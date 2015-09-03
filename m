Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 61C0977040
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:34 +0000 (UTC)
Received: by pacwi10 with SMTP id wi10so27089813pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=IrPD2yhoibjKJIQLWJHObQhoR7lpkjGZxJFSUNrUfNE=;
	b=0w73587Gikoc7M4QHoJMIOjcN7ZKOwgqSOClKXW9hk1hrjTY9d/ZV5i+TxvG8zWwdb
	IKU4n70+0E/+8sIsqPK4DbEJ0ZC7gl7AsWO99Qz3ZU20cPs3ux8HRNJ4QXwgNt8oIe7f
	1Zgdb+eZOB7DVRolSmIZserGfj5tfiCfxUUjgWI5KO1LNjaE660URbpmw99CgpduoPpx
	uaFUF9MrIs4YVTiB4JCo27OCt1OIEC09L4ZoPM1zjMXyDosf+xlWrHyN7Qb9y91pSSfy
	+/bz8J4GMiYwtYplUsdjSzFyLnLj/X2zM2zjETUpx9SAnKcSBtzoKcTRNUJC+orFaRtt
	knWA==
X-Received: by 10.67.23.232 with SMTP id id8mr28949692pad.138.1441239875026;
	Wed, 02 Sep 2015 17:24:35 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:34 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:12 -0700
Message-Id: <39856b9192c56b49ac17985593aa6f3c514cb1f5.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
References: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 6/6] toaster: Add tests for pages which show the default project
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:36 -0000

From: Elliot Smith <elliot.smith@intel.com>

Test that the correct landing page redirect is applied, depending
on the state of the default project.

Test that the default project is only shown on the /projects page
if it has at least one build.

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 115 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 7acf4bc..1a8b478 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -23,7 +23,8 @@
 
 from django.test import TestCase
 from django.core.urlresolvers import reverse
-from orm.models import Project, Release, BitbakeVersion
+from django.utils import timezone
+from orm.models import Project, Release, BitbakeVersion, Build
 from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer
 import json
@@ -179,3 +180,115 @@ class ViewTests(TestCase):
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content)
         self.assertNotEqual(data["error"], "ok")
+
+class LandingPageTests(TestCase):
+    """ Tests for redirects on the landing page """
+    # disable bogus pylint message error:
+    # "Instance of 'WSGIRequest' has no 'url' member (no-member)"
+    # (see https://github.com/landscapeio/pylint-django/issues/42)
+    # pylint: disable=E1103
+
+    LANDING_PAGE_TITLE = 'This is Toaster'
+
+    def setUp(self):
+        """ Add default project manually """
+        self.project = Project.objects.create_project('foo', None)
+        self.project.is_default = True
+        self.project.save()
+
+    def test_only_default_project(self):
+        """
+        No projects except default
+        => get the landing page
+        """
+        response = self.client.get(reverse('landing'))
+        self.assertTrue(self.LANDING_PAGE_TITLE in response.content)
+
+    def test_default_project_has_build(self):
+        """
+        Default project has a build, no other projects
+        => get the builds page
+        """
+        now = timezone.now()
+        build = Build.objects.create(project=self.project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+        response = self.client.get(reverse('landing'))
+        self.assertEqual(response.status_code, 302,
+                         'response should be a redirect')
+        self.assertTrue('/builds' in response.url,
+                        'should redirect to builds')
+
+    def test_user_project_exists(self):
+        """
+        User has added a project (without builds)
+        => get the projects page
+        """
+        user_project = Project.objects.create_project('foo', None)
+        user_project.save()
+
+        response = self.client.get(reverse('landing'))
+        self.assertEqual(response.status_code, 302,
+                         'response should be a redirect')
+        self.assertTrue('/projects' in response.url,
+                        'should redirect to projects')
+
+    def test_user_project_has_build(self):
+        """
+        User has added a project (with builds)
+        => get the builds page
+        """
+        user_project = Project.objects.create_project('foo', None)
+        user_project.save()
+
+        now = timezone.now()
+        build = Build.objects.create(project=user_project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+        response = self.client.get(reverse('landing'))
+        self.assertEqual(response.status_code, 302,
+                         'response should be a redirect')
+        self.assertTrue('/builds' in response.url,
+                        'should redirect to builds')
+
+class ProjectsPageTests(TestCase):
+    """ Tests for projects page """
+
+    PROJECT_NAME = 'cli builds'
+
+    def setUp(self):
+        """ Add default project manually """
+        project = Project.objects.create_project(self.PROJECT_NAME, None)
+        self.default_project = project
+        self.default_project.is_default = True
+        self.default_project.save()
+
+    def test_default_project_hidden(self):
+        """ The default project should be hidden if it has no builds """
+        params = {"count": 10, "orderby": "updated:-", "page": 1}
+        response = self.client.get(reverse('all-projects'), params)
+
+        self.assertTrue(not('tr class="data"' in response.content),
+                        'should be no project rows in the page')
+        self.assertTrue(not(self.PROJECT_NAME in response.content),
+                        'default project "cli builds" should not be in page')
+
+    def test_default_project_has_build(self):
+        """ The default project should be shown if it has builds """
+        now = timezone.now()
+        build = Build.objects.create(project=self.default_project,
+                                     started_on=now,
+                                     completed_on=now)
+        build.save()
+
+        params = {"count": 10, "orderby": "updated:-", "page": 1}
+        response = self.client.get(reverse('all-projects'), params)
+
+        self.assertTrue('tr class="data"' in response.content,
+                        'should be a project row in the page')
+        self.assertTrue(self.PROJECT_NAME in response.content,
+                        'default project "cli builds" should be in page')
-- 
1.9.1


