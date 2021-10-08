#include "alumno.h"
#include "ui_alumno.h"
#include "QPrintDialog"
#include <QPrinter>
#include <QPdfWriter>
#include <QTextDocument>
#include <QDesktopServices>

alumno::alumno(QString Matricula,QWidget *parent) :
    QDialog(parent),
    ui(new Ui::alumno)
{
    ui->setupUi(this);
    matricula=Matricula;
    //conexión con la base de datos
    conexion = QSqlDatabase::addDatabase("QODBC");
    conexion.setDatabaseName("gestioniti");

    QBrush CB(QColor(221,254,175));
    QBrush Mod(QColor(254,170,247));
    QBrush Tec(QColor(206,188,233));
    QBrush FGU(QColor(254,255,153));

    // si es la primera vez que entra al sistema
    QSqlQuery PrimeraVez;
    PrimeraVez.prepare("Select Matricula, contrasena from Alumno where matricula ='"+Matricula+"'");
    PrimeraVez.exec();
    if(PrimeraVez.next() && PrimeraVez.value(0) == PrimeraVez.value(1)){
        ui->stackedWidget->setCurrentIndex(0);
    }
    else{
        ui->stackedWidget->setCurrentIndex(1);
    }
    Mapa = new QGraphicsScene(0,0, 1245, 882);
    Img= Mapa->addPixmap(QPixmap(":logos/img/Mapa.jpg"));

    ui->MapaITI->setScene(Mapa);
    ui->MapaITI->show();
    ui->horizontalSlider->valueChanged(ui->horizontalSlider->value());

    //query para saber id de alumno y su periodo actual
    QString idAlumno;
    QString PeriodoAc;
    QString nombre;
    QString apeP;
    QString apeM;
    QSqlQuery idalum;

    idalum.prepare("Select idAlumno,PeriodoAct,nombre,ApellidoPaterno,ApellidoMaterno from Alumno where Matricula = '"+Matricula+"'");
    idalum.exec();
    if(idalum.next()){
        idAlumno=idalum.value(0).toString();
        PeriodoAc=idalum.value(1).toString();
        nombre=idalum.value(2).toString();
        apeP=idalum.value(3).toString();
        apeM=idalum.value(4).toString();
    }
    //asignar valores al inicio del usuario
    ui->labelID->setText(idAlumno);
    ui->labelnombre->setText(nombre+" "+apeP+" "+apeM );
    ui->labelmatricula->setText(Matricula);


    //query para saber las materias atrasadas
    QStringList titulos;
    ui->tablaMatAtrasada->setColumnCount(5);
    titulos<< "Id Materia" << "Nombre" <<"Periodo" << "Estado" << "Periodo actual";
    ui->tablaMatAtrasada->setHorizontalHeaderLabels(titulos);

    QSqlQuery MatAtra;
    MatAtra.prepare("select m.idmaterias, m.nombre,m.periodo, c.estado,a.periodoAct from alumno as a inner join control_materias as c on a.idAlumno=c.idAlumno inner join materias as m on m.idmaterias=c.idmaterias where c.idAlumno = '"+idAlumno+"' and m.periodo<='"+PeriodoAc+"';");
    MatAtra.exec();
    while(MatAtra.next()){
        if(MatAtra.value(3).toString()!="Finalizado" && MatAtra.value(3).toString()!="En curso" ){
            QString idmat=MatAtra.value(0).toString();
            QString nombremat=MatAtra.value(1).toString();
            QString periodo=MatAtra.value(2).toString();
            QString estado=MatAtra.value(3).toString();
            QString periodoAct=MatAtra.value(4).toString();

            ui->tablaMatAtrasada->insertRow(ui->tablaMatAtrasada->rowCount());

            ui->tablaMatAtrasada->setItem(ui->tablaMatAtrasada->rowCount()-1,0,new QTableWidgetItem(idmat));

            ui->tablaMatAtrasada->setItem(ui->tablaMatAtrasada->rowCount()-1,1,new QTableWidgetItem(nombremat));
            ui->tablaMatAtrasada->setItem(ui->tablaMatAtrasada->rowCount()-1,2,new QTableWidgetItem(periodo));
            ui->tablaMatAtrasada->setItem(ui->tablaMatAtrasada->rowCount()-1,3,new QTableWidgetItem(estado));
            ui->tablaMatAtrasada->setItem(ui->tablaMatAtrasada->rowCount()-1,4,new QTableWidgetItem(periodoAct));
        }
    }
// ///////////////////////////// Materias en curso
    QStringList titulos2;
    ui->tabla_materias->setColumnCount(4);
    titulos2<< "Id Materia" << "Nombre" << "Estado" << "Creditos";
    ui->tabla_materias->setHorizontalHeaderLabels(titulos2);

    QSqlQuery vermaterias;
    QSqlQuery alum;
    QString nombrealum;
    alum.prepare("SELECT Matricula, ApellidoPaterno, ApellidoMaterno, Nombre FROM alumno WHERE Matricula='"+matricula+"'; ");
    vermaterias.prepare("select m.idmaterias, m.nombre, c.estado, m.creditos, a.idAlumno, a.matricula from alumno as a inner join control_materias as c on a.idAlumno=c.idAlumno inner join materias as m on m.idmaterias=c.idmaterias where a.matricula='"+matricula+"' and c.estado='En curso'; ");

    if(alum.exec()){
        while (alum.next()) {
            nombrealum = alum.value(1).toString()+ " " +alum.value(2).toString()+ " " + alum.value(3).toString();
             ui->nombrealumno->setText(nombrealum);
        }

        if(vermaterias.exec()){
            while(vermaterias.next()){
                QString idmateria = vermaterias.value(0).toString();
                QString nombremateria = vermaterias.value(1).toString();
                QString status = vermaterias.value(2).toString();
                QString creditos = vermaterias.value(3).toString();

                ui->tabla_materias->insertRow(ui->tabla_materias->rowCount());
                ui->tabla_materias->setItem(ui->tabla_materias->rowCount()-1,0,new QTableWidgetItem(idmateria));
                ui->tabla_materias->setItem(ui->tabla_materias->rowCount()-1,1,new QTableWidgetItem(nombremateria));
                ui->tabla_materias->setItem(ui->tabla_materias->rowCount()-1,2,new QTableWidgetItem(status));
                ui->tabla_materias->setItem(ui->tabla_materias->rowCount()-1,3,new QTableWidgetItem(creditos));

            }
        }
    }

// ///////////////////////////// Proyección de materias del siguiente semestre
    conexion.open();

    QMessageBox msg;
    bool busqueda=0;

    QStringList titulos3;
    ui->tabla_proyeccion->setColumnCount(4);
    titulos3<< "Id Materia" << "Nombre" << "Creditos" << "Semestre";
    ui->tabla_proyeccion->setHorizontalHeaderLabels(titulos3);

    //buscar matricula del alumno en la base de datos
    QSqlQuery proyeccion;
    QSqlQuery buscaralu;
    QString semestre, semestreac;
    buscaralu.prepare("SELECT Matricula, PeriodoAct FROM alumno WHERE Matricula='"+matricula+"'; ");
    proyeccion.prepare("select idmaterias,nombre,creditos,semestre from materias where semestre= :semestreac+1;");

    if(buscaralu.exec()){
        while (buscaralu.next()) {
            semestre = buscaralu.value(1).toString();
            semestreac= buscaralu.value(1).toString();
        }

        proyeccion.bindValue(":semestreac", semestre);

        if(proyeccion.exec()){
            while(proyeccion.next()){
                QString idmateria = proyeccion.value(0).toString();
                QString nombremateria = proyeccion.value(1).toString();
                QString creditos = proyeccion.value(2).toString();
                QString semestre = proyeccion.value(3).toString();

                //tabla alumno
                ui->tabla_proyeccion->insertRow(ui->tabla_proyeccion->rowCount());
                ui->tabla_proyeccion->setItem(ui->tabla_proyeccion->rowCount()-1,0,new QTableWidgetItem(idmateria));
                ui->tabla_proyeccion->setItem(ui->tabla_proyeccion->rowCount()-1,1,new QTableWidgetItem(nombremateria));
                ui->tabla_proyeccion->setItem(ui->tabla_proyeccion->rowCount()-1,2,new QTableWidgetItem(creditos));
                ui->tabla_proyeccion->setItem(ui->tabla_proyeccion->rowCount()-1,3,new QTableWidgetItem(semestre));
            }
            busqueda=1;
        }
    }
    if(busqueda==0){

        msg.setWindowTitle("Error busqueda");
        msg.setIcon(QMessageBox::Critical);
        msg.setText("Matricula no encontrada");
        msg.addButton(tr("Aceptar"),QMessageBox::YesRole);
        msg.exec();
    }
    //proyecccíon real
    QSqlQuery materiasfal;
    QSqlQuery materiasPen;

    ui->proyeccion->setSelectionMode(QAbstractItemView::SingleSelection);
    ui->proyeccion->setDragEnabled(true);
    ui->proyeccion->setDragDropMode(QAbstractItemView::DragDrop);
    ui->proyeccion->viewport()->setAcceptDrops(false);
    ui->proyeccion->setDropIndicatorShown(true);



    ui->seleccion->setSelectionMode(QAbstractItemView::SingleSelection);
    ui->seleccion->setDragEnabled(true);
    ui->seleccion->setDragDropMode(QAbstractItemView::DragDrop);
    ui->seleccion->viewport()->setAcceptDrops(true);
    ui->seleccion->setDropIndicatorShown(true);





    materiasfal.prepare("select A.nombre, m.idmaterias,m.nombre,cm.estado,m.periodo,p.prerequisito, m.Area FROM alumno as a inner join control_materias as cm on a.idalumno=cm.idalumno inner join materias as m on m.idmaterias=cm.idmaterias inner join prerequisitos as p on m.idmaterias=p.idmaterias where a.idalumno='"+idAlumno+"'  and cm.estado<>'Finalizado' and cm.estado<>'En curso'");

    QString idmat;
    materiasPen.prepare("Select m.nombre ,cm.estado FROM alumno as a inner join control_materias as cm on a.idalumno=cm.idalumno inner join materias as m on cm.idmaterias=m.idmaterias where a.idAlumno='"+idAlumno+"' and m.idmaterias=:idmat");

    materiasfal.exec();
    materiasPen.exec();
    while(materiasfal.next()){
        QString materianombre=materiasfal.value(2).toString();
        QString idmaterias=materiasfal.value(1).toString();
        QString materiaestado=materiasfal.value(3).toString();
        QString materiaperiodo=materiasfal.value(4).toString();
        QString materiaperequisito=materiasfal.value(5).toString();
        QString area = materiasfal.value(6).toString();
        qDebug() << "Area: " << area;
        int codArea;
        if(area == "Ciencias basicas"){
            codArea = 1;
        }
        if (area == "Modelado de sistemas") {
            codArea = 2;
        }
        if (area == "Tecnologia") {
            codArea = 3;
        }
        if (area == "Formacion general universitaria") {
            codArea = 4;
        }


        materiasPen.bindValue(":idmat",materiaperequisito);
        materiasPen.exec();
        if(materiasPen.next() && (materiasPen.value(1)=="Finalizado" ||materiasPen.value(1)=="En curso")){
            QString bloque = "Nombre: " + materianombre + "\nId: " + idmaterias + "\nPeriodo: " + materiaperiodo;
            switch(codArea){
                case 1:{
                    QListWidgetItem * matCB = new QListWidgetItem;
                    matCB->setText(bloque);
                    matCB->setBackground(CB);
                    ui->proyeccion->addItem(matCB);
                    break;
                }
                case 2:{
                    QListWidgetItem * matMod = new QListWidgetItem;
                    matMod->setText(bloque);
                    matMod->setBackground(Mod);
                    ui->proyeccion->addItem(matMod);
                    break;
                }
                case 3:{
                    QListWidgetItem * matTec = new QListWidgetItem;
                    matTec->setText(bloque);
                    matTec->setBackground(Tec);
                    ui->proyeccion->addItem(matTec);
                    break;
                }
                case 4:{
                    QListWidgetItem * matFgu = new QListWidgetItem;
                    matFgu->setText(bloque);
                    matFgu->setBackground(FGU);
                    ui->proyeccion->addItem(matFgu);
                    break;
                }
            }
        }
    }

    QStringList titulosmateria;
    ui->tabla_busqueda->setColumnCount(4);
    titulosmateria<< "Id Materia" << "Nombre"<<"Creditos"<<"Prerrequisitos";
    ui->tabla_busqueda->setHorizontalHeaderLabels(titulosmateria);
}


