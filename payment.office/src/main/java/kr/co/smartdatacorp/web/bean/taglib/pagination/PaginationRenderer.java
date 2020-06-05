package kr.co.smartdatacorp.web.bean.taglib.pagination;

import kr.co.smartdatacorp.core.vo.common.BaseCriteria;

public interface PaginationRenderer {

	public String renderPagination(BaseCriteria page, String jsFunction);

}
