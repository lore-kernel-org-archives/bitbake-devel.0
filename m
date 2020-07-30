Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.51])
 by mx.groups.io with SMTP id smtpd.web12.5235.1596144508092573086
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 14:28:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=pAsr9K1P;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.77.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkF1UKjWEoaQciYkLkLxU3XipQQwzoUCz7Xx63JeeGSDn7RT7eLDXKn8GJz/4KBAgN7ZWf4LyCK6Xqs/DZ5SoTurJJM8Wj0PHTOKgqwG/Tp1hwiezuAE3QUQf7VccCWP2RXeCvLESdpMJMogFf1MAhDiKfzpX5ncE3CS+YaxYiE9ZmbiyPRNaAIiw4kBIAtcPRj3kKNJ24thFjFhOFCMbsU9oufkHhLL1f4IuiwFi0GMvQi/7h/CAVcRHulmhXr79sM6vFZzRO2KJ5MD+idsU9kOlirGGTdbwryXJAI+nAxgVKDffEB0xd4WbPxuGCZWf48L7UbA3u7X9iVx25yGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsysBjE0sbIQVIVcrkej+20DE6gUN56rbJKvNnR2wYE=;
 b=HIk7qjVmqqMLqD5a8KPHh22ifcgmo6kvKqoi0ce4esIJg6iEGUcBdL4apIwNqs31m/bKqk0q0sZIPzp3RL3ZGUT28Y+hWetM2P7QkIMf29D9c42GpAZoN4aFS+rPzITY0tyTP4ekwtMZwNNB0P2LneeSSR5O+ZzbozgfuA/UgoU5tBjfmQr2eEq6Gc97X+TFeGT/8T3l13idBJCn+bd/483e+K0TiP6p/KAa2iVSJS0zOlSutS3kBEQoKfmFafU/dSaopjX09YXT8r2rYErh3qcYZD4jQohMfyFOlUl/qx1gdxCAh5aZ4ZJike3NBoGMfvsCnoO+HoQkH6bpHOO20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsysBjE0sbIQVIVcrkej+20DE6gUN56rbJKvNnR2wYE=;
 b=pAsr9K1PsDpbo4R5S57yCKP5GeEWcE0ldnAuxln+SWcwrh/Xu3FKs8/AWczyCKEwkSQfk7DVXBti386r4KTrIkrrT4zkE+U1Q8zQncju9E+CiVxu25K5G7iMj2Hx6XPgilML6iv+6Fz14lGjbcfaPv3ZA+AxcPq58ytYnVA2SxL8vKyfmlBDuckB4IJAJV4lLDsE94peb7B5fhlDHHyXR2Z9AN3M45yW2nW6Vs5pnqioKN4dtZMrMGJuNSW+MM2s6T3RfFVRqImrDAmstyHRwNoEVZoindfvpRQ8sHe0Yq0S2JcN/7cesypAqXc464N2jSRbvHNOaS7cOdQuyAUvOQ==
Received: from DM6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:5:174::22)
 by DM5PR1201MB0138.namprd12.prod.outlook.com (2603:10b6:4:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Thu, 30 Jul
 2020 21:28:26 +0000
Received: from DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::ac) by DM6PR21CA0012.outlook.office365.com
 (2603:10b6:5:174::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.0 via Frontend
 Transport; Thu, 30 Jul 2020 21:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT051.mail.protection.outlook.com (10.13.178.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Thu, 30 Jul 2020 21:28:26 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 30 Jul 2020 15:28:24 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 2/3] progress: fix hypothetical NameError if 'progress' isn't set
Date: Thu, 30 Jul 2020 17:26:00 -0400
Message-ID: <20200730212601.80181-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730212601.80181-1-chris.laplante@agilent.com>
References: <20200730212601.80181-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e90be94f-700d-4cd2-7aa7-08d834cf7ee0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR1201MB013894A93CD86EF3DF234AA78B710@DM5PR1201MB0138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6xx1S4puBsnV1acL4PEqqlATpuXV5UiaFsE3wW25xYzcYi3WAWT6WLi69ozdeizLm+pNEx9BN1IGL+E7DAXAWk0lKhg58jPNteqn7GH9HOoPPxDp+2DNcMXKLs59zZElM8GsaD1/Yq0cOdF5ajf2rRzGrgcJfTlVDxtxeC9Nt2T5dC9VJbc84/cRd/fWSrbDtmVnWFJ10SkI5t5B88qu4/CTH0Vu9TdWQcoHevIk3VNxVUTYa1IyQ5L+iFPhJ6lRxpXyDH/aKK2EmJybWGOhsjk+QpfTe3ymnRTDw1hVTDMbyn33j4ICa3Mqri4Hu6cg1ipL+O9DCiFz+ZAxqsy8akVaUo2Rl17v3BNMYOE/zyCjyRL10d3dDtpWcfhdMgHxvXQXs96Gkkwb2yaas3OUulLIyiMKVK5lxuhucmu0Ujw=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(376002)(29502001)(46966005)(82740400003)(36756003)(44832011)(36906005)(478600001)(2616005)(47076004)(6916009)(4744005)(336012)(956004)(426003)(7636003)(356005)(82310400002)(5660300002)(316002)(2906002)(6666004)(8676002)(8936002)(86362001)(4326008)(70206006)(186003)(107886003)(1076003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 21:28:26.3061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90be94f-700d-4cd2-7aa7-08d834cf7ee0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
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

