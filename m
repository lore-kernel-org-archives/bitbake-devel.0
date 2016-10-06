Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7748C71A9C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 05 Oct 2016 17:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="1040898359"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:54 -0700
Message-Id: <51df288713a95fefa518d001e93a4fb089b0d2a7.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
References: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
In-Reply-To: <cover.1475712223.git.brian.avery@intel.com>
References: <cover.1475712223.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 6/6] toaster: Update tests to reflect front end changes
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
X-List-Received-Date: Thu, 06 Oct 2016 00:07:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

 - Browser test we changed the project heading access to use the class name
 - Update toastergui unit test for additional gotoUrl property
 - On faster browsers we had a race for layer details inputs being
   visible

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 4 ++++
 lib/toaster/tests/browser/test_project_page.py      | 2 +-
 lib/toaster/toastergui/tests.py                     | 8 +++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 72b6f60..6392d1e 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -91,6 +91,10 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for btn in self.find_all("dd .glyphicon-edit"):
             btn.click()
 
+        # Wait for the inputs to become visible
+        self.wait_until_visible("#layer-git input[type=text]")
+        self.wait_until_visible("dd textarea")
+
         # Edit each value
         for inputs in self.find_all("#layer-git input[type=text]") + \
                 self.find_all("dd textarea"):
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
index 786bef1..0186463 100644
--- a/lib/toaster/tests/browser/test_project_page.py
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -55,5 +55,5 @@ class TestProjectPage(SeleniumTestCase):
         self.get(url)
 
         # check that we get a project page with the correct heading
-        project_name = self.find('#project-name').text.strip()
+        project_name = self.find('.project-name').text.strip()
         self.assertEqual(project_name, self.CLI_BUILDS_PROJECT_NAME)
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 0508611..2b5894f 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -248,7 +248,13 @@ class ViewTests(TestCase):
         url = reverse('xhr_customrecipe_id', args=(recipe.id,))
         response = self.client.delete(url)
         self.assertEqual(response.status_code, 200)
-        self.assertEqual(json.loads(response.content.decode('utf-8')), {"error": "ok"})
+
+        gotoUrl = reverse('projectcustomimages', args=(self.project.pk,))
+
+        self.assertEqual(json.loads(response.content.decode('utf-8')),
+                         {"error": "ok",
+                          "gotoUrl": gotoUrl})
+
         # try to delete not-existent recipe
         url = reverse('xhr_customrecipe_id', args=(recipe.id,))
         response = self.client.delete(url)
-- 
1.9.1


