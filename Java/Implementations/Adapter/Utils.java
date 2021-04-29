public class Utils {
	private Utils() {}

	public static String sentenceCase(String x) {
		return x.substring(0, 1).toUpperCase() + x.substring(1);
	}
}
