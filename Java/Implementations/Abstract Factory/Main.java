abstract class CutleryFactory {
	public abstract Fork makeFork();
	public abstract Knife makeKnife();
}

abstract class Fork {
	protected int numberOfProngs;
	protected int length;

	protected Fork(int numberOfProngs, int length) {
		this.numberOfProngs = numberOfProngs;
		this.length = length;
	}

	public int numberOfProngs() {
		return this.numberOfProngs;
	}

	public int length() {
		return this.length;
	}

	public abstract void stickFood(String food);
}

abstract class Knife {
	protected boolean isDoubleEdged;
	protected int weight;

	protected Knife(boolean isDoubleEdged, int weight) {
		this.isDoubleEdged = isDoubleEdged;
		this.weight = weight;
	}

	public boolean isDoubleEdged() {
		return this.isDoubleEdged;
	}

	public int weight() {
		return this.weight;
	}

	public abstract void cutFood(String food);
}

/**
 * The finest cutlery you can find.
 */
class SilverwareCutleryFactory extends CutleryFactory {
	public Fork makeFork() {
		return new SilverwareFork();
	}

	public Knife makeKnife() {
		return new SilverwareKnife();
	}
}

/**
 * The finest fork you can find.
 */
class SilverwareFork extends Fork {
	public SilverwareFork() {
		super(3, 30);
	}

	public void stickFood(String food) {
		System.out.println(
			"You stick the fork gently and elegantly into the "
			+ food
			+ "."
		);
	}
}

/**
 * The finest knife you can find.
 */
class SilverwareKnife extends Knife {
	public SilverwareKnife() {
		super(false, 240);
	}

	public void cutFood(String food) {
		System.out.println(
			"The "
			+ food
			+ " slices easily, and with finesse."
		);
	}
}

/**
 * Cutlery from mother nature.
 */
class PrimitiveCutleryFactory extends CutleryFactory {
	public Fork makeFork() {
		return new PrimitiveFork();
	}

	public Knife makeKnife() {
		return new PrimitiveKnife();
	}
}

/**
 * A pointy stick.
 */
class PrimitiveFork extends Fork {
	public PrimitiveFork() {
		super(1, 25);
	}

	public void stickFood(String food) {
		System.out.println(
			"You force the stick into the "
			+ food
			+ ", mildly squishing the "
			+ food
			+ " in the process."
		);
	}
}

/**
 * A sharp rock.
 */
class PrimitiveKnife extends Knife {
	public PrimitiveKnife() {
		super(true, 110);
	}

	public void cutFood(String food) {
		System.out.println(
			"You attempt to cut the "
			+ food
			+ ", but you instead end up clumsily crushing it."
		);
	}
}

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
		if (args.length < 1) {
			System.out.println("Usage: java Main primitive|silver");
		} else {
			Main m = new Main(args[0]);
			m.makeCutlery();
			m.eat("sausage");
		}
	}
}
