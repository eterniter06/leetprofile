// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserDataCollection on Isar {
  IsarCollection<UserData> get userDatas => this.collection();
}

const UserDataSchema = CollectionSchema(
  name: r'UserData',
  id: 4284092529070872654,
  properties: {
    r'advancedTags': PropertySchema(
      id: 0,
      name: r'advancedTags',
      type: IsarType.objectList,
      target: r'TagsSolved',
    ),
    r'allQuestionsCount': PropertySchema(
      id: 1,
      name: r'allQuestionsCount',
      type: IsarType.objectList,
      target: r'AllQuestions',
    ),
    r'avatar': PropertySchema(
      id: 2,
      name: r'avatar',
      type: IsarType.string,
    ),
    r'badges': PropertySchema(
      id: 3,
      name: r'badges',
      type: IsarType.objectList,
      target: r'UserBadge',
    ),
    r'fundamentalTags': PropertySchema(
      id: 4,
      name: r'fundamentalTags',
      type: IsarType.objectList,
      target: r'TagsSolved',
    ),
    r'githubUrl': PropertySchema(
      id: 5,
      name: r'githubUrl',
      type: IsarType.string,
    ),
    r'intermediateTags': PropertySchema(
      id: 6,
      name: r'intermediateTags',
      type: IsarType.objectList,
      target: r'TagsSolved',
    ),
    r'languageProblemCount': PropertySchema(
      id: 7,
      name: r'languageProblemCount',
      type: IsarType.objectList,
      target: r'LanguageSubmission',
    ),
    r'lastFetchTime': PropertySchema(
      id: 8,
      name: r'lastFetchTime',
      type: IsarType.dateTime,
    ),
    r'linkedinUrl': PropertySchema(
      id: 9,
      name: r'linkedinUrl',
      type: IsarType.string,
    ),
    r'listOrder': PropertySchema(
      id: 10,
      name: r'listOrder',
      type: IsarType.long,
    ),
    r'nickname': PropertySchema(
      id: 11,
      name: r'nickname',
      type: IsarType.string,
    ),
    r'postViewCount': PropertySchema(
      id: 12,
      name: r'postViewCount',
      type: IsarType.string,
    ),
    r'problemData': PropertySchema(
      id: 13,
      name: r'problemData',
      type: IsarType.object,
      target: r'ProblemData',
    ),
    r'ranking': PropertySchema(
      id: 14,
      name: r'ranking',
      type: IsarType.string,
    ),
    r'realname': PropertySchema(
      id: 15,
      name: r'realname',
      type: IsarType.string,
    ),
    r'recentAcSubmissionList': PropertySchema(
      id: 16,
      name: r'recentAcSubmissionList',
      type: IsarType.objectList,
      target: r'RecentSubmission',
    ),
    r'reputation': PropertySchema(
      id: 17,
      name: r'reputation',
      type: IsarType.string,
    ),
    r'solutionCount': PropertySchema(
      id: 18,
      name: r'solutionCount',
      type: IsarType.string,
    ),
    r'submissionActivity': PropertySchema(
      id: 19,
      name: r'submissionActivity',
      type: IsarType.objectList,
      target: r'SubmissionCalendarDate',
    ),
    r'totalActiveDays': PropertySchema(
      id: 20,
      name: r'totalActiveDays',
      type: IsarType.long,
    ),
    r'userContestRanking': PropertySchema(
      id: 21,
      name: r'userContestRanking',
      type: IsarType.object,
      target: r'ContestRanking',
    ),
    r'userContestRankingHistory': PropertySchema(
      id: 22,
      name: r'userContestRankingHistory',
      type: IsarType.objectList,
      target: r'ContestSummary',
    ),
    r'username': PropertySchema(
      id: 23,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _userDataEstimateSize,
  serialize: _userDataSerialize,
  deserialize: _userDataDeserialize,
  deserializeProp: _userDataDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'SubmissionCalendarDate': SubmissionCalendarDateSchema,
    r'ProblemData': ProblemDataSchema,
    r'RecentSubmission': RecentSubmissionSchema,
    r'UserBadge': UserBadgeSchema,
    r'LanguageSubmission': LanguageSubmissionSchema,
    r'TagsSolved': TagsSolvedSchema,
    r'AllQuestions': AllQuestionsSchema,
    r'ContestRanking': ContestRankingSchema,
    r'ContestSummary': ContestSummarySchema
  },
  getId: _userDataGetId,
  getLinks: _userDataGetLinks,
  attach: _userDataAttach,
  version: '3.1.0+1',
);

int _userDataEstimateSize(
  UserData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.advancedTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TagsSolved]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TagsSolvedSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.allQuestionsCount;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AllQuestions]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              AllQuestionsSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.avatar.length * 3;
  {
    final list = object.badges;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[UserBadge]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              UserBadgeSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.fundamentalTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TagsSolved]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TagsSolvedSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.githubUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.intermediateTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TagsSolved]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TagsSolvedSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.languageProblemCount;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[LanguageSubmission]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              LanguageSubmissionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.linkedinUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nickname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.postViewCount.length * 3;
  {
    final value = object.problemData;
    if (value != null) {
      bytesCount += 3 +
          ProblemDataSchema.estimateSize(
              value, allOffsets[ProblemData]!, allOffsets);
    }
  }
  bytesCount += 3 + object.ranking.length * 3;
  bytesCount += 3 + object.realname.length * 3;
  {
    final list = object.recentAcSubmissionList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[RecentSubmission]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              RecentSubmissionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.reputation.length * 3;
  bytesCount += 3 + object.solutionCount.length * 3;
  {
    final list = object.submissionActivity;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[SubmissionCalendarDate]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += SubmissionCalendarDateSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.userContestRanking;
    if (value != null) {
      bytesCount += 3 +
          ContestRankingSchema.estimateSize(
              value, allOffsets[ContestRanking]!, allOffsets);
    }
  }
  {
    final list = object.userContestRankingHistory;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ContestSummary]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              ContestSummarySchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.username.length * 3;
  return bytesCount;
}

