qrc!(qml_resources,
    "/" {
        "qml/Main.qml",
        "qml/ImportPage.qml"
    },
);

pub fn load() {
    qml_resources();
}
