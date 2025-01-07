Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F1BE77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 21:56:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.70])
 by mx.groups.io with SMTP id smtpd.web11.4658.1736286992917912537
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 13:56:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=XZE5j9hD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.70, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oROqpThYQaVTEYhtMpn2OFeLQ5GVDIc2mI04dpwTbgS19zoWl1oEfPp47bYfT+J6wnhKURKCbPCn35Yc+pbxrjVekm3C5hKGZ5x8juPv8FiWSDZJpwbOZ2U6+YFWe5QTstWUUIGnAVhgUTbgO8mXNyBRhfex0zFSxWhg5aGbZzOqdRbdA5usKHcA8gza0NUHBBbw/3cuDXJveqOwapbVNDpz3BOxCiQxKrj8FHdgF3m5tb2Wb8e0cMt5IS3Zgw3bDqNJ/4WQSYWtMEhP2tS20FTKfF2mlPFIkv8LeoMc/y1ByEEzSLYhtyIbnRHwl7z/x++3X0U2zpbPXEcsGpziwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGo2JidcDtrzql1l4Xs0O7kDYBh8S4Q60n2U+xpvneQ=;
 b=QQJOnul2Z03KTuTksgi40VyxNQCrkqi7Mdx2+u2wWLq/xYpWtIYsc7d9efPDyGx08zzKej9m53ikvpEnC8WtUlCo9jXzhrP8JKZRB+wPRIEqfj6IvAYrjsjEdsthu3F2tXCjpYAMFBMoXl5iU1fjVnqNMAJgdbQW0GP9FRch1mX40LD6Yr0Fec2RNb1kpgUs/L6drkOg6Pu5wXw2wgbSqzob5Uct7S6TUgKL2fmH4QFjMmA52jEo++wEjmsM1r0YyKsZMpYz5RYXSYIZdZK6EJfsSy9PHl0EYV24izrD7ZPCS2oOxtE8eff01JDgF+0pq5t01T0hkkBvyKdwtJ8vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGo2JidcDtrzql1l4Xs0O7kDYBh8S4Q60n2U+xpvneQ=;
 b=XZE5j9hDWpXy+iSefkHlAcg/L9SS6IhKQvKgUf3rcUpsBBc/olaYRuj0pl2tvDWarQ1jWSPn8dNPc6LNWMRt0F7kc+7B7OOyPCFfakTbu9pbKh0zSOkwIigc9cUZ/s40cqgAfTpSGNU8R1wBz3GyeeqxQXY/Ij93SVFtUZ02hRhHm+/Nh6kw6FJeBu0FfgovA1YzGdFZ5ku0PCddbujIIijQxvwgS1z48MOulU5EOpxykP+A4oG8ZH9sgQTq90boIGiu+Xvu922r5FxJlKSPm/lcZeEnjLLg4Jt+QnEK2k8A0DhFM6stmhe+Zkj1HMkc/sBo80Zes8D88ioVK45AbQ==
Received: from SJ0PR13CA0150.namprd13.prod.outlook.com (2603:10b6:a03:2c6::35)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 21:56:25 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::16) by SJ0PR13CA0150.outlook.office365.com
 (2603:10b6:a03:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 21:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 21:56:24 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 14:56:19 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Chris Laplante <chris.laplante@agilent.com>, Richard
 Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][PATCH 1/3] ui/knotty: print log paths for failed tasks in summary
