#ifndef ADMINISTRADOR_H
#define ADMINISTRADOR_H

#include <QDialog>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QGraphicsPixmapItem>
#include <QGraphicsScene>
#include <QMessageBox>

namespace Ui {
class administrador;
}

class administrador : public QDialog
{
    Q_OBJECT

public:
    explicit administrador(QString ,QWidget *parent = nullptr);
    ~administrador();

private slots:
    void on_actionZoominOut_triggered();

    void on_horizontalSlider_valueChanged(int value);

    void on_ButtonBuscar_clicked();

    void on_buscar_clicked();

    void on_mapagrafico_clicked();

    void on_btnSalir_clicked();

private:
    Ui::administrador *ui;
    QSqlDatabase conexion;
    QString Id;
    QGraphicsScene *Mapa;
    QGraphicsPixmapItem *Img;
};

#endif // ADMINISTRADOR_H
