namespace Quantum.QIntTester.AdditionTester
{
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
					__NotWorking_Add3nWoOFCheck(a, b);
					let res = MeasureQInt(b);
					EqualityFactI(res, i + j, "Addition returned wrong result: " + IntAsString(i + j) + " expected, returned " + IntAsString(res));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}

	@Test("QuantumSimulator")
	operation Add2nQFTTest() : Unit
	{
		for (i in 0..31)
		{
			for (j in 0..31)
			{
				using (qs = Qubit[10])
				{
					let a = QInt(5, qs[0..4]);
					let b = QInt(5, qs[5..9]);
					CopyToQInt(i, a);
					CopyToQInt(j, b);
					Add2nQFT(a, b);
					let res = MeasureQInt(b);
					EqualityFactI(res, (i + j) % PowI(2, 5), "Addition returned wrong result: " + IntAsString(i + j) + " expected, returned " + IntAsString(res));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}

	@Test("QuantumSimulator")
	operation Subtract2nQFTTest() : Unit
	{
		for (i in 0..15)
		{
			for (j in 0..15)
			{
				using (qs = Qubit[8])
				{
					let a = QInt(4, qs[0..3]);
					let b = QInt(4, qs[4..7]);
					CopyToQInt(i, a);
					CopyToQInt(j, b);
					(Adjoint Add2nQFT)(a, b);
					let res = MeasureQInt(b);
					EqualityFactI(res, (j - i + PowI(2, 4)) % PowI(2, 4), "Addition returned wrong result: " + IntAsString((j - i + PowI(2, 4)) % PowI(2, 4)) + " expected, returned " + IntAsString(res));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}

	@Test("QuantumSimulator")
	operation Add2nQFTCQTest() : Unit
	{
		for (i in 0..31)
		{
			for (j in 0..31)
			{
				using (qs = Qubit[5])
				{
					let b = QInt(5, qs[0..4]);
					CopyToQInt(j, b);
					Add2nQFTCQ(i, b);
					let res = MeasureQInt(b);
					EqualityFactI(res, (i + j) % PowI(2, 5), "Addition returned wrong result: " + IntAsString((i + j) % PowI(2, 5)) + " expected, returned " + IntAsString(res));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}

	@Test("QuantumSimulator")
	operation Subtract2nQFTCQTest() : Unit
	{
		for (i in 0..31)
		{
			for (j in 0..31)
			{
				using (qs = Qubit[5])
				{
					let b = QInt(5, qs[0..4]);
					CopyToQInt(j, b);
					(Adjoint Add2nQFTCQ)(i, b);
					let res = MeasureQInt(b);
					EqualityFactI(res, (j - i + PowI(2, 5)) % PowI(2, 5), "Addition returned wrong result: " + IntAsString((j - i + PowI(2, 5)) % PowI(2, 5)) + " expected, returned " + IntAsString(res));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}

	@Test("QuantumSimulator")
	operation Add2nQFTOverFlowBitTest() : Unit
	{
		for (i in 0..15)
		{
			for (j in 0..15)
			{
				using (qs = Qubit[11])
				{
					let a = QInt(5, qs[0..4]);
					let b = QInt(5, qs[5..9]);
					let c = qs[10];
					CopyToQInt(i, a);
					CopyToQInt(j, b);
					within
					{
						(Adjoint Add2nQFT)(a, b);
					}
					apply
					{
						CNOT(b::Number[b::Size - 1], c);
					}
					let res = ResultAsBool(M(c));
					EqualityFactB(res, (i > j), "Wrong answer for " + IntAsString(i) + " >? " + IntAsString(j));
					ResetAll(qs);
				}
			}
		}
		Message("Test passed.");
	}
}
