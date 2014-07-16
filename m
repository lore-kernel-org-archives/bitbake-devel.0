Return-Path: <ting.liu@freescale.com>
X-Greylist: delayed 951 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 16 Jul 2014 10:33:19 UTC
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
	by mail.openembedded.org (Postfix) with ESMTP id C7C287036A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Jul 2014 10:33:19 +0000 (UTC)
Received: from CH1PR03CA008.namprd03.prod.outlook.com (10.255.156.153) by
	CY1PR0301MB0716.namprd03.prod.outlook.com (25.160.159.146) with
	Microsoft
	SMTP Server (TLS) id 15.0.985.8; Wed, 16 Jul 2014 10:17:28 +0000
Received: from BN1BFFO11FD050.protection.gbl (10.255.156.132) by
	CH1PR03CA008.outlook.office365.com (10.255.156.153) with Microsoft SMTP
	Server (TLS) id 15.0.985.8 via Frontend Transport;
	Wed, 16 Jul 2014 10:17:27 +0000
Received: from tx30smr01.am.freescale.net (192.88.168.50) by
	BN1BFFO11FD050.mail.protection.outlook.com (10.58.145.5) with Microsoft
	SMTP Server (TLS) id 15.0.980.11 via Frontend Transport;
	Wed, 16 Jul 2014 10:17:27 +0000
Received: from b28495.ap.freescale.net (b28495.ap.freescale.net [10.193.20.99])
	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id
	s6GAHOUT007631; Wed, 16 Jul 2014 03:17:25 -0700
From: <ting.liu@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Jul 2014 18:18:22 +0800
Message-ID: <1405505902-29285-1-git-send-email-ting.liu@freescale.com>
X-Mailer: git-send-email 1.7.3.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.88.168.50; CTRY:US; IPV:CAL; IPV:NLI;
	EFV:NLI; SFV:NSPM;
	SFS:(6009001)(199002)(189002)(6806004)(229853001)(26826002)(76482001)(104166001)(50226001)(46102001)(102836001)(4396001)(85306003)(84676001)(44976005)(85852003)(19580395003)(21056001)(47776003)(83322001)(106466001)(87286001)(2351001)(62966002)(48376002)(50466002)(89996001)(50986999)(95666004)(68736004)(80022001)(105606002)(99396002)(36756003)(74502001)(64706001)(86362001)(31966008)(83072002)(77156001)(88136002)(110136001)(19580405001)(93916002)(104016003)(92566001)(107046002)(81542001)(79102001)(86152002)(97736001)(87936001)(20776003)(81342001)(92726001)(74662001)(77982001)(33646002);
	DIR:OUT; SFP:; SCL:1; SRVR:CY1PR0301MB0716;
	H:tx30smr01.am.freescale.net; FPR:; MLV:ovrnspm;
	PTR:InfoDomainNonexistent; MX:1; LANG:en; 
MIME-Version: 1.0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 0274272F87
Received-SPF: Fail (: domain of freescale.com does not designate 192.88.168.50
	as permitted sender) receiver=; client-ip=192.88.168.50;
	helo=tx30smr01.am.freescale.net;
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
	smtp.mailfrom=ting.liu@freescale.com; 
X-OriginatorOrg: freescale.com
X-Mailman-Approved-At: Fri, 18 Jul 2014 13:06:08 +0000
Subject: [PATCH] bitbake fetch2/file: fix symlink not created issue
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
X-List-Received-Date: Wed, 16 Jul 2014 10:33:20 -0000
Content-Type: text/plain

From: Ting Liu <ting.liu@freescale.com>

Signed-off-by: Ting Liu <ting.liu@freescale.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index dcada12..7a4e43b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -835,7 +835,10 @@ def try_mirror_url(origud, ud, ld, check = False):
                 # Broken symbolic link
                 os.unlink(origud.localpath)
 
-            os.symlink(ud.localpath, origud.localpath)
+            bb.utils.mkdirhier(os.path.dirname(origud.localpath))
+            src = os.path.join(dldir, ud.localpath)
+            os.symlink(src, origud.localpath)
+
         update_stamp(origud, ld)
         return ud.localpath
 
-- 
1.7.3.4


