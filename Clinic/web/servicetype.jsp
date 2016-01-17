<%-- 
    Document   : servicetype
    Created on : Jan 16, 2016, 8:25:17 AM
    Author     : Gitobu
--%>

<jsp:directive.include file="sqllink.jsp"/>
<jsp:useBean id="st" class="com.clinic.ServiceType" scope="session"/>

<html>
    <head><title>Kenya Clinic: Service Type</title>
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
        <c:set var="service_type_id" value = "${param.service_type_id}"/>
           
        <sql:query dataSource="${snapshot}" var="st_data">
        SELECT st.service_type_id, st.service_type_no, st.service_type_description
        FROM service_type st 
        WHERE st.service_type_id = ${service_type_id}
        </sql:query>
        
        <c:forEach var="row" items="${st_data.rows}">
        <c:set var="service_type_id" value = "${row.service_type_id}"/>
        <c:set var="service_type_no" value = "${row.service_type_no}"/>
        <c:set var="service_type_description" value = "${row.service_type_description}"/>
    

        </c:forEach> 

        <jsp:setProperty name="st" property="service_type_id" value="${service_type_id}"/>
        <jsp:setProperty name="st" property="service_type_no" value="${service_type_no}"/>
        <jsp:setProperty name="st" property="service_type_description" value="${service_type_description}"/>
     
    </c:when>
    

   
</c:choose>

            
       
        <sql:query dataSource="${snapshot}" var="st_list">
        SELECT st.service_type_id, st.service_type_no, st.service_type_description
        FROM service_type st 
        ORDER BY service_type_description
        </sql:query>
        
        <form name="jobtitle" action="saveservicetype.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>New Service Type</h2>
            </caption>
             
         <c:choose>  
             <c:when test='${edit_mode}'>
                 <input type="hidden" name="service_type_id" value="<%= st.getService_type_id() %>">   
                  
             <tr><th align="left">Service Type</th><td><input type="text" name="service_type_description" value="<%= st.getService_type_description() %>"></td> </tr>
             </c:when>
             <c:when test='${new_mode}'>
             <tr><th align="left">Service Type</th><td><input type="text" name="service_type_description" ></td> </tr>
            </c:when> 
             </c:choose> 
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


