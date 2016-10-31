Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id 4A53B71AAD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:40:47 +0000 (UTC)
Received: by mail-pf0-f177.google.com with SMTP id 189so25679725pfz.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dj/g6BkOQU1UBTap8/JyFXNSBcieWVHWaIWyaoDXtoA=;
	b=rn7Gz8vO9yaTAxTpOhXtTiTqpFIXd67rWv24IqEebWig2f0DCCCrj7B5Zqmy6gYvSO
	qdfGJSX90bketD1QZcw89HWD5fET+inDpNoJlqwbsRiA06zbqgv7ysI3LHzDptgo38Ro
	aK+yDPYkIDeQqD8uuZk2Jksm+V7k6Wj1QhOWrbhtgdz9vWy3OSmvR01dwhK6hrgP3dTf
	IFcaKqZhYyelQqgACoq1HXyl6xQi/xr/KBVThfgPF2JBVj4FB4ir13jogBhhtPDnvM53
	OAU4b1p86Xe2FVGUqV7b5m6OWs3+w1vzQqM/hgp/mjJnu+kCftKEdpTA6NcJ1YfKGTiy
	7pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dj/g6BkOQU1UBTap8/JyFXNSBcieWVHWaIWyaoDXtoA=;
	b=ZZ3k+TAdGuC1GGWxGKAzHtGKbVHHKN0KtytZMm1hNqvpLowb1p3E9x/LISi1pyTZRi
	dJVCqWht3Wv/ZcXFyJtOYltYS0tNMq1OWsxWG47pLv0yWrx7rb/h/kYnyXq5Z9Te5h30
	qGaVMRvjqHhrEDISOsb8V2aoIcdFX+IkCIH3n7ztWv+iDrZ+HkwoShEVy7CVYSy7XzSf
	xot5Lp5fG+3y7MWjzBb16DSvVCfkrZ2b9mZ4GGhuwVAn/yqqV4/s5AMd/iHcwvbDw+Fu
	MUPi+v8XmrTSBq3aBdgTfrM6r3pOkEFrDeGjPC+pQ+MfxpWCjZIIaOm7pOUpvdwHlrVE
	/Osg==
X-Gm-Message-State: ABUngvf0Ktdrf60VnV2KQr5VQNX4ziQCYlrz8C3veyXud4o3KGaYJ9gKYizlZlaFR+kolwUs
X-Received: by 10.98.44.212 with SMTP id s203mr51107197pfs.84.1477932049226;
	Mon, 31 Oct 2016 09:40:49 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	j192sm36718494pfc.60.2016.10.31.09.40.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 31 Oct 2016 09:40:48 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 16:40:38 +0000
Message-Id: <1477932040-10112-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
References: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/4] toaster: add eventreplay test case for core-image-minimal
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
X-List-Received-Date: Mon, 31 Oct 2016 16:40:48 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Run toaster-eventreplay with core-image-minimal.events and
test if all required packages present in Target_Installed_Package
table.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/eventreplay/__init__.py | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 lib/toaster/tests/eventreplay/__init__.py

diff --git a/lib/toaster/tests/eventreplay/__init__.py b/lib/toaster/tests/eventreplay/__init__.py
new file mode 100644
index 0000000..792f07d
--- /dev/null
+++ b/lib/toaster/tests/eventreplay/__init__.py
@@ -0,0 +1,87 @@
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
+# Tests were part of openembedded-core oe selftest Authored by: Lucian Musat
+# Ionut Chisanovici, Paul Eggleton and Cristian Iorga
+
+"""
+Test toaster backend by playing build event log files
+using toaster-eventreplay script
+"""
+
+import os
+
+from subprocess import getstatusoutput
+from pathlib import Path
+
+from django.test import TestCase
+
+from orm.models import Target_Installed_Package
+
+class EventReplay(TestCase):
+    """Base class for eventreplay test cases"""
+
+    def setUp(self):
+        """
+        Setup build environment:
+            - set self.script to toaster-eventreplay path
+            - set self.eventplay_dir to the value of EVENTPLAY_DIR env variable
+        """
+        bitbake_dir = Path(__file__.split('lib/toaster')[0])
+        self.script = bitbake_dir /  'bin' / 'toaster-eventreplay'
+        self.assertTrue(self.script.exists(), "%s doesn't exist")
+        self.eventplay_dir = os.getenv("EVENTREPLAY_DIR")
+        self.assertTrue(self.eventplay_dir,
+                        "Environment variable EVENTREPLAY_DIR is not set")
+
+    def _replay(self, eventfile):
+        """Run toaster-eventplay <eventfile>"""
+        eventpath = Path(self.eventplay_dir) / eventfile
+        status, output = getstatusoutput('%s %s' % (self.script, eventpath))
+        if status:
+            print(output)
+
+        self.assertEqual(status, 0)
+
+class CoreImageMinimalEventReplay(EventReplay):
+    """Replay core-image-minimal events"""
+
+    def test_installed_packages(self):
+        """Test if all required packages have been installed"""
+
+        self._replay('core-image-minimal.events')
+
+        # test installed packages
+        packages = sorted(Target_Installed_Package.objects.\
+                          values_list('package__name', flat=True))
+        self.assertEqual(packages, ['base-files', 'base-passwd', 'busybox',
+                                    'busybox-hwclock', 'busybox-syslog',
+                                    'busybox-udhcpc', 'eudev', 'glibc',
+                                    'init-ifupdown', 'initscripts',
+                                    'initscripts-functions', 'kernel-base',
+                                    'kernel-module-uvesafb', 'libkmod',
+                                    'modutils-initscripts', 'netbase',
+                                    'packagegroup-core-boot', 'run-postinsts',
+                                    'sysvinit', 'sysvinit-inittab',
+                                    'sysvinit-pidof', 'udev-cache',
+                                    'update-alternatives-opkg',
+                                    'update-rc.d', 'util-linux-libblkid',
+                                    'util-linux-libuuid', 'v86d', 'zlib'])
-- 
2.7.4


