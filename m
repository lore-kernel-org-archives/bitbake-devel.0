Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
	[209.85.220.67])
	by mail.openembedded.org (Postfix) with ESMTP id 816A6770F9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:19 +0000 (UTC)
Received: by padew5 with SMTP id ew5so6655714pad.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=nDWm1xBFq2GFL9F1g1xSscJcr4nwctPB/5VyGR/FBn4=;
	b=NM4war6rxm3pIdrfEni4bkB/eVyhCBzmoihNcU83w9aZKgMWtEGy+bWB9C1g8AiQv+
	yubLuYzxUjk06tIqjgxWLjmZfeloL8mYA6oZ7gnF/OA3Gc5/f8O2l26GGE8qRKpOnq7p
	qWJhyyixXwlmF1QVcQos2dGub3UR4pQ2sa9NHdzY3JlCwsUGu1rufkvZPPki0H/qhxTr
	9IO0rxBKyZ6qoy15xvOJWWuCipoRVC/ILhqiILL3r2c7YCNWKfMIxtIFBpbBJF8PZQQ5
	wShpvk8yRmSQShKMs7jtj31xJyfVEMrvqYdC0moTe5D7ZkD2weRTp6R+5JlUV5Z8Qc1T
	a0hQ==
X-Received: by 10.66.61.205 with SMTP id s13mr5471628par.96.1444854439887;
	Wed, 14 Oct 2015 13:27:19 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:19 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:14 -0700
Message-Id: <8e7a8eac435d2374731cff03a4bfc27bf69dfe45.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:19 -0000

From: Elliot Smith <elliot.smith@intel.com>

In the all builds page, show an icon with tooltip next to the
command line builds project name.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/builds.html      | 11 ++++---
 lib/toaster/toastergui/templates/mrb_section.html |  2 +-
 lib/toaster/toastergui/tests.py                   | 40 +++++++++++++++++++----
 3 files changed, 41 insertions(+), 12 deletions(-)

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
index 4b93415..69bbfd4 100644
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
@@ -768,20 +768,48 @@ class AllBuildsPageTests(TestCase):
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
+
 class ProjectPageTests(TestCase):
     """ Test project data at /project/X/ is displayed correctly """
     CLI_BUILDS_PROJECT_NAME = 'Command line builds'
@@ -811,5 +839,3 @@ class ProjectPageTests(TestCase):
         response = self.client.get(url, follow=True)
 
         self.assertEqual(response.status_code, 200)
-
-
-- 
1.9.1


