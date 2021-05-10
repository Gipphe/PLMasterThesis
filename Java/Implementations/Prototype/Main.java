public class Main {
	public static void main(String... args) {
		SpaceShip ss = new SpaceShip();

		ThrusterPart tp = new ThrusterPart(30);
		StructurePart sp = new StructurePart();
		WindowPart wp = new WindowPart(50);
		GunPart gp = new GunPart(10);

		ss
			.addPart(tp)
			.addPart(tp)
			.addPart(wp)
			.addPart(gp);

		for (int i = 0; i < 10; i += 1) {
			ss.addPart(sp);
		}

		System.out.println(ss.display());
	}
}
