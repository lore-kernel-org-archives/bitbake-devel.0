Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4BAC61DD4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3446.1787861253957496348
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=I2KPm1RY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.201.34, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKe9Z7/lkHrdoyiDnyNmtmxFknbgHmSuvOFzW47Cfulo9VoP18Nw2NUnVPAEiuon4HPGETNGbjzsn0CwoOiTE8pOHZ+CCBbr7nO6iLzIPlKlNTacKWiNhllhmKJRP8pLTZbQRfsEzf+SSxgUfjmXoZyUHbkDeZ/fCxCzht/2mSTH0EpNPkr/2g0rz+0GtKf8si7FQkcMPcIfRB75AeDa+xkyyc8qESGFlc/OoennZ9GILONsDBtFzlfJpbLwBBYWubc/Vckg38a3agExQrF8oQ5HEzWYg+ODYfImdY8z8EdpKigjgpSl4LzsCDJPC48U5ev33W+jo2ZLvQhPWE/gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76A2YibjoQlUibyFEN4xsKDBtaRc35KvTAu6eyQN5f4=;
 b=JAtMqJfaDL/gZv6wFQVtl++L76a7ewyZFM9KQwocT1MPmhxqOAxn8J+7j3vJtP8vfQFhtTrK5+IvI4lMibQdnl2v0y9lpK7WYUfJGOtwChX4E/TzvlqYBo2jbfJF6hKCEm6tRprToH4tvtHM3pKfWxLiy2buBS+IPVr4iJZGsTNE26h45GIPd+jBIYgot0wScJ9De8eSl1tMt8Tl8oLdv8O5Qk4r3bZdd/BPCHVT5jW1FghnNUuefUehYy/BG3QgFNaqHjE3WhNrKbVPd1K4gfvbPxJACQjNPT1yFbHJ9HSrzPuPkRHPjL8ujlv8Hd9SRjRG1cigTFY8yqbtBaBv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76A2YibjoQlUibyFEN4xsKDBtaRc35KvTAu6eyQN5f4=;
 b=I2KPm1RYIvU7HRh32RdvD07trQupFAg80d/SpY20BYMIpXTeaO5EV5ulfKo1Ee4nN8C5G2WaAVOCp0Pd+qxsEEwLHfhbd0LagX3cmJUb59ETy5XjuXY4cTpK0cKbv07bsqEbJLdeBDaCZxCfNtKS0YpAAU6iOY9qqQTBtO89ye+2uK9hDAXAjSIuL/KX4bEb/ZQeHk1+VBttGrfZOx6Vsk/tDoH+pkIWlyaSDPdZ4bpbeAGxMbYdwWmg1qXqaoEv1BY98Kxm3dAqG4PGqMyYaNxG1A7wy3SWGNSkniw/u8oETvZ/NyR3VQETM7U3fvk3XdMQ76I4ZxACF79rXL5FUQ==
Received: from CH5PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:1ed::18)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:27 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::60) by CH5PR02CA0014.outlook.office365.com
 (2603:10b6:610:1ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:26 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:02 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 06/11] runqueue: optimize construction of rev_prio_map
Date: Thu, 27 Aug 2026 16:05:58 -0400
Message-ID: <20260827200603.688796-7-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 989a3976-430d-4a0a-8a85-08df0476d0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	UZBw++XV2gRtR2P4lZz864IGEgX6u4XNP4y+GvJ1liSrI9VFjR1ijTiFJO5N9E1BkOZS8Dm9cETs0YwY9NebW07RtNhlClQkmUS8xqHob8p1d+mBZVefJs39as739xo5B2EYeXS0Qdoh8Rse3NSa5HWDKSbI8zq0mwqcfTDFkP0wDZyZ/x3HFEUX8QinfJq1l+sRABJAtZRP8vxfFQpKbFHCd59tJEYMpJxCLV0o+GMZTNeKATZGhW/gINMfWzy1vsEhBZ05yP//6wTkfIafvAk47AoErv/Kl88rZYvATw73BmvDwvi4iqDvmmpCEtCC/xW8z5t1Be0d/uX9evVAqUd/mHVM7M/+AeZ46XIl+WL6eaaAfemvd/8Hd7v749bqXdk4tvLGRVUR3KKNOaPFLLFMTi8SgWx5RDjPo/N4j9ATVm+MH95BVE8cqO/RvrBylYF8fN0tyDzrxTaKCPGUeHxn2S/zoNz9ZF87FgZZQa6ktQZ4ghMVBrnf88Fcc1ldgJl7XN/lJu4WUEAcHzEcxyEH0GmGc2QIEfEJTa17lV3qNRu3lOgfeHQVqMxmOBTHl50ZkGOhgKCJckJU2Tqy+jFspL9lFlKtCJfa7894+V1waxRzctEWKYphEEzKpky85zENJzRRldUFodr8/YxWloplqPrciQAL1O6zRq01Uby9zeOhh8JlCUI/FB/HRDJ390xFZQ7kFPFf6VWfN+b5xw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0aNZCAy5RlKzPHZp/B0F4wFAWuyYq8RBL87S/xdDTEiw3CCpGL8+arG7WGegiU2cCvhjmle9XEZApxn+uCqLOUPEC+7G+xUB8ZWARaWOu0BXPgP5LxgJcAOWlFijdM2J3GeSLE0Au+yBHFTBJvFfkhYQdA3HL55Bc0VwVTwqNoCLCq73JyCSxKCgFs09ybBnK/JPabf5v+HR/lTemqlPN+evYOx6Aokhd/kiqXZSRxGYUpHc8AwRsUtkFpSUxrk8QYpr+rpFKf47glcIPbRZpmG6ze5LfCIQpgmwlDJ10S5BEbvpocIDuipZ8jQr6fnKFGpy4NJBtdYibugSixBAgCbT16JJyZFfyGhRyvfIhDqRFfy7KBpvUq3kRWnsY3TOKjsI96DQCIf3guzTbFcG7Od8zIaBDmyZq7z3yLNYlGFNB8QhK8RLQETJZOz7ymWB
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:26.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989a3976-430d-4a0a-8a85-08df0476d0ea
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20082

From: Chris Laplante <chris.laplante@agilent.com>

Make this an O(N) operation instead of O(N^2), where N =3D size of
runtaskentries map

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d64624e40..c55dfd9d8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -287,9 +287,10 @@ class RunQueueScheduler(object):
                 return tid
=20
         if not self.rev_prio_map:
-            self.rev_prio_map =3D {}
-            for tid in self.rqdata.runtaskentries:
-                self.rev_prio_map[tid] =3D self.prio_map.index(tid)
+            self.rev_prio_map =3D {
+                tid: priority
+                for priority, tid in enumerate(self.prio_map)
+            }
=20
         best =3D None
         bestprio =3D None
--=20
2.43.0


