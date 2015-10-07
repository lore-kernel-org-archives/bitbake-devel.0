Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8649076AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:21:59 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 07 Oct 2015 06:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; 
	d="scan'208,217";a="659587991"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 06:22:01 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 8EDEB6A4087;
	Wed,  7 Oct 2015 06:21:02 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:49 +0300
Message-Id: <a6bd0684f84bd04cc6fe05dd4bb16cc032e0c073.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
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
X-List-Received-Date: Wed, 07 Oct 2015 13:22:02 -0000

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
index 0b85d4f..12a91c3 100644
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
2.1.4


