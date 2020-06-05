package kr.co.smartdatacorp.web.controller.common;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.context.MessageSource;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;

public class BaseController {
	@Resource(name = "messageSource")
	public MessageSource messageSource;

    @Autowired public ObjectFactory<LoginSessionInfo> loginSessionInfoFactory;

}
