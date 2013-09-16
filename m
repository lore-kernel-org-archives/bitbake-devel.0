Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 006CB605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM87O2029322; Mon, 16 Sep 2013 23:08:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wysDExmt3wre; Mon, 16 Sep 2013 23:08:12 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85i7029307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:07 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjs-0002a3-B9; Mon, 16 Sep 2013 22:53:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:30 +0100
Message-Id: <1379368413-9808-13-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 13/16] data: Optimise flag lookup in build_dependencies
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:04 -0000

When looking up flag variable dependencies, large chunks of the function
aren't needed. Optimise the function flow accordingly for speed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 876f6ca..49bb5e9 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -291,10 +291,13 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
         if key[-1] == ']':
             vf = key[:-1].split('[')
             value = d.getVarFlag(vf[0], vf[1], False)
-        else:
-            value = d.getVar(key, False)
+            parser = d.expandWithRefs(value, key)
+            deps |= parser.references
+            deps = deps | (keys & parser.execs)
+            return deps, value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude"]) or {}
         vardeps = varflags.get("vardeps")
+        value = d.getVar(key, False)
 
         if "vardepvalue" in varflags:
            value = varflags.get("vardepvalue")
-- 
1.8.1.2


