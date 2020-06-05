package kr.co.smartdatacorp.web.bean.taglib.pagination;

import java.text.MessageFormat;

import kr.co.smartdatacorp.core.vo.common.BaseCriteria;

/**
 * 인터페이스 PaginationRenderer의 구현 추상클래스. <br />
 * <code>[처음][이전] 1 2 3 4 5 6 7 8 [다음][마지막]</code> <br />
 *
 * 클래스 변수들이 각 element와 매핑이 되는데,
 *
 * <pre>
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
public abstract class AbstractPaginationRenderer implements PaginationRenderer {

	protected String firstPageLabel;

	protected String previousPageLabel;

	protected String currentPageLabel;

	protected String otherPageLabel;

	protected String nextPageLabel;

	protected String lastPageLabel;

	public String renderPagination(BaseCriteria paginationInfo, String jsFunction) {

		int firstPageNo = paginationInfo.getFirstPageNo();
		int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
		int totalPageCount = paginationInfo.getTotalPageCount();
		int pageSize = paginationInfo.getPageSize();
		int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
		int currentPageNo = paginationInfo.getCurrentPageNo();
		int lastPageNo = paginationInfo.getLastPageNo();

		StringBuilder buffer = new StringBuilder();
		if (totalPageCount > pageSize) {
			if (firstPageNoOnPageList > pageSize) {
				buffer.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
				buffer.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList - 1) }));
			}
			else {
				// buffer.append(MessageFormat.format(firstPageLabel, new
				// Object[] { jsFunction, Integer.toString(firstPageNo) }));
				// buffer.append(MessageFormat.format(previousPageLabel, new
				// Object[] { jsFunction, Integer.toString(firstPageNo) }));
			}
		}
		int j = 0;
		for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
			if (i == currentPageNo) {
				buffer.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
			}
			else {
			    if(j==0){
			        String firstOther = otherPageLabel.replace("<li>", "<li class=\"firstPage\">");
			        buffer.append(MessageFormat.format(firstOther, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
			    }else{
			        buffer.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
			    }
			}
			j++;
		}

		if (totalPageCount > pageSize) {
			if (lastPageNoOnPageList < totalPageCount) {
				buffer.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList + pageSize) }));
				buffer.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
			}
			else {
				// buffer.append(MessageFormat.format(nextPageLabel, new
				// Object[] { jsFunction, Integer.toString(lastPageNo) }));
				// buffer.append(MessageFormat.format(lastPageLabel, new
				// Object[] { jsFunction, Integer.toString(lastPageNo) }));
			}
		}
		return buffer.toString();
	}

}
