Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtQ-0007r2-Pt
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321700"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:05 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:48 -0700
Message-Id: <9546bf5db63701d8bb372bca47b6495650766a31.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 02/10] bitbake: Make bitbake server type configurable.
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:57 -0000

From: Liping Ke <liping.ke@intel.com>

Add -t options in bitbake for configuring server type.

Signed-off-by: Liping Ke <liping.ke@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 5835ffc..d577e05 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -39,15 +39,11 @@ import bb.msg
 from bb import cooker
 from bb import ui
 from bb import server
-#from bb.server import none
-from bb.server import process
-#from bb.server import xmlrpc
 
 __version__ = "1.13.2"
 logger = logging.getLogger("BitBake")
 
 
-
 class BBConfiguration(object):
     """
     Manages build options and configurations for one run
@@ -160,6 +156,9 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-u", "--ui", help = "userinterface to use",
                action = "store", dest = "ui")
 
+    parser.add_option("-t", "--servertype", help = "Choose which server to use, none, process or xmlrpc",
+               action = "store", dest = "servertype")
+
     parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not",
                action = "store_true", dest = "revisions_changed", default = False)
 
@@ -170,6 +169,20 @@ Default BBFILES are the .bb files in the current directory.""")
 
     ui_main = get_ui(configuration)
 
+    # Server type could be xmlrpc or none currently, if nothing is specified,
+    # default server would be none
+    if configuration.servertype:
+        server_type = configuration.servertype
+    else:
+        server_type = 'process'
+
+    try:
+        module = __import__("bb.server", fromlist = [server_type])
+        server = getattr(module, server_type)
+    except AttributeError:
+        sys.exit("FATAL: Invalid server type '%s' specified.\n"
+                 "Valid interfaces: xmlrpc, process, none [default]." % servertype)
+
     # Save a logfile for cooker into the current working directory. When the
     # server is daemonized this logfile will be truncated.
     cooker_logfile = os.path.join(os.getcwd(), "cooker.log")
@@ -186,9 +199,7 @@ Default BBFILES are the .bb files in the current directory.""")
     # of the UIs (e.g. for DISPLAY, etc.)
     bb.utils.clean_environment()
 
-    #server = bb.server.none.BitBakeServer()    
-    server = bb.server.process.BitBakeServer()
-    #server = bb.server.xmlrpc.BitBakeServer()
+    server = server.BitBakeServer()
 
     server.initServer()
     idle = server.getServerIdleCB()
-- 
1.7.5.4



