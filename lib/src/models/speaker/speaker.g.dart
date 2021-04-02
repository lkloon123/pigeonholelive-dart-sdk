// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  return Speaker(
    id: json['id'] as int?,
    salutation: _$enumDecodeNullable(_$SalutationEnumMap, json['salutation']),
    fullName: json['fullName'] as String?,
    briefDescription: json['briefDescription'] as String?,
    biography: json['biography'] as String?,
  );
}

Map<String, dynamic> _$SpeakerToJson(Speaker instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('salutation', _$SalutationEnumMap[instance.salutation]);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('briefDescription', instance.briefDescription);
  writeNotNull('biography', instance.biography);
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$SalutationEnumMap = {
  Salutation.Mr: 'Mr',
  Salutation.Mrs: 'Mrs',
  Salutation.Miss: 'Miss',
  Salutation.Dr: 'Dr',
  Salutation.Ms: 'Ms',
  Salutation.Prof: 'Prof',
  Salutation.AVM: 'A V M',
  Salutation.Admiraal: 'Admiraal',
  Salutation.Admiral: 'Admiral',
  Salutation.AirCdre: 'Air Cdre',
  Salutation.AirCommodore: 'Air Commodore',
  Salutation.AirMarshal: 'Air Marshal',
  Salutation.AirViceMarshal: 'Air Vice Marshal',
  Salutation.Alderman: 'Alderman',
  Salutation.Alhaji: 'Alhaji',
  Salutation.Ambassador: 'Ambassador',
  Salutation.AssistantProfessor: 'Assistant Professor',
  Salutation.AssocProf: 'Assoc Prof',
  Salutation.Baron: 'Baron',
  Salutation.Barones: 'Barones',
  Salutation.Brig: 'Brig',
  Salutation.BrigGen: 'Brig Gen',
  Salutation.BrigGeneral: 'Brig General',
  Salutation.Brigadier: 'Brigadier',
  Salutation.BrigadierGeneral: 'Brigadier General',
  Salutation.Brother: 'Brother',
  Salutation.Canon: 'Canon',
  Salutation.Capt: 'Capt',
  Salutation.Captain: 'Captain',
  Salutation.Cardinal: 'Cardinal',
  Salutation.Cdr: 'Cdr',
  Salutation.Chief: 'Chief',
  Salutation.Cik: 'Cik',
  Salutation.Cmdr: 'Cmdr',
  Salutation.Col: 'Col',
  Salutation.ColDr: 'Col Dr',
  Salutation.Colonel: 'Colonel',
  Salutation.Commandant: 'Commandant',
  Salutation.Commander: 'Commander',
  Salutation.Commissioner: 'Commissioner',
  Salutation.Commodore: 'Commodore',
  Salutation.Comte: 'Comte',
  Salutation.Comtessa: 'Comtessa',
  Salutation.Congressman: 'Congressman',
  Salutation.Conseiller: 'Conseiller',
  Salutation.Consul: 'Consul',
  Salutation.Conte: 'Conte',
  Salutation.Contessa: 'Contessa',
  Salutation.Corporal: 'Corporal',
  Salutation.Councillor: 'Councillor',
  Salutation.Count: 'Count',
  Salutation.Countess: 'Countess',
  Salutation.CrownPrince: 'Crown Prince',
  Salutation.CrownPrincess: 'Crown Princess',
  Salutation.Dame: 'Dame',
  Salutation.Datin: 'Datin',
  Salutation.Dato: 'Dato',
  Salutation.Datuk: 'Datuk',
  Salutation.DatukSeri: 'Datuk Seri',
  Salutation.Deacon: 'Deacon',
  Salutation.Deaconess: 'Deaconess',
  Salutation.Dean: 'Dean',
  Salutation.Dhr: 'Dhr',
  Salutation.DiplIng: 'Dipl Ing',
  Salutation.Doctor: 'Doctor',
  Salutation.Dott: 'Dott',
  Salutation.Dottsa: 'Dottsa',
  Salutation.DrIng: 'Dr Ing',
  Salutation.Dra: 'Dra',
  Salutation.Drs: 'Drs',
  Salutation.Embajador: 'Embajador',
  Salutation.Embajadora: 'Embajadora',
  Salutation.En: 'En',
  Salutation.Encik: 'Encik',
  Salutation.Eng: 'Eng',
  Salutation.EurIng: 'Eur Ing',
  Salutation.ExmaSra: 'Exma Sra',
  Salutation.ExmoSr: 'Exmo Sr',
  Salutation.FO: 'F O',
  Salutation.Father: 'Father',
  Salutation.FirstLieutient: 'First Lieutient',
  Salutation.FirstOfficer: 'First Officer',
  Salutation.FltLieut: 'Flt Lieut',
  Salutation.FlyingOfficer: 'Flying Officer',
  Salutation.Fr: 'Fr',
  Salutation.Frau: 'Frau',
  Salutation.Fraulein: 'Fraulein',
  Salutation.Fru: 'Fru',
  Salutation.Gen: 'Gen',
  Salutation.Generaal: 'Generaal',
  Salutation.General: 'General',
  Salutation.Governor: 'Governor',
  Salutation.Graaf: 'Graaf',
  Salutation.Gravin: 'Gravin',
  Salutation.GroupCaptain: 'Group Captain',
  Salutation.GrpCapt: 'Grp Capt',
  Salutation.HE: 'H E',
  Salutation.HEDr: 'H E Dr',
  Salutation.HH: 'H H',
  Salutation.HM: 'H M',
  Salutation.HRH: 'H R H',
  Salutation.Hajah: 'Hajah',
  Salutation.Haji: 'Haji',
  Salutation.Hajim: 'Hajim',
  Salutation.HerExcellency: 'Her Excellency',
  Salutation.HerHighness: 'Her Highness',
  Salutation.HerHoliness: 'Her Holiness',
  Salutation.HerMajesty: 'Her Majesty',
  Salutation.HerWorship: 'Her Worship',
  Salutation.Herr: 'Herr',
  Salutation.HighChief: 'High Chief',
  Salutation.HisExcellency: 'His Excellency',
  Salutation.HisHighness: 'His Highness',
  Salutation.HisHoliness: 'His Holiness',
  Salutation.HisMajesty: 'His Majesty',
  Salutation.HisWorship: 'His Worship',
  Salutation.Hon: 'Hon',
  Salutation.Hr: 'Hr',
  Salutation.Hra: 'Hra',
  Salutation.Ing: 'Ing',
  Salutation.Ir: 'Ir',
  Salutation.Jonkheer: 'Jonkheer',
  Salutation.Judge: 'Judge',
  Salutation.Justice: 'Justice',
  Salutation.KhunYing: 'Khun Ying',
  Salutation.Kolonel: 'Kolonel',
  Salutation.Lady: 'Lady',
  Salutation.Lcda: 'Lcda',
  Salutation.Lic: 'Lic',
  Salutation.Lieut: 'Lieut',
  Salutation.LieutCdr: 'Lieut Cdr',
  Salutation.LieutCol: 'Lieut Col',
  Salutation.LieutGen: 'Lieut Gen',
  Salutation.Lord: 'Lord',
  Salutation.M: 'M',
  Salutation.ML: 'M L',
  Salutation.MR: 'M R',
  Salutation.Madame: 'Madame',
  Salutation.Mademoiselle: 'Mademoiselle',
  Salutation.MajGen: 'Maj Gen',
  Salutation.Major: 'Major',
  Salutation.Master: 'Master',
  Salutation.Mdm: 'Mdm',
  Salutation.Mevrouw: 'Mevrouw',
  Salutation.Mlle: 'Mlle',
  Salutation.Mme: 'Mme',
  Salutation.Monsieur: 'Monsieur',
  Salutation.Monsignor: 'Monsignor',
  Salutation.Mstr: 'Mstr',
  Salutation.Nti: 'Nti',
  Salutation.Pastor: 'Pastor',
  Salutation.President: 'President',
  Salutation.Prince: 'Prince',
  Salutation.Princess: 'Princess',
  Salutation.Princesse: 'Princesse',
  Salutation.Prinses: 'Prinses',
  Salutation.ProfDr: 'Prof Dr',
  Salutation.ProfSir: 'Prof Sir',
  Salutation.Professor: 'Professor',
  Salutation.Puan: 'Puan',
  Salutation.PuanSri: 'Puan Sri',
  Salutation.Rabbi: 'Rabbi',
  Salutation.RearAdmiral: 'Rear Admiral',
  Salutation.Rev: 'Rev',
  Salutation.RevCanon: 'Rev Canon',
  Salutation.RevDr: 'Rev Dr',
  Salutation.RevMother: 'Rev Mother',
  Salutation.Reverend: 'Reverend',
  Salutation.RtHon: 'Rt Hon',
  Salutation.Rva: 'Rva',
  Salutation.Senator: 'Senator',
  Salutation.Sergeant: 'Sergeant',
  Salutation.Sheikh: 'Sheikh',
  Salutation.Sheikha: 'Sheikha',
  Salutation.Sig: 'Sig',
  Salutation.Signa: 'Signa',
  Salutation.Sigra: 'Sigra',
  Salutation.Sir: 'Sir',
  Salutation.Sister: 'Sister',
  Salutation.SqnLdr: 'Sqn Ldr',
  Salutation.Sr: 'Sr',
  Salutation.SrD: 'Sr D',
  Salutation.Sra: 'Sra',
  Salutation.Srta: 'Srta',
  Salutation.Sultan: 'Sultan',
  Salutation.TanSri: 'Tan Sri',
  Salutation.TanSriDato: 'Tan Sri Dato',
  Salutation.Tengku: 'Tengku',
  Salutation.Teuku: 'Teuku',
  Salutation.ThanPuying: 'Than Puying',
  Salutation.TheHonDr: 'The Hon Dr',
  Salutation.TheHonJustice: 'The Hon Justice',
  Salutation.TheHonMiss: 'The Hon Miss',
  Salutation.TheHonMr: 'The Hon Mr',
  Salutation.TheHonMrs: 'The Hon Mrs',
  Salutation.TheHonMs: 'The Hon Ms',
  Salutation.TheHonSir: 'The Hon Sir',
  Salutation.TheRtHon: 'The Rt Hon',
  Salutation.TheRightHonourable: 'The Right Honourable',
  Salutation.TheVeryRev: 'The Very Rev',
  Salutation.TohPuan: 'Toh Puan',
  Salutation.Tun: 'Tun',
  Salutation.ViceAdmiral: 'Vice Admiral',
  Salutation.Viscount: 'Viscount',
  Salutation.Viscountess: 'Viscountess',
  Salutation.YBhgDatoSri: 'Y Bhg Dato Sri',
  Salutation.WgCdr: 'Wg Cdr',
};
