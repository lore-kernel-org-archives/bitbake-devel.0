Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 871B56ACA1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:29 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id cc10so12163365wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EewIAwRnqSPk7gMIluQZjscB/DfxExSp+K4qg1pLSOE=;
	b=bNcRS/ubbM8VTKwQVx7mWNIhXonflaR9AxIoS3NJkoI7bAw5X6dOe/+N9wTZMF77zY
	bMxmNjW/XLPtYsleaJ7FjXyCfXYF6yhWBjDAEKNksCQYtwRKF5fi/szwPDEfjiBsv9uS
	6eqncGBTiASV7NpCLvx1oaY5fBqvFh87jk1etqK78Y7bhK3TWJLgAA6rclKfL3wpExcT
	UmV9Hmt2tP4RLGyTiVqj179lYZWwIKeRjiPJJS1CaiM+FhzPWBU12Q2cc6efw2+5a/6C
	RKPPL+ILcQYRAXr/0DXiKP98TOWFB8WzTJ3JSdG+ElZkUIUlpTZRbCVmgsBN/tGfi7Wl
	mfhQ==
X-Gm-Message-State: ALoCoQneB1G2natDVnAgZUioZuXT4Q8blosvE3uAhUUaJJctwryq0Wsy10HQ8WRQyIr6Tr7ibFyl
X-Received: by 10.194.222.197 with SMTP id qo5mr12651242wjc.78.1404477870918; 
	Fri, 04 Jul 2014 05:44:30 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id o3sm78904399wix.15.2014.07.04.05.44.28
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:29 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 26EF156154C; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:23 +0100
Message-Id: <a9062d9692525e24e59b5b2bb4dfdef90b41bf2a.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/9] toaster: add automated login in new project page
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster uses the Django authentication system to assign
user accounts to the projects that are being created.

In the current implementation, the user accounts are
created/authenticated automatically, on the fly, based
on the fields specified in the create new project page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/newproject.html | 35 +++++++++++++-----------
 lib/toaster/toastergui/views.py                  | 29 ++++++++++++++++++--
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index e5a6551..ce01800 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -6,36 +6,39 @@
 				<div class="span6">
 				<div class="page-header">
 					<h1>Create a new project</h1>
-				</div>  
-					<form>
+				</div>
+				<div class="container-fluid">
+		{% for a in alerts %}
+			<div class="alert alert-error row-fluid" role="alert">{{a}}</div>
+		{% endfor %}
+				</div>
+					<form method="POST">{% csrf_token %}
 						<fieldset>
 							<label>Project name <span class="muted">(required)</span></label>
-							<input type="text" class="input-xlarge" required name="projectname">
+							<input type="text" class="input-xlarge" required name="projectname" value="{{projectname}}">
 							<label class="project-form">
 								Project owner
-								<i class="icon-question-sign get-help" title="The go-to person for this project"></i>
+					<i class="icon-question-sign get-help" title="The go-to person for this project"></i>
 							</label>
-				<form method="POST">
-							<input type="text">
+							<input type="text" name="username" value="{{username}}">
 							<label class="project-form">Owner's email</label>
-							<input type="email" class="input-large" name="email">
+							<input type="email" class="input-large" name="email" value="{{email}}">
 							<label class="project-form">
 								Yocto Project version
 								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
 							</label>
-							<select>
-								<option>Yocto Project 1.7 "D?"</option>
-								<option>Yocto Project 1.6 "Daisy"</option>
-								<option>Yocto Project 1.5 "Dora"</option>
+							<select name="projectversion">
+		<option value="1.7" {%if projectversion == "1.7" %}selected{%endif%}>Yocto Project 1.7 "D?"</option>
+		<option value="1.6" {%if projectversion == "1.6" %}selected{%endif%}>Yocto Project 1.6 "Daisy"</option>
+		<option value="1.5" {%if projectversion == "1.5" %}selected{%endif%}>Yocto Project 1.5 "Dora"</option>
 							</select>
-				</form>
 						</fieldset>
-									
+
 						<div class="form-actions">
-							<a href="project-with-targets.html" class="btn btn-primary btn-large">Create project</a>
+							<input type="submit" class="btn btn-primary btn-large" value="Create project"/>
 						</div>
-					</form> 
+					</form>
 				</div>
 			</div>
-		</div>  
+		</div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7dc0108..89c02d4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1768,17 +1768,42 @@ def managedcontextprocessor(request):
 # a default "page not available" simple functions for interactive mode
 if toastermain.settings.MANAGED:
 
+    from django.contrib.auth.models import User
+    from django.contrib.auth import authenticate, login
+    from django.contrib.auth.decorators import login_required
+
+
     # new project
     def newproject(request):
         template = "newproject.html"
-        context = {}
+        context = {
+            'email': request.user.email if request.user.is_authenticated() else '',
+            'username': request.user.username if request.user.is_authenticated() else '',
+        }
+
+
         if request.method == "GET":
             # render new project page
             return render(request, template, context)
         elif request.method == "POST":
-            if request.method:
+            mandatory_fields = ['projectname', 'email', 'username', 'projectversion']
+            if reduce( lambda x, y: x and y, map(lambda x: x in request.POST and len(request.POST[x]) > 0, mandatory_fields)):
+                if not request.user.is_authenticated():
+                    user = authenticate(username = request.POST['username'], password = 'nopass')
+                    if user is None:
+                        user = User.objects.create_user(username = request.POST['username'], email = request.POST['email'], password = "nopass")
+                        raise Exception("User cannot be authed, creating")
+                        user = authenticate(username = request.POST['username'], password = '')
+                    login(request, user)
+
                 return redirect(project)
             else:
+                alerts = []
+                # set alerts for missing fields
+                map(lambda x: alerts.append('Field '+ x + ' not filled in') if not x in request.POST or len(request.POST[x]) == 0 else None, mandatory_fields)
+                # fill in new page with already submitted values
+                map(lambda x: context.__setitem__(x, request.POST[x]), mandatory_fields)
+                context['alerts'] = alerts
                 return render(request, template, context)
         raise Exception("Invalid HTTP method for this page")
 
-- 
1.9.1


