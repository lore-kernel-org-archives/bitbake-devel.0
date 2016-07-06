Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id EFB6F60119
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 17:22:48 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 08086E073E;
	Wed,  6 Jul 2016 17:22:48 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-37-2-55.us-west-2.compute.internal [10.37.2.55])
	by relay.mailchannels.net (Postfix) with ESMTPA id 42693E05AF;
	Wed,  6 Jul 2016 17:22:47 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 17:22:47 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467825767600:888042417
X-MC-Ingress-Time: 1467825767599
Received: from [176.251.41.101] (port=34404 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKqZo-0000gg-AM; Wed, 06 Jul 2016 13:25:32 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 18:22:39 +0100
Message-Id: <83dfd8f3e5d7eef8371473a7615779fa7e59cdb8.1467825407.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
References: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467825407.git.elliot.smith@intel.com>
References: <cover.1467825407.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 4/4] toaster: tests Add selenium test for layerdetails page
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
X-List-Received-Date: Wed, 06 Jul 2016 17:22:49 -0000

From: Michael Wood <michael.g.wood@intel.com>

This tests:
 - Adding remove layer from project
 - Deleting layer
 - Editing layer fields

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tests/browser/test_layerdetails_page.py        | 190 +++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_layerdetails_page.py

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
new file mode 100644
index 0000000..fb1007f
--- /dev/null
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -0,0 +1,190 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2016 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.core.urlresolvers import reverse
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import Layer, Layer_Version, Project, LayerSource, Release
+from orm.models import BitbakeVersion
+
+from selenium.webdriver.support import expected_conditions as EC
+from selenium.webdriver.support.ui import WebDriverWait
+from selenium.webdriver.common.by import By
+
+
+class TestLayerDetailsPage(SeleniumTestCase):
+    """ Test layerdetails page works correctly """
+
+    def __init__(self, *args, **kwargs):
+        super(TestLayerDetailsPage, self).__init__(*args, **kwargs)
+
+        self.initial_values = None
+        self.url = None
+        self.imported_layer_version = None
+
+    def setUp(self):
+        release = Release.objects.create(
+            name='baz',
+            bitbake_version=BitbakeVersion.objects.create(name='v1')
+        )
+
+        # project to add new custom images to
+        self.project = Project.objects.create(name='foo', release=release)
+
+        layer_source = LayerSource.objects.create(
+            sourcetype=LayerSource.TYPE_IMPORTED)
+
+        name = "meta-imported"
+        vcs_url = "git://example.com/meta-imported"
+        subdir = "/layer"
+        gitrev = "d33d"
+        summary = "A imported layer"
+        description = "This was imported"
+
+        imported_layer = Layer.objects.create(name=name,
+                                              vcs_url=vcs_url,
+                                              summary=summary,
+                                              description=description)
+
+        self.imported_layer_version = Layer_Version.objects.create(
+            layer=imported_layer,
+            layer_source=layer_source,
+            branch=gitrev,
+            commit=gitrev,
+            dirpath=subdir,
+            project=self.project)
+
+        self.initial_values = [name, vcs_url, subdir, gitrev, summary,
+                               description]
+        self.url = reverse('layerdetails',
+                           args=(self.project.pk,
+                                 self.imported_layer_version.pk))
+
+    def test_edit_layerdetails(self):
+        """ Edit all the editable fields for the layer refresh the page and
+        check that the new values exist"""
+
+        self.get(self.url)
+
+        self.click("#add-remove-layer-btn")
+
+        # Open every edit box
+        for btn in self.find_all("dd .glyphicon-edit"):
+            btn.click()
+
+        self.wait_until_visible("dd input")
+
+        # Edit each value
+        for inputs in self.find_all("dd input[type=text]") + \
+                self.find_all("dd textarea"):
+            # ignore the tt inputs (twitter typeahead input)
+            if "tt-" in inputs.get_attribute("class"):
+                continue
+
+            value = inputs.get_attribute("value")
+
+            self.assertTrue(value in self.initial_values,
+                            "Expecting any of \"%s\"but got \"%s\"" %
+                            (self.initial_values, value))
+
+            inputs.send_keys("-edited")
+
+        for save_btn in self.find_all(".change-btn"):
+            save_btn.click()
+
+        # Refresh the page to see if the new values are returned
+        self.get(self.url)
+
+        new_values = ["%s-edited" % old_val
+                      for old_val in self.initial_values]
+
+        for inputs in self.find_all("dd input[type=text]") + \
+                self.find_all("dd textarea"):
+            # ignore the tt inputs (twitter typeahead input)
+            if "tt-" in inputs.get_attribute("class"):
+                continue
+
+            value = inputs.get_attribute("value")
+
+            self.assertTrue(value in new_values,
+                            "Expecting any of \"%s\"but got \"%s\"" %
+                            (self.initial_values, value))
+
+    def test_delete_layer(self):
+        """ Delete the layer """
+
+        self.get(self.url)
+
+        # Wait for the tables to load to avoid a race condition where the
+        # toaster tables have made an async request. If the layer is deleted
+        # before the request finishes it will cause an exception and fail this
+        # test.
+        wait = WebDriverWait(self.driver, 30)
+
+        wait.until(EC.text_to_be_present_in_element(
+            (By.CLASS_NAME,
+             "table-count-recipestable"), "0"))
+
+        wait.until(EC.text_to_be_present_in_element(
+            (By.CLASS_NAME,
+             "table-count-machinestable"), "0"))
+
+        self.click('a[data-target="#delete-layer-modal"]')
+        self.wait_until_visible("#delete-layer-modal")
+        self.click("#layer-delete-confirmed")
+
+        notification = self.wait_until_visible("#change-notification-msg")
+        expected_text = "You have deleted 1 layer from your project: %s" % \
+            self.imported_layer_version.layer.name
+
+        self.assertTrue(expected_text in notification.text,
+                        "Expected notification text \"%s\" not found instead"
+                        "it was \"%s\"" %
+                        (expected_text, notification.text))
+
+    def test_addrm_to_project(self):
+        self.get(self.url)
+
+        # Add the layer
+        self.click("#add-remove-layer-btn")
+
+        notification = self.wait_until_visible("#change-notification-msg")
+
+        expected_text = "You have added 1 layer to your project: %s" % \
+            self.imported_layer_version.layer.name
+
+        self.assertTrue(expected_text in notification.text,
+                        "Expected notification text %s not found was "
+                        " \"%s\" instead" %
+                        (expected_text, notification.text))
+
+        # Remove the layer
+        self.click("#add-remove-layer-btn")
+
+        notification = self.wait_until_visible("#change-notification-msg")
+
+        expected_text = "You have removed 1 layer from your project: %s" % \
+            self.imported_layer_version.layer.name
+
+        self.assertTrue(expected_text in notification.text,
+                        "Expected notification text %s not found was "
+                        " \"%s\" instead" %
+                        (expected_text, notification.text))
-- 
2.7.4


