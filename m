Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7B9EE75CF1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 21:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GLo9ZB020851 for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:51:12 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id E-Tw-PXh_DXF for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:51:12 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GLp88o020869
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:51:09 +0100
Message-ID: <1463435468.9746.162.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 16 May 2016 22:51:08 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Fixes to handle sigdata/siginfo files only containing basehash data
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
X-List-Received-Date: Mon, 16 May 2016 21:51:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The signature data file comparison functions are meant to be able to
handle data files containing just the base hash data. This had regressed
in some places so add fixes to allow these comparisons to be made. The
runtime components in the data files are optional.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 7f29c62..d48dcdf 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -295,7 +295,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         computed_basehash = calc_basehash(data)
         if computed_basehash != self.basehash[k]:
             bb.error("Basehash mismatch %s verses %s for %s" % (computed_basehash, self.basehash[k], k))
-        if k in self.taskhash:
+        if runtime and k in self.taskhash:
             computed_taskhash = calc_taskhash(data)
             if computed_taskhash != self.taskhash[k]:
                 bb.error("Taskhash mismatch %s verses %s for %s" % (computed_taskhash, self.taskhash[k], k))
@@ -449,6 +449,11 @@ def compare_sigfiles(a, b, recursecb = None):
         for dep in changed:
             output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
 
+    if not 'file_checksum_values' in a_data:
+         a_data['file_checksum_values'] = {}
+    if not 'file_checksum_values' in b_data:
+         b_data['file_checksum_values'] = {}
+
     changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
         for f, old, new in changed:
@@ -460,6 +465,10 @@ def compare_sigfiles(a, b, recursecb = None):
         for f in removed:
             output.append("Dependency on checksum of file %s was removed" % (f))
 
+    if not 'runtaskdeps' in a_data:
+         a_data['runtaskdeps'] = {}
+    if not 'runtaskdeps' in b_data:
+         b_data['runtaskdeps'] = {}
 
     if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
         changed = ["Number of task dependencies changed"]



