Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CA7C5DF97
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:07:08 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16.1787332021007049095
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=JVDMApRs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.195.21, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJkD1mjwlRTD0hMaw1ld9Z2eTxCeQgTUNL/lLak92wJgQ5TBKH1KwfLshnxP+7rmIsaAfInTUH80yD+yEpLstDks1ZrO5uNb2VDlbRUK58miTTPi/KquLCL670KtEEpoWnmJIDZA0vf08769era28uVgY7uGZvJ4GaTqQR54VqYKLJwH434+UEgMfZafRbkCNBRUl8B+vAZQoyM9GwSWt1PN0tKHksJNCOfEDEuJ0OHZq10w5OFui8XZkzgf83WMQdkymeS1q3MDPM4OACsJbg+bw9m7IssWhxP3SQvf9jEQfgkEYilPO3ONuvKjhKAUS+TeTdhVQtdNZBLqRMhWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT97SM6UpPzIp5VerE0qA2dA3lI0cp3o6/K2THgCK40=;
 b=hIdHtt4cVIMVn2242OyZdZM+XEaBAWQ7vKS7GYCwXyzZkFfoGkMVG1Qq5wTmiR55JWtuZCueUjte4d5nM+2Ck8vCmnbtvfrtQH96/2W/uToS22xAv5aUbGeBgx7KAHm9XwtBxuIxHsCS+nrAaogPT2TPiEUWzDWH/vVIrbcDklEUFz5lAnn4x0CpgSYa3dXxqx9xW1hIRICVwzwu/q6yv2wlBeKjJDhp+iHOT/JGnhW0cZDQxietGsm/XFAiKxWlR81Tso3hAks83jM5rz++MM8SKaHyuoYdLd68IrPa8Ldk+EJhpzv13QuzoikkpfqTUySU7RHeoD6llL5uIXbq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT97SM6UpPzIp5VerE0qA2dA3lI0cp3o6/K2THgCK40=;
 b=JVDMApRs8C0W9JIw4ZRFHV8gMs4JFLtDdEiiYZb2hufQhNMCF1Ksim8bt8CVObxPJ4ZSjI2UEU6Re53ox4JY6zL9Wu/6nM7Tz6TDY3IcBFC3/WlvY9DIl0Uk/+sfBQvjQBYcivs7hGm5YNfxUX4tp2klg66IvqQ5ng9gpy3AZki9jMQLpWyL2ObDRX6gQ8KFDn7T7lzqzRHxnGY8+YjES2h+p7hGS0pHyxtpfdTKCPX4FQcOeEA4MdrHl0EGiMr7C1SfCoEt96sCmjDYbnBkz+sWFKf9m8PR3PQBSQ3CkBldKzhaAStg+N4GKNCc5wO9EjT53GgpY5VEByDdkssSrA==
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 17:06:56 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::85) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 17:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:06:56 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 21 Aug 2026 11:06:41 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 3/3] lib: remove bb.fetch shim module; cleanup fallout
Date: Fri, 21 Aug 2026 13:06:24 -0400
Message-ID: <20260821170624.436725-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821170624.436725-1-chris.laplante@agilent.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 225b9d58-e19e-4c04-1bd9-08deffa69b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|56012099006|22082099003|3023799007|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	6EcCCrqamM5ZWt7hjlYFWg+jWn07nFKnSqznVVF7Utg1X/cIymOj+GxU5z0epwnCh+mr+2uIS8Da9pbS8F4xzfL3S/3rAD2YxA6N4uXby97JBqz817ve5WnZh8mLrlV6fIzrlYeiZmqZmdzctsEWTwneAJ2auRLm9U5VcwpcDuGGGacTGsDrdt/ynxmvFIGXr0QGoBOTBRWDF7mP6Ss22SUA7duXl6QoQEfLlCzS42aIuCcgoWOyeFpejCR3kVLHqsxgSl8k8ht5yBHwAMOxUdYj9ui5h23c44E+YV8LrSjNMViE/Gu6v833idnsHPm/I4mX7IKMFQDVgpCiRNb6A+OFFHijUkdnZaUDsDxPfbAIfN1Q8N7VSm7XyQp8emWLoAjMayZH76+IWYbVQnmxcFr3GnB1cYY9OzBRE5khLwDGrKurG/qkDm9V9oEDN/tJtnGbAs22a+M/yE2CZkHF49TO2VOKSby431mVd28yGV6HWcMf+8JXXpoCOZcKTMNeIwoZqNHLZv15Wlkm+ZwuWI1YgLcgDwyZYGoj18HRNw9dn0CMLpa1puxwrzOvrizzibtn817QseNbSF47HmYVJgv7YhQcLAH6rztS0+FXOdtVuPZsoTZPXiAV6Bur98F/9zxoNEIsz/XTaEEzqKvNYwFBHuXYsz5RJ/qfRRndy8HoqhD1U77wa0dbxk94oquNuorffWncQfyBI3bKPyJa6A==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(22082099003)(3023799007)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	gf6WckT6bCQd7hWRHDjLBP+z93dIPesJvkmlfCwzO5olHiHZEvfWcDgqlJhsnbFLy5QgIeP5hxXSPa5TeXmO+th5eDfVTYo5vUCh4+Tlffd8NY0zdw9GwxoH3o1b7fjgm0hbnjLp7XXHycvCUaggQFrwV1lVpsRx3Uitg76pGfwolGkRdH/TOTX8ynGYMKlOpo1CP6QrCFHwD2wZu0ZqLcPhEAgk4b6Uq+Hrf2gFpb5sLVJWPtDMeuDornNF+3z5jyXsu8WTtAy+X5XGpCjxRV48lzeeCp+Zq4X2KLoc1v6/CFqLBISQ6PchnsUm4rh8DP/8BNxCXIETyDb6GwMwB6PfKLBjLciyc8fs+uJyAfzXr/HFOdZ7qa3PhREg/4bZ0ct4AR9A6XToT+OlagzH+sQpwE4d7Lfp14MKnWB3OqFQh9Pq0iaAG+LhyrQzgg2w
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:06:56.2348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225b9d58-e19e-4c04-1bd9-08deffa69b04
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20010

