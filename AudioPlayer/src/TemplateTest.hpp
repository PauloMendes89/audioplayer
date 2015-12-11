// Default empty project template
#ifndef TemplateTest_HPP_
#define TemplateTest_HPP_

#include <QObject>

namespace bb
{
    namespace cascades
    {
        class Application;
    }
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class TemplateTest: public QObject
{
    Q_OBJECT
public:
    TemplateTest(bb::cascades::Application *app);
    virtual ~TemplateTest(){}
    Q_INVOKABLE
    QString getCurrentPath(QString musicDirectory);
    QString getMusic(QString musicDirectory);
    QString getPicture(QString pictureDirectory);
    QString getMusicName(QString musicDirectory);
    QString copyBackground(QString fileDirectory);
    QString getValueFor(QString fileDirectory);
    void saveValueFor(const QString &objectName, const QString fileDirectory);
    void gyroReadingChanged();
    // Define a slot to receive the finished() signal.


};

#endif /* TemplateTest_HPP_ */
