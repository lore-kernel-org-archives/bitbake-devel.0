Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAFC61DC2
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:46 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30466.1787687198731933105
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=SZqE24uA;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.56.0, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+z/Q7i8OwMCMzwnkADPSPt0prgX0YXhhoC+HKlpLpSFupYppEiLtkzc9Spwz/giw5esriK1q1Gw/XBmvP/+tqs4VhvWWAYmZ/ETd8iFnU6Rob+47L/zDM6aEMsnS4/rIotbop9wiLxQMI9AAN6UgzT66eERnt+b4cLFOd+hmjgO+1ZJ4bLT+5ZiI/LWuGGp7wur8z5nt8VXGSxC8BSgUUgE8lXQCwR190GAIY5xcIsJk4HLbbZqa/3ZP1+Bp6kWiWqve9yHVY4jR7GgdpvEW8LpLkhwZZZfq3M8tqWy37rYn+wRY4FgdoSpj9BXAU/z05dY+wof6mo9oFyOwiyRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUWEk7DzVjp3P2MjTAVPnmVSg0c70Wzxo7LxKXIEC+I=;
 b=uEEOTRxH6yMZzS4oFnEFsPGOAeWzkCeDYpoT5j8Yr/exhfKukhx3dwenYs3XweMyTrkYrxNJyvTMfGChxew6dll2nyZUfoScmLbOsveeingrYGL0d5IIB/4erBi0HV1PPrqZH/nlA6JxNLdI8aPoxXx6uYBrJZSD5K2H3+Fz0Og6F4JUSvwyq8Bi5XSfOLOldI5wxKYf758TsfMNIO04OXIc/X+nIm0/sszUSBOjnwql+/bHBN4qpcLMxjtz/6APHJi77PsOzXctjnPCEHcXbvWw77WderEvYjGmmWEgmFJHO6L/YHU7hbBrvTH1+6uBHDfBjEw3bMTr02RkEZP5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUWEk7DzVjp3P2MjTAVPnmVSg0c70Wzxo7LxKXIEC+I=;
 b=SZqE24uAC8wWVNY9i715HcBogKu95nQCa3E93GCoqwj4s8GS/tuBTVFzY3DTKJXfyhk9rBHEAKYrMEwhDAFKR4VRGs3Tsgge9bX2uFeijGEafCPEfr1wvhplvKquuECRxsVCKuknUVYlyFCnvjiKayKcU1orS++/b/H8ukpokpctXJfvJ4GSP63aSFDgaGKwCWKoPSkd/6ZoIRLCK0WwlXNIq0tp1HmHdq+D3tIl+YHlTu3qoHkKEQf1Theg6Tnp9VWCxNfj7kIg39Kn/LavHGTa6SS3b22WBw/B6U9PQKMzzKyCaGQj4fLbp4gT865MTAMmK+jCBQ8l+aEGP355QA==
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 25 Aug
 2026 19:46:33 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 19:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:33 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:59 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 5/6] __init__.py: add missing import bb.event
Date: Tue, 25 Aug 2026 15:45:48 -0400
Message-ID: <20260825194549.152553-5-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825194549.152553-1-chris.laplante@agilent.com>
References: <20260825194549.152553-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: a722f5af-0729-4ba1-f47e-08df02e19137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|10067099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 
	8BvuLpjAljOh+HdZtveB5wOpQyxgx87zvWI5Rh2wxY+DDMXB+bO9rCrcgqb650S24MnxajSqCdvT3owxetqBHxLDL61iIFtbJiaNTBDA7Acq1TlVLhHFxSbVEM5yqEwPEvPYA7zqTj0Io1YaIAL4R17GSogc11AoI26auWIbGIzh74g8CckLcZr79Kvox9pLsGGplB6Edfbp0TLyW8gro4ppXvYwEjU+wryusJL3hva++Y3fFK52HbGbb5cft9FXDfffJcmEvexwLUly0CsS4z8pYA5TrItik8sYXvrTrvdZfX5GeHAAcqCJuVKMLyDhv3d/gq1dGpSE3j1FFYlLklT5QkslaImRJ4XFQesvSNnZZ1aMJCMMF0umJ4uuQRgSSW2866Nrp4p1dUNB6tTG1ZGxn/WseEES9RDh3yjcYYbTIuMdj77bBhqE2AMzvBncuBMKMhRZW8UADKuyqij/B1KEZFWV5bDn+tPwCOQvXFTA3P6QCE21+RyP8Aj/ig6cTGj82NdNEu1GzkhElJFPHPk8XpznAFKokODdOL7jtJacdg6FVq9gS1EOVdlCTxOhUjhWy8OFtGYnLrn0AIRVGYlXQD65JYd0Fr4h15p+uQknkJB9H/Vcn/8VHvs0TavielifQlOyftGITffI/IgIeBDghrfMP8XlxVkFZ2oPYpT8lVo+68C+nEXyk+RiOMa5m20AZXWv0iKeTQTHpdUgHw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Io6Gmv8a1hIy6wcOISpFGwX80GB5Zl/a5oaDgylPRwAq8b7nH74UR+E1/psDuXGmh39K9MahQ1mhxrsz4Bm0eKJWQhInCUbH8MDiXReFXAGqGs3OjlJiw1SfD4IroYQoB7GKl8nDw/acvAMz/81XwGW6qaZwQZcBUigPzBwuXSMp4ogA6v3I7Sf5wag9mPAEtP3xjkbGoUs9vJ4av58xIfyv51iyeTjoKcnHs/MLIX+dM9Iu3O8n8CcJKNUDMMbYN4bNXeq/cfiqFLlb8/Wz58F+oDTZPBdlQyKZQXuCZQhEa3gaq39iqDNWajJuLdvKASyB2dkydKaMVE5N40yeDXVS6G2c9M+yvKFftcqJcB6uiM1jgNXWVi8vXoY8pBNbluwKtkuHPCPaiiQxJYYSFU6Qg5aevXmClh17CfxMq5YkjY3ORpALBRTnJ6j23DJP
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:33.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a722f5af-0729-4ba1-f47e-08df02e19137
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20045

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index bc5e9d82b..a9c31815a 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -90,6 +90,7 @@ class BBLoggerMixin(object):
         return self.bbdebug(3, *args, **kwargs)
=20
     def bbdebug(self, level, msg, *args, **kwargs):
+        import bb.event
         loglevel =3D logging.DEBUG - level + 1
         if not bb.event.worker_pid:
             if self.name in bb.msg.loggerDefaultDomains and loglevel > (bb=
.msg.loggerDefaultDomains[self.name]):
--=20
2.43.0


