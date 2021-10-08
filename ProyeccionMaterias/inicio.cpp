#include "inicio.h"
#include "ui_inicio.h"
#include "alumno.h"
#include "administrador.h"


Inicio::Inicio(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::Inicio)
{
    ui->setupUi(this);
    // CONEXIÓN CON LA BASE DE DATOS
    conexion = QSqlDatabase::addDatabase("QODBC");
    conexion.setPort(3306);
    conexion.setHostName("root");
    conexion.setPassword("");
    conexion.setDatabaseName("gestioniti");



conexion.close();
}

Inicio::~Inicio()
{
    delete ui;
}

void Inicio::on_BotonIngresar_clicked()
{
    conexion.open();
    // messagebox para hacer saber al usuario que debe cambiar su contraseña
    QMessageBox primeravez;
    primeravez.setText("Como tu primera vez que entras el sistema te recordamos que cambies tu contraseña"
                       "por el momento la contraseña predeterminada es tu matricula");
    QAbstractButton * Aceptar = primeravez.addButton(tr("ACEPTAR"),QMessageBox::AcceptRole);

    //inicio de sesión
    QString Matr;
    QString Contra;
    Matr=ui->Matricula->text();
    Contra=ui->Contrasegnia->text();
    if(Matr==""){
        //Error
        //qDebug()<<"Ingrese su usuario";
        QMessageBox::critical(this,"Error","Inserte su matricula","Aceptar");
        return;
        }
    if(Contra==""){
        //Error
        //qDebug()<<"Ingrese su contraseña";
        QMessageBox::critical(this,"Error","Inserte su contraseña (si es tu primera vez al entrar tu contraseña es tu matricula)","Aceptar");
        return;
        }
    //busca matricula en el sistema
    QSqlQuery login;
    login.prepare("SELECT Matricula, Contrasena FROM alumno WHERE Matricula='"+Matr+"' AND contrasena='"+Contra+"' ; ");
    login.exec();
    if(login.next()){
    //qDebug()<<"Contraseña del inicio: "<< Contra;
    //qDebug()<<"contraseña de la base de datos: " << login.value(1);
    if(login.value(1)==Contra){

        // query para saber si es la prera vez que entras
        if(Contra == Matr){
         QMessageBox::warning(this,"Aviso","Como tu primera vez que entras el sistema te recordamos que cambies tu contraseña por el momento la contraseña predeterminada es tu matricula","Aceptar");
        }

        // Acceso momentaneo para entrar a la ventana de usuario
        alumno ac(Matr,this);
        ac.setWindowTitle("Alumno");
        this->hide();
        ac.exec();
        this->show();
}
                    }
    // query para saber si el que está ingresando es el administador

    QSqlQuery loginAdmi;
    loginAdmi.prepare("Select idadministrador,contrasena from administrador where idadministrador='"+Matr+"' AND contrasena='"+Contra+"'; ");
    loginAdmi.exec();
    if(loginAdmi.next() && loginAdmi.value(1)==Contra)
    {
        administrador admi(Matr,this);
        admi.setWindowTitle("Administrador");
        admi.exec();
    }
    else{
        //qDebug()<<"No se pudo encontrar el usuario";
        //QMessageBox::critical(this,"Error","Usuario no encontrado","Aceptar");
        }



}
