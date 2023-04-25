package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FollowAllow
 */
@WebServlet("/sns/FollowAllow")
public class FollowAllow extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comment = request.getParameter("commentDetail");
		int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail = request.getParameter("userEmail");
		UserinfoBean ubean=new UserinfoBean();
		CommentBean cbean = new CommentBean();
		cbean.setPostId(postId);
		cbean.setUserEmail(userEmail);
		cbean.setCommentDetail(comment);
		cbean.setCommentParrent("0");
		cbean.setCommentChild("0");
		cbean.setCommentCorrect("");
		FriemdmanagerMgr fmgr = new FriemdmanagerMgr();
		fmgr.friendallow(userEmail);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("follow.jsp");
		}

}
