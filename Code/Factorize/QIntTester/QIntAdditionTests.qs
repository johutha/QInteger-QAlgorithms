namespace Quantum.QIntTester.AdditionTester {
    open QTypes.QInteger.Addition;
    open QTypes.QInteger;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    @Test("QuantumSimulator")
    operation Add3nWoOFCheckTest() : Unit
    {
        for (i in 0..7)
        {
            for (j in 0..7)
            {
                using (qs = Qubit[8])
                {
                    let a = QInt(4, qs[0..3]);
                    let b = QInt(4, qs[4..7]);
                    CopyToQInt(i, a);
                    CopyToQInt(j, b);
                    Add3nWoOFCheck(a, b);
                    let res = MeasureQInt(b);
                    EqualityFactI(res, i + j, "Addition returned wrong result: " + IntAsString(i + j) + " expected, returned " + IntAsString(res));
                    ResetAll(qs);
				}
			}
		}
        Message("Test passed.");
    }

    @Test("QuantumSimulator")
    operation Add3n1Pl1Check() : Unit
    {
        using (qr = Qubit[6])
        {
            let a = QInt(3, qr[0..2]);
            let b = QInt(3, qr[3..5]);
            CopyToQInt(1, a);
            CopyToQInt(1, b);
            Add3nWoOFCheck(a, b);
            let res = MeasureQInt(b);
            EqualityFactI(res, 2, "Wrong addition result");
            ResetAll(qr);
		}
        Message("Test passed.");
    }
}
