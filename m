Return-Path: <zhenhua.luo@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
	(mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
	by mail.openembedded.org (Postfix) with ESMTP id 39C446C6D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 10:17:29 +0000 (UTC)
Received: from mail183-db9-R.bigfish.com (10.174.16.254) by
	DB9EHSOBE030.bigfish.com (10.174.14.93) with Microsoft SMTP Server id
	14.1.225.22; Wed, 8 Jan 2014 10:17:29 +0000
Received: from mail183-db9 (localhost [127.0.0.1])	by
	mail183-db9-R.bigfish.com (Postfix) with ESMTP id 837614802C5	for
	<bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 10:17:29 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah1fc6hzz1de098h8275bh1de097hz2dh2a8h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h1354h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e23h1fe8h1ff5h2218h2216h226dh22d0h2327h2336h1155h)
Received: from mail183-db9 (localhost.localdomain [127.0.0.1]) by mail183-db9
	(MessageSwitch) id 1389176247943329_28275;
	Wed,  8 Jan 2014 10:17:27 +0000 (UTC)
Received: from DB9EHSMHS026.bigfish.com (unknown [10.174.16.225])	by
	mail183-db9.bigfish.com (Postfix) with ESMTP id E051E4E0049;
	Wed,  8 Jan 2014 10:17:27 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by DB9EHSMHS026.bigfish.com
	(10.174.14.36) with Microsoft SMTP Server (TLS) id 14.16.227.3;
	Wed, 8 Jan 2014 10:17:24 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-005.039d.mgd.msft.net (10.84.1.17) with Microsoft SMTP
	Server (TLS) id 14.3.158.2; Wed, 8 Jan 2014 10:17:19 +0000
Received: from localhost.localdomain (B19537-03.ap.freescale.net
	[10.193.20.127])	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with
	ESMTP id s08AHGiR020993;	Wed, 8 Jan 2014 03:17:18 -0700
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 8 Jan 2014 18:17:08 +0800
Message-ID: <1389176228-5336-1-git-send-email-zhenhua.luo@freescale.com>
X-Mailer: git-send-email 1.8.4.2
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%0$Dn%FREESCALE.MAIL.ONMICROSOFT.COM$RO%1$TLS%0$FQDN%$TlsDn%
Cc: b40290@freescale.com, b40527@freescale.com
Subject: [PATCH] bitbake: fetch2/git: add description for nobranch
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
X-List-Received-Date: Wed, 08 Jan 2014 10:17:30 -0000
Content-Type: text/plain

Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
---
 lib/bb/fetch2/git.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c323309..cae1653 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,6 +44,11 @@ Supported SRC_URI options are:
    checkout code and tracking branch requirements.
    The default is "0", set bareclone=1 if needed.
 
+- nobranch
+   Don't check the SHA validation for branch. set this option for the recipe
+   referring to commit which is valid in tag instead of branch.
+   The default is "0", set nobranch=1 if needed.
+
 """
 
 #Copyright (C) 2005 Richard Purdie
-- 
1.8.4.2



