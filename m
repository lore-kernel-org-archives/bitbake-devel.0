Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6FD3C72FFC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 21:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2LLAgiB008780; Tue, 21 Mar 2017 21:10:42 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TpC0K1Quk68D; Tue, 21 Mar 2017 21:10:41 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2LLAd8x008770
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Mar 2017 21:10:40 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cqR39-00007o-Fz; Tue, 21 Mar 2017 21:10:39 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 21:10:38 +0000
Message-Id: <1490130638-441-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] data/cooker: Sort output data shown by -e
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
X-List-Received-Date: Tue, 21 Mar 2017 21:10:43 -0000

Displaying the environment data in a sorted manner makes it easier
to compare data between different setups and means you can know
where to find specific entries.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 +-
 lib/bb/data.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 662a7ac..e3f5317 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -648,7 +648,7 @@ class BBCooker:
 
         # emit the metadata which isnt valid shell
         data.expandKeys(envdata)
-        for e in envdata.keys():
+        for e in sorted(envdata.keys()):
             if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index d145f1b..a85cb3a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -196,7 +196,7 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
     keys = sorted((key for key in d.keys() if not key.startswith("__")), key=isfunc)
     grouped = groupby(keys, isfunc)
     for isfunc, keys in grouped:
-        for key in keys:
+        for key in sorted(keys):
             emit_var(key, o, d, all and not isfunc) and o.write('\n')
 
 def exported_keys(d):
-- 
2.7.4


