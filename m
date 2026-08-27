Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BCC61DD5
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3288.1787861245673343066
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=XG8EYbWm;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.36, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqutXo/NdcRE1Q/LuQAEOcEx0/cr5ybBliYFe8XnFg9NbRoaC6LpxYEgP1m58WRiJfcHQAnRYiATyh2WoHStFSpHnYeXtPgwL3IKzu66gM1Uhl75sc809A4V0p+XzVmAWct2gg1pV5jhvSto+OMGhqIHSH+e+C0UsOK3Wz1GRnGv/IwhaXVqh5qJCd0aYZqlA6yXnYKXs8BeutpqtoTR4YQjuQ7nBhvYBIemTuIb36kZe03NPioDS0HWN2TuaF7Nx7ZF88jaLvX6n0zROMcv9Bau4oPpUmYhVfTbzNK67b8OnXZZoySX2ImTEn8sOxJ7RIrhUEi1OO8UE9usjlnXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQPbi3OPhUN/NlfgIMmqGJYORZzhchTxf3oAm+DYJEw=;
 b=YzbR9N00WW7AVgtX3uo/RlsNC1Bx9+nIiq6gIjWwnuNZUD0EL7V1rLViMkDD3jJ71bTJS+OnsOOamQA+RO0q9zh85t4sQeg38W4WFr/iu005NsMclGkSGu4hHhhgONFyEHKbh4kVp127A68IH+hGK9X6JWy/OZ1IZtTt3MefapgZmOYNukUY89PntDypJZbsH8HOumT7hTulkclumukWPsF19CoEdNJ5z+v6XaemxAh4WLp7Y0Rd27czBHMoE7xBSLcpiKxGy9XsM6bqK+gEEU5N2VulLYTn9WbabNOrjQ4PRt1+SXuXyWrMW1E/hX/Un1jcFj2kOymPwbLxMyIp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQPbi3OPhUN/NlfgIMmqGJYORZzhchTxf3oAm+DYJEw=;
 b=XG8EYbWmgW7xMyk/I4dJtTTzzkk8T30K0el+vLtsTFB8J9w9SCg1UEjDmEo7cGm8zNMlFQsXyLRDciT9K6ADlM/GoLhanu7v59x4aSSfVSgTOeG+xNCvT86CuZtvl2FAlMRFn8zeG8BglrfDyvE3USxB1EK8nImYhbfkzyuuN0ALn8HXMjnStBDGw578vSMQtHnFfOlR7X5FWrgTk6liJvLWAvWLuFa2ID7hpIpTNfitTqKkiqD6iIMdFZsfrlFk2NSuxEbwJ+J4CiEyWxf9WHq93sDq6NIf9DaRYxIsf+Kd6fIPoDTA+lz8E7YE6bMC+j/RZssFQEntDjqDRpjlMw==
Received: from CH5PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:1ed::20)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9d) by CH5PR02CA0018.outlook.office365.com
 (2603:10b6:610:1ed::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:18 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:01 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 03/11] runqueue: remove long-unused RunQueueData get_user_idstring/get_short_user_idstring
Date: Thu, 27 Aug 2026 16:05:55 -0400
Message-ID: <20260827200603.688796-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: b37e09c8-1c4c-4198-55e9-08df0476cc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	JOsJDjRIbSLc2tNEOmX2Rjyvh1jyrapwRaCis7rLp8PdKzm0ZqJ+W/0rtXK5rCQoVahCAN5McaP59jdsJOQuEVpphVlSs556UTp4X8JY8scCy4avR9Z4wgtDekqnmYpC98B08f4t341bAidZS78jSKvCcIdf9UXecyXfWO+kJ5GDoGmz5Fqa65jxuNR5wt0/pn7oleO3xNhZD2rIXuS05LznKnFDXsnmxS31v2DAUVNvXPYxGudQPQ3jVyvI4OkeAWPulKvQ6etccv4N2TUgojtUHocARX7zvJzr5WpM+KTkeD3r5K4wed0FTvo0wl3b2IVnPkObmKvGoARpcC0Cz8iTuDT4VGeOdSAAiOuEsTH2DsH8gb4ERCqfbjSZMjW92k+/z73/tQhWiUlA5CaVO/8U/vtQNuGOwjHm5AexT7PYx0fol3YEweSPFHTX2lLef+ybFNh+0yWUNJyznA3ppuO5cotL1jVyuSwK05x/Wo43ZUdxi6ptPf6FqtNG1CWlx4UqhsVdD/IEyClGQmY7AMbDi5x2up82YQznqUIRuhvHwrdJUBfHS+zG7WhWIZVsuAOxtLFmHG4LlK813QOcEe5sXeZOPEL/ot/4Q6ICmSg6ULMU+kyH1lM0AFdVLRUZWylYQE/CoWqUEcD+fLmJ1TkaZSoCc6AmCopCnvyS0HazbHQ3oodnuLRb5vLgrdhjD8HlxmCRI5iUMHxp/F/caA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	YlpgTc6Ifo4OupRCe9puMDWvTIAlG+vK3Yv4cWCHTr9Sj/zYZPETei8mIHkbfTthrFrHBHXTGbpuJE2QN8joAUVjJGSGw6DvkoVMkRv6QeI9s22EEmPAS4cg572fpMu+L0h608KiokyRGs5+0G/5AgvH8Eu4Wi1t6WBSvQmXABOnAl1xJ2/S3MQRpftaLeDmREymVzZ787jds73Cmy+Q+HOYvU1r/YGn1zl4up65bM1zb0oMCdTRKwb9HMblQneO19MI2UnoBMnJWpAhxWa27tKdQBdsT2WcIiA3/iZk5guwW6gCLLYE8eAmpavlMTx8gYjY1HV5VP9dNRJyf+LlA6GyByH3rqvjqGvHt0TgrAH5a+/PXadJmvba6mwViR7I81PpUFaVW7YBVzIzmrcB7Jkt71nQjXHkKTUuwryH6LIso+9JjEr8cfOtAN3uWvWY
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:18.5467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e09c8-1c4c-4198-55e9-08df0476cc1a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20077

From: Chris Laplante <chris.laplante@agilent.com>

These seem to last have been used in 2016, before runqueue was rewritten
to not use numeric TIDs (2c88afb60 taskdata/runqueue: Rewrite without use o=
f ID indirection)

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b2c2aaf14..4211c83ad 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -493,15 +493,6 @@ class RunQueueData:
     def get_task_unihash(self, tid):
         return self.runtaskentries[tid].unihash
=20
-    def get_user_idstring(self, tid, task_name_suffix =3D ""):
-        return tid + task_name_suffix
-
-    def get_short_user_idstring(self, task, task_name_suffix =3D ""):
-        (mc, fn, taskname, taskfn) =3D split_tid_mcfn(task)
-        pn =3D self.dataCaches[mc].pkg_fn[taskfn]
-        taskname =3D taskname_from_tid(task) + task_name_suffix
-        return "%s:%s" % (pn, taskname)
-
     def circular_depchains_handler(self, tasks):
         """
         Some tasks aren't buildable, likely due to circular dependency iss=
ues.
--=20
2.43.0


