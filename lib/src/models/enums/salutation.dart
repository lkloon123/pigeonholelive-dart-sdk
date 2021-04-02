import 'package:json_annotation/json_annotation.dart';

enum Salutation {
  @JsonValue('Mr')
  Mr,

  @JsonValue('Mrs')
  Mrs,

  @JsonValue('Miss')
  Miss,

  @JsonValue('Dr')
  Dr,

  @JsonValue('Ms')
  Ms,

  @JsonValue('Prof')
  Prof,

  @JsonValue('A V M')
  AVM,

  @JsonValue('Admiraal')
  Admiraal,

  @JsonValue('Admiral')
  Admiral,

  @JsonValue('Air Cdre')
  AirCdre,

  @JsonValue('Air Commodore')
  AirCommodore,

  @JsonValue('Air Marshal')
  AirMarshal,

  @JsonValue('Air Vice Marshal')
  AirViceMarshal,

  @JsonValue('Alderman')
  Alderman,

  @JsonValue('Alhaji')
  Alhaji,

  @JsonValue('Ambassador')
  Ambassador,

  @JsonValue('Assistant Professor')
  AssistantProfessor,

  @JsonValue('Assoc Prof')
  AssocProf,

  @JsonValue('Baron')
  Baron,

  @JsonValue('Barones')
  Barones,

  @JsonValue('Brig')
  Brig,

  @JsonValue('Brig Gen')
  BrigGen,

  @JsonValue('Brig General')
  BrigGeneral,

  @JsonValue('Brigadier')
  Brigadier,

  @JsonValue('Brigadier General')
  BrigadierGeneral,

  @JsonValue('Brother')
  Brother,

  @JsonValue('Canon')
  Canon,

  @JsonValue('Capt')
  Capt,

  @JsonValue('Captain')
  Captain,

  @JsonValue('Cardinal')
  Cardinal,

  @JsonValue('Cdr')
  Cdr,

  @JsonValue('Chief')
  Chief,

  @JsonValue('Cik')
  Cik,

  @JsonValue('Cmdr')
  Cmdr,

  @JsonValue('Col')
  Col,

  @JsonValue('Col Dr')
  ColDr,

  @JsonValue('Colonel')
  Colonel,

  @JsonValue('Commandant')
  Commandant,

  @JsonValue('Commander')
  Commander,

  @JsonValue('Commissioner')
  Commissioner,

  @JsonValue('Commodore')
  Commodore,

  @JsonValue('Comte')
  Comte,

  @JsonValue('Comtessa')
  Comtessa,

  @JsonValue('Congressman')
  Congressman,

  @JsonValue('Conseiller')
  Conseiller,

  @JsonValue('Consul')
  Consul,

  @JsonValue('Conte')
  Conte,

  @JsonValue('Contessa')
  Contessa,

  @JsonValue('Corporal')
  Corporal,

  @JsonValue('Councillor')
  Councillor,

  @JsonValue('Count')
  Count,

  @JsonValue('Countess')
  Countess,

  @JsonValue('Crown Prince')
  CrownPrince,

  @JsonValue('Crown Princess')
  CrownPrincess,

  @JsonValue('Dame')
  Dame,

  @JsonValue('Datin')
  Datin,

  @JsonValue('Dato')
  Dato,

  @JsonValue('Datuk')
  Datuk,

  @JsonValue('Datuk Seri')
  DatukSeri,

  @JsonValue('Deacon')
  Deacon,

  @JsonValue('Deaconess')
  Deaconess,

  @JsonValue('Dean')
  Dean,

  @JsonValue('Dhr')
  Dhr,

  @JsonValue('Dipl Ing')
  DiplIng,

  @JsonValue('Doctor')
  Doctor,

  @JsonValue('Dott')
  Dott,

  @JsonValue('Dottsa')
  Dottsa,

  @JsonValue('Dr Ing')
  DrIng,

  @JsonValue('Dra')
  Dra,

  @JsonValue('Drs')
  Drs,

  @JsonValue('Embajador')
  Embajador,

  @JsonValue('Embajadora')
  Embajadora,

  @JsonValue('En')
  En,

  @JsonValue('Encik')
  Encik,

  @JsonValue('Eng')
  Eng,

  @JsonValue('Eur Ing')
  EurIng,

  @JsonValue('Exma Sra')
  ExmaSra,

  @JsonValue('Exmo Sr')
  ExmoSr,

  @JsonValue('F O')
  FO,

  @JsonValue('Father')
  Father,

  @JsonValue('First Lieutient')
  FirstLieutient,

  @JsonValue('First Officer')
  FirstOfficer,

  @JsonValue('Flt Lieut')
  FltLieut,

  @JsonValue('Flying Officer')
  FlyingOfficer,

  @JsonValue('Fr')
  Fr,

  @JsonValue('Frau')
  Frau,

  @JsonValue('Fraulein')
  Fraulein,

  @JsonValue('Fru')
  Fru,

  @JsonValue('Gen')
  Gen,

  @JsonValue('Generaal')
  Generaal,

  @JsonValue('General')
  General,

  @JsonValue('Governor')
  Governor,

  @JsonValue('Graaf')
  Graaf,

  @JsonValue('Gravin')
  Gravin,

  @JsonValue('Group Captain')
  GroupCaptain,

  @JsonValue('Grp Capt')
  GrpCapt,

  @JsonValue('H E')
  HE,

  @JsonValue('H E Dr')
  HEDr,

  @JsonValue('H H')
  HH,

  @JsonValue('H M')
  HM,

  @JsonValue('H R H')
  HRH,

  @JsonValue('Hajah')
  Hajah,

  @JsonValue('Haji')
  Haji,

  @JsonValue('Hajim')
  Hajim,

