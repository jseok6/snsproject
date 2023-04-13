package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



public class UserinfoMgr {
	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/ch19/userphoto/";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 20*1024*1024;
	
	public UserinfoMgr() {
		// TODO Auto-generated constructor stub
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 유저 정보 불러오기
		public UserinfoBean getPMember(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			UserinfoBean bean = new UserinfoBean();
			try {
				con = pool.getConnection();
				sql = "select userNickName,userImage from userinfo where userEmail=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setUserEmail(email);
					bean.setUserName(rs.getString(1));
					bean.setUserImage(rs.getString(2));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	
	//본인을 제외한 5명 리스트
		public Vector<UserinfoBean> listPMember(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<UserinfoBean> vlist = new Vector<UserinfoBean>();
			try {
				con = pool.getConnection();
				sql = "select userEmail,userNickName,userImage from userinfo where userEmail !=? order by rand() limit 5";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					UserinfoBean bean = new UserinfoBean();
					bean.setUserEmail(rs.getString(1));
					bean.setUserNickName(rs.getString(2));
					bean.setUserImage(rs.getString(3));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		// 게시물 리스트
		public Vector<PostBean> listPBlog(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<PostBean> vlist = new Vector<PostBean>();
			try {
				con = pool.getConnection();
				sql = "select * from post where userEmail=? order by postId desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					PostBean bean = new PostBean();
					bean.setPostId(rs.getInt(1));
					bean.setUserEmail(rs.getString(2));
					bean.setLikeNum(rs.getInt(3));
					bean.setImageName(rs.getString(4));
					bean.setVideoName(rs.getString(5));
					bean.setShareNum(rs.getInt(6));
					bean.setCommentNum(rs.getInt(7));
					bean.setCreationDate(rs.getString(8));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
}
