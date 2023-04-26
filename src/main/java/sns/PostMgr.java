package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class PostMgr {
	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/ch19/photo/";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 20*1024*1024;
	public PostMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//하트 카운트
	public void upHCnt(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update post set likeNum=likeNum+1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	//게시물 신고 누적증가
	public void upReport(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			con = pool.getConnection();
			sql = "update post set postReport=postReport+1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
	}
	//게시물 만들기
	public void insertPost(HttpServletRequest req) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		MultipartRequest multi=null;
		try {
			con = pool.getConnection();
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			
			String photo = null;
			if (multi.getFilesystemName("photo") != null) {
				photo = multi.getFilesystemName("photo");
			}
			sql = "insert post(userEmail,likeNum,imageName,videoName,shareNum,commentNum,creationDate,postReport)values(?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("userEmail"));
			pstmt.setInt(2, 0);
			pstmt.setString(3, photo);
			pstmt.setString(4, null);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
	}
	//freind의 게시물리스트
		public PostBean friendimage(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			PostBean bean=new PostBean();
			try {
				con = pool.getConnection();
				sql = "select * from post where userEmail=? order by postId desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					bean.setPostId(rs.getInt(1));
					bean.setUserEmail(rs.getString(2));
					bean.setLikeNum(rs.getInt(3));
					bean.setImageName(rs.getString(4));
					bean.setVideoName(rs.getString(5));
					bean.setShareNum(rs.getInt(6));
					bean.setCommentNum(rs.getInt(7));
					bean.setCreationDate(rs.getString(8));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	//본인을 제외한 게시물리스트
	public PostBean listPBlog(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean=new PostBean();
		try {
			con = pool.getConnection();
			sql = "select * from post where userEmail!=? order by postId desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setImageName(rs.getString(4));
				bean.setVideoName(rs.getString(5));
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));
				bean.setCreationDate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//프렌드 이메일의 image가져오기
	public PostBean postImage(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean=new PostBean();
		try {
			con = pool.getConnection();
			sql = "select * from post where userEmail=? order by postId desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			System.out.println(email);
			while (rs.next()) {
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setImageName(rs.getString(4));
				bean.setVideoName(rs.getString(5));
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));
				bean.setCreationDate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
}
