let
	a = {
		exec-once = [ "wow" ];
	};

	b = {
		exec-once = [ "bruh" ];
	};

	c = a // b;
in {
	}