From: Chris Laplante <chris.laplante@agilent.com>

fetch2 replaced fetch a long time ago (2012) so I argue it is time to
say goodbye the bb.fetch shim.

In doing so, we reveal and cleanup a few circular imports and transitive
imports that must now be explicit.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/__init__.py   |  4 +---
 lib/bb/build.py      |  2 +-
 lib/bb/cookerdata.py | 11 +++++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index bc5e9d82b..049c87ef0 100644
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
@@ -152,9 +153,6 @@ class PrefixLoggerAdapter(logging.LoggerAdapter):
 # can result in construction of the various loggers.
 import bb.msg
=20
-from bb import fetch2 as fetch
-sys.modules['bb.fetch'] =3D sys.modules['bb.fetch2']
-
 # Messaging convenience functions
 def plain(*args):
     """
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 40839a81b..8b49721d6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -24,7 +24,6 @@ import datetime
 import bb
 import bb.msg
 import bb.process
-import bb.progress
 from io import StringIO
 from bb import data, event, utils
=20
@@ -387,6 +386,7 @@ esac
 '''
=20
 def create_progress_handler(func, progress, logfile, d):
+    import bb.progress
     if progress =3D=3D 'percent':
         # Use default regex
         return bb.progress.BasicProgressHandler(d, outfile=3Dlogfile)
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c5fcd71be..eedfd5406 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -16,9 +16,16 @@ import re
 import sys
 import hashlib
 from functools import wraps
-import bb
-from bb import data
+
+import bb.cache
+import bb.codeparser
+import bb.data
+import bb.data
+import bb.data_smart
+import bb.event
+import bb.fetch2
 import bb.parse
+import bb.utils
=20
 logger      =3D logging.getLogger("BitBake")
 parselog    =3D logging.getLogger("BitBake.Parsing")
--=20
2.43.0


