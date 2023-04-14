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
	public void deletePReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from comment where commentId=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
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
			sql = "select * from comment where postId=? order by commentId desc";
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
	//Board Reply:답글 입력
/**		public void replyBoard(CommentBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,"
						+ "pass,count,ip)values(?, ?, ?, ?, ?, ?, now(), ?, 0, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getContent());
				pstmt.setString(3, bean.getSubject());
				//////////////////////////////////////
				pstmt.setInt(4, bean.getRef());//원글과 동일한ref(그룹)
				pstmt.setInt(5, bean.getPos()+1);//원글 pos+1(정렬)
				pstmt.setInt(6,bean.getDepth()+1);//원글 depth+1
				///////////////////////////////////
				pstmt.setString(7, bean.getPass());
				pstmt.setString(8, bean.getIp());
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			
		}*/
		//댓글리스트:검색기능,페이지 및 블럭처리
		//limit 시작번호,가져올 개수
		public Vector<CommentBean> getBoardList(String keyField, String keyWord, int start, int cnt){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<CommentBean> vlist=new Vector<CommentBean>();
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//검색이 아닌경우
					sql = "select * from comment order by ref desc,pos limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
				}
				else {
					sql = "select * from tblBoard where "+keyField+" like ? order by ref desc,pos limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					CommentBean bean = new CommentBean();
					bean.setCommentId(rs.getInt("commentId"));
					bean.setPostId(rs.getInt("postId"));
					bean.setUserEmail(rs.getString("userEmail"));
					bean.setCommentDetail(rs.getString("commentDetail"));
					bean.setCommentParrent(rs.getString("commentParent"));
					bean.setCommentChild(rs.getString("commentChild"));
					bean.setCommentDate(rs.getString("commentDate"));
					bean.setCommentCorrect(rs.getString("commentCorrect"));
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