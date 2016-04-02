Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AD0116FFED
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Apr 2016 16:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u32GBVpl025392 for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Apr 2016 17:11:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F-xg3M5AWaAm for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Apr 2016 17:11:31 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u32GBQ6H025387
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Apr 2016 17:11:27 +0100
Message-ID: <1459613486.7348.125.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 02 Apr 2016 17:11:26 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Add checksum recalculation/checking code
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
X-List-Received-Date: Sat, 02 Apr 2016 16:11:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In theory all the information to recalcuate the task signatures was written
into the siginfo/sigdata files. In reality, some of the information was
written into the filename.

Firstly this patch duplicates that info into the file itself just for easy
of use since its small.

Secondly, we abstract out the existing "calculate the checksum" code for
the taskhash, and add a function to calculate the bashhash based on the
informaiton within the file.

Finally, we call these functions when we're writing out the data to check
that the data we're writing is consistent. I've found a couple of places
it wasn't and its good to know about these in advance, rather than having
a siginfo/sigdata file which a given hash in its filename but a contents
which give a different result.

This should all combine to avoid a certain class of checksum bugs making
it into world, and identifying problems in advance.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index d8ba1d4..2f0fb71 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -248,6 +248,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         bb.utils.mkdirhier(os.path.dirname(sigfile))
 
         data = {}
+        data['task'] = task
         data['basewhitelist'] = self.basewhitelist
         data['taskwhitelist'] = self.taskwhitelist
         data['taskdeps'] = self.taskdeps[fn][task]
@@ -267,6 +268,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]
+            data['taskhash'] = self.taskhash[k]
 
         taint = self.read_taint(fn, task, stampbase)
         if taint:
@@ -290,6 +292,15 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 pass
             raise err
 
+        computed_basehash = calc_basehash(data)
+        if computed_basehash != self.basehash[k]:
+            bb.error("Basehash mismatch %s verses %s for %s" % (computed_basehash, self.basehash[k], k))
+        if k in self.taskhash:
+            computed_taskhash = calc_taskhash(data)
+            if computed_taskhash != self.taskhash[k]:
+                bb.error("Taskhash mismatch %s verses %s for %s" % (computed_taskhash, self.taskhash[k], k))
+
+
     def dump_sigs(self, dataCache, options):
         for fn in self.taskdeps:
             for task in self.taskdeps[fn]:
@@ -506,6 +517,37 @@ def compare_sigfiles(a, b, recursecb = None):
     return output
 
 
+def calc_basehash(sigdata):
+    task = sigdata['task']
+    basedata = sigdata['varvals'][task]
+
+    if basedata is None:
+        basedata = ''
+
+    alldeps = sigdata['taskdeps']
+    for dep in alldeps:
+        basedata = basedata + dep
+        val = sigdata['varvals'][dep]
+        if val is not None:
+            basedata = basedata + str(val)
+
+    return hashlib.md5(basedata).hexdigest()
+
+def calc_taskhash(sigdata):
+    data = sigdata['basehash']
+
+    for dep in sigdata['runtaskdeps']:
+        data = data + sigdata['runtaskhashes'][dep]
+
+    for c in sigdata['file_checksum_values']:
+        data = data + c[1]
+
+    if 'taint' in sigdata:
+        data = data + sigdata['taint']
+
+    return hashlib.md5(data).hexdigest()
+
+
 def dump_sigfile(a):
     output = []
 
@@ -539,17 +581,13 @@ def dump_sigfile(a):
     if 'taint' in a_data:
         output.append("Tainted (by forced/invalidated task): %s" % a_data['taint'])
 
-    data = a_data['basehash']
-    for dep in a_data['runtaskdeps']:
-        data = data + a_data['runtaskhashes'][dep]
-
-    for c in a_data['file_checksum_values']:
-        data = data + c[1]
-
-    if 'taint' in a_data:
-        data = data + a_data['taint']
+    if 'task' in a_data:
+        computed_basehash = calc_basehash(a_data)
+        output.append("Computed base hash is %s and from file %s" % (computed_basehash, a_data['basehash']))
+    else:
+        output.append("Unable to compute base hash")
 
-    h = hashlib.md5(data).hexdigest()
-    output.append("Computed Hash is %s" % h)
+    computed_taskhash = calc_taskhash(a_data)
+    output.append("Computed task hash is %s" % computed_taskhash)
 
     return output



