public class Main {
	public static void main(String... args) {
		ThrusterPart weakThruster = new ThrusterPart(30);
		ThrusterPart strongThruster = new ThrusterPart(70);
		StructurePart normalStructure = new StructurePart(100);
		StructurePart strongStructure = new StructurePart(250);
		WindowPart window = new WindowPart(25);
		GunPart weakGun = new GunPart(10);
		GunPart strongGun = new GunPart(40);

		SpaceShip smallShip = new SpaceShip("Foo");
		smallShip
			.addPart(weakThruster)
			.addPart(weakThruster)
			.addPart(window)
			.addPart(weakGun)
			.addPart(weakGun);
		addN(10, normalStructure, smallShip);

		SpaceShip largeShip = new SpaceShip("Bar");
		largeShip
			.addPart(strongThruster)
			.addPart(strongThruster)
			.addPart(weakThruster)
			.addPart(weakThruster)
			.addPart(strongGun)
			.addPart(strongGun)
			.addPart(weakGun);
		addN(5, strongStructure, largeShip);
		addN(5, window, largeShip);
		addN(20, normalStructure, largeShip);

		System.out.println(smallShip.display() + "\n");
		System.out.println(largeShip.display());
	}

	public static void addN(int n, Part p, SpaceShip s) {
		for (int i = 0; i < n; i += 1) {
			s.addPart(p);
		}
	}
}
