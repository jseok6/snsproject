package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FriemdmanagerMgr {
	private DBConnectionMgr pool;
	
	public FriemdmanagerMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void followfirend(String userEmail,String followEmail) {
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			FriendmanagerBean bean=new FriendmanagerBean();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
}
