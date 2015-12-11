// Default empty project template
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/pickers/FilePicker>
#include <bb/cascades/pickers/FilePickerMode>
#include <bb/cascades/pickers/FilePickerSortFlag>
#include <bb/cascades/pickers/FilePickerSortOrder>
#include <bb/cascades/pickers/FilePickerViewMode>
#include <bb/cascades/pickers/FileType>
#include <bb/multimedia/MediaPlayer>

#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>
#include "TemplateTest.hpp"

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{

  /*  qmlRegisterType<pickers::FilePicker>("bb.cascades.pickers", 1, 0, "FilePicker");
    qmlRegisterUncreatableType<pickers::FilePickerMode>("bb.cascades.pickers", 1, 0,
            "FilePickerMode", "");
    qmlRegisterUncreatableType<pickers::FilePickerSortFlag>("bb.cascades.pickers", 1, 0,
            "FilePickerSortFlag", "");
    qmlRegisterUncreatableType<pickers::FilePickerSortOrder>("bb.cascades.pickers", 1, 0,
            "FilePickerSortOrder", "");
    qmlRegisterUncreatableType<pickers::FileType>("bb.cascades.pickers", 1, 0, "FileType", "");
    qmlRegisterUncreatableType<pickers::FilePickerViewMode>("bb.cascades.pickers", 1, 0,
            "FilePickerViewMode", "");
*/
    // this is where the server is started etc
    Application app(argc, argv);

    // localization support
    QTranslator translator;
    QString locale_string = QLocale().name();
    QString filename = QString("Template_Test_%1").arg(locale_string);
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator(&translator);
    }

//    QCoreApplication::setOrganizationName("Example");
//      QCoreApplication::setApplicationName("TemplateTest");

    new TemplateTest(&app);


    // we complete the transaction started in the app constructor and start the client event loop here
    return Application::exec();
    // when loop is exited the Application deletes the scene which deletes all its children (per qt rules for children)
}
