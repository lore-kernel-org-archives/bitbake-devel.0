Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id AECC362195
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2013 15:23:58 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 13 Jun 2013 08:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,859,1363158000"; d="scan'208";a="254566652"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Jun 2013 08:23:37 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 6C7435605D5; Thu, 13 Jun 2013 16:23:37 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Thu, 13 Jun 2013 16:23:35 +0100
Message-Id: <1371137015-4416-2-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371137015-4416-1-git-send-email-alexandru.damian@intel.com>
References: <1371137015-4416-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] bitbake: read BBSERVER environement for remote server
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
X-List-Received-Date: Thu, 13 Jun 2013 15:23:58 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This change allows bitbake to connect to a remote server
by reading the BBSERVER environment variable and effecting
the config. Basically a shortcut to the command line parameters.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index e924eec..1c2214d 100755
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


