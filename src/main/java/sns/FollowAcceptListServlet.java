package sns;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class FollowAcceptServlet
 */
@WebServlet("/sns/FollowAcceptListServlet")
public class FollowAcceptListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Gson gson = new Gson();
		String userEmail = request.getParameter("userEmail");
		Vector<String> followerList = followerInfo(userEmail);
		System.out.println("vector:"+followerList);
		ArrayList<UserinfoBean> followerImg = followerImage(followerList);
		System.out.println("ArrayList:"+followerImg);
		String json = gson.toJson(followerImg);
		System.out.println("json:"+json);
		response.getWriter().write(json);
		
	}

	
	
	public Vector<String> followerInfo(String userEmail){
		ProfileMgr pmgr = new ProfileMgr();
		Vector<String> followerList = pmgr.followerInfo(userEmail);
		return followerList;
	}
	
	public ArrayList<UserinfoBean> followerImage(Vector<String> followerList){
		UserMgr umgr = new UserMgr();
		ArrayList<UserinfoBean> followerImg = new ArrayList<UserinfoBean>();
		for(int i=0;followerList.size() > i; i++) {
			followerImg.add(umgr.getInfo(followerList.get(i)));
		}
		return followerImg;
	}
	
}















