#ifndef ALUMNO_H
#define ALUMNO_H

#include <QDialog>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QtDebug>
#include <QMessageBox>
#include <QGraphicsPixmapItem>
#include <QGraphicsScene>

namespace Ui {
class alumno;
}

class alumno : public QDialog
{
    Q_OBJECT

public:
    explicit alumno(QString, QWidget *parent = nullptr);
    ~alumno();

private slots:
    void on_Aceptar_clicked();

    void on_checkBox_stateChanged(int arg1);

    void on_btnCambiar_clicked();

    void on_btnPerfil_clicked();

    void on_pushButton_4_clicked();

    void on_pushButton_6_clicked();
    void on_actionZoominOut_triggered();

    void on_horizontalSlider_valueChanged(int value);
    void on_btn_materias_clicked();

    void on_Salir_clicked();

    void on_materias_clicked();

    void on_pushButton_7_clicked();

    void on_pushButton_8_clicked();

    void on_btnMaterias_clicked();

    void on_pushButton_9_clicked();

    void on_seleccion_currentRowChanged(int currentRow);

    void on_proyeccion_itemSelectionChanged();

    void on_pushButton_10_clicked();

    void on_nombremateria_textChanged(const QString &arg1);

    void on_Imprimir_clicked();

private:
    Ui::alumno *ui;
    QSqlDatabase conexion;
    QString matricula;
    QGraphicsScene *Mapa;
    QGraphicsPixmapItem *Img;
};

#endif // ALUMNO_H
