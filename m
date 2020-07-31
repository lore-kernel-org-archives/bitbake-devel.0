Received: from NAM04-CO1-obe.outbound.protection.outlook.com (NAM04-CO1-obe.outbound.protection.outlook.com [40.107.69.50])
 by mx.groups.io with SMTP id smtpd.web11.21098.1596210212932550615
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 08:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Bg+E977e;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.69.50, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH/L3jn2bYJxm6ol5iAEyDEAiJY+Z0Q3dGwsxD3H8P1J3NV3eRrFrra2rkLjaSVeXNgzDZ6Eg9duDedbRVsWdUq3bA9LojYowgNSfFfdLVOmIfTWnWJCbJN9EhpMC5p8un558/LRiC5NNAqcMomVPuUHMwmoeMKHHgfMMXn6hdDucXFDelU+jCfrGSqwquECe3m1oXVNOSZ0zLFF4ily/Hb/MztIq3zxSOoZAWbAwy23IR2VB8a9YGckhZ4YLD0Mh3+N3NpsQ3iHZ9B+40HaeD+GU6XujmPwBSZQzwrNgrxe8JjCxIa0XIBWet3zITpjDjDC+52N1nawFAZYoQIg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsysBjE0sbIQVIVcrkej+20DE6gUN56rbJKvNnR2wYE=;
 b=VepoSmBMWGSVRHYDq0EmCoNel4BhxZ/0FY0HCLi4FT2TY76HfvM6XUPL3mJ1U4wjRGX7MxPo29vfJ8OrNmRs8ZKgxqYBZgsOTiDkMdANJJ2RoEal52egvJ77LXjzZYe53wC1jcLVQevx7DuE6eCFAc2J4tz8AUF4EbplPq1CW36EvWt6rc01zi68CTYt/K5lx2d6swgoIrwpffLZJDOtgWOVSEKDkJkoIq1CRw8bnAt1gM0bNcXAcsOrx273OnniOPvJ2ohH43deEmWFx/FCD/8nJ57bHBfW/Jq9CQWceXzIyIph2G2iSG8xPnBdURorLfurE6XEIZ/PUuA6cXHCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsysBjE0sbIQVIVcrkej+20DE6gUN56rbJKvNnR2wYE=;
 b=Bg+E977eUSzZmNAX7yjVumz7coOYER9z+v/45+QZVgXB2s3V+gUHtgMuG/m5jL7xAK3690xHEyWBvC592oVWjzXjmAudwhY758Z60nBQ3Zjp5CIMQkv/OWYdXhfqlTUC0cBB6Mu7uODudkDB4bjfBgGyKoOMV8mIkrY0gesb7BWkgG6MeTb8YYgzBAkSvuJL/bQwb+W9foE2FvLvfwgOT9XpqQKNVPL8tr5XjjGXAUk+wBl/azhEvg8tXHnbXFqFIyXkH7W7rIA078bfK4WB+kxt4oaHAiI3CUVvQYzSpcC1UkKeXk+aOiMETLNGR7KCLTnV4JnFc3wfTGaMfBBY8Q==
Received: from DM5PR21CA0042.namprd21.prod.outlook.com (2603:10b6:3:ed::28) by
 BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 15:43:31 +0000
Received: from DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::58) by DM5PR21CA0042.outlook.office365.com
 (2603:10b6:3:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend
 Transport; Fri, 31 Jul 2020 15:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT020.mail.protection.outlook.com (10.13.179.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Fri, 31 Jul 2020 15:43:30 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 09:43:27 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 2/4] progress: fix hypothetical NameError if 'progress' isn't set
Date: Fri, 31 Jul 2020 11:42:47 -0400
Message-ID: <20200731154249.89999-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731154249.89999-1-chris.laplante@agilent.com>
References: <20200731154249.89999-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a13d70-0f21-4836-84d0-08d8356879c5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BL0PR12MB2497181A30FD808C0CD9EC898B4E0@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+zozfFNWzyQ1KzwEJvD5+IB5EnzTukeA+sLzgHOWdui6n2D3zqPztu2LkY1wkDTeJUfO74P/MHskuMaDO7kn8uhC4SAePyOQEWRuxX7UTBA1+mwPVZ8GOrqXjYb0Z2BKHG4w2xpOo0YFPmcTar+m8HYroEwGw55cMUNyUDt7D7sKtUjeDY6B51uaclYdtJvJQfr4x5zREde+Iz/zcYuNFgp+dUU/XsOxcMsF+RBmoSDoTqDWcbVW4QYy/lZkxj1YK051H+63aRZtO8EB/MyNEGzqh7vBO2W6ngxGKyJgpwAApn/LWOCaAWNUWKPPTVuYHBwBtJ0vutS3/fDHZKerixXQcFG5QSpnmXIvQo1C9nwciME8SyYR4nbrPstma59LgCIaUgxUcoOcheNQ8XMfdur7q5oAsvAd4z5nWoiEGdY=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(136003)(396003)(29502001)(46966005)(83380400001)(1076003)(107886003)(82740400003)(47076004)(356005)(36756003)(4744005)(4326008)(6916009)(82310400002)(5660300002)(336012)(70206006)(6666004)(2906002)(186003)(26005)(36906005)(8936002)(316002)(478600001)(44832011)(8676002)(2616005)(956004)(426003)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:43:30.7394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a13d70-0f21-4836-84d0-08d8356879c5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/progress.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index b4e9bf0f..8cddefae 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -204,6 +204,7 @@ class MultiStageProgressReporter:
           value is considered to be out of stage_total, otherwise it should
           be a percentage value from 0 to 100.
         """
+        progress = None
         if self._stage_total:
             stage_progress = (float(stage_progress) / self._stage_total) * 100
         if self._stage < 0:
@@ -212,9 +213,10 @@ class MultiStageProgressReporter:
             progress = self._base_progress + (stage_progress * self._stage_weights[self._stage])
         else:
             progress = self._base_progress
-        if progress > 100:
-            progress = 100
-        self._fire_progress(progress)
+        if progress:
+            if progress > 100:
+                progress = 100
+            self._fire_progress(progress)
 
     def finish(self):
         if self._finished:
-- 
2.17.1

