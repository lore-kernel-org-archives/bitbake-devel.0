Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]
	helo=DB3EHSOBE001.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1R8fjG-00087T-6X
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Sep 2011 00:02:18 +0200
Received: from mail49-db3-R.bigfish.com (10.3.81.242) by
	DB3EHSOBE001.bigfish.com (10.3.84.21) with Microsoft SMTP Server id
	14.1.225.22; Tue, 27 Sep 2011 21:41:45 +0000
Received: from mail49-db3 (localhost.localdomain [127.0.0.1])	by
	mail49-db3-R.bigfish.com (Postfix) with ESMTP id 2376716C024E	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2011 21:41:45 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bhz2dh2a8h668h839h62h)
X-Spam-TCS-SCL: 1:0
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null);
	IPVD:NLI; H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail49-db3 (localhost.localdomain [127.0.0.1]) by mail49-db3
	(MessageSwitch) id 1317159703894267_5619;
	Tue, 27 Sep 2011 21:41:43 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.243])	by
	mail49-db3.bigfish.com (Postfix) with ESMTP id D392813804F	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2011 21:41:43 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by DB3EHSMHS002.bigfish.com
	(10.3.87.102) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Tue, 27 Sep 2011 21:41:42 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
	039-SN1MMR1-003.039d.mgd.msft.net (10.84.1.16) with Microsoft SMTP
	Server id 14.1.323.7; Tue, 27 Sep 2011 16:41:40 -0500
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	p8RLfeeD008427	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2011 16:41:40 -0500 (CDT)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Sep 2011 16:41:39 -0500
Message-ID: <1317159699-3823-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] Make git fetch run with -f so rebased branches don't fail
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
X-List-Received-Date: Tue, 27 Sep 2011 22:02:18 -0000
Content-Type: text/plain

git fetches can fail (or at least return failed) when trying to
fetch and prune rebased branches. This patch simply adds a -f
to the git fetch command so these failure are ignore

Generally, if some SHA was rebased away it's not coming back so
there is no point in not doing this force

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
This seems to fix the issue when building against our internal trees
which are constantly rebased wrt to git fetch throwing errors if a
non fast-forward-able branch is found

 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fb6125c..87a35d9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -190,7 +190,7 @@ class Git(FetchMethod):
                 logger.debug(1, "No Origin")
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
-            fetch_cmd = "%s fetch --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
+            fetch_cmd = "%s fetch -f --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
             bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             runfetchcmd(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
-- 
1.7.6.1




