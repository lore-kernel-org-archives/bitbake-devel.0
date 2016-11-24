Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f175.google.com (mail-wj0-f175.google.com
	[209.85.210.175])
	by mail.openembedded.org (Postfix) with ESMTP id 333D271B58
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:21 +0000 (UTC)
Received: by mail-wj0-f175.google.com with SMTP id mp19so31052806wjc.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=k15eI0QXBQ3hK0e05ed+AMyTZG3scsbox+BUFfTSMO0=;
	b=qZDLM7UNFVPFTiKYsIF9qmVKdL/eJyYWh5V79fYNrHuFKcIMmHWk5CjUkNuSqKIec4
	h1N65DN+Q/gQwshWydUoPyIV2zkodzkn+d2CAkeIuKzWZIobiQR6SedWwLmENckBVxzx
	WLCBxPQdV8wIGXZst5TZnmX1iSc/sXc7HNsaWnN7lweObhleEIjXDLucnat9hL/Ekmna
	o+R4RDu8BqhNUdnPhHCob1IGwpBKE8hk5AAQgO2zd9w2Gz8yN0flHgqpzDa9zQoiWczf
	o1jc9xxSVxFJsiQXYHAk7UNYvqRu/11fVmbe4eBqN+hY2Qm301/lXgToeHplHRtnwgxo
	iDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=k15eI0QXBQ3hK0e05ed+AMyTZG3scsbox+BUFfTSMO0=;
	b=O4/zKJ4e2xjF576unKpSAX4bbuu+MbIUkw+NJktZpWnrgCLdXvbwDaY9sc4TpGnjLx
	uRbP9VduksEjCd9jnRx9E68wx0j+WaVGOWNqUWslwICL/GKBWGBCh6/mVKAg23EoiZ5l
	JtdGlVCQJDibDzm14wR5zmAY2N62vq7bDBuykcSB6GzHwcIDKFomuUTzfCCymwZnIVtO
	I5GZcwrinoTLr3ugLSUW2GWIai1qWuARTOXeTOSfgh1jrgbUqCkw32jLFtArAE6pZELv
	MGHuTKbZ0CQGj9R6z2G4w7LMp/MlpeqwHidwrPg7ecNtmCCiARJN2DnwOVE1lLeVNxQ1
	aM4Q==
X-Gm-Message-State: AKaTC03WTmJr/k4L5j0YSRtbsuil13ETHAWn65zAnJWvvntnnGdK6EStGXA+WoMmnVBOIbZD
X-Received: by 10.194.14.105 with SMTP id o9mr1813263wjc.66.1479986422739;
	Thu, 24 Nov 2016 03:20:22 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:22 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:53 +0000
Message-Id: <1479986406-4657-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 02/15] toaster: tests Add management command tests
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:22 -0000

Add some simple sanity tests for the management commands that we use for
Toaster.

Can be executed with ./manage.py test tests.commands

For faster execution use the test settings and keepdb flag:
DJANGO_SETTINGS_MODULE=toastermain.settings_test ./manage.py test
tests.commands --keepdb

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/commands/__init__.py       |  0
 lib/toaster/tests/commands/test_loaddata.py  | 61 +++++++++++++++++++
 lib/toaster/tests/commands/test_lsupdates.py | 45 ++++++++++++++
 lib/toaster/tests/commands/test_runbuilds.py | 88 ++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 lib/toaster/tests/commands/__init__.py
 create mode 100644 lib/toaster/tests/commands/test_loaddata.py
 create mode 100644 lib/toaster/tests/commands/test_lsupdates.py
 create mode 100644 lib/toaster/tests/commands/test_runbuilds.py

