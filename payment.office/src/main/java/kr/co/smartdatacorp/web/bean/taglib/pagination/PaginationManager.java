package kr.co.smartdatacorp.web.bean.taglib.pagination;

/**
 * <pre>
 * PaginationRenderer의 구현체를 빈설정 파일을 참조하여 반환한다. 
 * 이는 이미지, 텍스트등 여러 포맷으로 보여줄 필요성이 있을 경우, 각 type의 구현클래스를 사용자가 지정하고 
 * Tag사용시에 type을 자유롭게 정하여 사용하기 위함이다.
 *                
 * 아래의 예와 같이 프로퍼티 rendererType에 여러 PaginationRenderer을 설정하면,
 * 페이징을 위한 태그인 <ui:pagination type="..."/>에서 사용자가 사용하려는 PaginationRenderer의 key값을 type 속성값으로 주면 된다.
 * </pre>
 * 
 * <pre class="code">
 * &lt;bean id="imageRenderer" class="com.maxmovie.commons.web.pagination.ImagePaginationRenderer"/&gt;
 * &lt;bean id="textRenderer" class="com.maxmovie.commons.web.pagination.TextPaginationRenderer"/&gt;	
 * &lt;bean id="paginationManager" class="com.maxmovie.commons.web.pagination.DefaultPaginationManager"&gt;
 *     &lt;property name="rendererType"&gt;
 *        &lt;map&gt;
 *           &lt;entry key="image" value-ref="imageRenderer"/&gt;
 *           &lt;entry key="text" value-ref="textRenderer"/&gt;
 *        &lt;/map&gt;
 *     &lt;/property&gt;
 * &lt;/bean&gt;
 * </pre>
 * 
 * @author
 */
public interface PaginationManager {

	public PaginationRenderer getRendererType(String type);

}
