Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RVoiF-0007Jg-JI
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 Nov 2011 19:16:55 +0100
Received: from mail152-ch1-R.bigfish.com (10.43.68.246) by
	CH1EHSOBE012.bigfish.com (10.43.70.62) with Microsoft SMTP Server id
	14.1.225.22; Wed, 30 Nov 2011 17:24:57 +0000
Received: from mail152-ch1 (localhost [127.0.0.1])	by
	mail152-ch1-R.bigfish.com (Postfix) with ESMTP id 822C8100190	for
	<bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2011 17:24:57 +0000 (UTC)
X-SpamScore: 16
X-BigFish: VS16(z2e28uzzz1202h1082kzz8275bhz2dh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail152-ch1 (localhost.localdomain [127.0.0.1]) by mail152-ch1
	(MessageSwitch) id 1322673897222370_13295;
	Wed, 30 Nov 2011 17:24:57 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.244])	by mail152-ch1.bigfish.com (Postfix) with ESMTP id
	238553C0045	for <bitbake-devel@lists.openembedded.org>; Wed, 30 Nov 2011
	17:24:57 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS004.bigfish.com
	(10.43.70.4) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Wed, 30 Nov 2011 17:24:56 +0000
Received: from az33smr02.freescale.net (10.64.34.200) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server id 14.1.339.2; Wed, 30 Nov 2011 11:24:55 -0600
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	pAUHOtaw024628	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2011 11:24:55 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Nov 2011 11:24:55 -0600
Message-ID: <1322673895-25682-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed
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
X-List-Received-Date: Wed, 30 Nov 2011 18:16:55 -0000
Content-Type: text/plain

Some BB_HASHBASE_WHITELIST variables are in the lists of variable
dependencies for signatures. Ignore those differences in lists
since this difference does not matter

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
I'm seeing variables in BB_HASHBASE_WHITELIST make it
to the signature. Not sure if they are used to calculate
the hash but assuming they are not we don't need to print
out that they are different

 lib/bb/siggen.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 9231291..bb909ba 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -237,13 +237,13 @@ def compare_sigfiles(a, b):
     p2 = pickle.Unpickler(file(b, "rb"))
     b_data = p2.load()
 
-    def dict_diff(a, b):
+    def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
         sb = set(b.keys())
         common = sa & sb
         changed = set()
         for i in common:
-            if a[i] != b[i]:
+            if a[i] != b[i] and i not in whitelist:
                 changed.add(i)
         added = sa - sb
         removed = sb - sa
@@ -263,7 +263,7 @@ def compare_sigfiles(a, b):
     if a_data['basehash'] != b_data['basehash']:
         print "basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash'])
 
-    changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'])
+    changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
         for dep in changed:
             print "List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep])
-- 
1.7.6.1




