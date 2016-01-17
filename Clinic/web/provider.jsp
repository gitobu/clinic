<%-- 
    Document   : provider
    Created on : Jan 13, 2016, 9:47:02 PM
    Author     : Gitobu
--%>


<jsp:directive.include file="sqllink.jsp"/>
<jsp:useBean id="pr" class="com.clinic.Provider" scope="session"/>

<html>
    <head><title>Kenya Clinic: Healthcare provider</title>
    <link href="styleOne.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function validateFormValues(){
	
	
        if (document.provider.first_name.value === ""){
		alert('Please enter first name');
		return false;} 
        if (document.provider.last_name.value === ""){
		alert('Please enter last name');
		return false;} 
         if (document.provider.job_title_id.value === ""){
		alert('Please select job title');
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
            
            <c:set var="edit_mode" value="${not empty param.provider_id}"></c:set>   
            <c:set var="new_mode" value="${ empty param.provider_id}"></c:set> 
            
            
            
<c:choose>
    <c:when test='${edit_mode}'>
        <c:set var="provider_id" value = "${param.provider_id}"/>
           
        <sql:query dataSource="${snapshot}" var="pr_data">
        SELECT pr.provider_id, pr.provider_no, pr.first_name, pr.last_name, pr.job_title_id, jt.job_title
        FROM provider pr inner join job_title jt on pr.job_title_id = jt.job_title_id
        WHERE pr.provider_id = ${provider_id}
        </sql:query>
        
        <c:forEach var="row" items="${pr_data.rows}">
        <c:set var="provider_id" value = "${row.provider_id}"/>
        <c:set var="provider_no" value = "${row.provider_no}"/>
        <c:set var="first_name" value = "${row.first_name}"/>
        <c:set var="last_name" value = "${row.last_name}"/>
        <c:set var="job_title_id" value = "${row.job_title_id}"/>
         <c:set var="job_title" value = "${row.job_title}"/>

        </c:forEach> 

        <jsp:setProperty name="pr" property="provider_id" value="${provider_id}"/>
        <jsp:setProperty name="pr" property="provider_no" value="${provider_no}"/>
        <jsp:setProperty name="pr" property="first_name" value="${first_name}"/>
        <jsp:setProperty name="pr" property="last_name" value="${last_name}"/>
        <jsp:setProperty name="pr" property="job_title_id" value="${job_title_id}"/>
     
    </c:when>
    <c:when test='${new_mode}'>
         <c:set var="job_title_id" value = ""/>
   </c:when>
</c:choose>

            
       
        <sql:query dataSource="${snapshot}" var="pr_list">
        SELECT pr.provider_id, pr.provider_no, pr.first_name, pr.last_name, jt.job_title
        FROM provider pr, job_title jt
        WHERE pr.job_title_id = jt.job_title_id
        ORDER BY pr.last_name
        </sql:query>
        
        <sql:query dataSource="${snapshot}" var="jt">
        SELECT job_title_id, job_title
        FROM job_title
        ORDER BY job_title
        </sql:query> 
        
        <form name="provider" action="saveprovider.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>Healthcare provider</h2>
            </caption>
             
         <c:choose>  
             <c:when test='${edit_mode}'>
                 <input type="hidden" name="provider_id" value="<%= pr.getProvider_id() %>">   
                  
             <tr><th align="left">First name</th><td><input type="text" name="first_name" value="<%= pr.getFirst_name() %>"></td> </tr>
             <tr><th align="left">last name</th><td><input type="text" name="last_name" value="<%= pr.getLast_name() %>"></td> </tr>
             </c:when>
             <c:when test='${new_mode}'>
                 <tr><th align="left">First name</th><td><input type="text" name="first_name" /></td> </tr>
                 <tr><th align="left">last name</th><td><input type="text" name="last_name" /></td> </tr>
            </c:when> 
             </c:choose> 
                 <tr><th align="left">Job Title</th><td> 
                <select name="job_title_id">
                  <c:choose>  
             
                      
                      <c:when test='${edit_mode}'>   
                 <option value="<%= pr.getJob_title_id() %>"> ${job_title}  </option>
              </c:when>
             <c:when test='${new_mode}'>
                 <option value="">[Please select job title]</option>
             </c:when>
                  </c:choose>
                 
                 <c:forEach var="row" items="${jt.rows}">
                <option value="${row.job_title_id}">${row.job_title}</option>
  		</c:forEach> 
                </select> 
                
       
             
                 
            
                 
                 
                   
                 
                     
                     </td> </tr>
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
            </table>
            </form>
         <table border="1" cellpadding="10" align="center" >
         <caption><h2>Health care provider</h2></caption>
         <tr>
            <th>Provider Number</th>
            <th>First name</th>
            <th>Last name</th>
            <th>Job Title</th>
            <th>Edit</th>

         </tr>
         <c:forEach var="row" items="${pr_list.rows}">
         <tr>
            <td><c:out value="${row.provider_no}"/></td>
            <td><c:out value="${row.first_name}"/></td>
            <td><c:out value="${row.last_name}"/></td>
            <td><c:out value="${row.job_title}"/></td>
            <td><a href="<c:url value="provider.jsp?provider_id=${row.provider_id}"/>">Edit</a></td>
         </tr>
         </c:forEach>
         </table>
        </div>
        <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>

