Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.109])
 by mx.groups.io with SMTP id smtpd.web10.17805.1600878005711110836
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 09:20:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=RZa/hAtQ;
 spf=pass (domain: klsmartin.com, ip: 40.107.6.109, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geLilDde/1ZPb9jlruD5bzpqVrhLBX9gvb1Ifz2dqLqzOa1SbaR+ogi8WuZLHCjjyRzWus/SGh8jlDik4VrOJyEMfh6lQf81U9pAS5Ux0OARRbkxD0H9UKDLzgzYQpIPcOmjSrr3lLsC684cLKp1S21DgPmn8uXlOMKsEESOGyQ1LKKc2J9Ow2c6f6UA+jyjCu6/pcTUWl+jXwrCbcE6p8Jm1PO6uLE4NS9WBmfkp9VnQ1aY5pfCgr2oxwz807pMQL+cVrhAQUtTX9ikdWobIhGGHknpkGnlk01sNAE5IdqRoHux2xd5WOP4l/62iO0lRd9xuYzidxg/1LhYsMc5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyL2eWDlbrY78IR6Nyoz0kYu38+3QaJalvxnVxhFG48=;
 b=VO3vdYQXpH1Xr9Dmnc2v1u99uLo7kBk92HMuZSSd+EBAFaM9ZZKpe8yznGBIui53Da5yro0MuI//U4CL3jclN9XG1LVEBdRD9SZGWQhiUKnWSEEDoxFL2PgPkYPUa8TEZ8+JSDJvEUnANhiSdSpFRoXMLJmloVwMnn10FrgQvEkvtYiiZm4tNv1Jq0oXp2XeQwBR3TFzeD6gQzRokRR+c+GoWYrCmnBEdc5bT1p60WUFRvII7qQ1oTQwnvpt78LZXCENzpCwgKDKW4mEopkD9dmvkfu8Z6HhLjNEy6ufyGWHoVPHHYcVO0+1wH/gVfqN5wo9K4IulDkdAdEdnyLLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyL2eWDlbrY78IR6Nyoz0kYu38+3QaJalvxnVxhFG48=;
 b=RZa/hAtQN5cL5rF4fVD0TOZAwSiMDt96H5FcbqAGXFTLZ8SzDoQsfcakGhSiYu+zYuLh7S8cFL/+aO+YM7mOWuJd3IEiPYyME4DYDyCK7V9COxCw8+Ev2kQ2J6VFsxM2DAI+ImtaRG1LtBTPqH7I4D4mYSEJwqJZjn3Qn1UYDC9Dt3AqvJjlj1yoSaAGFhv1Q1WuZb/8Itqw81Z8wN1BSkdtY0Yvqiv2c6B/rWcW43MbPb7Pwl2ds08mCYP6FHGgq9lkGwRTYG6UmjeaZB41jnXcpBMzpOoMB8/eBJ69CIbc5OzDLSf9qNDHAl4lIXeCKYfAO2nX/ypBTohH8l1X0g==
Received: from DB6PR0402CA0014.eurprd04.prod.outlook.com (2603:10a6:4:91::24)
 by VI1PR02MB4831.eurprd02.prod.outlook.com (2603:10a6:803:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 16:20:02 +0000
Received: from DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:91:cafe::97) by DB6PR0402CA0014.outlook.office365.com
 (2603:10a6:4:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 16:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT015.mail.protection.outlook.com (10.152.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 16:20:02 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Sep 2020 18:20:01 +0200
Received: from ELARA.TUT.KLS.zentral (172.20.10.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Wed, 23 Sep 2020 18:20:01 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 ELARA.TUT.KLS.zentral (172.20.10.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 23 Sep 2020 18:20:01 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 23 Sep 2020 18:20:00 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v2 2/2] tests/fetch: backslash support in file:// URIs
Date: Wed, 23 Sep 2020 18:18:34 +0200
Message-ID: <20200923161832.235619-2-leif.middelschulte@klsmartin.com>
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
X-CI-MailPolicy-Key: a60266a4433cb55947cbc50de7993e6d;1fa5ca58-2a35-4baf-8cb3-07a8bd40538d;ELARA
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ebaaf2-a451-4f8d-3b02-08d85fdc8661
X-MS-TrafficTypeDiagnostic: VI1PR02MB4831:
X-Microsoft-Antispam-PRVS: 
	<VI1PR02MB48318AE723C5C89628F6051199380@VI1PR02MB4831.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LYWt4Y3st4D0bdYzmUkZpP6bWxl4cj39Bk8nALiByVQnhxGE51iqNtYEtKX/DApXtAIwJerAdE4z5NIBAZeKwiD1/ClUTpV8BBevhhwDCZ75JXMWJPp6rHEX5s7AUov7uEpHwlbQ/YARACMcHSBWetvkZ1euy4auY57I2xzGsPiltpKbdclUCabwd/4ARaWLRHu13U7JN2KFnozxvmLlI51kuzetOxs4f5F2OZfOa7FQEmwi3Kx/MOkOwhbrAAEZ5/HtDPRMWdtZJLI5sdts8XAQVejt7dT+6E1COLaERqmzmQEaCxRwpp5TEKhq0WBzHtXTchSFV9buJQjX/6yb5jAI6Z2tNqUUMeGjjbPynBTcwVbUHMbHUX5aap+0doFi9VEuKlNkXSx1ozzbKLDOQC4Y4FJuHjNEYLWkgcD6cUBwIhkcmrodHDQ/b0QFr6Jy
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966005)(2906002)(186003)(70586007)(47076004)(82740400003)(107886003)(6916009)(478600001)(8676002)(26005)(8936002)(16526019)(6666004)(70206006)(4326008)(5660300002)(36756003)(44832011)(316002)(1076003)(82310400003)(33310700002)(81166007)(36906005)(2616005)(356005)(86362001)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:20:02.3988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ebaaf2-a451-4f8d-3b02-08d85fdc8661
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4831
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Implements backslashes in local filenames.
A typical usecase for such a filename is a systemd unit.

Example: `dev-disk-by\x2dpath-foo.device`
---
 lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0ecf044f..c392afc9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -584,6 +584,7 @@ class FetcherLocalTest(FetcherTest):
         touch(os.path.join(self.localsrcdir, 'dir', 'd'))
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
+        touch(os.path.join(self.localsrcdir, 'backslash\x2dsystemd-unit.de=
vice'))
         self.d.setVar("FILESPATH", self.localsrcdir)
=20
     def fetchUnpack(self, uris):
@@ -601,6 +602,10 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
=20
+    def test_local_backslash(self):
+        tree =3D self.fetchUnpack(['file://backslash\\x2dsystemd-unit.devi=
ce'])
+        self.assertEqual(tree, ['backslash\\x2dsystemd-unit.device'])
+
     def test_local_wildcard(self):
         with self.assertRaises(bb.fetch2.ParameterError):
             tree =3D self.fetchUnpack(['file://a', 'file://dir/*'])
--=20
2.26.2

