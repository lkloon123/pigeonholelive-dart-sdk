import 'package:pigeonholelive_sdk/src/exceptions/no_next_page_exception.dart';
import 'package:pigeonholelive_sdk/src/models/pagination/pagination_result.dart';

class PaginationHelper<T extends PaginationResult> {
  T paginationResult;

  PaginationHelper({required this.paginationResult});

  T setNextPage(NextPageCallback<T> callback) {
    if (paginationResult.paginationMeta?.hasMore ?? false) {
      paginationResult.nextPage = callback;
    } else {
      paginationResult.nextPage = () {
        throw NoNextPageException();
      };
    }

    return paginationResult;
  }
}
