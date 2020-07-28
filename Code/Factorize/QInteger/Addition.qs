namespace QTypes.QInteger.Addition
{

    open QTypes.QInteger;
    open Microsoft.Quantum.Intrinsic;

    operation __carry(Ccurr : Qubit, Summand : Qubit, Target : Qubit, Cnext : Qubit) : Unit is Adj+Ctl
    {
        CCNOT(Summand, Target, Cnext);
        CNOT(Summand, Target);
        CCNOT(Ccurr, Target, Cnext);
	}

    operation __sum(Ccurr : Qubit, Summand : Qubit, Target : Qubit) : Unit is Adj+Ctl
    {
        CNOT(Summand, Target);
        CNOT(Ccurr, Target);
	}

    operation Add3nWoOFCheck(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
    {
        let n = Target::Size;
        using (Carry = Qubit[n + 1])
        {
            for (i in 0..n - 1)
            {
                __carry(Carry[0], Summand::Number[i], Target::Number[i], Carry[i + 1]);
			}
            CNOT(Summand::Number[n - 1], Target::Number[n - 1]);
            __sum(Carry[n - 1], Summand::Number[n - 1], Target::Number[n - 1]);
            for (i in n - 2..0)
            {
                (Adjoint __carry)(Carry[0], Summand::Number[i], Target::Number[i], Carry[i + 1]);
                __sum(Carry[i], Summand::Number[i], Target::Number[i]);
			}
		}
	}

    operation Add3nWoOFCheckSeperateRes(A : QInt, B : QInt, Target : QInt) : Unit is Adj+Ctl
    {
        using (Carry = Qubit())
        {
            for (i in 0..Target::Size)
            {
                CNOT(       Carry, Target::Number[i]);
                CNOT(A::Number[i], Target::Number[i]);
                CNOT(B::Number[i], Target::Number[i]);

                X(Target::Number[i]);
                (Controlled X)([A::Number[i], B::Number[i], Target::Number[i]], Carry);
                X(A::Number[i]); X(B::Number[i]); X(Target::Number[i]);
                (Controlled X)([A::Number[i], B::Number[i], Target::Number[i]], Carry);
                X(A::Number[i]); X(B::Number[i]);
			}
		}
	}
}
