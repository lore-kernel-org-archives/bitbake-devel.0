Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 485106023E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2013 09:08:10 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 18 Jun 2013 02:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,887,1363158000"; d="scan'208";a="256573722"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.72])
	by AZSMGA002.ch.intel.com with ESMTP; 18 Jun 2013 02:08:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2013 10:08:04 +0100
Message-Id: <1371546484-18146-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.12][PATCH] tinfoil: backport to 1.12
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Jun 2013 09:08:10 -0000

Backport the tinfoil wrapper that allows external utilities to make use
of bitbake code easily. This allows the OpenEmbedded layer index to
parse recipes from OE-Classic.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py  | 22 +++++++++----
 lib/bb/tinfoil.py | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 6 deletions(-)
 create mode 100644 lib/bb/tinfoil.py

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c8d898e..70a44c6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -32,6 +32,7 @@ import sre_constants
 import threading
 from cStringIO import StringIO
 from contextlib import closing
+from functools import wraps
 import bb
 from bb import utils, data, parse, event, cache, providers, taskdata, command, runqueue
 
@@ -495,12 +496,6 @@ class BBCooker:
             path, _ = os.path.split(path)
 
     def parseConfigurationFiles(self, files):
-        def _parse(f, data, include=False):
-            try:
-                return bb.parse.handle(f, data, include)
-            except (IOError, bb.parse.ParseError) as exc:
-                parselog.critical("Unable to parse %s: %s" % (f, exc))
-                sys.exit(1)
 
         data = self.configuration.data
         bb.parse.init_parser(data)
@@ -941,6 +936,21 @@ def parse_file(task):
         exc.recipe = filename
         raise exc
 
+def catch_parse_error(func):
+    """Exception handling bits for our parsing"""
+    @wraps(func)
+    def wrapped(fn, *args):
+        try:
+            return func(fn, *args)
+        except (IOError, bb.parse.ParseError) as exc:
+            parselog.critical("Unable to parse %s: %s" % (fn, exc))
+            sys.exit(1)
+    return wrapped
+
+@catch_parse_error
+def _parse(fn, data, include=False):
+    return bb.parse.handle(fn, data, include)
+
 class CookerParser(object):
     def __init__(self, cooker, filelist, masked):
         self.filelist = filelist
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
new file mode 100644
index 0000000..f3cb4f9
--- /dev/null
+++ b/lib/bb/tinfoil.py
@@ -0,0 +1,95 @@
+# tinfoil: a simple wrapper around cooker for bitbake-based command-line utilities
+#
+# Copyright (C) 2012 Intel Corporation
+# Copyright (C) 2011 Mentor Graphics Corporation
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
+import logging
+import warnings
+import os
+import sys
+
+import bb.cache
+import bb.cooker
+import bb.providers
+import bb.utils
+from bb.cooker import state
+import bb.fetch2
+
+class Tinfoil:
+    def __init__(self):
+        # Needed to avoid deprecation warnings with python 2.6
+        warnings.filterwarnings("ignore", category=DeprecationWarning)
+
+        # Set up logging
+        self.logger = logging.getLogger('BitBake')
+        console = logging.StreamHandler(sys.stdout)
+        format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+        console.setFormatter(format)
+        self.logger.addHandler(console)
+
+        initialenv = os.environ.copy()
+        bb.utils.clean_environment()
+        self.config = TinfoilConfig(parse_only=True)
+        self.cooker = bb.cooker.BBCooker(self.config,
+                                            self.register_idle_function)
+        self.config_data = self.cooker.configuration.data
+        bb.providers.logger.setLevel(logging.ERROR)
+        self.cooker_data = None
+
+    def register_idle_function(self, function, data):
+        pass
+
+    def parseRecipes(self):
+        sys.stderr.write("Parsing recipes..")
+        self.logger.setLevel(logging.WARNING)
+
+        try:
+            while self.cooker.state in (state.initial, state.parsing):
+                self.cooker.updateCache()
+        except KeyboardInterrupt:
+            self.cooker.shutdown()
+            self.cooker.updateCache()
+            sys.exit(2)
+
+        self.logger.setLevel(logging.INFO)
+        sys.stderr.write("done.\n")
+
+        self.cooker_data = self.cooker.status
+
+    def prepare(self, config_only = False):
+        if not self.cooker_data:
+            if config_only:
+                self.cooker.parseConfiguration()
+                self.cooker_data = self.cooker.status
+            else:
+                self.parseRecipes()
+
+
+class TinfoilConfig(object):
+    def __init__(self, **options):
+        self.pkgs_to_build = []
+        self.debug_domains = []
+        self.extra_assume_provided = []
+        self.file = []
+        self.debug = 0
+        self.__dict__.update(options)
+
+    def __getattr__(self, attribute):
+        try:
+            return super(TinfoilConfig, self).__getattribute__(attribute)
+        except AttributeError:
+            return None
+
-- 
1.8.1.2


