import java.util.function.Predicate;

public class PredicateExample {
	static boolean doStuff(Predicate<Integer> pred) {
		return pred.test(12);
	}

	public static void main(String[] args) {
		boolean res = doStuff((x) -> x > 10);
		System.out.println(res);
	}
}
