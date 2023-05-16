package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.JsonIOException;

@WebServlet("/sns/UserLogout")
public class UserLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 	
		HttpSession session = request.getSession();
		session.invalidate();
		response.getWriter().write(getJSON());	
	}

	@SuppressWarnings("unchecked")
	public String getJSON() {
		JSONObject sendObject = new JSONObject();
		sendObject.put("result","login.jsp");		 
		return sendObject.toString();
	}
	
}
