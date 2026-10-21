
package com.motoverse.util;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {

	private static final int ITERATIONS = 210000;
	private static final int SALT_LENGTH = 16;
	private static final int KEY_LENGTH = 256;

	public static String hashPassword(String password) {
		byte[] salt = new byte[SALT_LENGTH];
		new SecureRandom().nextBytes(salt);

		byte[] hash = deriveKey(password.toCharArray(), salt, ITERATIONS);

		return "pbkdf2$" + ITERATIONS + "$" + Base64.getEncoder().encodeToString(salt) + "$"
				+ Base64.getEncoder().encodeToString(hash);
	}

	public static boolean verifyPassword(String password, String storedHash) {
		try {
			String[] parts = storedHash.split("\\$");

			if (parts.length != 4 || !"pbkdf2".equals(parts[0])) {
				return false;
			}

			int iterations = Integer.parseInt(parts[1]);
			byte[] salt = Base64.getDecoder().decode(parts[2]);
			byte[] expectedHash = Base64.getDecoder().decode(parts[3]);

			byte[] actualHash = deriveKey(password.toCharArray(), salt, iterations);

			return MessageDigest.isEqual(expectedHash, actualHash);

		} catch (Exception e) {
			return false;
		}
	}

	private static byte[] deriveKey(char[] password, byte[] salt, int iterations) {
		PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, KEY_LENGTH);

		try {
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

			return factory.generateSecret(spec).getEncoded();

		} catch (Exception e) {
			throw new IllegalStateException("Password hashing failed.", e);

		} finally {
			spec.clearPassword();
		}
	}
}
