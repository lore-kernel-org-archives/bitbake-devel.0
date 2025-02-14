Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A7C021A4
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 21:14:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.40])
 by mx.groups.io with SMTP id smtpd.web10.32063.1739567657048774886
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 13:14:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=E/kyeCYk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJA4CLfl4VEL/WESidoV0kiGQUP3KpHggc0r7hfQFuc8fsN+VZhfzvRMBJaK1ve7lyWYoyMBB7+/RTv92Z8QR78PXtVtLmcsUtLCvLh73KXGvaEza9u4vIwxcq6nJTruuuo5lsB14JliiYKEPz6WaN8jje6dIRVB/hDNiJEVzOG/FPd+Nb8N5mUkV/ijPN/CEi+r6c/e7/4K5+kAcZuTvWP/JbqhJ+rA8zXnarUKLPceKxUtw3AyB7ykb24bNT+cqLKHaEP2YPAWxi550wj8Nm5JUV4FqHlRJxfj+neOuKXxnlRWtkwhcFyGy76lUT+Ln/l8kg0+wHSlTk1Pf8s1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEhmxzKuAGtd1d4Nb2bwfd+b7iObwaW953BAaXzQJQ0=;
 b=ukh2/svD7VxLeDwl2zgVA4RO7akPCq7Pm12PHATjL6aAoasZyWtPV0zOrI5f9szKIbAJpDTAmxBvlO9PD8fhYMDPnzYxqY7pWcyY/4lX9+mKfHH7Z2Sg4GsCKx1Ea3nUQd5gK8yjx6s+XprRVyxLzcxxSEh+VUbLPJF7Jb1pA/8hNkGZSpGTd4bz/Rr60qR/raZ2qaekHx3XMfR8IgIeHsyJFlN6u1Wc1rJ9W81nuc3Ghwf1vcSi96M8cBk6Xx+2KDae8Wdy9mlVwb2EdeTXQpg7/HKr/BAOfSS4p3qsHmW4CG0ihdbZUYtWrsc0DsEa5x1S6Juo0k48UJybLNfhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEhmxzKuAGtd1d4Nb2bwfd+b7iObwaW953BAaXzQJQ0=;
 b=E/kyeCYk6wGM3GJrG8o7Y+wL7QdEyTIBqwob/89HPWIuEgpbHCNFkAIV1FJnL7eDAH6KkB2yKD3DE+MMoZHTwWDxN/wUkYd/e4BgHFsRVZLuVo7qCBzBjhFZ8gm0roM81FOrgSdlcWhCZHf4ho+uxr8p+rzYX96Y5fNS7YoRbkj4qfEWDJxGVxhqoxsZLQ5R7PcAKjcxSQYMNrjPmKnsF3/oGINEs8C+x4DLILxP/PGzBan9bbFGyLR0qcI84kRu+JRmxSEOoMf+LytLzUBR54uZx5LfM2Z99uKxd2h2EHm3T++apOm4pLmUzLqjLv7yJMkv1Gi9JfzUPxG2H81QHw==
Received: from MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 21:14:12 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::cd) by MN2PR11CA0027.outlook.office365.com
 (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 21:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 21:14:12 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 14:13:34 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] knotty: report cache validity checking progress
