Return-Path: <cal@brightsign.biz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2029DC433F5
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 12:14:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.119])
 by mx.groups.io with SMTP id smtpd.web11.7298.1634127293902214863
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 05:14:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brightsign.biz header.s=selector2 header.b=FIDj+Pri;
 spf=pass (domain: brightsign.biz, ip: 40.107.237.119,
 mailfrom: cal@brightsign.biz)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi7ij1dUmdxU93uErBmVXyMq7/TureQTt/qqrXaDmZUVw7iTzBISct9YlBLM2dTKNr+5R7M2wZSckd++RQtaO4sUj7Xvf+iy7Cj7Y8ty6oBJgbeIga+8YJ9TbJjiiyyQuVfivAaVPxuAkSNDtaACltXFC4ATos4aPSZOqSgoPZX/7B4cr7wioUjUdV7piON/A27usHLWaGjOe9PmQifajcKHGWTJSS56n7FlJFRs0I+MBMCCF/tKQOvt+y0fW+xhdbikb/dkXazr4x9xI4y2Z4UDjlkSDqhMqjsN4mUprkIsq0ZMf+n2OYL5gqhVol9LqDW2YvYf6WVc4Fjsf4SxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrTaGw4p5bXFp5HGIe9s3AxXkGa861VOHTagpGY24Hg=;
 b=DVt99iuBr9EYzT8BSCd9FUF5ZJuPaxj3dc2eO0Pahff0pJqM5BEpf5MyTeAWi6IuoVOjUF0KeHgNz+keyt2mOGddim17oWOJ6RfiOMgTHZ/ntyEuNQUWJDBqoyzU0eCBrnI2n/6l40L70NpZSVQ1zH9HiYUfwJcEYQ5qtmEZOYAjGFugIW/NcqiMYxC/DWFVL6i9WiRWv7uUEUuSZDrG/2CqDcA7Sj+EIdeHDhTKnQYdeaqd36upo/ewDe7nwb7SiECqFAOVJV5CI74FzsslJYPsrkktKJum4M4DWTMfJNRvy7Ljj9RmNsjoeDFTg7cZFSF0LicWG/F+5nQK0hnQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.138.180.132) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=brightsign.biz; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=brightsign.biz; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brightsign.biz;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrTaGw4p5bXFp5HGIe9s3AxXkGa861VOHTagpGY24Hg=;
 b=FIDj+PriiQXBRsY8ucMzwZvnZfIfRPMTIml5hReodVTz7JBPbD6nQOuN2JsDv3yL6G2Gif1a9HbYzT7iXoC3T0wmR28EdoWgoKyDmKRNic3TiduwAgO0nkmSI8z8orrHq692Gn0CW2+3Y314pD6bviq/yeS3kd9Ka9Q5tSalSkCH+Wo7tsimVonOzVQc0ZbWUw6j8J5lir++tcZ+6FXQ58l3+PYglu4sh2Exx69NFZhA2Xnvk5z8B7XPmGNKqdCHDba+YZwZdnJHH9Pf7fK0pB9tWakYDB9i/bPeNW6V0tKmrcf2nKlqWY8EcZ2XmP6HnuuWBW0XD0YuFQ4i7GagJw==
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by MWHPR22MB0383.namprd22.prod.outlook.com (2603:10b6:300:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 12:14:51 +0000
Received: from BN8NAM04FT010.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::50) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Wed, 13 Oct 2021 12:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.138.180.132)
 smtp.mailfrom=brightsign.biz; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=brightsign.biz;
Received-SPF: Pass (protection.outlook.com: domain of brightsign.biz
 designates 217.138.180.132 as permitted sender)
 receiver=protection.outlook.com; client-ip=217.138.180.132;
 helo=elite.brightsign;
