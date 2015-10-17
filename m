Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id C244377133
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:47 +0000 (UTC)
Received: by padfb7 with SMTP id fb7so6713631pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=m5azyo1XzFRQD3UHUT81xvbsq/2jMG3sN9sIg2mHC5M=;
	b=IDaWkFXF23BqJQegPkfvKIVRYnuoUa8obrBrnx2aFOfDqCNVn+lhc95fP8YHgrljRZ
	4+v2V+8NinPAmpaToevUX+3q5YBNxtpEPSEoEkZIPsGEH2g9SzonpD5yiLP9eRfUQoct
	NNVxx9OW/ZsQVDF6hNz7MtgoJDmr9WIfLEgXE0ZSpF3AtSPE5aGjr9StXeBwIRB8vhzD
	0XrUwSClXZEYJsjpRfaPK9tjm5bpalz9n2NC7tU4VVlepaUeZNDeFD0D2cacxG7YbzEE
	vT2+zctmbORfKWFgQyCpF+v5pY8WKASxJMISO4fHGjEB+GtxrSLiZRQvFfEHiypX1aEK
	VE8A==
X-Received: by 10.68.219.4 with SMTP id pk4mr24530279pbc.138.1445103827855;
	Sat, 17 Oct 2015 10:43:47 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	bn1sm27888794pad.17.2015.10.17.10.43.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:47 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:53 -0700
Message-Id: <fc3d0f0346d2e7929edbefbfa6d1efc9999e5a15.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
References: <27aab0077a5ef4f49d5b1f3a94f7872836054ad4.1445103849.git.avery.brian@gmail.com>
In-Reply-To: <cover.1445103849.git.avery.brian@gmail.com>
References: <cover.1445103849.git.avery.brian@gmail.com>
Subject: [PATCH 6/6] toaster: Remove all navigation when not in build mode
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:47 -0000

From: Elliot Smith <elliot.smith@intel.com>

The user is redirected to the all builds page or all projects
page from the landing page, regardless of mode.

In build mode, this makes sense; but in analysis mode, we are
restricting the view to just the cli builds project. This means
that "all projects" and "all builds" only contains items relating
to this one project.

Modify the landing page so it redirects to the project builds page
for the cli builds project when not in build mode. Also remove
navigation elements which are irrelevant when not in build mode.

[YOCTO #8514]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/base.html |  4 ++--
 lib/toaster/toastergui/views.py            | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 073c342..dfa6bba 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -91,9 +91,9 @@
             <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
             {% endif %}
           </span>
-          {% if request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
+          {% if BUILD_MODE and request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
           <ul class="nav">
-            <li  {% if request.resolver_match.url_name == 'all-builds' %}
+            <li {% if request.resolver_match.url_name == 'all-builds' %}
                 class="active"
                 {% endif %}>
               <a href="{% url 'all-builds' %}">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d675f4f..6ebb6a9 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -71,14 +71,24 @@ class MimeTypeFinder(object):
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
+    # in build mode, we redirect to the command-line builds page
+    # if there are any builds for the default (cli builds) project
+    default_project = Project.objects.get_default_project()
+    default_project_builds = Build.objects.filter(project = default_project)
+
+    if (not toastermain.settings.BUILD_MODE) and default_project_builds.count() > 0:
+        args = (default_project.id,)
+        return redirect(reverse('projectbuilds', args = args), permanent = False)
+
     # we only redirect to projects page if there is a user-generated project
+    num_builds = Build.objects.all().count()
     user_projects = Project.objects.filter(is_default = False)
     has_user_project = user_projects.count() > 0
 
-    if Build.objects.count() == 0 and has_user_project:
+    if num_builds == 0 and has_user_project:
         return redirect(reverse('all-projects'), permanent = False)
 
-    if Build.objects.all().count() > 0:
+    if num_builds > 0:
         return redirect(reverse('all-builds'), permanent = False)
 
     context = {'lvs_nos' : Layer_Version.objects.all().count()}
-- 
1.9.1


