Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 1648E759CB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:43 +0000 (UTC)
Received: by wicgi11 with SMTP id gi11so71413078wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CeNXInHSGSEKOUn3OgUAMn5xVLMPqaXzzeKwZNdJMhw=;
	b=C5XgqnLP/SOFxyBXrKU52t4xbWzPmHNR7B3ksN4QJzJ6VYB3CFQq9HEvRxskUaYE3S
	NbywImMtN7/Cc2AK4BN5XTDTfRsQIBUQ27rCrwg7suCNwh2g2bAFPIpxif8MpP6lQ4wp
	ya/588ujzFH3SxegRerGTq4wjCS5pmOWGCW221bER8aE4ccFyouOAgB6aNPffbRbORy8
	hs9Jdz0J0Uj84UBsodX0QLlIjy8NsDhUNLmSKJuLY75wFKTQ7A/sXnyBmFd7uIyyGEcg
	u4RIkz6giRrg61nYwc9WQpJFNV4kAhV9SqCNBu9SsGdmuSmoZMw6JEjIvUFFN7y2rDkm
	nV9Q==
X-Gm-Message-State: ALoCoQns6WzCh+Wz1F6JXYi76nbIn90TVaEiF+NAViFhTh9XZPJv2BRAQuTWDhzff+lWr3LFCKEB
X-Received: by 10.180.84.202 with SMTP id b10mr4504905wiz.23.1435228484537;
	Thu, 25 Jun 2015 03:34:44 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fm8sm6910212wib.9.2015.06.25.03.34.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:43 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D8A5A56271F; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:50 +0100
Message-Id: <2efc338cefd6e6e097af83d7dff63e9ba177d021.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 13/23] toastergui: select project types
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:44 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This brings in project types in the New Project page.

The "analisys" projects are the projects with no "release"
set, and have read-only properties in the project page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                        |  8 +-
 lib/toaster/toastergui/templates/newproject.html | 99 +++++++++++++++---------
 lib/toaster/toastergui/views.py                  | 11 ++-
 3 files changed, 80 insertions(+), 38 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 077c94d..8488aa4 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -57,7 +57,11 @@ class ToasterSetting(models.Model):
 
 class ProjectManager(models.Manager):
     def create_project(self, name, release):
-        prj = self.model(name = name, bitbake_version = release.bitbake_version, release = release)
+        if release is not None:
+            prj = self.model(name = name, bitbake_version = release.bitbake_version, release = release)
+        else:
+            prj = self.model(name = name, bitbake_version = None, release = None)
+
         prj.save()
 
         for defaultconf in ToasterSetting.objects.filter(name__startswith="DEFCONF_"):
@@ -66,6 +70,8 @@ class ProjectManager(models.Manager):
                 name = name,
                 value = defaultconf.value)
 
+        if release is None:
+            return prj
 
         for rdl in release.releasedefaultlayer_set.all():
             try:
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index ed3a279..1159d71 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -11,60 +11,74 @@
       <div class="alert alert-error row-fluid" role="alert">{{alert}}</div>
     {% endif %}
         </div>
-    {% if releases.count > 0 %}
+
+      <div class="row-fluid">
+        <div class="span6">
         <form method="POST">{% csrf_token %}
+
             <fieldset>
               <label>Project name <span class="muted">(required)</span></label>
               <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
-       {% if releases.count > 1 %}
+            </fieldset>
+
+            <fieldset>
+                <label class="project-form">Project type</label>
+                    <label class="project-form radio"><input type="radio" name="ptype" value="analysis" checked/> Analysis Project</label>
+
+                {% if releases.count > 0 %}
+                    <label class="project-form radio"><input type="radio" name="ptype" value="build" checked /> Build Project</label>
+                {% endif %}
+            </fieldset>
+
+        {% if releases.count > 0 %}
+            <fieldset class="release">
+            {% if releases.count > 1 %}
               <label class="project-form">
                 Release
                 <i class="icon-question-sign get-help" title="The version of the build system you want to use"></i>
               </label>
               <select name="projectversion" id="projectversion">
-          {% for release in releases %}
-            <option value="{{release.id}}"
-                {%if defaultbranch == release.name %}
-                selected
-            {%endif%}
-
-             >{{release.description}}</option>
-          {% endfor %}
+                {% for release in releases %}
+                    <option value="{{release.id}}"
+                        {%if defaultbranch == release.name %}
+                            selected
+                        {%endif%}
+                     >{{release.description}}</option>
+                {% endfor %}
               </select>
