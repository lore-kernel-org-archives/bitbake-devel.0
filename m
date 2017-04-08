Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B27A977D46
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Apr 2017 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491672833; x=1523208833;
	h=from:to:cc:subject:date:message-id;
	bh=oaF2rs4BiFX0WEZ8LP9ctvoUtTtzkrb1kVz5XjggytM=;
	b=QYEKJ7rAgmT07VvzQ6gcyZwjAGapIKcLQ4S7lFgw0AOVbayZaUTxKAuu
	t3sRH1hRrv8ueSRBQS018h9URxtXSw==;
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2017 10:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,173,1488873600"; d="scan'208";a="953773369"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga003.jf.intel.com with ESMTP; 08 Apr 2017 10:33:52 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  8 Apr 2017 10:33:41 -0700
Message-Id: <1491672821-14233-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v2] command.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Sat, 08 Apr 2017 17:33:52 -0000

In a multiconfig environment, a tinfoil call such as

    tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")

can fail with an error such as:

  File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in get_recipe_file
    raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
bb.providers.NoProvider: Unable to find any recipe file matching "multiconfig:arduino-101-sss:gcc"

The culprit is findBestProvider, which does not handle multiconfig.
This patch fixes the error and in the case mentioned above the tinfoil call returns:

  "multiconfig:arduino-101-sss:/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"

[YOCTO#11210]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/command.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 78a86ac..340842b 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -141,6 +141,13 @@ class Command:
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
+def split_mc_pn(pn):
+    if pn.startswith("multiconfig:"):
+        mc = pn.split(":")[1]
+        pn = ":".join(pn.split(":")[2:])
+        return (mc, pn)
+    return ('', pn)
+
 class CommandsSync:
     """
     A class of synchronous commands
@@ -425,8 +432,8 @@ class CommandsSync:
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-        pn = params[0]
-        return command.cooker.findBestProvider(pn)
+        (mc, pn) = split_mc_pn(params[0])
+        return command.cooker.findBestProvider(pn, mc)
     findBestProvider.readonly = True
 
     def allProviders(self, command, params):
-- 
2.7.4


