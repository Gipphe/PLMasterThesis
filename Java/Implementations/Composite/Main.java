public class Main {
	public static void main(String... args) {
		Chassis computer = new Chassis("Cheap chassis", 350);
		Motherboard mb = new Motherboard("Decent motherboard", 1100);
		mb.add(new RAM("Expensive RAM", 1400, (long) 4e12));
		mb.add(new CPU("Good CPU", 2000, "3 GHz"));
		computer.add(new CDROM("Cheap CDROM", 150));
		computer.add(mb);

		System.out.println(computer.display());
	}
}
