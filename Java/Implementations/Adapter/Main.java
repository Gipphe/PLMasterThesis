import java.util.StringJoiner;

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

		Meal[] meals = new Meal[] {
			new Meal(wf, wk, "beef"),
			new Meal(waf, stk, "salad"),
			new Meal(stf, sik, "sandwich"),
			new Meal(sif, stk, "pizza"),
			new Meal(siaf, wk, "bread")
		};

		StringJoiner sj = new StringJoiner("\n-----\n");

		for (Meal meal : meals) {
			sj.add(eat(meal));
		}

		System.out.println(sj);
	}

	public static String eat(Meal meal) {
		return meal.knife.cutFood(meal.food)
			+ "\n" + meal.fork.stabFood(meal.food)
			+ "\nNom";
	}
}

class Meal {
	public final Fork fork;
	public final Knife knife;
	public final String food;
	public Meal(Fork fork, Knife knife, String food) {
		this.fork = fork;
		this.knife = knife;
		this.food = food;
	}
}
