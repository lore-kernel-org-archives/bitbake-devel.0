Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RT8ce-0005Io-HB
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 09:56:05 +0100
Received: from mail54-ch1-R.bigfish.com (10.43.68.249) by
	CH1EHSOBE018.bigfish.com (10.43.70.68) with Microsoft SMTP Server id
	14.1.225.22; Wed, 23 Nov 2011 08:03:30 +0000
Received: from mail54-ch1 (localhost [127.0.0.1])	by mail54-ch1-R.bigfish.com
	(Postfix) with ESMTP id 1FA423403B4;
	Wed, 23 Nov 2011 08:04:22 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bhz2dh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail54-ch1 (localhost.localdomain [127.0.0.1]) by mail54-ch1
	(MessageSwitch) id 1322035459987331_18359;
	Wed, 23 Nov 2011 08:04:19 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.246])	by mail54-ch1.bigfish.com (Postfix) with ESMTP id
	EBF54580046;	Wed, 23 Nov 2011 08:04:19 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS030.bigfish.com
	(10.43.70.30) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Wed, 23 Nov 2011 08:03:23 +0000
Received: from az33smr02.freescale.net (10.64.34.200) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server id 14.1.339.2; Wed, 23 Nov 2011 02:04:01 -0600
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	pAN840wK013282; Wed, 23 Nov 2011 02:04:00 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Nov 2011 02:04:00 -0600
Message-ID: <1322035440-8480-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] siggen.py: sort task hash depedencies with basepath
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 Nov 2011 08:56:05 -0000
Content-Type: text/plain

Without this patch the tash hash dependencies can be in a order
that is dependent upon directory/filesystem layout. With this
change the data is sorted the same regardless.

Without this the dependent hashes could be in different orders
on different systems and consequently final md5 hash would differ
as well even though nothing else changed.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 lib/bb/siggen.py |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 217f29b..9b73c4c 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -136,7 +136,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
         self.runtaskdeps[k] = []
-        for dep in sorted(deps):
+        for dep in sorted(deps, key=clean_basepath):
             # We only manipulate the dependencies for packages not in the whitelist
             if self.twl and not self.twl.search(dataCache.pkg_fn[fn]):
                 # then process the actual dependencies
@@ -218,6 +218,19 @@ def dump_this_task(outfile, d):
     task = "do_" + d.getVar("BB_CURRENTTASK", True)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile")
 
+def clean_basepath(a):
+    if a.startswith("virtual:"):
+        b = a.rsplit(":", 1)[0] + a.rsplit("/", 1)[1]
+    else:
+        b = a.rsplit("/", 1)[1]
+    return b
+
+def clean_basepaths(a):
+    b = {}
+    for x in a:
+        b[clean_basepath(x)] = a[x]
+    return b
+
 def compare_sigfiles(a, b):
     p1 = pickle.Unpickler(file(a, "rb"))
     a_data = p1.load()
@@ -236,16 +249,6 @@ def compare_sigfiles(a, b):
         removed = sb - sa
         return changed, added, removed
 
-    def clean_basepaths(a):
-        b = {}
-        for x in a:
-            if x.startswith("virtual:"):
-                y = x.rsplit(":", 1)[0] + x.rsplit("/", 1)[1]
-            else:
-                y = x.rsplit("/", 1)[1]
-            b[y] = a[x]
-        return b
-
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
 
-- 
1.7.6.1