-         {% for release in releases %}
-             <div class="row-fluid helptext" id="description-{{release.id}}" style="display: none">
+                {% for release in releases %}
+              <div class="row-fluid helptext" id="description-{{release.id}}" style="display: none">
                 <span class="help-block span5">{{release.helptext|safe}}</span>
-           </div>
-         {% endfor %}
-       {% else %}
-        <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
-       {% endif %}
-
+              </div>
+                {% endfor %}
+            {% else %}
+              <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
+            {% endif %}
             </fieldset>
+        {% endif %}
 
             <div class="form-actions">
               <input type="submit" class="btn btn-primary btn-large" value="Create project"/>
               <span class="help-inline" style="vertical-align:middle;">To create a project, you need to enter a project name</span>
             </div>
         </form>
-    {% else %}
-    <br/>
-    <div class="alert alert-warning row-fluid span6">
-    <h3>No releases configured</h3>
-    <p>
-    It looks like Toaster releases have not been configured properly. Contact the person who set up Toaster, and tell them about it.
-    </p>
-    <p>
-    If you are the Toaster administrator, we are sorry: setting up Toaster is not easy.
-    <ul>
-    <li><a href="{% url 'admin:orm_release_changelist' %}">Log in to the Django administration interface</a> and check  the "Releases" section.</li>
-    <li>Check out the <a href="https://wiki.yoctoproject.org/wiki/Setting_up_a_hosted_managed_mode_for_Toaster#Releases">documentation about configuring releases</a></li>
-    </ul>
-    </p>
-    </div>
-    {% endif %}
+        </div>
 
-</div>
+        <div class="span5 well">
+                <span class="help-block">
+                 <h4>Toaster project types</h4>
+                 <p>With a <strong>build project</strong> you configure and run your builds from Toaster.</p>
+                 <p>With an <strong>analysis project</strong>, the builds are configured and run by another tool
+                 (something like Buildbot or Jenkins), and the project only collects the information about the
+                 builds (packages, recipes, dependencies, logs, etc). </p>
+                 <p>You can read more on <a href="#">how to set up an analysis project</a>
+                 in the Toaster manual.</p>
+                 <h4>Release</h4>
+                 <p>If you create a <strong>build project</strong>, you will need to select a <strong>release</strong>,
+                 which is the version of the build system you want to use to run your builds.</p>
+               </div>
+        </div>
+    </div>
 
     <script type="text/javascript">
         $(document).ready(function () {
@@ -94,6 +108,21 @@
                 $(".helptext").hide();
                 $('#description-' + new_release).fadeIn();
             });
+
+			// Hide the project release when you select an analysis project
+			function projectType() {
+				if ($("input[type='radio']:checked").val() == 'build') {
+					$('.release').fadeIn();
+				}
+				else {
+					$('.release').fadeOut();
+				}
+			}
+			projectType();
+
+			$('input:radio').change(function(){
+				projectType();
+			});
         })
     </script>
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8c6f9fa..1a504b8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2104,8 +2104,11 @@ if True:
             # render new project page
             return render(request, template, context)
         elif request.method == "POST":
-            mandatory_fields = ['projectname', 'projectversion']
+            mandatory_fields = ['projectname', 'ptype']
             try:
+                ptype = request.POST.get('ptype')
+                if ptype == "build":
+                    mandatory_fields.append('projectversion')
                 # make sure we have values for all mandatory_fields
                 if reduce( lambda x, y: x or y, map(lambda x: len(request.POST.get(x, '')) == 0, mandatory_fields)):
                 # set alert for missing fields
@@ -2121,7 +2124,11 @@ if True:
                     login(request, user)
 
                 #  save the project
-                prj = Project.objects.create_project(name = request.POST['projectname'], release = Release.objects.get(pk = request.POST['projectversion']))
+                release = Release.objects.get(pk = request.POST.get('projectversion', None ))
+                if ptype == "analysis":
+                    release = None
+
+                prj = Project.objects.create_project(name = request.POST['projectname'], release = release)
                 prj.user_id = request.user.pk
                 prj.save()
                 return redirect(reverse(project, args=(prj.pk,)) + "#/newproject")
-- 
1.9.1


