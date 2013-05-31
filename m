Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 7B11862222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:06:51 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 31 May 2013 04:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="310504528"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by azsmga001.ch.intel.com with ESMTP; 31 May 2013 04:06:50 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 2589D5607A9; Fri, 31 May 2013 12:06:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Fri, 31 May 2013 12:06:48 +0100
Message-Id: <1369998409-16560-3-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/4] bitbake: fixes in executable
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
X-List-Received-Date: Fri, 31 May 2013 11:06:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Two fixes in bitbake related to running remote servers -
* can now specify correctly the bind port
* the information in print conforms to common server infrastructure

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f3bbeb4..d263cbd 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -204,7 +204,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 def start_server(servermodule, configParams, configuration):
     server = servermodule.BitBakeServer()
     if configParams.bind:
-        server.initServer((configParams.bind, 0))
+        (host, port) = configParams.bind.split(':')
+        server.initServer((host, int(port)))
     else:
         server.initServer()
 
@@ -313,7 +314,7 @@ def main():
             bb.event.ui_queue = []
             server_connection.terminate()
     else:
-        print("server address: %s, server port: %s" % (server.serverinfo.host, server.serverinfo.port))
+        print("server address: %s, server port: %s" % (server.serverImpl.host, server.serverImpl.port))
 
     return 1
 
-- 
1.8.1.2


