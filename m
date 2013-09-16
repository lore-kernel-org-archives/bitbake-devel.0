Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 327F960FED
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:53:59 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM87Nw029322; Mon, 16 Sep 2013 23:08:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tB8AP3PUPFWp; Mon, 16 Sep 2013 23:08:08 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM84kh029297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002ZF-5t; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:20 +0100
Message-Id: <1379368413-9808-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 03/16] siggen: Use lookup cache exclusively
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:00 -0000

All the values we need are already guaranteed to be in the lookupcache
so rather than fetch variables again, just use the cache. This gives a
small performance improvement and simplifies the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index fb8b678..c15ba28 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -91,8 +91,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         basehash = {}
 
         for task in tasklist:
-            data = d.getVar(task, False)
-            lookupcache[task] = data
+            data = lookupcache[task]
 
             if data is None:
                 bb.error("Task %s from %s seems to be empty?!" % (task, fn))
@@ -115,16 +114,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
             alldeps = sorted(seen)
             for dep in alldeps:
                 data = data + dep
-                if dep in lookupcache:
-                    var = lookupcache[dep]
-                elif dep[-1] == ']':
-                    vf = dep[:-1].split('[')
-                    var = d.getVarFlag(vf[0], vf[1], False)
-                    lookupcache[dep] = var
-                else:
-                    var = d.getVar(dep, False)
-                    lookupcache[dep] = var
-                if var:
+                var = lookupcache[dep]
+                if var is not None:
                     data = data + str(var)
             self.basehash[fn + "." + task] = hashlib.md5(data).hexdigest()
             taskdeps[task] = alldeps
-- 
1.8.1.2


