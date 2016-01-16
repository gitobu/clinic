<%-- 
    Document   : saveprovider
    Created on : Jan 13, 2016, 10:20:35 PM
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

            <c:set var="provider_id" value = "<%= request.getParameter("provider_id")%>"/>        
            <c:set var="first_name" value="<%= request.getParameter("first_name")%>" />
            <c:set var="last_name" value="<%= request.getParameter("last_name")%>" />
            <c:set var="job_title_id" value="<%= request.getParameter("job_title_id")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            update provider set first_name = '${first_name}', last_name = '${last_name}', job_title_id = ${job_title_id}
            where provider_id  = ${provider_id}
            </sql:update>  

        </c:when>
        <c:when test='${new_mode}'>
            <sql:query dataSource="${snapshot}" var="pr">
            select CONCAT('PR', max(substr(provider_no,3,5)) + 1) as pr_no 
            FROM provider
            </sql:query>

            <c:forEach var="row" items="${pr.rows}">
                <c:set var="pr_no" value = "${row.pr_no}" />
            </c:forEach>   


            <c:set var="first_name" value="<%= request.getParameter("first_name")%>" />
            <c:set var="last_name" value="<%= request.getParameter("last_name")%>" />
            <c:set var="job_title_id" value="<%= request.getParameter("job_title_id")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            insert into provider (provider_no, first_name, last_name, job_title_id)
            values ('${pr_no}', '${first_name}','${last_name}', ${job_title_id})
            </sql:update>        

        </c:when>
    </c:choose>
    
    <sql:query dataSource="${snapshot}" var="jt">
        SELECT job_title_id, job_title
        FROM job_title
        ORDER BY job_title
        </sql:query> 
    
    
     
         <sql:query dataSource="${snapshot}" var="pr_list">
        SELECT pr.provider_id, pr.provider_no, pr.first_name, pr.last_name, jt.job_title
        FROM provider pr, job_title jt
        WHERE pr.job_title_id = jt.job_title_id
        ORDER BY pr.last_name
        </sql:query>
        
        
    <form name="provider" action="saveprovider.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>Healthcare provider</h2>
            </caption>
             
        
                 <tr><th align="left">First name</th><td><input type="text" name="first_name" /></td> </tr>
                 <tr><th align="left">last name</th><td><input type="text" name="last_name" /></td> </tr>
           
                 <tr><th align="left">Job Title</th><td> 
                 <select name="provider_id">
                 <option value="">[Please select job title]</option>
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