void _userDataSerialize(
  UserData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TagsSolved>(
    offsets[0],
    allOffsets,
    TagsSolvedSchema.serialize,
    object.advancedTags,
  );
  writer.writeObjectList<AllQuestions>(
    offsets[1],
    allOffsets,
    AllQuestionsSchema.serialize,
    object.allQuestionsCount,
  );
  writer.writeString(offsets[2], object.avatar);
  writer.writeObjectList<UserBadge>(
    offsets[3],
    allOffsets,
    UserBadgeSchema.serialize,
    object.badges,
  );
  writer.writeObjectList<TagsSolved>(
    offsets[4],
    allOffsets,
    TagsSolvedSchema.serialize,
    object.fundamentalTags,
  );
  writer.writeString(offsets[5], object.githubUrl);
  writer.writeObjectList<TagsSolved>(
    offsets[6],
    allOffsets,
    TagsSolvedSchema.serialize,
    object.intermediateTags,
  );
  writer.writeObjectList<LanguageSubmission>(
    offsets[7],
    allOffsets,
    LanguageSubmissionSchema.serialize,
    object.languageProblemCount,
  );
  writer.writeDateTime(offsets[8], object.lastFetchTime);
  writer.writeString(offsets[9], object.linkedinUrl);
  writer.writeLong(offsets[10], object.listOrder);
  writer.writeString(offsets[11], object.nickname);
  writer.writeString(offsets[12], object.postViewCount);
  writer.writeObject<ProblemData>(
    offsets[13],
    allOffsets,
    ProblemDataSchema.serialize,
    object.problemData,
  );
  writer.writeString(offsets[14], object.ranking);
  writer.writeString(offsets[15], object.realname);
  writer.writeObjectList<RecentSubmission>(
    offsets[16],
    allOffsets,
    RecentSubmissionSchema.serialize,
    object.recentAcSubmissionList,
  );
  writer.writeString(offsets[17], object.reputation);
  writer.writeString(offsets[18], object.solutionCount);
  writer.writeObjectList<SubmissionCalendarDate>(
    offsets[19],
    allOffsets,
    SubmissionCalendarDateSchema.serialize,
    object.submissionActivity,
  );
  writer.writeLong(offsets[20], object.totalActiveDays);
  writer.writeObject<ContestRanking>(
    offsets[21],
    allOffsets,
    ContestRankingSchema.serialize,
    object.userContestRanking,
  );
  writer.writeObjectList<ContestSummary>(
    offsets[22],
    allOffsets,
    ContestSummarySchema.serialize,
    object.userContestRankingHistory,
  );
  writer.writeString(offsets[23], object.username);
}

UserData _userDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserData(
    avatar: reader.readString(offsets[2]),
    lastFetchTime: reader.readDateTime(offsets[8]),
    nickname: reader.readStringOrNull(offsets[11]),
    realname: reader.readString(offsets[15]),
    totalActiveDays: reader.readLongOrNull(offsets[20]) ?? 0,
    username: reader.readString(offsets[23]),
  );
  object.advancedTags = reader.readObjectList<TagsSolved>(
    offsets[0],
    TagsSolvedSchema.deserialize,
    allOffsets,
    TagsSolved(),
  );
  object.allQuestionsCount = reader.readObjectList<AllQuestions>(
    offsets[1],
    AllQuestionsSchema.deserialize,
    allOffsets,
    AllQuestions(),
  );
  object.badges = reader.readObjectList<UserBadge>(
    offsets[3],
    UserBadgeSchema.deserialize,
    allOffsets,
    UserBadge(),
  );
  object.fundamentalTags = reader.readObjectList<TagsSolved>(
    offsets[4],
    TagsSolvedSchema.deserialize,
    allOffsets,
    TagsSolved(),
  );
  object.githubUrl = reader.readStringOrNull(offsets[5]);
  object.intermediateTags = reader.readObjectList<TagsSolved>(
    offsets[6],
    TagsSolvedSchema.deserialize,
    allOffsets,
    TagsSolved(),
  );
  object.languageProblemCount = reader.readObjectList<LanguageSubmission>(
    offsets[7],
    LanguageSubmissionSchema.deserialize,
    allOffsets,
    LanguageSubmission(),
  );
  object.linkedinUrl = reader.readStringOrNull(offsets[9]);
  object.listOrder = reader.readLongOrNull(offsets[10]);
  object.postViewCount = reader.readString(offsets[12]);
  object.problemData = reader.readObjectOrNull<ProblemData>(
    offsets[13],
    ProblemDataSchema.deserialize,
    allOffsets,
  );
  object.ranking = reader.readString(offsets[14]);
  object.recentAcSubmissionList = reader.readObjectList<RecentSubmission>(
    offsets[16],
    RecentSubmissionSchema.deserialize,
    allOffsets,
    RecentSubmission(),
  );
  object.reputation = reader.readString(offsets[17]);
  object.solutionCount = reader.readString(offsets[18]);
  object.submissionActivity = reader.readObjectList<SubmissionCalendarDate>(
    offsets[19],
    SubmissionCalendarDateSchema.deserialize,
    allOffsets,
    SubmissionCalendarDate(),
  );
  object.userContestRanking = reader.readObjectOrNull<ContestRanking>(
    offsets[21],
    ContestRankingSchema.deserialize,
    allOffsets,
  );
  object.userContestRankingHistory = reader.readObjectList<ContestSummary>(
    offsets[22],
    ContestSummarySchema.deserialize,
    allOffsets,
    ContestSummary(),
  );
  return object;
}

