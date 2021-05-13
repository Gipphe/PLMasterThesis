import java.util.*;

public class ReverseCrypt implements Crypt {
	public String encrypt(String in) {
		return new StringBuilder(in).reverse().toString();
	}
}
