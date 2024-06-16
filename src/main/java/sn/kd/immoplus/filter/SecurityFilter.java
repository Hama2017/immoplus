package sn.kd.immoplus.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sn.kd.immoplus.model.User;

import java.io.IOException;

@WebFilter("/*")
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre si nécessaire
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestURI = httpRequest.getRequestURI();


        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String path = req.getRequestURI();
        String action = req.getParameter("action");

        // Récupérer le segment "user" à partir de l'URI
        String[] parts = path.split("/");
        String controllerName = parts.length > 1 ? parts[2] : "";

//       if (user==null) {
//
//            switch (controllerName) {
//                case "user":
//                    switch (action) {
//                        case "register":
//                            res.sendRedirect(req.getContextPath() + "/user?action=login");
//                            return;
//                    }
//                    break;
//            }
//
//        }else if (user != null) {
//            String role = user.getRole();
//
//        }

        chain.doFilter(request, response);


    }

    private boolean isPublicPage(String controllerName, String action) {
        // Pages publiques accessibles sans authentification
        return "user".equals(controllerName) &&
                ("login".equals(action) || "register".equals(action));
    }

    private boolean isRestrictedPage(String controllerName, String action, String role) {
        // Restrictions basées sur les rôles
        if ("admin".equals(controllerName) && !"ADMIN".equals(role)) {
            return true;
        } else if ("user".equals(controllerName) && !"USER".equals(role) && !"ADMIN".equals(role)) {
            return true;
        }
        return false;
    }

    @Override
    public void destroy() {
        // Nettoyage du filtre si nécessaire
    }
}
