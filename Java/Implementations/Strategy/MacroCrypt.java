import java.util.*;

public class MacroCrypt implements Crypt {
	private List<Crypt> crypts = new ArrayList<>();

	public MacroCrypt(Crypt... crypts) {
		for (Crypt c : crypts) {
			this.crypts.add(c);
		}
	}

	public String encrypt(String in) {
		for (Crypt crypt : crypts) {
			in = crypt.encrypt(in);
		}
		return in;
	}
}