P _userDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TagsSolved>(
        offset,
        TagsSolvedSchema.deserialize,
        allOffsets,
        TagsSolved(),
      )) as P;
    case 1:
      return (reader.readObjectList<AllQuestions>(
        offset,
        AllQuestionsSchema.deserialize,
        allOffsets,
        AllQuestions(),
      )) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readObjectList<UserBadge>(
        offset,
        UserBadgeSchema.deserialize,
        allOffsets,
        UserBadge(),
      )) as P;
    case 4:
      return (reader.readObjectList<TagsSolved>(
        offset,
        TagsSolvedSchema.deserialize,
        allOffsets,
        TagsSolved(),
      )) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<TagsSolved>(
        offset,
        TagsSolvedSchema.deserialize,
        allOffsets,
        TagsSolved(),
      )) as P;
    case 7:
      return (reader.readObjectList<LanguageSubmission>(
        offset,
        LanguageSubmissionSchema.deserialize,
        allOffsets,
        LanguageSubmission(),
      )) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readObjectOrNull<ProblemData>(
        offset,
        ProblemDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readObjectList<RecentSubmission>(
        offset,
        RecentSubmissionSchema.deserialize,
        allOffsets,
        RecentSubmission(),
      )) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readObjectList<SubmissionCalendarDate>(
        offset,
        SubmissionCalendarDateSchema.deserialize,
        allOffsets,
        SubmissionCalendarDate(),
      )) as P;
    case 20:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 21:
      return (reader.readObjectOrNull<ContestRanking>(
        offset,
        ContestRankingSchema.deserialize,
        allOffsets,
      )) as P;
    case 22:
      return (reader.readObjectList<ContestSummary>(
        offset,
        ContestSummarySchema.deserialize,
        allOffsets,
        ContestSummary(),
      )) as P;
    case 23:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userDataGetId(UserData object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userDataGetLinks(UserData object) {
  return [];
}

void _userDataAttach(IsarCollection<dynamic> col, Id id, UserData object) {}

extension UserDataQueryWhereSort on QueryBuilder<UserData, UserData, QWhere> {
  QueryBuilder<UserData, UserData, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserDataQueryWhere on QueryBuilder<UserData, UserData, QWhereClause> {
  QueryBuilder<UserData, UserData, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserDataQueryFilter
    on QueryBuilder<UserData, UserData, QFilterCondition> {
  QueryBuilder<UserData, UserData, QAfterFilterCondition> advancedTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'advancedTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'advancedTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      advancedTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'advancedTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allQuestionsCount',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allQuestionsCount',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allQuestionsCount',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> avatarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'badges',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'badges',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      badgesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'badges',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fundamentalTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fundamentalTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fundamentalTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'githubUrl',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'githubUrl',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'githubUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'githubUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'githubUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> githubUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'githubUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      githubUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'githubUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intermediateTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intermediateTags',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intermediateTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'languageProblemCount',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'languageProblemCount',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languageProblemCount',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastFetchTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFetchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      lastFetchTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFetchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastFetchTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFetchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> lastFetchTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFetchTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedinUrl',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      linkedinUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedinUrl',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      linkedinUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedinUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkedinUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkedinUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> linkedinUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedinUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      linkedinUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkedinUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listOrder',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listOrder',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> listOrderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nickname',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nickname',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> nicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      postViewCountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postViewCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      postViewCountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'postViewCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> postViewCountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'postViewCount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      postViewCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postViewCount',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      postViewCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'postViewCount',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> problemDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'problemData',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      problemDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'problemData',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ranking',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ranking',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ranking',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ranking',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> rankingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ranking',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'realname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'realname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realname',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> realnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'realname',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recentAcSubmissionList',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recentAcSubmissionList',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentAcSubmissionList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reputation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reputation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reputation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> reputationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reputation',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      reputationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reputation',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      solutionCountGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'solutionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      solutionCountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'solutionCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> solutionCountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'solutionCount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      solutionCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'solutionCount',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      solutionCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'solutionCount',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'submissionActivity',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'submissionActivity',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'submissionActivity',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      totalActiveDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalActiveDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      totalActiveDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalActiveDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      totalActiveDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalActiveDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      totalActiveDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalActiveDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userContestRanking',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userContestRanking',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userContestRankingHistory',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userContestRankingHistory',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userContestRankingHistory',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension UserDataQueryObject
    on QueryBuilder<UserData, UserData, QFilterCondition> {
  QueryBuilder<UserData, UserData, QAfterFilterCondition> advancedTagsElement(
      FilterQuery<TagsSolved> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'advancedTags');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      allQuestionsCountElement(FilterQuery<AllQuestions> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allQuestionsCount');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> badgesElement(
      FilterQuery<UserBadge> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'badges');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      fundamentalTagsElement(FilterQuery<TagsSolved> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fundamentalTags');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      intermediateTagsElement(FilterQuery<TagsSolved> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'intermediateTags');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      languageProblemCountElement(FilterQuery<LanguageSubmission> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'languageProblemCount');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> problemData(
      FilterQuery<ProblemData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'problemData');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      recentAcSubmissionListElement(FilterQuery<RecentSubmission> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'recentAcSubmissionList');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      submissionActivityElement(FilterQuery<SubmissionCalendarDate> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'submissionActivity');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition> userContestRanking(
      FilterQuery<ContestRanking> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'userContestRanking');
    });
  }

  QueryBuilder<UserData, UserData, QAfterFilterCondition>
      userContestRankingHistoryElement(FilterQuery<ContestSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'userContestRankingHistory');
    });
  }
}

