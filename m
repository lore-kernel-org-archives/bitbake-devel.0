Return-Path: <elliot.smith@intel.com>
Received: from butterfly.birch.relay.mailchannels.net
	(butterfly.birch.relay.mailchannels.net [23.83.209.27])
	by mail.openembedded.org (Postfix) with ESMTP id 9085775E2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:49 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BB07A1287AD;
	Mon, 22 Aug 2016 15:42:48 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-3-24.us-west-2.compute.internal [10.220.3.24])
	by relay.mailchannels.net (Postfix) with ESMTPA id C77FF128705;
	Mon, 22 Aug 2016 15:42:47 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.92.147.53])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:48 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880568167:335431608
X-MC-Ingress-Time: 1471880568166
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN8-0002ZA-LB; Mon, 22 Aug 2016 11:42:46 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:34 +0100
Message-Id: <1471880556-9232-7-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 7/9] toaster: tests Add selenium test layer source switching layer details page
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:49 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add selenium tests for the new layer source switching functionality on
the layer details page. Edits the values for git repository and saves
and then edits the details for directory information and saves.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tests/browser/test_layerdetails_page.py        | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
index 2fa9672..72b6f60 100644
--- a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -82,15 +82,17 @@ class TestLayerDetailsPage(SeleniumTestCase):
         self.get(self.url)
 
         self.click("#add-remove-layer-btn")
+        self.click("#edit-layer-source")
+        self.click("#repo")
+
+        self.wait_until_visible("#layer-git-repo-url")
 
         # Open every edit box
         for btn in self.find_all("dd .glyphicon-edit"):
             btn.click()
 
-        self.wait_until_visible("dd input")
-
         # Edit each value
-        for inputs in self.find_all("dd input[type=text]") + \
+        for inputs in self.find_all("#layer-git input[type=text]") + \
                 self.find_all("dd textarea"):
             # ignore the tt inputs (twitter typeahead input)
             if "tt-" in inputs.get_attribute("class"):
@@ -104,16 +106,20 @@ class TestLayerDetailsPage(SeleniumTestCase):
 
             inputs.send_keys("-edited")
 
+        # Save the new values
         for save_btn in self.find_all(".change-btn"):
             save_btn.click()
 
+        self.click("#save-changes-for-switch")
+        self.wait_until_visible("#edit-layer-source")
+
         # Refresh the page to see if the new values are returned
         self.get(self.url)
 
         new_values = ["%s-edited" % old_val
                       for old_val in self.initial_values]
 
-        for inputs in self.find_all('dd input[type="text"]') + \
+        for inputs in self.find_all('#layer-git input[type="text"]') + \
                 self.find_all('dd textarea'):
             # ignore the tt inputs (twitter typeahead input)
             if "tt-" in inputs.get_attribute("class"):
@@ -125,6 +131,24 @@ class TestLayerDetailsPage(SeleniumTestCase):
                             "Expecting any of \"%s\" but got \"%s\"" %
                             (new_values, value))
 
+        # Now convert it to a local layer
+        self.click("#edit-layer-source")
+        self.click("#dir")
+        dir_input = self.wait_until_visible("#layer-dir-path-in-details")
+
+        new_dir = "/home/test/my-meta-dir"
+        dir_input.send_keys(new_dir)
+
+        self.click("#save-changes-for-switch")
+        self.wait_until_visible("#edit-layer-source")
+
+        # Refresh the page to see if the new values are returned
+        self.get(self.url)
+        dir_input = self.find("#layer-dir-path-in-details")
+        self.assertTrue(new_dir in dir_input.get_attribute("value"),
+                        "Expected %s in the dir value for layer directory" %
+                        new_dir)
+
     def test_delete_layer(self):
         """ Delete the layer """
 
-- 
2.7.4


