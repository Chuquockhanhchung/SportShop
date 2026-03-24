package filter;

import dao.FooterDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class FooterDataFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            FooterDAO dao = new FooterDAO();
            request.setAttribute("footerSettings", dao.getSettings());
            request.setAttribute("footerSocialLinks", dao.getLinksByType("social"));
            request.setAttribute("footerQuickLinks", dao.getLinksByType("quick"));
            request.setAttribute("footerServiceLinks", dao.getLinksByType("service"));
        } catch (Exception ignore) {}
        chain.doFilter(request, response);
    }
}