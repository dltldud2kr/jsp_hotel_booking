package reply;

import java.sql.Date;

public class Reply {
    private int reply_idx;     // 댓글의 고유 인덱스
    private int mem_idx;       // 회원의 고유 인덱스
    private int review_idx;    // 리뷰의 고유 인덱스
    private String reply_cmt;  // 댓글 내용
    private String mem_name;   // 회원 이름
    private Date created_at;   // 댓글 작성일

    // Getter 및 Setter 메서드들
    public int getReply_idx() {
        return reply_idx;
    }

    public void setReply_idx(int reply_idx) {
        this.reply_idx = reply_idx;
    }

    public int getMem_idx() {
        return mem_idx;
    }

    public void setMem_idx(int mem_idx) {
        this.mem_idx = mem_idx;
    }

    public int getReview_idx() {
        return review_idx;
    }

    public void setReview_idx(int review_idx) {
        this.review_idx = review_idx;
    }

    public String getReply_cmt() {
        return reply_cmt;
    }

    public void setReply_cmt(String reply_cmt) {
        this.reply_cmt = reply_cmt;
    }

    public String getMem_name() {
        return mem_name;
    }

    public void setMem_name(String mem_name) {
        this.mem_name = mem_name;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }
}
