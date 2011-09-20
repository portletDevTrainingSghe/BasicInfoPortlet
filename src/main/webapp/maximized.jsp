<%@page language="java"%>
<%@page import="javax.portlet.RenderRequest, java.util.Map, java.util.Map.Entry, java.util.Enumeration, com.liferay.portal.service.RoleLocalServiceUtil, java.util.List, com.liferay.portal.model.Role"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects/>

<h4>Welcome to the <%=portletConfig.getPortletName()%> -- MAXimized Version</h4>

<script type="text/javascript">
    jQuery().ready(function () {
        jQuery("#accordion").accordion({
            header: 'h3',
            autoHeight: false,
            active: false,
            collapsible: true
        });
    });

</script>

<div id="accordion">
    <h3><a href="#">General Request Properties</a></h3>
    <div>
        <dl>
            <dt>authType</dt>
            <dd><%=renderRequest.getAuthType()%></dd>
            <dt>contextPath</dt>
            <dd><%=renderRequest.getContextPath()%></dd>
            <dt>cookies</dt>
            <dd><%=renderRequest.getCookies()%></dd>
            <dt>locale</dt>
            <dd><%=renderRequest.getLocale()%></dd>
            <dt>portletMode</dt>
            <dd><%=renderRequest.getPortletMode()%></dd>
            <dt>remoteUser</dt>
            <dd><%=renderRequest.getRemoteUser()%></dd>
            <dt>requestedSessionId</dt>
            <dd><%=renderRequest.getRequestedSessionId()%></dd>
            <dt>responseContentType</dt>
            <dd><%=renderRequest.getResponseContentType()%></dd>
            <dt>scheme</dt>
            <dd><%=renderRequest.getScheme()%></dd>
            <dt>serverName</dt>
            <dd><%=renderRequest.getServerName()%></dd>
            <dt>serverPort</dt>
            <dd><%=renderRequest.getServerPort()%></dd>
            <dt>userPrincipal</dt>
            <dd><%=renderRequest.getUserPrincipal()%></dd>
            <dt>windowID</dt>
            <dd><%=renderRequest.getWindowID()%></dd>
            <dt>windowState</dt>
            <dd><%=renderRequest.getWindowState()%></dd>
            <dt>isRequestedSessionIdValid</dt>
            <dd><%=renderRequest.isRequestedSessionIdValid()%></dd>
            <dt>isSecure</dt>
            <dd><%=renderRequest.isSecure()%></dd>
        </dl>
    </div>
    <h3><a href="#">Portlet Configuration</a></h3>
    <div>
        <dl>
            <dt>containerRuntimeOptions</dt>
            <dd><%=portletConfig.getContainerRuntimeOptions()%></dd>
            <dt>defaultNamespace</dt>
            <dd><%=portletConfig.getDefaultNamespace()%></dd>
            <dt>initParameters</dt>
            <dd>
                <dl>
                    <%
                    Enumeration<String> initParamNames = portletConfig.getInitParameterNames();
                    while(initParamNames.hasMoreElements()) {
                        String initParamName = initParamNames.nextElement();
                        %><dt><%=initParamName%></dt><%
                        %><dd><%=portletConfig.getInitParameter(initParamName)%></dd><%
                    }
                    %>
                </dl>
            </dd>
            <dt>portletName</dt>
            <dd><%=portletConfig.getPortletName()%></dd>
            <dt>supportedLocales</dt>
            <dd>
                <%
                Enumeration<java.util.Locale> locales = portletConfig.getSupportedLocales();
                while(locales.hasMoreElements()) {
                    java.util.Locale locale = locales.nextElement();
                    %><%=locale%> <%
                }
                %>
            </dd>
        </dl>
    </div>
    <h3><a href="#">Request Attributes</a></h3>
    <div>
        <dl>
            <%
            Enumeration<String> attrNames = renderRequest.getAttributeNames();
            while(attrNames.hasMoreElements()) {
                String attrName = attrNames.nextElement();
                %><dt><%=attrName%></dt><%
                %><dd><%=renderRequest.getAttribute(attrName)%></dd><%
            }
            %>
        </dl>
    </div>
    <h3><a href="#">Portlet Preferences</a></h3>
    <div>
        <dl>
            <%
            Enumeration<String> names = renderRequest.getPreferences().getNames();
            while(names.hasMoreElements()) {
                String name = names.nextElement();
                boolean isReadOnly = renderRequest.getPreferences().isReadOnly(name);

                %><dt><%=name%><%=isReadOnly ? " (read-only)" : ""%><dt><%

                String[] values = renderRequest.getPreferences().getValues(name, null);
                if(values != null && values.length > 0) {
                    if(values.length > 1) {
                        for(int i = 0; i < values.length; i++) {
                            %><dd>[<%=i%>] <%=values[i]%></dd><%
                        }
                    }
                    else {
                        %><dd><%=values[0]%></dd><%
                    }
                }
                else {
                    %><dd>null</dd><%
                }

            }
            %>
        </dl>
    </div>
    <h3><a href="#">User Attributes</a></h3>
    <div>
        <%
        Map<String, String> attributes =
                (Map<String, String>) renderRequest.getAttribute(RenderRequest.USER_INFO);

				
				
        if(attributes != null && attributes.size() > 0) {
            %><dl><%
            for(Entry<String, String> entry : attributes.entrySet()) {
                %><dt><%=entry.getKey()%></dt><%
                %><dd><%=entry.getValue()%></dd><%
            }
            %></dl><%
        }
        else {
            %>
            <div class="portlet-msg-info">No USER_INFO attributes available.</div>
            <%
        }
        %>

    </div>
</div>
