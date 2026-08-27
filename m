Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CAEC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:02 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4.1787861877879011096
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=dj0MwtoH;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.46.39, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+/5zZyDHqFQMZwzQjWRS0sjIYNAXUYXjYKVyAvajzYZh4mzLGH2oeaMqG/vjYNIq9jCxMXLI1F3UPZOFjPrGoy5bC6dH/12gja3CcRmA8GxVLcUJgKlQgs7pqRdC69+a5310D4cfCHRjI0VsWgVkfUTalJkbCJiPbqM58vEG+3aMKVaIBVDqpVnZGJA260k1tydRrF7jDTSIVGGVZwbcj42ZE4O6SJDTZ1QnrtQXQt6XDIAjpAUbv+jcdm1EGt/+4g1oZwJAMlsBGtP8x/IjzvcOLzm27H4hA0SES0PXRoLBpR/GhuLCVt7yp4L8mnmK7cUqb6JhzTFrLUO2nZWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBcDq+BnjKBKAE7KHDxTa8cOkFQ5JHz6rwpLKGUZZMY=;
 b=eA7O+Wy5Eqc2iX4jSM0WTVcCjKpe/W2xIl2g7HXPfe7CMRtSSgYiepMitMgoCebXYLNMdBGpX+yomhmZnbaj+WnhTGrBuJHp89YMFP5vyRzEAFlNbvaJ+JGa//tls0cdbU5j9+uCH2V4hW2Bc4l9N4MXwMLKUT8C3VJ3YJ4tOAvb1unt/biEE/qcnFuxmtt5wLbaAAKyGK5RD1XZ8v939WeJCYulrhgv7WEwmPNUKW6cNNflMnc45uqtZprQb25aeQIuqXQMhrKCrDdXO5OYwx2hJxUrszH0o8YkcIertJobixmCxOtBztXPCjrXmfLYBUNZw4cDtMHNE8Yw1JnYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBcDq+BnjKBKAE7KHDxTa8cOkFQ5JHz6rwpLKGUZZMY=;
 b=dj0MwtoHW4+6NjcxvNvdimg4beMu7NPgzjL4nL7TGhFWeBF203+vOn1k84a9ufOpFYHBCLk4XsMyCbQEtB3aeeWk3UjC7S4/LXG4HBJ11HOO/A40LE/cBfF50Yt5HUXDIE6K5zA2O9gJagsCstQtVKHbe6P5zXvUymJQXpFsd1ElHhWnqcpxO2r6X64nacXq8iHj+8amAi8v/ntUdAhx5FIN7MxS46AG6D0obnkdEH66fOMcPkN7gBIthB4/L8UgR7TnltDrkw4BSsvnYtwlAKSivwmmkESXU0vaqGsulcZjZ9qw0kmRu0G6XzWTJWthuyejKD3X6+hIBIKGkxetvQ==
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 20:17:52 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::59) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:52 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:35 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 11/11] runqueue: report memory pressure limit correctly
Date: Thu, 27 Aug 2026 16:17:21 -0400
Message-ID: <20260827201720.698482-13-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca5c7c0-0f79-4a5e-6e10-08df047845cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	H/LwpRHU0pyAoMZbLtK/imiqIUX5N73oU1eQFstrsrHuTSwZTWEsiegNYYK8fv/7F0s02mqyQFLXcmH/WeUdPgfndJAzgD4T7HBthEzT38AvqCFUoNW9jQSrmPu7VvB/rRZyo/U83dOAiPpzWOl7Cb9YJZDXdR++X8XXdu17Jkvq375LerqnbfKgbqIpv0s8fVpLYY0SSIopUKTLFYHG7aOy7wl/jA/jaihzEUgSv9q10lh/CQjh2mlKCXebCHUdPrOQvpxRHgetw5o2g38u4I11jNQrTdHW56LZOj1GpI0H9Pqkwo3NXdj2nJdtsJe3F1G9pj/EiqOwQktxL/Ba5R+H7y7PfTybVqRWfM1ec1WbOFN4T/+yf4isnlzkSjuvkxzdTVZp3D0y76mYcidx31q+6ix+282TUeiuCXHko1/b01jZKUJgC198lNhVIkEymjN2RImI9609LkDxV857QRzx8wHS2gMa0I2wctwrsOusfs1fsbdyPQY+LMQrCPUhIEifzwnoBcPCos9dXdXhi5XwnxBmRWDoBRWvJduvBOW+MBWF6hMdf0fMQkDCN/ec+70lxDCK0H34+oJ1n+R1DE4uCTTPP00Oci885yuVb7scbKJQwe3O4SDbatQJ7U4o8KSo8XPfn20Xgnq86Ahi3L8SbZh2yISOXEHqt7dJcS1lrP2ncV55lnCZ4BBx/ahGbu/Kj3nmAdFq3VRED1O/Zg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	NFBjDYxQAM18L6c6ltA0bC3vlZvpDba/Ww/JxWiRykOXuXImhPcc5bbNstvp67MRHAlqOQ18wdx8j5YRFJWO01kLwShrrlPUWj7fUZot0Q2h/PAymfPEdFv7A5t3ym6t5xZPfEb2/riXXTJ4+dutYKC81q9jbzvxJkSOWx1sdy62mpbfmwYDiYO0O1EmVoEnHDJybyhUqJHsBfHPn66dmUaHvbVDVXVlGpyhf/aTBWExEiOGF+6WGHGOE7Jti5ocVUTfDgvsj9B3FnRU6stkOUOvmoJHYGxePoYxBRWOgJjGmlZLcCcg6KHrMsNGOkFJNmWDP9o4UUQDiYPP1LfBn+noR64aIvKYq4Ag2uBbq1KV0l60EMlsNWdU1VyT+kzVqF9b06XxJe7T0RUFzmTgk5zfOoVqH4OdBDgkS8VVLmS5aqXGwK08lse4rXMGLgdm
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:52.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca5c7c0-0f79-4a5e-6e10-08df047845cd
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20096

From: Chris Laplante <chris.laplante@agilent.com>

The BB_PRESSURE_MAX_MEMORY upper-limit warning displayed
max_io_pressure instead of the configured memory pressure value.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 04c1c4d3b..270ae4744 100644
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


