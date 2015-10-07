Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D720860125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:21:34 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Oct 2015 06:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="805581606"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2015 06:21:29 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 72A676A4087;
	Wed,  7 Oct 2015 06:20:31 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:47 +0300
Message-Id: <2e03f539e0f77966a19f5b29d72068b96c6d487f.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
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
X-List-Received-Date: Wed, 07 Oct 2015 13:21:35 -0000

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
---
 lib/toaster/toastergui/static/css/default.css     |  5 +++
 lib/toaster/toastergui/templates/mrb_section.html | 41 +++++++++++++++--------
 lib/toaster/toastergui/tests.py                   | 32 ++++++++++++++++++
 3 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index cce3e31..336a407 100644
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
index 7b1f9b5..00ae9d4 100644
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
@@ -589,3 +603,21 @@ class AllBuildsPageTests(TestCase):
         response = self.client.get(url, follow=True)
         result = re.findall('bash:clean', response.content, re.MULTILINE)
         self.assertEqual(len(result), 3)
+
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
-- 
2.1.4