extension UserDataQueryLinks
    on QueryBuilder<UserData, UserData, QFilterCondition> {}

extension UserDataQuerySortBy on QueryBuilder<UserData, UserData, QSortBy> {
  QueryBuilder<UserData, UserData, QAfterSortBy> sortByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByGithubUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'githubUrl', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByGithubUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'githubUrl', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLastFetchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFetchTime', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLastFetchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFetchTime', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLinkedinUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedinUrl', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByLinkedinUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedinUrl', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByListOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listOrder', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByListOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listOrder', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByPostViewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postViewCount', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByPostViewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postViewCount', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByRanking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ranking', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByRankingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ranking', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByRealname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realname', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByRealnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realname', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByReputation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reputation', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByReputationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reputation', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySolutionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solutionCount', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortBySolutionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solutionCount', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByTotalActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveDays', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByTotalActiveDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveDays', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension UserDataQuerySortThenBy
    on QueryBuilder<UserData, UserData, QSortThenBy> {
  QueryBuilder<UserData, UserData, QAfterSortBy> thenByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByGithubUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'githubUrl', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByGithubUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'githubUrl', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLastFetchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFetchTime', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLastFetchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFetchTime', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLinkedinUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedinUrl', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByLinkedinUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedinUrl', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByListOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listOrder', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByListOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listOrder', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByPostViewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postViewCount', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByPostViewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postViewCount', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByRanking() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ranking', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByRankingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ranking', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByRealname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realname', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByRealnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realname', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByReputation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reputation', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByReputationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reputation', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySolutionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solutionCount', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenBySolutionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solutionCount', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByTotalActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveDays', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByTotalActiveDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveDays', Sort.desc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<UserData, UserData, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension UserDataQueryWhereDistinct
    on QueryBuilder<UserData, UserData, QDistinct> {
  QueryBuilder<UserData, UserData, QDistinct> distinctByAvatar(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByGithubUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'githubUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByLastFetchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastFetchTime');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByLinkedinUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedinUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByListOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listOrder');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByNickname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nickname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByPostViewCount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postViewCount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByRanking(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ranking', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByRealname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'realname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByReputation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reputation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctBySolutionCount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'solutionCount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByTotalActiveDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalActiveDays');
    });
  }

  QueryBuilder<UserData, UserData, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension UserDataQueryProperty
    on QueryBuilder<UserData, UserData, QQueryProperty> {
  QueryBuilder<UserData, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UserData, List<TagsSolved>?, QQueryOperations>
      advancedTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'advancedTags');
    });
  }

  QueryBuilder<UserData, List<AllQuestions>?, QQueryOperations>
      allQuestionsCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allQuestionsCount');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> avatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatar');
    });
  }

  QueryBuilder<UserData, List<UserBadge>?, QQueryOperations> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'badges');
    });
  }

  QueryBuilder<UserData, List<TagsSolved>?, QQueryOperations>
      fundamentalTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fundamentalTags');
    });
  }

  QueryBuilder<UserData, String?, QQueryOperations> githubUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'githubUrl');
    });
  }

  QueryBuilder<UserData, List<TagsSolved>?, QQueryOperations>
      intermediateTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intermediateTags');
    });
  }

  QueryBuilder<UserData, List<LanguageSubmission>?, QQueryOperations>
      languageProblemCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languageProblemCount');
    });
  }

  QueryBuilder<UserData, DateTime, QQueryOperations> lastFetchTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastFetchTime');
    });
  }

  QueryBuilder<UserData, String?, QQueryOperations> linkedinUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedinUrl');
    });
  }

  QueryBuilder<UserData, int?, QQueryOperations> listOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listOrder');
    });
  }

  QueryBuilder<UserData, String?, QQueryOperations> nicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nickname');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> postViewCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postViewCount');
    });
  }

  QueryBuilder<UserData, ProblemData?, QQueryOperations> problemDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemData');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> rankingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ranking');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> realnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'realname');
    });
  }

  QueryBuilder<UserData, List<RecentSubmission>?, QQueryOperations>
      recentAcSubmissionListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recentAcSubmissionList');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> reputationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reputation');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> solutionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'solutionCount');
    });
  }

  QueryBuilder<UserData, List<SubmissionCalendarDate>?, QQueryOperations>
      submissionActivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'submissionActivity');
    });
  }

  QueryBuilder<UserData, int, QQueryOperations> totalActiveDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalActiveDays');
    });
  }

  QueryBuilder<UserData, ContestRanking?, QQueryOperations>
      userContestRankingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userContestRanking');
    });
  }

  QueryBuilder<UserData, List<ContestSummary>?, QQueryOperations>
      userContestRankingHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userContestRankingHistory');
    });
  }

  QueryBuilder<UserData, String, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserBadgeSchema = Schema(
  name: r'UserBadge',
  id: 3299412855898024376,
  properties: {
    r'creationDate': PropertySchema(
      id: 0,
      name: r'creationDate',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 1,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'iconLink': PropertySchema(
      id: 2,
      name: r'iconLink',
      type: IsarType.string,
    )
  },
  estimateSize: _userBadgeEstimateSize,
  serialize: _userBadgeSerialize,
  deserialize: _userBadgeDeserialize,
  deserializeProp: _userBadgeDeserializeProp,
);

int _userBadgeEstimateSize(
  UserBadge object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.iconLink;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userBadgeSerialize(
  UserBadge object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.creationDate);
  writer.writeString(offsets[1], object.displayName);
  writer.writeString(offsets[2], object.iconLink);
}

UserBadge _userBadgeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserBadge(
    creationDate: reader.readDateTimeOrNull(offsets[0]),
    displayName: reader.readStringOrNull(offsets[1]),
    iconLink: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _userBadgeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserBadgeQueryFilter
    on QueryBuilder<UserBadge, UserBadge, QFilterCondition> {
  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      creationDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      creationDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> creationDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      creationDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      creationDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> creationDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> displayNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconLink',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      iconLinkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconLink',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition> iconLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconLink',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBadge, UserBadge, QAfterFilterCondition>
      iconLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconLink',
        value: '',
      ));
    });
  }
}

