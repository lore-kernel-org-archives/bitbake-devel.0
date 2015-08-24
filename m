Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A3EDB76A33
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 14:00:38 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Aug 2015 07:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,738,1432623600"; d="scan'208";a="754364524"
Received: from achalot-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.20.62])
	by orsmga001.jf.intel.com with ESMTP; 24 Aug 2015 07:00:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Aug 2015 15:00:22 +0100
Message-Id: <640bcd6bc518bfac03c3c3c4a45717d61ef05bfb.1440424765.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1440424765.git.paul.eggleton@linux.intel.com>
References: <cover.1440424765.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1440424765.git.paul.eggleton@linux.intel.com>
References: <cover.1440424765.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/main: avoid importing all server/UI modules on every execution
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
X-List-Received-Date: Mon, 24 Aug 2015 14:00:39 -0000

We're importing the server and UI modules in order to check they are
valid, but it turns out that that has some nasty side-effects. We don't
actually need to do this except when --help is passed or the module
doesn't exist, so rearrange the code so that we only do the module
listing in those two cases.

Additionally, let's just go ahead and catch all errors on import; we
really don't care to have them cause a failure now.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py | 60 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 910cd64..8762f72 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -41,10 +41,35 @@ logger = logging.getLogger("BitBake")
 class BBMainException(Exception):
     pass
 
+def present_options(optionlist):
+    if len(optionlist) > 1:
+        return ' or '.join([', '.join(optionlist[:-1]), optionlist[-1]])
+    else:
+        return optionlist[0]
+
+class BitbakeHelpFormatter(optparse.IndentedHelpFormatter):
+    def format_option(self, option):
+        # We need to do this here rather than in the text we supply to
+        # add_option() because we don't want to call list_extension_modules()
+        # on every execution (since it imports all of the modules)
+        # Note also that we modify option.help rather than the returned text
+        # - this is so that we don't have to re-format the text ourselves
+        if option.dest == 'ui':
+            valid_uis = list_extension_modules(bb.ui, 'main')
+            option.help = option.help.replace('@CHOICES@', present_options(valid_uis))
+        elif option.dest == 'servertype':
+            valid_server_types = list_extension_modules(bb.server, 'BitBakeServer')
+            option.help = option.help.replace('@CHOICES@', present_options(valid_server_types))
+
+        return optparse.IndentedHelpFormatter.format_option(self, option)
+
 def list_extension_modules(pkg, checkattr):
     """
     Lists extension modules in a specific Python package
-    (e.g. UIs, servers)
+    (e.g. UIs, servers). NOTE: Calling this function will import all of the
+    submodules of the specified module in order to check for the specified
+    attribute; this can have unusual side-effects. As a result, this should
+    only be called when displaying help text or error messages.
     Parameters:
         pkg: previously imported Python package to list
         checkattr: attribute to look for in module to determine if it's valid
@@ -60,7 +85,7 @@ def list_extension_modules(pkg, checkattr):
             continue
         try:
             module = __import__(pkg.__name__, fromlist=[modulename])
-        except (ImportError, SystemExit, RuntimeError):
+        except:
             # If we can't import it, it's not valid
             continue
         module_if = getattr(module, modulename)
@@ -70,7 +95,7 @@ def list_extension_modules(pkg, checkattr):
             modules.append(modulename)
     return modules
 
-def import_extension_module(pkg, modulename):
+def import_extension_module(pkg, modulename, checkattr):
     try:
         # Dynamically load the UI based on the ui name. Although we
         # suggest a fixed set this allows you to have flexibility in which
@@ -78,7 +103,7 @@ def import_extension_module(pkg, modulename):
         module = __import__(pkg.__name__, fromlist = [modulename])
         return getattr(module, modulename)
     except AttributeError:
-        raise BBMainException("FATAL: Unable to import extension module %s from %s" % (modulename, pkg.__name__))
+        raise BBMainException('FATAL: Unable to import extension module "%s" from %s. Valid extension modules: %s' % (modulename, pkg.__name__, present_options(list_extension_modules(pkg, checkattr))))
 
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
@@ -104,6 +129,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
     def parseCommandLine(self, argv=sys.argv):
         parser = optparse.OptionParser(
+            formatter = BitbakeHelpFormatter(),
             version = "BitBake Build Tool Core version %s" % bb.__version__,
             usage = """%prog [options] [recipename/target recipe:do_task ...]
 
@@ -168,24 +194,14 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-P", "--profile", help = "Profile the command and save reports.",
                    action = "store_true", dest = "profile", default = False)
 
-        def present_options(optionlist):
-            if len(optionlist) > 1:
-                return ' or '.join([', '.join(optionlist[:-1]), optionlist[-1]])
-            else:
-                return optionlist[0]
-
         env_ui = os.environ.get('BITBAKE_UI', None)
-        valid_uis = list_extension_modules(bb.ui, 'main')
         default_ui = env_ui or 'knotty'
-        if env_ui and not env_ui in valid_uis:
-            raise BBMainException('Invalid UI "%s" specified in BITBAKE_UI environment variable - valid choices: %s' % (env_ui, present_options(valid_uis)))
-        elif not default_ui in valid_uis:
-            raise BBMainException('Default UI "%s" could not be found')
-        parser.add_option("-u", "--ui", help = "The user interface to use (%s - default %%default)." % present_options(valid_uis),
-                   action="store", dest="ui", type="choice", choices=valid_uis, default=default_ui)
-
-        valid_server_types = list_extension_modules(bb.server, 'BitBakeServer')
-        parser.add_option("-t", "--servertype", help = "Choose which server type to use (%s - default %%default)." % present_options(valid_server_types),
+        # @CHOICES@ is substituted out by BitbakeHelpFormatter above
+        parser.add_option("-u", "--ui", help = "The user interface to use (@CHOICES@ - default %default).",
+                   action="store", dest="ui", default=default_ui)
+
+        # @CHOICES@ is substituted out by BitbakeHelpFormatter above
+        parser.add_option("-t", "--servertype", help = "Choose which server type to use (@CHOICES@ - default %default).",
                    action = "store", dest = "servertype", default = "process")
 
         parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
@@ -315,8 +331,8 @@ def bitbake_main(configParams, configuration):
 
     configuration.setConfigParameters(configParams)
 
-    ui_module = import_extension_module(bb.ui, configParams.ui)
-    servermodule = import_extension_module(bb.server, configParams.servertype)
+    ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
+    servermodule = import_extension_module(bb.server, configParams.servertype, 'BitBakeServer')
 
     if configParams.server_only:
         if configParams.servertype != "xmlrpc":
-- 
2.1.0


