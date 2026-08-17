Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE684C5DF66
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 19:51:28 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3444.1786996288694961394
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 12:51:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=WvQV8KKD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.201.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qETEILFkbBelB+LipWpkw2yr2pSdCyfggniAkB7jp54VsdE2GkC3LsWUwvxoyf8+mCKsllm7byV3EQRVlXHXRY/wxBCrxTf4NunGANj01TysknMLR2h4zshrU6JD1KLvGa8NSc6ytfHU+EhK9RHDC0PRF6RTS1EkGrvnc2S5sQtlgg4Q3fD6mOulA2R1FG+jBBz7Q/pky6xHjuhonKSuGCSuc/MImN+ONOPVIlO/Ciqgp0szZYigSf6W9rV3P+7JoPk4BHF2HAVOqYxwZKZjDSb/5q55zZsLZKD2TqBu4P43PCLbtusnG3t5C3qZt5qGoVmdI+WP8zqCpeDMo28jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5uO5vjB2sBtT7uYfp+mRR3E4mZzLslD02RtR9UBm9s=;
 b=oMjN/kYp+tTF0dKVCelSLk+IxJlTjELNeRPFGbnxXIvGjP8Ryv2GM/nC4FJskLpE5jgrgZFr/oOU1RSAJrPP8KbSGE2OFSxtVyEJb0BU30rUFGQ8XNvbd+RPJ3XeKbk8pNVsLy8CrzeqEyn/pAYZ95BmlpNaHRvgRIzQHr6guJFE0XwDuqbeSaMt6NbLWC+/NPyebi5SkmTHgs063w1/OkCV0PffA188fH3HPaXMrEkiuQQ6W9K7bX+SOUVp7vHDy2CxI7HJsPSG6xi9hUuW3YynbzIEpKAGYLXJVlDJuq3AXpcQ7SZ5sRkw4gGKita4DwY/PY8G4dmqO+gIZcUgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5uO5vjB2sBtT7uYfp+mRR3E4mZzLslD02RtR9UBm9s=;
 b=WvQV8KKDcDvUdOhuAY7df8xNPIYytNFW81vlr1xnT2UcitSV1qRQedHY6aOBSz6lCi2bUYdCnqX/FGsWxXxZ3cLlpPDpUSnLMvneHwIuVwQqlKAVOaYSgt4AgdNidwgcGjMLRtJCRy+AqQn8iioF7TO0uH55NdYK2e13nCOyedtNy6YLr/wp+NoNCnJ3wEAahMT/WgNCqe2wtDFYtmiYH0G4Zr8PQFnpv6MVl4CYZBWfYw5FyYonbuXkyBVBtRcQ+550tBw68YY8P1qswq++mQ7biezaQe6wcqb+vw2KJY4yg5QfWqlsxGO7GFklQyKv7aOd4v9tm/jZ/X+QmOPIuA==
Received: from CYZPR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:8a::11)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:51:21 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::8) by CYZPR10CA0005.outlook.office365.com
 (2603:10b6:930:8a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 19:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 19:51:21 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 17 Aug 2026 13:51:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <svsvenss@cisco.com>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] fetch2: get rid of unused FetchMethod.urls property
Date: Mon, 17 Aug 2026 15:50:56 -0400
Message-ID: <20260817195057.2485364-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac92897-4cc7-47d8-d0ce-08defc98e9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	V8G2Q7vzmc/SqkslYjR9FjshNqWm7iAvG105/uUyx1vRq0nEUWjpdxcJLZF4dkys4RB851i2xKacCk2Bq4MXt/ix6v6UYvYL7S4deUi3os/BXociiYAydMXN2HZS4AdNLFTOaPbPhYkNrLIv5wq/lhtWTbcsnXPOYWoV2biSMVTmHnH/Ndi/vpvQeWxiAX/EtEo/N6nHB76TaWFGXinmJrVxMBjNxifDGw9OF4Q1RnRw3cG7MUWFp+pU5Qq+zDkvPsj6koPs7hAeKUMQ7K/dQI53psC+btT31bOmyIT7r0djYWcAwVBBFCXStbyfuG2/G8apuSGtxn3Oje4t1FmcvOkUGnYmiq/5ujNyKF6KI7ijayfccBAGnIZKFdGdOIpCJXntIwCXnkdpK35hT9aFoR91x30L9STCegSqjSA+25UJ6pshOgYdrWl2D9YW6pbxylDzC538daEM2wg0oX34h+2k9u6tnpOgSkJsaRTTsACSHbRc6yjoWPGw4qn9DeTt6Jn0JA8BPfuSqpJ3VXtQlrKhtZGOs/U72Gz+RsyL/3R8YC/hwcLA2a1Er7OUaU6WtCF8H3ggmmcH601NfJrOpYNTxKnvsKQb/HRY+o2vDDg59T+SXRj2tcx6P3gx0Cm1nMPjjy628k+FegDxwZVvbc3jA+PxsePRlT4q5QPWWeHF3U3iqIbjTdtEgTwowbzV
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hcMGt3WmINhvkPTTGujSGW5vDjyxec12gMVCF3QP7mU5SF2/SnexmiTlvJz/JyzZ3qCi3de/PZrKFAD7xEZqzBwtZCXF6gFdeGRkYcKIbLXHs8QvZ328nMJ5wxDMCTITQxiVY/ZTg3Ngeo5XfnBCuT+JyZVltxEimS7XmqtDqWj8teYFJ3SrL4BN4Xemrpu4rpzBei2PMQ+FfsBsic3xC4VAkpjzXetUdsQ+e3vmKeWk7+jjHVAMoFs6ef/ZN3xuRLwFTMKPR9mA+8ijtppt4Gau+BUZE2O2qaVJTHJP3bw9NI+GKXpoJ6OkXjhhE5d6scElaFuCaPmCcMD4jaK7BDSs/eOrIOP9iTdRhYqpNTZu4v3Ajvi4gURAa3OzNgQNRdGkXSFOIBy1MaPAKycarWAMRY2D3SRnjab5xLSwsDv4/nbtN+iAlQCi4cASpFJj
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:51:21.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac92897-4cc7-47d8-d0ce-08defc98e9a0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 19:51:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19976

From: Chris Laplante <chris.laplante@agilent.com>

It was never set by __init__ anyway.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/__init__.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b6006fa38..4a3119ad0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1438,9 +1438,6 @@ class FetchData(object):
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
=20
-    def __init__(self, urls=3DNone):
-        self.urls =3D []
-
     def supports(self, urldata, d):
         """
         Check to see if this fetch class supports a given url.
@@ -1501,14 +1498,6 @@ class FetchMethod(object):
             relpath =3D relpath[1:]
         return relpath
=20
-    def setUrls(self, urls):
-        self.__urls =3D urls
-
-    def getUrls(self):
-        return self.__urls
-
-    urls =3D property(getUrls, setUrls, None, "Urls property")
-
     def need_update(self, ud, d):
         """
         Force a fetch, even if localpath exists?
--=20
2.43.0


