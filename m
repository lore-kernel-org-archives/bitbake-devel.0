Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55587C61DC7
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:46 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3298.1787861260258695146
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=VzZPG1bT;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.62.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u30qUKMWT01aQ5G8P+XUj5S4wyG+SeDP2Bp5+0kZ5qLzXe7TeYlQSRsx9kp0owgPkHFmO/UaAD3lyqhzHablpTqmvQLAJJQ+leiGQhLvEtonkNfhnMsdLL3dMb9pyndGUChG/iFPQZ8lDBmP0pwJ6qrKCmf9+MwtMSn4Uav3WtErI74nXbrN3M4fLuE2D2FusISCLs1enXnPw/rPv9LvpnksPU07Jf190MWqbbd5RC/QBb3yG8ZiGAYm/Yud0O3whN1G/s6HbwlcPzpZvLLcHQn25M4qCMcAZ7ROANHFZwNPbahL9Ewi+V4T5cQ9/M+rStqZ4lMSOMW6bkDE3bCHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feCHibeONQxWBFb5YmDZDJxkJMOQaACQYjBFLBPRV6U=;
 b=Lhh4AUOjzEgAqU51rdOeyJ0pJunY2fJvHG8JwHiqbkZVgyWZkON+SgPVCwEeJ11lfgWB0IniXP4uxPxKotbi7E4wc4a5PgnQTXUiA4sh2b9ScQmPPdAh7e4fRIF04jiAduGemXMN2LZd3pQ6oPmrpYCXELn/Uyx64wsP3+T5+QvgRk64UBdicqh1+2leLiEq1rqHBEghf63pu/peYJYIKwlMS/cteqy7R3rlFDdHfAHVPakc5QLslOMtoznmuKqfwwxe9cITuDRUPPZuWmSf0LNOXdSCTf3++5A33Pc0Cx4bvBXQpMIo+x/6SdWjjC4rqNpFnjT2id4+aowujH0GQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feCHibeONQxWBFb5YmDZDJxkJMOQaACQYjBFLBPRV6U=;
 b=VzZPG1bTvaRB85k98qr7kGQSG4JaPFjyga5L643qVB5143TdpKSPfn3P3g9RvcwS0BhB8zujDnDa4/dKKqWGnsQih38A7753tW4XajfByDZyCNYQ7A9UVHbQ6p45TSCSzLPIIGnoUlTC0ilU/lcVEnvxvRAb0/UBh1o1vxTnjr8I4qAJZCmx7SBclAQdKRyCJ3ipw8wJsp9r9fOMSt+NQX0zOY7Xk9Rcy37xPNU1+p1Vtx/2Rt3sExSWn7gaa3ub3dNMA/VlUm9ZNJAalTNNsNkVbCcllT8Zze8DevZmDPmphr3zxcUl2eylGJBwGfrld2ZvYDKPil6SC5aBd+DLgg==
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:29 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::1c) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:03 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 08/11] runqueue: fix remaining attributes created outside of constructor
Date: Thu, 27 Aug 2026 16:06:00 -0400
Message-ID: <20260827200603.688796-9-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: ff762678-e762-47d7-68b3-08df0476d249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ZYdcK0MME+Cfx9+qb/Tz+xgDVgwDAnz/yiooD32ZZ+YN2o/3CAmzrDvCJDeGSJO84LdCUk0+HFNUt79obn0HcTi5zX01KtnOMMYmALKlcgI9rkOAEgvkQdbosSWr7GB+/LE6dn/STWuM/HFtJYl0PsgybJHXf5csSOa+ktvgkM1wtQFliC9JmpculhQtnNabiXCiExFmMejduwXD3f3upSAnblPUqJlxYcR2C92j2trzw6QoURD5aHDX5LlrKOv8fLGfHIR3kbDOuBaF77YdPOAAItTLpLZOjRj1tOHcOZ3HBhDuae4Cu6QbjK2a+yfoB3DAL2bovNoVYndr2Lra5vWphAoZSpEMblculfNJ+4sbFavhuwZKUYXikqmfUOBDUyJw3mAD8W4vdUBIMRex90TY2P3+NQwcUUxtELb4/W0h2TThcvrDlVDSSiaeLfVuDqw4AiakJCKRjEFvQXYMcYLeivP0kNaGIYwiXuZ785ml9scPIcusEMhtHN+6aVeblEE30lHtdX3eA33A2Sm0tXv6ArDrK/tsQnMdMwaBIQgA67+69mCcdG1q+W9UA1jdye5ryoTVfef4RAToltk9dR5PoOXqn6Qzn8as6sp2z72FFH8QCjn0LK7ZYXlbYwsDrlKQLFWrn0E/+NmD4QORH6caxBS612+KFW9hByxJfauqGM2XrHKAANAj4dKR1DyblXPonnAmVUFaYk7YBx+k+w==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	TDnhsWg9Pk37bRpVv+5KSbJdw6prV0krO4WeUmgyst0wTxdIVW8O+iNsbHSe7e9FPlBdMTWqAxssi1KPutgx2JevKuElVYAoUMhM65+7UXhtw9pklR9/EW4r2crWBjQXtzTLn2dJkClLkoS2xuwywn9IyXoW3nx5AnZVsAW8OdczO+hyI5Ht+raB2T+O09EJASz6cD33YWJVkPnomoYbckUQAd2IxDvKNzkpoYfH7ZLGYUp/sUJ1da57aCfKvtcd4hmEi0aij2w3TADYpkld4qs8AyhITzeTPnP1kJa4E/8RkhuTljvCuq7PS5YAFJD7mWWjChTX0dUOfZMcWMIoWHcBseZbnf1/B+PKbgkDO8f/MWiONZsFdg7/CUFRaKjdUrwjAUctf/DzQt0w8pdZbsTwmbp62vRVMLHynP6zAWiqLeY2T9o/WOP97ZJhYwKK
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:28.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff762678-e762-47d7-68b3-08df0476d249
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20086

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9325bf356..826801855 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -488,6 +488,8 @@ class RunQueueData:
         self.setscene_ignore_tasks =3D get_setscene_enforce_ignore_tasks(c=
fgData, targets)
         self.setscene_enforce =3D (cfgData.getVar('BB_SETSCENE_ENFORCE') =
=3D=3D "1")
         self.init_progress_reporter =3D bb.progress.DummyMultiStageProcess=
