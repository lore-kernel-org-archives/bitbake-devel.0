Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.135])
 by mx.groups.io with SMTP id smtpd.web11.18007.1600877987627674349
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 09:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=k+P7dm7w;
 spf=pass (domain: klsmartin.com, ip: 40.107.8.135, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otgf2O8N6wmLJS31qVnSDZNR3mPQP3xCqTTBseE1w4Q076wwd+8nbr0eLoeTxkVCDl5G5AXcx8yJ3Lu186Y+mgj2dx4Bk/+GXX/0g7C0cs8u6Yh+8BYFffSOrxaLhW+F54U8RP1jVD06u1X6w/zIPPwbe0Rl+LzPzywP3L6Eibe4JIdI2a7HR4oLEqiZLO5Ck0pvfhiPxaTlLeTskTljExmKyg6PSrw+HcUaqpx+22bUB4bqCXuciCihONkzYSogDGdCg3Du0jiSGjkoWP78oGcyfXZEtjFew+hCMT6xh1inRbITCzdlogajoqALIT+XqImPetr7yHdmW6z4BBgSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=FXlEfGHrcogOAqiCN65INFWswip4RYp1AUiPNiYOIESuSRFFtrdC/TMBQ/xlVTPNdNQTLYzKRv3Sh/uEnYav37Huf3R0D6VyZHIqBIQtRgWNC9tam+fQdY7prv36GZyd37LxMjAukXsbKHfx0E1bTQmsuS78OyBXzBDyYq5N21X32KzkokyYPPKofrsvEhRBeQaO3ETXLlNJ9aJS4iCup8K08sWtlUQUMrMwCyXXtEcVF8xpKXAcnyNCXTlLD+RPkLTYcM9Fr2ywyL1W9fxyKvJojs8hMBZNUi9gjQnbY5pd2dux+8dzUvtmjw4D5zcn6mbfqRddBSkSmb3sioE7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRKWRjbT8p9rdUd0ML3IrhUdvDBybbzExWlx0cDL6k4=;
 b=k+P7dm7wAw/ew1LvAoynGvVax4TZF8SmYoat6tU2uXa7rjrvpLfdTRJizKt4CIQSbClrNNbNT8ojwvECKRS9gKNsFttyp++QES4WhGuHFpaymd9xoJywCK07MtucOD1gfzmSF1d4i/yiEpWLZQif2O3dQlvkpbr1dtO5E1B63fObX9ip8NrrlFDgZtyPvzv+HiYqP008Gp+sD+gGVWMdQcqlrPENrvEmGv5AA6AAw6rteTjFX5LJeRpkruuM7oBc/BO+s6ndCiUl/xnqyMtJZb49Wkoxuo+6pr8MtWGHYyJl6m4/klvQYTAcCXtToIkvrPklewnnHnjrfCzG+fhN2Q==
Received: from DB6PR07CA0099.eurprd07.prod.outlook.com (2603:10a6:6:2c::13) by
 VI1PR0202MB2623.eurprd02.prod.outlook.com (2603:10a6:801:4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Wed, 23 Sep 2020 16:19:45 +0000
Received: from DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::4a) by DB6PR07CA0099.outlook.office365.com
 (2603:10a6:6:2c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.7 via Frontend
 Transport; Wed, 23 Sep 2020 16:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT008.mail.protection.outlook.com (10.152.4.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 16:19:44 +0000
Received: from SKLSExchange01.KLS.zentral (172.20.10.199) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Sep 2020 18:19:44 +0200
Received: from ELARA.TUT.KLS.zentral (172.20.10.63) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Wed, 23 Sep 2020 18:19:44 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 ELARA.TUT.KLS.zentral (172.20.10.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 23 Sep 2020 18:19:43 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 23 Sep 2020 18:19:36 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v2 1/2] fetch2: fix handling of `\` in file:// SRC_URI
Date: Wed, 23 Sep 2020 18:18:33 +0200
Message-ID: <20200923161832.235619-1-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
References: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23.09.2020 11:04:00
X-CI-MailPolicy-Key: 39ee064392aeb15e588bdd6aff4d0e07;f134e50c-d742-4939-b342-2a1d81d57c71;ELARA
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16b3f86-2177-4687-3de7-08d85fdc7bf5
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2623:
X-Microsoft-Antispam-PRVS: 
	<VI1PR0202MB26239B1342BE41A05BAD662F99380@VI1PR0202MB2623.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MGQct8g6AG+L8itNJPbbbINT18mKBMepAIBt9Pl4yoqJvgnd40JARz1xW9Qb2E2ptJac9TeMicHH8MO9iiSSAAy3Ofv4hSLfudQ7rVZcAndyCayrcbP8Us4jsYrPxlnp7MlQr+FvGCmV7mt2mMnO+4Um5Jl2134lRGHfqgRqrmmnUhpHM9OQ0Pn8z+QVv0Ge4WcHVV4q3Zzh8J+7y5hT9VW8Yfq9c9FPt7GMfa4UQmuZdWhRc/7dSpiil6sqKjtzzkKOBK9j0lxx2jP0Jtfb4Z35a0dNpnEM99k7um8mcWoYGD2rLsnV11Gj86BthfuGyLP8RmkTv3f8XaIFKIDXHV3HdXVht9NKJZh90okL8uykwysAiqqMQrc3lj0u0NIKHqBXwutY6O/+6tOMV1oaBFeCT9M1k6aU19fB6s+WobCaBLV7LHlGQ7OnR8+lGRF7OW6yWa5orT7bDk2ZKom8/cX+1ta4du3OOlBASyYjhC5i2Gs3AFSd70XEqiFsasaC
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(46966005)(36906005)(6666004)(82310400003)(8936002)(70586007)(6916009)(5660300002)(83380400001)(107886003)(26005)(4326008)(186003)(16526019)(70206006)(44832011)(2906002)(47076004)(8676002)(2616005)(316002)(81166007)(336012)(1076003)(33310700002)(478600001)(966005)(36756003)(82740400003)(86362001)(356005);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:19:44.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16b3f86-2177-4687-3de7-08d85fdc7bf5
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2623
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Using backslashes in file:// URIs was broken.
Either the resolver would fail or the subsequent `cp` command.
Try to avoid this by putting the filenames into quotes.

Fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D8161

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7ec1fea5..6bf70337 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -21,6 +21,7 @@ if 'git' not in urllib.parse.uses_netloc:
 import operator
 import collections
 import subprocess
+import glob
 import pickle
 import errno
 import bb.persist_data, bb.utils
@@ -1520,7 +1521,9 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd =3D 'cp -fpPRH %s %s' % (file, destdir)
+                # do not rely on Shell's glob expansion.
+                file =3D ' '.join("'{}'".format(file_path) for file_path i=
n glob.glob(file))
+                cmd =3D 'cp -fpPRH %s "%s"' % (file, destdir)
=20
         if not cmd:
             return
--=20
2.26.2

