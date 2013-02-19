Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1U7u9k-0006h3-KW
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Feb 2013 21:51:31 +0100
Received: from mail73-ch1-R.bigfish.com (10.43.68.232) by
	CH1EHSOBE016.bigfish.com (10.43.70.66) with Microsoft SMTP Server id
	14.1.225.23; Tue, 19 Feb 2013 20:20:02 +0000
Received: from mail73-ch1 (localhost [127.0.0.1])	by mail73-ch1-R.bigfish.com
	(Postfix) with ESMTP id 7C0AC6014B	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 19 Feb 2013 20:20:02 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 3
X-BigFish: VS3(zzzz1f42h1ee6h1de0h1202h1e76h1d1ah1d2ah1082kzz8275bhz2dh2a8h668h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1155h)
Received: from mail73-ch1 (localhost.localdomain [127.0.0.1]) by mail73-ch1
	(MessageSwitch) id 1361305200397373_11839;
	Tue, 19 Feb 2013 20:20:00 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.249])	by mail73-ch1.bigfish.com (Postfix) with ESMTP id
	54BEA40127 for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Feb 2013 20:20:00 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS033.bigfish.com
	(10.43.70.33) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Tue, 19 Feb 2013 20:19:59 +0000
Received: from az84smr01.freescale.net (10.64.34.197) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server (TLS) id 14.2.328.11; Tue, 19 Feb 2013 20:19:58 +0000
Received: from right.am.freescale.net (right.am.freescale.net [10.82.176.228])
	by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id
	r1JKJvBS029475	for
	<bitbake-devel@lists.openembedded.org>; Tue, 19 Feb 2013 13:19:58 -0700
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Feb 2013 14:20:01 -0600
Message-ID: <1361305201-15312-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.9.7
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] bitbake/fetch2: workaround urlparse in older python not support git
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
X-List-Received-Date: Tue, 19 Feb 2013 20:51:34 -0000
Content-Type: text/plain

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index f5b363d..8118fc2 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -30,6 +30,9 @@ from __future__ import print_function
 import os, re
 import logging
 import urllib
+import urlparse
+if 'git' not in urlparse.uses_netloc:
+    urlparse.uses_netloc.append('git')
 from urlparse import urlparse
 import operator
 import bb.persist_data, bb.utils
-- 
1.7.9.7




