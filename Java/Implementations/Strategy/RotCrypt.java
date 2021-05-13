import java.util.*;

public class RotCrypt implements Crypt {
	private int rot;

	public RotCrypt(int rot) {
		this.rot = rot % 26;
	}

	public String encrypt(String in) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < in.length(); i += 1) {
			char orig = in.charAt(i);
			if (!Character.isLetter(orig)) {
				continue;
			}
			char shifted = (char) (orig + this.rot);
			if (
				(Character.isLowerCase(orig) && shifted > 'z')
				|| (Character.isUpperCase(orig) && shifted > 'Z')
			) {
				shifted = (char) (orig - (26 - this.rot));
			}
			sb.append(shifted);
		}
		return sb.toString();
	}
}
