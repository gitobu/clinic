<%-- 
    Document   : savejobtitle
    Created on : Jan 13, 2016, 8:25:49 PM
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
	
	
        if (document.jobtitle.job_title.value === ""){
		alert('Please enter job title');
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
      <c:set var="edit_mode" value="${not empty param.job_title_id}"></c:set>   
      <c:set var="new_mode" value="${ empty param.job_title_id}"></c:set> 
      
    <c:choose>
        <c:when test='${edit_mode}'>

            <c:set var="job_title_id" value = "<%= request.getParameter("job_title_id")%>"/>        
            <c:set var="job_title" value="<%= request.getParameter("job_title")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            update job_title set job_title = '${job_title}'
            where job_title_id = ${job_title_id}
            </sql:update>  

        </c:when>
        <c:when test='${new_mode}'>
            <sql:query dataSource="${snapshot}" var="jt">
            select CONCAT('JT', max(substr(job_title_no,3,5)) + 1) as jt_no 
            FROM job_title
            </sql:query>

            <c:forEach var="row" items="${jt.rows}">
                <c:set var="jt_no" value = "${row.jt_no}" />
            </c:forEach>   


            <c:set var="job_title" value="<%= request.getParameter("job_title")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            insert into job_title (job_title_no, job_title)
            values ('${jt_no}', '${job_title}')
            </sql:update>        

        </c:when>
    </c:choose>
    
    
    
    
     <sql:query dataSource="${snapshot}" var="jt_list">
        SELECT jt.job_title_id, jt.job_title_no, jt.job_title
        FROM job_title jt
        ORDER BY job_title
        </sql:query>
        
    <form name="jobtitle" action="savejobtitle.jsp" method="POST">
    <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>New Job Title</h2>
            </caption>
            
             <tr><th align="left">Job Title</th><td><input type="text" name="job_title"></td> </tr>
             
             
          
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
            </table>
    </form>
    <table border="1" cellpadding="10" align="center" >
         <caption><h2>Job Title</h2></caption>
         <tr>
            <th>Job Title Number</th>
            <th>Job Title</th>
            <th>Edit</th>

         </tr>
         <c:forEach var="row" items="${jt_list.rows}">
         <tr>
            <td><c:out value="${row.job_title_no}"/></td>
            <td><c:out value="${row.job_title}"/></td>
            <td><a href="<c:url value="jobTitle.jsp?job_title_id=${row.job_title_id}"/>">Edit</a></td>
         </tr>
         </c:forEach>
         </table>
    </div>
      <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>


