package kr.co.smartdatacorp.web.bean.taglib.pagination;

import kr.co.smartdatacorp.core.vo.common.BaseCriteria;

/**
 * 페이징 리스트의 기본적인 포맷을 제공. <br />
 * <code>[처음][이전] 1 2 3 4 5 6 7 8 [다음][마지막]</code>
 *
 * <pre>
 * 클래스 변수들이 각 element와 다음과 같이 매핑이 된다.
 * firstPageLabel = [처음]
 * previousPageLabel = [이전]
 * currentPageLabel = 현재 페이지 번호
 * otherPageLabel = 현재 페이지를 제외한 페이지 번호
 * nextPageLabel = [다음]
 * lastPageLabel = [마지막]
 * </pre>
 *
 * @author
 */
public class AdminPaginationRenderer extends AbstractPaginationRenderer {

	public AdminPaginationRenderer() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">[처음]</a>&#160;";
		previousPageLabel = "<a class=\"pre\" href=\"#\" onclick=\"{0}({1}); return false;\">[이전]</a>&#160;";
		currentPageLabel = "<strong>{0}</strong>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a class=\"next\" href=\"#\" onclick=\"{0}({1}); return false;\">[다음]</a>&#160;";
		lastPageLabel = "<a class=\"next_end\" href=\"#\" onclick=\"{0}({1}); return false;\">[마지막]</a>&#160;";
	}

	@Override
	public String renderPagination(BaseCriteria paginationInfo, String jsFunction) {
		return super.renderPagination(paginationInfo, jsFunction);
	}

}
