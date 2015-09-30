Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6B30577010
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 13:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDuAnP008086 for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:56:10 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wS15z4bcxABI for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:56:10 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8UDtu08008077
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Sep 2015 14:56:07 +0100
Message-ID: <1443621356.5162.97.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Sep 2015 14:55:56 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] siggen: Make it clear why nostamp tasks signatures don't match
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
X-List-Received-Date: Wed, 30 Sep 2015 13:56:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you run bitbake-diffsigs against two differing sigdata files from
nostamp tasks it shows no difference despite the differing checksum.

Change the code so this shows up as a nostamp 'taint' and at least
makes the issue clearer to the end user.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 2985272..0352e45 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -80,6 +80,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taskdeps = {}
         self.runtaskdeps = {}
         self.file_checksum_values = {}
+        self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
         self.pkgnameextract = re.compile("(?P<fn>.*)\..*")
@@ -199,11 +200,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
             import uuid
-            data = data + str(uuid.uuid4())
+            taint = str(uuid.uuid4())
+            data = data + taint
+            self.taints[k] = "nostamp:" + taint
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
             data = data + taint
+            self.taints[k] = taint
             logger.warn("%s is tainted from a forced run" % k)
 
         h = hashlib.md5(data).hexdigest()
@@ -247,6 +251,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if taint:
             data['taint'] = taint
 
+        if runtime and k in self.taints:
+            if 'nostamp:' in self.taints[k]:
+                data['taint'] = self.taints[k]
+
         fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
             with os.fdopen(fd, "wb") as stream:



