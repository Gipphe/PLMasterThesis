interface Arg {
	boolean isGood(int x);
}

public class WithoutLambda {
	static boolean doStuff(Arg arg) {
		return arg.isGood(12);
	}

	public static void main(String[] args) {
		boolean res = doStuff(new Arg() {
			public boolean isGood(int x) {
				return x > 10;
			}
		});
		System.out.println(res);
	}
}
