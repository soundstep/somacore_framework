package com.cafetownsend.vo {
	
	public class LoginVO {
		
		public var username:String;
		public var password:String;
		
		public function LoginVO(username:String = "", password:String = "") {
			this.username = username;
			this.password = password;
		}
		
		public function toString():String {
			return "[LoginVO] " + " username: " + username + ", password: " + password;
		}

	}
}