ProgressReporter()
+        self.target_tids =3D []
+        self.runq_setscene_tids =3D set()
=20
         self.reset()
=20
@@ -1354,6 +1356,9 @@ class RunQueue:
         self.rqexe =3D None
         self.worker =3D {}
         self.fakeworker =3D {}
+        self.teardown =3D False
+        self.invalidtasks_dump =3D set()
+        self.dumpsigs_launched =3D None
=20
     @staticmethod
     def send_pickled_data(worker, data, name):
@@ -1697,7 +1702,7 @@ class RunQueue:
             bb.parse.siggen.dump_sigtask(taskfn, taskname, dataCaches[mc].=
stamp[taskfn], True)
=20
     def dump_signatures(self, options):
-        if not hasattr(self, "dumpsigs_launched"):
+        if self.dumpsigs_launched is None:
             if bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO not in self.coo=
ker.featureset:
                 bb.fatal("The dump signatures functionality needs the RECI=
PE_SIGGEN_INFO feature enabled")
=20
@@ -1891,6 +1896,7 @@ class RunQueueExecute:
         self.holdoff_tasks =3D set()
         self.holdoff_need_update =3D True
         self.sqdone =3D False
+        self.taskdepdata_cache =3D {}
=20
         self.stats =3D RunQueueStats(len(self.rqdata.runtaskentries), len(=
self.rqdata.runq_setscene_tids))
=20
--=20
2.43.0


