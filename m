Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.98])
 by mx.groups.io with SMTP id smtpd.web10.14301.1600946169497682436
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 04:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=U1PMIhM7;
 spf=pass (domain: klsmartin.com, ip: 40.107.22.98, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhdAedB608ISP7hyGToLxAN/Qzh+Ld+l5BaCRBfbofREYI8f2Y8x8oaB+kNLl3sOkGq1gdr5YDPrLoEcbsx0lBNVij37zzeJsuF9EA1DjOfaGPELq1r+ieh2kCSKO4iKQQNhmyDvaI9dKuM9VHZHY1h/pIQqUzSFZqDM5jTRux77lrLSJomC6CVXxsZcrx0aYgQLJhOqCj1usbuonSqD01Dqc3W19SWLjWbZC8EHNZrdkj7GTsCmpp7R0kubBPrczUs03JQJy9V7n0T82yPCxoulIepy+9pfuF4S4uhV7VZz6kphdmrp8Ng8srgmy3Wr43PKNVMAD4XSxAm5lMU3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc6umPPr5YdktTYj4djjxIQOCzThIWyeLPsP6cuFPIE=;
 b=ZQTsLbrPSPUxU3KyExy3pup2szE9nVHu97zlJTsQWF3xe3u8U3jzf/H0CR4AgTVdnPerqa7SI5K9nJjKVvAhDPcLixMPI9kcBuIFPru9g1R2E5DOa41JLD+yQOyuQBsj3EP0/4fH11wYJfJgIaoEN+Do+uz90mjoWCztP4yIUW5tVNWB6zAOC6hLi206RhrRNHemKEt9YZsTcDv+/eGvF81Pqp8iL/rBHpdC2Aozs9j2078/sNlZZNy98r6GJ/AqGQ1YpN6blw5bUQNGO9q106BPZaiVkBKxlBf9Vfgx53FgJq3t6yMomsCcIg0vA0XCv2Qi+VvbatiXji3ygFPWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc6umPPr5YdktTYj4djjxIQOCzThIWyeLPsP6cuFPIE=;
 b=U1PMIhM7TfFsWm2ZHz0g9hAtThzNXB1+r07AalIqHp0It6JqW8qLnzxtULVL7r4Ffvqm0PsTsgga4nJ3MBg7KTqNZmpgPTgiiVHefyA1usJcymFKhJ4NlixpBISzzFmgbgVlNEz8faiss3SkPd490ksQuxxNKtj9Rqxo5BUnINdt08EiNI4aa7sJ4BV/OWonjfBJ+zNm7evjAhtMSpaUOgXK0T4nBhjXc1c2sENAlsjTqtHhFt+6E8klsxH9J2gJ9WVarAHdD1/8ST1QUn1VWXftkkHcAtvH2BEzHB9yPJ0mJX9R803BhPVWQ9LjDY0wYEZh1ixgooYALOVXh/IPdQ==
Received: from DB6PR0802CA0035.eurprd08.prod.outlook.com (2603:10a6:4:a3::21)
 by DB6PR02MB3174.eurprd02.prod.outlook.com (2603:10a6:6:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 11:16:06 +0000
Received: from DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::ad) by DB6PR0802CA0035.outlook.office365.com
 (2603:10a6:4:a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Thu, 24 Sep 2020 11:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT052.mail.protection.outlook.com (10.152.5.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 11:16:06 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 13:16:05 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 13:16:05 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 13:16:04 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH v4 2/2] tests/fetch: backslash support in file:// URIs
Date: Thu, 24 Sep 2020 13:14:12 +0200
Message-ID: <20200924111411.21590-3-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 09:09:00
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25d3ded2-d677-4c6b-3645-08d8607b3b1a
X-MS-TrafficTypeDiagnostic: DB6PR02MB3174:
X-Microsoft-Antispam-PRVS: 
	<DB6PR02MB3174C59A1F4E9EC5D197246A99390@DB6PR02MB3174.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lU7wthHbFDfxuj8LNS+yGJ3AGWoaPK7f5g0ivo4brJYedErxmpg6u5g8TgNETopUqxWdK5R4Hei/9n1jUGYZ6lrlz4Z2ADv/R5UCS4ZBNTsD8cucYmT3k0VDzKAZFMNLKKgj3sW8t1JyRgQEg9yucd0Ryd+/ZWPgEqSvNChyJfI6cw+UtN6e1Qjm+yQ+DKwWU74S4AD32CJ9xXI9LpYs+lEvTauF/veJABJruIRglA0R+CfQY+no9h259mzFVSoF05cJNSZhVJlyKSRIi76t4F1RczssX6lV9uy07keJ/aqSqLdFws9/dut7fBk0cBxYWbVbxyQFtL7nsIrgmRTPU03qZwFOB6VrvLKn3EdW+L6J6Gv8Pj8XjuiDaZ6MYkMNKJx9E0M00opYfA3DdgMjd6bn1cd6wsPfYWWPBGaJPVQgqis2VSYE2szDPlkmkyFofXMyFNSgTnl+S/MRYJkfugfjagKrx2jGnTz42gSFR/w=
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(46966005)(4326008)(16526019)(6666004)(186003)(316002)(336012)(5660300002)(44832011)(36906005)(478600001)(2616005)(82310400003)(70586007)(356005)(33310700002)(2906002)(70206006)(26005)(86362001)(81166007)(6916009)(47076004)(1076003)(82740400003)(107886003)(36756003)(8936002)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:16:06.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d3ded2-d677-4c6b-3645-08d8607b3b1a
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3174
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
index 0ecf044f..9030d6d9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -584,6 +584,7 @@ class FetcherLocalTest(FetcherTest):
         touch(os.path.join(self.localsrcdir, 'dir', 'd'))
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
+        touch(os.path.join(self.localsrcdir, 'backslash\\x2dsystemd-unit.d=
evice'))
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

