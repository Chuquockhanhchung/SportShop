    package model;

    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.SQLException;
    import java.util.logging.Level;
    import java.util.logging.Logger;

    public class DBContext {

        protected Connection connection;

        public DBContext() {
        try {
            String user = "chung"; 
            String pass = "123"; 
            String url = "jdbc:sqlserver://DESKTOP-RIM8CPH:1433;databaseName=SportShop;encrypt=true;trustServerCertificate=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
}
        public static void main(String[] args) {
            DBContext db = new DBContext();
            System.out.println(db);
        }
   

    }
