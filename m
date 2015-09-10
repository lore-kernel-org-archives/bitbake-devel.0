Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id CE6D976FFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:29 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so49009332pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=GAjjSWmejvWiLOHZ+px1Y1MOwDI3e2kaFKKzoa40Kf0=;
	b=HLrIAIkTqmDWcjk0Oylyaa2qMnA+OTPCn5hBzyNoIZJu4IFz22y//3+wTbWhvXiB3p
	FAcQbdvFp0bNXuZ4Pw/yq2Qe9ICkvay8zFHCSQm1+P9rGSY9D3GI7B92nlCKjQ6Ahpba
	6X7U2TEFE8w0wESdxjPwxhQJnYPNMf4Cqj5KsJaCx/UE14VqeIYrLFP07K8o2XIl2oBP
	/sm/g81eVUvFhBhoU5wii3HVu+WXGNcSmvz0QhJ8aTVGo20cV7qrKMeiCqfW2ErJmDNr
	riNLhen7oj57H0xCWblFZOrzi+jtEaL4WcKEmuETgGeAWJ+G2PGPOMcxjvvqcaWugDFP
	SgKQ==
X-Received: by 10.66.184.197 with SMTP id ew5mr76548873pac.54.1441904670016;
	Thu, 10 Sep 2015 10:04:30 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	by1sm13099494pab.6.2015.09.10.10.04.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:29 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:19 -0700
Message-Id: <4dde7bbd2e6bf6c51790a8c644cfba81c32af143.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Subject: [PATCH 5/5] toaster: Simplify redirects when build page parameters are missing
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:29 -0000

From: Elliot Smith <elliot.smith@intel.com>

A RedirectException is used to redirect the client to the
correct page when their original request is missing the
required parameters (page, orderby etc.). However, the code
is difficult to follow.

Rather than catching RedirectExceptions and rethrowing them with
different view URLs, ensure that the RedirectException has the
correct URL in it when thrown by passing the original page
name to the _build_list_helper() method.

Modified from an original patch by
David Reyna <david.reyna@windriver.com>.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 49 +++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 631d619..adfebab 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1889,6 +1889,10 @@ if True:
         pass
 
     # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
+    # WARNING _build_list_helper() may raise a RedirectException, which
+    # will set the GET parameters and redirect back to the
+    # all-builds or projectbuilds page as appropriate;
+    # TODO don't use exceptions to control program flow
     @_template_renderer("builds.html")
     def builds(request):
         # define here what parameters the view needs in the GET portion in order to
@@ -1897,27 +1901,35 @@ if True:
 
         queryset = Build.objects.all()
 
-        try:
-            context, pagesize, orderby = _build_list_helper(request, queryset)
-            # all builds page as a Project column
-            context['tablecols'].append({'name': 'Project', 'clcalss': 'project_column', })
-        except RedirectException as re:
-            # rewrite the RedirectException
-            re.view = resolve(request.path_info).url_name
-            raise re
+        redirect_page = resolve(request.path_info).url_name
+
+        context, pagesize, orderby = _build_list_helper(request,
+                                                        queryset,
+                                                        redirect_page)
+        # all builds page as a Project column
+        context['tablecols'].append({
+            'name': 'Project',
+            'clclass': 'project_column'
+        })
 
         _set_parameters_values(pagesize, orderby, request)
         return context
 
 
     # helper function, to be used on "all builds" and "project builds" pages
-    def _build_list_helper(request, queryset_all):
+    def _build_list_helper(request, queryset_all, redirect_page, pid=None):
         default_orderby = 'completed_on:-'
         (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            raise RedirectException( None, request.GET, mandatory_parameters)
+            params = {}
+            if pid:
+                params = {'pid': pid}
+            raise RedirectException(redirect_page,
+                                    request.GET,
+                                    mandatory_parameters,
+                                    **params)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
@@ -2661,6 +2673,10 @@ if True:
 
         return context
 
+    # WARNING _build_list_helper() may raise a RedirectException, which
+    # will set the GET parameters and redirect back to the
+    # all-builds or projectbuilds page as appropriate;
+    # TODO don't use exceptions to control program flow
     @_template_renderer('projectbuilds.html')
     def projectbuilds(request, pid):
         prj = Project.objects.get(id = pid)
@@ -2700,13 +2716,12 @@ if True:
 
         queryset = Build.objects.filter(project_id = pid)
 
-        try:
-            context, pagesize, orderby = _build_list_helper(request, queryset)
-        except RedirectException as re:
-            # rewrite the RedirectException with our current url information
-            re.view = resolve(request.path_info).url_name
-            re.okwargs = {"pid" : pid}
-            raise re
+        redirect_page = resolve(request.path_info).url_name
+
+        context, pagesize, orderby = _build_list_helper(request,
+                                                        queryset,
+                                                        redirect_page,
+                                                        pid)
 
         context['project'] = prj
         _set_parameters_values(pagesize, orderby, request)
-- 
1.9.1


