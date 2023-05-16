package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FollowAcceptServlet
 */
@WebServlet("/sns/FollowAcceptServlet")
public class FollowAcceptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String myEmail = request.getParameter("myEmail");
		String Email = request.getParameter("Email");
		int result = followAccept(myEmail, Email);
		response.getOutputStream().write(String.valueOf(result).getBytes("UTF-8"));
	}

	public int followAccept(String userEmail, String Email) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		return dao.followAccept(userEmail, Email);
	}
	
	
}
