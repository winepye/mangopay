package kr.co.smartdatacorp.web.bean.taglib.pagination;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.vo.common.BaseCriteria;

/**
 * 페이징을 위한 Tag class <br />
 * 실제 페이징을 위한 작업은 PaginationRenderer에게 위임한다. <br />
 * 어떤 PaginationRenderer를 사용할지는 PaginationManager에게 위임하는데, PaginationManager는 빈
 * 설정 파일의 정보와 태그의 type 속성값을 비교하여 PaginationRenderer을 결정한다.
 *
 * @author
 */
@SuppressWarnings("serial")
public class PaginationTag extends TagSupport {

	private static final String PAGINATION_MANAGER = "paginationManager";

	private BaseCriteria paginationInfo;

	private String type;

	private String jsFunction;

	public int doEndTag() throws JspException {
		try {
		    if(!paginationInfo.getPagingYn().equals(Constants.YES_NO_Y)) return 0;
			JspWriter out = pageContext.getOut();
			WebApplicationContext ctx = RequestContextUtils.getWebApplicationContext(pageContext.getRequest(), pageContext.getServletContext());

			PaginationManager paginationManager;
			if (ctx.containsBean(PAGINATION_MANAGER)) {
				paginationManager = (PaginationManager) ctx.getBean(PAGINATION_MANAGER);
			}
			else {
				paginationManager = new DefaultPaginationManager();
			}

			PaginationRenderer renderer = paginationManager.getRendererType(type);
			String contents = renderer.renderPagination(paginationInfo, jsFunction);
			String returnContents = "<ul>"+contents+"</ul>";
			out.println(returnContents);
		}
		catch (IOException e) {
			e.printStackTrace();
			throw new JspException();
		}
		return EVAL_PAGE;
	}

	public void setJsFunction(String jsFunction) {
		this.jsFunction = jsFunction;
	}

    public void setPaginationInfo(BaseCriteria paginationInfo) {
        this.paginationInfo = paginationInfo;
    }

    public void setType(String type) {
		this.type = type;
	}

}
