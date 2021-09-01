Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.41])
 by mx.groups.io with SMTP id smtpd.web10.989.1630525508574205874
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 12:45:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector2-xilinx-onmicrosoft-com header.b=gkIMT/2M;
 spf=pass (domain: xilinx.com, ip: 40.107.212.41, mailfrom: vishalpa@xilinx.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS9cAN0peBvMlzg0AkKD89MzUTuHzQR5PVI8u/1L5qlEQgDlgrO/Ck6P10PHZR6cfZDSIp0U3rJSUj3CRmczupVqJFmZZPSB6/aKSgYjUNFp4x4O2QNM5x6FUwgoRALeBAb13Hed2eqVnfZvO6A7FtalpJv7JVfEWclKpCQ1MFFCR5FAP/SFChi1Ya4tamdGjeHo8Y+25k74bFigZTMl2zZlaTdamVwOS9VfxN8GNwrAUttJEISj8aHY+9KGcJAe0gKHdI+cV9t8SpdlMNmAlDcNyiKE5UW4ExLlDamTtt+ZHQ0XIOCa5kXo93G+ZnfgoV/6z+i/KLenUYEPbQJiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoR0FB7zWOWy0MZDEcmq5EXJsSdE6L99d8hPzJR3+YI=;
 b=RvpUxfxjwx8SCviiTTdida5pJQUHpE8s3q7MOcFEoXldrP7oK18gJMZUPKeP3/1hJOuT4KphGeApP76wsuIK6jR+zSD30tSatzlE4Pc6uXdM1ogwctQ8WU5/YOHyXmjWVC6szQnwTtu/x+oXOGhPOJSkm73L7uhm4ZgGhGgGMU/0Mp5Xt1zbk/ZMAFpwHxf/tTzY4rFsy3NL6EN2/cojUKRVVJvbqEPfFIhpw1VRnunuz2ngFx7exXNtnD84/CMtOSEj9NFEey4PtiL9RoGE5gw8ghd04cRT/lQuUXoHDp0iPi5pMlqoJ0Ee301pNxetgS2d/rGgiDMArFCVBN5Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoR0FB7zWOWy0MZDEcmq5EXJsSdE6L99d8hPzJR3+YI=;
 b=gkIMT/2MxGyXe5wn8qa0v5D9SQ6MF7Rfjp+5Oo3svJ32574xE0Exf/EcaeNnBr2AGq7EZ/IkfFau9eSkKuUxj/HLB2Z8GMOoJNfh3+EYV6kKv2nfzkz/QZNVbNKfkfsWgistN7MtFD2/BnPLMSDTZ9H8R4UkpLrEpP+ue+aBKGI=
Received: from DM5PR06CA0042.namprd06.prod.outlook.com (2603:10b6:3:5d::28) by
 CH2PR02MB6584.namprd02.prod.outlook.com (2603:10b6:610:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.24; Wed, 1 Sep 2021 19:45:06 +0000
Received: from DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::bc) by DM5PR06CA0042.outlook.office365.com
 (2603:10b6:3:5d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Wed, 1 Sep 2021 19:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT035.mail.protection.outlook.com (10.13.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 19:45:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 12:45:04 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 12:45:04 -0700
Return-Path: vishalpa@xilinx.com
Envelope-to: bitbake-devel@lists.openembedded.org
Received: from [172.19.2.60] (port=55656 helo=xsjvishalpa50.xilinx.com)
	by smtp.xilinx.com with esmtp (Exim 4.90)
	(envelope-from <vishal.patel@xilinx.com>)
	id 1mLWAR-000BYB-Un; Wed, 01 Sep 2021 12:45:03 -0700
From: "Vishal Patel" <vishal.patel@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <mark.hatle@xilinx.com>, Vishal Patel <vishal.patel@xilinx.com>
Subject: [PATCH 1/1] tests/fetch.py: Add test case to verify PREMIRROR with mix of remote and local
Date: Wed, 1 Sep 2021 12:44:56 -0700
Message-ID: <20210901194456.2642587-2-vishal.patel@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901194456.2642587-1-vishal.patel@xilinx.com>
References: <20210901194456.2642587-1-vishal.patel@xilinx.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9497fc-abf6-4410-7b5b-08d96d810005
X-MS-TrafficTypeDiagnostic: CH2PR02MB6584:
X-Microsoft-Antispam-PRVS: 
	<CH2PR02MB658409AE239AA5549F272D34AFCD9@CH2PR02MB6584.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ux6caAGVzTjlMajkzBT4l8Ii3oxN3rQEJ/3rkg1U6HBsxJS8wr+oXLVE41s3voLn06OwXgNhlR+0ks1UlR520l5yi1XUnOZTGPVtB7eHDiqX9FJH8PvE4UXhtdhL02LFxE8CUSEsps2zMqXkP7J7XnXRm6BjKbejAIwrjKQdYsyj0gezVPfM9NdNoJNw4QJy0KOAv7+xxgBbeLa/Ky9qzKaZ8W66SuKPkmB0x1hj+U6IO6obHu5Z6yrQFHq3FCx09dLTHp032Vyvsk8fW8GDFt6xcardWmuca2M3iqVAAm7XPH/pnCq6l2OMukTf3ulAgl263GU4tEE5X7nUEKE/Xnx+nt7+jQIzh4j0kGvbbvDQ70BMdmYJ7Fp3vwH561RSbaA+zny2Bxls8VCZy6IXed8wpXSX13LYf0pxB7B79ckN/MvJtloWo6MF2ff+hyk/TX0VjGrWYuZs8Lb32lk/WJlRoyBzpjOBaGVImco7lVGbciZ4FSqIdsTVcI6vZ1JhELFbOfjnTPBQQBnqK722ohzAIqbjlRfUF9to5NDTXG+/hYB6KUTbPyhuwWwHWBtYfvjLALYf7Cn7jaFmcW7xi9FvNCwLwhX+/eDYIA1q+DZe42sJkjRDPZ8cRXN81PzS4l0qPMNOypdX4JI7xNeJ/+N3euBOy+KkEmPlZk5oNIPTYURkCYR4/gSnyREGsoQLygqoj+1j3nKWvDDKX3a+DNM9GRiLBe4JAfgDzrxabLNE1d3EygzikO1+qMF/d4Hse+7Zg9GPzbX6LzSVAWNnsyjXXZPOalInJ9QvRSXcHtOvthwqCKkya+7fOiDCtt/OkfHFzDv/31v6xUzuxDsqJQ==
X-Forefront-Antispam-Report: 
	CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(7636003)(8676002)(7696005)(5660300002)(316002)(966005)(82310400003)(478600001)(54906003)(36906005)(9786002)(19273905006)(356005)(70206006)(70586007)(82740400003)(6916009)(15650500001)(6666004)(47076005)(36756003)(8936002)(36860700001)(426003)(4326008)(2906002)(2616005)(336012)(107886003)(83380400001)(1076003)(44832011)(26005)(186003)(102446001)(563064011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 19:45:06.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9497fc-abf6-4410-7b5b-08d96d810005
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6584
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

If the PREMIRROR lists both remote and local mirrors, and has BB_NO_NETWORK
enabled, it will fail on the first network attempt without falling back to
the local (file://) PREMIRROR.

Signed-off-by: Vishal Patel <vishal.patel@xilinx.com>
---
 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9291ce4a..559c678b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -823,6 +823,26 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))

+    def test_fetch_premirror(self):
+        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        os.mkdir(mirrordir)
+        # create the file in a mirror directory with correct hash
+        string =3D "this is a test file\n".encode("utf-8")
+        with open(os.path.join(mirrordir, "test-file.tar.gz"), "wb") as f:
+            f.write(string)
+        self.d.setVarFlag("SRC_URI", "sha256sum", "b6668cf8c46c7075e18215d=
922e7812ca082fa6cc34668d00a6c20aee4551fb6")
+        self.d.setVar("PREMIRRORS", "http://.*/.* file://%s/test-file.tar.=
gz" % mirrordir)
+        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
se/test-file.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/test-file.tar.gz")=
, 20)
+        bb.utils.remove(self.dldir, recurse=3DTrue)
+
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctopr=
oject.org/releases/bitbake \nhttp://.*/.* file://%s/test-file.tar.gz" % mir=
rordir)
+        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
se/test-file.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/test-file.tar.gz")=
, 20)
+
 class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch(self):
--
2.25.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
