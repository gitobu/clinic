<%-- 
    Document   : savepatient
    Created on : Jan 16, 2016, 5:56:19 AM
    Author     : Gitobu
--%>

<jsp:directive.include file="sqllink.jsp"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kenya Clinic: Job Title</title>
        <link href="styleOne.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
    function validateFormValues(){
	
	
       if (document.patient.first_name.value === ""){
		alert('Please enter first name');
		return false;} 
        if (document.patient.last_name.value === ""){
		alert('Please enter last name');
		return false;} 
         if (document.patient.gender.value === ""){
		alert('Please select patient gender');
		return false;} 
			else
		{
			return true;
		}
    }
    </script>
    
    </head>
    <body>
  <div id="header">
       <jsp:directive.include file="header.html"/>
        </div>
        
              <div id="nav">
                 <jsp:directive.include file="menubar.jsp"/>
</div>   
<div id="section">
      <c:set var="edit_mode" value="${not empty param.patient_id}"></c:set>   
      <c:set var="new_mode" value="${ empty param.patient_id}"></c:set> 
      
    
      <c:choose>
        <c:when test='${edit_mode}'>
          
            <c:set var="patient_id" value = "<%= request.getParameter("patient_id")%>"/> 
            <c:set var="patient_no" value = "<%= request.getParameter("patient_no")%>"/> 
            <c:set var="first_name" value = "<%= request.getParameter("first_name")%>"/> 
            <c:set var="last_name" value = "<%= request.getParameter("last_name}")%>"/> 
        
            <c:set var="gender" value = "<%= request.getParameter("gender")%>"/> 
            <c:set var="national_id" value = "<%= request.getParameter("national_id")%>"/> 
            <c:set var="pin_no" value = "<%= request.getParameter("pin_no")%>"/> 

            <sql:update dataSource="${snapshot}" var="result">
            update patient set first_name = '${first_name}', last_name = '${last_name}', gender = ${gender}, national_id = '${national_id}', pin_no = '${pin_no}'
            where patient_id  = ${patient_id}
            </sql:update>  

        </c:when>
        <c:when test='${new_mode}'>
            <sql:query dataSource="${snapshot}" var="pa">
            select CONCAT('PT', max(substr(patient_no,3,5)) + 1) as pa_no 
            FROM patient
            </sql:query>

            <c:forEach var="row" items="${pa.rows}">
                <c:set var="pa_no" value = "${row.pa_no}" />
            </c:forEach>   

            <c:set var="first_name" value = "<%= request.getParameter("first_name")%>"/> 
            <c:set var="last_name" value = "<%= request.getParameter("last_name}")%>"/> 
        
            <c:set var="gender" value = "<%= request.getParameter("gender")%>"/> 
            <c:set var="national_id" value = "<%= request.getParameter("national_id")%>"/> 
            <c:set var="pin_no" value = "<%= request.getParameter("pin_n")%>"/>

            <sql:update dataSource="${snapshot}" var="result">
            insert into patient (patient_no, first_name, last_name, gender, national_id, pin_no)
            values ('${pa_no}', '${first_name}','${last_name}', ${gender}, '${national_id}, '${pin_no}')
            </sql:update>        

        </c:when>
    </c:choose>
    
<sql:query dataSource="${snapshot}" var="pa_list">
        SELECT pa.patient_id, pa.patient_no, pa.first_name, pa.last_name, pa.date_of_birth, pa.gender, pa.national_id, pa.pin_no
        FROM patient pa 
        ORDER BY pa.last_name
        </sql:query>
        
     
        
        <form name="patient" action="savepatient.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>Patient Information</h2>
            </caption>
             
        
                  
          
           <tr><th align="left">First name</th><td><input type="text" name="first_name" ></td> </tr>
             <tr><th align="left">last name</th><td><input type="text" name="last_name" ></td> </tr>
             <tr><th align="left">Date of birth</th><td><input type="text" name="date_of_birth" ></td> </tr>
             <tr><th align="left">Gender</th><td><input type="text" name="gender"></td> </tr>
             <tr><th align="left">National Id</th><td><input type="text" name="national_id" ></td> </tr>
             <tr><th align="left">PIN Number</th><td><input type="text" name="pin_no" ></td> </tr>
           
                 
                     
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
            </table>
            </form>
         <table border="1" cellpadding="10" align="center" >
         <caption><h2>Patient</h2></caption>
         <tr>
            <th>Patient Number</th>
            <th>First name</th>
            <th>Last name</th>
            <th>Date of birth</th>
            <th>Gender</th>
            <th>National Id</th>
            <th>PIN Number</th>
            <th>Edit</th>

         </tr>
         <c:forEach var="row" items="${pa_list.rows}">
         <tr>   
            <td><c:out value="${row.patient_no}"/></td>
            <td><c:out value="${row.first_name}"/></td>
            <td><c:out value="${row.last_name}"/></td>
            <td><c:out value="${row.date_of_birth}"/></td>
            <td><c:out value="${row.gender}"/></td>
            <td><c:out value="${row.national_id}"/></td>
            <td><c:out value="${row.pin_no}"/></td>
            
            <td><a href="<c:url value="patient.jsp?patient_id=${row.patient_id}"/>">Edit</a></td>
         </tr>
         </c:forEach>
         </table>
        </div>
        <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>


