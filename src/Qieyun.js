const Qieyun = require('qieyun');

// The six elements of a phonological location
exports.initial = phonologicalLocation => phonologicalLocation['母'];
exports.rounding1 = phonologicalLocation => phonologicalLocation['開合'];
exports.division = phonologicalLocation => phonologicalLocation['等'];
exports.repeatedInitial1 = phonologicalLocation => phonologicalLocation['重紐'];
exports.rhyme = phonologicalLocation => phonologicalLocation['韻'];
exports.tone = phonologicalLocation => phonologicalLocation['聲'];

// Extended phonological attributes
exports.placeOfArticulation = phonologicalLocation => phonologicalLocation['音'];
exports.voicing = phonologicalLocation => phonologicalLocation['清濁'];
exports.phonologicalClass = phonologicalLocation => phonologicalLocation['攝'];

// Phonological description and encoding
exports.phonologicalDescription = phonologicalLocation => phonologicalLocation['描述'];
exports.phonologicalEncoding = phonologicalLocation => phonologicalLocation['編碼'];
exports.phonologicalExpression = phonologicalLocation => phonologicalLocation['表達式'];

// Constructor
exports.fromPhonologicalDescription1 = s => {
  try {
    return Qieyun['音韻地位']['from描述'](s);
  } catch (e) {
    return null;
  }
}

exports.fromPhonologicalEncoding1 = s => {
  try {
    return Qieyun['音韻地位']['from編碼'](s);
  } catch (e) {
    return null;
  }
}

// representative character and fanqie
exports.representativeCharacter1 = phonologicalLocation => phonologicalLocation['代表字'];
exports.fanqie1 = phonologicalLocation => s => phonologicalLocation['反切'](s);

// entries
exports.entries = phonologicalLocation => phonologicalLocation['條目'].map(o => ({ character: o['字頭'], explanation: o['屬性'] }));


exports.belongsTo = phonologicalLocation => s => phonologicalLocation['屬於'](s);
exports.eqPhonologicalLocation1 = a => b => a['等於'](b);

exports.queryCharacter1 = s => Qieyun['query字頭'](s).map(o => ({ explanation: o['解釋'], phonologicalLocation: o['音韻地位'] }));
exports.getPhonologicalLocations = () => [...Qieyun['iter音韻地位']()];
