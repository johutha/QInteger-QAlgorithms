namespace Quantum.Factorize {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    
    operation QuantumFactor (x : Int) : Int {
        
        return 0;
    }

    operation CNOP(q1: Qubit[], q2: Qubit[], i3 : Int) : Unit
    {
        for (i in 0..7)
        {
            CNOT(q1[i], q2[i]);
		}
	}

    operation Test (i1 : Int, i2 : Int, i3 : Int) : (Int, Int)
    {
        mutable ri1 = 0;
        mutable ri2 = 0;
        using (qip = Qubit[8])
        {
            using (qre = Qubit[8])
            {
                let b1 = IntAsBoolArray(i1, 8);
                let b2 = IntAsBoolArray(i2, 8);
                for (i in 0..7)
                {
                    if (b1[i]) { X(qip[i]); }
                    if (b2[i]) { X(qre[i]); }
				}

                CNOP(qip, qre, i3);
                mutable r1 = new Bool[8];
                mutable r2 = new Bool[8];

                for (i in 0..7)
                {
                    if (M(qip[i]) == One)
                    {
                        set r1 w/= i <- true;
					}
                    else
                    {
                        set r1 w/= i <- false;
					}
                    if (M(qre[i]) == One)
                    {
                        set r2 w/= i <- true;
					}
                    else
                    {
                        set r2 w/= i <- false;
					}
				}

                set ri1 = BoolArrayAsInt(r1);
                set ri2 = BoolArrayAsInt(r2);
                ResetAll(qip);
                ResetAll(qre);
			}
		}
        return (ri1, ri2);
	}
}
