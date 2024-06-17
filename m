Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BECC27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 20:08:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.72])
 by mx.groups.io with SMTP id smtpd.web10.67459.1718654889025526178
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 13:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=WexyLqZ7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.72, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwJ4aQ5HtOag9WruvxoHMbZEOZctlnggSUl5zHdBuJ8nZic0/gAVOh/xuwAcugu4mq5Dctjsc2O14IvsVxH0jHyvUXw+cUTNiZpLCaYTypyz4dkDo3yUSwfc8d+l6CVnCF60EiznmJyz0TFNUFgxYeSvm3MfwU76YuR7Hp6lkgjvl3XQNV0H1VZwnUCcabodCatxrQi9e4VwCdBEsLF9Dt2vLyQK4FpGmqlHtTMTS5bpMdSCKUjKJEzxEhOTiReYD7hCaZ6nNoeL9aP9Nkl2RrxXfpn+pJjlX0INzhl/++OIVj09bVE2E6V2RIh2Wu3LuXO3tibbC6XJuAApPlFzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=KgrzX/82bmN3xMe/pt22IliTE3+M7UcqZSbIjOcHgg50z+LvLJVasNckkbtEYbTACHrL2xcMnuyNQZTcMzXO2e01lhshCim0ara0Sb4NIiusJ5qzfjDqAchb6orWRJbkoZpORhTB7FOQL9jd0ewR1P0okqi+dp2CK/UgWJ3njih2OfPfEy49zM+cOJFpz30079M05DXQEYB5XEj+/Nhex+0zLpHB1TLCe7qXr19m1s1JMsISii4vHXgOzjQvhv4/bXMkD6fW221fPiCy0rvur/HFFXhyQt1n0IyBvs+9eNB+xyP3G0Z7hBZ2FrvFHrMGgixHVJg0BCXQ8cJIoG2PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=WexyLqZ7iRIFnhKVDKeDSqM81FenEkrzbdJIqYpqbntmVT4twl7q3dsI253c0k2KgT3sHV8kAnQKMI9daSqlMOQmCpY4+Wvkcsk5QZar6k/k90ThYwMgrS3HDd41aajrK5e9pmxO0r6LZ3hsrgXrO0RzRTkD/YDZA78+SCRK4zoO30uQNjLvzCRVZmX7sMpeLJmPsKvtbG0VrzMEXJWSfnKkYz2N/1jSF6sLDgmTA/2KFTQhW5nB8q7MdzYfMeeZHWi33HwQXfFPp2et4WKTvEtoZs152MI3aZfgxiDk0EehTUqkn3LI54lazZ5vRkDWpDAwlJ+DIBxa8ejsqqT6ww==
Received: from MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 20:08:05 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::36) by MN2PR05CA0055.outlook.office365.com
 (2603:10b6:208:236::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:08:02 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 14:07:55 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [RFC PATCH] ui/knotty: print log paths for failed tasks in summary
Date: Mon, 17 Jun 2024 16:07:45 -0400
Message-ID: <20240617200745.1254638-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f3efe4-44e5-4129-0215-08dc8f093197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lwwsZu+9KZqVSfFUF0qiMvz+7gL5CMISkbbH2eP9YBnx3R/h6JXitqfcEsdo?=
 =?us-ascii?Q?WIZ3lp2H4VvHjLizBJx6CdVmX7dKEaAC7OVT96UOFXR71nel0XQFps4F8FPp?=
 =?us-ascii?Q?GQLaHKHzFz6NycAw9Hm8ZCP8ZLQ3mR6A2urfrMRsq6NwnnpS2ISAI2E82rFc?=
 =?us-ascii?Q?Un/xAPsnitmgVZG8vzuNoZZcHx4NC2l2CBQjMCl/p3J+3ju9GL/UgiR5knyd?=
 =?us-ascii?Q?EVd1KP2P0skrn/ZA2RfmI6M2bNMkvTVUqjJYZyVObbtzOaYZFk4KMsJT4kQk?=
 =?us-ascii?Q?GA/UqjzFNT4mw2N0dLexh9wgcS9e844sQ7ZIEX6OkxPdM1cdjWzhLvj7uAfs?=
 =?us-ascii?Q?nK9ARZRDAE/aFowo0x/4Rc51dqVbXJ3q3YdKnnJdkSLB+FXCWLTH/mLfeNh2?=
 =?us-ascii?Q?jbDjvmRpTTFgQGiULc+VTxh4VsbISRTZY5Xz6foFYbFwTWyFQ/++AxqiGIKa?=
 =?us-ascii?Q?LyB/sdVcxMU1ksBY18YpDybdA1hS28z1xXdOFmzPBISjt+9Fips7BniIou/X?=
 =?us-ascii?Q?f6e5Aeodb4uKqhcavJMrrOlMO2buBe+3C62KSobiZDkvcXG8FpDHrWp7lhES?=
 =?us-ascii?Q?eCbBHRVfw9BFRDoWCKwyD+i7BOu69HWsCdi91UvsQsUo5n2FR1kTOGMNxYuV?=
 =?us-ascii?Q?Y1USW9cf7Ev98IjE8B6FPOVjUk+wH/I/xgb6ZGblca6rH1yC9VVUZnNgoDgb?=
 =?us-ascii?Q?Bp2m51wflkoMbhUjAGrIUUGj4BcLsWuyqWLic5S9Vx4vZ1S8Spz2poQc8LET?=
 =?us-ascii?Q?FEnCstVT1zap6ac/7V20Q10DwAeB/z8yjMC9xB5RWXlgTEtquMn/tOwom1c5?=
 =?us-ascii?Q?OIv4SLLkItfkLsrMDdiZ3Qcsd0TyReW84ZI+HeIpsPEwrp+1dPRw4PkZLJqP?=
 =?us-ascii?Q?sYLHxx9eeMSJ6CzlVPcBYeNBV/85CAf5UB7YIHsq4TRvNiyHTxPMrRFXvvwC?=
 =?us-ascii?Q?rXfaeQqo5aXu12/VIgHqBm3sIXzeGUzY8VW1eS/MYgqmhTwXE+MQKNxYY5i+?=
 =?us-ascii?Q?S29hzsxMg75lkiUzMx855oP78qqHJgQMrhhuzh5CzJBAX5Cp8Ejxr8LDa3J7?=
 =?us-ascii?Q?Cpo7tLpLYNyENBlpzHMVkQRGU1YdOaokEWfeFgpM9WOZ0lF6eNnMpvtCyRYf?=
 =?us-ascii?Q?yI3ZMEotTumqXBEjINUz8EwOKh0JsaxtmN7jXBik6Ih3Iz3gSV06lcdzqTY8?=
 =?us-ascii?Q?IEEHxQKeJyZ7hmUeOa7LBeNjK+elA0Vov8stamxfuLQ7fzrtE0Vavlq/mSJq?=
 =?us-ascii?Q?ch8pCsuZSV5eFQwzgiFiOpOJFyoh3XF42ZG+GpHP+ou0s68JVcmCADFU7+Mg?=
 =?us-ascii?Q?Dw9pJAGaEBioeLoZjEUjq4zlfkEowDxa8/UGTI6uuqt61yWYBDTCrBkqP5pb?=
 =?us-ascii?Q?QTFJSAI=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:08:02.8600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f3efe4-44e5-4129-0215-08dc8f093197
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 20:08:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16364

From: Chris Laplante <chris.laplante@agilent.com>

When tasks fail, it's very frustrating to have to scroll up to find the
log path(s). Many of us have the muscle memory to navigate to the 'temp'
directories under tmp/work/, but new users do not.

This change enhances the final summary to include log paths (reported
via bb.build.TaskFailed events). Here's an example:

NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be rer=
un and 3 failed.

Summary: 3 tasks failed:
  virtual:native:/home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6=
.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-native/=
6.5/temp/log.do_fetch.1253462
  /home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-linux/ncurses/=
6.5/temp/log.do_fetch.1253466
  virtual:nativesdk:/home/chris/repos/poky/meta/recipes-core/ncurses/ncurse=
s_6.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk-lin=
ux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
Summary: There were 3 WARNING messages.
Summary: There were 6 ERROR messages, returning a non-zero exit code.

Each log is rendered as a clickable hyperlink in the terminal. See
https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/knotty.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f86999bb0..5956ab177 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -640,7 +640,7 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
     return_value =3D 0
     errors =3D 0
     warnings =3D 0
-    taskfailures =3D []
+    taskfailures =3D {}
=20
     printintervaldelta =3D 10 * 60 # 10 minutes
     printinterval =3D printintervaldelta
@@ -726,6 +726,8 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
             if isinstance(event, bb.build.TaskFailed):
                 return_value =3D 1
                 print_event_log(event, includelogs, loglines, termfilter)
+                k =3D "{}:{}".format(event._fn, event._task)
+                taskfailures[k] =3D event.logfile
             if isinstance(event, bb.build.TaskBase):
                 logger.info(event._message)
                 continue
@@ -821,7 +823,7 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
=20
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 return_value =3D 1
-                taskfailures.append(event.taskstring)
+                taskfailures.setdefault(event.taskstring)
                 logger.error(str(event))
                 continue
=20
@@ -942,11 +944,19 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
     try:
         termfilter.clearFooter()
         summary =3D ""
+        def print_hyperlink(url, link_text):
+            start =3D f'\033]8;;{url}\033\\'
+            end =3D '\033]8;;\033\\'
+            return f'{start}{link_text}{end}'
+
         if taskfailures:
             summary +=3D pluralise("\nSummary: %s task failed:",
                                  "\nSummary: %s tasks failed:", len(taskfa=
ilures))
-            for failure in taskfailures:
+            for (failure, log_file) in taskfailures.items():
                 summary +=3D "\n  %s" % failure
+                if log_file:
+                    hyperlink =3D print_hyperlink(f"file://{log_file}", lo=
g_file)
+                    summary +=3D "\n    log: {}".format(hyperlink)
         if warnings:
             summary +=3D pluralise("\nSummary: There was %s WARNING messag=
e.",
                                  "\nSummary: There were %s WARNING message=
s.", warnings)
--=20
2.34.1


