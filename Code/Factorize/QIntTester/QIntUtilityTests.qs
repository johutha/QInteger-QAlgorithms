namespace Quantum.QIntTester.UtilityTester {
    open QTypes.QInteger;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    @Test("QuantumSimulator")
    operation ResetTest() : Unit
    {
        using (qr = Qubit[8])
        {
            let qn = QInt(8, qr);
            for (i in qr)
            {
                H(i);
			}
            ResetQInt(qn);
		}
        
        Message("Test passed.");
    }
    
    @Test("QuantumSimulator")
    operation CopyTest() : Unit
    {
        for (i in 0..255)
        {
            let ar = IntAsBoolArray(i, 8);
            using (qr = Qubit[8])
            {
                let qn = QInt(8, qr);
                CopyToQInt(i, qn);
                for (j in 0..7)
                {
                    AssertQubit(BoolAsResult(ar[j]), qn::Number[j]);
				}
                ResetAll(qr);
		    }
		}
        
        Message("Test passed.");
    }

    @Test("QuantumSimulator")
    operation ReadTest() : Unit
    {
        for (i in 0..255)
        {
            using (qr = Qubit[8])
            {
                let ba = IntAsBoolArray(i, 8);
                let qn = QInt(8, qr);
                for (j in 0..7)
                {
                    if (ba[j])
                    {
                        X(qr[j]);
					}
				}
                EqualityFactI(MeasureQInt(qn), i, "Wrong number returned");
                ResetAll(qr);
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation IncrementTest() : Unit
    {
        for (i in 0..255)
        {
            using (qr = Qubit[8])
            {
                let qn = QInt(8, qr);
                CopyToQInt(i, qn);
                Increment(qn);
                EqualityFactI(MeasureQInt(qn), (i + 1) % 256, "Wrong number returned");
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation DecrementTest() : Unit
    {
        for (i in 0..255)
        {
            using (qr = Qubit[8])
            {
                let qn = QInt(8, qr);
                CopyToQInt(i, qn);
                Decrement(qn);
                EqualityFactI(MeasureQInt(qn), (i + 255) % 256, "Wrong number returned");
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation EqualityTest() : Unit
    {
        for (i in 0..31)
        {
            for (j in 0..31)
            {
                using (qs = Qubit[11])
                {
                    let a = QInt(5, qs[0..4]);
                    let b = QInt(5, qs[5..9]);
                    let c = qs[10];
                    CopyToQInt(i, a);
                    CopyToQInt(j, b);
                    EqualsQQQ(a, b, c);
                    AssertQubit(BoolAsResult(i == j), c);
                    Reset(c);
                    EqualsCQQ(i, b, c);
                    AssertQubit(BoolAsResult(i == j), c);
                    Reset(c);
                    EqualityFactB(EqualsQQM(a, b), i == j, "Wrong result");
                    EqualityFactB(EqualsCQM(i, b), i == j, "Wrong result");
                    ResetAll(qs);
				}
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation IsZeroTest() : Unit
    {
        for (i in 0..1023)
        {
            using (qr = Qubit[11])
            {
                let qn = QInt(10, qr[0..9]);
                CopyToQInt(i, qn);
                IsZeroQInt(qn, qr[10]);
                AssertQubit(BoolAsResult(i == 0), qr[0]);
                ResetAll(qr);
			}
		}
        Message("Test passed.");
	}
}
