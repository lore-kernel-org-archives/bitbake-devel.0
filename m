Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 6C34C770DC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:17 +0000 (UTC)
Received: by padcn9 with SMTP id cn9so32585299pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Hpg1ypMFZfZ++tcyCBpDY1FIwwEmFQP4Z0fLWY8HLpM=;
	b=IIKhdMZsZZC0CCOh0e6Q1sYt2LVGCvGmuDa9X44v1QsSwiM/b9rjd0lKwEtT3tQH2F
	WuNtx17sTohZzpWQc7syzNDDmu3Hcwi6rnNoogPqDN2zA3N4K8Mi7+WunT2cmsTskVxZ
	HbGEbrvKrblMYXoljToum7KMY6hMLcozYnXwZfljD/ddP0n6GSxDmvaOOFl0EikSEaQ5
	RrbpUviSO077uSxn+R54vkAow4jFqys7pTo5Zej1BCihrb0ru/bSq1D7U3c5B3ecdxSN
	SoacPCkqyEqd8wk7VQjNkVTtHjAxdm207Njq4P0Lv490Tn8KN25ULytTrmJrZLiL/zpb
	DQhg==
X-Received: by 10.68.183.5 with SMTP id ei5mr5597663pbc.124.1444854437949;
	Wed, 14 Oct 2015 13:27:17 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:17 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:12 -0700
Message-Id: <54bf8a22865e12439d915c345c5c7568b0c4ccc5.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
Subject: [PATCH 04/10] toaster: Make the builds view the project page for "command line builds"
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:17 -0000

From: Elliot Smith <elliot.smith@intel.com>

Command line builds don't have configuration or layers which can
be manipulated in Toaster, so these pages shouldn't be visible.
However, the configuration page is the default page for the
project view (/project/X/), which isn't correct for the
command line builds project.

Modify all project page links across the application so that
the command line builds project (aka the "default" project)
always displays the builds tab.

Add a project_url tag for templates which contains the logic
determining where the URL for a project links to, based on
whether it is the default project or not.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/base.html         |  5 +--
 lib/toaster/toastergui/templates/builds.html       |  3 +-
 lib/toaster/toastergui/templates/mrb_section.html  |  6 ++--
 lib/toaster/toastergui/templates/projects.html     |  7 ++--
 .../toastergui/templatetags/project_url_tag.py     | 34 +++++++++++++++++++
 lib/toaster/toastergui/tests.py                    | 38 ++++++++++++++++++++--
 6 files changed, 82 insertions(+), 11 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/project_url_tag.py

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 640bc47..3f27790 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -1,6 +1,7 @@
 <!DOCTYPE html>
 {% load static %}
 {% load projecttags %}
+{% load project_url_tag %}
 <html lang="en">
     <head>
         <title>{% if objectname %} {{objectname|title}} - {% endif %}Toaster</title>
@@ -35,7 +36,7 @@
         projectsTypeAheadUrl: {% url 'xhr_projectstypeahead' as prjurl%}{{prjurl|json}},
         {% if project.id %}
         projectId : {{project.id}},
-        projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
+        projectPageUrl : {% url 'project' project.id as purl %}{{purl|json}},
         projectName : {{project.name|json}},
         recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
         layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
@@ -133,7 +134,7 @@
                 <h6>Project:</h6>
                 <span id="project">
                   {% if project.id %}
-                  <a class="lead" href="{% url 'project' project.id %}">{{project.name}}</a>
+                  <a class="lead" href="{% project_url project %}">{{project.name}}</a>
                   {% else %}
                   <a class="lead" href="#"></a>
                   {% endif %}
diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 2b35b01..6fbaf98 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -2,6 +2,7 @@
 
 {% load static %}
 {% load projecttags %}
+{% load project_url_tag %}
 {% load humanize %}
 
 {% block extraheadcontent %}
@@ -104,7 +105,7 @@
               {% endif %}
             </td>
         <td>
-                <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
+                <a href="{% project_url build.project %}">{{build.project.name}}</a>
             </td>
         </tr>
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 5e96b39..b29f650 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -1,8 +1,8 @@
 {% load static %}
 {% load projecttags %}
+{% load project_url_tag %}
 {% load humanize %}
 
-
 {%if mru and mru.count > 0%}
 
   {%if mrb_type == 'project' %}
@@ -22,7 +22,7 @@
     {% if mrb_type != 'project' %}
     project-name">
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
-         <a href={% url 'project' build.project.pk %}>
+         <a href={% project_url build.project %}>
            {{build.project.name}}
          </a>
        </span>
