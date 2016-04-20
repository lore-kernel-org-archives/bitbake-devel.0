Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 340AF6FF25
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Apr 2016 09:51:26 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 20 Apr 2016 02:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,509,1455004800"; d="scan'208";a="788519958"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 20 Apr 2016 02:51:27 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 67C8F6A4002;
	Wed, 20 Apr 2016 03:39:04 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Apr 2016 10:31:29 +0300
Message-Id: <1461137489-14968-2-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461137489-14968-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
	<1461137489-14968-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 2/2] bitbake: main: set defaults from env variables
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
X-List-Received-Date: Wed, 20 Apr 2016 09:51:27 -0000

Environment variables BBSERVER, BBTOKEN and BBEVENTLOG silently
overwrite bitbake command line arguments. This is confusing and
can cause issues that are difficult to debug. It's better to use
them as default values instead.

Used environment variables BBSERVER, BBTOKEN and BBEVENTLOG to set
default values for command line arguments.

Changed setting default value of --ui command line argument from
BITBAKE_UI to look similar way.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 08ecdda..b843b7d 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -194,18 +194,16 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-P", "--profile", help = "Profile the command and save reports.",
                    action = "store_true", dest = "profile", default = False)
 
-        env_ui = os.environ.get('BITBAKE_UI', None)
-        default_ui = env_ui or 'knotty'
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
         parser.add_option("-u", "--ui", help = "The user interface to use (@CHOICES@ - default %default).",
-                   action="store", dest="ui", default=default_ui)
+                   action="store", dest="ui", default=os.environ.get('BITBAKE_UI', 'knotty'))
 
         # @CHOICES@ is substituted out by BitbakeHelpFormatter above
         parser.add_option("-t", "--servertype", help = "Choose which server type to use (@CHOICES@ - default %default).",
-                   action = "store", dest = "servertype", default = "process")
+                   action = "store", dest = "servertype", default = ["process", "xmlrpc"]["BBSERVER" in os.environ])
 
         parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
-                   action = "store", dest = "xmlrpctoken")
+                   action = "store", dest = "xmlrpctoken", default = os.environ.get("BBTOKEN"))
 
         parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not.",
                    action = "store_true", dest = "revisions_changed", default = False)
@@ -223,7 +221,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                    action = "store_true", dest = "setsceneonly", default = False)
 
         parser.add_option("", "--remote-server", help = "Connect to the specified server.",
-                   action = "store", dest = "remote_server", default = False)
+                   action = "store", dest = "remote_server", default = os.environ.get("BBSERVER"))
 
         parser.add_option("-m", "--kill-server", help = "Terminate the remote server.",
                     action = "store_true", dest = "kill_server", default = False)
@@ -235,21 +233,11 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                    action = "store_true", dest = "status_only", default = False)
 
         parser.add_option("-w", "--write-log", help = "Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.",
-                   action = "store", dest = "writeeventlog")
+                   action = "store", dest = "writeeventlog", default = os.environ.get("BBEVENTLOG"))
 
         options, targets = parser.parse_args(argv)
 
-        # some environmental variables set also configuration options
-        if "BBSERVER" in os.environ:
-            options.servertype = "xmlrpc"
-            options.remote_server = os.environ["BBSERVER"]
-
-        if "BBTOKEN" in os.environ:
-            options.xmlrpctoken = os.environ["BBTOKEN"]
-
-        if "BBEVENTLOG" in os.environ:
-            options.writeeventlog = os.environ["BBEVENTLOG"]
-
+        # use configuration files from environment variables
         if "BBPRECONF" in os.environ:
             option.prefile.append(os.environ["BBPRECONF"])
 
-- 
2.1.4


