Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EFC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3448.1787861256208083441
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=vlPgWVV0;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.201.1, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpy/GcH7RyvaHZf7r6r8lPl3lw8U1Pb0jX9ITvuis3cdXxS/FbAYj7ogYqQVeyiXnhZpTJeG+DCQ9VZtITgDBZZ+/0LSHLlenunrv7LCs4c1/85sgOy62cqbPQ+kQhi3FoBK7WV4D5T1UJBcCrB5IIVuaxl98v1vh5iGt22tf55RXH4wW7CfgoyrV2Ncs67NxtsG1JuHDbL2ysnod6pQPgOw1lRzkcZABTBvv266U/k/4XhDEng7zTjrfc8DXE9xdvB+2h3Lnpu9JTwkgECo1+nn7cy8PhcI7WFXRcEGdAqBoD+uD3hJeZi+DXDVfIUQR5/ygbVKV6ieE9ko9wvm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuxKuLzF0TiJVELO+oYIGtQ74baDeOWsU8wyHILqZQQ=;
 b=JDlI1TTRc85g8MXLUb8f68qO+K1TtBQZvAQ5tKC3qZCd6s1b7JI8mmWIoubpncJ9rZHHuSGFgosCUea37HV/bZpUWEbvVI4zlULIhu8lkjez8IxHd8miNho2KwKGGjHO/ihLXHbX9gFeuUkQbCs3Clzlalr3bTz0mMaLfciUpDhNjq+uHj5ZN8sUsfhEjZQV0bZM9dWeoXqQgAeJkly4CPQAEa0OmWMdUZ+eRkBkmGq9vkvrY83PGrX5L29Xhk+amWoveX50JTTIl/UoUJOj/w0JbISDVIur4qQgs3TVKVQJBMLHD1sH864VX56fYsbudfEh4PnDMiNTw75fo7Uw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuxKuLzF0TiJVELO+oYIGtQ74baDeOWsU8wyHILqZQQ=;
 b=vlPgWVV0fReI2BpJrwXL3JR64iBOoA1j76QC76ZCAdNp8pi2M+EJjX/bKp945IOS8ZChracYve49pC/pBxDb/Zd8BdkdeH/1dA1wDmbE8IREFNOyrDJj4rZq/dHJF9d+fKyRWSnUCHel0UTtd6klAHJZVZbB9yBc1/dzyZ4qsD9yTlUFqPw0Qezm4YvNZmRNJZyDcFCSjAz539ts5s0kxB3wXhNqrteALCI4VVHySL9oEaj3599LiVoI4mkdn3K9d9osgt/GBhNS48cz8tdiF8GxDAQHUAmTIFcM8rR86kkqpu28kdTbjcJTSAXonPgLf7Q6FSwiebdzIarCKNX9Zg==
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:31 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::99) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:31 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:04 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 11/11] runqueue: report memory pressure limit correctly
Date: Thu, 27 Aug 2026 16:06:03 -0400
Message-ID: <20260827200603.688796-12-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 98290187-5480-4c87-401e-08df0476d3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	fErDfZ0lRXGNwWbWWAKS/3IbIP2BQ74Ql/dqzEm8LW6+s5dbidxC3cm89g6EVysD6sHQGDEcbvA1JVRQ92iy1n2HJEr8Vkqs0lyU69dPuM4NQkR8rRSN5ATqE9qbAgi8WzRnj+54QsNF2VwcuXEzW94Pm9h52YLzXS4J7MtBCDnyjLAYAfRt8Cf0tZ7c8q5MyEb939tZQt/zpnYiPursJSSPh+2n7sbNDSIHJHwOVuzLooKrSNLJUxGh0xusd3A56UbXgydCWinShSO49uIVGePUruoiHHMauU6ckxtm6B8YxK5n88cW5W9l3XcDoXEEqWwgQJ3yXOfx2SuTC0T+oudoosrrz/kv4oD0zoHawE7aKFQof3tTtTDAoeZ8Wg6zjRva7cznLyQ5yFjEp+Sducuw7Fw9WoQfpbFoCL9Ata78uFCYSpdUo0qzgidw8fKZAq/co1KBypF9ODOgzVop95VmPUJztGYwX+zDXQzr2eCAIkPptg22+MR8b2910kMJVu5IZ61ZhfoDSpELz3565IQGsdlIgKfYCThIcCtIu/A7LI1tUTU8Wlj2bLVsXZBWanWFAM+ciB43tjWkpgrGgyW4oo2DLoVdO5JvtMpRo9SeoAAXcOVnOLfLa8VSANv4dnC0MijudQCLxdIKKX6bO59w9TPOv9mWtU1uU+j1sPUVi4vElpxuZQsTaV8h8KdXV9f96PK0LmnpP1HSJxIkRw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	C1gqo7c7qO3DdMqIoyc2SNcYlZwAkTpy6jFrt+ga2F75Pp1JXflydr19UcKsY5ClsdmLGnKlEEiLbfJ5zDRboESPZ2TppR80MZ0yDMnjy+4WjDmku7XhWqVLXYL70ArhyR+bhSVJanWbs/YkElRiNI4/RUlTDSuQDc+bogoTDduuaGXYC0oxKvNfIi3exO4zXJYQdExJjz+0u9shbibuDg87dnbZTnWOOtE0eFSey2eoxSkPx/p9EKE8Wl8lQPLLNe7ywUDnzc9zw2x94G+q2W994NPmO8cVYoaUlFY2L2h+32MTdwAO2zOW6qvc4GJeU1zpxvGahWZ7S2jGyrYRsHe+VzzrBBtj2MVuUA5XVxWwHM3ELg0kdIcUJctVSWUhurj6bNakrARhlnlZln9nxdEswRqu8TlAWItYJObl0iqyePNG384HRruKbGjY0k7o
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:31.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98290187-5480-4c87-401e-08df0476d3e5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20084

From: Chris Laplante <chris.laplante@agilent.com>

The BB_PRESSURE_MAX_MEMORY upper-limit warning displayed
max_io_pressure instead of the configured memory pressure value.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 43a7f17a6..e317ea5cd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1924,7 +1924,7 @@ class RunQueueExecute:
             if self.max_memory_pressure < lower_limit:
                 bb.fatal("Invalid BB_PRESSURE_MAX_MEMORY %s, minimum value=
 is %s." % (self.max_memory_pressure, lower_limit))
             if self.max_memory_pressure > upper_limit:
-                bb.warn("Your build will be largely unregulated since BB_P=
RESSURE_MAX_MEMORY is set to %s. It is very unlikely that such high pressur=
e will be experienced." % (self.max_io_pressure))
+                bb.warn("Your build will be largely unregulated since BB_P=
RESSURE_MAX_MEMORY is set to %s. It is very unlikely that such high pressur=
e will be experienced." % (self.max_memory_pressure))
=20
         if self.max_loadfactor:
             self.max_loadfactor =3D float(self.max_loadfactor)
--=20
2.43.0