Date: Fri, 14 Feb 2025 16:14:02 -0500
Message-ID: <20250214211403.493573-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211403.493573-1-chris.laplante@agilent.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: fce0310b-6f9f-4b1d-f06a-08dd4d3c878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jDwEqn0HfRdkEc/bxeBZeGpJQdwMWRf2p6yVVPjIws6XFVzwwBcGTnz03j6A?=
 =?us-ascii?Q?0RW4NvWcGSRd7jQGRt/+PIEQXHavGyC5A+JBiL5YBAZZKxNpeQXXxTp+yUTO?=
 =?us-ascii?Q?XQgqK7T2cccvclQK258f+Bfcizx7vWXnNgy6cp3GOSJ+TRv+39Rl/KTNulyI?=
 =?us-ascii?Q?ckjzuRJ8HXyh7xrUTiPO9uwsxRY0e2M0Nc4Ve+r2ts+788rDz6NGsoATjGDg?=
 =?us-ascii?Q?IKo5vds2q8L87BZ1xyVXfvCvqneqjXspXQ9sYR2VnwnErAodVOyuF1etOQLh?=
 =?us-ascii?Q?jCvAWXMnJmI9ARgmB3oh4FohFBy8xmLND2Hdx96S2St2050qXX0sVnloeqY8?=
 =?us-ascii?Q?L/f0LsLbGqsIoleIRFDF/o4RYCT4R6lDygB9/aUDwtwWEnM4Qph44uJ6yz7e?=
 =?us-ascii?Q?MZutCtiudnS7FuIQbPPVQMFIwxTM/nr/LODJm4ksFT6on2LT2YRmZxc/940h?=
 =?us-ascii?Q?XMR7XTH7517nQs9EqO7+k/Hkc4XN1iPCB+T++uKUAMC8Hrv/K8AlK4N08oQf?=
 =?us-ascii?Q?eGUTBFeZifl18Scs2mkmB5iK2PpUANJE3pxg7oA6MEcMw7jGPXPuHxAjcrbW?=
 =?us-ascii?Q?00Hpurwggr73aknHPFpi9ZKP2PSN/F5qOc6w6i186RXl8ZSLWWMQWvi96OnD?=
 =?us-ascii?Q?72a4eotdYkvHK4pBnkTYQ7bBSJh/U0E8fvq4NqxKNvPdG+ig0NXke6kc5byW?=
 =?us-ascii?Q?I2MsT924JfcElfwJjHUDMTvfaoYQz2dO8e2XRm2vLi0B6WwlR8561IQArKi0?=
 =?us-ascii?Q?rYssOZKQptzfpuQsxF4LRjxTOyFlug9uaRtWhNoQgYeaR31o6B46/4kq02T/?=
 =?us-ascii?Q?rI+F5RM2xsSEGVKOP6Xuxkgq0pYrj9vM9ADhKbY23lTdpyfe4B67QNwtoC4F?=
 =?us-ascii?Q?gVvvSOlCqCwT6R+pAf+j4nIj/NnesvhGunmBer0+kXtVtG+y1CuaGcp8/3sm?=
 =?us-ascii?Q?BNnAQjmV5yvUbCB2B0rbfj6eWLAWW///9WfRw5kz2h3TmUA4puy/kNoDBHjm?=
 =?us-ascii?Q?B/ZDtrHh4UrMc9Kr/Uc9FrmkTvZZXWguxYtQ+MNHeq210IpH5Xy/ToeXFBcJ?=
 =?us-ascii?Q?H3xJ04ZxWYgStMo951KrwH9WtbG46V+yC9Ye3oLr8H2ROQIcTsNhimObpDiv?=
 =?us-ascii?Q?H3VzuV08JB4b1i+RRZR3Nn1YqWXa4j77QQVbpt+bMmqXwoT+XQJ9valCx4AQ?=
 =?us-ascii?Q?xnhSC8XpaKA2d+FId1dN54IkxsUdxWprnHrPMEnIliK3jV2T744h48IKTjMF?=
 =?us-ascii?Q?fBDnDL2Q9kdT67R3h4/Qn/G0fD1hR/Zvx/fpjfgHr2mq7o2sj2pAgnLouWVi?=
 =?us-ascii?Q?nhikyOJn3snt0ual9sMym6WPyXN28CfSyZ/Q/pNhFlHKTVn0HlzphpM9I9k7?=
 =?us-ascii?Q?WgRdnvIkKjn8wuko2I+NfICK1vud4PE+8/pzv0OzaOiI4Qenr3bBw8deAJCa?=
 =?us-ascii?Q?hmuPpQl9Algh4qSQssitNZtwRcLWzCdg1RPjpAJS7BLqG9FdkhptD4nNoYiR?=
 =?us-ascii?Q?JOzJUw6Q7XdngIg=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:14:12.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce0310b-6f9f-4b1d-f06a-08dd4d3c878d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 21:14:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17228

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/knotty.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2fff1b3669..92b1980f5d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -404,7 +404,8 @@ _evt_list =3D [ "bb.runqueue.runQueueExitWait", "bb.eve=
nt.LogExecTTY", "logging.Lo
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.run=
queue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTask=
Failed", "bb.runqueue.sceneQueueTaskFailed",
               "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.Task=
Succeeded", "bb.build.TaskFailedSilent",
-              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.even=
t.ProcessProgress", "bb.event.ProcessFinished"]
+              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.even=
t.ProcessProgress", "bb.event.ProcessFinished",
+              "bb.event.CheckCacheValidityStarted", "bb.event.CheckCacheVa=
lidityProgress", "bb.event.CheckCacheValidityCompleted"]

 def drain_events_errorhandling(eventHandler):
     # We don't have logging setup, we do need to show any events we see be=
fore exiting
@@ -796,6 +797,26 @@ def main(server, eventHandler, params, tf =3D Terminal=
Filter):
                     print("Loaded %d entries from dependency cache." % eve=
nt.num_entries)
                 continue

+            if isinstance(event, bb.event.CheckCacheValidityStarted):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress =3D new_progress("Checking cache validity", =
event.total).start()
+                continue
+
+            if isinstance(event, bb.event.CheckCacheValidityProgress):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress.update(event.current)
+                continue
+
+            if isinstance(event, bb.event.CheckCacheValidityCompleted):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress.finish()
+                if params.options.quiet =3D=3D 0:
+                    print(f"Checked {event.total:d} cache entries for vali=
dity.")
+                continue
+
             if isinstance(event, bb.command.CommandFailed):
                 return_value =3D event.exitcode
                 if event.error:
--
2.43.0


