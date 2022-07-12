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

#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>

#include "qhttpserver.hpp"
#include "qhttpserverconnection.hpp"
#include "qhttpserverrequest.hpp"
#include "qhttpserverresponse.hpp"

#include <map>

std::map<std::string, std::string> mimes;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    
    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);
    app->setApplicationName("conversejs.luigi311");

    mimes[".html"] = "text/html";
    mimes[".css"] = "text/css";
    mimes[".js"] = "application/javascript";
    mimes[".wasm"] = "application/wasm";
    mimes[".woff2"] = "application/font-woff2";
    mimes[".png"] = "image/png";
    mimes[".icon"] = "image/x-icon";

    qhttp::server::QHttpServer server;
    server.listen(QHostAddress::LocalHost, 19500,
        [](qhttp::server::QHttpRequest *req, qhttp::server::QHttpResponse *res)
    {
        QString docname = "./src/www" + (req->url().toString()==("/") ?("/index.html"):req->url().toString());
        if (!QFile(docname).exists()) {
            qDebug() << docname << "not found";
            docname = QString("./src/www/index.html");
        }
        QFile doc(docname);
        doc.open(QFile::ReadOnly);

        res->addHeader("Content-Length", QString::number(doc.size()).toUtf8());
        res->addHeader("Connection", "keep-alive");

        auto doc_str = docname.toStdString();
        auto doc_ext = doc_str.substr(doc_str.find_last_of('.'));
        if (mimes.count(doc_ext) > 0)
            res->addHeader("Content-Type", mimes[doc_ext].data());
        else
            res->addHeader("Content-Type", "application/octet-stream");
        res->setStatusCode(qhttp::TStatusCode::ESTATUS_OK);
        res->write(doc.readAll());
    });
    
    QQuickView *view = new QQuickView();
    view->setSource(QUrl("qrc:/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    return app->exec();
}
