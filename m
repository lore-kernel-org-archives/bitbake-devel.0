Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F9C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 21:14:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.89])
 by mx.groups.io with SMTP id smtpd.web11.31877.1739567657627284786
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 13:14:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=PDKvVNed;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.89, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfEsRZoWVoQe0awSismHUTEQI/dD9FmZAP7l1tv0dbYHfgsM8lxhK3so65OIbTJUvqrvCNUr2vh4ZvjNA8Xn7uXTPqCEyp52JRc14V141VGczuQJHYCnz9HYHp/JGJteMUfNKc2tsjX1RhbB8QBTqMh0PvA+WBy8OPZgVcVyq7J6P8Rgs8zZWaQuK9VDQEjcmdsT7LQ06F3JkW4rUgcOm7FHj6gcGV1ZACrAarrlgWyn+Igix1XhkxwyVXHuKDVrEW3Hs7atVIvJuC8UA7REQpQgBgDdtFkGiJXLBOzxJYNcjSfVf27Qz9PvdMo78Q1wmO0AA4yvlO7dOHviXmEinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbcd6W0XuhTC6ccpN0UwEoGtsNkg9ntHkb0uQi3FxBs=;
 b=gZjuwvrLJSneIoUz7+1+1gdaEbuKnL0QSNOY0X5wddJ92IsqQ3G6X/wWF+Nx1/MeQd0Vxa/59Iqb6mWhczvSgBOcyXvySSzM+BcyY6tbGVKMYLpL2w2WtShP7tBEK5L3/mSJQB3eLcsqz5y4qGJjgjmt6A1oC1QtO9awbmGLg49QHPBC8uIzHsKparrJSxa67fxJFubmyp1u1v9SIthdkmvBJ9r/WpN2QaoquG6zBCw21tSQ/oxhgfcSoNX3LBevpi3owCExM0EHBChhXiraT91b1TcM66c1pPU6NMA+oxghHYCcGELDYUVG66OIbKuWnMc2P9DmMMBvh+uzvmRCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbcd6W0XuhTC6ccpN0UwEoGtsNkg9ntHkb0uQi3FxBs=;
 b=PDKvVNedh7Foxjf2B92Ubmwoj75pYsJijExC1yOXIl0dX+MI9kLeo0b/pAGBjh2gQ/bUXnEWq6FTv+9TNjkbaa7wvcTLamNHm/sN0sKsB0A3jroR535CQf70yGsMxhunoFy8dZ9UgYMKsXPX0XcbiOweSf70XPGsZPc3iG60jjnjgzOpR4/DCpoKpiP/G4eg7GTnqd0FdaYxgWzETZX0arOwXMz75D/QnKjHkje/AfkYz4+5VdW2/3vzi4FbL4U8C9+k4KA5lwoImORRuJLOyBkU/7eCl1fm77PG2iHExIX6r+9iMPm/see+ROCKmo2tP1nuf+4H/7JHwMcFnVUOlg==
Received: from MN2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:208:23b::29)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 21:14:11 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::54) by MN2PR11CA0024.outlook.office365.com
 (2603:10b6:208:23b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 21:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 21:14:11 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 14:13:34 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] cooker/event: add cache validity checking events
