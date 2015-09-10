Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 4569476EBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:20 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so48315902pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=zjJl8YGHzt6P0k5SYOMhnPISFliuvIFQHkkNgS92gak=;
	b=iT5QDWuheR6HaKfnD+/nnlnzYxi7Mu/jmdSc9tl8roDYU9yFSrGsQjEcSprqchcr0a
	wnxisNOrFnkf9faI0kbomA7JKNRXa5pKDwGG7d7oeI8+eFIvIeKyl5gi6KFk/0Bh/XPe
	F7QzD5LDduDDSjRI0hWIb6D14IslsiX76hAKWgFaCOev5qJO/UbdRpFClKR+Na0m1vDa
	bKBAQmlYLtrIpJh0NonXRTCIzZ1lc+4sNoiqz0w7cN2U4WVzWgmDN/dVbiSY9rAjWeWx
	FKnMBmN5S+I5KZ8ftybPspMkaGxFZnzt5uAWCHtEHApTv/0gEdyTsTB3cKzmHM1/DceO
	o0Ow==
X-Received: by 10.66.221.193 with SMTP id qg1mr77483604pac.103.1441904661022; 
	Thu, 10 Sep 2015 10:04:21 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	by1sm13099494pab.6.2015.09.10.10.04.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:20 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:16 -0700
Message-Id: <fa4a3965a75c8b3c659d7bdce1f5949a2f6f046b.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Subject: [PATCH 2/5] toaster: Add tests for /project/X/builds page
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:22 -0000

From: Elliot Smith <elliot.smith@intel.com>

Add tests to check whether "in progress" builds are filtered
out correctly, and that only builds for the current project
are shown.

Adds a dependency on BeautifulSoup 4, which is used to simplify
writing tests which verify the HTML.

Also requires a fix to how a date was converted in the view
which only manifested when I wrote the tests.

[YOCTO #8236]
[YOCTO #8187]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 91 +++++++++++++++++++++++++++++++++++++++--
 lib/toaster/toastergui/views.py |  5 +--
 toaster-requirements.txt        |  1 +
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 1a8b478..4d1549b 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -24,10 +24,11 @@
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from django.utils import timezone
-from orm.models import Project, Release, BitbakeVersion, Build
-from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer
+from orm.models import Project, Release, BitbakeVersion, ProjectTarget
+from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer
 import json
+from bs4 import BeautifulSoup
 
 PROJECT_NAME = "test project"
 
@@ -41,7 +42,6 @@ class ViewTests(TestCase):
                                          bitbake_version=bbv)
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=release)
-
         layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
                                                                   layer_source=layersrc)
@@ -292,3 +292,88 @@ class ProjectsPageTests(TestCase):
                         'should be a project row in the page')
         self.assertTrue(self.PROJECT_NAME in response.content,
                         'default project "cli builds" should be in page')
+
+class ProjectBuildsDisplayTest(TestCase):
+    """ Test data at /project/X/builds is displayed correctly """
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name="bbv1", giturl="/tmp/",
+                                            branch="master", dirpath="")
+        release = Release.objects.create(name="release1",
+                                         bitbake_version=bbv)
+        self.project1 = Project.objects.create_project(name=PROJECT_NAME,
+                                                       release=release)
+        self.project2 = Project.objects.create_project(name=PROJECT_NAME,
+                                                       release=release)
+
+        # parameters for builds to associate with the projects
+        now = timezone.now()
+
+        self.project1_build_success = {
+            "project": self.project1,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.SUCCEEDED
+        }
+
+        self.project1_build_in_progress = {
+            "project": self.project1,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.IN_PROGRESS
+        }
+
+        self.project2_build_success = {
+            "project": self.project2,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.SUCCEEDED
+        }
+
+        self.project2_build_in_progress = {
+            "project": self.project2,
+            "started_on": now,
+            "completed_on": now,
+            "outcome": Build.IN_PROGRESS
+        }
+
+    def _get_rows_for_project(self, project_id):
+        url = reverse("projectbuilds", args=(project_id,))
+        response = self.client.get(url, follow=True)
+        soup = BeautifulSoup(response.content)
+        return soup.select('tr[class="data"]')
+
+    def test_show_builds_for_project(self):
+        """ Builds for a project should be displayed """
+        build1a = Build.objects.create(**self.project1_build_success)
+        build1b = Build.objects.create(**self.project1_build_success)
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 2)
+
+    def test_show_builds_for_project_only(self):
+        """ Builds for other projects should be excluded """
+        build1a = Build.objects.create(**self.project1_build_success)
+        build1b = Build.objects.create(**self.project1_build_success)
+        build1c = Build.objects.create(**self.project1_build_success)
+
+        # shouldn't see these two
+        build2a = Build.objects.create(**self.project2_build_success)
+        build2b = Build.objects.create(**self.project2_build_in_progress)
+
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 3)
+
+    def test_show_builds_exclude_in_progress(self):
+        """ "in progress" builds should not be shown """
+        build1a = Build.objects.create(**self.project1_build_success)
+        build1b = Build.objects.create(**self.project1_build_success)
+
+        # shouldn't see this one
+        build1c = Build.objects.create(**self.project1_build_in_progress)
+
+        # shouldn't see these two either, as they belong to a different project
+        build2a = Build.objects.create(**self.project2_build_success)
+        build2b = Build.objects.create(**self.project2_build_in_progress)
+
+        build_rows = self._get_rows_for_project(self.project1.id)
+        self.assertEqual(len(build_rows), 2)
\ No newline at end of file
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c9831b1..6ff510d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -40,7 +40,7 @@ from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponseNotFound
 from django.utils import timezone
 from django.utils.html import escape
-from datetime import timedelta, datetime, date
+from datetime import timedelta, datetime
 from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 import json
@@ -435,8 +435,7 @@ def _modify_date_range_filter(filter_string):
 def _add_daterange_context(queryset_all, request, daterange_list):
     # calculate the exact begining of local today and yesterday
     today_begin = timezone.localtime(timezone.now())
-    today_begin = date(today_begin.year,today_begin.month,today_begin.day)
-    yesterday_begin = today_begin-timedelta(days=1)
+    yesterday_begin = today_begin - timedelta(days=1)
     # add daterange persistent
     context_date = {}
     context_date['last_date_from'] = request.GET.get('last_date_from',timezone.localtime(timezone.now()).strftime("%d/%m/%Y"))
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 19b5293..1d7d21b 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,3 +2,4 @@ Django==1.6
 South==0.8.4
 argparse==1.2.1
 wsgiref==0.1.2
+beautifulsoup4>=4.4.0
-- 
1.9.1


