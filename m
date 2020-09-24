Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.109])
 by mx.groups.io with SMTP id smtpd.web11.16382.1600952870053942422
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 06:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=W/cDLXWx;
 spf=pass (domain: klsmartin.com, ip: 40.107.21.109, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBdAuMzq97erd4FZlCEU5gjUrWyJ/PV96EJiJLbBQ/1dMmfPNGQsHmieJ1dJP58pA4ubFtbn0W5XFTTAIyvzbyGNHIt4OxmHyOhCQkKiaX7E7P56imoBtK8Y5CcnyjUMLTzE4hAkZcKrKBLDWpZc1uerGwRk8NwbKkgZrnoabC0BulSSGIL5TBcJXfe1ERne8cZI8NqQrNla1UNKIopyN89yd3bxYlowAQ1fcha5o/FvfRJBIatHrqmhB9s/FimvTy41xm2rE4r1zNB37OoJ3ufrIxgfKhmVsaEEkodIgjVdRxRB5oPp208ina4keNR1k3TKNxk1PbIU8iLOnw6I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUkX+e6uuBpCvcpTii8pwyeABDjHlgF/UUF5QphrKZQ=;
 b=bZ6FwOp48VD9cgSZMchzApQe+kbUX05ZdWma89HMtte13Co61cMH2TeHwTfWioi0dhbfWov8fa0w0YrhRG2xHfKHRut8NFyZFq5Flu0+RtwpIfKluv9oJZJEwWCoQbekzqBVNrE0htgSZERIKEOfauCGSKXa6S+uD9Oz2r7TF4VcsUeuMxFGiEV94YTbp71CUfTh3x6QPZxKD9tjj4wN9AH59AnIT9k/06LM0nBXfaV0vBpLImZgcKW0n/BY4aSfAfNKkxxoC25hnJ4yB48yhuy7JpOZ0OedqrjJPSlzCfLBECiVtL8Uo2n/KuzAhT8SByOy8jnfSp07ONfhle+WWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUkX+e6uuBpCvcpTii8pwyeABDjHlgF/UUF5QphrKZQ=;
 b=W/cDLXWxaugmPeh20N6063ZG3fF6sU3UuAwhYMKWPbBz7g8vcriGp1vVNTyGR9ftTlGhnhr09gmI3rSePV4RtXi9lM1T1NgSRbFaMT0e3rnL2gPrdpv3ifcUkvr877y6XyaJfVO3jolrtvzsWC2EM4DHmzpLTQ0L+rQAAl5hOh4Jeq2pcy6Nxk7bpLh05LjcMjDqpywmaAbI6a/54wbu/Rsmq92jtefZA7+ABfeQW0jdez8vroovyjHz5Q2VSjeCKvctz9mbIf/edJ8bivbK7AbgS9804Z7s8qKk2UlsjdPpZRNizPguOcSgExHKXKMWQuAuvQq1dUaA9bQKczf3mg==
Received: from AM5PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:206:1::28)
 by AM0PR0202MB3300.eurprd02.prod.outlook.com (2603:10a6:208:5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 13:07:46 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::2d) by AM5PR04CA0015.outlook.office365.com
 (2603:10a6:206:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Thu, 24 Sep 2020 13:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 13:07:46 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange01.KLS.zentral (172.20.10.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 15:07:45 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 15:07:45 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 15:07:44 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v5 2/2] tests/fetch: backslash support in file:// URIs
Date: Thu, 24 Sep 2020 15:07:19 +0200
Message-ID: <20200924130719.33118-2-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924130719.33118-1-leif.middelschulte@klsmartin.com>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
 <20200924130719.33118-1-leif.middelschulte@klsmartin.com>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 09:09:00
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2beba7-9152-4459-42cb-08d8608ad498
X-MS-TrafficTypeDiagnostic: AM0PR0202MB3300:
X-Microsoft-Antispam-PRVS: 
	<AM0PR0202MB3300E8AD5EA0C5DEE31DD3E499390@AM0PR0202MB3300.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1O48K04672WStYTa7132nCJ0aLTP+940Fgn5iCsQQPtpRWyO4K1TFNYxf3hqj3isAFEi8y9k8FXXucnxlp6R6uI102hQmAjB5KZn9GJ0R6Gf9FqPeI023sEKcSQyBYnCWmca0AOqFkgwafVQmZ6h7ZUiun332mkOZmuLE0drgbcKa/fZS5/XIGa7dFTpJ/NUChL/kNBEW/cDIgK1r+uC1mq9KOb75AB4BBXFjiEq18oDmth0zr/pvcc7SJNLwNX09UxaOiwaQGF1ZuEz8Zc7spUoW52XWBnIhCIpjQgeFyzOmPxCuMIe+OJ6puJ3v2eqUFXL2Exci07yEaf+FrBJxBSUJ8W83zE5BqxpyKM3AJ8spvOsh2kpFJNOjFX65PdWC4+udOC/4BYZ9noYlZc09l3GFu1xZau0gLOjdQKD5W6hy5DDV/YNqgmXP9ImCGSN
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(46966005)(26005)(356005)(186003)(86362001)(478600001)(4326008)(2616005)(82310400003)(33310700002)(6666004)(44832011)(316002)(36906005)(1076003)(107886003)(5660300002)(2906002)(82740400003)(16526019)(81166007)(6916009)(70206006)(70586007)(8936002)(47076004)(36756003)(336012)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 13:07:46.0648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2beba7-9152-4459-42cb-08d8608ad498
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3300
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Implements backslashes in local filenames.
A typical usecase for such a filename is a systemd unit.

Example: `dev-disk-by\x2dlabel-FOO.device`

Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
---
 lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0ecf044f..c078cd5b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -584,6 +584,7 @@ class FetcherLocalTest(FetcherTest):
         touch(os.path.join(self.localsrcdir, 'dir', 'd'))
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
+        touch(os.path.join(self.localsrcdir, r'backslash\x2dsystemd-unit.d=
evice'))
         self.d.setVar("FILESPATH", self.localsrcdir)
=20
     def fetchUnpack(self, uris):
@@ -601,6 +602,10 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
=20
+    def test_local_backslash(self):
+        tree =3D self.fetchUnpack([r'file://backslash\x2dsystemd-unit.devi=
ce'])
+        self.assertEqual(tree, [r'backslash\x2dsystemd-unit.device'])
+
     def test_local_wildcard(self):
         with self.assertRaises(bb.fetch2.ParameterError):
             tree =3D self.fetchUnpack(['file://a', 'file://dir/*'])
--=20
2.26.2

