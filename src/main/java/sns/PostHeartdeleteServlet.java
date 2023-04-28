package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/PostHeartdeleteServlet")
public class PostHeartdeleteServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PostMgr pmgr = new PostMgr();
		PostlikeMgr plmgr=new PostlikeMgr();
		int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail=request.getParameter("userEmail");
		pmgr.minusHCnt(postId);
		System.out.println("삭제중:"+userEmail+":"+postId);
		plmgr.deletePostlike(userEmail, postId);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		else 
			response.sendRedirect("Main.jsp?gid="+gid);
	}

}
