Return-Path: <ting.liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
	(mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
	by mail.openembedded.org (Postfix) with ESMTP id 6CFF370332
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Jul 2014 10:37:33 +0000 (UTC)
Received: from BN3PR0301CA0053.namprd03.prod.outlook.com (25.160.152.149) by
	BLUPR03MB151.namprd03.prod.outlook.com (10.255.212.25) with Microsoft
	SMTP Server (TLS) id 15.0.990.7; Wed, 16 Jul 2014 10:37:33 +0000
Received: from BY2FFO11FD049.protection.gbl (2a01:111:f400:7c0c::131) by
	BN3PR0301CA0053.outlook.office365.com (2a01:111:e400:401e::21) with
	Microsoft
	SMTP Server (TLS) id 15.0.990.7 via Frontend Transport; Wed, 16 Jul 2014
	10:37:32 +0000
Received: from tx30smr01.am.freescale.net (192.88.168.50) by
	BY2FFO11FD049.mail.protection.outlook.com (10.1.15.186) with Microsoft
	SMTP Server (TLS) id 15.0.980.11 via Frontend Transport;
	Wed, 16 Jul 2014 10:37:32 +0000
Received: from b28495.ap.freescale.net (b28495.ap.freescale.net [10.193.20.99])
	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id
	s6GAbT1h020429; Wed, 16 Jul 2014 03:37:30 -0700
From: <b28495@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Jul 2014 18:38:27 +0800
Message-ID: <1405507107-30079-1-git-send-email-b28495@freescale.com>
X-Mailer: git-send-email 1.7.3.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.88.168.50; CTRY:US; IPV:CAL; IPV:NLI;
	EFV:NLI; SFV:NSPM;
	SFS:(6009001)(189002)(199002)(105606002)(95666004)(26826002)(21056001)(77982001)(93916002)(85306003)(33646002)(102836001)(106466001)(104016003)(110136001)(89996001)(88136002)(97736001)(31966008)(81342001)(64706001)(47776003)(107046002)(4396001)(20776003)(92566001)(6806004)(86152002)(77156001)(83072002)(85852003)(50466002)(46102001)(87936001)(92726001)(48376002)(81542001)(83322001)(44976005)(74662001)(68736004)(87286001)(2351001)(19580405001)(84676001)(36756003)(50226001)(50986999)(80022001)(62966002)(76482001)(19580395003)(104166001)(79102001)(229853001)(74502001)(99396002);
	DIR:OUT; SFP:; SCL:1; SRVR:BLUPR03MB151;
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
X-List-Received-Date: Wed, 16 Jul 2014 10:37:42 -0000
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


