#ifndef __ADDRESSBOOK_H_
#define __ADDRESSBOOK_H_

#include <QWidget>
#include <QMap>

class QLineEdit;
class QTextEdit;
class QPushButton;

class Address:public QWidget
{
    Q_OBJECT

public:
    Address(QWidget* parent = 0);
public slots:
    void addContact();
    void submitContact();
    void cancel();

private:
    QPushButton* addButton;
    QPushButton* submitButton;
    QPushButton* cancelButton;
    QLineEdit* nameLine;
    QTextEdit* addressText;

    QString oldName;
    QString oldAddress;

    QMap<QString, QString> contacts;
};

#endif
