Return-Path: <mac@mcrowe.com>
X-Greylist: delayed 451 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 05 Nov 2018 14:36:44 UTC
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
	by mail.openembedded.org (Postfix) with ESMTP id 5FED474616
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Nov 2018 14:36:43 +0000 (UTC)
Received: from deneb ([80.229.24.9]) by smtp with ESMTP
	id JfsPgkLO1x6b6JfsQgugyR; Mon, 05 Nov 2018 14:29:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=T4GiscCQ c=1 sm=1 tr=0
	a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
	a=JHtHm7312UAA:10 a=-An2I_7KAAAA:8 a=RdiZSxg3kNzwlYJAG-gA:9
	a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.89)
	(envelope-from <mac@mcrowe.com>)
	id 1gJfsO-0002mW-2r; Mon, 05 Nov 2018 14:29:12 +0000
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Nov 2018 14:29:05 +0000
Message-Id: <20181105142905.22709-1-mac@mcrowe.com>
X-Mailer: git-send-email 2.11.0
X-CMAE-Envelope: MS4wfJSnVcmiWITQHq7Ik1qRjWL/xpbsmbpyO1u9UGBRItTXPcr6O9J8hN/SAsWB6fCk2LUue4eLzWoYXVl0xx0eyU4JhG4LYg4RC3W9lRcwVya+VwQ7VJIv
	3yzLsVFLgNvMCLv3LMtjxPfArWdXKrTmee94WjQHJfJmgVhOEQxk51qA
Subject: [PATCH] siggen: Correct format argument substitution
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
X-List-Received-Date: Mon, 05 Nov 2018 14:36:44 -0000

Use % operator to ensure that the dependency is substituted into the error
message correctly.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 03c824ec..c619b596 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -185,7 +185,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
                 continue
             if dep not in self.taskhash:
-                bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)
+                bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
             data = data + self.taskhash[dep]
             self.runtaskdeps[k].append(dep)
 
-- 
2.11.0