Date: Tue, 7 Jan 2025 16:54:01 -0500
Message-ID: <20250107215403.251838-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 50317ed0-fcbf-445a-ee3d-08dd2f6620ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S5eRjrGMmVHzPck++ZHLkLN1GKCXgDJQ0VMxVfRWzchO4KESb7izCaf+mZw6?=
 =?us-ascii?Q?yWjJe9uFYm1mqNHEhkcKXVUM7Afvar8lh8uRh85hlAIhPmTcTCHP7M2SKIMW?=
 =?us-ascii?Q?EPRQiTHPD8IKQ1MwvjQBvBGy+UtVLVURTgve7MxfKxWRJq0STIGbagdBiDHQ?=
 =?us-ascii?Q?RzGgPCoiHRd4i2YT5ruaOc1Eyl1LAVpAF0pxqXVgdv7OHUEdhJT4owJmzlB1?=
 =?us-ascii?Q?iILSoVoiH4TePyQdewTnwB8AkZuyZOhoqCBwg1EZh8syaAET5uWDOeuhdzLX?=
 =?us-ascii?Q?XHgkskBinyIACAcVOHhzDn/EqhkIegpZGfLMO2YsQ08gBTsGimpyxEWda2D/?=
 =?us-ascii?Q?He8loReF7Xx2qL11Lp3k13NksKhskbYJMKAICLSTuW+SM/F74kDcQTNsvkph?=
 =?us-ascii?Q?DZrTGDPPGzqX1O2hkK6gwh2STHwJGebyF9oqXwHLgTpx+U6u9nWGFC3u0I1P?=
 =?us-ascii?Q?9rmlvDKo2PVVPKGAaWg9SJnbJNdLDIWOMRcW1GClOHnRgX/OsA25kkd1Kpd1?=
 =?us-ascii?Q?OyMbPB7oe6Rg1aYmWzyM33Ly/TU1Wb9BQowbO8YSExMOaFaxjP5X4gV77DjZ?=
 =?us-ascii?Q?WRjZemoqPdk/MxQCFoxDsHVLVeIDorJnHQrMxZNoV2QxBLcE61tk9LLOPC7b?=
 =?us-ascii?Q?1nkXIArfnXB0ThyUr4p9A09B1ImdLJi6uG60fIMtjaH35oJ9xCHyT0nAc54T?=
 =?us-ascii?Q?ub5o/2iqHVr6FZreMCpTNZyrNxg/qAz68jmRwY0340sIa/MWGitCRJMmTo/Y?=
 =?us-ascii?Q?mzYFGnNK0MeB3xTK+gL8c8y0qBSsXiyQsEd+5oU2J38TNYPiga5drk77YPDP?=
 =?us-ascii?Q?1C0RuF1xUVy/iGfQn81SCj07DNI/zXeU6dp/qkSMiqAN2YIrXVvwJtssDcw9?=
 =?us-ascii?Q?hr5CuyNB2erohCg9fCQO4ud6hhlWvt5kHJgivnqv51ffINl/n9cFIV99PIvK?=
 =?us-ascii?Q?4PhKWFhx+TbJ7guEeRArnqTylgvuehCt29kv9xCULy85NE7Vz9mGmQYWPkpN?=
 =?us-ascii?Q?IsS2rgfxtVyJsJ7NxM+3pyimwA6YAjfyJhDYRjIaEbr0bbcexbjNxnT5xdN7?=
 =?us-ascii?Q?tb2po69NVSQswOZVQ7uBuAHDDd8nQW0erAbVJ60VKbHKFXMQ15eakaqYW2i9?=
 =?us-ascii?Q?muhTHgurS/ofoi6ITmmHw/nyH6DBMBUaMSlhWlkGilALh7reOvVxYTTnNmqn?=
 =?us-ascii?Q?xtnvLQV1Fn1ylyzTYYadw5+is3FICVyIRV8mcucMPWBEsB7Y5bZrDqxvWHoX?=
 =?us-ascii?Q?t2f4nuaTzJpqvm6XVlhaadzDFvcWbo7UsDtSj41f1mVE5E65G6DXW7IBpZ5V?=
 =?us-ascii?Q?94PscDDBm4m/v9chleOaMkt5mU0ppAgdNQ5SiLAgbfxs8i19z8CwGGjgV34J?=
 =?us-ascii?Q?pXCCGPxL3ZQCCCyqY3/zZsUg3Q5Bi6CgirAVEQ9j91xdB3jb4Vp9yDUAxACp?=
 =?us-ascii?Q?Yl18dCbRThY=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 21:56:24.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50317ed0-fcbf-445a-ee3d-08dd2f6620ee
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 21:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16984

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
2.43.0


