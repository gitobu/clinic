<%-- 
    Document   : visit
    Created on : Jan 16, 2016, 11:09:11 PM
    Author     : Gitobu
--%>

<%-- 
    Document   : provider
    Created on : Jan 13, 2016, 9:47:02 PM
    Author     : Gitobu
--%>


<jsp:directive.include file="sqllink.jsp"/>
<jsp:useBean id="vi" class="com.clinic.Visit" scope="session"/>

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
            
            <c:set var="edit_mode" value="${not empty param.visit_id}"></c:set>   
            <c:set var="new_mode" value="${ empty param.visit_id}"></c:set> 
            
            
            
    <c:choose>
    <c:when test='${edit_mode}'>
        <c:set var="visit_id" value = "${param.visit_id}"/>
           
    <sql:query dataSource="${snapshot}" var="vi_data">
    SELECT v.visit_id, v.visit_no, v.patient_id, v.visit_date, v.primary_complaint, v.provider_id, CONCAT(p.first_name,' ',p.last_name) as patient_name, CONCAT(pr.first_name, ' ' , pr.last_name) as provider_name
    FROM visit v inner join patient p on v.patient_id = p.patient_id inner join provider pr on v.provider_id = pr.provider_id
    WHERE v.visit_id = ${visit_id}
    </sql:query>
        
    <c:forEach var="row" items="${vi_data.rows}">
    <c:set var="visit_id" value = "${row.visit_id}"/>
    <c:set var="visit_no" value = "${row.visit_no}"/>
    <c:set var="patient_id" value = "${row.patient_id}"/>
    <c:set var="visit_date" value = "${row.visit_date}"/>
    <c:set var="primary_complaint" value = "${row.primary_complaint}"/>
    <c:set var="provider_id" value = "${row.provider_id}"/>
    <c:set var="patient_name" value = "${row.patient_name}"/>
    <c:set var="provider_name" value = "${row.provider_name}"/>

    </c:forEach> 

    <jsp:setProperty name="vi" property="visit_id" value="${visit_id}"/>
    <jsp:setProperty name="vi" property="visit_no" value="${visit_no}"/>
    <jsp:setProperty name="vi" property="patient_id" value="${patient_id}"/>
   
     
    </c:when>
    <c:when test='${new_mode}'>
         <c:set var="visit_id" value = ""/>
    </c:when>
    </c:choose>

            
       
    <sql:query dataSource="${snapshot}" var="vi_list">
    SELECT v.visit_id, v.visit_no, v.patient_id, v.visit_date, v.primary_complaint, v.provider_id, CONCAT(p.first_name,' ',p.last_name) as patient_name, CONCAT(pr.first_name, ' ' , pr.last_name) as provider_name
    FROM visit v inner join patient p on v.patient_id = p.patient_id inner join provider pr on v.provider_id = pr.provider_id
    ORDER BY pr.last_name
    </sql:query>
        
    <sql:query dataSource="${snapshot}" var="pr">
    SELECT provider_id, CONCAT(first_name, ' ' , last_name) as provider
    FROM provider
    ORDER BY last_name
    </sql:query> 
        
        <form name="visit" action="savevisti.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>Patient Visit</h2>
            </caption>
             
         
                 <tr><th align="left">Visit date</th><td><input type="text" name="visit_date" /></td> </tr>
                 <tr><th align="left">Primary complaint</th><td><textarea name="primary_complaint" rows="5" /></td> </tr><TEXTAREA NAME="textarea1" ROWS="5"></TEXTAREA>
            
                 <tr><th align="left">Provider </th><td> 
                <select name="provider_id">
                  <c:choose>  
             
                      
                      <c:when test='${edit_mode}'>   
                 <option value="${provider_id}'"> ${provider_name}  </option>
              </c:when>
             <c:when test='${new_mode}'>
                 <option value="">[Please select provider]</option>
             </c:when>
                  </c:choose>
                 
                 <c:forEach var="row" items="${pr.rows}">
                <option value="${row.provider_id}">${row.provider}</option>
  		</c:forEach> 
                </select> 
                
       
             
                 
            
                 
                 
                   
                 
                     
                     </td> </tr>
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
         
            </table>
            </form>
         
         
        </div>
        <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>


