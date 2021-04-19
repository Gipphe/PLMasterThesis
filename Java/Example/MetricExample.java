// Example code used to explain the metrics used
// in this thesis.


interface Speaker {
	public void speak();
}

abstract class SpeaksWithSound implements Speaker {
	protected String sound;

	protected SpeaksWithSound(String sound) {
		this.sound = sound;
	}

	public void speak() {
		System.out.println(this.sound);
	}
}

class Dog extends SpeaksWithSound {
	public Dog() {
		super("Woof");
	}
}

class Wolf extends SpeaksWithSound {
	public Wolf() {
		super("Awoo");
	}
}

class Cat implements Speaker {
	private static final String SMALL_SOUND = "Meow";
	private static final String BIG_SOUND = "Rawr";
	private int size;

	public Cat (int size) {
		this.size = size;
	}

	public void speak() {
		if (size > 2) {
			System.out.println(BIG_SOUND);
		} else {
			System.out.println(SMALL_SOUND);
		}
	}
}


class MetricExample {
	public static void main(String... args) {
		Speaker[] zoo = new Speaker[] {
			new Cat(1),
			new Cat(3),
			new Dog(),
			new Wolf()
		};

		for (Speaker animal : zoo) {
			animal.speak();
		}
	}
}
