/**
 * let const
 */
let hoge = "hoge";
const FUGA = "FUGA";
// let hoge = "hogehoge"; 再定義できない
// hoge = "hogehogehoge"; 再代入はOK
// const FUGA = "FUGAFUGA"; 再定義できない
// FUGA = "FUGAFUGA"; 再代入もできない



/**
 * アロー関数
 */
var f1 = function (a,b) {
  return a + b;
};
const f2 = (a,b) => {
  return a + b;
};
// 単一式の場合はreturn も省略可
// const f2 = (a, b) => a + b;

console.log('f1:' + f1(1,2));
console.log('f2:' + f2(1,2));


/**
 * クラス
 */

class Klass {
  constructor(name) {
    this.name = name;
  }
  getName() {
    return this.name;
  }
  setName(newName) {
    this.name = newName;
  }
 }
 k = new Klass('Taro');
 console.log( k.getName() );
 k.setName('Jiro'); console.log(k.getName());