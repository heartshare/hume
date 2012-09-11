#include <QApplication>
#include "addressbook.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    Address *addressBook = new Address;

    addressBook->show();

    return app.exec();
}
