Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1URh42-0004B4-8F
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 12:55:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Apr 2013 03:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,474,1363158000"; d="scan'208";a="286240180"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.147])
	by azsmga001.ch.intel.com with ESMTP; 15 Apr 2013 03:37:37 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2013 13:38:13 +0300
Message-Id: <1366022295-4744-2-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 1/3] bitbake : handle each ui error
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 15 Apr 2013 10:55:18 -0000

Added the functionality to bitbake to handle each
ui error in particular. The function handle_sys_exit()
needs to be implemented in the ui that needs different
error reporting than default.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/bin/bitbake |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 40b50e1..4dce7be 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -75,7 +75,7 @@ def get_ui(config):
         # suggest a fixed set this allows you to have flexibility in which
         # ones are available.
         module = __import__("bb.ui", fromlist = [interface])
-        return getattr(module, interface).main
+        return getattr(module, interface)
     except AttributeError:
         sys.exit("FATAL: Invalid user interface '%s' specified.\n"
                  "Valid interfaces: depexp, goggle, ncurses, hob, knotty [default]." % interface)
@@ -100,7 +100,7 @@ warnings.filterwarnings("ignore", category=ImportWarning)
 warnings.filterwarnings("ignore", category=DeprecationWarning, module="<string>$")
 warnings.filterwarnings("ignore", message="With-statements now directly support multiple context managers")
 
-
+ui_main = None
 def main():
     parser = optparse.OptionParser(
         version = "BitBake Build Tool Core version %s, %%prog version %s" % (bb.__version__, __version__),
@@ -189,6 +189,7 @@ Default BBFILES are the .bb files in the current directory.""")
     configuration = BBConfiguration(options)
     configuration.pkgs_to_build.extend(args[1:])
 
+    global ui_main
     ui_main = get_ui(configuration)
 
     # Server type can be xmlrpc, process or none currently, if nothing is specified,
@@ -261,7 +262,7 @@ Default BBFILES are the .bb files in the current directory.""")
             os.environ[k] = cleanedvars[k]
 
         try:
-            return server.launchUI(ui_main, server_connection.connection, server_connection.events)
+            return server.launchUI(ui_main.main, server_connection.connection, server_connection.events)
         finally:
             bb.event.ui_queue = []
             server_connection.terminate()
@@ -277,5 +278,11 @@ if __name__ == "__main__":
         ret = 1
         import traceback
         traceback.print_exc(5)
+    except SystemExit:
+            try:
+                hasattr(ui_main, 'handle_sys_exit')
+                ui_main.handle_sys_exit()
+            except AttributeError:
+                ret = 1
     sys.exit(ret)
 
-- 
1.7.9.5



