// Default empty project template
#include "TemplateTest.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <unistd.h>
#include <bb/cascades/Button>
#include <bb/system/MenuManager>
#include <bb/cascades/Container>

#include <QDir>
#include <QFile>
#include <QString>
#include <bb/cascades/Image>
//#include <bb/device/DisplayInfo>

using namespace bb::cascades;
//using namespace bb::device;

TemplateTest::TemplateTest(bb::cascades::Application *app) :
        QObject(app)
{



    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // Retrieve the path to the app's working directory
    QString workingDir = QDir::currentPath();

    // Build the path, add it as a context property, and expose
    // it to QML
    /*QDeclarativePropertyMap* dirPaths = new QDeclarativePropertyMap;
     dirPaths->insert("camera", QVariant(QString(
     "file://" + workingDir + "/shared/camera/")));*/
    QDeclarativePropertyMap* dirPaths = new QDeclarativePropertyMap;
    dirPaths->insert("music", QVariant(QString("file://" + workingDir + "/shared/music/")));
    qml->setContextProperty("dirPaths", dirPaths);

    QDeclarativePropertyMap* picDirPaths = new QDeclarativePropertyMap;
    picDirPaths->insert("picture", QVariant(QString("file://" + workingDir + "/shared/photos/")));
    qml->setContextProperty("picDirPaths", picDirPaths);


    //qml->setContextProperty("_app", this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    qml->setContextProperty("root", this);
    // set created root object as a scene
    app->setScene(root);
    char* getcwd(char* buffer, size_t size);

//    DisplayInfo display;
//    int width = display.pixelSize().width();
//    int height = display.pixelSize().height();
//
//    QDeclarativePropertyMap* displayProperties = new QDeclarativePropertyMap;
//    displayProperties->insert("width", QVariant(width));
//    displayProperties->insert("height", QVariant(height));
//
//    qml->setContextProperty("DisplayInfo", displayProperties);

//    QString myFile = "mybackground.jpg";
//    bool ok = QFile::copy( "app/native/assets/" + myFile, "data/" + myFile);
//    qDebug() << "Copy of JPG file success=" << ok;

    // Copy a database from the assets directory to the shared/misc directory
//    QString myDB = "mydata.db";
//    bool ok = QFile::copy( "app/native/assets/" + myDB, "shared/misc/" + myDB);
//    qDebug() << "Copy of database file success=" << ok;

    // Copy an ICS file from the assets directory to the shared directory
    // using currentPath() to retrieve the application working directory
//    QString newPath = QDir::currentPath() + "/app/native/assets/images";
//    QString filePath= "/accounts/1000/shared/photos/";
//    qDebug() << "Result of copy:" << QFile::copy(filePath, newPath);

}

QString TemplateTest::getCurrentPath(QString fileDirectory)
{
    //return QDir::currentPath();
    return QString(QDir::currentPath() + fileDirectory.remove(0, 14));
}


//QString TemplateTest::getValueFor(QString fileDirectory)
//{
//
//    QSettings settings;
//    // If no value has been saved, return the default value.
//    if (settings.value(fileDirectory).isNull()) {
//        return 0;
//    }
//
//    // Otherwise, return the value stored in the settings object.
//    return settings.value(fileDirectory);
//}
//
//void TemplateTest::saveValueFor(QString fileDirectory)
//{
//    // A new value is saved to the application settings object.
//    QSettings settings;
//    settings.setValue(QVariant(fileDirectory));
//}


//QString TemplateTest::getMusic(QString musicDirectory)
//{
//    //return QString("file://" + QDir::currentPath() + musicDirectory.remove(0, 14));
//    // int LineCount = musicDirectory.length();
//    //return QString(musicDirectory.remove(0, 28));
//    return QString(QDir::currentPath() + musicDirectory.remove(0, 14));
//}

//QString TemplateTest::getMusicName(QString musicDirectory)
//{
//    return QString(QDir::currentPath() + musicDirectory.remove(0, 14));
//}

//QString TemplateTest::getPicture(QString pictureDirectory)
//{
//    return QString(QDir::currentPath() + pictureDirectory.remove(0, 14));
//}

