package review;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class ReviewDAO {
    private Connection conn;
    private ResultSet rs;

    // 생성자: 데이터베이스 연결
    public ReviewDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/jsp_project?useUnicode=true&characterEncoding=utf-8";
            String dbID = "root";
            String dbPassword = "1234";
            
            // JDBC 드라이버 로드하고 데이터베이스에 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 데이터베이스 연결 객체 반환
    public Connection getConnection() {
        return conn;
    }

    // 데이터베이스로부터 현재 날짜 및 시간 가져오기
    public String getCurrentDateFromDB() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Error";
    }

    // 다음 리뷰의 인덱스 가져오기
    public int getNext() {
        String SQL = "SELECT review_idx FROM review ORDER BY review_idx DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }

    // 리뷰 작성 메서드
    public int write(int mem_idx, int room_idx, String review_title, String review_cmt) {
        String SQL = "INSERT INTO review (mem_idx, room_idx, review_title, review_cmt, created_at) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, mem_idx);
            pstmt.setInt(2, room_idx);
            pstmt.setString(3, review_title);
            pstmt.setString(4, review_cmt);
            pstmt.setString(5, getCurrentDateFromDB());
            pstmt.executeUpdate();
            return getNext();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 리뷰 업데이트 메서드
    public int update(int review_idx, String review_title, String review_cmt) {
        String SQL = "UPDATE review SET review_title = ?, review_cmt = ? WHERE review_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, review_title);
            pstmt.setString(2, review_cmt);
            pstmt.setInt(3, review_idx);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 리뷰 삭제 메서드
    public int delete(int review_idx) {
        String SQL = "DELETE FROM review WHERE review_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, review_idx);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 특정 리뷰 검색 메서드
    public Review getReview(int review_idx) {
        String SQL = "SELECT * FROM review WHERE review_idx = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, review_idx);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReview_idx(rs.getInt("review_idx"));
                review.setMem_idx(rs.getInt("mem_idx"));
                review.setRoom_idx(rs.getInt("room_idx"));
                review.setReview_title(rs.getString("review_title"));
                review.setReview_cmt(rs.getString("review_cmt"));
                
                // 추가 부분: 리뷰 작성 날짜
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    review.setCreated_at(new Date(timestamp.getTime()));
                }
                return review;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 가장 최근 리뷰 3개 가져오기
    public ArrayList<Review> getMostRecentReviews(int count) {
        String SQL = "SELECT * FROM review ORDER BY created_at DESC LIMIT ?";
        ArrayList<Review> list = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            pstmt.setInt(1, count);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = extractReviewFromResultSet(rs);
                    list.add(review);
                }
            }

        } catch (SQLException e) {
            handleSQLException(e);
        }

        return list;
    }

    // ResultSet으로부터 리뷰 추출 메서드
    private Review extractReviewFromResultSet(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReview_idx(rs.getInt("review_idx"));
        review.setMem_idx(rs.getInt("mem_idx"));
        review.setRoom_idx(rs.getInt("room_idx"));
        review.setReview_title(rs.getString("review_title"));
        review.setReview_cmt(rs.getString("review_cmt"));

        // 추가 부분: 리뷰 작성 날짜
        Timestamp timestamp = rs.getTimestamp("created_at");
        if (timestamp != null) {
            review.setCreated_at(new Date(timestamp.getTime()));
        }

        return review;
    }

    // SQLException 처리 메서드
    private void handleSQLException(SQLException e) {
        // SQLException 처리: 로그 출력 또는 적절한 방법으로 처리
        e.printStackTrace();
    }

    // 모든 리뷰 목록 가져오기
    public ArrayList<Review> getAllReviews() {
        String SQL = "SELECT * FROM review ORDER BY created_at DESC";
        ArrayList<Review> list = new ArrayList<>();

        try {
            // 연결이 유효하고 닫혀 있지 않은지 확인
            if (conn != null && !conn.isClosed()) {
                // 리소스 관리를 위해 try-with-resources 사용
                try (PreparedStatement pstmt = conn.prepareStatement(SQL);
                     ResultSet rs = pstmt.executeQuery()) {

                    // ResultSet의 각 열에서 데이터를 추출하고 Review 객체에 설정
                    while (rs.next()) {
                        Review review = extractReviewFromResultSet(rs);
                        list.add(review);
                    }
                }
            } else {
                // 연결이 유효하지 않거나 닫혔을 때 처리
                System.err.println("Connection is invalid or closed");
            }
        } catch (SQLException e) {
            // SQLException 처리: 로그 출력 또는 적절한 방법으로 처리
            e.printStackTrace();
        }

        // 리뷰 목록 반환
        return list;
    }

    // 데이터베이스 연결 닫기
    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}