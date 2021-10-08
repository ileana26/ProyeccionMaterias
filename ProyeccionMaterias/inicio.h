#ifndef INICIO_H
#define INICIO_H

#include <QMainWindow>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QMessageBox>
#include <QDebug>

namespace Ui {
class Inicio;
}

class Inicio : public QMainWindow
{
    Q_OBJECT

public:
    explicit Inicio(QWidget *parent = nullptr);
    ~Inicio();

private slots:
    void on_BotonIngresar_clicked();

private:
    Ui::Inicio *ui;
    QSqlDatabase  conexion;
};

#endif // INICIO_H
