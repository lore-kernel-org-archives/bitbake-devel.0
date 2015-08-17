Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7C48E606E8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:40 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564791"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:21 +0100
Message-Id: <55d2d81677ad941cbed9fabc3790bf351968923d.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/13] Fix -m handling if cannot connect to server
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

If we can't connect to the server we should error out, because it might
not be that the server is actually dead - it might just be unable to
execute commands.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/main.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index f08a8ef..4d77408 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -358,8 +358,6 @@ def bitbake_main(configParams, configuration):
         try:
             server_connection = server.establishConnection(featureset)
         except Exception as e:
-            if configParams.kill_server:
-                return 0
             bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
 
         # Restore the environment in case the UI needs it
-- 
2.1.0


