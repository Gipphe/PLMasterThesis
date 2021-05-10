class Main {
	private CutleryFactory cutleryFactory;
	private Knife knife;
	private Fork fork;

	public Main(String type) {
		if (type.equals("primitive")) {
			this.cutleryFactory = new PrimitiveCutleryFactory();
		} else if (type.equals("silver")) {
			this.cutleryFactory = new SilverwareCutleryFactory();
		} else {
			System.out.println("Unrecognized cutlery type: " + type);
			System.exit(1);
		}
	}

	public void makeCutlery() {
		this.knife = this.cutleryFactory.makeKnife();
		this.fork = this.cutleryFactory.makeFork();
	}

	public void eat(String food) {
		this.fork.stickFood(food);
		this.knife.cutFood(food);
	}

	public static void main(String... args) {
		Main m = new Main("primitive");
		m.makeCutlery();
		m.eat("sausage");

		System.out.println("-----");

		Main n = new Main("silver");
		n.makeCutlery();
		n.eat("salad");
	}
}
