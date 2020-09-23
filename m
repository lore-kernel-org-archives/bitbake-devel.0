Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.129])
 by mx.groups.io with SMTP id smtpd.web12.13827.1600868030244371196
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 06:33:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=MvkpI5Je;
 spf=pass (domain: klsmartin.com, ip: 40.107.8.129, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVwVvd5qEPv5kXPPHVnIbSaDVTSXNqU9Ijp9UgqJptlwDxHxKoiwuWMQ8OE7bolnBhTXSZsvwa//QFDkd1GOTACtGDsTcUZSaDf0a/Hj81XAIYZGcmwZIH9UI2avrnSqqqorqipBfWxJbSksn4a7SViQVngULdkh1H4VypbaOJ0MKulSk9KJTyX1wpTIhhIz6J77+tdcSe1Jos3nd4gtE4001H2yTk2v6TME9AooFiP0MZq6LxFx1Ori1xZEF1yWabkQPZxgw/ie50OJoZ0A06iIpOqRnv0yc9xtqfDqsU0qvCDihIjVgwax0jkeEbbtLsxGadGx6qM8SQDx2KL2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ImK48lArv9BfdlRUqfAy6gJ7Vk6rRGH4jUvgKVDc6A=;
 b=Uhl5tzHVn6XmUOpKY9Isgt6fQFDVkWaKKm8gSElR8oQRjIfwPBPqr7UFgxCLrHKltrYryi8OxcmJkt8igADyZKRlmNSyiRHccIZkjO4Wto8Qx7dVQe1A5ujR2YrF/tdyXr8bgZCsd/gJaeBak1eavCwwMm+rZI1AW42vN3u31Hfso+W84cKLQihzKNS11PV8W5CeiOJdH7JSC1rYfg+zNy/vnDTuhFBJ0KQFaq7+6OZSW1pZ5L1+DvDqIwirxmnZiuuozx61gynTsENoZgbqtfcTiNo+qFfQGWLQIyMzWUT5B+tfVmYpM3/mZt4gsrezxriXO6NjDsRgcwg2v7gp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ImK48lArv9BfdlRUqfAy6gJ7Vk6rRGH4jUvgKVDc6A=;
 b=MvkpI5JemP3p3/lAUzjvsDLbJoA/4DriQ3L9nxsohHxZfZuXRJeE6U4G3gqgorpC0L87ksaXlF6BBOtCtIjciensFdPSHRM7hDxeDvxhMPhtYWjk+N8tgsjJgfEAFzEVkJAJWLmHz3nG+oABSc0gJpWipdZuJw5YUjV5uwE6PKlxuTof7xn23izpEp6vTA2V7Iw7yNiUpaMzXm1ohtOiY9PH+RwuNfpQDyVK7O0npMRjjFUXba9zJD6ZJU9Z8A7n2Gd4cAnmvcLsMNOFNoSdHKZCPdByiLM5e/dR5rlljegrSzBDW4I/VR/nHgqP7Q/Tn84moro6DZvgAVnJR3+jLg==
Received: from DB6PR0801CA0062.eurprd08.prod.outlook.com (2603:10a6:4:2b::30)
 by HE1PR0202MB2619.eurprd02.prod.outlook.com (2603:10a6:3:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 13:33:46 +0000
Received: from DB5EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::40) by DB6PR0801CA0062.outlook.office365.com
 (2603:10a6:4:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 13:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT020.mail.protection.outlook.com (10.152.4.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 13:33:45 +0000
Received: from SKLSExchange01.KLS.zentral (172.20.10.199) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Sep 2020 15:33:45 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Wed, 23 Sep 2020 15:33:45 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 23 Sep 2020 15:33:44 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH] fetch2: fix handling of `\` in file:// SRC_URI
Date: Wed, 23 Sep 2020 15:32:54 +0200
Message-ID: <20200923133253.187115-1-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23.09.2020 08:35:00
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d5ef78d-051e-45c7-2707-08d85fc54bc6
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2619:
X-Microsoft-Antispam-PRVS: 
	<HE1PR0202MB2619E7CE22D56B0B3DA1E7B899380@HE1PR0202MB2619.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WdhVRdt//DVUZYLEaw5u1movbd+IHx7gsvf0psvec7kqs9cTese0w7bFQirUR3tcmYj1wdYX3gFESXdnk/wLB02KgeuKFJNWbsnbiQkrNGZ/cAckQfa88OsQrYPL15X8yYGv+NB0X9fXWR179hCqLaTkW+mDZRwiKAFcBTYuSfvVhYY5rytYW1zbfggQn4UnBf1Ec2T/bY+A4Odi0kNS8PT5+jPsn25E13ewY190hI0rwKsJBfCZgK5XtGtFfMG4yDdu7ZIjefkktvuJMGtLJ+nZRyvTbIyK3OjLR2YJLLUIvE7lPrmqAbPEal4JYo9U+uHNtwaKf1IAuf5qPFjLIL3yClfYY9Imt8IFCv565SnPLGhAPBaS+sZEQgf5MPvK014J/OkQ0BDuWNNgDlqwoQyZlMUSS8AsQAxOJ1R7J9O+SfDK87hXZ/+SOxgqwDdOuQ8+uKqYMbk8SqGwg+/bh+czhKAACTOLk7UrW4VANk0YGC2D+89ydeW/zY8HARsq
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(46966005)(36906005)(316002)(966005)(47076004)(356005)(44832011)(2616005)(81166007)(83380400001)(336012)(82310400003)(36756003)(33310700002)(5660300002)(26005)(186003)(16526019)(70586007)(70206006)(86362001)(8676002)(2906002)(6916009)(82740400003)(478600001)(4326008)(6666004)(1076003)(4744005)(8936002)(107886003);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 13:33:45.6478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5ef78d-051e-45c7-2707-08d85fc54bc6
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2619
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Using backslashes in file:// URIs was broken.
Either the resolver would fail or the subsequent `cp` command.
Try to avoid this by putting the filenames into quotes.

Fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D8161

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7ec1fea5..1911ecd3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1520,7 +1520,7 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd =3D 'cp -fpPRH %s %s' % (file, destdir)
+                cmd =3D "cp -fpPRH '%s' '%s'" % (file, destdir)
=20
         if not cmd:
             return
--=20
2.26.2

