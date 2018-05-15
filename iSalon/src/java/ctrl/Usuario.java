/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ctrl;

import database.cDatos;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Alumno
 */
public class Usuario {

    private int id;
    private int pass;
    private int tipo;
    private boolean isValid;
    private String name, username;
    private String tableName;
    private String idRow, nameRow, passRow, typeRow, usernameRow;
    private cDatos db;

    public Usuario(String nombre, int pass) {
        this.username = nombre;
        this.pass = pass;
        inicializar();
    }

    public Usuario(int id) {
        this.id = id;
        inicializar();
    }

    private void inicializar() {
        this.isValid = false;
        this.db = new cDatos();
        this.tableName = "usuarios";
        this.idRow = "id";
        this.usernameRow = "username";
        this.nameRow = "name";
        this.passRow = "pass";
        this.typeRow = "tipo";
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPass(int pass) {
        this.pass = pass;
    }

    public void setNombre(String nombre) {
        this.name = nombre;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public int getTipo() {
        return tipo;
    }

    public String getNombre() {
        return name;
    }

    public boolean isValid() {
        return this.isValid;
    }

    public String getUsername() {
        return this.username;
    }

    public String remove() throws SQLException {
        if (this.isValid) {
            db.conectar();
            
            db.setPreparedStatement("delete from " + this.tableName + " where " + this.idRow + " = ?;");
            db.setPreparedVariables(new String[][]{
                {"int", String.valueOf(id)}
            });
            
            db.cierraConexion();
            
            return "Usuario eliminado";
        } else {
            return "Usuario no existe!";
        }
    }

    public String create(int type) throws SQLException {
        String message = "";
        ResultSet res;

        tipo = type;
        
        db.conectar();

        db.setPreparedStatement("call crearUsuario(?, ?, ?, ?)");
        db.setPreparedVariables(new String[][]{
            {"String", username},
            {"String", name},
            {"int", String.valueOf(pass)},
            {"int", String.valueOf(tipo)}
        });

        res = db.runPreparedQuery();

        while (res.next()) {
            message = res.getString("message");
            id = res.getInt("id");
            isValid = (res.getInt("isValid") == 1);
            if(!isValid) {
                tipo = 0;
            }
        }

        db.cierraConexion();

        return message;
    }

    public String edit() throws SQLException {
        if (this.isValid) {
            db.conectar();
            
            db.setPreparedStatement("update " + this.tableName + " set " + this.nameRow + " = ?, " + this.passRow + " = ?, " + this.usernameRow + " = ? "
                    + "where " + this.idRow + " = ?;");
            db.setPreparedVariables(new String[][]{
                {"String", this.name},
                {"int", String.valueOf(this.pass)},
                {"String", this.username},
                {"int", String.valueOf(this.id)}
            });

            db.runPreparedUpdate();
            
            db.cierraConexion();
            return "Usuario editado";
        } else {
            return "Usuario no existe!";
        }
    }

    public void validarUsuarioId() throws SQLException {
        db.conectar();

        db.setPreparedStatement("select * from " + this.tableName + " where " + this.idRow + " = ?;");
        db.setPreparedVariables(new String[][]{
            {"int", String.valueOf(id)}
        });
        validarUsuario(db.runPreparedQuery());

        db.cierraConexion();
    }

    public void validarUsuarioCred() throws SQLException {
        db.conectar();
        
        db.setPreparedStatement("call validarUsuario(?, ?);");
        db.setPreparedVariables(new String[][]{
            {"String", username},
            {"int", String.valueOf(pass)}
        });
        ResultSet res = db.runPreparedQuery();

        while (res.next()) {
            isValid = (res.getInt("isValid") == 1);

            if (isValid) {
                id = res.getInt("id");
                tipo = res.getInt("tipo");
                name = res.getString("name");
            } else {
                id = -1;
                tipo = -1;
                name = "";
            }
        }
        db.cierraConexion();
    }

    private void validarUsuario(ResultSet res) throws SQLException {
        if (res.next()) {
            id = res.getInt(idRow);
            name = res.getString(nameRow);
            tipo = res.getInt(typeRow);
            pass = res.getInt(passRow);
            username = res.getString(usernameRow);
            isValid = true;
        } else {
            id = -1;
            name = "";
            username = "";
            pass = 0;
            tipo = -1;
            isValid = false;
        }
    }
}
