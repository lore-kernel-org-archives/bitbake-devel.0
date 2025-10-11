Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF12CCD187
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 03:11:51 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.15])
 by mx.groups.io with SMTP id smtpd.web11.4393.1760152305419253158
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 20:11:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=Mo6mjoZ6;
 spf=pass (domain: axis.com, ip: 52.101.72.15, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8h4hTOsvdxFSV9Uzr2V3zQVAajySBVUJpGPeGoVtO9di252J08OoqpyqUx+F+ZOBtdTKOUk2C8nJXVb+LBlB5rEmzpcmKCW4RJ0inIxDqkuH/vHG8ad5SAmSGu2q/lox6+K548W7fQBn5lDa+OXmxKP/r2Q/Uh7NPAeUowzZyb+g4qjlFX6XpljFv3Rgk+a0yiQrYIojnunrTwFZdvNJjnQYh+7swfuoQ+T8UtFvPjVNYvT29fDicEdKMKXtSRcM9/58u2g6x3IZEqsNs/LzTP3sCLhdmXdybWW/UzRPchON8pRMmxjJvgrIIIrfA2GUNpa0fGQzBUSinwrKwnXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19tixdHravoWH5Nl5Jxt5hX59KqOEiReF/4v+QDlVhs=;
 b=uTL4uRNGvuaiUIeLMLEerah6K+3LNqKdA3yD1ebzeCAJHp2glPXSy8PdviJ1PdMn3yt1RADL4PWTGX+Km0RgOrQGjF6fWkTV/ebI8wJoRB1uyEXbZFMpmbzLvxIYLd9s84n6Wtf1TAL9/YnNDzxR+Cq82qWDts379fs8Kn4NrLgyUYi9lPdjzpFz/qH+O1JZ+KsRfa8PEMQl/ZKV+U2xsp0w0qL0wa3MZW3PbfNlXfcRHwNm/yYBZcdGA66KnQ2Ey+XOtNnpmHqrd/8+5Jd0xfxwHpFnRNBj9gd6ng0hnOZMAJWihlO06Z9j5xPTx5XCw7fnmcrZ4PDmxIh/EV5Edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19tixdHravoWH5Nl5Jxt5hX59KqOEiReF/4v+QDlVhs=;
 b=Mo6mjoZ6XVLNnj7nKXYLrzzeAghBSB3NXoovQul65IlqLBpzYGWgJqQUNmBaA49+k+T0YhkavjyICoFaWUQWU0SDnMZ0w7PW2eemyu+bB0i4hSTQeUCqRakY1yb3YZYfvR8K7RIlaHlinRcNDNFlJ31zHNCGmLfh7cE78/dIOzc=
Received: from AM4PR0302CA0025.eurprd03.prod.outlook.com (2603:10a6:205:2::38)
 by GVX0PF6C155ADC6.eurprd02.prod.outlook.com (2603:10a6:158:401::b14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 03:11:39 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::e8) by AM4PR0302CA0025.outlook.office365.com
 (2603:10a6:205:2::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 03:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 03:11:38 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 05:11:38 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 11 Oct 2025 05:11:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 83A5B1C8C
	for <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 05:11:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 5810F120675; Sat, 11 Oct 2025 05:11:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/3] knotty, uihelper: Remove running_pids and lastpids
Date: Sat, 11 Oct 2025 05:11:33 +0200
Message-ID: <20251011031135.2243358-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|GVX0PF6C155ADC6:EE_
X-MS-Office365-Filtering-Correlation-Id: 3120fdd4-236f-490a-16b5-08de0873e4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/6XvjWfETjVBpDOAe6N2vRGmk9vTmWtj1Rx30gBbGgZGeItHX9df2uXsAbgW?=
 =?us-ascii?Q?d/EPuzQlspUuF3owtlbx2fSYEIpHxeyTFhLJdlbK+hBRyWoO5fNi8aPK7BUq?=
 =?us-ascii?Q?pEEzyKBrJbiuW/6lALITbid+8i+lHpQEVYT6elWo6+5cW4cuFZoyHb6Kq6et?=
 =?us-ascii?Q?K5d+fcdiNrCSqt+w29JCVB4Pe/7TfdkvfwJFxPJNxn2MxYhqPStZfMs1dcxJ?=
 =?us-ascii?Q?A+WpxuVUGwAMw6C4tfJfm0YfkOdLPzRu1lY7PDloegsHX9j8ezaMb13xk3Zm?=
 =?us-ascii?Q?5nKxk+wSixPBN5QSeOZSvRn+cc6QIDLBHcvY1bsj6IeK0kzznqol5NsMBWDP?=
 =?us-ascii?Q?nAlVfRYke6gUHuqZ8B9mLvGWa1uidNiYeigK2tmakMsZVFZOJ5WPD2YLjUeb?=
 =?us-ascii?Q?zHr/4008xSzQhEzlHfWWbgKP2PKm+GFg0dPiDTKG5FppQcpuU0Zwz92CmsCR?=
 =?us-ascii?Q?tmQ4zrMkJMJnbwINYTPeD2xktXkVGxhXwxfB/Z+LszQa3se4uMHX/pbGiWKo?=
 =?us-ascii?Q?szXdrkwXS+NWwge4mobBEavrzsGs3GqtPKi2k2M5DZsS87jppMvZ16cCVi4A?=
 =?us-ascii?Q?TjgjS1RNop0sO/LdNXbhy1l752KrCYiOw/mIkQNxy3QjOdH3LNmnc4wisc5X?=
 =?us-ascii?Q?VxZsiAm2PAw0jA6cEEcVOcrZ1sc19woGPWPf3hreFG6z7H/tZrJh2fhcxnA7?=
 =?us-ascii?Q?RCLkqZXbpHzDlE6uyowWCX+P/LII7X6B4gRhAMcyt0m4ZwIBfrXPzWVObN68?=
 =?us-ascii?Q?bXbiXBLPpvHnQDeh7KfUxNdL/Kk5BQaiFg0YQJ2HDGUPGnIgUnZDJyqKs502?=
 =?us-ascii?Q?6LyLKMR//dB4rzzDpKnDy1ydLO7CCnckI5w5GZxMN8XUvn5Qqu2HwQnbZ15g?=
 =?us-ascii?Q?4i4Us66p0hrAPWzRh1j7mbNBhkYVElunzXce7JvPMRogzgL7B8hvYbnGhrae?=
 =?us-ascii?Q?Ar+DC9IHlPjUsFyPWFfjz9hLEF/hTjx7zHmnL3Dz+PCI6DHec+qy7ySIJKdM?=
 =?us-ascii?Q?mH8dU26ryVtNaK1H9W/Bms4CWrT44VYdh4Dw1+jOARWv45h0tr7XtxK2HC36?=
 =?us-ascii?Q?fyZlaYp8MbQGcyBSQydIG5NIUUnGZwmPpn89USDWHu1t8Dz3NbzSRdyfN0Ai?=
 =?us-ascii?Q?aCa5mPmlTxfBg2NYtud4b1fuXyBe+iSucWutMoHKyWDUfdJVF/dbVWPtVcMZ?=
 =?us-ascii?Q?/Zni7u/mCYzE9Q25mjJEOj5MBYff3eey5MjatGbSYVxEO5HvCHWEuKWnUjGz?=
 =?us-ascii?Q?Zndy2DmYVa4/laIfvpFjzYOgpggf9xZSi7eFeq3MMxAO71b+1RhQkd57ogP/?=
 =?us-ascii?Q?CnxcQ2/tdz27oeVzd7GsTFGT5uUxamVvy1yChqE/UiNOTv+UiPVPtA8fCMZ+?=
 =?us-ascii?Q?1RIkWgSNS7CJIkkkYqSOcX8TpA6ZN5jKWMKqYRW4AbR+u0LOkKi5AE9H/rMT?=
 =?us-ascii?Q?XR0aLniMUj6QtVB4vTPB6tfWEwVQd3YmzlwQUaqNX8a8tmZuNbToK2SXte1I?=
 =?us-ascii?Q?OtPiHl5xOCG5C9qEHWGia0mIFX8Rz5iDvhx2VuMOGQfEbE7Xt1q76dPXq69m?=
 =?us-ascii?Q?7INT/I9ui8Vx939OK8s=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 03:11:38.7857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3120fdd4-236f-490a-16b5-08de0873e4ee
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF6C155ADC6
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 03:11:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18172

* lastpids has not been used for almost 10 years.
* There is no longer any need to use running_pids to keep track of the
  order the pids in running_tasks were added as dicts are guaranteed to
  remember the insertion order since Python 3.7.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py   | 5 +----
 bitbake/lib/bb/ui/uihelper.py | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 492ea20763..00258c80ff 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -169,7 +169,6 @@ class TerminalFilter(object):
         self.stdinbackup =3D None
         self.interactive =3D sys.stdout.isatty()
         self.footer_present =3D False
-        self.lastpids =3D []
         self.lasttime =3D time.time()
         self.quiet =3D quiet
=20
@@ -254,7 +253,6 @@ class TerminalFilter(object):
             return
         activetasks =3D self.helper.running_tasks
         failedtasks =3D self.helper.failed_tasks
-        runningpids =3D self.helper.running_pids
         currenttime =3D time.time()
         deltatime =3D currenttime - self.lasttime
=20
@@ -283,7 +281,7 @@ class TerminalFilter(object):
         self._footer_buf.seek(0)
=20
         tasks =3D []
-        for t in runningpids:
+        for t in activetasks.keys():
             start_time =3D activetasks[t].get("starttime", None)
             if start_time:
                 msg =3D "%s - %s (pid %s)" % (activetasks[t]["title"], sel=
f.elapsed(currenttime - start_time), activetasks[t]["pid"])
@@ -358,7 +356,6 @@ class TerminalFilter(object):
                     content =3D "%s: %s" % (tasknum, task)
                     print(content, file=3Dself._footer_buf)
                 lines =3D lines + self.getlines(content)
-        self.lastpids =3D runningpids[:]
         self.lastcount =3D self.helper.tasknumber_current
=20
         # Clear footer and Print buffer.
diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index e6983bd559..a223632471 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -13,7 +13,6 @@ class BBUIHelper:
         self.needUpdate =3D False
         self.running_tasks =3D {}
         # Running PIDs preserves the order tasks were executed in
-        self.running_pids =3D []
         self.failed_tasks =3D []
         self.pidmap =3D {}
         self.tasknumber_current =3D 0
@@ -23,7 +22,6 @@ class BBUIHelper:
         # PIDs are a bad idea as they can be reused before we process all =
UI events.
         # We maintain a 'fuzzy' match for TaskProgress since there is no o=
ther way to match
         def removetid(pid, tid):
-            self.running_pids.remove(tid)
             del self.running_tasks[tid]
             if self.pidmap[pid] =3D=3D tid:
                 del self.pidmap[pid]
@@ -35,7 +33,6 @@ class BBUIHelper:
                 self.running_tasks[tid] =3D { 'title' : "mc:%s:%s %s" % (e=
vent._mc, event._package, event._task), 'starttime' : time.time(), 'pid' : =
event.pid }
             else:
                 self.running_tasks[tid] =3D { 'title' : "%s %s" % (event._=
package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
-            self.running_pids.append(tid)
             self.pidmap[event.pid] =3D tid
             self.needUpdate =3D True
         elif isinstance(event, bb.build.TaskSucceeded):

