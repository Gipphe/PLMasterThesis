interface Arg {
	boolean isGood(int x);
}

public class WithLambda {
	static boolean doStuff(Arg arg) {
		return arg.isGood(12);
	}

	public static void main(String[] args) {
		boolean res = doStuff(x -> x > 10);
		System.out.println(res);
	}
}
