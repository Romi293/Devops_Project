<%@ page import="java.util.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<!--
Simple Page to Upload Multiple Files at one Go.

-->
<head>
<script>
<title>Romi and Eyal and Ziv</title>
</script>
</head>
<center>
<h1>Your files  uploaded </h1>
<br />
<br />

<%
	String filePath = "";
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	System.out.println("isMultipart="+isMultipart);
	System.out.println(config.getServletContext());

	File root_directory = new File(getServletContext().getRealPath("/")); 
	root_directory = root_directory.getParentFile();
	System.out.println("root_directory->?"+root_directory);
	filePath = root_directory.toString()+"//Your_Desired_Folder//file_uploads//";


	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	List items=null;
	
	try
	 {
		items = upload.parseRequest(request);
	} catch (FileUploadException e) 
	{
		e.printStackTrace();
	}
	Iterator itr = items.iterator();
	while (itr.hasNext())
	 {
	FileItem item = (FileItem)(itr.next());

		if (item.isFormField()) 
		{
			try{
			String field=item.getFieldName();
			String value=item.getString();
			System.out.println("field="+value);
			}
			catch(Exception e)
			{
				System.out.println("Exception "+e);		
			}
		} 
		else {
			try
			 {
			
			String itemName = item.getName();
			out.println("\n FileName:"+itemName);%><br /><%
			File savedFile = new File(filePath+itemName);
			item.write(savedFile);  
			//out.println("done");
			} 
			catch (Exception e) 
			{
			e.printStackTrace();
			}
		}
	}

   %>

</center>
</body>
</html>