alumno::~alumno()
{
    delete ui;
}

void alumno::on_Aceptar_clicked()
{
    if(ui->LineEditNuevaContrasea->text() == ui->LineEditConfirmarContrasenia->text()){
     QSqlQuery cambiar,id;
      // query para cambiar de contraseña para un usuario nuevo
     id.prepare("Select idAlumno from alumno where Matricula='"+matricula+"';");
     id.exec();
     id.next();

     QString idAlumno =id.value(0).toString();
     QString nuevaContra=ui->LineEditNuevaContrasea->text();


     cambiar.prepare("UPDATE alumno set contrasena='"+ui->LineEditNuevaContrasea->text()+"' where idAlumno= '"+idAlumno+"';");
     if(cambiar.exec()){
         QMessageBox mensaje;
         mensaje.setText("Contraseña cambiada correctamente");
         mensaje.setWindowTitle("Aviso");
         mensaje.setIcon(QMessageBox::Information);
         QAbstractButton * btnAcp = mensaje.addButton("Aceptar", QMessageBox::AcceptRole);

         mensaje.exec();
         if(mensaje.clickedButton() == btnAcp){
            ui->stackedWidget->setCurrentIndex(1);
         }
     }
    }
    else
     QMessageBox::warning(this,"Error","No coinciden las contraseñas","Aceptar");
}

