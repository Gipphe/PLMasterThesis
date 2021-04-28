import java.util.*;

public final class Utils {
	private Utils() {}

	public static String indent(String s) {
		String[] parts = s.split("\n");
		StringJoiner sj = new StringJoiner("\n");
		for (String part : parts) {
			sj.add("  " + part);
		}
		return sj.toString();
	}

	public static String indentAfterFirst(String s) {
		String[] parts = s.split("\n");
		StringJoiner sj = new StringJoiner("\n");
		sj.add(parts[0]);
		for (int i = 1; i < parts.length; i += 1) {
			sj.add("  " + parts[i]);
		}
		return sj.toString();
	}

	public static StringJoiner componentStringJoiner() {
		return new StringJoiner("\n, ", "{ ", "\n}");
	}

	public static StringJoiner collectionStringJoiner() {
		return new StringJoiner("\n, ", "[ ", "\n]");
	}
}
