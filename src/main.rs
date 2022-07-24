/*
* Copyright (C) 2022  luigi311
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 3.
*
* conversejs is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

extern crate cstr;
extern crate cpp;
#[macro_use]
extern crate qmetaobject;

use std::env;
use std::path::PathBuf;
use std::thread;

use gettextrs::{bindtextdomain, textdomain};
use qmetaobject::*;

mod qrc;

use actix_files as fs;
use actix_web::{App, HttpServer};

#[actix_web::main]
async fn webserver(port: u16) -> std::io::Result<()> {

    HttpServer::new(|| {
        App::new()
            .service(fs::Files::new("/", "www/")
                .show_files_listing()
                .use_last_modified(true)

            )
    })
    .bind(("127.0.0.1", port))?
    .run()
    .await

}

fn init_gettext() {
    let domain = "conversejs.luigi311";
    textdomain(domain).expect("Failed to set gettext domain");

    let app_dir = env::var("APP_DIR").expect("Failed to read the APP_DIR environment variable");

    let mut app_dir_path = PathBuf::from(app_dir);
    if !app_dir_path.is_absolute() {
        app_dir_path = PathBuf::from("/usr");
    }

    let path = app_dir_path.join("share/locale");

    bindtextdomain(domain, path.to_str().unwrap()).expect("Failed to bind gettext domain");
}

fn main() {

    thread::spawn(move || {
        let port = 9090;
        webserver(port).map_err(|err| println!("Webserver error: {:?}", err)).ok();
    });

    init_gettext();
    unsafe {
        cpp! { {
            #include <QtCore/QCoreApplication>
            #include <QtCore/QString>
        }}
        cpp! {[]{
            // Enable support for high resolution screens, breaks on some systems such as when using clickable desktop so disable when needed
            QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
            QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);

            // Enable opengl support massively speeding up rendering for the webview
            QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

            QCoreApplication::setApplicationName(QStringLiteral("conversejs.luigi311"));
        }}
    }
    
    // Set enviorment variables for chromium
    let chromium_flags = "--enable-gpu-compositing --enable-native-gpu-memory-buffers  --enable-zero-copy --enable-zero-copy-rasterization  \
        --enable-accelerated-video-decode --enable-accelerated-mjpeg-decode  \
        --enable-oop-rasterization --canvas-oop-rasterization \
        --turn-off-streaming-media-caching-on-battery --back-forward-cache --smooth-scrolling --enable-quic --enable-parallel-downloading";
    env::set_var("QTWEBENGINE_CHROMIUM_FLAGS", chromium_flags);

    QQuickStyle::set_style("Suru");
    qrc::load();
    let mut engine = QmlEngine::new();
    engine.load_file("qrc:/qml/Main.qml".into());
    engine.exec();
}
