Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BFCE4706B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7Hiibe027664
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:44:44 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aClQoHUzSgRS for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:44:44 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7HiVQS027661
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:44:43 GMT
Message-ID: <1415382307.2820.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Nov 2014 17:45:07 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Ensure we output if the ordering of runtaskdeps changes
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
X-List-Received-Date: Fri, 07 Nov 2014 17:45:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Order of runtaskdeps is important. If the hashes differ we should print output.
This is complicated by shared work where the filenames themselves can differ, 
but the checksum should not.

This fixes a case where two different checksums could show no output with
bitbake-diffsigs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 86d9ca0..1033785 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -307,6 +307,12 @@ def clean_basepaths(a):
         b[clean_basepath(x)] = a[x]
     return b
 
+def clean_basepaths_list(a):
+    b = []
+    for x in a:
+        b.append(clean_basepath(x))
+    return b
+
 def compare_sigfiles(a, b, recursecb = None):
     output = []
 
@@ -406,6 +412,17 @@ def compare_sigfiles(a, b, recursecb = None):
         for f in removed:
             output.append("Dependency on checksum of file %s was removed" % (f))
 
+    changed = []
+    for idx, task in enumerate(a_data['runtaskdeps']):
+        a = a_data['runtaskdeps'][idx]
+        b = b_data['runtaskdeps'][idx]
+        if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
+            changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
+
+    if changed:
+        output.append("runtaskdeps changed from %s to %s" % (clean_basepaths_list(a_data['runtaskdeps']), clean_basepaths_list(b_data['runtaskdeps'])))
+        output.append("\n".join(changed))
+
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
         a = a_data['runtaskhashes']



