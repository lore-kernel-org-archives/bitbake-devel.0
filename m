Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D55CAC592
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 21:19:47 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.2])
 by mx.groups.io with SMTP id smtpd.web10.7463.1758057584996063867
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 14:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=LmaZMO4S;
 spf=pass (domain: axis.com, ip: 40.107.159.2, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6KLlCeSlzSNpihQKcth+PI3w73UuYy8jkRTySRZrnCXDgDI2b60A1JP2zjaLNQek0kFW2Mm5DoxlHxzsMGqhWov0EDKjxMDFruIYDL4ApK3JWp45S5TkExcn1Zn7LyAb874ldGR8WEorFyQhBSNqdzl9w1cyhYB2B9DjEa1KT76tTUWyJUJyWebMBw8in6udIHgxXPY+8idtiyWZwvhkhUW6inInVUOwmtyPWdwJ4KXJKjdB05SCRuCrjfqA6NLK3L57Mbglu/aE29CUNJrZlBWnYE9JS4W6bnJgeACKfuBApq50Wx06rJ5NtSXyKGwj9FWUwkekde3jFqRRq/plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap09tiQuDISk6nfA+dtbuknZbSmsxTXRstpHsKdft8s=;
 b=fZ9QQqoCr0hGDQYWgwUMygN2NWNs/lwqbxJH/Q7hWXIMd/cfCRimyiW+RdxMe0I8fAJ3cWDHyPNhFXvBvpi6p5xGfY0IpLJoeGI2er65N56xpL8yAxKhewXLrBw8hf6sTPpnxd1ENDsfa5g/G+xfSgGglqErYwNuF2yIrrwasrwT2G1WgwLmURfpjsGNfZynGzStKlitiCJ3LZsFx3s37iIDzBxXH27ZBXPCZS8UFSYMVdURqAn7nvOPla87e+MZyNBPV/pXQVva0BwJiNfh3gtGLMWTsytE6id7MZJYjbZBR5qVXc7hjsz7H+5ErEEvtoDlRF/0t1ve0WmefnWXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap09tiQuDISk6nfA+dtbuknZbSmsxTXRstpHsKdft8s=;
 b=LmaZMO4SdfFnapf6U+pvHwicELPCZcUt3SPF61cIm+I5WGvZsOY0RzzzQxUDGXlJy93UrdHGT+plnZ9MVn/LKHWC1EXx7SUMIieZyFDoilnxiHiKeirrQ95S1HZjVyOY68cm1DPerXmHrnl4TsM2YxlzOFhLo41naRSv9nZ3mEk=
Received: from AM4PR0302CA0035.eurprd03.prod.outlook.com (2603:10a6:205:2::48)
 by AS2PR02MB9389.eurprd02.prod.outlook.com (2603:10a6:20b:59f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 16 Sep
 2025 21:19:39 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::a0) by AM4PR0302CA0035.outlook.office365.com
 (2603:10a6:205:2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 21:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:19:39 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 158D122AD
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 23:19:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 7C41812024B; Tue, 16 Sep 2025 23:19:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 3/5] tests/parse: Add tests for include, require and include_all
Date: Tue, 16 Sep 2025 23:19:32 +0200
Message-ID: <20250916211934.253650-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916211934.253650-1-pkj@axis.com>
References: <20250916211934.253650-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AS2PR02MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 160d9be2-eade-4af9-a0b0-08ddf566beed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bvuPO2kMll8oFBpCeGU+Q9KJBJgNLMdyqxuVXioCAh82chDTh52yjRDLESD2?=
 =?us-ascii?Q?p94CXjf754AezhV7RuE/AZ63AJX/BGJBZBsZRYHQu4hB2ETv8bzrSd01o3xv?=
 =?us-ascii?Q?u1FvZU48NDq1d+Fj8GCN4zDownrk/7v/QD+9i8R70CSFvCzfqn53CPwnzwYs?=
 =?us-ascii?Q?P4ptFPGLaUmUX5/g0/m+8jzAx+rlepeYYkeM9IeFkZro52AIX/ERB6UyGuFU?=
 =?us-ascii?Q?42Y2PU5nKxLxiPig+fG+u2uQKX0CxVFMMdih5VRLaYQ1DoCUj32sCLHxmCz6?=
 =?us-ascii?Q?uZEWp54O27xf21ohnBELp3av0trs4nyi9G1dB6GY7C70vMS+n3jZIrxuiXs1?=
 =?us-ascii?Q?OdGr6XGgEUNEgCZs7Feq96R4EyptbSDTf6wT2RVca9Syuh1gYyHbhuWs1puV?=
 =?us-ascii?Q?qUD5RRtfk7ZZyfCIV4XcDoBqNVyK+1ATZ3zUY697hRJ5omfqcf3WWPLEcl55?=
 =?us-ascii?Q?IkZ0yr40al6xQfjF0nOozw6jiu18SoedqNH/cOx917IDRBA81yivDuF49SMj?=
 =?us-ascii?Q?lDSo8KJuWe1fC8jLQw5YkyXl6eAw6I2P+dy/kLwfuVOMtXnMkHIXqRFsOkDo?=
 =?us-ascii?Q?EbaUOPbYbfOQZUHQCF+w3f9IE1A046rN0CLzDU/VgRsIIrXAR2h8A63fZlCN?=
 =?us-ascii?Q?863pd7vbgUQerZ5BTsDC6wO1Piwuq8JEFjoRBRoKLXD7y1jjd5BX3/n1M1Jj?=
 =?us-ascii?Q?yCccLRpSaySDo5go8APAA4iixaKnOydBZEraWL9jTGWmbVtIO9uUFNPZCPkE?=
 =?us-ascii?Q?tfMpuDuy7yYVQyGRBOftgJhrxN098udu0v9Lkg1xweHimcypb+mbGYxaDV3G?=
 =?us-ascii?Q?RY3colvuYmwW7VKlgFGoa/yebisMSEVCDLyKNLnoThGwJy4O67nsLNiSWEcv?=
 =?us-ascii?Q?PTOnc/pg1Tm55VB4YfXtqwq5H+MJ2XIx0DgXC/dnlJ4jcGxfEt9R1ZF4xa8b?=
 =?us-ascii?Q?yJ9+vfQc7NlUnxqewwRHynQQ04y8HWFB/i//Y96J2OCQ8eanPjG3XxOuO3KH?=
 =?us-ascii?Q?12IupJ1z9pf9Oq7UTxn8aOHtpTCgwf7mtPZtBMybmGi8HpcVPXu3h1TUJZG0?=
 =?us-ascii?Q?BeQqJeUg8PnECXp/f6XMI3YDEWRjn8DqRHpapzhx1dXwQsqEjv4clIcIiVFH?=
 =?us-ascii?Q?RoZhsHxmk/ZZ3EoYf9vcOQQLet/Q7YromdMUUBhKugZkavWvBWKKWV9StCWH?=
 =?us-ascii?Q?veDk7q8CryUZXsiH6jRJYq7mQEBg7DAMYamXB6DC36NYf6IBIVFkIoXbQEtD?=
 =?us-ascii?Q?vGyb1mzpS0zvd46GkmzxNOqrbNH+PBkNMNEP4OctucpBb4T/Mu2zfn5zMUst?=
 =?us-ascii?Q?zuWPAC/4X89WGKNNdCBMCI3PxsBwVsx5BNbMdVKRYBRNX/rrKSHXcY+27oS9?=
 =?us-ascii?Q?R8KnROLkld7hVRP8I86Il2pydAg+Aj6GIXeQv0piFQ6s6VKeOsSIxEpl4Tir?=
 =?us-ascii?Q?MIbiaPOmJpjXB+LNuftzXWxVnb8ByYk4lr182Sz7uDLUWMqrYD50SOvAAvvI?=
 =?us-ascii?Q?puYzm+dJZoa7JeHR5YEMvOCbxodM1VNlWGrQ?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:19:39.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160d9be2-eade-4af9-a0b0-08ddf566beed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9389
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 21:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18045

Simple tests for various ways to include and require configuration
files.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No change.

 bitbake/lib/bb/tests/parse.py | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 431b0c7d3e..d3867ece98 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -448,3 +448,63 @@ A+ =3D "b"
             with self.assertRaises(bb.parse.ParseError) as error:
                 bb.parse.handle(f.name, self.d)
         self.assertIn("Empty variable name in assignment", str(error.excep=
tion))
+
+    someconf1 =3D """
+EXTRA_OECONF:append =3D " foo"
+"""
+
+    someconf2 =3D """
+EXTRA_OECONF:append =3D " bar"
+"""
+
+    someconf3 =3D """
+EXTRA_OECONF:append =3D " foobar"
+"""
+
+    def test_include_and_require(self):
+        def test_helper(content, result):
+            with self.parsehelper(content) as f:
+                if isinstance(result, type) and issubclass(result, Excepti=
on):
+                    with self.assertRaises(result):
+                        d =3D bb.parse.handle(f.name, bb.data.createCopy(s=
elf.d))['']
+                else:
+                    d =3D bb.parse.handle(f.name, bb.data.createCopy(self.=
d))['']
+                    self.assertEqual(d.getVar("EXTRA_OECONF"), result)
+
+        with tempfile.TemporaryDirectory() as tempdir:
+            os.makedirs(tempdir + "/conf1")
+            os.makedirs(tempdir + "/conf2")
+
+            with open(tempdir + "/conf1/some.conf", "w") as f:
+                f.write(self.someconf1)
+            with open(tempdir + "/conf2/some.conf", "w") as f:
+                f.write(self.someconf2)
+            with open(tempdir + "/conf2/some3.conf", "w") as f:
+                f.write(self.someconf3)
+
+            self.d.setVar("BBPATH", tempdir + "/conf1" + ":" + tempdir + "=
/conf2")
+
+            test_helper("include some.conf", " foo")
+            test_helper("include someother.conf", None)
+            test_helper("include some3.conf", " foobar")
+            test_helper("include ${@''}", None)
+            test_helper("include " + tempdir + "/conf2/some.conf", " bar")
+
+            test_helper("require some.conf", " foo")
+            test_helper("require someother.conf", bb.parse.ParseError)
+            test_helper("require some3.conf", " foobar")
+            test_helper("require ${@''}", None)
+            test_helper("require " + tempdir + "/conf2/some.conf", " bar")
+
+            test_helper("include_all some.conf", " foo bar")
+            test_helper("include_all someother.conf", None)
+            test_helper("include_all some3.conf", " foobar")
+
+            self.d.setVar("BBPATH", tempdir + "/conf2" + ":" + tempdir + "=
/conf1")
+
+            test_helper("include some.conf", " bar")
+            test_helper("include some3.conf", " foobar")
+            test_helper("require some.conf", " bar")
+            test_helper("require some3.conf", " foobar")
+            test_helper("include_all some.conf", " bar foo")
+            test_helper("include_all some3.conf", " foobar")

