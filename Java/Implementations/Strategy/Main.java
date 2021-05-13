public class Main {
	public static void main(String... args) {
		Crypt intersperse = new IntersperseCrypt("foo");
		Crypt reverse = new ReverseCrypt();
		Crypt rot = new RotCrypt(11);
		Crypt macro = new MacroCrypt(rot, intersperse, reverse);

		Encrypter encrypter = new Encrypter(intersperse);
		encrypter.printEncrypted("Mulligan");
		encrypter.setCrypt(reverse);
		encrypter.printEncrypted("Trireme");
		encrypter.setCrypt(rot);
		encrypter.printEncrypted("Basket");
		encrypter.setCrypt(macro);
		encrypter.printEncrypted("Aqua");
	}
}