extension UserBadgeQueryObject
    on QueryBuilder<UserBadge, UserBadge, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProblemDataSchema = Schema(
  name: r'ProblemData',
  id: 5306759286510392388,
  properties: {
    r'easySolved': PropertySchema(
      id: 0,
      name: r'easySolved',
      type: IsarType.long,
    ),
    r'easySubmissions': PropertySchema(
      id: 1,
      name: r'easySubmissions',
      type: IsarType.long,
    ),
    r'easyTotal': PropertySchema(
      id: 2,
      name: r'easyTotal',
      type: IsarType.long,
    ),
    r'hardSolved': PropertySchema(
      id: 3,
      name: r'hardSolved',
      type: IsarType.long,
    ),
    r'hardSubmissions': PropertySchema(
      id: 4,
      name: r'hardSubmissions',
      type: IsarType.long,
    ),
    r'hardTotal': PropertySchema(
      id: 5,
      name: r'hardTotal',
      type: IsarType.long,
    ),
    r'mediumSolved': PropertySchema(
      id: 6,
      name: r'mediumSolved',
      type: IsarType.long,
    ),
    r'mediumSubmissions': PropertySchema(
      id: 7,
      name: r'mediumSubmissions',
      type: IsarType.long,
    ),
    r'mediumTotal': PropertySchema(
      id: 8,
      name: r'mediumTotal',
      type: IsarType.long,
    )
  },
  estimateSize: _problemDataEstimateSize,
  serialize: _problemDataSerialize,
  deserialize: _problemDataDeserialize,
  deserializeProp: _problemDataDeserializeProp,
);

int _problemDataEstimateSize(
  ProblemData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _problemDataSerialize(
  ProblemData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.easySolved);
  writer.writeLong(offsets[1], object.easySubmissions);
  writer.writeLong(offsets[2], object.easyTotal);
  writer.writeLong(offsets[3], object.hardSolved);
  writer.writeLong(offsets[4], object.hardSubmissions);
  writer.writeLong(offsets[5], object.hardTotal);
  writer.writeLong(offsets[6], object.mediumSolved);
  writer.writeLong(offsets[7], object.mediumSubmissions);
  writer.writeLong(offsets[8], object.mediumTotal);
}

