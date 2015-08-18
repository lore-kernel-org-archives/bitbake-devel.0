Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 585DD75F44
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 10:29:55 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 18 Aug 2015 03:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,701,1432623600"; d="scan'208";a="750741640"
Received: from jburrows-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.8.34])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2015 03:29:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 11:29:46 +0100
Message-Id: <1439893786-28572-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <CAJTo0LagN2RZRA0G1LW=nQMTRBidy0T87q5HMY_2BYZkd3nPVw@mail.gmail.com>
References: <CAJTo0LagN2RZRA0G1LW=nQMTRBidy0T87q5HMY_2BYZkd3nPVw@mail.gmail.com>
Subject: [PATCH v2] lib/bb/main: consolidate UI/server extension listing and loading
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
X-List-Received-Date: Tue, 18 Aug 2015 10:29:56 -0000

Provide us with a means of showing the list of UIs / server choices for
the command line help, and do the processing in one place for both.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---

Changes since v1:
 - Handle SystemExit when trying to import the ui module i.e.
   don't blow up when we try to import the hob module and PyGTK+
   isn't installed
 - Format the options a little bit more nicely in the help text

(also pushed to the paule/tinfoil2-pre branch)


 lib/bb/main.py | 85 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 4d77408..c98cf44 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -41,22 +41,44 @@ logger = logging.getLogger("BitBake")
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
+        except (ImportError, SystemExit):
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
 
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
@@ -146,11 +168,25 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-P", "--profile", help = "Profile the command and save reports.",
                    action = "store_true", dest = "profile", default = False)
 
-        parser.add_option("-u", "--ui", help = "The user interface to use (e.g. knotty, hob, depexp).",
-                   action = "store", dest = "ui")
-
-        parser.add_option("-t", "--servertype", help = "Choose which server to use, process or xmlrpc.",
-                   action = "store", dest = "servertype")
+        def present_options(optionlist):
+            if len(optionlist) > 1:
+                return ' or '.join([', '.join(optionlist[:-1]), optionlist[-1]])
+            else:
+                return optionlist[0]
+
+        env_ui = os.environ.get('BITBAKE_UI', None)
+        valid_uis = list_extension_modules(bb.ui, 'main')
+        default_ui = env_ui or 'knotty'
+        if env_ui and not env_ui in valid_uis:
+            raise BBMainException('Invalid UI "%s" specified in BITBAKE_UI environment variable - valid choices: %s' % (env_ui, present_options(valid_uis)))
+        elif not default_ui in valid_uis:
+            raise BBMainException('Default UI "%s" could not be found')
+        parser.add_option("-u", "--ui", help = "The user interface to use (%s - default %%default)." % present_options(valid_uis),
+                   action="store", dest="ui", type="choice", choices=valid_uis, default=default_ui)
+
+        valid_server_types = list_extension_modules(bb.server, 'BitBakeServer')
+        parser.add_option("-t", "--servertype", help = "Choose which server type to use (%s - default %%default)." % present_options(valid_server_types),
+                   action = "store", dest = "servertype", default = "process")
 
         parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
                    action = "store", dest = "xmlrpctoken")
@@ -279,21 +315,8 @@ def bitbake_main(configParams, configuration):
 
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