Received: from elite.brightsign (217.138.180.132) by
 BN8NAM04FT010.mail.protection.outlook.com (10.13.161.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 12:14:51 +0000
Received: from ukcam-caltinbasak01.brightsign ([fd44:d8b8:cab5:cb01::7b])
	by elite.brightsign with esmtp (Exim 4.92)
	(envelope-from <caltinbasak@brightsign.biz>)
	id 1mad9h-0003Q4-Pi; Wed, 13 Oct 2021 13:14:45 +0100
Received: from cal by ukcam-caltinbasak01.brightsign with local (Exim 4.92)
	(envelope-from <cal@ukcam-caltinbasak01.brightsign>)
	id 1mad9h-0004cF-Os; Wed, 13 Oct 2021 13:14:45 +0100
From: Caner Altinbasak <cal@brightsign.biz>
To: bitbake-devel@lists.openembedded.org
Cc: Caner Altinbasak <cal@brightsign.biz>
Subject: [PATCH 2/2] fetch2: Do not attempt to verify donestamp if download is
 not complete
Date: Wed, 13 Oct 2021 13:14:42 +0100
Message-Id: <20211013121442.17696-2-cal@brightsign.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211013121442.17696-1-cal@brightsign.biz>
References: <20211013121442.17696-1-cal@brightsign.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f919cc9a-3914-4b1f-a4c0-08d98e430ef1
X-MS-TrafficTypeDiagnostic: MWHPR22MB0383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MWHPR22MB0383076A90BCBE411A5865A2DAB79@MWHPR22MB0383.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	riRIik8sm+OdbPCSJvefG1VtTyTJxT0T3C7zauuYFswoqRrZE3bVV/i199VwG+wCrM7bad9GyLlFER/bk5uXdjj2eOOnuC9sCvnmtGxATuOsNZ1sqBrZP9wYTIG9v1ojpIsTNW2mNV34H/9Qv5+0gSO3oHstU99iyluQSK2ITVDUOkzb/rvR/qu/94tWSPKr5BnV6X/JIsWOXrkjRc/doMKmit2TydHh/+msbeTeWwe5FcKY1DrW/Y7xgYfmO/12N/+6L56YXdcypkneH/AY2FU6yYZSL6apZ2Bw240GWWAibFcPiPwyWOScZ4HLosf30DqvlseFjn7vIvMs74HxqOvktuesYxbU0uctrMh+bGGY205AvImUxRSbPXC68pFtzMfB38tp6TjkGjrRjcgdXxvnL7M32TlaxCnQlrQP0GUeDKZJt8HnXV62thtkp1IO7d/q2ncGCk622VqlGWt3zWlunCUIABQ5bcIlBth/NH9VLeFwwCIqDPVoqGss2O4cN0vPIfi3Z+FaF50rmnvxUprkKIEUN4y5I2D6bVn2arRDH3j/Xt2bzlhiRytpBywaZsRdNIUT26jwTxy+3hKTEZHkqbvz7i/DkTFKRQGToHN56KuklBqRiEyQ/4D6PK2gyoT+6b/672KpQdbuIwUGWxf9G5ss52wQ84L6iQBUgiQop2B9seoDfMTGyhbZlkeWq/ZvQplVvAI8FtW11KEJyA==
X-Forefront-Antispam-Report: 
	CIP:217.138.180.132;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:elite.brightsign;PTR:elite.brightsigndigital.co.uk;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39840400004)(396003)(46966006)(36840700001)(508600001)(70586007)(47076005)(5660300002)(36756003)(4326008)(86362001)(8936002)(83380400001)(82310400003)(70206006)(1076003)(9786002)(186003)(6916009)(8676002)(26005)(70036008)(2616005)(356005)(9746002)(36860700001)(2906002)(336012)(316002)(36906005)(107886003)(15650500001)(6666004);DIR:OUT;SFP:1102;
X-OriginatorOrg: brightsign.biz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:14:51.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f919cc9a-3914-4b1f-a4c0-08d98e430ef1
X-MS-Exchange-CrossTenant-Id: 8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c;Ip=[217.138.180.132];Helo=[elite.brightsign]
X-MS-Exchange-CrossTenant-AuthSource: 
 BN8NAM04FT010.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR22MB0383
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 12:14:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12765

npmsw(and maybe other fetchers) may try to download same files simulatenous=
ly.

if a premirror is set, download method tries premirror location first. If f=
ile
is not found, done is set to false. In the meantime, other fetchers may dow=
nload
the files required and verify_donestamp might return true.

In this scenerio, fetcher doesn't try to download again and fails. Do not
attempt to verify_donestamp if done is not set. By this way, we ensure that
fetcher attempts to do another download after premirror failure.

Signed-off-by: Caner Altinbasak <cal@brightsign.biz>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 259b2637a..650969020 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1721,7 +1721,9 @@ class Fetch(object):
                     self.d.setVar("BB_NO_NETWORK", "1")

                 firsterr =3D None
-                verified_stamp =3D m.verify_donestamp(ud, self.d)
+                verified_stamp =3D False
+                if done:
+                    verified_stamp =3D m.verify_donestamp(ud, self.d)
                 if not done and (not verified_stamp or m.need_update(ud, s=
elf.d)):
                     try:
                         if not trusted_network(self.d, ud.url):
--
2.20.1

BrightSign considers your privacy to be very important. The emails you send=
 to us will be protected and secured. Furthermore, we will only use your em=
ail and contact information for the reasons you sent them to us and for tra=
cking how effectively we respond to your requests.

