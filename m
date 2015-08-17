Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6C146767BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:41 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564797"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:22 +0100
Message-Id: <4f97e8585f449c28d935e5859f619b1a05e5210a.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 07/13] lib/bb/main: consolidate UI/server extension listing and loading
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:41 -0000

Provide us with a means of showing the list of UIs / server choices for
the command line help, and do the processing in one place for both.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py | 78 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 4d77408..2b720aa 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -41,22 +41,45 @@ logger = logging.getLogger("BitBake")
 class BBMainException(Exception):
     pass
 
-def get_ui(config):
-    if not config.ui:
-        # modify 'ui' attribute because it is also read by cooker
-        config.ui = os.environ.get('BITBAKE_UI', 'knotty')
-
-    interface = config.ui
-
+def list_extension_modules(pkg, checkattr):
+    """
+    Lists extension modules in a specific Python package
+    (e.g. UIs, servers)
+    Parameters:
+        pkg: previously imported Python package to list
+        checkattr: attribute to look for in module to determine if it's valid
+            as the type of extension you are looking for
+    """
+    import pkgutil
+    pkgdir = os.path.dirname(pkg.__file__)
+
+    modules = []
+    for _, modulename, _ in pkgutil.iter_modules([pkgdir]):
+        if os.path.isdir(os.path.join(pkgdir, modulename)):
+            # ignore directories
+            continue
+        try:
+            module = __import__(pkg.__name__, fromlist=[modulename])
+        except ImportError:
+            # If we can't import it, it's not valid
+            continue
+        module_if = getattr(module, modulename)
+        if getattr(module_if, 'hidden_extension', False):
+            continue
+        if not checkattr or hasattr(module_if, checkattr):
+            modules.append(modulename)
+    return modules
+
+def import_extension_module(pkg, modulename):
     try:
         # Dynamically load the UI based on the ui name. Although we
         # suggest a fixed set this allows you to have flexibility in which
         # ones are available.
-        module = __import__("bb.ui", fromlist = [interface])
-        return getattr(module, interface)
+        module = __import__(pkg.__name__, fromlist = [modulename])
+        return getattr(module, modulename)
     except AttributeError:
-        raise BBMainException("FATAL: Invalid user interface '%s' specified.\n"
-                 "Valid interfaces: depexp, goggle, ncurses, hob, knotty [default]." % interface)
+        raise BBMainException("FATAL: Unable to import extension module %s from %s" % (modulename, pkg.__name__))
+
 
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
@@ -146,11 +169,19 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-P", "--profile", help = "Profile the command and save reports.",
                    action = "store_true", dest = "profile", default = False)
 
-        parser.add_option("-u", "--ui", help = "The user interface to use (e.g. knotty, hob, depexp).",
-                   action = "store", dest = "ui")
+        env_ui = os.environ.get('BITBAKE_UI', None)
+        valid_uis = list_extension_modules(bb.ui, 'main')
+        default_ui = env_ui or 'knotty'
+        if env_ui and not env_ui in valid_uis:
+            raise BBMainException('Invalid UI "%s" specified in BITBAKE_UI environment variable - valid choices: %s' % (env_ui, ', '.join(valid_uis)))
+        elif not default_ui in valid_uis:
+            raise BBMainException('Default UI "%s" could not be found')
+        parser.add_option("-u", "--ui", help = "The user interface to use (%s)." % ', '.join(valid_uis),
+                   action="store", dest="ui", type="choice", choices=valid_uis, default=default_ui)
 
-        parser.add_option("-t", "--servertype", help = "Choose which server to use, process or xmlrpc.",
-                   action = "store", dest = "servertype")
+        valid_server_types = list_extension_modules(bb.server, 'BitBakeServer')
+        parser.add_option("-t", "--servertype", help = "Choose which server type to use (%s)." % ', '.join(valid_server_types),
+                   action = "store", dest = "servertype", default = "process")
 
         parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
                    action = "store", dest = "xmlrpctoken")
@@ -279,21 +310,8 @@ def bitbake_main(configParams, configuration):
 
     configuration.setConfigParameters(configParams)
 
-    ui_module = get_ui(configParams)
-
-    # Server type can be xmlrpc or process currently, if nothing is specified,
-    # the default server is process
-    if configParams.servertype:
-        server_type = configParams.servertype
-    else:
-        server_type = 'process'
-
-    try:
-        module = __import__("bb.server", fromlist = [server_type])
-        servermodule = getattr(module, server_type)
-    except AttributeError:
-        raise BBMainException("FATAL: Invalid server type '%s' specified.\n"
-                              "Valid interfaces: xmlrpc, process [default]." % server_type)
+    ui_module = import_extension_module(bb.ui, configParams.ui)
+    servermodule = import_extension_module(bb.server, configParams.servertype)
 
     if configParams.server_only:
         if configParams.servertype != "xmlrpc":
-- 
2.1.0


