package review;

import java.util.Date;

public class Review {
    private int review_idx;    // 리뷰 인덱스
    private int mem_idx;       // 회원 ID
    private int room_idx;      // 객실 ID
    private String review_title;  // 리뷰 제목
    private String review_cmt;    // 리뷰 내용
    private Date created_at;      // 리뷰 생성일

    // 생성자, getter 및 setter 메서드

    /**
     * 기본 생성자
     */
    public Review() {
    }

    /**
     * 전체 속성을 가지는 생성자
     * 
     * @param review_idx   리뷰 인덱스
     * @param mem_idx      회원 ID
     * @param room_idx     객실 ID
     * @param review_title 리뷰 제목
     * @param review_cmt   리뷰 내용
     * @param created_at   리뷰 생성일
     */
    public Review(int mem_idx, int room_idx, String review_title,
            String review_cmt) {
        this.mem_idx = mem_idx;
        this.room_idx = room_idx;
        this.review_title = review_title;
        this.review_cmt = review_cmt;
    }

    // Getter 및 Setter 메서드

    /**
     * 리뷰 인덱스를 반환합니다.
     * 
     * @return 리뷰 인덱스
     */
    public int getReview_idx() {
        return review_idx;
    }

    /**
     * 리뷰 인덱스를 설정합니다.
     * 
     * @param review_idx 리뷰 인덱스
     */
    public void setReview_idx(int review_idx) {
        this.review_idx = review_idx;
    }

    /**
     * 회원 ID를 반환합니다.
     * 
     * @return 회원 ID
     */
    public int getMem_idx() {
        return mem_idx;
    }

    /**
     * 회원 ID를 설정합니다.
     * 
     * @param mem_idx 회원 ID
     */
    public void setMem_idx(int mem_idx) {
        this.mem_idx = mem_idx;
    }

    /**
     * 객실 ID를 반환합니다.
     * 
     * @return 객실 ID
     */
    public int getRoom_idx() {
        return room_idx;
    }

    /**
     * 객실 ID를 설정합니다.
     * 
     * @param room_idx 객실 ID
     */
    public void setRoom_idx(int room_idx) {
        this.room_idx = room_idx;
    }

    /**
     * 리뷰 제목을 반환합니다.
     * 
     * @return 리뷰 제목
     */
    public String getReview_title() {
        return review_title;
    }

    /**
     * 리뷰 제목을 설정합니다.
     * 
     * @param review_title 리뷰 제목
     */
    public void setReview_title(String review_title) {
        this.review_title = review_title;
    }

    /**
     * 리뷰 내용을 반환합니다.
     * 
     * @return 리뷰 내용
     */
    public String getReview_cmt() {
        return review_cmt;
    }

    /**
     * 리뷰 내용을 설정합니다.
     * 
     * @param review_cmt 리뷰 내용
     */
    public void setReview_cmt(String review_cmt) {
        this.review_cmt = review_cmt;
    }

    /**
     * 리뷰 생성일을 반환합니다.
     * 
     * @return 리뷰 생성일
     */
    public Date getCreated_at() {
        return created_at;
    }

    /**
     * 리뷰 생성일을 설정합니다.
     * 
     * @param created_at 리뷰 생성일
     */
    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }
}
