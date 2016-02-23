Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DE5DE772B3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:52 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272791"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:53 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:58 -0600
Message-Id: <1456188718-13755-9-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 8/8] toaster/tests: Adds Copyright information.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:53 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bin/toaster-test             | 17 +++++++++++++++++
 lib/toaster/tests/base.py    | 17 +++++++++++++++++
 lib/toaster/tests/helpers.py | 14 ++++++++++++++
 lib/toaster/tests/setup.py   | 17 +++++++++++++++++
 lib/toaster/tests/ui.py      | 17 ++++++++++++++++-
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/bin/toaster-test b/bin/toaster-test
index b0c26dc..d256629 100755
--- a/bin/toaster-test
+++ b/bin/toaster-test
@@ -1,5 +1,22 @@
 #!/usr/bin/env python
 
+# Toaster test runner
+#
+# Copyright (C) 2015-2016 Intel Corporation
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
 import sys
 import os
 import argparse
diff --git a/lib/toaster/tests/base.py b/lib/toaster/tests/base.py
index 8b303ac..3c13612 100644
--- a/lib/toaster/tests/base.py
+++ b/lib/toaster/tests/base.py
@@ -1,3 +1,20 @@
+# Toaster tests base class
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
 import unittest
 
 class ToasterOptions(object): 
diff --git a/lib/toaster/tests/helpers.py b/lib/toaster/tests/helpers.py
index 549358b..ed152b2 100755
--- a/lib/toaster/tests/helpers.py
+++ b/lib/toaster/tests/helpers.py
@@ -1,7 +1,21 @@
 #!/usr/bin/env python
 
+# Toaster helper for clone/setup/start/stop
+#
 # Copyright (C) 2016 Intel Corporation
 #
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
 
 import subprocess
 import os
diff --git a/lib/toaster/tests/setup.py b/lib/toaster/tests/setup.py
index 0acbb16..725e858 100644
--- a/lib/toaster/tests/setup.py
+++ b/lib/toaster/tests/setup.py
@@ -1,3 +1,20 @@
+# Toaster setup test case
+#
+# Copyright (C) 2015-2016 Intel Corporation
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
 import time
 
 from selenium import webdriver
diff --git a/lib/toaster/tests/ui.py b/lib/toaster/tests/ui.py
index cb11184..74dc9ce 100644
--- a/lib/toaster/tests/ui.py
+++ b/lib/toaster/tests/ui.py
@@ -1,4 +1,19 @@
-# Copyright
+# Toaster UI/Backend test cases
+#
+# Copyright (C) 2015-2016 Intel Corporation
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
 
 # DESCRIPTION
 # This is toaster automation base class and test cases file
-- 
2.1.4


