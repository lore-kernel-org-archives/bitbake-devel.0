Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 88C74770E6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:20 +0000 (UTC)
Received: by payp3 with SMTP id p3so15794020pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=xbPZrqZw+YfjFLqXYoOJL7Ua7j1I7gcRVjcAotKjxsM=;
	b=xsktFldFBZReSH0pE0P9KX4nA9o24hNI0bHgp7Bye+dNsoPf5C87nNxWLaBolx0eF9
	xMmhFfxuCS/dTUeL7jKFQwMTpce58BqWkBM6FjxqgEmRPBgJH4Ty9pY4ZEvQ5jXQw4+w
	ckIvAC4GEKyCn8qz9BGbOzYRavImc2YMqkfntS066ufwyG8UuVbyJ37dbzhuPvL3HSis
	D8B4pJ+x03jVAQxWNsdToTbzG7hXhFpk+u/kJtN4bMvqJhKnwT4y5WWXQp+hQuVb7c/a
	kfOhPAAMLs0LqTqXSA1hWyTLlNzieCwFuucB+8S3jhJ+6PpTxTuYeFiSiJLo0oCSPRrU
	x8yQ==
X-Received: by 10.66.251.35 with SMTP id zh3mr5590358pac.121.1444854440689;
	Wed, 14 Oct 2015 13:27:20 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:20 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:15 -0700
Message-Id: <8494c483f6fa2be70a3fd29c0aadcea4c631e295.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
Subject: [PATCH 07/10] toaster: More linting of tests
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:20 -0000

From: Elliot Smith <elliot.smith@intel.com>

Fix some more lint errors on the tests for toastergui.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 69bbfd4..7c4bd39 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -433,6 +433,18 @@ class AllProjectsPageTests(TestCase):
 
     MACHINE_NAME = 'delorean'
 
+    def setUp(self):
+        """ Add default project manually """
+        project = Project.objects.create_project(CLI_BUILDS_PROJECT_NAME, None)
+        self.default_project = project
+        self.default_project.is_default = True
+        self.default_project.save()
+
+        # this project is only set for some of the tests
+        self.project = None
+
+        self.release = None
+
     def _add_build_to_default_project(self):
         """ Add a build to the default project (not used in all tests) """
         now = timezone.now()
@@ -458,16 +470,6 @@ class AllProjectsPageTests(TestCase):
                                                      value=self.MACHINE_NAME)
         project_var.save()
 
-    def setUp(self):
-        """ Add default project manually """
-        project = Project.objects.create_project(CLI_BUILDS_PROJECT_NAME, None)
-        self.default_project = project
-        self.default_project.is_default = True
-        self.default_project.save()
-
-        # this project is only set for some of the tests
-        self.project = None
-
     def test_default_project_hidden(self):
         """ The default project should be hidden if it has no builds """
         params = {"count": 10, "orderby": "updated:-", "page": 1}
@@ -573,17 +575,15 @@ class AllProjectsPageTests(TestCase):
         # link for default project
         row = soup.find('tr', attrs={'data-project': self.default_project.id})
         cell = row.find('td', attrs={'data-project-field': 'name'})
-        url = cell.find('a')['href']
         expected_url = reverse('projectbuilds', args=(self.default_project.id,))
-        self.assertEqual(url, expected_url,
+        self.assertEqual(cell.find('a')['href'], expected_url,
                          'link on default project name should point to builds')
 
         # link for other project
         row = soup.find('tr', attrs={'data-project': self.project.id})
         cell = row.find('td', attrs={'data-project-field': 'name'})
-        url = cell.find('a')['href']
         expected_url = reverse('project', args=(self.project.id,))
-        self.assertEqual(url, expected_url,
+        self.assertEqual(cell.find('a')['href'], expected_url,
                          'link on project name should point to configuration')
 
 class ProjectBuildsPageTests(TestCase):
@@ -640,13 +640,6 @@ class ProjectBuildsPageTests(TestCase):
             "outcome": Build.IN_PROGRESS
         }
 
-        self.default_project_build_success = {
-            "project": self.default_project,
-            "started_on": now,
-            "completed_on": now,
-            "outcome": Build.SUCCEEDED
-        }
-
     def _get_rows_for_project(self, project_id):
         """ Helper to retrieve HTML rows for a project """
         url = reverse("projectbuilds", args=(project_id,))
-- 
1.9.1


