package kr.co.smartdatacorp.web.bean.taglib.baseValue;

import java.util.Map;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

import kr.co.smartdatacorp.core.bean.util.BaseValueMstrUtil;

public class BaseValueTag extends TagSupport{

    private String var;
    private String scope;

    public String getScope()
    {
        return scope;
    }

    public void setScope(String scope)
    {
        this.scope = scope;
    }

    public String getVar()
    {
        return var;
    }

    public void setVar(String var)
    {
        this.var = var;
    }

    public int doStartTag() throws JspException
    {
        int scope = BaseValueTag.getScope(this.scope, 1);
 
        try
        {
            Map baseValue = BaseValueMstrUtil.getInstance().getBaseValueMstrListAll(); 

            if(baseValue != null && !baseValue.isEmpty())
                pageContext.setAttribute(var, baseValue, scope);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            throw new JspTagException("Illegal access: ");
        }

        return 0;
    }

    public void release()
    {
        super.release();
        scope = null;
        var = null;
    }

    public static int getScope(String scope, int defaultScope)
        throws JspException
    {
        int pcscope;
        if(scope == null)
            switch(defaultScope)
            {
            case 1: // '\001'
            case 2: // '\002'
            case 3: // '\003'
            case 4: // '\004'
                pcscope = defaultScope;
                break;

            default:
                throw new JspTagException("Invalid default scope: " + defaultScope);
            }
        else
        if("page".equals(scope))
            pcscope = 1;
        else
        if("request".equals(scope))
            pcscope = 2;
        else
        if("session".equals(scope))
            pcscope = 3;
        else
        if("application".equals(scope))
            pcscope = 4;
        else
            throw new JspTagException("Invalid scope name: " + scope);
        return pcscope;
    }
}