@@ -106,7 +106,7 @@
                       pull-right"
                       onclick='scheduleBuild({% url 'projectbuilds' build.project.id as bpi %}{{bpi|json}},
                         {{build.project.name|json}},
-                        {% url 'project' build.project.id as bpurl %}{{bpurl|json}},
+                        {% url 'project' build.project.id as purl %}{{purl|json}},
                         {{build.target_set.all|get_tasks|json}})'>
 
                         Run again
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index a7192c2..7c612e8 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -2,6 +2,7 @@
 
 {% load static %}
 {% load projecttags %}
+{% load project_url_tag %}
 {% load humanize %}
 
 {% block pagecontent %}
@@ -37,8 +38,10 @@
   {% include "basetable_top.html" %}
   {% for o in objects %}
     <tr class="data" data-project="{{ o.id }}">
-      <td><a href="{% url 'project' o.id %}">{{o.name}}</a></td>
-      <td class="updated"><a href="{% url 'project' o.id %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
+      <td data-project-field="name">
+          <a href="{% project_url o %}">{{o.name}}</a>
+      </td>
+      <td class="updated"><a href="{% project_url o %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
       <td data-project-field="release">
         {% if o.release %}
             <a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a>
diff --git a/lib/toaster/toastergui/templatetags/project_url_tag.py b/lib/toaster/toastergui/templatetags/project_url_tag.py
new file mode 100644
index 0000000..04770ac
--- /dev/null
+++ b/lib/toaster/toastergui/templatetags/project_url_tag.py
@@ -0,0 +1,34 @@
+from django import template
+from django.core.urlresolvers import reverse
+
+register = template.Library()
+
+def project_url(parser, token):
+    """
+    Create a URL for a project's main page;
+    for non-default projects, this is the configuration page;
+    for the default project, this is the project builds page
+    """
+    try:
+        tag_name, project = token.split_contents()
+    except ValueError:
+        raise template.TemplateSyntaxError(
+            "%s tag requires exactly one argument" % tag_name
+        )
+    return ProjectUrlNode(project)
+
+class ProjectUrlNode(template.Node):
+    def __init__(self, project):
+        self.project = template.Variable(project)
+
+    def render(self, context):
+        try:
+            project = self.project.resolve(context)
+            if project.is_default:
+                return reverse('projectbuilds', args=(project.id,))
+            else:
+                return reverse('project', args=(project.id,))
+        except template.VariableDoesNotExist:
+            return ''
+
+register.tag('project_url', project_url)
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index c725fc8..3753748 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -428,8 +428,8 @@ class LandingPageTests(TestCase):
         self.assertTrue('/builds' in response.url,
                         'should redirect to builds')
 
-class ProjectsPageTests(TestCase):
-    """ Tests for projects page """
+class AllProjectsPageTests(TestCase):
+    """ Tests for projects page /projects/ """
 
     MACHINE_NAME = 'delorean'
 
@@ -554,6 +554,38 @@ class ProjectsPageTests(TestCase):
         self.assertEqual(text, self.MACHINE_NAME,
                          'machine name should be shown for non-default project')
 
+    def test_project_page_links(self):
+        """
+        Test that links for the default project point to the builds
+        page /projects/X/builds for that project, and that links for
+        other projects point to their configuration pages /projects/X/
+        """
+
+        # need a build, otherwise project doesn't display at all
+        self._add_build_to_default_project()
+
+        # another project to test, which should show machine
+        self._add_non_default_project()
+
+        response = self.client.get(reverse('all-projects'), follow=True)
+        soup = BeautifulSoup(response.content)
+
+        # link for default project
+        row = soup.find('tr', attrs={'data-project': self.default_project.id})
+        cell = row.find('td', attrs={'data-project-field': 'name'})
+        url = cell.find('a')['href']
+        expected_url = reverse('projectbuilds', args=(self.default_project.id,))
+        self.assertEqual(url, expected_url,
+                         'link on default project name should point to builds')
+
+        # link for other project
+        row = soup.find('tr', attrs={'data-project': self.project.id})
+        cell = row.find('td', attrs={'data-project-field': 'name'})
+        url = cell.find('a')['href']
+        expected_url = reverse('project', args=(self.project.id,))
+        self.assertEqual(url, expected_url,
+                         'link on project name should point to configuration')
+
 class ProjectBuildsPageTests(TestCase):
     """ Test data at /project/X/builds is displayed correctly """
 
@@ -650,7 +682,7 @@ class ProjectBuildsPageTests(TestCase):
         self.assertEqual(len(result), 2)
 
 class AllBuildsPageTests(TestCase):
-    """ Tests for all builds page """
+    """ Tests for all builds page /builds/ """
 
     def setUp(self):
         bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
-- 
1.9.1


