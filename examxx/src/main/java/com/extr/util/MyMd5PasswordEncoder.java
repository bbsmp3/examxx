package com.extr.util;

import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class MyMd5PasswordEncoder extends MessageDigestPasswordEncoder implements PasswordEncoder{
	public MyMd5PasswordEncoder() {
        super("MD5");
    }
	
	public String encode(CharSequence rwPassword) {
		return super.encodePassword((String) rwPassword, null).substring(8, 24);
	}
	
	public boolean matches(CharSequence rwPassword, String password) {
		// TODO Auto-generated method stub
		return rwPassword.equals(password) ? true : false;
	}
	
	 /**
     * Takes a previously encoded password and compares it with a rawpassword after mixing in the salt and
     * encoding that value
     *
     * @param encPass previously encoded password
     * @param rawPass plain text password
     * @param salt salt to mix into password
     * @return true or false
     */
    public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
        String pass1 = "" + encPass;
        String pass2 = super.encodePassword((String) rawPass, null).substring(8, 24);

        return pass1.equals(pass2);
    }
}

