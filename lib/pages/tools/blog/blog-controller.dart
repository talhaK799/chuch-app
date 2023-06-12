import 'package:churchappenings/api/blog.dart';
import 'package:churchappenings/pages/tools/blog/publisher/blog-publisher-page.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  bool loading = true;
  String title = '';

  BlogAPI blogAPI = BlogAPI();
  var blogs;

  onInit() async {
    title = Get.arguments['blogName'];
    blogs = await blogAPI.getBlogByCategories(title);
    loading = false;
    update();

    super.onInit();
  }

  navigateToPublisherPortal() {
    Get.to(BlogPublisherPage());
  }
}
