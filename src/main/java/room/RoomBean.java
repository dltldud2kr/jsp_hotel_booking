package room;

import java.sql.Date;

public class RoomBean {
	private int room_idx;
	private int mem_idx;
	private String room_title;
	private int room_kind;
	private int room_people;
	private String room_detail;
	private String room_area;
	private String room_guide;
	private String room_map;
	private int room_price;
	private Date created_at;
	private int room_num;
	
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public int getMem_idx() {
		return mem_idx;
	}
	public void setMem_idx(int mem_idx) {
		this.mem_idx = mem_idx;
	}
	public String getRoom_title() {
		return room_title;
	}
	public void setRoom_title(String room_title) {
		this.room_title = room_title;
	}
	public int getRoom_kind() {
		return room_kind;
	}
	public void setRoom_kind(int room_kind) {
		this.room_kind = room_kind;
	}
	public int getRoom_people() {
		return room_people;
	}
	public void setRoom_people(int room_people) {
		this.room_people = room_people;
	}
	public String getRoom_detail() {
		return room_detail;
	}
	public void setRoom_detail(String room_detail) {
		this.room_detail = room_detail;
	}
	public String getRoom_area() {
		return room_area;
	}
	public void setRoom_area(String room_area) {
		this.room_area = room_area;
	}
	public String getRoom_guide() {
		return room_guide;
	}
	public void setRoom_guide(String room_guide) {
		this.room_guide = room_guide;
	}
	public String getRoom_map() {
		return room_map;
	}
	public void setRoom_map(String room_map) {
		this.room_map = room_map;
	}
	public int getRoom_price() {
		return room_price;
	}
	public void setRoom_price(int room_price) {
		this.room_price = room_price;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
}
