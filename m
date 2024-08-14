Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D45AC52D7B
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 13:51:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.69])
 by mx.groups.io with SMTP id smtpd.web10.98401.1723643465693060042
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Aug 2024 06:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=gS+nOcHs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOUCFfxprI5zZD4cSbt6N5SUBHl8rVDYPs1td7Y68Q5g2kB+XEX0kqOzHNTw/jfDGqKps0tBUzUhjwKHethP1frnAVok2/Vv7jLULn/w7eWyS2R382DhEhe8YARnQLSfBo4oDx/rEuSlhUkOXyVXFGYR+ozXel21GW2fvzXV2uecPktnMLkvXoVO1zrpvv8u+S+iWA3m8CGQuJT5/99k8+t7NgLYhTKpsp9WJYiKliZxs5yEAhoVIzdZ6aQd/vL3ted0JORddV+bknnzGNygj9Kz3+HmKLHjFkpH93zmBfR1mIjQGm79Ko3wxxUg7GXPWPcd46NpwONlV5Eahbwcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=IjNtDUei9WRBVrf3ajDQDNToFXV12MWn9aJfSTTXvvXgw1MBgA3eULjG1iVf7pMP8WfD5PTJzL6qMyTeyuaED51RJvsJ2wncARaM2joQQOuTpZ6Tn3mc2qZpiZ2NEsKtFlI5kavJCSH/haGYibrIisz8pWJ9+/6lMHzI9jj7KeRhn/PBDLgFv1z+JMkiBBslGmjgP4ecpAAWqEUDp5WONqDfrActopndkGhXI0Kwb9nr6wBj0FclaLk/wWW+a+NfTOmWdsv4Q/nkRJK+twMONFIG9PkEgolaMAS5Kw/w1M5KHz+NG7jAKP6deFSlGpqEboulpccwTmBpdVteGefzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=gS+nOcHszLbhNRA618GWAAF3IVKUW4RsekieAfGK5TfUsDan+tgHinvYMJzeFTiGa9PAOu6DZOyb/YUhAgLLSSocrXzXJx+dT4tGwJMSEMoYIxzJuEyvGL4OUXnyJGuzP6pfCC/uzUjR15+KqmsleqvZ+7llHdstxSfEmKe+U7ULW/90ZaU7Ssl2w1XZI4cHFYGvqHnG8H+/E2ek9gnSmUcgrViy7BGqFFz14C7HCcY7fB1OPQz4eT1V7FV6/rJ+QK9OmtNbcC29yBq9SmEYhGjqrL7YHzNHE614fW+oOhlvydDJw/RtObV36gWdk9B7Q/2n//3K30uFuiUZlK17Qg==
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 13:51:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::9c) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 13:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 13:50:59 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 07:50:54 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/1] ui/knotty: print log paths for failed tasks in summary
Date: Wed, 14 Aug 2024 09:50:37 -0400
Message-ID: <20240814135037.4018930-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814135037.4018930-1-chris.laplante@agilent.com>
References: <20240814135037.4018930-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e932553-e54e-466c-f796-08dcbc682115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uU7WEY0TdlpYkTkcWP724F74ywWvZYNL0qQGoVLIHyi0tjuyftj4OY/Ntlqh?=
 =?us-ascii?Q?SUDQCDFngjQ2RcnYmOrFNLfAAOyF1PL3KZhXRbhlJaXvcl8F3wFqMOC8So5D?=
 =?us-ascii?Q?RAst5b3IW3FupgnYYqWM1YVBD40gxQ3Il6YYtjOEaQM+sWnh1ljqn4Pq8LBy?=
 =?us-ascii?Q?nybSVZCdyjgQrwbjMwwpxDZl+bObP/EsTjNRZMwQ2hKuqsepBzoMcTViCctO?=
 =?us-ascii?Q?mZDwD95WXKQLRS6HPtDi4BHaKFpU6akAe/q5Ptvoa6YZeCGRB7c8GnbeQeCi?=
 =?us-ascii?Q?io3ymvXwiBUiXg6oqkX2bijP+hYhQl8Ye6FCXu65ZV0KTuyD7IWd4Qc15wP6?=
 =?us-ascii?Q?uZhd/XPjJ1NMfsKI+JGZfeLR+2g/Hhn5s9Ttw5jsTfAWC2a78/GWHfpaSjQU?=
 =?us-ascii?Q?vZaG7chI7jYu3EEFWfwEzItQrJAnbAC6UTDSt86iwQEBb1UKUtitWUCITMln?=
 =?us-ascii?Q?bzieNd6q/7pI3TzxmMHBrqgMR0+sdP+wQ6tA0Heb5tU52IXsxl84B1s1Lzg0?=
 =?us-ascii?Q?Sd4a1P7txEV1bsL4e1BQkw+srRp5Sjours1mFPREbyaRvUhVrVNCMBa8xmcO?=
 =?us-ascii?Q?shncfSf/Ce7vENuwbcmV5lIa10R1drTxMgL7IriOuo7IvhBH1CWpOeQ6bLKf?=
 =?us-ascii?Q?VEpxD0ACLtUlhSn+l5IRajzUVKYgKfMmAn2TtVHOsrXuOUSB/l9cBUshEM3X?=
 =?us-ascii?Q?qki+u/7+2ajduXIQPEFMHLTZYXsQrRkeqSP/lu8fBtyKODOnumE5DFmLKfR2?=
 =?us-ascii?Q?3paTKczWW5g3kr9K8gzoKB8+3LUHbJyIjU0Mw3cHIicgZiKrpaUY8RY7g90x?=
 =?us-ascii?Q?QxKgI7zxINenLC5F9ucIrItsEuzhKK86fgbuD+LVfRtoyVRmObfcpMwJyvgd?=
 =?us-ascii?Q?wkxK3HN+cqiQZBf03h5mZ8BbDt9ymgsDJ7F1T1qJPmCAchlZBqsaycYF0tP5?=
 =?us-ascii?Q?KBBSISgAjqC529WoH5LZ56ngf53wd6a7ebzaVFfrxBed7Ccps46iNy4Aec1J?=
 =?us-ascii?Q?+91CD6js4lJMpuejXoJPxXQFusW3cKzcgoxzFLKJVizMt4ReRjM9kSRXwpGf?=
 =?us-ascii?Q?oPavX0NZkL4474+H9cxi3JXmVuMhXqToHyvVvlSlFSvkOXCp7dzlrWFPdyJy?=
 =?us-ascii?Q?AB+6Q1QFhuHyvvt2nulEEygmIPrEwD0ToP9PCgPsOFN4LcdZZgC0L74SMVMO?=
 =?us-ascii?Q?VmV9yK1o7uC5A9JP0NHAHivdZ2n0H4hJASGMaothhs69FlPxxmGwJ/bsOFC9?=
 =?us-ascii?Q?hWdkjJcAXFt4ei8QZJdkqoNaiOiE1rbvCTvEfiRPGzxhobHnBDYznOdtgLUt?=
 =?us-ascii?Q?LCYrhZGRgHRD52cI33/b5BRFKzzAR5HGkL4Iuy2jMBT/6qEf407n2Nv6an2s?=
 =?us-ascii?Q?FHQTiYJ8W7ImLnN1BdQsxz8d92h/?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:50:59.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e932553-e54e-466c-f796-08dcbc682115
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 13:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16485

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


