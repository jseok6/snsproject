package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class FriemdmanagerMgr {
	private DBConnectionMgr pool;
	
	public FriemdmanagerMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//친구 추가
	public void followfirend(String userEmail,String followEmail) {
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			FriendmanagerBean bean=new FriendmanagerBean();
			con=pool.getConnection();
			sql="insert into friendmanager(userEmail,friendEmail,friendSign) values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,userEmail);
			pstmt.setString(2,followEmail);
			pstmt.setInt(3, 0);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
	//친구가 되어있는지 체크
	public boolean friendCheck(String userEmail, String friendEmail) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		boolean flag=false;
		try {
			
			con=pool.getConnection();
			sql="SELECT * FROM friendmanager WHERE userEmail=? and friendEmail=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(2, userEmail);
			pstmt.setString(1, friendEmail);
			rs = pstmt.executeQuery();

			flag = rs.next();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
	//userEmail값이랑 friendsign이 0인경우만 5명불러오기
	public Vector<FriendmanagerBean> listfMember(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FriendmanagerBean> vlist = new Vector<FriendmanagerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendmanager where userEmail =? and friendsign=0 order by friendIndex limit 5";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendmanagerBean bean = new FriendmanagerBean();
				bean.setFriendIndex(rs.getString(1));
				bean.setUserEmail(rs.getString(2));
				bean.setFriendEmail(rs.getString(3));
				bean.setFriendSign(rs.getInt(4));
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
