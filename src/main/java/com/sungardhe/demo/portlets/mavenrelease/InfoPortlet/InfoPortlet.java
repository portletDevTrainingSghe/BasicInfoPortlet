package com.sungardhe.demo.portlets.mavenrelease.InfoPortlet;

/*
 * Copyright 2001-2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.IOException;
import javax.portlet.PortletConfig;
import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.WindowState;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class InfoPortlet extends GenericPortlet {

    private static final Log log = LogFactory.getLog(InfoPortlet.class);
    
	private static final String NORMAL_VIEW = "/normal.jsp";
    private static final String MAXIMIZED_VIEW = "/maximized.jsp";

    private PortletRequestDispatcher normalView;
    private PortletRequestDispatcher maximizedView;

    public void doView( RenderRequest request, RenderResponse response )
        throws PortletException, IOException {

    	long clock = System.currentTimeMillis();
    	
    	try {
            System.out.println("hi: " + clock);
            log.debug("Rendering view.");
            
	        if( WindowState.MINIMIZED.equals( request.getWindowState() ) ) {
	            return;
	        }
	
	        if ( WindowState.NORMAL.equals( request.getWindowState() ) ) {
	            normalView.include( request, response );
	        } else {
	            maximizedView.include( request, response );
	        }
    	} 
    	finally {
    		long duration = System.currentTimeMillis() - clock;
            log.debug(String.format("View rendering took %s ms.", duration));
    	}
    }


    public void init( PortletConfig config ) throws PortletException {

        long clock = System.currentTimeMillis();
        try {
        	log.debug("Initializing InfoPortlet");
            super.init( config );

            normalView = config.getPortletContext().getRequestDispatcher( NORMAL_VIEW );
            maximizedView = config.getPortletContext().getRequestDispatcher( MAXIMIZED_VIEW );
        } 
        finally {
        	long duration = System.currentTimeMillis() - clock;
        	log.debug(String.format("Initialization took %s ms.", duration));
        }
    }

    public void destroy() {
        normalView = null;
        maximizedView = null;
        super.destroy();
    }

}