Date: Fri, 14 Feb 2025 16:14:01 -0500
Message-ID: <20250214211403.493573-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3181f3-a07e-4c71-447f-08dd4d3c8720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A6aUqmodya3VuD0IUxMp0cs4+N/YQlXYNKyu3nMkmaSj4PhEpz4sL6CwfmnR?=
 =?us-ascii?Q?h6eK2DDRcsgcAvSn7g0a2vJBSY2ZEONLdsBvXUkDdlxuYWemjOAuMUihrDe2?=
 =?us-ascii?Q?soTxoR7YsvKsmWWZ1RxcNgRtALl0R1o3xpTkppdcUX9vahjOAzLkrf3nBLaj?=
 =?us-ascii?Q?ErbEQjOQEZAEShIR5HQ3Plvnvqbr5jLlGdzRAVCvEjcxXgZfaZrGf4RYiKaY?=
 =?us-ascii?Q?QcX8IK8xthx0ejbB+QHPV5VIFZPj9PfgGrfufRu4uyLejtmEcCFQ/1GYDymC?=
 =?us-ascii?Q?70ZHP0RaLqwWG0s7Fzj9AD4VZWOs5ogvoXP1cnzT6AtE1dcsg/90222jLqkT?=
 =?us-ascii?Q?o6rKZSv0nsJpLmGfbvaywYIZjMaO1yDGTwDMZQZ5G51FIBeIR0FlXGcSE7mU?=
 =?us-ascii?Q?JmZuyxcMRPgJHreAuWgg0Tj3nD8PbpHHB+oQpaMa8Ig3a0cUts2G/tSShAjh?=
 =?us-ascii?Q?rqgtpFNXqZD9cvaKKcX9hjD0clHFPMN/2fJ/rIc/IskrTHLv0dcsV7Y+RN4i?=
 =?us-ascii?Q?R2YWtMzQEC4GgZsE/6RLeBRlp/w8DbquvV+GEoUmoukYmw2FVMBXaQMZMLsS?=
 =?us-ascii?Q?2gmBxCurEY3ygmXgUItBrmrbCd0PWspEIKrVgRPLySuyxmHbP7vlSYtW0uLZ?=
 =?us-ascii?Q?oPSCEnJE/6WECjsLo2qix4VennKA3OxMFbvAAu6giOg4gfJJUSQbqmJzRZ5S?=
 =?us-ascii?Q?dVSbCDXvJhqrDfVXKNscpKhshHOSWNwknZ8QIKNtgEeUzFO0WxK0faYT6jx2?=
 =?us-ascii?Q?u4bSYHb5VuD8KwXOpGaGA+dow4IQQHH4PrxnGPHIINIvPLnRHtiotRUe3P4s?=
 =?us-ascii?Q?TzQC96kbKs4g/zfYNEdMlcl89cD1f9bu+mrccbC7LdcCxI5NLF3xXrf1hLnN?=
 =?us-ascii?Q?VPtrjVjxs3kQ7ofQ4SfmuVI7TlDn3xVHAM0gQfxPOKeGHtK4G5ak8V+JIQpr?=
 =?us-ascii?Q?W+jl6r3LtZUvPDdsj/3tkmyGAtqV8RafpvIS2mjUdUEOw1yi28tyzengVzZf?=
 =?us-ascii?Q?toSdM6GBtuImO+Hpsf9iwgFcHz1IwEUl1X1Xj5pmuoKJkwUiRN9337C+vOaI?=
 =?us-ascii?Q?zovD2q/YPNV16tp91vvSpHtP4Rqk0dAH/uUrV7slaglB42KPEWRnBL67jzOx?=
 =?us-ascii?Q?zk3qVj4VAQ1w+oSsyJGEG2XluHuQ9WEy5MNPpJCbuoamlMU58zaRevi8Fi9Z?=
 =?us-ascii?Q?t+E+yak6SZaSiZQvcwCFhgFd07QpKh4JvZC9tAA9bs0xBFywH1K/5THntaNP?=
 =?us-ascii?Q?QASlKM1RIwtV6LRHLYqz07wgmY5qd3Kqy2tW1otj42oD5hgpJ1jmdwcYQImH?=
 =?us-ascii?Q?70wnokZCiMBvy5YfSIRPLib//nZwm3Wzf99sanPtMPlnKdPBLVHr9SeuGP3Y?=
 =?us-ascii?Q?34JuUw8feUPFFmL30tx7qOc2nyPlZpVZsQr+SuGUwjHhHUsJV6HAB8+PwdG9?=
 =?us-ascii?Q?pI1ZzEpGbAPvKG2fOuqmzERLlW7GU4dkKpP3BPdsywXI/Mw3r8Kt8roJPO4e?=
 =?us-ascii?Q?Aw201Mqz36uBE8I=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:14:11.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3181f3-a07e-4c71-447f-08dd4d3c8720
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 21:14:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17230

From: Chris Laplante <chris.laplante@agilent.com>

There's a "dead zone" between the "Loading cache" phase and the "Parsing
recipes" phase during which bitbake checks whether cache entries are actual=
ly
valid. Even at the highest (-DDD) debug level, bitbake produces no output.

On my relatively powerful baremetal Yocto build PC, this phase takes 6 seco=
nds
in the presence of 4 multiconfigs (including 'default') and 40 layers.

This patch provides events to track the progress of cache validity
checking, so we can give the user some visual feedback.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/cooker.py | 10 ++++++++++
 lib/bb/event.py  | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5b885cddd7..9b78530ad3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2127,6 +2127,12 @@ class CookerParser(object):
         self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder, self=
.cfghash, cooker.caches_array)
         self.fromcache =3D set()
         self.willparse =3D set()
+
+        validate_count =3D sum(len(self.mcfilelist[mc]) for mc in self.coo=
ker.multiconfigs)
+        validate_chunk =3D int(max(validate_count / 100, 1))
+
+        bb.event.fire(bb.event.CheckCacheValidityStarted(validate_count), =
self.cfgdata)
+        num_validated =3D 0
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends =3D self.cooker.collections[mc].get_file_appends(f=
ilename)
@@ -2135,6 +2141,10 @@ class CookerParser(object):
                     self.willparse.add((mc, self.bb_caches[mc], filename, =
appends, layername))
                 else:
                     self.fromcache.add((mc, self.bb_caches[mc], filename, =
appends, layername))
+                num_validated +=3D 1
+                if num_validated % validate_chunk =3D=3D 0:
+                    bb.event.fire(bb.event.CheckCacheValidityProgress(num_=
validated, validate_count), self.cfgdata)
+        bb.event.fire(bb.event.CheckCacheValidityCompleted(validate_count)=
, self.cfgdata)

         self.total =3D len(self.fromcache) + len(self.willparse)
         self.toparse =3D len(self.willparse)
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 952c85c0bd..e9834d01c7 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -639,6 +639,21 @@ class CacheLoadCompleted(OperationCompleted):
         OperationCompleted.__init__(self, total, "Loading cache Completed"=
)
         self.num_entries =3D num_entries

+class CheckCacheValidityStarted(OperationStarted):
+    """Started checking whether cached entries are valid"""
+    def __init__(self, total):
+        super().__init__("Checking cache validity started")
+        self.total =3D total
+
+class CheckCacheValidityProgress(OperationProgress):
+    def __init__(self, current, total):
+        super().__init__(current, total, "Checking cache validity")
+
+class CheckCacheValidityCompleted(OperationCompleted):
+    """Finished checking whether cached entries are valid"""
+    def __init__(self, total):
+        super().__init__(total, "Checking cache validity completed")
+
 class TreeDataPreparationStarted(OperationStarted):
     """Tree data preparation started"""
     def __init__(self):
--
2.43.0


