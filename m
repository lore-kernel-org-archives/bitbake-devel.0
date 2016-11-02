Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0C4D26E5FB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 15:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2F6k3T017740
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Nov 2016 15:06:54 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qujBSKlcm6rH for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 15:06:54 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2F6o4s017818
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Nov 2016 15:06:51 GMT
Message-ID: <1478099210.23123.62.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 02 Nov 2016 15:06:50 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] siggen: Pass basehash to worker processes and sanity check reparsing result
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
X-List-Received-Date: Wed, 02 Nov 2016 15:06:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Bitbake can parse metadata in the cooker and in the worker during builds. If
the metadata isn't deterministic, it can change between these two parses and
this confuses things a lot. It turns out to be hard to debug these issues
currently.

This patch ensures the basehashes from the original parsing are passed into
the workers and that these are checked when reparsing for consistency. The user
is shown an error message if inconsistencies are found.

There is debug code in siggen.py (see the "Slow but can be useful for debugging
mismatched basehashes" commented code), we don't enable this by default due to
performance issues. If you run into this message, enable this code and you will
find "sigbasedata" files in tmp/stamps which should correspond to the hashes
shown in this error message. bitbake-diffsigs on the files should show which
variables are changing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index bac1796..75a80bf 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -30,6 +30,7 @@ class SignatureGenerator(object):
     name = "noop"
 
     def __init__(self, data):
+        self.basehash = {}
         self.taskhash = {}
         self.runtaskdeps = {}
         self.file_checksum_values = {}
@@ -61,11 +62,10 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-       return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints)
+        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints = data
-
+        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash = data
 
 class SignatureGeneratorBasic(SignatureGenerator):
     """
@@ -133,7 +133,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 var = lookupcache[dep]
                 if var is not None:
                     data = data + str(var)
-            self.basehash[fn + "." + task] = hashlib.md5(data.encode("utf-8")).hexdigest()
+            datahash = hashlib.md5(data.encode("utf-8")).hexdigest()
+            k = fn + "." + task
+            if k in self.basehash and self.basehash[k] != datahash:
+                bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], datahash))
+            self.basehash[k] = datahash
             taskdeps[task] = alldeps
 
         self.taskdeps[fn] = taskdeps
@@ -183,6 +187,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def get_taskhash(self, fn, task, deps, dataCache):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
+        self.basehash[k] = data
         self.runtaskdeps[k] = []
         self.file_checksum_values[k] = []
         recipename = dataCache.pkg_fn[fn]




