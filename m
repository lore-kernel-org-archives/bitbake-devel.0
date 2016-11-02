Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D90CD71A3E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 15:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2F7bmf017843
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Nov 2016 15:07:37 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3n-_vqFMDjpr for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 15:07:37 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2F7XhZ017836
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Nov 2016 15:07:34 GMT
Message-ID: <1478099253.23123.63.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 02 Nov 2016 15:07:33 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] siggen: Ensure taskhash mismatches don't override existing data
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
X-List-Received-Date: Wed, 02 Nov 2016 15:07:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

We recalculate the taskhash to ensure the version we have matches
what we think it should be. When we write out a sigdata file, use
the calculated value so that we don't overwrite any existing file.
This leaves any original taskhash sigdata file intact to allow a
debugging comparison.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 75a80bf..be09a96 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -284,6 +284,15 @@ class SignatureGeneratorBasic(SignatureGenerator):
             if 'nostamp:' in self.taints[k]:
                 data['taint'] = self.taints[k]
 
+        computed_basehash = calc_basehash(data)
+        if computed_basehash != self.basehash[k]:
+            bb.error("Basehash mismatch %s versus %s for %s" % (computed_basehash, self.basehash[k], k))
+        if runtime and k in self.taskhash:
+            computed_taskhash = calc_taskhash(data)
+            if computed_taskhash != self.taskhash[k]:
+                bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[k], k))
+                sigfile = sigfile.replace(self.taskhash[k], computed_taskhash)
+
         fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
             with os.fdopen(fd, "wb") as stream:
@@ -298,14 +307,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 pass
             raise err
 
-        computed_basehash = calc_basehash(data)
-        if computed_basehash != self.basehash[k]:
-            bb.error("Basehash mismatch %s versus %s for %s" % (computed_basehash, self.basehash[k], k))
-        if runtime and k in self.taskhash:
-            computed_taskhash = calc_taskhash(data)
-            if computed_taskhash != self.taskhash[k]:
-                bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[k], k))
-
     def dump_sigs(self, dataCaches, options):
         for fn in self.taskdeps:
             for task in self.taskdeps[fn]:



