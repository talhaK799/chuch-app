import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class BlogAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> getBlogCategories() async {
    String query = """
      query MyQuery {
        blog_category {
          name
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["blog_category"];
  }

  Future<dynamic> getBlogByCategories(String category) async {
    print(category);
    String query = """
      query MyQuery(\$id: String!) {
        blog(order_by: {created_at: desc}, where: {category: {_eq: \$id}, published: {_eq: true}}, limit: 100) {
          id
          name
          created_at
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": category,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["blog"];
  }

  Future<dynamic> createBlog(String name) async {
    String query = """
      mutation MyMutation(\$facility_id: Int!, \$name: String!, \$member_id: Int) {
        insert_blog(objects: {name: \$name, facility_id: \$facility_id, member_id: \$member_id}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "facility_id": profileApi.selectedChurchId,
      "name": name,
      "member_id": profileApi.memberId,
    };

    var res = await hasura.hasuraMutation(query, variables);
    return res["data"]["insert_blog"]["returning"][0]["id"];
  }

  Future<dynamic> getPublisherBlogs() async {
    String query = """
      query MyQuery(\$id: Int!) {
        blog(order_by: {created_at: desc}, where: {member_id: {_eq: \$id}}) {
          category
          name
          published
          id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.memberId,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["blog"];
  }

  Future<dynamic> getSingleBlog(int id) async {
    String query = """
      query MyQuery(\$id: Int!) {
        blog(where: {id: {_eq: \$id}}) {
          id
          created_at
          content
          name
          no_data
          published
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["blog"][0];
  }

  Future<dynamic> saveBlog(
    int id,
    String name,
    dynamic content,
    String category,
  ) async {
    String query = """
      mutation MyMutation(\$id: Int!, \$name: String!, \$content: jsonb!, \$category: String!) {
        update_blog(where: {id: {_eq: \$id}}, _set: {content: \$content, category: \$category, name: \$name, no_data: false}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
      "name": name,
      "content": content,
      "category": category,
    };

    await hasura.hasuraMutation(query, variables);
  }

  Future<dynamic> togglePublishBlog(
    int id,
    bool published,
  ) async {
    String query = """
      mutation MyMutation(\$id: Int!, \$published: Boolean!) {
        update_blog(where: {id: {_eq: \$id}}, _set: {published: \$published}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
      "published": !published,
    };

    var res = await hasura.hasuraMutation(query, variables);
    print(res);
  }
}
