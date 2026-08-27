Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41EC61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:17:46 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3786.1787861864212796263
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=c5cOjCGo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.193.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggyQ1NGW55/N2Alyv1cXewMKxMVPUlYcMYnUkWI41KtL6ECE0gcA6Qigj994pCD8/YxAeCq0u5a+cqhq02QUbCOHHghJ1DJbDjecaACWWobHQo5PW/FSfjdARUv8j3uYmhRoDbc5OYaUXyQf5wO545ykdxwF8kPoai4JbHwhod5InOMCF/N5tfbL6wZoehW3vOwpaCOhzXWoTsCCyPGU2f+ELrRHnQdrLuytLELYvyn9xQYFgo/tgwx5Nz6A+uyfLh6gc5FFyv3sSp0o1qaCd0m/lPQi1GPeXowrOVcMDNU4YP691MdNkMH3Bl17bbUJ6Ln5IwYb5hkcf8IQNlNi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90o1TNy7F+jS7MlY/Hs8APpMHxU0WVfORGEwI7JMV70=;
 b=ouYybwSPNjk7OQEZvLmYivzYSG0OCH8rvZqw0DfYpS+nGQDJv+KssO//6eQsfWTYpBNVLBU8Rul/MbUu8V+C6xp0S3sTm0+3RTTUOdUAEVUEW0IX06qmEglqK7WfmzQY72prU2iyov+Ua2ks+Vxped1tZXDMKCETogVEsrKB2MG1/wxvOYDtYLKHQCdUrcdTUb0PQjBbRfYfIoRZrMMTAEw3Sb4vFDHVxvIm+Xd0nfujMfKdmuU4oxtd4ZBZ0VuofxOo0sLTRMUQ6AqHn9KGCZ1wpIQlIn3cMmRRF80UNAgXpcnj51/GpQfuGFM0GFJujZJnwF7Uip24CFlEkk9kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90o1TNy7F+jS7MlY/Hs8APpMHxU0WVfORGEwI7JMV70=;
 b=c5cOjCGoDJlqSxm92IugmjqBqIoGeZ3bFGFsEtwbFDChwUTa/6GffHh6wPDvAimbY+zMQWxPu6bez2YHE++7VeoDP49VWQ3ZtRC5rrjWSwMO90A2aHr1dumN7plIqcDVms1UdhZHWgSKTd91TMuvsEcp157MaZNmedPaOlt6qrwsqZKn5BQ4A9tcy470q+rdr2cruTJaNBTq+1G91rUboue9krQW93Cg++/4DNNKB4MA9AqjO+BprCmB28EjTvSYvaPcT8MMkJDTuGeGwdM2FEbjhwDFMEI8QY25Fza5h5n7/7A1ar1pRVK/LIbaId5+6tV9T6QUdaIYkxYj9JjP0w==
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 27 Aug
 2026 20:17:39 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::36) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:38 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:30 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 00/11] runqueue correctness fixes, optimizations, and cleanups
Date: Thu, 27 Aug 2026 16:17:10 -0400
Message-ID: <20260827201720.698482-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 56199943-2320-49bd-e95c-08df04783dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|18002099003|10067099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	AVIdy3mcbBoOaW5P4+nYXT4AYH73Fy2SyJoGMAALwRnsWTJQwcCi6cNowV2mo9pYduifzqfUAxUxLIoInYbscafRUZ6SfErykskoJBX4LYLrLfKcqyxPhjL13/tY//8PviUH22qQpf7e5xek0Zcpmf4qjCYeFZu959q685gFg1kW97Q6AJsAsgnXZsoJ3MYkd47jgLtzQ2tIiNxWw4wjc/uv3Sd3e6vOppzHh1FoAAfmtpjl2RlzrfxzlctaHb9mhlWMj1sn7+OrERS603NQ+An08oHBaeJszrSnRy2YA+/NrLUtzNizLGJKMPjaBxizAjxuE5x2EgRiWeRHYcxs6cqAKjWCQ422wXgRQVYYfXichqLSEwiLkMLJqqGE2THkXqFeUiloYuym//7O8+JTBifEtWRYq9sCyh7LOJ0u/EeIBxHzJGrE5BXbjk7rnOoObOX6rgyOcKe3T2nmBtAbpawRMzMyWErvIf7NcNTV+WFFzMoa0bih50YgigSQajGOC7UK0g7OJhTViQszCr9RbV8xZ82eRzMUAi9+zxd6rAEGN6CIOuY6VIVAuhyLMOORWaqIeqmjLsMQWs+dqOIZnJsfjN5cXRIzcqdlkavnQwrHAnAB8mRx2fXca3q2bhhthnUHqq17N9h78wJetD9aIV040zOdpogHgmbmko6ElH565uDSv6CEN1hcOVrmHrupGu1GRT7ct/DlN9F7lcsA5A==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(18002099003)(10067099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Pl/uCLVq0MO7i0fLszQ92J+GdgvuUB4e+sOp9zfCtVBS2UyIyszh5dO+c1alFCPHh4/K8jV8R/e1/XKec8LnRTcu5skAEMtyXvEAsluP5gmoEpvtDBWaYXb2diryajq9sFVn4knIGsNnO0j7NTpm8e/aK/AWEqSPlxXO1zA5g5oGFbW0+ZkVBrF8qcThXePyLYIq6PeMHEMlSttM85Nf4H4X5l3Lz9LaOGb77LEJ5uobRUGzW8PV+Mp2abmqmeSpAZuwwo1tO5eIyCuKTO5HMlykaD2q3xLeFJHvSTmtE64snA+SaO8cK/Zx5KAOKojfQjh92Ldbh1CTKKfguBwooXRmnuGQKr2TY65LkroIS/zHvB4yl/3vH3fNPjFgxdbM2LKVOP6xf1NAa1SWP7asveNPEwL3+BIhRVLrOWsDws2+mD9SARgsh7fUTwQcEpSU
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:38.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56199943-2320-49bd-e95c-08df04783dbf
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:17:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20087

From: Chris Laplante <chris.laplante@agilent.com>

Sorry in advance for the patchbomb, but there were lots of things I wanted =
to
fix/cleanup, while I attempt to absorb a bit of how runqueue works.

I think the most interesting fix is patch 9/11
("runqueue: wait for covered tasks before setscene").

Changes in v2:
- Fix the multiprocessing proxy import in patch 4. The v1 import treated
  bb.multiprocessing as a submodule, causing bitbake-selftest to fail durin=
g
  module import. I'll probably eventually send a patch to turn
  bb.multiprocessing into a real module...

Chris Laplante (11):
  runqueue: remove unused attributes/variables
  runqueue: remove unused RunQueueExecute.sorted_setscene_tids; declare
    setscene_tids_generator in __init__
  runqueue: remove long-unused RunQueueData
    get_user_idstring/get_short_user_idstring
  runqueue: cleanup imports
  runqueue: remove RunQueueExecute.build_stamps2 which is never read
  runqueue: optimize construction of rev_prio_map
  runqueue: declare pressure/load attributes in
    RunQueueScheduler.__init__ rather than dynamically
  runqueue: fix remaining attributes created outside of constructor
  runqueue: wait for covered tasks before setscene
  runqueue: clean up dumpsigs polling
  runqueue: report memory pressure limit correctly

 lib/bb/runqueue.py | 114 ++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

--
2.43.0


