namespace QTypes.QInteger
{
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Math;
	open Microsoft.Quantum.Convert;

	newtype QInt = (Size : Int, Number : Qubit[]);

	operation QIntVS(qs : Qubit[], len : Int, val : Int) : QInt
	{
		let qn = QInt(len, qs[0..len - 1]);
		CopyToQInt(val, qn);
		return qn;
	}

	operation QIntV(qs : Qubit[], val : Int) : QInt
	{
		let len = Length(qs);
		let qn = QInt(len, qs[0..len - 1]);
		CopyToQInt(val, qn);
		return qn;
	}

	operation QIntR(qs : Qubit[]) : QInt
	{
		let len = Length(qs);
		let qn = QInt(len, qs);
		return qn;
	}
}
