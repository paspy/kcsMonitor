////////////////////////////////////////////////////////
// Original author: Andante
// https://twitter.com/andanteyk
// https://github.com/andanteyk/ElectronicObserver
////////////////////////////////////////////////////////
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace ElectronicObserver.Data {

    /// <summary>
    /// IDを持つデータのリストを保持します。
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class IDDictionary<T> : IReadOnlyDictionary<int, T> where T : class, IIdentifiable {

        private readonly IDictionary<int, T> dict;

        public IDDictionary()
            : this(new List<T>()) {
        }

        public IDDictionary(IEnumerable<T> source) {
            dict = source.ToDictionary(x => x.ID);
        }


        internal void Add(T data) {
            dict.Add(data.ID, data);
        }

        internal void Remove(T data) {
            dict.Remove(data.ID);
        }

        internal void Remove(int id) {
            dict.Remove(id);
        }

        internal int RemoveAll(Predicate<T> predicate) {
            var removekeys = dict.Values.Where(elem => predicate(elem)).Select(elem => elem.ID).ToArray();

            foreach (var key in removekeys) {
                dict.Remove(key);
            }

            return removekeys.Count();
        }

        internal void Clear() {
            dict.Clear();
        }


        public bool ContainsKey(int key) {
            return dict.ContainsKey(key);
        }

        public IEnumerable<int> Keys {
            get { return dict.Keys; }
        }

        public bool TryGetValue(int key, out T value) {
            return dict.TryGetValue(key, out value);
        }

        public IEnumerable<T> Values {
            get { return dict.Values; }
        }

        public T this[int key] {
            get { return dict.ContainsKey(key) ? dict[key] : null; }
        }

        public int Count {
            get { return dict.Count; }
        }

        public IEnumerator<KeyValuePair<int, T>> GetEnumerator() {
            return dict.GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator() {
            return dict.GetEnumerator();
        }
    }

}