diff --git a/lib/toaster/tests/commands/__init__.py b/lib/toaster/tests/commands/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/commands/test_loaddata.py b/lib/toaster/tests/commands/test_loaddata.py
new file mode 100644
index 0000000..951f6ff
--- /dev/null
+++ b/lib/toaster/tests/commands/test_loaddata.py
@@ -0,0 +1,61 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016 Intel Corporation
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
+from django.test import TestCase
+from django.core import management
+
+from orm.models import Layer_Version, Layer, Release, ToasterSetting
+
+
+class TestLoadDataFixtures(TestCase):
+    """ Test loading our 3 provided fixtures """
+    def test_run_loaddata_poky_command(self):
+        management.call_command('loaddata', 'poky')
+
+        num_releases = Release.objects.count()
+
+        self.assertTrue(
+            Layer_Version.objects.filter(
+                layer__name="meta-poky").count() == num_releases,
+            "Loaded poky fixture but don't have a meta-poky for all releases"
+            " defined")
+
+    def test_run_loaddata_oecore_command(self):
+        management.call_command('loaddata', 'oe-core')
+
+        # We only have the one layer for oe-core setup
+        self.assertTrue(
+            Layer.objects.filter(name="openembedded-core").count() > 0,
+            "Loaded oe-core fixture but still have no openemebedded-core"
+            " layer")
+
+    def test_run_loaddata_settings_command(self):
+        management.call_command('loaddata', 'settings')
+
+        self.assertTrue(
+            ToasterSetting.objects.filter(name="DEFAULT_RELEASE").count() > 0,
+            "Loaded settings but have no DEFAULT_RELEASE")
+
+        self.assertTrue(
+            ToasterSetting.objects.filter(
+                name__startswith="DEFCONF").count() > 0,
+            "Loaded settings but have no DEFCONF (default project "
+            "configuration values)")
diff --git a/lib/toaster/tests/commands/test_lsupdates.py b/lib/toaster/tests/commands/test_lsupdates.py
new file mode 100644
index 0000000..49897a4
--- /dev/null
+++ b/lib/toaster/tests/commands/test_lsupdates.py
@@ -0,0 +1,45 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016 Intel Corporation
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
+from django.test import TestCase
+from django.core import management
+
+from orm.models import Layer_Version, Machine, Recipe
+
+
+class TestLayerIndexUpdater(TestCase):
+    def test_run_lsupdates_command(self):
+        # Load some release information for us to fetch from the layer index
+        management.call_command('loaddata', 'poky')
+
+        old_layers_count = Layer_Version.objects.count()
+        old_recipes_count = Recipe.objects.count()
+        old_machines_count = Machine.objects.count()
+
+        # Now fetch the metadata from the layer index
+        management.call_command('lsupdates')
+
+        self.assertTrue(Layer_Version.objects.count() > old_layers_count,
+                        "lsupdates ran but we still have no more layers!")
+        self.assertTrue(Recipe.objects.count() > old_recipes_count,
+                        "lsupdates ran but we still have no more Recipes!")
+        self.assertTrue(Machine.objects.count() > old_machines_count,
+                        "lsupdates ran but we still have no more Machines!")
diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
new file mode 100644
index 0000000..3e63483
--- /dev/null
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -0,0 +1,88 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016 Intel Corporation
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
+import os
+
+from django.test import TestCase
+from django.core import management
+
+from orm.models import signal_runbuilds
+
+import threading
+import time
+import subprocess
+import signal
+
+
+class KillRunbuilds(threading.Thread):
+    """ Kill the runbuilds process after an amount of time """
+    def __init__(self, *args, **kwargs):
+        super(KillRunbuilds, self).__init__(*args, **kwargs)
+        self.setDaemon(True)
+
+    def run(self):
+        time.sleep(5)
+        signal_runbuilds()
+        time.sleep(1)
+
+        pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
+                                    ".runbuilds.pid")
+
+        with open(pidfile_path) as pidfile:
+            pid = pidfile.read()
+            os.kill(int(pid), signal.SIGTERM)
+
+
+class TestCommands(TestCase):
+    """ Sanity test that runbuilds executes OK """
+
+    def setUp(self):
+        os.environ.setdefault("DJANGO_SETTINGS_MODULE",
+                              "toastermain.settings_test")
+        os.environ.setdefault("BUILDDIR",
+                              "/tmp/")
+
+        # Setup a real database if needed for runbuilds process
+        # to connect to
+        management.call_command('migrate')
+
+    def test_runbuilds_command(self):
+        kill_runbuilds = KillRunbuilds()
+        kill_runbuilds.start()
+
+        manage_py = os.path.join(
+            os.path.dirname(os.path.abspath(__file__)),
+            os.pardir,
+            os.pardir,
+            "manage.py")
+
+        command = "%s runbuilds" % manage_py
+
+        process = subprocess.Popen(command,
+                                   shell=True,
+                                   stdout=subprocess.PIPE,
+                                   stderr=subprocess.PIPE)
+
+        (out, err) = process.communicate()
+        process.wait()
+
+        self.assertNotEqual(process.returncode, 1,
+                            "Runbuilds returned an error %s" % err)
-- 
2.7.4


