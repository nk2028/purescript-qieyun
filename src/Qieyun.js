const Qieyun = require('qieyun');

// Instances
exports.eqPhonologicalPosition1 = a => b => a['等於'](b);

// The six elements of a phonological position
exports.initial = pl => pl['母'];
exports.rounding1 = pl => pl['呼'];
exports.division = pl => pl['等'];
exports.repeatedInitial1 = pl => pl['重紐'];
exports.rhyme = pl => pl['韻'];
exports.tone = pl => pl['聲'];

// Extended phonological attributes
exports.placeOfArticulation = pl => pl['音'];
exports.voicing = pl => pl['清濁'];
exports.phonologicalClass = pl => pl['攝'];

// Phonological description and encoding
exports.phonologicalDescription = pl => pl['描述'];
exports.phonologicalEncoding = pl => pl['編碼'];
exports.phonologicalExpression = pl => pl['表達式'];
exports.satisfies = pl => s => pl['屬於'](s);

// Constructor
exports.phonologicalPosition1 = a => b => c => d => e => f => new Qieyun['音韻地位'](a, b, c, d, e, f);
exports.fromPhonologicalDescription = s => Qieyun['音韻地位']['from描述'](s);
exports.fromPhonologicalEncoding = s => Qieyun['音韻地位']['from編碼'](s);

// Queries
exports.representativeCharacter1 = pl => pl['代表字'];
exports.fanqie1 = s => pl => pl['反切'](s);
exports.entries = pl => pl['條目'].map(o => ({ character: o['字頭'], explanation: o['解釋'] }));
exports.queryCharacter = s => Qieyun['query字頭'](s).map(o => ({ explanation: o['解釋'], phonologicalPosition: o['音韻地位'] }));

// List all phonological positions
exports.getPhonologicalPositions = () => [...Qieyun['iter音韻地位']()];
