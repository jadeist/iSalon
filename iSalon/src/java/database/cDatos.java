/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import servlets.AgregarUsuario;

/**
 *
 * @author Ger
 */
public class cDatos {
    
    private boolean SQLite;
    private boolean preparedReady;
    private String usrBD;
    private String passBD;
    private String urlBD;
    private String driverClassName;
    private String SQLiteDbPath;
    private Connection conn = null;
    private Statement estancia;
    private PreparedStatement prepared;
 
    public cDatos(String usuarioBD, String passwordBD, String url, String driverClassName, boolean SQLite, String SQLiteDbPath) {
        this.usrBD = usuarioBD;
        this.passBD = passwordBD;
        this.urlBD = url;
        this.driverClassName = driverClassName;
        this.SQLite = SQLite;
        this.SQLiteDbPath = SQLiteDbPath;
    }
    public cDatos() {
        //poner los datos apropiados
        this.usrBD = "root";
        this.passBD = "n0m3l0";
        this.urlBD = "jdbc:mysql://127.0.0.1:3306/iSalon";
        
        // com.mysql.jdbc.Driver
        // org.sqlite.JDBC
        this.driverClassName = "com.mysql.jdbc.Driver";
        this.SQLite = false;
        this.preparedReady = false;
        this.SQLiteDbPath = "E:\\Escuela\\Programación\\Lib\\DB\\SmaF.db";
    }
    
    //metodos para establecer los valores de conexion a la BD
    public void setUsuarioBD(String usuario) throws SQLException {
        this.usrBD = usuario;
    }
    public void setPassBD(String pass) {
        this.passBD = pass;
    } 
    public void setUrlBD(String url) {
        this.urlBD = url;
    }
    public void setConn(Connection conn) {
        this.conn = conn;
    }
    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }
    public void setSQLiteDatabasePath(String path) {
        this.SQLiteDbPath = path;
    }
    
    //Establecer si se usa MySQL o SQLite
    public void setMSQL() {
        this.SQLite = false;
    }
    public void setSQLite() {
        this.SQLite = true;
    }
    
    public boolean isSQLite() {
        return this.SQLite;
    }
    
    //Conexion a la BD
    public void conectar() throws SQLException {
        try {
            Class.forName(this.driverClassName).newInstance();
            if(this.SQLite) {
                this.conn = DriverManager.getConnection("jdbc:sqlite:"+this.SQLiteDbPath+"?useUnicode=true&characterEncoding=utf-8");
            } else {
                this.conn = DriverManager.getConnection(urlBD, usrBD, passBD);
            }
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException err) {
            Logger.getLogger(AgregarUsuario.class.getName()).log(Level.SEVERE, null, err);
        }
    }
    
    //Cerrar la conexion de BD
    public void cierraConexion() throws SQLException {
        this.conn.close();
    }
    
    //Metodos para ejecutar sentencias SQL
    public ResultSet consulta(String consulta) throws SQLException {
        this.estancia = (Statement) conn.createStatement();
        return this.estancia.executeQuery(consulta);
    } 
    public void actualizar(String actualiza) throws SQLException {
        this.estancia = (Statement) conn.createStatement();
        estancia.executeUpdate(actualiza);
    } 
    
    // Prepared Statements
    public void setPreparedStatement(String statement) throws SQLException {
        this.prepared = this.conn.prepareStatement(statement);
        this.preparedReady = false;
    }
    public void setPreparedVariables(String[][] variables) throws SQLException {
        int n = variables.length;
        
        for(int i=0; i<n; ++i) {
            if(variables[i][0].equals("String")) {
                this.prepared.setString(i+1, variables[i][1]);
            } else if(variables[i][0].equals("int")) {
                this.prepared.setInt(i+1, Integer.parseInt(variables[i][1]));
            }
        }
        
        this.preparedReady = true;
    }
    public ResultSet runPreparedQuery() throws SQLException {
        checkPreparedReady();
        return this.prepared.executeQuery();
    }
    public void runPreparedUpdate() throws SQLException {
        checkPreparedReady();
        this.prepared.executeUpdate();
    }
    private void checkPreparedReady() {
        if(!preparedReady) {
            throw new RuntimeException("Prepared Statement not ready yet!");
        }
    }
}