package reply;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class ReplyDAO {
    private Connection conn; // db와 연결하는 객체
    private ResultSet rs;

    // 생성자 (Constructor)
    public ReplyDAO() {
        try {
            // DB 연결 정보
            String dbURL = "jdbc:mysql://localhost:3306/jsp_project?useSSL=false";
            String dbID = "root";
            String dbPassword = "1234!";
            
            // JDBC 드라이버 로드 및 연결
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 현재 날짜 및 시간을 가져오는 메서드
    public String getDate() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // 다음 댓글의 인덱스를 가져오는 메서드
    public int getNext() {
        String SQL = "SELECT reply_idx FROM reply ORDER BY reply_idx DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1;
    }

    // 댓글 작성 메서드
    public int write(int review_idx, String reply_cmt, String mem_name) {
        String SQL = "INSERT INTO reply VALUES(?, ?, ?, ?, NOW())";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setInt(2, review_idx);
            pstmt.setString(3, reply_cmt);
            pstmt.setString(4, mem_name);
            pstmt.executeUpdate();
            return getNext();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 특정 댓글의 내용을 가져오는 메서드
    public String getUpdateReply(int reply_idx) {
        String SQL = "SELECT reply_cmt FROM reply WHERE reply_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, reply_idx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // 특정 리뷰에 속하는 댓글 리스트를 가져오는 메서드
    public ArrayList<Reply> getList(int review_idx) {
        String SQL = "SELECT r.*, m.mem_name FROM reply r " +
                     "JOIN member m ON r.mem_idx = m.mem_idx " +
                     "WHERE r.review_idx = ? ORDER BY r.review_idx DESC";

        ArrayList<Reply> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, review_idx);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Reply reply = new Reply();
                reply.setReply_idx(rs.getInt("reply_idx"));
                reply.setMem_idx(rs.getInt("mem_idx"));
                reply.setReview_idx(rs.getInt("review_idx"));
                reply.setReply_cmt(rs.getString("reply_cmt"));
                reply.setMem_name(rs.getString("mem_name"));
                
                // 추가된 부분: 댓글 작성 일자
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    reply.setCreated_at(new Date(timestamp.getTime()));
                }

                list.add(reply);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 댓글 업데이트 메서드
    public int update(int reply_idx, String reply_cmt) {
        String SQL = "UPDATE reply SET reply_cmt = ? WHERE reply_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reply_cmt);
            pstmt.setInt(2, reply_idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 특정 댓글을 가져오는 메서드
    public Reply getReply(int reply_idx) {
        String SQL = "SELECT * FROM reply WHERE reply_idx = ? ORDER BY reply_idx DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, reply_idx);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Reply reply = new Reply();
                reply.setReply_idx(rs.getInt(1));
                reply.setMem_idx(rs.getInt(2));
                reply.setReview_idx(rs.getInt(3));
                reply.setReply_cmt(rs.getString(4));
                reply.setMem_name(rs.getString(5));
                reply.setCreated_at(rs.getDate("created_at"));
                return reply;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 댓글 삭제 메서드
    public int delete(int reply_idx) {
        String SQL = "DELETE FROM reply WHERE reply_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, reply_idx);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
