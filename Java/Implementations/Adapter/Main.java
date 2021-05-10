import java.util.*;

public class Main {
	public static void main(String... args) {
		Knife wk = new WoodenKnife();
		Knife sik = new SilverKnife();
		Knife stk = new SteelKnife();
		Fork wf = new WoodenFork();
		Fork sif = new SilverFork();
		Fork stf = new SteelFork();
		Fork waf = new KnifeForkAdapter(new WoodenKnife());
		Fork siaf = new KnifeForkAdapter(new SilverKnife());

		List<Pair<Client, String>> meals = new ArrayList<>();
		meals.add(new Pair<>(new Client(wf, wk), "beef"));
		meals.add(new Pair<>(new Client(waf, stk), "salad"));
		meals.add(new Pair<>(new Client(stf, sik), "sandwich"));
		meals.add(new Pair<>(new Client(sif, stk), "pizza"));
		meals.add(new Pair<>(new Client(siaf, wk), "bread"));

		StringJoiner sj = new StringJoiner("\n-----\n");

		for (Pair<Client, String> meal : meals) {
			Client client = meal.fst;
			String food = meal.snd;
			sj.add(client.eat(food));
		}

		System.out.println(sj);
	}
}

class Pair<A, B> {
	public final A fst;
	public final B snd;
	Pair(A a, B b) {
		this.fst = a;
		this.snd = b;
	}
}
