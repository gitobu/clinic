<%-- 
    Document   : saveservicetype
    Created on : Jan 16, 2016, 10:03:52 PM
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
	
	
        if (document.servicetype.service_type_description.value === ""){
		alert('Please enter service type');
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
      <c:set var="edit_mode" value="${not empty param.service_type_id}"></c:set>   
      <c:set var="new_mode" value="${ empty param.service_type_id}"></c:set> 
      
    <c:choose>
        <c:when test='${edit_mode}'>

            <c:set var="service_type_id" value = "<%= request.getParameter("service_type_id")%>"/>        
            <c:set var="service_type_description" value="<%= request.getParameter("service_type_description")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            update service_type set service_type_description = '${service_type_description}'
            where service_type_id = ${service_type_id}
            </sql:update>  

        </c:when>
        <c:when test='${new_mode}'>
            <sql:query dataSource="${snapshot}" var="st">
            select CONCAT('ST', max(substr(service_type_no,3,5)) + 1) as st_no 
            FROM service_type
            </sql:query>

            <c:forEach var="row" items="${st.rows}">
                <c:set var="st_no" value = "${row.st_no}" />
            </c:forEach>   


            <c:set var="service_type_description" value="<%= request.getParameter("service_type_description")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            insert into service_type (service_type_no, service_type_description)
            values ('${st_no}', '${service_type_description}')
            </sql:update>        

        </c:when>
    </c:choose>
    
    
    
    
     <sql:query dataSource="${snapshot}" var="st_list">
        SELECT st.service_type_id, st.service_type_no, st.service_type_description
        FROM service_type st 
        ORDER BY service_type_description
        </sql:query>
        
        <form name="jobtitle" action="savejobtitle.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>New Service Type</h2>
            </caption>
             
             <tr><th align="left">Service Type</th><td><input type="text" name="service_type_description" ></td> </tr>
            
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
            </table>
            </form>
         <table border="1" cellpadding="10" align="center" >
         <caption><h2>Service Type</h2></caption>
         <tr>
            <th>Service Type Number</th>
            <th>Service Type</th>
            <th>Edit</th>

         </tr>
         <c:forEach var="row" items="${st_list.rows}">
         <tr>
            <td><c:out value="${row.service_type_no}"/></td>
            <td><c:out value="${row.service_type_description}"/></td>
            <td><a href="<c:url value="servicetype.jsp?service_type_id=${row.service_type_id}"/>">Edit</a></td>
         </tr>
         </c:forEach>
         </table>
        </div>
        <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>