void alumno::on_checkBox_stateChanged(int arg1)
{
    ui->LineEditNuevaContrasea->setEchoMode(ui->checkBox->checkState() == Qt::Checked ? QLineEdit::Normal : QLineEdit::Password);
    ui->LineEditConfirmarContrasenia->setEchoMode(ui->checkBox->checkState() == Qt::Checked ? QLineEdit::Normal : QLineEdit::Password);
}

void alumno::on_btnCambiar_clicked()
{
    ui->stackedWidget->setCurrentIndex(0);
}

void alumno::on_btnPerfil_clicked()
{
    ui->stackedWidget->setCurrentIndex(1);
}

void alumno::on_pushButton_4_clicked()
{
    ui->stackedWidget->setCurrentIndex(2);
}

void alumno::on_pushButton_6_clicked()
{
    ui->stkMaterias->setCurrentIndex(1);
}

void alumno::on_actionZoominOut_triggered()
{
    Img->setScale(ui->horizontalSlider->value()/12.0);
}

void alumno::on_horizontalSlider_valueChanged(int value)
{
    ui->actionZoominOut->trigger();
}

void alumno::on_btn_materias_clicked()
{
    ui->stackedWidget->setCurrentIndex(4);
}

void alumno::on_Salir_clicked()
{
    this->close();
}