ProblemData _problemDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProblemData(
    easySolved: reader.readLongOrNull(offsets[0]) ?? 0,
    easySubmissions: reader.readLongOrNull(offsets[1]) ?? 0,
    easyTotal: reader.readLongOrNull(offsets[2]) ?? 0,
    hardSolved: reader.readLongOrNull(offsets[3]) ?? 0,
    hardSubmissions: reader.readLongOrNull(offsets[4]) ?? 0,
    hardTotal: reader.readLongOrNull(offsets[5]) ?? 0,
    mediumSolved: reader.readLongOrNull(offsets[6]) ?? 0,
    mediumSubmissions: reader.readLongOrNull(offsets[7]) ?? 0,
    mediumTotal: reader.readLongOrNull(offsets[8]) ?? 0,
  );
  return object;
}

P _problemDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ProblemDataQueryFilter
    on QueryBuilder<ProblemData, ProblemData, QFilterCondition> {
  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySolvedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'easySolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySolvedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'easySolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySolvedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'easySolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySolvedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'easySolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySubmissionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'easySubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySubmissionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'easySubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySubmissionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'easySubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easySubmissionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'easySubmissions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easyTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'easyTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easyTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'easyTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easyTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'easyTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      easyTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'easyTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSolvedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hardSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSolvedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hardSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSolvedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hardSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSolvedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hardSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSubmissionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hardSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSubmissionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hardSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSubmissionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hardSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardSubmissionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hardSubmissions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hardTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hardTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hardTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      hardTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hardTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSolvedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediumSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSolvedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediumSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSolvedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediumSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSolvedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediumSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSubmissionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediumSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSubmissionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediumSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSubmissionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediumSubmissions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumSubmissionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediumSubmissions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediumTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediumTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediumTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<ProblemData, ProblemData, QAfterFilterCondition>
      mediumTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediumTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProblemDataQueryObject
    on QueryBuilder<ProblemData, ProblemData, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RecentSubmissionSchema = Schema(
  name: r'RecentSubmission',
  id: 95131675610991799,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 1,
      name: r'timestamp',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleSlug': PropertySchema(
      id: 3,
      name: r'titleSlug',
      type: IsarType.string,
    )
  },
  estimateSize: _recentSubmissionEstimateSize,
  serialize: _recentSubmissionSerialize,
  deserialize: _recentSubmissionDeserialize,
  deserializeProp: _recentSubmissionDeserializeProp,
);

int _recentSubmissionEstimateSize(
  RecentSubmission object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.timestamp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.titleSlug;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recentSubmissionSerialize(
  RecentSubmission object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.timestamp);
  writer.writeString(offsets[2], object.title);
  writer.writeString(offsets[3], object.titleSlug);
}

RecentSubmission _recentSubmissionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentSubmission(
    id: reader.readStringOrNull(offsets[0]),
    timestamp: reader.readStringOrNull(offsets[1]),
    title: reader.readStringOrNull(offsets[2]),
    titleSlug: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _recentSubmissionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RecentSubmissionQueryFilter
    on QueryBuilder<RecentSubmission, RecentSubmission, QFilterCondition> {
  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timestamp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      timestampIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'titleSlug',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'titleSlug',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleSlug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleSlug',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleSlug',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentSubmission, RecentSubmission, QAfterFilterCondition>
      titleSlugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleSlug',
        value: '',
      ));
    });
  }
}

extension RecentSubmissionQueryObject
    on QueryBuilder<RecentSubmission, RecentSubmission, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LanguageSubmissionSchema = Schema(
  name: r'LanguageSubmission',
  id: -2792901719991480061,
  properties: {
    r'languageName': PropertySchema(
      id: 0,
      name: r'languageName',
      type: IsarType.string,
    ),
    r'problemsSolved': PropertySchema(
      id: 1,
      name: r'problemsSolved',
      type: IsarType.long,
    )
  },
  estimateSize: _languageSubmissionEstimateSize,
  serialize: _languageSubmissionSerialize,
  deserialize: _languageSubmissionDeserialize,
  deserializeProp: _languageSubmissionDeserializeProp,
);

int _languageSubmissionEstimateSize(
  LanguageSubmission object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.languageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _languageSubmissionSerialize(
  LanguageSubmission object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.languageName);
  writer.writeLong(offsets[1], object.problemsSolved);
}

LanguageSubmission _languageSubmissionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LanguageSubmission(
    languageName: reader.readStringOrNull(offsets[0]),
    problemsSolved: reader.readLongOrNull(offsets[1]) ?? 0,
  );
  return object;
}

