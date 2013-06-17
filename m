Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9924260812
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jun 2013 11:11:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Jun 2013 04:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,880,1363158000"; d="scan'208";a="354833336"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by orsmga002.jf.intel.com with ESMTP; 17 Jun 2013 04:11:56 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 9B014560386; Mon, 17 Jun 2013 12:11:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 17 Jun 2013 12:11:53 +0100
Message-Id: <1371467513-3746-4-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371467513-3746-1-git-send-email-alexandru.damian@intel.com>
References: <1371467513-3746-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/3] bitbake: read BBSERVER environement for remote server
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
X-List-Received-Date: Mon, 17 Jun 2013 11:11:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This change allows bitbake to connect to a remote server
by reading the BBSERVER environment variable and effecting
the config. Basically a shortcut to the command line parameters.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index 0d6b3ae..60c4b96 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -204,6 +204,12 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                    action = "store_true", dest = "observe_only", default = False)
 
         options, targets = parser.parse_args(sys.argv)
+
+        # some environmental variables set also configuration options
+        if "BBSERVER" in os.environ:
+            options.servertype = "xmlrpc"
+            options.remote_server = os.environ["BBSERVER"]
+
         return options, targets[1:]
 
 
@@ -268,6 +274,9 @@ def main():
             sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
         if not configParams.bind:
             sys.exit("FATAL: The '--server-only' option requires a name/address to bind to with the -B option.\n")
+        if configParams.remote_server:
+            sys.exit("FATAL: The '--server-only' option conflicts with the '--remote-server' option. %s\n" % 
+                ("Please check your BBSERVER environment" if "BBSERVER" in os.environ else "" ))
 
     if configParams.bind and configParams.servertype != "xmlrpc":
         sys.exit("FATAL: If '-B' or '--bind' is defined, we must set the servertype as 'xmlrpc'.\n")
-- 
1.8.1.2


