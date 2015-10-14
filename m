Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id C515E770CA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:15 +0000 (UTC)
Received: by payp3 with SMTP id p3so15792383pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=wl3RapVU/7AIDvBJrhtUCsQFrGj0BKKx+RENCju/R10=;
	b=xERYZtItlJEziuUnsOaoPG6p9pRgG7xC89zdef8Ef7i0mnUCdnDwLxar4EUS+Rtdaw
	Ff9l758WT4tOgYSCc2vv5keNiE1awveZKCuBuFSjZ0Qzc2aVPfvf7nmHDF0AWQqtOWuU
	Fdam09ZZG6zdBJKmhR6XAwdpH6WjtapWeeFjJQwA2ofqNSpJ37wgXxj5bxERktIahTKO
	Z4z5f9EOcsYzesZa9ymC9KiDo2m5fSZm2hqqOqvubSyoEAj5tGNTyf2uyMasQYp3dqku
	WevkVYVNAbMSXY/uXzRajbTf51CGY52Pf8KvQDCcrbWUef3bfPTkmFVmJehwGNBZxXP/
	fuHA==
X-Received: by 10.66.65.228 with SMTP id a4mr5599434pat.19.1444854435867;
	Wed, 14 Oct 2015 13:27:15 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:15 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:10 -0700
Message-Id: <fd3759758164160a9f584d8f62eb0d45eb728e80.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
Subject: [PATCH 02/10] toaster: Replace "Run again" button with help text for cli builds
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:16 -0000

From: Elliot Smith <elliot.smith@intel.com>

It's not possible to run a command-line build again, as Toaster
doesn't have access to the data used for that build.

Replace the "Run again" button with an icon which pops up some
help text to that effect.

Add test to check that the run again button is hidden and the
help icon displayed instead for command-line builds.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/static/css/default.css     |  5 +++
 lib/toaster/toastergui/templates/mrb_section.html | 41 +++++++++++++++--------
 lib/toaster/toastergui/tests.py                   | 33 ++++++++++++++++++
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 06d9976..bc8a97b 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -15,6 +15,8 @@
 /* Styles for the help information */
 .get-help { color: #CCCCCC; }
 .get-help:hover, .icon-plus-sign:hover { color: #999999; cursor: pointer; }
+.get-help-green { color: #468847; }
+.get-help-green:hover { color: #347132; cursor: pointer; }
 .get-help-blue { color: #3A87AD; }
 .get-help-blue:hover { color: #005580; cursor: pointer; }
 .get-help-yellow { color: #C09853; }
@@ -161,6 +163,9 @@ table { table-layout: fixed; word-wrap: break-word; }
 .project-name .label { font-weight: normal; margin-bottom: 5px; margin-left: -15px; padding: 5px; }
 .project-name .label > a { color: #fff; font-weight: normal; }
 
+/* styles for showing help icons next to command-line builds */
+.build-result .get-help-green, .build-result .get-help-red, .build-result .get-help-blue { margin-right: 35px; margin-top: 8px; font-size: 16px; }
+
 /* Remove bottom margin for forms inside modal dialogs */
 #dependencies-modal-form { margin-bottom: 0px; }
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index ad90e82..5e96b39 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -18,7 +18,7 @@
   {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
-  <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
+  <div id="build-result-{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
     {% if mrb_type != 'project' %}
     project-name">
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
@@ -81,24 +81,37 @@
             </div>
             <div class="lead ">
               <span class="lead">
-                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}</a>
+                  Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}</a>
               </span>
-              <button class="btn
+              {% if build.project.is_default %}
+                  <i class="pull-right icon-question-sign get-help
                   {% if build.outcome == build.SUCCEEDED %}
-                      btn-success
+                      get-help-green
                   {% elif build.outcome == build.FAILED %}
-                      btn-danger
+                      get-help-red
                   {% else %}
-                      btn-info
-                  {%endif%}
-                  pull-right"
-                  onclick='scheduleBuild({% url 'projectbuilds' build.project.id as bpi %}{{bpi|json}},
-                    {{build.project.name|json}},
-                    {% url 'project' build.project.id as bpurl %}{{bpurl|json}},
-                    {{build.target_set.all|get_tasks|json}})'>
+                      get-help-blue
+                  {% endif %}
+                  " title="Builds in this project cannot be started from Toaster: they are started from the command line">
+                  </i>
+              {% else %}
+                  <button class="btn
+                      {% if build.outcome == build.SUCCEEDED %}
+                          btn-success
+                      {% elif build.outcome == build.FAILED %}
+                          btn-danger
+                      {% else %}
+                          btn-info
+                      {%endif%}
+                      pull-right"
+                      onclick='scheduleBuild({% url 'projectbuilds' build.project.id as bpi %}{{bpi|json}},
+                        {{build.project.name|json}},
+                        {% url 'project' build.project.id as bpurl %}{{bpurl|json}},
+                        {{build.target_set.all|get_tasks|json}})'>
 
-                    Run again
-              </button>
+                        Run again
+                  </button>
+              {% endif %}
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 9156cc8..9dd60d9 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -38,6 +38,7 @@ import json
 import re
 
 PROJECT_NAME = "test project"
+CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
@@ -570,6 +571,12 @@ class AllBuildsPageTests(TestCase):
                                          bitbake_version=bbv)
         self.project1 = Project.objects.create_project(name=PROJECT_NAME,
                                                        release=release)
+        self.default_project = Project.objects.create_project(
+            name=CLI_BUILDS_PROJECT_NAME,
+            release=release
+        )
+        self.default_project.is_default = True
+        self.default_project.save()
 
         # parameters for builds to associate with the projects
         now = timezone.now()
@@ -581,6 +588,13 @@ class AllBuildsPageTests(TestCase):
             "outcome": Build.SUCCEEDED
         }
 
+        self.default_project_build_success = {
+            "project": self.default_project,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.SUCCEEDED
+        }
+
     def test_show_tasks_in_allbuilds(self):
         """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
@@ -590,6 +604,23 @@ class AllBuildsPageTests(TestCase):
         result = re.findall('bash:clean', response.content, re.MULTILINE)
         self.assertEqual(len(result), 3)
 
+    def test_no_run_again_for_cli_build(self):
+        """ "Run again" button should not be shown for command-line builds """
+        build = Build.objects.create(**self.default_project_build_success)
+        url = reverse("all-builds")
+        response = self.client.get(url, follow=True)
+        soup = BeautifulSoup(response.content)
+
+        element_id = 'build-result-%d' % build.id
+
+        # shouldn't see a run again button for command-line builds
+        run_again_button = soup.select('#%s button' % element_id)
+        self.assertEqual(len(run_again_button), 0)
+
+        # should see a help icon for command-line builds
+        help_icon = soup.select('#%s i.get-help-green' % element_id)
+        self.assertEqual(len(help_icon), 1)
+
 class ProjectPageTests(TestCase):
     """ Test project data at /project/X/ is displayed correctly """
     CLI_BUILDS_PROJECT_NAME = 'Command line builds'
@@ -619,3 +650,5 @@ class ProjectPageTests(TestCase):
         response = self.client.get(url, follow=True)
 
         self.assertEqual(response.status_code, 200)
+
+
-- 
1.9.1


