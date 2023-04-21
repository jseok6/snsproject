package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/FollowServlet")
public class FollowServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		FriemdmanagerMgr fmgr=new FriemdmanagerMgr();
		String userEmail=request.getParameter("userEmail");
		String followEmail=request.getParameter("friendEmail");
		System.out.println(userEmail);
		System.out.println(followEmail);
		fmgr.followfirend(userEmail,followEmail);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		
	}

}
