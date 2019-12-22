Return-Path: <masahiroy@kernel.org>
X-Greylist: delayed 367 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 22 Dec 2019 06:45:59 UTC
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
	by mail.openembedded.org (Postfix) with ESMTP id 662947FC99
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 06:45:59 +0000 (UTC)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-03.nifty.com
	with ESMTP id xBM6be6L001027
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 15:37:40 +0900
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net
	[126.93.102.113]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id xBM6bKDA011121;
	Sun, 22 Dec 2019 15:37:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBM6bKDA011121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1576996640;
	bh=ue0cCcYHl/Nfe7UBp7qX8T6/qdQP9t8i18ovLDOpCWI=;
	h=From:To:Cc:Subject:Date:From;
	b=olnZGR0z/zQgJgfD2naol7VTM0cMW4jeLRgjn9MgAld4cy2VxleYrEMzgkfb8B4yM
	SOMZbBX3yNj3BvQ3ZCBko50cZtC8W+Jr+D9uzpH3/qGKVPKiFp57VWVs5QPwjPl5CJ
	drVmFqPc91xSFqoY/50txnRpWTjAo79+iftWJzat0efrwvB3iu74zkkfTWWvlqPhXs
	KSW1sTw9qSrPqTe04gbRcvpuZtnrwQ+XmRoqmQzp3uqcgeXp5qURSgLuWC9b0RV3mn
	fnGVfioUNhZdLIkpediMvPTRJuzAc+pAQ0ZZp6PwMNzQ+zv3psWeGqtFw0ai71lGfo
	qYRagGbdG/s1Q==
X-Nifty-SrcIP: [126.93.102.113]
From: Masahiro Yamada <masahiroy@kernel.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 15:37:18 +0900
Message-Id: <20191222063718.9330-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sat, 28 Dec 2019 12:13:12 +0000
Subject: [PATCH] base.bbclass: fix 'python should use 4 spaces indentation' warnings
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
X-List-Received-Date: Sun, 22 Dec 2019 06:45:59 -0000

Even if there are not so many users of base.bbclass bundled in bitbake,
it is helpful as sample code at least.

If this base.bbclass is used, bitbake emits the following warnings:

WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 41
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 42
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 43
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 44
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 45
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 46
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 47
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 53
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 54
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 55
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 56
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 63
WARNING: python should use 4 spaces indentation, but found tabs in base.bbclass, line 64

Let's fix the indentation as suggested. While I was touching these lines,
I also fixed "isnt" into "isn't" in the comment line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 classes/base.bbclass | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/classes/base.bbclass b/classes/base.bbclass
index 08441fe1..18093961 100644
--- a/classes/base.bbclass
+++ b/classes/base.bbclass
@@ -38,30 +38,30 @@ bbfatal() {
 addtask showdata
 do_showdata[nostamp] = "1"
 python do_showdata() {
-	import sys
-	# emit variables and shell functions
-	bb.data.emit_env(sys.__stdout__, d, True)
-	# emit the metadata which isnt valid shell
-	for e in bb.data.keys(d):
-		if d.getVarFlag(e, 'python', False):
-			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e)))
+    import sys
+    # emit variables and shell functions
+    bb.data.emit_env(sys.__stdout__, d, True)
+    # emit the metadata which isn't valid shell
+    for e in bb.data.keys(d):
+        if d.getVarFlag(e, 'python', False):
+            bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e)))
 }
 
 addtask listtasks
 do_listtasks[nostamp] = "1"
 python do_listtasks() {
-	import sys
-	for e in bb.data.keys(d):
-		if d.getVarFlag(e, 'task', False):
-			bb.plain("%s" % e)
+    import sys
+    for e in bb.data.keys(d):
+        if d.getVarFlag(e, 'task', False):
+            bb.plain("%s" % e)
 }
 
 addtask build
 do_build[dirs] = "${TOPDIR}"
 do_build[nostamp] = "1"
 python base_do_build () {
-	bb.note("The included, default BB base.bbclass does not define a useful default task.")
-	bb.note("Try running the 'listtasks' task against a .bb to see what tasks are defined.")
+    bb.note("The included, default BB base.bbclass does not define a useful default task.")
+    bb.note("Try running the 'listtasks' task against a .bb to see what tasks are defined.")
 }
 
 EXPORT_FUNCTIONS do_clean do_mrproper do_build
-- 
2.17.1


