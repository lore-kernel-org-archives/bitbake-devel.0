Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704DC61DD3
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3441.1787861247017002287
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=xxSbthYm;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.9, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFqMMGjFQ+1p6L6aHvRm5yLi3oyVxMV/N7poZy2EtsTMnGXxBOTrNYXj54CKAZabji4sjLdI6w3R0W/CSKRMRhPhoBfi3RyUl6h6vkTgEwIGxO9uz0OC4pPLECie2xVAfX6b0AriecQVx3A2IUhkdv7n6f6ereaRHkxKRwUBLyK7JCZk/NaO9TGjy0TA2yHLQNP+LsEuxoZ8CKYXR3SPK602Fsmk+jlOeNnLBd+xhAK1gRl3aSS1Y14dtU0LdrAWOW7RmKj7rbuN5eCwNSiTS9qw1G6ZgtC0hrFt+b1is/SLfxnFHpP/DjqjIDhjXFa/jmBJiL27UhpRDjogG5j5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNhhVBU5ZYJbRHfoaujPBhqhjuPBwhMLyfR7EMvRyRM=;
 b=eSKvAlB371EL+2fCehXbA+cP2lgE9Hm59nkJQIKb0ZPszmyFN0vPhykMf78FH0PkHfoZ2Qe54sbjDpaRUabANpSUyyWfgguzHt6mXbq7S2Qx+/zy8mpzxo3uIztZXL4QbO3NC9KK5S0UPC8vWZINW0e32I/ikvfeC8LMNOEi7tCMvEezf+0xNWsR696eTFPH3cwirylZK1QTr/weADIRBo/NS1+HJ6DhACjxPTflVp4NqWGkU8OJATFDS8F0Wxsor5CBtvoXvls2xw4NgDJSCM8BKcYNRauqg9HgUXqR8liD60E0V0Kk5KWsj9XxnGPohKwINyMbmsVAdgfsGCXyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNhhVBU5ZYJbRHfoaujPBhqhjuPBwhMLyfR7EMvRyRM=;
 b=xxSbthYmcv6+auzEaARxPlxMTLHgxwRJ7Ij1woXm7u6bsP7fN8gGMQ0TvRC3ftqRfDWJT5o89XXZAgIkEmyvnrUKspbSlyQqoS1A7tQlOCl8oADrDaWG6D8Go5KTn3lnJq9TXKJwHHlm72pLEHTyGUxJs61kn+MFnn/unZDZ6+/YX/5Wm+AzVj75nBqxHtLE6HKJcsBHP0rTfHFEsgj/FBX5f1gSSQOK8kUgSWmELvJk0Zjtj6Fl02HxYVD9P5M9jPI0nbFMRvnynSv17cP9xWE/twJZ/+oHq8fEtRKR7J9U1yGUsH95XljZadnYU4hugcxqZqNO2jQel6nQK+bKAQ==
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 27 Aug
 2026 20:07:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5b) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:13 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:00 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 02/11] runqueue: remove unused RunQueueExecute.sorted_setscene_tids; declare setscene_tids_generator in __init__
Date: Thu, 27 Aug 2026 16:05:54 -0400
Message-ID: <20260827200603.688796-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b6669e-2dc4-4e47-bc14-08df0476c957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	xmF5w6ij5aUkVLZhgRPKFBSIGj3AkfQYujxPYflo9iv4vVPvanBo0UShseuykwxSYZ4mZ+WaHJCYVnwUQeCAzd6j32TwhNANHVNOm78UHWrHKgCi88p50+yazbToCw8qgiquNXKYthRJMWRU/TKJOLx6cv+DgUrG+E8FgRO8/XkQQCmk2SmuEIktHbL1vfx/9whMwnBknpZsv/Mg4c2Y2FMc0NYSg+cURp8Y0WI6nZfB7UWsGHZ/OmSK44vbQkGeGh3WcPgxTxsFetweOOJcpcd+w2GwqZJPtckj3S24wCieqnZGu7kx2kDUgJPKHeEOzp2WmftPiKWd1FztVrk/NLIaZSGW/hU6LsratKgtYR7cP0xFIVBkqafTkSdlUkLryt+Olcd1lFeM7aTAcF8zlNBl3BkioHImDgJIQgfOKsywRJPp1MfwImj2dMP92dsH/qc26RrST8yqWtvfoOSZt5sNDA74a09QW0Byo90KHgX0bjXU4Bdn/OQ17vZv4LN2lmL92YFjcjXQdtBySsvY638lJdSWAXnQGTB7qV0fOaIlC5O/dudSy324LljqSOT3BsRyOuK2mxDZzdrcQO6aMIqE+rQItiRkjQoAZBNtAQjeoUJs+I8O6lv9XZceRdlsRzzuGqOmsC2O3T61rWrSGt6X75l4EVKjP9Wl8+cc1S2ZzOslI2oC/12yMCX2xfVlKzP4Ykfoq16lDeOJFhxJwA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	s0moM7KkbIEsWGLd7YepLbMxVWAFwqQaWQOGi3ULO9v72GK6ywfvk17YZNs2g23xbj4w/7YgfwERQ1vhSuiApeKjMKRwFIBuiWYr9wERZMSy6f8jyxpD9R2eK7jZgQ6EZLkmWZKZJs6TwwlY835OulcAKolqllb61tACkcktMzgeCqKsM1knuFrkjpzownXe4DBXuJ/DeLim+Lml4YPmm/dE1o18E3wik9ecMGxXpAQDMxUWxcBE1efHCegAgOBXBnXi40PmZzcXbygFuWTGRCeBVNehGY6HpHalgpS6taq7N2MdMI5Cn/zosMc6Fj9AyOWmvkAw6JjN2zMLdgnlPifooJ+WVWZTcd73IEo8OIPjuCEWTLZNLzRYEvKwfGL5ZQweBVXzNEmqKE52cZNL2czVh0IOXeFhM1vSN5PAXqEOxmDw+aCZg87RuJSd/y8V
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:13.9151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b6669e-2dc4-4e47-bc14-08df0476c957
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20079

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


