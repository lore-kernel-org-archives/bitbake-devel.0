Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 602FE6FFED
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Apr 2016 16:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u32GAqrv025357 for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Apr 2016 17:10:52 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8rnKv27e53Ka for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Apr 2016 17:10:52 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u32GAmOd025351
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Apr 2016 17:10:49 +0100
Message-ID: <1459613448.7348.124.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 02 Apr 2016 17:10:48 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Fix check calculation problem with file_checksums
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
X-List-Received-Date: Sat, 02 Apr 2016 16:10:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When I enabled debugging of the checksum code, I found the value calculated
from siginfo/sigdata files for do_fetch tasks never matched. This was due
to an error in the way the data was being stored for these, it wasn't ordered
correctly. This patch fixes things so the checksums calculated from
siginfo/sigdata files is correct when file checksums are present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index be0f0b5..d8ba1d4 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -186,8 +186,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
         self.runtaskdeps[k] = []
-        self.file_checksum_values[k] = {}
+        self.file_checksum_values[k] = []
         recipename = dataCache.pkg_fn[fn]
+
         for dep in sorted(deps, key=clean_basepath):
             depname = dataCache.pkg_fn[self.pkgnameextract.search(dep).group('fn')]
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
@@ -206,7 +203,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             else:
                 checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
-                self.file_checksum_values[k][f] = cs
+                self.file_checksum_values[k].append((f,cs))
                 if cs:
                     data = data + cs
 
@@ -262,7 +263,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if runtime and k in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[k]
-            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k].items()]
+            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]


