Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]
	helo=VA3EHSOBE008.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RBAgB-0003Hm-48
	for bitbake-devel@lists.openembedded.org;
	Tue, 04 Oct 2011 21:29:27 +0200
Received: from mail136-va3-R.bigfish.com (10.7.14.251) by
	VA3EHSOBE008.bigfish.com (10.7.40.28) with Microsoft SMTP Server id
	14.1.225.22; Tue, 4 Oct 2011 19:08:44 +0000
Received: from mail136-va3 (localhost.localdomain [127.0.0.1])	by
	mail136-va3-R.bigfish.com (Postfix) with ESMTP id 56833F381EE	for
	<bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2011 19:08:44 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bhz2dh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null);
	IPVD:NLI; H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail136-va3 (localhost.localdomain [127.0.0.1]) by mail136-va3
	(MessageSwitch) id 1317755324114120_25230;
	Tue,  4 Oct 2011 19:08:44 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.240])	by
	mail136-va3.bigfish.com (Postfix) with ESMTP id 1330F3F0050	for
	<bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2011 19:08:44 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS030.bigfish.com
	(10.7.99.40) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Tue, 4 Oct 2011 19:08:40 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
	039-SN1MMR1-003.039d.mgd.msft.net (10.84.1.16) with Microsoft SMTP
	Server id 14.1.323.7; Tue, 4 Oct 2011 14:08:38 -0500
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	p94J8bjh021139	for <bitbake-devel@lists.openembedded.org>;
	Tue, 4 Oct 2011 14:08:37 -0500 (CDT)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Oct 2011 14:08:37 -0500
Message-ID: <1317755317-14911-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] Export additional variables to the fetchers
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
X-List-Received-Date: Tue, 04 Oct 2011 19:29:27 -0000
Content-Type: text/plain

git could need these environment variables when working behind
a proxy

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 lib/bb/fetch2/__init__.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f6fa46c..fb6138b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -385,7 +385,8 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     exportvars = ['PATH', 'GIT_PROXY_COMMAND', 'GIT_PROXY_HOST',
                   'GIT_PROXY_PORT', 'GIT_CONFIG', 'http_proxy', 'ftp_proxy',
                   'https_proxy', 'no_proxy', 'ALL_PROXY', 'all_proxy',
-                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME']
+                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME',
+                  'GIT_PROXY_IGNORE', 'SOCKS5_USER', 'SOCKS5_PASSWD']
 
     for var in exportvars:
         val = bb.data.getVar(var, d, True)
-- 
1.7.6.1