void alumno::on_materias_clicked()
{
    ui->stkMaterias->setCurrentIndex(0);
}

void alumno::on_pushButton_7_clicked()
{
    ui->stackedWidget->setCurrentIndex(5);
}

void alumno::on_pushButton_8_clicked()
{
    ui->stkProyeccion->setCurrentIndex(0);
}

void alumno::on_btnMaterias_clicked()
{
    ui->stackedWidget->setCurrentIndex(3);
}

void alumno::on_pushButton_9_clicked()
{
    ui->stkProyeccion->setCurrentIndex(1);
}

void alumno::on_seleccion_currentRowChanged(int currentRow)
{
    /*qDebug() << "Entrada a signal";
    if(ui->seleccion->count() > 6){
        qDebug() << ui->seleccion->count();
        ui->seleccion->setAcceptDrops(false);
    }*/
}

void alumno::on_proyeccion_itemSelectionChanged()
{
    qDebug() << ui->seleccion->count();
    if(ui->seleccion->count() == 6){
        ui->seleccion->setAcceptDrops(false);
        QMessageBox::warning(this, "Error", "Solo se pueden agragar 6 materias a la proyección", "Aceptar");
    }
}

void alumno::on_pushButton_10_clicked()
{
    ui->stackedWidget->setCurrentIndex(7);
}


