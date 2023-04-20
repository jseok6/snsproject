package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//댓글삭제
@WebServlet("/sns/cdel")
public class cdel extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentMgr cmgr = new CommentMgr();
		int commentId = Integer.parseInt(request.getParameter("commentId"));
		System.out.println(commentId);
		cmgr.deletePReply(commentId);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		else 
			response.sendRedirect("Main.jsp?gid="+gid);
	}

}
