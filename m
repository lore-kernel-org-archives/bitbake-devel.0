Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5FC61DC6
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:46 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30858.1787687199552187211
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=1Eb9PRw2;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.52, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZfBmdHtkHYEJKmw+nojdcMl8+nLiPOG8FcKvjKPLVGiAiwVh9mduNkTH2rONpcG8GHnOtrdv9Tq0Ur7YXk5I6qk+PQ8v8YCyPGHePAADTdTVTahe8W2mPScinDFrJIwEojcNKnwl27BtnOwEFxeO62feroFojwrw/Bm04NdWFZBZYq2XBpIDpQQaxrHHiG88s0nCbLz8EtGxgIw5tQdhRJ7GV8zOeb1AyxlCRTGFUsgyczmhg8a7ENJHaXLzNgm1pmLd5Die5gdSi/dD3OHvIgZzR76+2fmDgEhGBr4Qjbtv5HkTDiFjHMwVB/RF2uJwmXDNxyUqx6ykEpDFSuC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRe+7Nlgj+dmx6VcVFICGKsThsJMlyQIQGF7SRNYrAw=;
 b=LpUkZZUqQgHlpDlPQP4/BJhGyjOfetbc4QUMyO9A0Cm/6OaMkqBt5hLD1Pc5h8xGzHJhW//lf53jfKDbsncUzq4MjfRZLeYKr9bGTlg0MYadd/BDEoKQf7JWHTYVEz6fLFQAtjEgICzzal1TqxA85v5Kmxmedzd5L85H6LOVxXRRzuhz2qrApHdy2v0eOQX5SZhK2k/RPTf9q9AQuClyTri6iKiZVweGnZ1z/foSs+bOSeBTNzjL5WcUK3xpm+r29cpObE8GdBO2rDkvGYJJokCH+TqmzH12keXeURomH8P4KoZ6qzpGXU23ndMP/0x3FE+8Hcw3XCxCPqP1RiEDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRe+7Nlgj+dmx6VcVFICGKsThsJMlyQIQGF7SRNYrAw=;
 b=1Eb9PRw2Uzw/0AjA3FPmXG/QKY2jwli2XzDhWYWa4cgNoWPAa0n4rh2izah8SasPuhYW9n8VAgyYBG47d3xlv5AMaDbDoPBMMQ1wssk89SuolZk5ceEwbD6UkG4JrV4ULXk/Lru5J0lbcCGIMkQtEBYXSQAmdNeqQ+Kg+27JZEsolsaYPv784YsIXPrkq/0RHUYDGsvbL7jM9NuKVR/zQDqIa8BmGDcYTusecsJ5sj+6EvC8EDBNb3oJtTS7o2YmAcuEDA7M303TzyWLg5iPFBjtnHE8A0QO3W3d8fR4nY7yoV8MTssXYSqCVwMh0sADlDcQHL5glCCYIUS1SmhrVw==
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 19:46:28 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::73) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 19:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:57 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/6] data_smart: use Pattern.search instead of findall, to match comment
Date: Tue, 25 Aug 2026 15:45:44 -0400
Message-ID: <20260825194549.152553-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d457fdc-aa4f-44dd-0942-08df02e18df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ot7qT/36wN6ueXz96hCoag04gDViiRwn+VytBoKQOTmmtQWoqrpPnG20AQhOiJTEZEGic/yl/cAGTpOvo0fZ2r9Fk7unxcuhaz/tcm9zdqsBUexkfMkeKPTOWt9Wokl79U8lzvq3LR2b9thuzU7bMYYswMSt+ufoTAYaWP15vbVtDAxBlBjxt5J71QQZT3yb2btCET3BgipdBlaOHXfhf0frn271EwN8YuQ6JN5PM10+HN26dVJFEh++88T+L9o04BUypZI/HZn5YhITpJz8uC7UE75lCYcD78Rj6YZ++QN5WNEfOCXqKJLk6Nf3TftroTPw+s3k8877i7lM3Nii1PCPLtd7pk+BdzcAD7bnhzLL4ttixdS5iazkwrHn5fhQ3H37AY0m9PNykacvYpfN2Kcky9grzfHpd2TDNucAmmH2z74Y5pDyFcF/P9XbxY0ts6LzMHgx1BWVo7aVb7mLEmHc94D3iJyKJ7cvHW2bXNqMdxo1aWRtbLORZgHRZrLMI5omb5WHoPWIYePWAPXjA3leCVd24Zhs5CRwygqxvKMSvqbl5HM8xVS5+6MCNqbfoWjrjmZy9Pn1ENHNcjHoAlDKvdRmb2bbvj/isAMY/M6XEP6gwyJObvfdqguOGtS4yiSgVDL+m4etMw/ROfUtsB4kMOBFGcguA1HJT5+0YfDO8M6wyjmysPeRFP2Wp1Ob7LYCzBFDCiMWoZuOXkf8Ww==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9Ix9svQvU5g/pQl7b61bdwgLuYzprwi6H8qALWpdDJj6TeP5IziAhjo6EjOC9O+Z4/7KyX4Uhwy2j7WFFKiKga6Bo+Fd80Ck9AXFX4h20sTGaqMpqV+QE8MtWCd68xGUUHDgqY0n45kerR9ItXlaSmry+OMetFp0nqNbRH+bJE8pROyzewi6mNheIhPYlebPaQsFOOEsk0cvkrB+8nVVH9eUZJHcHQ2FoDq370aS4p+5+UZJr/un7aoRkRAiho4XvjnXB8ks05cnnwVUGqMlnq5xOtKBZdsnFYXyQbFNUL86wubj9EZxJhru4qSUkTbsM7AoLT72PbPDnidTehs6WyfOSdTDyTQvur49eQ7cCCxFGxdknnFj5sVG2c3HrhjrScQiVq9GRlCscBvffT/zlKwmuJ0dDe0f6Yz69rHOe40Zm8AflpxF1Q/tkc3U/EPm
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:28.1777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d457fdc-aa4f-44dd-0942-08df02e18df3
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20046

From: Chris Laplante <chris.laplante@agilent.com>

The comment says "Do not run code that contains one or more unexpanded
variables", so just stop when we find one rather than look for all.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index cbace8520..8aa7c1f99 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -126,7 +126,7 @@ class VariableParse:
=20
         # Do not run code that contains one or more unexpanded variables
         # instead return the code with the characters we removed put back
-        if __expand_var_regexp__.findall(code):
+        if __expand_var_regexp__.search(code):
             return "${@" + code + "}"
=20
         if self.varname:
--=20
2.43.0


