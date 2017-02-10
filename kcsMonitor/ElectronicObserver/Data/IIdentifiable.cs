////////////////////////////////////////////////////////
// Original author: Andante
// https://twitter.com/andanteyk
// https://github.com/andanteyk/ElectronicObserver
////////////////////////////////////////////////////////using System;
namespace ElectronicObserver.Data {

	/// <summary>
	/// 固有のIDを取得できることを示します。
	/// </summary>
	public interface IIdentifiable {

		int ID { get; }

	}

}
