Return-Path: <mario.goulart@bmw-carit.de>
X-Greylist: delayed 7058 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 21 Jul 2016 16:06:03 UTC
Received: from cit-hm8-gw01.bmw-carit.de (cit-hm8-mail01.bmw-carit.de
	[212.118.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id 5626665CBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 16:06:03 +0000 (UTC)
Received: from [10.40.100.13] (port=47891 helo=cit-hm8-mail01.bmw-carit.de)
	by cit-hm8-gw01.bmw-carit.de with esmtps (TLSv1.2:AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <Mario.Goulart@bmw-carit.de>)
	id 1bQEeF-0002WT-14 for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2016 16:08:23 +0200
Received: from macbook-bmw.bmw-car.intra (10.242.6.13) by
	CIT-HM8-EX01.bmw-carit.intra (10.40.100.13) with Microsoft SMTP Server
	(TLS) id 15.0.1178.4; Thu, 21 Jul 2016 16:08:21 +0200
X-CTCH-RefID: str=0001.0A0C0208.5790D757.00D5, ss=1, re=0.000, recu=0.000,
	reip=0.000, cl=1, cld=1, fgs=0
From: Mario Domenech Goulart <mario.goulart@bmw-carit.de>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jul 2016 16:08:01 +0200
Message-ID: <1469110081-3602-1-git-send-email-mario.goulart@bmw-carit.de>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.242.6.13]
X-ClientProxiedBy: CIT-HM8-EX01.bmw-carit.intra (10.40.100.13) To
	CIT-HM8-EX01.bmw-carit.intra (10.40.100.13)
Cc: Mario Domenech Goulart <mario.goulart@bmw-carit.de>
Subject: [PATCH] fetcher2/__init__: Print command in case of ExecutionError in runfetchcmd
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
X-List-Received-Date: Thu, 21 Jul 2016 16:06:07 -0000
Content-Type: text/plain

Signed-off-by: Mario Domenech Goulart <mario.goulart@bmw-carit.de>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a27512c..0cf512b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -832,7 +832,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None):
             output = "output:\n%s" % e.stderr
         else:
             output = "no output"
-        error_message = "Fetch command failed with exit code %s, %s" % (e.exitcode, output)
+        error_message = "Fetch command %s failed with exit code %s, %s" % (e.command, e.exitcode, output)
     except bb.process.CmdError as e:
         error_message = "Fetch command %s could not be run:\n%s" % (e.command, e.msg)
     if not success:
-- 
2.8.1


