namespace QTypes.QInteger
{
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    operation ResizeQInt(qn : QInt, rs : Qubit[]) : QInt
    {
        mutable ar = qn::Number;
        set ar += rs;
        return QIntR(ar);
	}

    operation CopyToQInt(n : Int, qn : QInt) : Unit is Adj+Ctl
    {
        let ar = IntAsBoolArray(n, qn::Size);
        for (i in 0..qn::Size - 1)
        {
            if (ar[i])
            {
                X(qn::Number[i]);
			}
		}
	}

    operation PrepareUniformSuperposition(n : QInt) : Unit
    {
        for (i in 0..n::Size - 1)
        {
            H(n::Number[i]);
		}
	}

    operation MeasureQInt(n : QInt) : Int
    {
        mutable r = 1;
        mutable res = 0;

        for (i in 0..n::Size - 1)
        {
			if (M(n::Number[i]) == One)
            {
                set res += r;
			}
            set r*= 2;
		}
        return res;
	}

    operation ResetQInt(n : QInt) : Unit
    {
        ResetAll(n::Number);
	}

    operation IsZeroQInt(n : QInt, res : Qubit) : Unit is Adj+Ctl
    {
        within
        {
            for (i in 0..n::Size - 1)
            {
                X(n::Number[i]);
		    }
        }
        apply
        {
            (Controlled X)(n::Number, res);
	    }
	}

    operation EqualsQQQ(a : QInt, b : QInt, c : Qubit) : Unit is Adj+Ctl
    {
        if (a::Size <= b::Size)
        {
            within
            {
                for (i in 0..b::Size - 1)
                {
                    if (i < a::Size)
                    {
                        CNOT(a::Number[i], b::Number[i]);
			        }
                    X(b::Number[i]);
		        }
		    }
            apply
            {
                (Controlled X)(b::Number, c);
		    }
	    }
        else
        {
            EqualsQQQ(b, a, c);
		}
	}

    operation EqualsCQQ(a : Int, b : QInt, c : Qubit) : Unit is Adj+Ctl
    {
        if (a < PowI(2, b::Size))
        {
            let ar = IntAsBoolArray(a, b::Size);
            for (i in 0..b::Size - 1)
            {
                if (not ar[i])
                {
                    X(b::Number[i]);
                }
		    }
            (Controlled X)(b::Number, c);
            for (i in 0..b::Size - 1)
            {
                if (not ar[i])
                {
                    X(b::Number[i]);
                }
		    }
	    }
	}

    operation EqualsQQM(a : QInt, b : QInt) : Bool
    {
        mutable res = Zero;
        using (anc = Qubit())
        {
            EqualsQQQ(a, b, anc);
            set res = M(anc);
            Reset(anc);
		}
        return ResultAsBool(res);
	}

    operation EqualsCQM(a : Int, b : QInt) : Bool
    {
        mutable res = Zero;
        using (anc = Qubit())
        {
            EqualsCQQ(a, b, anc);
            set res = M(anc);
            Reset(anc);
		}
        return ResultAsBool(res);
	}

    operation Increment(n : QInt) : Unit is Adj+Ctl
    {
        if (n::Size != 0)
        {
            (Controlled Increment)([n::Number[0]], QInt(n::Size - 1, n::Number[1..(n::Size - 1)]));
            X(n::Number[0]);
        }
	}

    operation Decrement(n : QInt) : Unit is Adj+Ctl
    {
        (Adjoint Increment)(n);
	}
}
