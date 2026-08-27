Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDDC61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:17:52 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3788.1787861870238931673
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=tW6gLiV1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chLx/v06M9qHy0Ge+A//W9BNdHDBrKXomAyckrx1ds4wh+Tc5aZAyWsPQ3492AyluGxI19R171Puug7CHDQiZfcWGv3c6uZQrxadRZ6K2/uAyk0joNTPRebIuuW0IuNfnDt3lisdrzZTWYJRsaqgMGsK4Bm0qxfDcaS30RKL5SNkkWPJU2jH81qXIxTcUcCDCJF8LkwVsw1USJoAqNqU+QZJTZM2shl6epPxEXKr2OrzGFIgVExE9AFcvQxRZtYYaibafeltS/DdpcjmRhfzvVgzwrm3TSzjK68PQiQFVcyGqhX0Jvr6rLq37lRff1JCNGla5zeOEz3VyOAeEaza/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQPbi3OPhUN/NlfgIMmqGJYORZzhchTxf3oAm+DYJEw=;
 b=ol8PU67tdcqOlan5LFDvDaKfXTkrgQKdIkHpn9NmzTZhfJN+0rci4MUYy4pazRIkvt148fa5NapzFKgzWEddi7+Si+rwR4KOwsiz/ySungWI28G3dOlVfVY9qhV4YtO6d/WJ7U6U1yyX5odxhu6MTkrxp45TCpsikOkx9qCyR7EXG7icvl/VRzFOv08iCA6tBI/PSTRddhF4AJ0mKZcZYT7dzuWh83kfKwe8Hf5jpM9Z7C/s2ppSKsY48PxLi1vGCB97Np2t8OMDPQVA1fl99XQjIMjsrJFiIYrvvP4hm707vvS4qd0KrJ+T1U84pRFO7oLDYYUj5vfljAPqr9lPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQPbi3OPhUN/NlfgIMmqGJYORZzhchTxf3oAm+DYJEw=;
 b=tW6gLiV1l1YDjEsYwbmaBBppe0r9RCOzc85AqdRXx8KO7Dam3z0QqdF5V+/Fw+vUzIY0QCugwoxiKgL7ZNCVZ9nfAw8Q46qatKhk0MhEyYHUpFS6fv0LCqrdVXSj1GjOl2nINP8GbI+hg8v0UIBUXsi4/Udqa8IqOi4+Ot3ZH6DKfbCUXnz6O9qQU0cEiXNe8rFUcvxiGLy+u/qnEtW8edDCEJnH4ECjM2L6bCzT25yys6RA1JMUBRp4g6TFo1fuYNH4XJWsPIHODxZ57IVoyFD9c09a/tk61h+rNmFu0a4g1La6y3xwoj5XmXgrttqwr9IMScTDYyWK3m3cFv47iA==
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:42 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::72) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_3,
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
 15.2.2562.41; Thu, 27 Aug 2026 14:17:32 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 03/11] runqueue: remove long-unused RunQueueData get_user_idstring/get_short_user_idstring
Date: Thu, 27 Aug 2026 16:17:13 -0400
Message-ID: <20260827201720.698482-5-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc8485f-d9f1-4f30-3690-08df04783f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8PjbLDT6PsGACGXylMUL/dVYgRqpD4qYeMKsgZpwaHPScU/SMg2A85OMMS1BKHxKixzll0s/mZNUW4eCRKufrOpURKdYt+PeDshNHO7mNdFAwYP/uFeCQ6Feo1MUTCu28ZEy/sP5iCbUd2barF+4AUwoA+5YlWkhtS2uecBKTvwsHsuwzMGMosgYQ8pv5W7joIK+6f8umUtRLdYJNSXSQzIgT6Ls+J63tkGQUk/Gtof3f+NEcDcwa5fU0vTgQppqAKAAWpopujWissmSJklFM9Ivo/Dfj2ouWLGNB+B/HAuLjr26+ajy4VhFEVmyyPAHn00Bcjt0dTWYPA3z0E7u7A1XH5fEGWALjYN4mPhMLYgXw5QxEIyVUFdU7yqvMczACGnDKSezDMccjUmkDja3D6AarvP4+L3IA+x03jtl7v6OCE+ztmATKdyDGvBk1eu3n2h8M80u6JtvQPVLVCN8GCF+W4g1CBDKSNRCUjiR0CfoOOMdjWydbTvOk+KlR7jw0+jIZM8iEQvStzqocR5/8Q1UMePa7zAKsd6O+gjrc0rPY4KDt1p+rypAzMXsvz93qqQTAYgd3VeTxsDRG1Hg+8MQDkrbWlA+YiOUroqT2t9DekalSi6UHFN+vex1mauzsGGysfgb7cWAqWbhpDv7BMVDgTRhQsietOkCLEfcoWphWw0iBuA2KGHIwkCcKDzj8PT7LuGrC0l0HS8++mpREg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7nhX10+O8dH0NKGphsZSiCNQIeax3w/mtK1HhBuNjuIDOGzA6UU7dWamkvctExV+t00xmWkFJqkaZc4UdK578n7uZoolAdjvfDydHHtcG2+VzPDC7vHpnKXEBDtL+zPfBNatyJpa7TeXXiH97tqxqfoq6hx1Rdti1M0JDG2joXzats3G9hrU311U6nowVJOV9yHMJ4M5EMK8X2cXOLkP1gdbx+XzjaixfRkZhpfvCFRs0Txe0jbmD2LCAi1z/EV9guejQU2a05xkB8czWd1Uc9b9wGOgP9qGPagMiTXBcJwwrhtJkbncFPe+pkg0o4OVKyMjVdeBQCxz9jSo2x6eXH4B7H5R58Rm4yOqRY6xuyv2H7FCJowKrxhjm6mZz/nhMF7P+vVETrLer2Tew0ErDBXG6pMyfwXf7xuFC28d751fPLps/EuRcmjoTH6MwZ2Q
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:41.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc8485f-d9f1-4f30-3690-08df04783f95
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:17:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20090

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


