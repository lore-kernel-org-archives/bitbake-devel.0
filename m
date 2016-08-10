Return-Path: <btv1==030c3eaa6d5==Terry.Boese@vecima.com>
X-Greylist: delayed 1022 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 10 Aug 2016 15:31:43 UTC
Received: from mx2.vecima.com (mx2.vecima.com [216.65.182.69])
	by mail.openembedded.org (Postfix) with ESMTP id B36CF74197
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 15:31:43 +0000 (UTC)
X-ASG-Debug-ID: 1470842081-0359fc429221b250001-FWLXlK
Received: from ExchangeInt.corp.vcom.com (exchangeint.corp.vcom.com
	[192.168.50.125]) by mx2.vecima.com with ESMTP id
	MikBMYWO4L6QzIg8 for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 09:14:41 -0600 (CST)
X-Barracuda-Envelope-From: Terry.Boese@vecima.com
Received: from PC2170.corp.vcom.com (192.168.216.92) by
	ExchangeInt.corp.vcom.com (192.168.50.125) with Microsoft SMTP Server
	id 14.3.279.2; Wed, 10 Aug 2016 09:14:41 -0600
From: Terry Boese <terry.boese@vecima.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Aug 2016 09:14:15 -0600
X-ASG-Orig-Subj: [PATCH v2] fetch2/gitannex.py: use 'git annex init' instead
	of 'git annex sync'
Message-ID: <1470842055-18237-1-git-send-email-terry.boese@vecima.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [192.168.216.92]
X-Barracuda-Connect: exchangeint.corp.vcom.com[192.168.50.125]
X-Barracuda-Start-Time: 1470842081
X-Barracuda-URL: https://192.168.99.189:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 901
X-Virus-Scanned: by bsmtpd at vecima.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.31902
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
Cc: Terry Boese <terry.boese@vecima.com>
Subject: [PATCH v2] fetch2/gitannex.py: use 'git annex init' instead of 'git annex sync'
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
X-List-Received-Date: Wed, 10 Aug 2016 15:31:43 -0000
Content-Type: text/plain

The git annex fetcher needs git annex to be initialized.  Previously
it was using 'git annex sync' to do this, but that has the downside
of moving the checkout to the tip of the default branch.  This means
that tags, SRCREV, etc don't work in the gitannex case.

Signed-off-by: Terry Boese <terry.boese@vecima.com>
---
 bitbake/lib/bb/fetch2/gitannex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/gitannex.py b/bitbake/lib/bb/fetch2/gitannex.py
index 0f37897..e4527f1 100644
--- a/bitbake/lib/bb/fetch2/gitannex.py
+++ b/bitbake/lib/bb/fetch2/gitannex.py
@@ -66,7 +66,7 @@ class GitANNEX(Git):
 
         os.chdir(ud.destdir)
         try:
-            runfetchcmd("%s annex sync" % (ud.basecmd), d)
+            runfetchcmd("%s annex init" % (ud.basecmd), d)
         except bb.fetch.FetchError:
             pass
 
-- 
2.7.4


