Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 7BB4073199
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 20:48:51 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 30 Aug 2016 13:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,258,1470726000"; d="scan'208";a="162622922"
Received: from ashuvini-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.135])
	by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2016 13:48:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Aug 2016 08:48:07 +1200
Message-Id: <ebc225ccd0012ab7104e52aaac1510c3742d4d90.1472589757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 2/4] Ensure tinfoil is shut down correctly in utilities that use it
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
X-List-Received-Date: Tue, 30 Aug 2016 20:48:52 -0000

We should always shut down tinfoil when we're finished with it, either
by explicitly calling the shutdown() method or by using it as a
context manager ("with ...").

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs |  6 +++---
 bin/bitbake-layers   | 53 +++++++++++++++++++++++++++-------------------------
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 3b6ef88..527d2c7 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -115,9 +115,9 @@ parser.add_option("-t", "--task",
 options, args = parser.parse_args(sys.argv)
 
 if options.taskargs:
-    tinfoil = bb.tinfoil.Tinfoil()
-    tinfoil.prepare(config_only = True)
-    find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
+    with bb.tinfoil.Tinfoil() as tinfoil:
+        tinfoil.prepare(config_only=True)
+        find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
 else:
     if len(args) == 1:
         parser.print_help()
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 0c973df..946def2 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -87,31 +87,34 @@ def main():
 
     plugins = []
     tinfoil = tinfoil_init(False)
-    for path in ([topdir] +
-                 tinfoil.config_data.getVar('BBPATH', True).split(':')):
-        pluginpath = os.path.join(path, 'lib', 'bblayers')
-        bb.utils.load_plugins(logger, plugins, pluginpath)
-
-    registered = False
-    for plugin in plugins:
-        if hasattr(plugin, 'register_commands'):
-            registered = True
-            plugin.register_commands(subparsers)
-        if hasattr(plugin, 'tinfoil_init'):
-            plugin.tinfoil_init(tinfoil)
-
-    if not registered:
-        logger.error("No commands registered - missing plugins?")
-        sys.exit(1)
-
-    args = parser.parse_args(unparsed_args, namespace=global_args)
-
-    if getattr(args, 'parserecipes', False):
-        tinfoil.config_data.disableTracking()
-        tinfoil.parseRecipes()
-        tinfoil.config_data.enableTracking()
-
-    return args.func(args)
+    try:
+        for path in ([topdir] +
+                    tinfoil.config_data.getVar('BBPATH', True).split(':')):
+            pluginpath = os.path.join(path, 'lib', 'bblayers')
+            bb.utils.load_plugins(logger, plugins, pluginpath)
+
+        registered = False
+        for plugin in plugins:
+            if hasattr(plugin, 'register_commands'):
+                registered = True
+                plugin.register_commands(subparsers)
+            if hasattr(plugin, 'tinfoil_init'):
+                plugin.tinfoil_init(tinfoil)
+
+        if not registered:
+            logger.error("No commands registered - missing plugins?")
+            sys.exit(1)
+
+        args = parser.parse_args(unparsed_args, namespace=global_args)
+
+        if getattr(args, 'parserecipes', False):
+            tinfoil.config_data.disableTracking()
+            tinfoil.parseRecipes()
+            tinfoil.config_data.enableTracking()
+
+        return args.func(args)
+    finally:
+        tinfoil.shutdown()
 
 
 if __name__ == "__main__":
-- 
2.5.5


