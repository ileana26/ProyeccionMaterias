#include "administrador.h"
#include "ui_administrador.h"


administrador::administrador(QString admi,QWidget *parent) :
    QDialog(parent),
    ui(new Ui::administrador)
{
    ui->setupUi(this);
    Id=admi;
    //conexión con la base de datos
    conexion = QSqlDatabase::addDatabase("QODBC");
    conexion.setDatabaseName("gestioniti");

    if(conexion.open())
        qDebug()<< "Conexión EXITOSA Administrador";
    else
        qDebug()<< "Conexión FALLIDA Administrador";

    //MOSTRAR EL MAPA GRAFICO EN LA VENTANA
    Mapa = new QGraphicsScene(0,0, 1245, 882);
    Img= Mapa->addPixmap(QPixmap(":logos/img/Mapa.jpg"));

    ui->MapaITI->setScene(Mapa);
    ui->MapaITI->show();
    ui->horizontalSlider->valueChanged(ui->horizontalSlider->value());

}

administrador::~administrador()
{
    delete ui;
}

void administrador::on_actionZoominOut_triggered()
{
    Img->setScale(ui->horizontalSlider->value()/12.0);
}

void administrador::on_horizontalSlider_valueChanged(int value)
{
    ui->actionZoominOut->trigger();
}

void administrador::on_ButtonBuscar_clicked()
{
    conexion.open();

        QMessageBox msg;
        bool busqueda=0;
        QString matri;
        matri=ui->matricula->text();

        if(matri==""){
            //Error
            QMessageBox::critical(this,"Error","Inserte su matricula","Aceptar");
            return;
        }

        QStringList titulos;
        ui->tabla_alumno->setColumnCount(4);
        titulos<< "Id Materia" << "Nombre" << "Estado" << "Creditos";
        ui->tabla_alumno->setHorizontalHeaderLabels(titulos);

        //buscar matricula del alumno en la base de datos
        QSqlQuery buscar;
        QSqlQuery control;
        QString idAl, nombreCompleto, idAlum, matricu;
        buscar.prepare("SELECT idAlumno, Matricula, ApellidoPaterno, ApellidoMaterno, Nombre FROM alumno WHERE Matricula='"+matri+"'; ");
        control.prepare("select m.idmaterias, m.nombre, c.estado, m.creditos, a.idAlumno from alumno as a inner join control_materias as c on a.idAlumno=c.idAlumno inner join materias as m on m.idmaterias=c.idmaterias where c.idAlumno = :idA;");
        if(buscar.exec()){
            while (buscar.next()) {
                nombreCompleto = buscar.value(2).toString()+ " " +buscar.value(3).toString()+ " " + buscar.value(4).toString();
                idAlum = buscar.value(0).toString();
                idAl = buscar.value(0).toString();
                matricu = buscar.value(1).toString();

                ui->labelnombre->setText(nombreCompleto);
                ui->labelmatricula->setText(matricu);
                ui->labelID->setText(idAlum);
            }
            control.bindValue(":idA", idAl);
            if(control.exec()){
                while(control.next()){
                    QString idmateria = control.value(0).toString();
                    QString nombremateria = control.value(1).toString();
                    QString status = control.value(2).toString();
                    QString creditos = control.value(3).toString();

                    //tabla alumno
                    ui->tabla_alumno->insertRow(ui->tabla_alumno->rowCount());
                    ui->tabla_alumno->setItem(ui->tabla_alumno->rowCount()-1,0,new QTableWidgetItem(idmateria));
                    ui->tabla_alumno->setItem(ui->tabla_alumno->rowCount()-1,1,new QTableWidgetItem(nombremateria));
                    ui->tabla_alumno->setItem(ui->tabla_alumno->rowCount()-1,2,new QTableWidgetItem(status));
                    ui->tabla_alumno->setItem(ui->tabla_alumno->rowCount()-1,3,new QTableWidgetItem(creditos));
                }
                busqueda=1;
            }
        }


        if(busqueda==0)
        {
                   msg.setWindowTitle("Error busqueda");
                   msg.setIcon(QMessageBox::Critical);
                   msg.setText("Matricula no encontrada");
                   msg.addButton(tr("Aceptar"),QMessageBox::YesRole);
                   msg.exec();
        }

        //conexion.close();
}



void administrador::on_buscar_clicked()
{
     ui->stackedWidget->setCurrentIndex(2);
}

void administrador::on_mapagrafico_clicked()
{
     ui->stackedWidget->setCurrentIndex(0);
}

void administrador::on_btnSalir_clicked()
{
    this->close();
}


