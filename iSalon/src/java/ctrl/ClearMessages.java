/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ctrl;

import database.cDatos;
import java.sql.SQLException;

/**
 *
 * @author A
 */
public class ClearMessages {
    public static void main(String[] args) throws SQLException {
        cDatos db = new cDatos();
        
        db.conectar();
        db.actualizar("delete from messages");
        db.cierraConexion();
    }
}
