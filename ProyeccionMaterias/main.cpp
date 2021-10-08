#include "inicio.h"
#include <QApplication>
#include <QSplashScreen>
#include <QTimer>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QSplashScreen * splash = new QSplashScreen;
    splash->setPixmap(QPixmap(":/logos/img/splashscreenV1.jpg"));
    splash->show();

    Inicio w;

    QTimer::singleShot(5000, splash, SLOT(close()));
    QTimer::singleShot(5000, &w, SLOT(show()));

    //w.show();

    return a.exec();
}
