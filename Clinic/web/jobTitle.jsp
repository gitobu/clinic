
<%-- 
    Document   : SubjectArea
    Created on : Aug 23, 2015, 8:07:53 AM
    Author     : Gitobu
--%>

<jsp:directive.include file="sqllink.jsp"/>
<jsp:useBean id="jt" class="com.clinic.Job_Title" scope="session"/>

<html>
    <head><title>Kenya Clinic: Job Title</title>
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
        <c:set var="job_title_id" value = "${param.job_title_id}"/>
           
        <sql:query dataSource="${snapshot}" var="jt_data">
        SELECT jt.job_title_id, jt.job_title_no, jt.job_title
        FROM job_title jt 
        WHERE jt.job_title_id = ${job_title_id}
        </sql:query>
        
        <c:forEach var="row" items="${jt_data.rows}">
        <c:set var="job_title_id" value = "${row.job_title_id}"/>
        <c:set var="job_title_no" value = "${row.job_title_no}"/>
        <c:set var="job_title" value = "${row.job_title}"/>
    

        </c:forEach> 

        <jsp:setProperty name="jt" property="job_title_id" value="${job_title_id}"/>
        <jsp:setProperty name="jt" property="job_title_no" value="${job_title_no}"/>
        <jsp:setProperty name="jt" property="job_title" value="${job_title}"/>
     
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
             
         <c:choose>  
             <c:when test='${edit_mode}'>
                 <input type="hidden" name="job_title_id" value="<%= jt.getJob_title_id() %>">   
                  
             <tr><th align="left">Job Title</th><td><input type="text" name="job_title" value="<%= jt.getJob_title() %>"></td> </tr>
             </c:when>
             <c:when test='${new_mode}'>
             <tr><th align="left">Job Title</th><td><input type="text" name="job_title" ></td> </tr>
            </c:when> 
             </c:choose> 
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