P _languageSubmissionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LanguageSubmissionQueryFilter
    on QueryBuilder<LanguageSubmission, LanguageSubmission, QFilterCondition> {
  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'languageName',
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'languageName',
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'languageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'languageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'languageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageName',
        value: '',
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      languageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'languageName',
        value: '',
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      problemsSolvedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      problemsSolvedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      problemsSolvedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<LanguageSubmission, LanguageSubmission, QAfterFilterCondition>
      problemsSolvedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemsSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LanguageSubmissionQueryObject
    on QueryBuilder<LanguageSubmission, LanguageSubmission, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TagsSolvedSchema = Schema(
  name: r'TagsSolved',
  id: -2265951863314360540,
  properties: {
    r'problemsSolved': PropertySchema(
      id: 0,
      name: r'problemsSolved',
      type: IsarType.long,
    ),
    r'tagName': PropertySchema(
      id: 1,
      name: r'tagName',
      type: IsarType.string,
    ),
    r'tagSlug': PropertySchema(
      id: 2,
      name: r'tagSlug',
      type: IsarType.string,
    )
  },
  estimateSize: _tagsSolvedEstimateSize,
  serialize: _tagsSolvedSerialize,
  deserialize: _tagsSolvedDeserialize,
  deserializeProp: _tagsSolvedDeserializeProp,
);

int _tagsSolvedEstimateSize(
  TagsSolved object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.tagName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tagSlug;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tagsSolvedSerialize(
  TagsSolved object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.problemsSolved);
  writer.writeString(offsets[1], object.tagName);
  writer.writeString(offsets[2], object.tagSlug);
}

TagsSolved _tagsSolvedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TagsSolved(
    problemsSolved: reader.readLongOrNull(offsets[0]),
    tagName: reader.readStringOrNull(offsets[1]),
    tagSlug: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _tagsSolvedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TagsSolvedQueryFilter
    on QueryBuilder<TagsSolved, TagsSolved, QFilterCondition> {
  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'problemsSolved',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'problemsSolved',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      problemsSolvedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemsSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagName',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagName',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagName',
        value: '',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagName',
        value: '',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagSlug',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagSlugIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagSlug',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagSlugGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagSlug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagSlug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagSlug',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition> tagSlugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagSlug',
        value: '',
      ));
    });
  }

  QueryBuilder<TagsSolved, TagsSolved, QAfterFilterCondition>
      tagSlugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagSlug',
        value: '',
      ));
    });
  }
}

extension TagsSolvedQueryObject
    on QueryBuilder<TagsSolved, TagsSolved, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AllQuestionsSchema = Schema(
  name: r'AllQuestions',
  id: 747179144923837874,
  properties: {
    r'difficulty': PropertySchema(
      id: 0,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'total': PropertySchema(
      id: 1,
      name: r'total',
      type: IsarType.long,
    )
  },
  estimateSize: _allQuestionsEstimateSize,
  serialize: _allQuestionsSerialize,
  deserialize: _allQuestionsDeserialize,
  deserializeProp: _allQuestionsDeserializeProp,
);

int _allQuestionsEstimateSize(
  AllQuestions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.difficulty;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _allQuestionsSerialize(
  AllQuestions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.difficulty);
  writer.writeLong(offsets[1], object.total);
}

AllQuestions _allQuestionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AllQuestions(
    difficulty: reader.readStringOrNull(offsets[0]),
    total: reader.readLongOrNull(offsets[1]) ?? 0,
  );
  return object;
}

P _allQuestionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AllQuestionsQueryFilter
    on QueryBuilder<AllQuestions, AllQuestions, QFilterCondition> {
  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficulty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'difficulty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition> totalEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition>
      totalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition> totalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<AllQuestions, AllQuestions, QAfterFilterCondition> totalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AllQuestionsQueryObject
    on QueryBuilder<AllQuestions, AllQuestions, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ContestRankingSchema = Schema(
  name: r'ContestRanking',
  id: 4646034527870529585,
  properties: {
    r'attendedContestsCount': PropertySchema(
      id: 0,
      name: r'attendedContestsCount',
      type: IsarType.long,
    ),
    r'globalRanking': PropertySchema(
      id: 1,
      name: r'globalRanking',
      type: IsarType.long,
    ),
    r'rating': PropertySchema(
      id: 2,
      name: r'rating',
      type: IsarType.double,
    ),
    r'topPercentage': PropertySchema(
      id: 3,
      name: r'topPercentage',
      type: IsarType.double,
    ),
    r'totalParticipants': PropertySchema(
      id: 4,
      name: r'totalParticipants',
      type: IsarType.long,
    )
  },
  estimateSize: _contestRankingEstimateSize,
  serialize: _contestRankingSerialize,
  deserialize: _contestRankingDeserialize,
  deserializeProp: _contestRankingDeserializeProp,
);

int _contestRankingEstimateSize(
  ContestRanking object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _contestRankingSerialize(
  ContestRanking object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attendedContestsCount);
  writer.writeLong(offsets[1], object.globalRanking);
  writer.writeDouble(offsets[2], object.rating);
  writer.writeDouble(offsets[3], object.topPercentage);
  writer.writeLong(offsets[4], object.totalParticipants);
}

ContestRanking _contestRankingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContestRanking(
    attendedContestsCount: reader.readLongOrNull(offsets[0]) ?? 0,
    globalRanking: reader.readLongOrNull(offsets[1]) ?? 0,
    rating: reader.readDoubleOrNull(offsets[2]) ?? 0,
    topPercentage: reader.readDoubleOrNull(offsets[3]) ?? 100,
    totalParticipants: reader.readLongOrNull(offsets[4]),
  );
  return object;
}

