/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mysqlconnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

/**
 *
 * @author Swarn Avinash Kumar
 */
public class connectionsql {
    static Connection con=null;
    String uname="Swarn";
    String pword="0123@root";
    int count;
    public static Connection connect()
    {        
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost/java_web_app","root","swarnavinash");
            System.out.println("connected  "+con);
            
            
        }catch(Exception e)
        {
             System.out.println("cError   "+con);
             System.out.println("EXCEPTION IS "+e);
        }
        finally{
            return con;
        }
    }
    public static void main(String Arg[])
    {
        
        connect();
        Date dt =Date.valueOf(LocalDate.now());
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        try {
            String Dates=dateFormat.format(dt);
            System.out.println("DAte S "+Dates);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
 