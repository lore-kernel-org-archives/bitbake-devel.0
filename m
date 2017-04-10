Return-Path: <juro.bystricky@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9399360069
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491839467; x=1523375467;
	h=from:to:cc:subject:date:message-id;
	bh=GEtXQ+hF07RKf6mP4TqLQcqLTnmDT8XD37QSme/Zc2M=;
	b=bhUBTqRl6LncdBq946fFYVkxt6u8CNSaAz48fTIu5lV70ySQ9d/tumLH
	QUwgKIkRoH7m1tVwzJt2FTC69ciI3A==;
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2017 08:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,182,1488873600"; d="scan'208";a="85639466"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga005.jf.intel.com with ESMTP; 10 Apr 2017 08:51:06 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Apr 2017 08:51:04 -0700
Message-Id: <1491839464-38205-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v3] command.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Mon, 10 Apr 2017 15:51:05 -0000

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
 bitbake/lib/bb/command.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 78a86ac..390d4f1 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -141,6 +141,12 @@ class Command:
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
+def split_mc_pn(pn):
+    if pn.startswith("multiconfig:"):
+        _, mc, pn = pn.split(":", 2)
+        return (mc, pn)
+    return ('', pn)
+
 class CommandsSync:
     """
     A class of synchronous commands
@@ -425,8 +431,8 @@ class CommandsSync:
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


