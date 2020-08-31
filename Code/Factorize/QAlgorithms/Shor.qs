namespace QAlgorithms.Shor
{
    open Microsoft.Quantum.Convert;
    open QTypes.QInteger;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    internal function SmallestPowExp2WithPowBiggerThan(ip : Int): Int
    {
        mutable rs = 1;
        mutable e = 0;
        while (rs <= ip)
        {
            set rs = rs * 2;
            set e = e + 1;
		}
        return e;
	}

    operation ShorOrderFinder(A : Int, Mod : Int) : Int
    {
        mutable res = 0;
        mutable rep = 0;
        repeat
        {
            let q = SmallestPowExp2WithPowBiggerThan(Mod * Mod);
            let n = SmallestPowExp2WithPowBiggerThan(Mod);
            using (qr = Qubit[q + n])
            {
                let inreg = QIntR(qr[0..q - 1]);
                let outreg = QIntR(qr[q..q + n - 1]);
                PrepareUniformSuperposition(inreg);
                ModExp(A, inreg, outreg, Mod);
                (Adjoint QFTQInt)(inreg);
                let tr = MeasureQInt(inreg);
                let dsc = MeasureQInt(outreg);
                mutable tp = 0;
                set (tp, res) = ApproximateFraction(tr, FastPow(2, q), Mod);
                ResetAll(qr);
                set rep = rep + 1;
                if (rep >= 50)
                {
                    fail "Too many repetitions for " + IntAsString(A) + "^? == 1 mod " + IntAsString(Mod) + ", last guess " + IntAsString(tr) + " / " + IntAsString(FastPow(2, q)) + " -> " + IntAsString(tp) + " / " + IntAsString(res) + ".";
				}
		    }
	    }
        until (FastPowMod(A, res, Mod) == 1 and res > 0);
        return res;
    }
}
