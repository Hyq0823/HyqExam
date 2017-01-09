import java.util.List;


public class User {
		private String test;
		private String name;
		private int age;
		private boolean Marryed;
		
		private String birth;
		private List<Info> list;
		
		
		
		public String getTest() {
			return test;
		}
		public void setTest(String test) {
			this.test = test;
		}
		public boolean isMarryed() {
			return Marryed;
		}
		public void setMarryed(boolean marryed) {
			Marryed = marryed;
		}
		
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
	
		public String getBirth() {
			return birth;
		}
		public void setBirth(String birth) {
			this.birth = birth;
		}
		public List<Info> getList() {
			return list;
		}
		public void setList(List<Info> list) {
			this.list = list;
		}
		@Override
		public String toString() {
			
			
			return "User [name=" + name + ", age=" + age + ", Marryed=" + Marryed + ", birth=" + birth + ", list="
					+ list + "]"
					;
			
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		
		
		
	}
