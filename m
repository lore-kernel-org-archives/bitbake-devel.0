Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]
	helo=ch1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RlUvf-0001Km-4T
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 01:23:35 +0100
Received: from mail113-ch1-R.bigfish.com (10.43.68.243) by
	CH1EHSOBE010.bigfish.com (10.43.70.60) with Microsoft SMTP Server id
	14.1.225.23; Thu, 12 Jan 2012 23:09:03 +0000
Received: from mail113-ch1 (localhost [127.0.0.1])	by
	mail113-ch1-R.bigfish.com (Postfix) with ESMTP id BE88D62043D	for
	<bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2012 23:09:03 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bh8275dhz2dhc1ahc1bh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-FB-SS: 13,
Received: from mail113-ch1 (localhost.localdomain [127.0.0.1]) by mail113-ch1
	(MessageSwitch) id 1326409743604715_13181;
	Thu, 12 Jan 2012 23:09:03 +0000 (UTC)
Received: from CH1EHSMHS001.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.245])	by mail113-ch1.bigfish.com (Postfix) with ESMTP id
	8558C240082	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2012
	23:09:03 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS001.bigfish.com
	(10.43.70.1) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Thu, 12 Jan 2012 23:09:03 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server id 14.1.355.3; Thu, 12 Jan 2012 17:09:02 -0600
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	q0CN915a007275	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2012 17:09:01 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jan 2012 17:09:01 -0600
Message-ID: <1326409741-17390-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] bitbake/fetch2: add support for wrapper command
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
X-List-Received-Date: Fri, 13 Jan 2012 00:23:35 -0000
Content-Type: text/plain

cc: bitbake-devel@lists.openembedded.org
Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 lib/bb/fetch2/__init__.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3af56e5..1d7d5c7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -389,6 +389,8 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     Optionally remove the files/directories listed in cleanup upon failure
     """
 
+    cmd = "%s %s" % (bb.data.getVar("BB_FETCH_WRAPPER", d, True), cmd)
+
     # Need to export PATH as binary could be in metadata paths
     # rather than host provided
     # Also include some other variables.
-- 
1.7.6.1




