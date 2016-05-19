Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id E9D3365CC3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 12:59:45 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 May 2016 05:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="106841800"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by fmsmga004.fm.intel.com with ESMTP; 19 May 2016 05:59:47 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 13:59:30 +0100
Message-Id: <1463662773-31389-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
References: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 3/6] toaster: Add a specific test settings file
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
X-List-Received-Date: Thu, 19 May 2016 12:59:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

When running certain tests we want a particular database specified.
When bitbake toaster ui is being tested pass it these test settings so
that it uses the same database as the unit tests running.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastermain/settings-test.py | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastermain/settings-test.py

diff --git a/bitbake/lib/toaster/toastermain/settings-test.py b/bitbake/lib/toaster/toastermain/settings-test.py
new file mode 100644
index 0000000..36b14c0
--- /dev/null
+++ b/bitbake/lib/toaster/toastermain/settings-test.py
@@ -0,0 +1,41 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016        Intel Corporation
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
+# Django settings for Toaster project.
+
+# Settings overlay to use for running tests
+# DJANGO_SETTINGS_MODULE=toastermain.settings-test
+
+from settings import *
+
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+DATABASES = {
+    'default': {
+        'ENGINE': 'django.db.backends.sqlite3',
+        'NAME': '/tmp/toaster-test-db.sqlite',
+        'TEST': {
+            'ENGINE': 'django.db.backends.sqlite3',
+            'NAME': '/tmp/toaster-test-db.sqlite',
+        }
+    }
+}
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


