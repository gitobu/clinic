<%-- 
    Document   : sqllink
    Created on : Jan 13, 2016, 7:54:05 PM
    Author     : Gitobu
--%>

<%-- 
    Document   : sqllink
    Created on : Jul 19, 2015, 12:06:38 PM
    Author     : Gitobu
--%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3307/ciothirai?zeroDateTimeBehavior=convertToNull"
     user="root"  password="Ist303@cgu"/>
    

 