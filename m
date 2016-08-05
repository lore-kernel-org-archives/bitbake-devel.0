Return-Path: <elliot.smith@intel.com>
Received: from nov-007-i608.relay.mailchannels.net
	(nov-007-i608.relay.mailchannels.net [46.232.183.162])
	by mail.openembedded.org (Postfix) with ESMTP id C6D2777045
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Aug 2016 08:27:03 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 71CD4125F9B;
	Fri,  5 Aug 2016 08:27:00 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-120-4-226.us-west-2.compute.internal [10.120.4.226])
	by relay.mailchannels.net (Postfix) with ESMTPA id 90E0E124C01;
	Fri,  5 Aug 2016 08:26:59 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.21.150.52])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.4); Fri, 05 Aug 2016 08:27:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1470385619946:1373467425
X-MC-Ingress-Time: 1470385619946
Received: from [176.249.240.35] (port=35602 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bVaT4-0003aB-FD; Fri, 05 Aug 2016 04:26:58 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  5 Aug 2016 09:26:49 +0100
Message-Id: <1470385609-31463-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH] toaster: tests test_new_project_page Catch button not enabled exception
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
X-List-Received-Date: Fri, 05 Aug 2016 08:27:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

When using firefox and selenium we get an exception generated when a
disabled button click is attempted. This should happen in the test but
we need to catch the exception to make sure it doesn't cause the test to
fail.

[YOCTO #10056]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/tests/browser/test_new_project_page.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/tests/browser/test_new_project_page.py b/bitbake/lib/toaster/tests/browser/test_new_project_page.py
index 1b038ac..77e5f15 100644
--- a/bitbake/lib/toaster/tests/browser/test_new_project_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_new_project_page.py
@@ -22,6 +22,7 @@
 from django.core.urlresolvers import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 from selenium.webdriver.support.ui import Select
+from selenium.common.exceptions import InvalidElementStateException
 
 from orm.models import Project, Release, BitbakeVersion
 
@@ -102,7 +103,10 @@ class TestNewProjectPage(SeleniumTestCase):
 
         # Try and click it anyway, if it submits we'll have a new project in
         # the db and assert then
-        self.click("#create-project-button")
+        try:
+            self.click("#create-project-button")
+        except InvalidElementStateException:
+            pass
 
         self.assertTrue(
             (Project.objects.filter(name=project_name).count() == 1),
-- 
2.7.4


