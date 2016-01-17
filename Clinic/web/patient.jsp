<%-- 
    Document   : patient
    Created on : Jan 15, 2016, 9:11:03 PM
    Author     : Gitobu
--%>




<jsp:directive.include file="sqllink.jsp"/>
<jsp:useBean id="pa" class="com.clinic.Patient" scope="session"/>

<html>
    <head><title>Kenya Clinic: Patient</title>
    <link href="styleOne.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function validateFormValues(){
	
	
        if (document.patient.first_name.value === ""){
		alert('Please enter first name');
		return false;} 
        if (document.patient.last_name.value === ""){
		alert('Please enter last name');
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
        <c:set var="patient_id" value = "${param.patient_id}"/>
           
        <sql:query dataSource="${snapshot}" var="pa_data">
        SELECT pa.patient_id, pa.patient_no, pa.first_name, pa.last_name, pa.date_of_birth, pa.gender, pa.national_id, pa.pin_no
        FROM patient pa 
        WHERE pa.patient_id = ${patient_id}
        </sql:query>
        
        <c:forEach var="row" items="${pa_data.rows}">
        <c:set var="patient_id" value = "${row.patient_id}"/>
        <c:set var="patient_no" value = "${row.patient_no}"/>
        <c:set var="first_name" value = "${row.first_name}"/>
        <c:set var="last_name" value = "${row.last_name}"/>
        
        <c:set var="gender" value = "${row.gender}"/>
        <c:set var="national_id" value = "${row.national_id}"/>
        <c:set var="pin_no" value = "${row.pin_no}"/>
    

        </c:forEach> 

        <jsp:setProperty name="pa" property="patient_id" value="${patient_id}"/>
        <jsp:setProperty name="pa" property="patient_no" value="${patient_no}"/>
        <jsp:setProperty name="pa" property="first_name" value="${first_name}"/>
        <jsp:setProperty name="pa" property="last_name" value="${last_name}"/>
       
        <jsp:setProperty name="pa" property="gender" value="${gender}"/>
        <jsp:setProperty name="pa" property="national_id" value="${national_id}"/>
        <jsp:setProperty name="pa" property="pin_no" value="${pin_no}"/>
        
     
    </c:when>
    <c:when test='${new_mode}'>
         <c:set var="patient_id" value = ""/>
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
             
         <c:choose>  
             <c:when test='${edit_mode}'>
                 <input type="hidden" name="patient_id" value="<%= pa.getPatient_id() %>">   
                  
             <tr><th align="left">First name</th><td><input type="text" name="first_name" value="<%= pa.getFirst_name() %>"></td> </tr>
             <tr><th align="left">last name</th><td><input type="text" name="last_name" value="<%= pa.getLast_name() %>"></td> </tr>
             <tr><th align="left">Date of birth</th><td><input type="text" name="date_of_birth" ></td> </tr>
             <tr><th align="left">Gender</th><td><input type="text" name="gender" value="<%= pa.getGender() %>"></td> </tr>
             <tr><th align="left">National Id</th><td><input type="text" name="national_id" value="<%= pa.getNational_id() %>"></td> </tr>
             <tr><th align="left">PIN Number</th><td><input type="text" name="pin_no" value="<%= pa.getPin_no() %>"></td> </tr>
          
            
             </c:when>
             <c:when test='${new_mode}'>
           <tr><th align="left">First name</th><td><input type="text" name="first_name" ></td> </tr>
             <tr><th align="left">last name</th><td><input type="text" name="last_name" ></td> </tr>
             <tr><th align="left">Date of birth</th><td><input type="text" name="date_of_birth" ></td> </tr>
             <tr><th align="left">Gender</th><td><input type="text" name="gender"></td> </tr>
             <tr><th align="left">National Id</th><td><input type="text" name="national_id" ></td> </tr>
             <tr><th align="left">PIN Number</th><td><input type="text" name="pin_no" ></td> </tr>
            </c:when> 
             </c:choose> 
                 
                     
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


