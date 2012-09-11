#include <QtGui>
#include "addressbook.h"

Address::Address(QWidget* parent):QWidget(parent)
{
    QLabel* nameLabel = new QLabel("Name: ");

    nameLine = new QLineEdit;
    nameLine->setReadOnly(true);

    QLabel* addressLabel = new QLabel("Address: ");

    addressText = new QTextEdit;
    addressText->setReadOnly(true);

    addButton = new QPushButton("&add");
    addButton->show();

    submitButton = new QPushButton("&Submit");
    submitButton->hide();

    cancelButton = new QPushButton("&Cancel");
    cancelButton->hide();


    connect(addButton, SINGAL(clicked()), this, SLOT(addContact()));
    connect(submitButton, SIGNAL(clicked()), this, SLOT(submitContact()));
    connect(cancelButton, SINGAL(clicked()), this, SLOT(cancel()));

    QVBoxLayout* btnLayout = new QVBoxLayout();

    btnLayout->addWidget(addButton);
    btnLayout->addWidget(submitButton); 
    btnLayout->addWidget(cancelButton);
    btnLayout->addStretch();

    QGridLayout* mainLayout = new QGridLayout();

    mainLayout->addWidget(nameLabel, 0, 0);
    mainLayout->addWidget(nameLine, 0, 1);
    mainLayout->addWidget(addressLabel, 1, 0, Qt::AlignTop);
    mainLayout->addWidget(addressText, 1, 1);
    mainLayout->addLayout(btnLayout, 1, 2);

    setLayout(mainLayout);
    setWindowTitle("Simple Address Book");
}


void Address::addContact()
{
    oldName = nameLine->text();
    oldAddress = addressText->toPlainText();

    nameLine->clear();

    addressText->clear();

    // read & write
    nameLine->setReadOnly(false);
    addressText->setReadOnly(false);

    addButton->setEnabled(false);
    submitButton->show();
    cancelButton->show();
}

void Address::submitContact()
{
    QString name = nameLine->text();

    QString address = addressText->toPlainText();

    if(name == "" || address == "") {
        QMessageBox::information(this, "Empty Field", "Please Enter a name or address!");
        return;
    }

    if(!contacts.contains(name)) {
        contains.insert(name, address);
        QMessageBox::information(this, "Add Successful", "Ok!");
     } else {
        QMessageBox::information(this, "Add Unsuccessful", "Sorry!");
        return;
    }

    nameLine->setReadOnly(true);
    addressText->setReadOnly(true);

    addButton->setEnabled(true);
    submitButton->hide();
    submitButton->hide();
}

void Address::cancel()
{
    nameLine->setText(oldName);
    nameLine->setReadOnly(true);

    addressText->setText(oldAddress);
    addressText->setReadOnly(true);

    addButton->setEnabled(true);
    submitButton->hide();
    submitButton->hide();
}


