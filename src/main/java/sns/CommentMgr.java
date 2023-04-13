package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class CommentMgr {

	private DBConnectionMgr pool;
	
	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//덧글 달기
	public void insertPReply(CommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			UserinfoBean ubean=new UserinfoBean();
			PostBean pbean=new PostBean();
			con = pool.getConnection();
			sql = "insert comment(postId,userEmail,commentDetail,commentParent,commentChild,commentDate,commentCorrenct)values(?,?,?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pbean.getPostId());
			pstmt.setString(2, ubean.getUserEmail());
			pstmt.setString(3, bean.getCommentDetail());
			pstmt.setString(4, bean.getCommentParrent());
			pstmt.setString(5, bean.getCommentChild());
			pstmt.setString(6, bean.getCommentCorrect());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	//덧글 삭제
	public void deletePReply(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblPReply where rnum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//덧글 전부삭제
	public void deleteAllPReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from comment where postId=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//덧글 리스트
	public Vector<CommentBean> listPReply(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from comment where postId=? order by rnum desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setCommentId(rs.getInt(1));
				bean.setPostId(rs.getInt(2));
				bean.setUserEmail(rs.getString(3));
				bean.setCommentDetail(rs.getString(4));
				bean.setCommentParrent(rs.getString(5));
				bean.setCommentChild(rs.getString(6));
				bean.setCommentDate(rs.getString(7));
				bean.setCommentCorrect(rs.getString(8));
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