import java.lang.Math;

public class Utils {
	private Utils() {}

	public static double roundTo(double x, int digits) {
		return (Math.round(x * Math.pow(10, digits)) / Math.pow(10, digits));
	}
}