P _contestRankingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 100) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ContestRankingQueryFilter
    on QueryBuilder<ContestRanking, ContestRanking, QFilterCondition> {
  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      attendedContestsCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attendedContestsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      attendedContestsCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attendedContestsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      attendedContestsCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attendedContestsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      attendedContestsCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attendedContestsCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      globalRankingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'globalRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      globalRankingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'globalRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      globalRankingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'globalRanking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      globalRankingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'globalRanking',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      ratingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      ratingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      ratingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      ratingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      topPercentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      topPercentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      topPercentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      topPercentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalParticipants',
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalParticipants',
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalParticipants',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalParticipants',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalParticipants',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestRanking, ContestRanking, QAfterFilterCondition>
      totalParticipantsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalParticipants',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContestRankingQueryObject
    on QueryBuilder<ContestRanking, ContestRanking, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ContestSummarySchema = Schema(
  name: r'ContestSummary',
  id: 4664527265986857673,
  properties: {
    r'finishTimeInSeconds': PropertySchema(
      id: 0,
      name: r'finishTimeInSeconds',
      type: IsarType.long,
    ),
    r'problemsSolved': PropertySchema(
      id: 1,
      name: r'problemsSolved',
      type: IsarType.long,
    ),
    r'ranking': PropertySchema(
      id: 2,
      name: r'ranking',
      type: IsarType.long,
    ),
    r'rating': PropertySchema(
      id: 3,
      name: r'rating',
      type: IsarType.double,
    ),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalProblems': PropertySchema(
      id: 6,
      name: r'totalProblems',
      type: IsarType.long,
    )
  },
  estimateSize: _contestSummaryEstimateSize,
  serialize: _contestSummarySerialize,
  deserialize: _contestSummaryDeserialize,
  deserializeProp: _contestSummaryDeserializeProp,
);

int _contestSummaryEstimateSize(
  ContestSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _contestSummarySerialize(
  ContestSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.finishTimeInSeconds);
  writer.writeLong(offsets[1], object.problemsSolved);
  writer.writeLong(offsets[2], object.ranking);
  writer.writeDouble(offsets[3], object.rating);
  writer.writeLong(offsets[4], object.startTime);
  writer.writeString(offsets[5], object.title);
  writer.writeLong(offsets[6], object.totalProblems);
}

ContestSummary _contestSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContestSummary(
    finishTimeInSeconds: reader.readLongOrNull(offsets[0]),
    problemsSolved: reader.readLongOrNull(offsets[1]),
    ranking: reader.readLongOrNull(offsets[2]),
    rating: reader.readDoubleOrNull(offsets[3]),
    startTime: reader.readLongOrNull(offsets[4]),
    title: reader.readStringOrNull(offsets[5]),
    totalProblems: reader.readLongOrNull(offsets[6]) ?? 4,
  );
  return object;
}

P _contestSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 4) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ContestSummaryQueryFilter
    on QueryBuilder<ContestSummary, ContestSummary, QFilterCondition> {
  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishTimeInSeconds',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishTimeInSeconds',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishTimeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishTimeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishTimeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      finishTimeInSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishTimeInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'problemsSolved',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'problemsSolved',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      problemsSolvedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemsSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ranking',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ranking',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ranking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ranking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ranking',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      rankingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ranking',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      ratingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      startTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      totalProblemsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProblems',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      totalProblemsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProblems',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      totalProblemsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProblems',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestSummary, ContestSummary, QAfterFilterCondition>
      totalProblemsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProblems',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContestSummaryQueryObject
    on QueryBuilder<ContestSummary, ContestSummary, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SubmissionCalendarDateSchema = Schema(
  name: r'SubmissionCalendarDate',
  id: 6838790401759101293,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'submissions': PropertySchema(
      id: 1,
      name: r'submissions',
      type: IsarType.long,
    )
  },
  estimateSize: _submissionCalendarDateEstimateSize,
  serialize: _submissionCalendarDateSerialize,
  deserialize: _submissionCalendarDateDeserialize,
  deserializeProp: _submissionCalendarDateDeserializeProp,
);

int _submissionCalendarDateEstimateSize(
  SubmissionCalendarDate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _submissionCalendarDateSerialize(
  SubmissionCalendarDate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.submissions);
}

SubmissionCalendarDate _submissionCalendarDateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubmissionCalendarDate(
    date: reader.readDateTimeOrNull(offsets[0]),
    submissions: reader.readLongOrNull(offsets[1]),
  );
  return object;
}

P _submissionCalendarDateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SubmissionCalendarDateQueryFilter on QueryBuilder<
    SubmissionCalendarDate, SubmissionCalendarDate, QFilterCondition> {
  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'submissions',
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'submissions',
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'submissions',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'submissions',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'submissions',
        value: value,
      ));
    });
  }

  QueryBuilder<SubmissionCalendarDate, SubmissionCalendarDate,
      QAfterFilterCondition> submissionsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'submissions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SubmissionCalendarDateQueryObject on QueryBuilder<
    SubmissionCalendarDate, SubmissionCalendarDate, QFilterCondition> {}
