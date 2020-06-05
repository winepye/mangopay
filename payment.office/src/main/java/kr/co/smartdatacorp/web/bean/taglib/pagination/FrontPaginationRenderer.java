package kr.co.smartdatacorp.web.bean.taglib.pagination;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

/**
 *
 * @author
 */
public class FrontPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware {

	private ServletContext servletContext;

	public FrontPaginationRenderer() {

	}

	public void initVariables() {
		// String contextPath = servletContext.getContextPath();
	    firstPageLabel    = "<button type='button' class='pre_end_btn' onclick=\"{0}({1},this)\"><em>맨처음 페이지</em></button>";
        previousPageLabel = "<button type='button' class='pre_btn' onclick=\"{0}({1},this)\"><em>이전 페이지</em></button>";
		currentPageLabel = "<span class=\"current\"><a>{0}</a></span> ";
		otherPageLabel = "<span class=\"first\"><a href=\"javascript:{0}({1})\">{2}</a></span> ";
		nextPageLabel     = "<button type='button' class='next_btn' onclick=\"{0}({1},this)\"><em>다음 페이지</em></button>";
        lastPageLabel     = "<button type='button' class='next_end_btn' onclick=\"{0}({1},this)\"><em>맨마지막 페이지</em></button>";
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
