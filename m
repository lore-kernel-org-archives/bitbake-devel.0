Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id A3CEE76A25
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:20 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so113624691wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vcooGTaA5IzAcpADfywwivttOV3L2O7TMHk6+U2vAOk=;
	b=C1nI/rDHxIxsbo3Hsja732SKd+bVGFBWjO06+DiLyanVk4T7+uSLAC74L/W1u1Ox5G
	rCWjvdTOdvDqj1rzzVF/H74JJn5cntOvhnuezvveMfZCuR/7nqAmxq8c/SYZIhI3bHdo
	pcR//CdYcyCzaojre58JNM5rAOPOSIzOb1yk4EzMHChqmyeVltSkvzVwWH+akOpScjDe
	Hi29grSpmlGZhUygByeIzPm2bRr2kh+WE4YtPG4/lEvfCHwi3j59Cd1nOxowsvc3XqW1
	eaPaOwfspDTyGz3wwHDEOgW4tBCT2mfXBZ9ECcT+YTbw/VPGn/dXjBGIU7Bhb8hKkDp6
	6ueA==
X-Gm-Message-State: ALoCoQkNX1EbVkXbao83AM5tKmQOg+nXjUsF05Jala0NFC24jRthGxdUUEf4GtM8Ode2reFr1UDZ
X-Received: by 10.180.219.101 with SMTP id pn5mr43651873wic.89.1439915360834; 
	Tue, 18 Aug 2015 09:29:20 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:20 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:29:00 +0100
Message-Id: <81b3c1926e9e8a934d542933c4ce80902cc3d3bc.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 14/14] toastergui: fix projectbuilds page
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Aug 2015 16:29:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the redirection projectbuilds page and
the template layout in the projectbuilds page.

* The _build_list_helper now returns an empty RedirectException
that is properly customized by the caller and re-raised
to achieve redirection to the original page (poor man's overloading)

* The template for ProjectBuilds is updated as to properly display
Build objects instead of BuildRequest objects.

[YOCTO #7995]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../toastergui/templates/projectbuilds.html        | 42 +++-------------------
 lib/toaster/toastergui/views.py                    | 24 +++++++++----
 2 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 646755b..f1db2f1 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -16,8 +16,8 @@
 <script>
     // initialize the date range controls
     $(document).ready(function () {
-        date_init('created','{{last_date_from}}','{{last_date_to}}','{{dateMin_created}}','{{dateMax_created}}','{{daterange_selected}}');
-        date_init('updated','{{last_date_from}}','{{last_date_to}}','{{dateMin_updated}}','{{dateMax_updated}}','{{daterange_selected}}');
+        date_init('created','{{last_date_from}}','{{last_date_to}}','{{dateMin_started_on}}','{{dateMax_started_on}}','{{daterange_selected}}');
+        date_init('updated','{{last_date_from}}','{{last_date_to}}','{{dateMin_completed_on}}','{{dateMax_completed_on}}','{{daterange_selected}}');
     });
 </script>
 
@@ -28,7 +28,7 @@
         {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
             No builds found
         {%else%}
-            All builds
+            Project builds
         {%endif%}
         <i class="icon-question-sign get-help heading-help" title="This page lists all the builds for the current project"></i>
       </h1>
@@ -58,7 +58,7 @@
 
   {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
-        {% for br in objects %}{% if br.build %}  {% with build=br.build %} {# if we have a build, just display it #}
+        {% for build in objects %} {# if we have a build, just display it #}
         <tr class="data">
             <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
                    {% if build.project %}
@@ -96,40 +96,6 @@
               {% endif %}
             </td>
         </tr>
-
-              {%endwith%}
-      {% else %} {# we don't have a build for this build request, mask the data with build request data #}
-
-
-
-        <tr class="data">
-            <td class="outcome">{% if br.state == br.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
-            <td class="target">
-                <a href="{% url "builddashboard" br.id %}"><span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
-            </td>
-            <td class="machine">
-                <a href="{% url "builddashboard" br.id %}">{{br.machine}}</a>
-            </td>
-            <td class="started_on">
-                <a href="{% url "builddashboard" br.id %}">{{br.created|date:"d/m/y H:i"}}</a>
-            </td>
-            <td class="completed_on">
-                <a href="{% url "builddashboard" br.id %}">{{br.updated|date:"d/m/y H:i"}}</a>
-            </td>
-            <td class="failed_tasks error">
-            </td>
-            <td class="errors.count">
-        <a class="errors.count error" href="{% url "builddashboard" br.id %}#errors">{{br.brerror_set.all.count}} error{{br.brerror_set.all.count|pluralize}}</a>
-            </td>
-            <td class="warnings.count">
-            </td>
-            <td class="time">
-                {{br.timespent.total_seconds|sectohms}}
-            </td>
-            <td class="output"> {# we have no output here #}
-            </td>
-        </tr>
-          {%endif%}
         {% endfor %}
 
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 086d387..7641f86 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -33,7 +33,7 @@ from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
-from django.core.urlresolvers import reverse
+from django.core.urlresolvers import reverse, resolve
 from django.core.exceptions import MultipleObjectsReturned
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponseNotFound
@@ -372,7 +372,6 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string,
 # if the value is given explicitly as a GET parameter it will be the first selected,
 # otherwise the cookie value will be used.
 def _get_parameters_values(request, default_count, default_order):
-    from django.core.urlresolvers import resolve
     current_url = resolve(request.path_info).url_name
     pagesize = request.GET.get('count', request.session.get('%s_count' % current_url, default_count))
     orderby = request.GET.get('orderby', request.session.get('%s_orderby' % current_url, default_order))
@@ -1894,7 +1893,14 @@ if True:
 
         queryset = Build.objects.exclude(outcome = Build.IN_PROGRESS)
 
-        context, pagesize, orderby = _build_list_helper(request, queryset)
+        try:
+            context, pagesize, orderby = _build_list_helper(request, queryset)
+            # all builds page as a Project column
+            context['tablecols'].append({'name': 'Project', 'clcalss': 'project_column', })
+        except RedirectException as re:
+            # rewrite the RedirectException
+            re.view = resolve(request.path_info).url_name
+            raise re
 
         _set_parameters_values(pagesize, orderby, request)
         return context
@@ -1908,7 +1914,7 @@ if True:
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            raise RedirectException( 'all-builds', request.GET, mandatory_parameters)
+            raise RedirectException( None, request.GET, mandatory_parameters)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
@@ -2083,8 +2089,6 @@ if True:
                     {'name': 'Image files', 'clclass': 'output',
                      'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
                         # TODO: compute image fstypes from Target_Image_File
-                    },
-                    {'name': 'Project', 'clcalss': 'project_column',
                     }
                     ]
                 }
@@ -2655,7 +2659,13 @@ if True:
 
         queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
 
-        context, pagesize, orderby = _build_list_helper(request, queryset)
+        try:
+            context, pagesize, orderby = _build_list_helper(request, queryset)
+        except RedirectException as re:
+            # rewrite the RedirectException with our current url information
+            re.view = resolve(request.path_info).url_name
+            re.okwargs = {"pid" : pid}
+            raise re
 
         context['project'] = prj
         _set_parameters_values(pagesize, orderby, request)
-- 
2.1.4


