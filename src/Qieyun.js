const Qieyun = require('qieyun');

// Instances
exports.eqPhonologicalPosition1 = a => b => a['等於'](b);

// The six elements of a phonological position
exports.initial = pp => pp['母'];
exports.rounding1 = pp => pp['呼'];
exports.division = pp => pp['等'];
exports.repeatedInitial1 = pp => pp['重紐'];
exports.rhyme = pp => pp['韻'];
exports.tone = pp => pp['聲'];

// Extended phonological attributes
exports.placeOfArticulation = pp => pp['音'];
exports.voicing = pp => pp['清濁'];
exports.phonologicalClass = pp => pp['攝'];

// Phonological description and encoding
exports.phonologicalDescription = pp => pp['描述'];
exports.phonologicalEncoding = pp => pp['編碼'];
exports.phonologicalExpression = pp => pp['表達式'];
exports.satisfies = pp => s => pp['屬於'](s);

// Constructor
exports.phonologicalPosition1 = a => b => c => d => e => f => new Qieyun['音韻地位'](a, b, c, d, e, f);
exports.fromPhonologicalDescription = s => Qieyun['音韻地位']['from描述'](s);
exports.fromPhonologicalEncoding = s => Qieyun['音韻地位']['from編碼'](s);

// Queries
exports.representativeCharacter1 = pp => pp['代表字'];
exports.fanqie1 = s => pp => pp['反切'](s);
exports.entries = pp => pp['條目'].map(o => ({ character: o['字頭'], explanation: o['解釋'] }));
exports.queryCharacter = s => Qieyun['query字頭'](s).map(o => ({ explanation: o['解釋'], phonologicalPosition: o['音韻地位'] }));

// List all phonological positions
exports.getPhonologicalPositions = () => [...Qieyun['iter音韻地位']()];
