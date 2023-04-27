package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PostlikeMgr {
	private DBConnectionMgr pool;
	public PostlikeMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean postLike(int postId,String userEmail) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		ResultSet rs=null;
		boolean flag=false;
		try {
			
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postId);
			pstmt.setString(2, userEmail);
			rs=pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
}
