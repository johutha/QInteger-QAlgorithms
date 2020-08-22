namespace QAlgorithms.PhaseEstimator
{
    open QTypes.QInteger;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    operation EstimatePhase(U : (Qubit[] => Unit is Ctl), Eigenstate : Qubit[], Precision : Int) : Int 
    {
        using (anc = Qubit[Precision])
        {
            for (i in 0..Precision - 1)
            {
				H(anc[i]);
			}
            mutable rep = 1;
            for (i in Precision - 1..-1..0)
            {
                for (r in 0..rep - 1)
                {
                    (Controlled U)([anc[i]], Eigenstate);
				}
                set rep = rep * 2;
			}
            let qr = QIntR(anc);
            (Adjoint QFTQInt)(qr);
            let res = MeasureQInt(qr);
            ResetQInt(qr);
            return res;
		}
    }
}
