Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD8C52D6F
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 14:37:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.66])
 by mx.groups.io with SMTP id smtpd.web11.212125.1724078266000646425
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 07:37:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=BgxrRnbr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.66, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL1T3mdi3IWw5bY9V7k4fV66KI29a+Kys1Rd/aGoRHy/C9t+HhVdmsIcnlRAiZZP8HWV0Jsi4db2qBMIEdy8DEkjAeFM6kyVThngZH9AYwS3smsp5E5c8SsCnT/q1peqgJVcFR0u4EQv3TmHmLYRWJWYqvIGMhQ0QYxVGfOX5312TowaOdvDmLgw8Ae4eVweewvuuEWv3+195/mIHxuchWbEt79ETk9w6iucIrm5FakFfdtBRBuIkWY88jUIzWME+c930HBwiZIe72f938VZjiupOk4MzNDjY253OgGvKF9+nkmWlhbl0BgpDc1sFrnJz+WPQMI5E64kv5t0pbPWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=YJ8GesjQTOOS0RBxA/oWQZcL1SML7XyjoeEaPYeHlE1kAU+FAO7IkhrYCczwHyPR+43z8PRnDRf0uzQUJk7uXDFPnAcJbWTNqCYZk0FVUyKIWG/tJOgL4qW3fX7sFXb5xEgCfcZZANpSpFsdVZbD7bzEcl8kEWRFTsaSWjmLTE81VQ+Lqma59A720dj93M2JwGPyXbuVForitJAmXfeesEWeN0XQlIiu6gQ3bTgrBq4YiZjJot94h9o8FcOT+6OQgOsLuHpFvdDNY6e9VLGW0UtMdtIH3XfwqWtx3b0CoUPh6v7UOamOC6F5JmLHCbqwRfnxvUNsAi9sjpZPGdxyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dNQsvmqcjGcsYHmfLd1+OIsINyp91qMAIiiRyt1lck=;
 b=BgxrRnbrTKEAFvAvEal6l9ddWGfORLFSWY/qYSzRDSbMZlpSgeSAqmPq93wUB6caypE1Hhm5sp5R/wI3Ehbo2rIj5s0We7IFqJhoQnoXK6+Wt5cAy4KgUslB+osJQu4D2/62u3dywW87jzbZ3r65R0oimllAbkR1H9TtUA4wy8SSrYT4fk229wtJE51QuZ5OhxAld1Pd4nLhsvFNKDNxSz4P5H00PC+kUv8L0DbYxWV0Jvpy43LEupwD1It2GIeBeM9D/qWij0a4cGy8HNsBHFGt5bfQlBaO0oU449JwkdZXeNE8dqOmUGbBKMLx8fMzePOwdVMBfoKBQbmjG0N+Lw==
Received: from BN9PR03CA0066.namprd03.prod.outlook.com (2603:10b6:408:fc::11)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:37:41 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::ac) by BN9PR03CA0066.outlook.office365.com
 (2603:10b6:408:fc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 14:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 14:37:40 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 08:37:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 1/2] ui/knotty: print log paths for failed tasks in summary
