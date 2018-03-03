Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 67ED078A60
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Mar 2018 17:09:06 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w23H95t9025448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sat, 3 Mar 2018 17:09:06 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1esAef-0003MK-U3; Sat, 03 Mar 2018 17:09:05 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  3 Mar 2018 17:09:04 +0000
Message-Id: <1520096944-12868-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520096944-12868-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1520096944-12868-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] cooker: Run registered anonymous python before displaying environment
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
X-List-Received-Date: Sat, 03 Mar 2018 17:09:08 -0000

The output of bitbake -e can differ from what actually is used due
to anonymous python making changes to the data store. Execute any
anonymous python added in the base configuration to make things
more consistent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index af482f9..d1df711 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -530,13 +530,15 @@ class BBCooker:
             self.data.inchistory.emit(env)
             logger.plain(env.getvalue())
 
+        data.expandKeys(envdata)
+        parse.ast.runAnonFuncs(envdata)
+
         # emit variables and shell functions
         with closing(StringIO()) as env:
             data.emit_env(env, envdata, True)
             logger.plain(env.getvalue())
 
         # emit the metadata which isnt valid shell
-        data.expandKeys(envdata)
         for e in sorted(envdata.keys()):
             if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
-- 
2.7.4


