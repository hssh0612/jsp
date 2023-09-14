package logon;

import java.sql.Timestamp;

public class LogonDataBean {


		private String id;
		private String pwd;
		private String name;
		private int age;
		private Timestamp regDate;
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getPwd() {
			return pwd;
		}
		public void setPwd(String pwd) {
			this.pwd = pwd;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
		public Timestamp getRegDate() {
			return regDate;
		}
		public void setRegDate(Timestamp regDate) {
			this.regDate = regDate;
		}
}


