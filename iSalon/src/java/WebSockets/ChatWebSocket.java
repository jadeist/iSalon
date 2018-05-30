/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebSockets;

import database.cDatos;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.json.JSONObject;

/**
 *
 * @author Alumno
 */
@ServerEndpoint("/WebSockets/chat")
public class ChatWebSocket {
    
    private final String[][] prohibitedChars = new String[][] {
        {"<", "&lt;"},
        {">", "&gt;"},
        {"{", "&#123;"},
        {"}", "&#124;"},
    };
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet());

    public static void sendToAll(Object data) {
        try {
            for (Session s : sessions) {
                s.getBasicRemote().sendObject(data);
            }
        } catch (IOException | EncodeException ex) {
            System.out.println("Send Error: " + ex.toString());
        }
    }

    @OnOpen
    public void onOpen(Session ses) {
        sessions.add(ses);
        
        Runnable sendMessageLog = new Runnable() {
            @Override
            public void run() {
                try {
                    cDatos db = new cDatos();
                    
                    db.conectar();
                    
                    ResultSet res = db.consulta("select * from messages order by fecha asc");
                    while(res.next()) {
                        ses.getBasicRemote().sendObject(res.getString("message"));
                    }
                    
                    db.cierraConexion();
                } catch (SQLException | IOException | EncodeException ex) {
                    Logger.getLogger(ChatWebSocket.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        };
        sendMessageLog.run();
    }

    @OnClose
    public void onClose(Session ses) {
        sessions.remove(ses);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        DateFormat format = new SimpleDateFormat("[dd/MM/yy hh:mm:ss]");
        
        message = removeChars(message);
        JSONObject json = new JSONObject(message);
        String res = format.format(new Date()) + json.getString("name") + " -> " + json.getString("message");
        
        if (sessions.contains(session) && !json.getString("message").equals("")) {
            sendToAll(res);
        }
        
        // Guardar a base de datos
        Runnable saveToDB = new Runnable() {
            @Override
            public void run() {
                try {
                    cDatos db = new cDatos();
                    db.conectar();
                    
                    db.setPreparedStatement("insert into messages(message) values(?)");
                    db.setPreparedVariables(new String[][] {
                        {"String", res}
                    });
                    db.runPreparedUpdate();
                    
                    db.cierraConexion();
                } catch (SQLException ex) {
                    Logger.getLogger(ChatWebSocket.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        };
        
        saveToDB.run();
    }
    
    private String removeChars(String data) {
        int n = prohibitedChars.length;
        
        for (int i = 0; i<n; ++i) {
            data = data.replaceAll(prohibitedChars[i][0], prohibitedChars[i][1]);
        }
        
        return data;
    }
}
