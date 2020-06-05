package kr.co.smartdatacorp.web.bean.taglib.code;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.co.smartdatacorp.core.vo.code.CodeVo;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CodeUtil;

public class CodeTag extends TagSupport {
    private static final long serialVersionUID = -234908230147803248L;

    private final Log log = LogFactory.getLog(this.getClass());

    private enum Type {
        select,
        checkbox,
        radio,
        text
    }

    private String type;

    private String name;

    private String subjectText;

    private static final String SUBJECT_VALUE = "";

    private String attr;

    private String cdGrp;

    private String cd;

    private String labelAttr;

    private String prefix;

    private String postfix;

    private String useType = Constants.YES_NO_Y;

    private List<String> cdList = new ArrayList<String>();

    public void setType(String type) {
        this.type = type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSubjectText(String subjectText) {
        this.subjectText = subjectText;
    }

    public void setAttr(String attr) {
        this.attr = attr;
    }

    public void setCdGrp(String cdGrp) {
        this.cdGrp = cdGrp;
    }

    public void setCd(String cd) {
        this.cd = cd;

        if(cd.indexOf(",") > 1){
            String[] cdArray = cd.split(",");

            for(int i = 0; i < cdArray.length; i++){
                cdList.add(cdArray[i]);
            }
        }
    }

    public void setLabelAttr(String labelAttr) {
        this.labelAttr = labelAttr;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public void setPostfix(String postfix) {
        this.postfix = postfix;
    }

    @Override
    public int doStartTag() throws JspTagException {
        return SKIP_BODY;
    }

    @Override
    public int doEndTag() throws JspTagException {

        type = type.toLowerCase();

        Type t;
        try {
            t = Type.valueOf(type);
        }
        catch (IllegalArgumentException e) {
            throw new JspTagException("CodeTag : 지원하지 않는 type입니다.");
        }

        StringBuffer printValue = new StringBuffer();
        if (Type.select.equals(t)) {
            try {
				printValue.append(getSelectTag());
			} catch (Exception e) {
				throw new JspTagException("CodeTag : Select Tag 생성할수 없습니다.");
			}
        }
        else if (Type.radio.equals(t) || Type.checkbox.equals(t)) {
            try {
				printValue.append(getCheckboxTag());
			} catch (Exception e) {
				throw new JspTagException("CodeTag : Checkbox Tag 생성할수 없습니다.");
			}
        }
        else if (Type.text.equals(t)) {
            printValue.append(getCodeName());
        }

        try {
            pageContext.getOut().print(printValue.toString());
        }
        catch (IOException e) {
            throw new JspTagException(e);
        }

        return EVAL_PAGE;
    }

    private String resolveCheckedOption(String compareCd) {
        String option = "";

        if (StringUtils.equals(cd, compareCd)) {
            if (StringUtils.equalsIgnoreCase(type, "select")) {
                option = "selected";
            }
            else {
                option = "checked";
            }
        }

        return option;
    }

    private String getSelectTag() throws Exception {
        StringBuffer printValue = new StringBuffer();
        printValue.append("<select");
        printValue.append(StringUtils.isNotBlank(name) ? " name=\"" + name + "\"" : "");
        printValue.append(StringUtils.isNotBlank(id) ? " id=\"" + id + "\"" : "");
        printValue.append(StringUtils.isNotBlank(attr) ? " " + attr : "");
        printValue.append(">");

        if (StringUtils.isNotEmpty(subjectText)) {
            printValue.append("<option value=\"" + StringUtils.defaultIfBlank(SUBJECT_VALUE, "") + "\">");
            printValue.append(subjectText);
            printValue.append("</option>");
        }

        List<CodeVo> codeVolist = CodeUtil.getInstance().getCodeVoList(cdGrp);

        for (CodeVo codeVo : codeVolist) {

            if(useType!=null&&!useType.equals(Constants.USE_TYPE_A)&&!useType.equals(codeVo.getUseYn())) continue;

            printValue.append("<option value=\"" + codeVo.getCd() + "\" ");
            printValue.append(resolveCheckedOption(codeVo.getCd()));
            printValue.append(">");
            printValue.append(codeVo.getCdNm());
            printValue.append("</option>");
        }

        printValue.append("</select>");

        return printValue.toString();
    }

    private String getCheckboxTag() throws Exception {
        List<CodeVo> codeVolist = CodeUtil.getInstance().getCodeVoList(cdGrp);

        String key = StringUtils.isNotBlank(id) ? id : "" + System.nanoTime();

        StringBuffer printValue = new StringBuffer();
        List<String> verifyCode = this.cdList;
        int length = codeVolist.size();
        for (int i = 0; i < length; i++) {
            CodeVo codeVo = codeVolist.get(i);

            if(useType!=null&&!useType.equals(Constants.USE_TYPE_A)&&!useType.equals(codeVo.getUseYn())) continue;

            String idForLabel = key + i;

            printValue.append(StringUtils.isNotBlank(prefix) ? prefix : "");
            printValue.append("<label for=\"" + idForLabel + "\" " + (StringUtils.isNotBlank(labelAttr) ? labelAttr : "") + ">");
            printValue.append("<input type=\"" + type.toLowerCase() + "\"");
            printValue.append(" id=\"" + idForLabel + "\"");
//            printValue.append(StringUtils.isNotBlank(name) ? " name=\"" + name + "_" + i + "\"" : "");
            printValue.append(StringUtils.isNotBlank(name) ? " name=\"" + name + "\"" : "");
//            printValue.append(StringUtils.isNotBlank(name) ? " id =\"" + name + "\"" : "");
            printValue.append(StringUtils.isNotBlank(attr) ? " " + attr : "");
            printValue.append(" value=\"" + codeVo.getCd() + "\" ");
            printValue.append(resolveCheckedOption(codeVo.getCd()));
            if (verifyCode != null){
	            for (int j = 0; j < verifyCode.size(); j++) {
	            	if (StringUtils.equals(codeVo.getCd(), verifyCode.get(j))){
	            	    printValue.append(" checked=\"checked\" ");
	            	}
				}
            }

            printValue.append("/>");
            printValue.append(" " + codeVo.getCdNm());
            printValue.append("</label>");
            printValue.append(StringUtils.isNotBlank(postfix) ? postfix : "");
            printValue.append("\n");
        }

        return printValue.toString();
    }

    private String getCodeName() {
        String codeName = "";

        try {
            codeName = CodeUtil.getInstance().getCodeName(cdGrp, cd);
        }
        catch (Exception e) {
            //e.printStackTrace();
            log.error(e.getMessage());
        }

        return codeName;
    }

	public List<String> getCodeVoList() {
		return cdList;
	}

	public void setCodeVoList(List<String> cdList) {
		this.cdList = cdList;
	}

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType;
    }



}
