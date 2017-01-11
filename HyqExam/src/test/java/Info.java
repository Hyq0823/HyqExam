
class Info {
		private String info1;
		private String info2;
		private Family family;
		
		
		
		public Family getFamily() {
			return family;
		}
		public void setFamily(Family family) {
			this.family = family;
		}
		public String getInfo1() {
			return info1;
		}
		public void setInfo1(String info1) {
			this.info1 = info1;
		}
		public String getInfo2() {
			return info2;
		}
		public void setInfo2(String info2) {
			this.info2 = info2;
		}
		@Override
		public String toString() {
			return "Info [info1=" + info1 + ", info2=" + info2 + ", family=" + family.toString() + "]";
		}
		
		
	}