  @JsonValue('Her Excellency')
  HerExcellency,

  @JsonValue('Her Highness')
  HerHighness,

  @JsonValue('Her Holiness')
  HerHoliness,

  @JsonValue('Her Majesty')
  HerMajesty,

  @JsonValue('Her Worship')
  HerWorship,

  @JsonValue('Herr')
  Herr,

  @JsonValue('High Chief')
  HighChief,

  @JsonValue('His Excellency')
  HisExcellency,

  @JsonValue('His Highness')
  HisHighness,

  @JsonValue('His Holiness')
  HisHoliness,

  @JsonValue('His Majesty')
  HisMajesty,

  @JsonValue('His Worship')
  HisWorship,

  @JsonValue('Hon')
  Hon,

  @JsonValue('Hr')
  Hr,

  @JsonValue('Hra')
  Hra,

  @JsonValue('Ing')
  Ing,

  @JsonValue('Ir')
  Ir,

  @JsonValue('Jonkheer')
  Jonkheer,

  @JsonValue('Judge')
  Judge,

  @JsonValue('Justice')
  Justice,

  @JsonValue('Khun Ying')
  KhunYing,

  @JsonValue('Kolonel')
  Kolonel,

  @JsonValue('Lady')
  Lady,

  @JsonValue('Lcda')
  Lcda,

  @JsonValue('Lic')
  Lic,

  @JsonValue('Lieut')
  Lieut,

  @JsonValue('Lieut Cdr')
  LieutCdr,

  @JsonValue('Lieut Col')
  LieutCol,

  @JsonValue('Lieut Gen')
  LieutGen,

  @JsonValue('Lord')
  Lord,

  @JsonValue('M')
  M,

  @JsonValue('M L')
  ML,

  @JsonValue('M R')
  MR,

  @JsonValue('Madame')
  Madame,

  @JsonValue('Mademoiselle')
  Mademoiselle,

  @JsonValue('Maj Gen')
  MajGen,

  @JsonValue('Major')
  Major,

  @JsonValue('Master')
  Master,

  @JsonValue('Mdm')
  Mdm,

  @JsonValue('Mevrouw')
  Mevrouw,

  @JsonValue('Mlle')
  Mlle,

  @JsonValue('Mme')
  Mme,

  @JsonValue('Monsieur')
  Monsieur,

  @JsonValue('Monsignor')
  Monsignor,

  @JsonValue('Mstr')
  Mstr,

  @JsonValue('Nti')
  Nti,

  @JsonValue('Pastor')
  Pastor,

  @JsonValue('President')
  President,

  @JsonValue('Prince')
  Prince,

  @JsonValue('Princess')
  Princess,

  @JsonValue('Princesse')
  Princesse,

  @JsonValue('Prinses')
  Prinses,

  @JsonValue('Prof Dr')
  ProfDr,

  @JsonValue('Prof Sir')
  ProfSir,

  @JsonValue('Professor')
  Professor,

  @JsonValue('Puan')
  Puan,

  @JsonValue('Puan Sri')
  PuanSri,

  @JsonValue('Rabbi')
  Rabbi,

  @JsonValue('Rear Admiral')
  RearAdmiral,

  @JsonValue('Rev')
  Rev,

  @JsonValue('Rev Canon')
  RevCanon,

  @JsonValue('Rev Dr')
  RevDr,

  @JsonValue('Rev Mother')
  RevMother,

  @JsonValue('Reverend')
  Reverend,

  @JsonValue('Rt Hon')
  RtHon,

  @JsonValue('Rva')
  Rva,

  @JsonValue('Senator')
  Senator,

  @JsonValue('Sergeant')
  Sergeant,

  @JsonValue('Sheikh')
  Sheikh,

  @JsonValue('Sheikha')
  Sheikha,

  @JsonValue('Sig')
  Sig,

  @JsonValue('Signa')
  Signa,

  @JsonValue('Sigra')
  Sigra,

  @JsonValue('Sir')
  Sir,

  @JsonValue('Sister')
  Sister,

  @JsonValue('Sqn Ldr')
  SqnLdr,

  @JsonValue('Sr')
  Sr,

  @JsonValue('Sr D')
  SrD,

  @JsonValue('Sra')
  Sra,

  @JsonValue('Srta')
  Srta,

  @JsonValue('Sultan')
  Sultan,

  @JsonValue('Tan Sri')
  TanSri,

  @JsonValue('Tan Sri Dato')
  TanSriDato,

  @JsonValue('Tengku')
  Tengku,

  @JsonValue('Teuku')
  Teuku,

  @JsonValue('Than Puying')
  ThanPuying,

  @JsonValue('The Hon Dr')
  TheHonDr,

  @JsonValue('The Hon Justice')
  TheHonJustice,

  @JsonValue('The Hon Miss')
  TheHonMiss,

  @JsonValue('The Hon Mr')
  TheHonMr,

  @JsonValue('The Hon Mrs')
  TheHonMrs,

  @JsonValue('The Hon Ms')
  TheHonMs,

  @JsonValue('The Hon Sir')
  TheHonSir,

  @JsonValue('The Rt Hon')
  TheRtHon,

  @JsonValue('The Right Honourable')
  TheRightHonourable,

  @JsonValue('The Very Rev')
  TheVeryRev,

  @JsonValue('Toh Puan')
  TohPuan,

  @JsonValue('Tun')
  Tun,

  @JsonValue('Vice Admiral')
  ViceAdmiral,

  @JsonValue('Viscount')
  Viscount,

  @JsonValue('Viscountess')
  Viscountess,

  @JsonValue('Y Bhg Dato Sri')
  YBhgDatoSri,

  @JsonValue('Wg Cdr')
  WgCdr,
}
