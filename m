Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 205596C7FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884N029330; Mon, 16 Sep 2013 23:08:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nKjOkxLGYl76; Mon, 16 Sep 2013 23:08:09 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85Ah029303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002Zj-Tx; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:26 +0100
Message-Id: <1379368413-9808-9-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 09/16] data_smart: Allow expansion of flags in getVarFlags
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:02 -0000

Allow a list of flags to expand to be passed into getVarFlags. This
is useful within bitbake itself to optimise performance of the
dependency generation code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 970e404..bc4ad54 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -647,7 +647,7 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
             self.dict[var][i] = flags[i]
 
-    def getVarFlags(self, var, internalflags=False):
+    def getVarFlags(self, var, expand = False, internalflags=False):
         local_var = self._findVar(var)
         flags = {}
 
@@ -656,7 +656,8 @@ class DataSmart(MutableMapping):
                 if i.startswith("_") and not internalflags:
                     continue
                 flags[i] = local_var[i]
-
+                if expand and i in expand:
+                    flags[i] = self.expand(flags[i], None)
         if len(flags) == 0:
             return None
         return flags
-- 
1.8.1.2


