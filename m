Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C448C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:17:52 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3643.1787861866812070188
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=eWdSjZ9g;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.200.33, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldnew1wRJvaALKGtoc358FOX6tHQ7EmUinR0lDGthSrrzQ3rh8VLB8XgZOhWf2hf7G5uTKjBWu8mnyZK2emgY75kNt8aeA9WZw5Igu7jaa3coTSlD59X4OEr0j69rFxs90/w4/ULwff36+dPxFYr79ytIrL5QSeYiOJwZrQbigh9ILsEnOiBQX5nkbZb9ODdTtMYzVQUnYGpQsuPvmQjHUfziwgVSit8eJqOUx/bYsxXuMt26fyzsFuqwyavVHIXyhIOoO0/U36u7fveKuWIHfTpAyI0q+BIyq6xqG3rRl3NtyjE4Iii5NAs5Z5saHjKfdoYFxUSwHKW9r1jNErgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNhhVBU5ZYJbRHfoaujPBhqhjuPBwhMLyfR7EMvRyRM=;
 b=BsVLj8HrquaT9Fx632ovCc7NI9wWqezwVmht+Ed3+WJt73DSF3a3qEVAIWJsR/PxThawAyFa0PeV7lbF01poc9KVuxCeld3jseDwbtx2iXyvFWKq8p0V19gdq63mTITdEdlpkQJd8ki47j+rUIKwzpxknwVOTjezMpcvAXzdSGFx1l3lDmSn2J9l73mZPW0/tTfM0HQiG5MpUNtNjaQ/hyu0KX0F8Ykhxn1sb4Nx76/43kckz0ADrf/ejoRtJhENnzsFyc2V3+XU8ssBOHY+ARKW5YYiV4cKXZ9BvhYwEodT45Syp+ayyCZ7Su/vN6wt2U1K/as23+jw/76dM9cbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNhhVBU5ZYJbRHfoaujPBhqhjuPBwhMLyfR7EMvRyRM=;
 b=eWdSjZ9ghSgoGUvinEB+v8qdVFXKCYJl8+i8Yq3xQQ265ktvKOHHa/65uMucpTXkEjfFcMQX1ntwTRtM8Pb3QayR6htEXjWMKwQGPNvIU3TSYoctqXovitHn+xK8+0oNpzHybmr6I2zWkT8wMEAUUB+XkaZBTD5Pjt9vXoZguQrUJf04Z4uiHKsQsPwqyBPsdGTlviAZTPBaVyqFmEkZ7MZTN6EWW7uRXT3ySBG9oJl2SAXDM8bNRFMGhYe2hsnErPit9rwwDSQN46kZTYmtLILHtwXO+5nmR/4gh0XMgV0YzpG/qhTfYcGDbxBVmmlM67TXWk8zGNGfATIFXSO4OA==
Received: from BN9PR03CA0292.namprd03.prod.outlook.com (2603:10b6:408:f5::27)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:41 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::55) by BN9PR03CA0292.outlook.office365.com
 (2603:10b6:408:f5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:41 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:31 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 02/11] runqueue: remove unused RunQueueExecute.sorted_setscene_tids; declare setscene_tids_generator in __init__
Date: Thu, 27 Aug 2026 16:17:12 -0400
Message-ID: <20260827201720.698482-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7410fedd-56cd-4ab1-02a1-08df04783f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Ttn/AFh37JYFbnqTssV+C1N/OIKrwtxUUTitRGUwAwRp8qair/QV+cOwuNE3z/7Ck4Rx28aOlHSNezwlgUAMmLv78A4RFDaG2J1kSZ1LXKKn7JcnBf/LqK4+s/+WooZIYlLozydygg5/sZ4tGxZsexxNzgHyVadQK8+Gvn09OXZCDIyUqlXtpIu9zeshfACxwZT5f3ltnJ280Pg3c024YkQ19HU509VEIo5NednSLmnQtFHZEjxJ58WNJxxbVpZY1dYKiHjvsncELIn4vuFX2f1lfCZqHmZCUJdB66RItfLdG6OXz7SR0oyF9PMhjjsUJMclvd0APtbBHPRuTfckFt/oTtuOuBfjMQJ5MggAZeowXBbvWBnzDNZlE9kZ8CY67gFzauaKqASmobBvmEoH6XJWfcE1Mgh1w0uOBsIQGW7JCX/Rv5WiKtZK+Vqy1+3wfyvMdi/31zbpHmy45EnP4Ha6lppxfaFR5gtzwIF2MLERP5c3xi/jv/RAEb61WveyoAxn/fAXXqthltVlCR5OQgk4Ta02go4l5vDm7i2KK+XlsB6dQDyUqdVXx+UHRNl2OrySCbszinNcgq0LH1cI1C2RAqBLZSlBqk8KLSU7OBsYfJkc/Yn4P0KzH7Tg0yr//83YXcWO4h4tFwYdndfVz+zpa/uzJYU0MJreTpq1wQDFDlT5gh6eUxkms5DdaWVnaqLrIB+T0hcLuJYIn9W1LA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5DbMCOeQuR3J9K/wIXcMooHXD3oBb8H+EsR8Qvas4d8joUQpCoR1O0SjaOQ/0JB6xnjuBWsgW/QiGQ9PEokuM+Mcdi8Pr5w03k8VoL/PEscN0qjkVr8xPdyL2IsHiotWmshVLZhMhFuqqWBUVrhhruFWKaKkuoXr+/w+AhDQK7qJ1pRTW9tNwy0zGfB3viPW/ALf+VOJhVtxboznVhUVjcW4tB+DtNypNXUUg/C11BL+as5KT5UseFzgsGvynuogm4q8uf+qj2iYtcNm6/3n9Sq09605iEC+ySH/orfsDXF/sNRdcBUuKvdfKiX3usjnQGJVyxGy4XgUtbD2KUfaAznSPpjPL05IJa9jojvNNn2szqBck9XpCdMWM2bviq6P8EcMi/cep+gVrFWMf702n1LyF8fe66zrhL3yTWHXkhzHF4VnCO7Hm1kODfmeNinp
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:41.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7410fedd-56cd-4ab1-02a1-08df04783f4e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:17:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20088

From: Chris Laplante <chris.laplante@agilent.com>

This makes the code a bit clearer by avoiding an ugly 'hasattr' call.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 183475016..b2c2aaf14 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1931,6 +1931,8 @@ class RunQueueExecute:
         self.tasks_notcovered =3D set()
         self.scenequeue_notneeded =3D set()
=20
+        self.setscene_tids_generator =3D None
+
         schedulers =3D self.get_schedulers()
         for scheduler in schedulers:
             if self.scheduler =3D=3D scheduler.name:
@@ -2202,9 +2204,7 @@ class RunQueueExecute:
         if self.updated_taskhash_queue or self.pending_migrations:
             self.process_possible_migrations()
=20
-        if not hasattr(self, "sorted_setscene_tids"):
-            # Don't want to sort this set every execution
-            self.sorted_setscene_tids =3D sorted(self.rqdata.runq_setscene=
_tids)
+        if self.setscene_tids_generator is None:
             # Resume looping where we left off when we returned to feed th=
e mainloop
             self.setscene_tids_generator =3D itertools.cycle(self.rqdata.r=
unq_setscene_tids)
=20
--=20
2.43.0


