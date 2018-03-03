Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 99E8178A94
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Mar 2018 23:31:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w23NV3nA008263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sat, 3 Mar 2018 23:31:04 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1esGcI-0004ZF-WE; Sat, 03 Mar 2018 23:31:02 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  3 Mar 2018 23:31:01 +0000
Message-Id: <1520119861-17519-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: [PATCH] cooker: Fix environment double key expansion issue
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
X-List-Received-Date: Sat, 03 Mar 2018 23:31:05 -0000

The base configuration needs key expansion and anon python execution,
the parsed configurations do not. Fix this consistently, its been
broken and causing double key expansion for a while, only relised
when we started double anonymous python exeution too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d1df711..1fda40d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -516,6 +516,8 @@ class BBCooker:
             fn = runlist[0][3]
         else:
             envdata = self.data
+            data.expandKeys(envdata)
+            parse.ast.runAnonFuncs(envdata)
 
         if fn:
             try:
@@ -530,9 +532,6 @@ class BBCooker:
             self.data.inchistory.emit(env)
             logger.plain(env.getvalue())
 
-        data.expandKeys(envdata)
-        parse.ast.runAnonFuncs(envdata)
-
         # emit variables and shell functions
         with closing(StringIO()) as env:
             data.emit_env(env, envdata, True)
-- 
2.7.4