Date: Mon, 19 Aug 2024 10:36:12 -0400
Message-ID: <20240819143613.1380185-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819143613.1380185-1-chris.laplante@agilent.com>
References: <20240819143613.1380185-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: d5568d4c-5285-44b3-bff2-08dcc05c7ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M0+RP+YhZbNc08WapzffqJ1Qca8zabKSXdn6hW4/a3+OwP3nNk+cbzLOcon+?=
 =?us-ascii?Q?b78A3mdkVOjKHT1IRU26Vn7LVL2usprQlMXllcGY0V4pmJoK/IrnRJteKG5b?=
 =?us-ascii?Q?f9L363NUSwJ09YzrD0ykfszcnJFhmMhm0Z6dUDJPhZ4Eru5e/wtgabEmXGhJ?=
 =?us-ascii?Q?S3Y2tA9zoI3L1iYg2lGTSV8cRjCb+czTvrbIqPYtwsRxNxuJ2jzNNUlGCRmZ?=
 =?us-ascii?Q?6Lqrp5tim0LvAb2eQRK6n3gtxs8Oaz6G/COmrY2wO8hREYbzN5NJzGbjUBZD?=
 =?us-ascii?Q?Z4SdHC9Zd3dQxqQTpNYPfzBvZUC+ukOTXrQp8ZNPHFZqwuJ5FDuAuMCZMq4d?=
 =?us-ascii?Q?cP6uHNu/wSI1NtwVX7tJsdIHAykIyvFDhHjvqHvJALeMePXybUwD9yI+oNwQ?=
 =?us-ascii?Q?VskZLt0j8w68LeiUVilaB2yj1WPx0oAY9rDQQ9PEmHkYvRewLV+c/fk9Es/T?=
 =?us-ascii?Q?vxINt1X1VJ8lHnhpo5HVzqBj5mDd5fh4IaE3OcEdg9w76eJm+MOy3k6wr+iP?=
 =?us-ascii?Q?MkpFWt1f+S3nIVig3kqCmefByN61LVX5FX3yooAbF+x9bThlvV1hnzu6NU46?=
 =?us-ascii?Q?JjlKCnhVtc44dKUKTSgwRBDpjF8BIopZpJsArtq2Xqw7bXGlwRH3mCz6Z71v?=
 =?us-ascii?Q?qtAkJqe3wWV86sPeoXwOA/Ep2+NOePN70/eMmyXqVjYOV6Pf3/O0DY/XIwpK?=
 =?us-ascii?Q?0GDjOC7hQ11hCxr3kjv+vFvU0qoLuf//wbQYySDGmG18v8/+FY593xe0smFV?=
 =?us-ascii?Q?kRpPycuv3w6oaoHCyn1dsIZ/oNLV0H+UtYNDi+WERcNEkPDp448OD7zevHzP?=
 =?us-ascii?Q?dfEikxPoQc+0CbXkeLiRbeHzJNEDgo3TkLSvUAdijBzdOLjvaD+5QmO9wEIA?=
 =?us-ascii?Q?SPmPy6qrQYkrzLW/Rd91CvS9zAQPYshkUAmQAvQdpWS4bCtnGdp6NjsXJFEO?=
 =?us-ascii?Q?B/eu0WpVHrjh3woLE1mq4v99gTTUtc4fth+cizSnVuOOrqCwSCQkw7sGTKqU?=
 =?us-ascii?Q?CJjTjqp1m/5d3zWkyCZza61Kliyfb2hsXB80OcMTl9bHfm6iZjKyZZn5ftZU?=
 =?us-ascii?Q?B8G47uWBj0NrySyhiFTSigH9MD1foOxLfCxfmHp7axQom/XUWNPzX5weXS41?=
 =?us-ascii?Q?htt+xKBPLtsKOWUK34ybGzxXDD1NKsOvtvvW1zLUQ2mCsX4O74qiKxhfrsTA?=
 =?us-ascii?Q?bm1EmPWRzfFdioik67LjpfhbaerCiuGJE4SfJFHq6t2voQcuDylbjvsS8x4W?=
 =?us-ascii?Q?DYWBCwlyt5sVmDpkzs106/JZ4+GWzq7YbUrIhrPdk6FIBHuAbQ68ToVldNkn?=
 =?us-ascii?Q?/oFv1cdOSrrjBwegDbQm6xXw/hivWIuYmtj01yWaf+aYPcS1/0Y2QhvgRJJy?=
 =?us-ascii?Q?Z/9xiB4hHVhp+LtzqdOw8+4Z2esKTadhkzc+GT7ZiCsjLfDxRw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:37:40.9762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5568d4c-5285-44b3-bff2-08dcc05c7ae5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 14:37:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16497

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