void alumno::on_nombremateria_textChanged(const QString &buscar)
{
    conexion.open();
    //buscar materia en base de datos
    QSqlQuery buscarmateria;
    buscarmateria.prepare("select idmaterias, Nombre, creditos from materias where Nombre LIKE '%"+buscar+"%';");
    if(buscarmateria.exec()){
       ui->tabla_busqueda->setRowCount(0);
       while (buscarmateria.next()) {
           QString idmateria = buscarmateria.value(0).toString();
           QString nombremateria = buscarmateria.value(1).toString();
           QString creditosmateria = buscarmateria.value(2).toString();
           //Prerrequisitos
           QSqlQuery prerrequisito;
           prerrequisito.prepare("SELECT Nombre FROM materias WHERE idmaterias=(SELECT preRequisito FROM prerequisitos WHERE idmaterias='"+idmateria+"')");
           prerrequisito.exec();
           prerrequisito.first();
           QString materia_pre=prerrequisito.value(0).toString();
           if(materia_pre=="")
           {
               materia_pre="Sin prerrequisitos.";
           }

           //tabla materias
           ui->tabla_busqueda->insertRow(ui->tabla_busqueda->rowCount());
           ui->tabla_busqueda->setItem(ui->tabla_busqueda->rowCount()-1,0,new QTableWidgetItem(idmateria));
           ui->tabla_busqueda->setItem(ui->tabla_busqueda->rowCount()-1,1,new QTableWidgetItem(nombremateria));
           ui->tabla_busqueda->setItem(ui->tabla_busqueda->rowCount()-1,2,new QTableWidgetItem(creditosmateria));
           ui->tabla_busqueda->setItem(ui->tabla_busqueda->rowCount()-1,3,new QTableWidgetItem(materia_pre));
       }
    }
}

void alumno::on_Imprimir_clicked()
{
    QSqlQuery alumno;
        alumno.prepare("Select Nombre,ApellidoPaterno,ApellidoMaterno,Matricula from alumno where matricula='"+matricula+"'");
        alumno.exec();
        alumno.next();

        QString html;
        html +="<img class='imageCenter' src=':logos/img/600px-Escudobuappositivo2.png' alt='Ed' width='130' height='130'/><strong>"
               "<h1 style='text-align: center';>Proyección de materias</h1>"
               "<hr />"
               "<h3 style='text-align: center';>La Benemerita Universidad Autonoma de Puebla expide la siguiente proyección de materias al  Alumno: <br><h2>"+alumno.value(1).toString()+" "+alumno.value(2).toString()+" "+alumno.value(0).toString()+"</h2><br> Para gozar del conocomiento de las siguientes materias</h3>"
               "<p></p>"
               "<hr />";
        // aqui va a ir el codigo para ver las materias que metió
        QString info;

        int count = ui->seleccion->count();
        if (count!=0)
        {


        for(int i=0;i<count;i++)
        {
           QListWidgetItem *item=ui->seleccion->item(i);
           info = item->text();
           html +="<br><h3>'"+info+"'</h3><br><hr />";
        }

        html +="<p style='text-align: center;'><strong><h1>Atentamente</h1></strong></p>"
        "<p style='text-align: center;'><strong>Facultad de ciencias de la computación</strong></p>"
        "<p style='text-align: center;'><img src=':logos/img/firma.png' alt="" width='110' height='100' /></p>";
        QTextDocument document;
        document.setHtml(html);

        QPrinter printer(QPrinter::PrinterResolution);
        printer.setOutputFormat(QPrinter::PdfFormat);
        printer.setPaperSize(QPrinter::A4);
        printer.setOutputFileName("/tmp/Proyeccion.pdf");
        printer.setPageMargins(QMarginsF(15, 15, 15, 15));

        document.print(&printer);
        QDesktopServices::openUrl(QUrl::fromLocalFile("/tmp/Proyeccion.pdf"));
        }
        else
        {
            QMessageBox::warning(this,"Error","Para poder imprimir tu proyeccion debes añadir tus matiras a cursar","Aceptar");
        }
}
