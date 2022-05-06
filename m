Return-Path: <adriaan.schmidt@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE42C433F5
	for <webhook@archiver.kernel.org>; Fri,  6 May 2022 12:11:17 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web10.8560.1651839070658072223
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 May 2022 05:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=bEMX4+ZH;
 spf=pass (domain: siemens.com, ip: 40.107.8.57,
 mailfrom: adriaan.schmidt@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVIrJRz7DZeVVwH7RFXR5bu67JEeVs00O07SGRickXd01IYgTNrOI/BMi3zYNgihnoDrAr55z3xYaN4TYZaPhFnRjonAjwBPPDGjAYYXI0c6TA08bFTGrf+38ElISePg2B7m23IahRjFpUyUmxW3Zds/kJ4Ter56USGRsXmu2oG8t5wa+48DtnQRIGyBMJnGRynlfs6ttFHPGc+xLNX1k56hi1LaqfECtuZw4xhi8EEaBddireNmwlbl2/1361WpqvBBeEeXbMBriAZQIk5hZoyjGJ0OTn4vOg3qc5ZP/jHlYBOMnO8mAN4aDlfdxWTT0oGN/ZSM5U+iXZ+z54fzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxfSlMKVnlBZDtxFcWSw4LTn/X5zlHZAWGTkJuAoV9g=;
 b=ihNLRwPztHRKdEXX6jLuNbfsJFUYx9zyq2U5+Gzdh0ukcdYc6aC0GOI+e2++aGle4Dl86bN+fNOccaoyYDayjiS6XSV4Sfo7HMX64tVHpSc6FqE94twRiaRYTlEYuy7swZiLvPpjNSWp5YZWkQFoZKHYA4kI9oIbfheB3J137MoE7IGdVkmiqu9c4u1hCzNCgyQBJwZ8X/cwRtbAJCal7BYnVtxVnAK6CJpSuip/JoyPQUoe6imnZ96oBSx5J0k8lp7m+1h01C0k8DmOu+QJSYOMgbtCCmrd19gaYImA63MmbrN6ziQ1WST39u9XCNTAML1qVXy7oTN0pUROltRPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxfSlMKVnlBZDtxFcWSw4LTn/X5zlHZAWGTkJuAoV9g=;
 b=bEMX4+ZHx6xePSVkW4UQR6b2DTttArsbfTUyb3gOz5EmQwKfGWAwbsgFeRpSEBN0yWxZ0HKUocrF/PCo6PKaJAhnyVKRFmw0YI6GbCwjT5BKMqbgrGM+ZzqLZxzZ+EX/FxJMnSkHbF1l/qVzoF99bpzKa+YBQlGGg8y5lUkW5wBF9bj0xEuwvcXF4T1UDpYIwMXCCCrS9XpGqycsoeba4OXDCE9nl/TD6BLnDOzCzGUtF5581DINvOf+VRD973tPdqT8yM6dA7CsMsZCD5JPN79HkOZ43KV1rcsQUH4kBDJ9Ea087jUbiAe8wFjVlS8liLZdvBvfyAVoj9JMhJhAaw==
Received: from AS9PR06CA0288.eurprd06.prod.outlook.com (2603:10a6:20b:45a::19)
 by DB7PR10MB2171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 12:11:07 +0000
Received: from VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45a:cafe::b2) by AS9PR06CA0288.outlook.office365.com
 (2603:10a6:20b:45a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 6 May 2022 12:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT031.mail.protection.outlook.com (10.152.2.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 12:11:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 14:11:06 +0200
Received: from random.ppmd.siemens.net (139.25.68.25) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 14:11:06 +0200
From: Adriaan Schmidt <adriaan.schmidt@siemens.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Adriaan Schmidt <adriaan.schmidt@siemens.com>
Subject: [PATCH] bitbake-diffsigs: break on first dependent task difference
Date: Fri, 6 May 2022 14:10:33 +0200
Message-ID: <20220506121033.1212704-1-adriaan.schmidt@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [139.25.68.25]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.927600-8.000000
X-TMASE-MatchedRID: dh+U1xplaFOD48uwiopfRMYBHeGPZPw2LIdNqQECjaCYh7QjWI3JDCY6
	ALX8FNLOg62QWKBoZ9Rj8XzdqXhnXq3aC25avUua4yf6Jl3/aOQ5hou9z/6pqd+G9ND+fWcZAgv
	M6h73BtpncSzHLoRamctfdBL+08yffS0Ip2eEHnz3IzXlXlpamPoLR4+zsDTtgUicvJ4MChljG7
	WlrEHKY4Omoovoo/xux1BMjI72P3NKG3FTLtIr0noGAEEg4pV0
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.927600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 B83C0F112E00CE0CA701671560FA1005519040F2096DCAADDA47CB6852E3B18F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79cc73df-f127-4bed-68f6-08da2f597fb8
X-MS-TrafficTypeDiagnostic: DB7PR10MB2171:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB2171F17ED3BA319021E25477EDC59@DB7PR10MB2171.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xtSeAjt2ybUzGXr8pAJ486Tct6K0OHsG4Pb45iCF9E4nu2Ehq8oVlE2Hh6IStDqyMSyrL4HuFV9omsGn0cvfstXole3fPTCs6nT+h1PUR0aqKULmHyG+7Mo9UR8fsV2boMQnJcKLOfCWq81n62c1C554pmTt/SXBcpBtLfvh3ovbQZ9XcSBdTk0UjA6JGaqxhQ7CPVoj233QDZ5AjezUbApap7NI6iYkYoXavBPYJsTexva2da3mqbyRQI6tsBeUgUVy+kIRFBoqAPmeUhGkEhW/khyis1Ov2/KyIj8UMuDcwUVYuH8zgUSvUQuh/xpZcSIx/KXbWjM3CAHFmI9aKjCvo6tT5J9L+lhWVw1ju7sL1zEh45QVWzCkzBgwwPPj3chSlYKsndnS8iNyKmoWF/olqnFe39X/qirrBGBInzfw8K2cw2Ms/sNl+kb+xL7dvTE9FLFWmOft5TB4a9isACRvJ+bMHEDYFJPk9kchnjF8loe+bTCiLbL2pit5V+S0AXxsOl7hj+VSwhbU3JTZ+hrL0rPvz4qEGF3fDV+Oj4syuIWEAv52Oxmhgr50dYlShLuIdAY+SqrktDrKu22WdAUqAsfwMx9UK/BQ16Sh1hEE+wkA9Xs0pT9pUymtWTIZIhQaeeOh8eNnwabaqL4Md+MV7DDDcUnnoDSh7waQI19+KmM09+T5ZT1GAZRb332S37+tDT7D/m+zgLdALu3jaw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(508600001)(6666004)(2616005)(26005)(4326008)(36756003)(1076003)(83380400001)(16526019)(186003)(36860700001)(107886003)(336012)(47076005)(86362001)(356005)(82960400001)(40460700003)(81166007)(82310400005)(316002)(5660300002)(70586007)(70206006)(8676002)(956004)(2906002)(6916009)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 12:11:06.7108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 79cc73df-f127-4bed-68f6-08da2f597fb8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2171
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 May 2022 12:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13673

compare_sigfiles() recursively calculates differences on all dependent
tasks with changed hashes. This is done in arbitrary/alphabetical order, an=
d
only the last of those results is returned, while everything else is discar=
ded.

This changes the behavior to instead return the first difference and not ca=
lculate
any more, which significantly speeds up diffs of tasks with many dependenci=
es.

Signed-off-by: Adriaan Schmidt <adriaan.schmidt@siemens.com>
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 9fa568f6..08eca786 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1026,6 +1026,7 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=3D=
False, collapsed=3DFalse):
                             # If a dependent hash changed, might as well p=
rint the line above and then defer to the changes in
                             # that hash since in all likelyhood, they're t=
he same changes this task also saw.
                             output =3D [output[-1]] + recout
+                            break
=20
     a_taint =3D a_data.get('taint', None)
     b_taint =3D b_data.get('taint', None)
--=20
2.30.2


