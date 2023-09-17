// import 'package:graphql/client.dart';
// 
// class Graphql {
//   static final _httpLink = HttpLink(
//     'https://leetcode.com/graphql',
//   );

//   static GraphQLClient client = GraphQLClient(
//     /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
//     cache: GraphQLCache(),
//     link: _httpLink,
//   );
// }

// String queryString = '''query questionOfToday {
//         activeDailyCodingChallengeQuestion {
//           date
//           userStatus
//           link
//           question{
//             acRate
//             difficulty
//             freqBar
//             frontendQuestionId: questionFrontendId
//             isFavor
//             paidOnly: isPaidOnly
//             status
//             title
//             titleSlug
//             hasVideoSolution
//             hasSolution
//             topicTags {
//               name
//               id
//               slug
//             }
//           }
//         }
//       }''';
// //variables":{},"operationName":"questionOfToday"}''';

// final QueryOptions options = QueryOptions(
//   document: gql(queryString),
// );

// Future<void> main(List<String> args) async {
//   var result = await Graphql.client.query(options);

//   print(result.data?['activeDailyCodingChallengeQuestion']);
// }
