Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E2A6076AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:22:36 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 07 Oct 2015 06:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821306300"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 07 Oct 2015 06:22:37 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 9A6866A4083;
	Wed,  7 Oct 2015 06:21:39 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:51 +0300
Message-Id: <45192e7d2f667502c55f3e7f984c929dc9a7bfdc.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/10] toaster: Show tooltip next to cli builds project name in all builds
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
X-List-Received-Date: Wed, 07 Oct 2015 13:22:37 -0000

From: Elliot Smith <elliot.smith@intel.com>

In the all builds page, show an icon with tooltip next to the
command line builds project name.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/builds.html      | 11 ++++---
 lib/toaster/toastergui/templates/mrb_section.html |  2 +-
 lib/toaster/toastergui/tests.py                   | 37 ++++++++++++++++++++---
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 6fbaf98..566c279 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -63,10 +63,10 @@
   {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for build in objects %}
-        <tr class="data">
+        <tr class="data" data-table-build-result="{{ build.id }}">
             <td class="outcome">
-        <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
-        </td>
+                <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
+            </td>
             <td class="target">
                 {% for t in build.target_set.all %}
                     <a href="{% url "builddashboard" build.id %}">
@@ -104,8 +104,11 @@
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
               {% endif %}
             </td>
-        <td>
+            <td class="project-name">
                 <a href="{% project_url build.project %}">{{build.project.name}}</a>
+                {% if build.project.is_default %}
+                    <i class="icon-question-sign get-help hover-help" title="" data-original-title="This project shows information about the builds you start from the command line while Toaster is running" style="visibility: hidden;"></i>
+                {% endif %}
             </td>
         </tr>
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 53f40d0..55687a1 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -22,7 +22,7 @@
   {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
-  <div id="build-result-{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
+  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
     {% if mrb_type != 'project' %}
     project-name">
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 0d56ab2..1e67d1a 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -760,7 +760,7 @@ class AllBuildsPageTests(TestCase):
         """ Task should be shown as suffix on build name """
         build = Build.objects.create(**self.project1_build_success)
         Target.objects.create(build=build, target='bash', task='clean')
-        url = reverse("all-builds")
+        url = reverse('all-builds')
         response = self.client.get(url, follow=True)
         result = re.findall('bash:clean', response.content, re.MULTILINE)
         self.assertEqual(len(result), 3)
@@ -768,17 +768,44 @@ class AllBuildsPageTests(TestCase):
     def test_no_run_again_for_cli_build(self):
         """ "Run again" button should not be shown for command-line builds """
         build = Build.objects.create(**self.default_project_build_success)
-        url = reverse("all-builds")
+        url = reverse('all-builds')
         response = self.client.get(url, follow=True)
         soup = BeautifulSoup(response.content)
 
-        element_id = 'build-result-%d' % build.id
+        attrs = {'data-latest-build-result': build.id}
+        result = soup.find('div', attrs=attrs)
 
         # shouldn't see a run again button for command-line builds
-        run_again_button = soup.select('#%s button' % element_id)
+        run_again_button = result.select('button')
         self.assertEqual(len(run_again_button), 0)
 
         # should see a help icon for command-line builds
-        help_icon = soup.select('#%s i.get-help-green' % element_id)
+        help_icon = result.select('i.get-help-green')
         self.assertEqual(len(help_icon), 1)
 
+    def test_tooltips_on_project_name(self):
+        """
+        A tooltip should be present next to the command line
+        builds project name in the all builds page, but not for
+        other projects
+        """
+        build1 = Build.objects.create(**self.project1_build_success)
+        default_build = Build.objects.create(**self.default_project_build_success)
+
+        url = reverse('all-builds')
+        response = self.client.get(url, follow=True)
+        soup = BeautifulSoup(response.content)
+
+        # no help icon on non-default project name
+        result = soup.find('tr', attrs={'data-table-build-result': build1.id})
+        name = result.select('td.project-name')[0]
+        icons = name.select('i.get-help')
+        self.assertEqual(len(icons), 0,
+                         'should not be a help icon for non-cli builds name')
+
+        # help icon on default project name
+        result = soup.find('tr', attrs={'data-table-build-result': default_build.id})
+        name = result.select('td.project-name')[0]
+        icons = name.select('i.get-help')
+        self.assertEqual(len(icons), 1,
+                         'should be a help icon for cli builds name')
-- 
2.1.4


