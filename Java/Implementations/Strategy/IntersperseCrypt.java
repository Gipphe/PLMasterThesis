import java.util.*;

public class IntersperseCrypt implements Crypt {
	private String str;

	public IntersperseCrypt(String str) {
		this.str = str;
	}

	public String encrypt(String in) {
		char[] cs = in.toCharArray();
		StringJoiner sj = new StringJoiner(this.str);
		for (char c : cs) {
			sj.add(String.valueOf(c));
		}
		return sj.toString();
	}
}
