package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/CommentReply")
public class CommentReply extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String commentDetail = request.getParameter("commentDetail");
		int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail = request.getParameter("userEmail");
		String commentParrent = request.getParameter("commentParrent");
		String commentId=request.getParameter("commentId");
		CommentBean cbean = new CommentBean();
		cbean.setPostId(postId);
		cbean.setUserEmail(userEmail);
		cbean.setCommentDetail(commentDetail);
		cbean.setCommentParrent(commentId);
		cbean.setCommentChild("1");
		cbean.setCommentCorrect("");
		CommentMgr cmgr = new CommentMgr();
		PostMgr pmgr=new PostMgr();
		cmgr.insertReply(cbean);
		pmgr.upComment(postId);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		}
	

}
