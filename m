Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]
	helo=DB3EHSOBE002.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RTOBa-0001Kw-2o
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 02:33:10 +0100
Received: from mail89-db3-R.bigfish.com (10.3.81.247) by
	DB3EHSOBE002.bigfish.com (10.3.84.22) with Microsoft SMTP Server id
	14.1.225.22; Thu, 24 Nov 2011 01:10:52 +0000
Received: from mail89-db3 (localhost [127.0.0.1])	by mail89-db3-R.bigfish.com
	(Postfix) with ESMTP id E2FA1260304	for
	<bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 01:11:29 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bhz2dh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 13,
Received: from mail89-db3 (localhost.localdomain [127.0.0.1]) by mail89-db3
	(MessageSwitch) id 1322097089856859_3897;
	Thu, 24 Nov 2011 01:11:29 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.246])	by
	mail89-db3.bigfish.com (Postfix) with ESMTP id C339180046	for
	<bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 01:11:29 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by DB3EHSMHS001.bigfish.com
	(10.3.87.101) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Thu, 24 Nov 2011 01:10:52 +0000
Received: from az33smr02.freescale.net (10.64.34.200) by
	039-SN1MMR1-003.039d.mgd.msft.net (10.84.1.16) with Microsoft SMTP
	Server id 14.1.339.2; Wed, 23 Nov 2011 19:11:29 -0600
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	pAO1BSGn013883	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2011 19:11:29 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Nov 2011 19:11:27 -0600
Message-ID: <1322097087-26935-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] Nothing uses USERNAME, remove it - can cause sstate-cache conflicts
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
X-List-Received-Date: Thu, 24 Nov 2011 01:33:10 -0000
Content-Type: text/plain

USER is the correct variable to use, also this can affect sstate
cache as well.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 lib/bb/utils.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f905702..521a068 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -505,7 +505,6 @@ def preserved_envvars_exported():
         'SHELL',
         'TERM',
         'USER',
-        'USERNAME',
     ]
 
 def preserved_envvars_exported_interactive():
-- 
1.7.6.1




