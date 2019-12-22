Return-Path: <masahiroy@kernel.org>
X-Greylist: delayed 1906 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 22 Dec 2019 07:09:24 UTC
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by mail.openembedded.org (Postfix) with ESMTP id 3E17B7C603
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 07:09:24 +0000 (UTC)
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net
	[126.93.102.113]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id xBM79J2V002855;
	Sun, 22 Dec 2019 16:09:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xBM79J2V002855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1576998559;
	bh=ue0cCcYHl/Nfe7UBp7qX8T6/qdQP9t8i18ovLDOpCWI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZL6mOojRnNbSGqaSMkqIJ7ZhlyH1qDDFvcd4ZqJDTAy4dVTWS5y46L00botjHb7Nd
	ALOtRkVP923lJ9fZvVSSx3qBP4bwSqCeOFLOeO7k6EF/IDGA4kDTGb9jCgqeK+Fz8t
	2FTvVGHYy2V1KoCbHNUT5S+0PkmYyjyx0UA+wmzCir/GPtcva365TOpkqyD+fsl0Q+
	yv3EaXvb82jkxnOKUCLmBMrOjf7YuaK4tVh40LA2cx/RSHKgg8hHvXHTaoxDPwUsyJ
	sYRHeEmQ5wZlS14mdx86fwypxV9DGmwc4mZ83rqYexvDjTFE+5TJFm8+L+P0chmIgh
	+cRWyiUz73vpw==
X-Nifty-SrcIP: [126.93.102.113]
From: Masahiro Yamada <masahiroy@kernel.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 16:09:14 +0900
Message-Id: <20191222070914.11423-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
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
X-List-Received-Date: Sun, 22 Dec 2019 07:09:24 -0000

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


