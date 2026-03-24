package controller;

import dao.FooterDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import model.FooterSettings;
import model.FooterLink;

@WebServlet("/footer")
public class FooterAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FooterDAO dao = new FooterDAO();
            request.setAttribute("footerSettings", dao.getSettings());
            request.setAttribute("footerSocialLinks", dao.getLinksByType("social"));
            request.setAttribute("footerQuickLinks", dao.getLinksByType("quick"));
            request.setAttribute("footerServiceLinks", dao.getLinksByType("service"));
            request.getRequestDispatcher("admin_footer.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FooterDAO dao = new FooterDAO();

            FooterSettings f = new FooterSettings();
            f.setDescription(request.getParameter("description"));
            f.setAddress(request.getParameter("address"));
            f.setPhone(request.getParameter("phone"));
            f.setEmail(request.getParameter("email"));
            f.setHours(request.getParameter("hours"));
            f.setCopyright(request.getParameter("copyright"));
            dao.updateSettings(f);

            dao.replaceLinks("social", buildLinks(request, "social"));
            dao.replaceLinks("quick", buildLinks(request, "quick"));
            dao.replaceLinks("service", buildLinks(request, "service"));

            response.sendRedirect("footer");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private List<FooterLink> buildLinks(HttpServletRequest request, String prefix) {
        String[] labels = request.getParameterValues(prefix + "Label");
        String[] urls = request.getParameterValues(prefix + "Url");
        String[] icons = request.getParameterValues(prefix + "Icon");

        List<FooterLink> list = new ArrayList<>();
        if (labels == null) return list;
        for (int i = 0; i < labels.length; i++) {
            FooterLink l = new FooterLink();
            l.setLabel(labels[i]);
            l.setUrl(urls != null && i < urls.length ? urls[i] : "");
            l.setIcon(icons != null && i < icons.length ? icons[i] : "");
            list.add(l);
        }
        return list;
    }
}