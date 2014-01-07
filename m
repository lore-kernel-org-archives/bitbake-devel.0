Return-Path: <zhenhua.luo@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by mail.openembedded.org (Postfix) with ESMTP id 1934A6BFFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 03:21:16 +0000 (UTC)
Received: from mail14-ch1-R.bigfish.com (10.43.68.239) by
	CH1EHSOBE019.bigfish.com (10.43.70.76) with Microsoft SMTP Server id
	14.1.225.22; Tue, 7 Jan 2014 03:21:16 +0000
Received: from mail14-ch1 (localhost [127.0.0.1])	by mail14-ch1-R.bigfish.com
	(Postfix) with ESMTP id 4BBBA40266	for
	<bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 03:21:16 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah1fc6hzz1de098h8275bh1de097hz2dh2a8h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h1354h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e23h1fe8h1ff5h2218h2216h226dh22d0h2327h2336h1155h)
Received: from mail14-ch1 (localhost.localdomain [127.0.0.1]) by mail14-ch1
	(MessageSwitch) id 138906487560926_10991;
	Tue,  7 Jan 2014 03:21:15 +0000 (UTC)
Received: from CH1EHSMHS002.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.252])	by mail14-ch1.bigfish.com (Postfix) with ESMTP id
	0832D380047;	Tue,  7 Jan 2014 03:21:15 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS002.bigfish.com
	(10.43.70.2) with Microsoft SMTP Server (TLS) id 14.16.227.3;
	Tue, 7 Jan 2014 03:21:14 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server (TLS) id 14.3.158.2; Tue, 7 Jan 2014 03:21:13 +0000
Received: from localhost.localdomain (B19537-03.ap.freescale.net
	[10.193.20.127])	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with
	ESMTP id s073LAJq008979;	Mon, 6 Jan 2014 20:21:11 -0700
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 7 Jan 2014 11:21:06 +0800
Message-ID: <1389064866-26141-1-git-send-email-zhenhua.luo@freescale.com>
X-Mailer: git-send-email 1.8.4.2
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%0$Dn%FREESCALE.MAIL.ONMICROSOFT.COM$RO%1$TLS%0$FQDN%$TlsDn%
Cc: b43082@freescale.com, b40290@freescale.com, b40527@freescale.com
Subject: [PATCH] bitbake: fetch2/git: add nobranch option for SRC_URI to skip validating SHA
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
X-List-Received-Date: Tue, 07 Jan 2014 03:21:17 -0000
Content-Type: text/plain

For rebased git tree, some commits can be found in tag rather than branch, the change
is useful for such case.

Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b4b9368..6d74dbb 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -101,6 +101,8 @@ class Git(FetchMethod):
 
         ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
 
+        ud.nobranch = ud.parm.get("nobranch","0") == "1"
+
         # bareclone implies nocheckout
         ud.bareclone = ud.parm.get("bareclone","0") == "1"
         if ud.bareclone:
@@ -217,7 +219,7 @@ class Git(FetchMethod):
             ud.repochanged = True
         os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud, d, name):
+            if not ud.nobranch and not self._contains_ref(ud, d, name):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
-- 
1.8.4.2



