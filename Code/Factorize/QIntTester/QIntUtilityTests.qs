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
                AssertQubit(BoolAsResult(i == 0), qr[10]);
                ResetAll(qr);
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation DiffSizeEqualityTest() : Unit
    {
        for (i in 0..3)
        {
            for (j in 0..3)
            {
                for (a in 0..PowI(2, i) - 1)
                {
                    for (b in 0..PowI(2, j) - 1)
                    {
                        using (qr = Qubit[i + j + 1])
                        {
                            let qa = QIntVS(qr[0..i - 1], i, a);
                            let qb = QIntVS(qr[i..i + j - 1], j, b);
                            let c = qr[i + j];
                            EqualsQQQ(qa, qb, c);
                            AssertQubit(BoolAsResult(a == b), c);
                            Reset(c);
                            EqualsCQQ(a, qb, c);
                            AssertQubit(BoolAsResult(a == b), c);
                            Reset(c);
                            EqualityFactB(EqualsCQM(a, qb), a == b, "Wrong result in CQM");
                            EqualityFactB(EqualsQQM(qa, qb), a == b, "Wrong result in QQM");
                            ResetAll(qr);
						}
					}
				}
			}
		}
        Message("Test passed.");
	}

    @Test("QuantumSimulator")
    operation CompTest() : Unit
    {
        for (i in 0..15)
        {
            for (j in 0..15)
            {
                using (qs = Qubit[9])
                {
                    let a = QInt(4, qs[0..3]);
                    let b = QInt(4, qs[4..7]);
                    let c = qs[8];
                    CopyToQInt(i, a);
                    CopyToQInt(j, b);
                    GreaterThan(a, b, c);
                    AssertQubit(BoolAsResult(i > j), c);
                    Reset(c);
                    LessThan(a, b, c);
                    AssertQubit(BoolAsResult(i < j), c);
                    Reset(c);
                    GreaterOrEq(a, b, c);
                    AssertQubit(BoolAsResult(i >= j), c);
                    Reset(c);
                    LessOrEq(a, b, c);
                    AssertQubit(BoolAsResult(i <= j), c);
                    Reset(c);
                    ResetAll(qs);
				}
			}
		}
        Message("Test passed.");
	}
}
