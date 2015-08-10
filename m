Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id EECE9768E0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:28 +0000 (UTC)
Received: by wijp15 with SMTP id p15so144496050wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Nd51VbkPwzxFC0aHWVoGb04K0zHorIp+ccUtw6bJrMY=;
	b=lbew4pk1K9P4BUxBqZjWU84q7zXq2F71P28OEPPsv8L3V2cjJcg/oIWBHf3j0RC9nB
	kBOmAckbGpziOByFKWwHtDsbSof05G6pOFoeUJuThNBJIcp8R3yFSZScbOZJUHQNTvtf
	2XDbqAAruR1SKaxwHqAADWJT0KT0qG3pp9qE0scelGKi5NIZONDkJciemoD3Kg3g7GGe
	7Zaka0GT4y0/2Tt/cdBj+Eajs8DBI5yMC5Bjq37XhseYVFGJhNTyAyDrOeU+vG+M32NE
	CsSwG3oFoAByOaZJsuOSbtKxQ6QoD9If/MjNH6KPIRhJdZ5J1Wsk3/lNQTjDaY0Ir9vi
	Xtig==
X-Gm-Message-State: ALoCoQmueCk9C6LTTzH/XXeS6A1hxUVc9yH6s59VIv8OcYhrHzASTI7Nax+ZQa0Qann9Zky6UldP
X-Received: by 10.180.8.135 with SMTP id r7mr26858786wia.58.1439227648671;
	Mon, 10 Aug 2015 10:27:28 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.27
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:28 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:14 +0100
Message-Id: <4044383aa4914dc063bc836302407f518d9f3f9a.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 07/11] toaster: add header and docstings
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:29 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added header and docstrings to toastergui tests module.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 624ab7c..1ed83dc 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -1,3 +1,26 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2015 Intel Corporation
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
+"""Test cases for Toaster GUI and ReST."""
+
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from orm.models import Project, Release, BitbakeVersion
@@ -45,6 +68,7 @@ class ViewTests(TestCase):
         self.assertTrue(self.lver in self.project.compatible_layerversions())
 
     def test_get_base_call_returns_html(self):
+        """Basic test for all-projects view"""
         response = self.client.get(reverse('all-projects'), follow=True)
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('text/html'))
@@ -52,6 +76,7 @@ class ViewTests(TestCase):
         self.assertTrue(PROJECT_NAME in response.content)
 
     def test_get_json_call_returns_json(self):
+        """Test for all projects output in json format"""
         url = reverse('all-projects')
         response = self.client.get(url, {"format": "json"}, follow=True)
         self.assertEqual(response.status_code, 200)
@@ -73,6 +98,7 @@ class ViewTests(TestCase):
         self.assertTrue("projectBuildsUrl" in data["rows"][0])
 
     def test_typeaheads(self):
+        """Test typeahead ReST API"""
         layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
         prj_url = reverse('xhr_projectstypeahead')
 
@@ -82,7 +108,8 @@ class ViewTests(TestCase):
                  reverse('xhr_machinestypeahead', args=(self.project.id,)),
                ]
 
-        def basic_reponse_check(reponse, url):
+        def basic_reponse_check(response, url):
+            """Check data structure of http response."""
             self.assertEqual(response.status_code, 200)
             self.assertTrue(response['Content-Type'].startswith('application/json'))
 
-- 
2.1.4


