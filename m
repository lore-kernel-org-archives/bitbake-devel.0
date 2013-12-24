Return-Path: <zhenhua.luo@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
	(co1ehsobe002.messaging.microsoft.com [216.32.180.185])
	by mail.openembedded.org (Postfix) with ESMTP id EEA446A5A2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:08 +0000 (UTC)
Received: from mail34-co1-R.bigfish.com (10.243.78.242) by
	CO1EHSOBE034.bigfish.com (10.243.66.99) with Microsoft SMTP Server id
	14.1.225.22; Tue, 24 Dec 2013 08:07:09 +0000
Received: from mail34-co1 (localhost [127.0.0.1])	by mail34-co1-R.bigfish.com
	(Postfix) with ESMTP id A75539005D4	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:09 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah1fc6hzz1de098h8275bh1de097hz2dh2a8h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h1354h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dfeh1dffh1e23h1fe8h1ff5h2218h2216h226dh22d0h2327h2336h1155h)
Received: from mail34-co1 (localhost.localdomain [127.0.0.1]) by mail34-co1
	(MessageSwitch) id 1387872427971373_2707;
	Tue, 24 Dec 2013 08:07:07 +0000 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.240])	by
	mail34-co1.bigfish.com (Postfix) with ESMTP id DF107BC004C;
	Tue, 24 Dec 2013 08:07:07 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CO1EHSMHS013.bigfish.com
	(10.243.66.23) with Microsoft SMTP Server (TLS) id 14.16.227.3;
	Tue, 24 Dec 2013 08:07:03 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server (TLS) id 14.3.158.2; Tue, 24 Dec 2013 08:07:01 +0000
Received: from localhost.localdomain (B19537-03.ap.freescale.net
	[10.193.20.127])	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with
	ESMTP id rBO86soK021591;	Tue, 24 Dec 2013 01:06:59 -0700
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 16:06:33 +0800
Message-ID: <1387872393-4567-3-git-send-email-zhenhua.luo@freescale.com>
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%0$Dn%FREESCALE.MAIL.ONMICROSOFT.COM$RO%1$TLS%0$FQDN%$TlsDn%
Cc: b40290@freescale.com, b40527@freescale.com
Subject: [PATCH 2/2] bitbake: fetch2: adjust the priority of revision definition
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
X-List-Received-Date: Tue, 24 Dec 2013 08:07:09 -0000
Content-Type: text/plain

The sanity check for commit validity has been added for branch, to support the
commit included in tag rather than branch, the commit validity check should be
supported for tag as well.

To allign with above change, the priority of revision needs to be adjusted as
following, otherwise SHA defined by SRCREV will be overriden by rev/tag defined
by SRC_URI.

New SHA check order:
a) a source revision if SHA is specified by SRCREV
b) a source revision if revision is specified in SRC_URI
c) latest revision if SRCREV="AUTOINC"
d) None if not specified

Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
---
 lib/bb/fetch2/__init__.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8fdf59c..4c5c2e8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -862,17 +862,12 @@ def try_mirrors(d, origud, mirrors, check = False):
 def srcrev_internal_helper(ud, d, name):
     """
     Return:
-        a) a source revision if specified
-        b) latest revision if SRCREV="AUTOINC"
-        c) None if not specified
+        a) a source revision if SHA is specified by SRCREV
+        b) a source revision if revision is specified in SRC_URI
+        c) latest revision if SRCREV="AUTOINC"
+        d) None if not specified
     """
 
-    if 'rev' in ud.parm:
-        return ud.parm['rev']
-
-    if 'tag' in ud.parm:
-        return ud.parm['tag']
-
     rev = None
     pn = d.getVar("PN", True)
     if name != '':
@@ -883,6 +878,12 @@ def srcrev_internal_helper(ud, d, name):
         rev = d.getVar("SRCREV_pn-%s" % pn, True)
     if not rev:
         rev = d.getVar("SRCREV", True)
+    if not rev:
+        if 'rev' in ud.parm:
+            return ud.parm['rev']
+    if not rev:
+        if 'tag' in ud.parm:
+            return ud.parm['tag']
     if rev == "INVALID":
         var = "SRCREV_pn-%s" % pn
         if name != '':
-- 
1.8.4.2



