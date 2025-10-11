Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF27CCD183
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 04:23:21 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.70])
 by mx.groups.io with SMTP id smtpd.web11.5195.1760156600570282176
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 21:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=Pcg36qyq;
 spf=pass (domain: axis.com, ip: 52.101.70.70, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK+ck6DXGdqX/uQQ7PDQsPXXMd2WpAuEzAq/4T2XMAShwm9sY2ySss8X1WMpcr1KvXYnPhdYIomOwZo9O2bw5iH9oscm2sGBekFS6kzz0Qr9FBipJM/lDsomSpBWPWmoszL8sM59ZIQg+KDG0KKlLQz9bJIEL4y22zh8R6/q212UpVzDC+uBcDdBimwewt/nulbMk5i7PfgMB4abVR4/mVsNOACUduaF0FBSv6h14bPSzEqgsrsG2SKgFGfgorEV6rObqL2k/UznuAmdGk74naXmBSXnwD1wSMBhc+Jz5zPx4r3y5UGQC/gm7VU24AUYxIotl1oGcByXOpgKq5lQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z258lNx/q2K47YwI4DFJaaXPM2rnQmiHhwFOa/HhVpU=;
 b=cOgW1tzMbG/cqbOxDn2Oa9Kt0BUqdYM0UgpOpKV6Nl5MsAjVe0FbK0HkfhHv3rTsVafxxRW9bHTPBFB/BaMB/M9Um8Ydiu9gADZUh6jtWgVAiDg1OEs3kvlMSFL2c2z8Bmxow8C6qQ3/gSKz9KUAye30W0W4TNV4iO8GFFtcHDY283T3Wsdcw25Iz1DhkYK6RoihtXeAQYvSM0jI689r7ugyn0HhBO1303nIDxU4vAoWlih5Bacpd4YxJ2ZLsXFKXmJb08iwWW1gTODjvz8jDwPOHkp8LgyFwd3h9Jvat8UdwYBmv4foToMtZgDqN679KjYGmjgZbq22vrVWO9zpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z258lNx/q2K47YwI4DFJaaXPM2rnQmiHhwFOa/HhVpU=;
 b=Pcg36qyqMonpvX4LS3CqoGHLwr4pWCKRJ5WKl5yQXisJHy8o9SHo8eS+WrkzFgob4U55Le63o/xELQ+SrttwtZyoqDNrmTkNqlfuWaHDsMQZUVOT0UYsp6l5zeyucbJqZc8x6uR2US9ipsL4qMrHqiFjkltdQw+EVa1KbBiOsg8=
Received: from CWLP265CA0451.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::11)
 by DB9PR02MB10352.eurprd02.prod.outlook.com (2603:10a6:10:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 04:23:15 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:400:1b7:cafe::80) by CWLP265CA0451.outlook.office365.com
 (2603:10a6:400:1b7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 04:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 04:23:14 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 06:23:14 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 06:23:13 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 11 Oct 2025 06:23:13 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id E2CFA1C2F
	for <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 06:23:13 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id B647B120675; Sat, 11 Oct 2025 06:23:12 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] progressbar: Make bars show correctly with maxval == 0
Date: Sat, 11 Oct 2025 06:23:10 +0200
Message-ID: <20251011042310.2260617-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB9PR02MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: 54061190-5448-4ed4-c490-08de087de544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DIDpm3j3Fjko/3J/C3MnyYdEl2CDuBbJ1jTlDHGR3Ai+kgXrysa8Zz55cC08?=
 =?us-ascii?Q?FqBG1XLu/lMl6y/HlUVQ3qoIEGZpqln9gwqgjPQNbdc4S1S9BtpTmSp+Qkd3?=
 =?us-ascii?Q?6DK/+DG58lCy9dQmHT0+NDNe4XF8+XBa2saPMLeMjnpQoJRjfrODIm+5dgCY?=
 =?us-ascii?Q?3jfd/+eFai+J6ILGS/jF6T4PD/LSr8Am9833IgFAVCxOre0x8v9Wr4Zj6yi9?=
 =?us-ascii?Q?Urf/J2WOlxZhWrn5Rzy11uA7xOvgvgsDCh6XmgICOps4W06wUb+mDh2Tmkwv?=
 =?us-ascii?Q?aul1Lkz+a5G8qPE4gP6zjrd3MWgdf/nJBGQEWuIypKhhuxMOaebiHdw2XgP5?=
 =?us-ascii?Q?mV/z7lDEQQbytgTC/0fiOv63uCYvhQqn7DpfjZhi3jr7Bn15KAnm8DPg5t9e?=
 =?us-ascii?Q?5WjltTgY5yAULNTCM3LDAkqjcWl7TpirzZMCKXcPqRgzyyc+AK8+pz3VLgJ5?=
 =?us-ascii?Q?SaeRCJZAqbi7t1WlDzfN6/Jq/SjrfMbL7b3viCD0VUsPAUKqs8MAaD12hehX?=
 =?us-ascii?Q?7ssKHcSQJ4CV36lApJJJnaCXh6SgYNQLsWioh9cpiMX2FdSoaBFfe66mgbjx?=
 =?us-ascii?Q?5fi3ZGBjNXmkDySvYWdJP5Txv/kkL/OApwqXzogORlGI7AS305PxdeAFe16Y?=
 =?us-ascii?Q?Nl4vW+Sl74M7i0X1jjgfwJq1QQQDrsgHxB1vRKDgSoLhfx2WHBHceC+PmJbc?=
 =?us-ascii?Q?HvVoA5sosZT8LfDKvXkeB7mcnsgQ5js0HffqEhL5NZoIO9fPV46En2eqvolD?=
 =?us-ascii?Q?ANkgMxKpxh+mMzMckK3/51z5ju9X9MONM025DjYl0kxsDoAlH74pfh/arBWV?=
 =?us-ascii?Q?AndPMAphVludeY6Qm6sNelTtT/+LD816clknMQQe+gBQWLXfDP8bifnUygQ7?=
 =?us-ascii?Q?5/yhr8RzLtGmKPnY6K/AQiijah+S2R8BBrRR16EFsvp1xByAz5VOTB9Fwtvh?=
 =?us-ascii?Q?0+J8cQH7An302o6/YwHLNWltZRtoSqmR8o73OVfl/oWKTHj22umOkobo8Iym?=
 =?us-ascii?Q?R1/S8o3DfDaIqx43QPQyh0IHOlfopHoBZaiuLIpVZKOGn2sMgWUrdNlacaRs?=
 =?us-ascii?Q?vvcO0fzk4BX1dvCfWf6xjqY4LMK9037Temr17PSPIo8xh2Z/eZQvbfMd0A0l?=
 =?us-ascii?Q?aWnV4vLpjPbYlo24vs6t6YoFCoxfNzSgPE7zmoxKEPWZmhmvZsXrMiOVy5fG?=
 =?us-ascii?Q?ziSMfAvg5WZHHgdyum52dVkzOd+04+hktO/4YIPtLhHT0XCc8ddp/OMaL/52?=
 =?us-ascii?Q?hCWI8zAQ8crbNfIEgZE1HAanyQLkqVR+uwkBo7Q/JbZx/035e+EIYDLD1FuR?=
 =?us-ascii?Q?m7OPvFZMVgHN0/VLB5yDq2AUvfnJbC53f7EIrSoT/C8BGbfezplusdZVHHqU?=
 =?us-ascii?Q?EuT62ENsxKkSmlw/hqvi54S+dDRh4NEX3n2SOX0YklsjXTg3a/D4MPgj4Oei?=
 =?us-ascii?Q?K3uSc/Fh5H24nRnC9Zv/eE21BSnssqYhgiBW/UZzJvfG8bsSRcdiM4hM+ujb?=
 =?us-ascii?Q?I68VT59+gma8mbMHq2sYHm0UZbkSKSYmZHAvuM2NHyEnQVb+cPnBVok2fTKf?=
 =?us-ascii?Q?ckX+POFqS2yDM8LZNfQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 04:23:14.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54061190-5448-4ed4-c490-08de087de544
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB10352
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 04:23:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18173

While it can be argued how useful a progressbar created with 0 as
maximum value is, it should still show two states, started (empty) and
finished (full). Setting the maxval to _DEFAULT_MAXVAL instead will
accomplish this.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

This solves an additional problem related to the progress bars that I
noticed. This typically happens when the dependency cache is empty.

 bitbake/lib/progressbar/progressbar.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/progressbar/progressbar.py b/bitbake/lib/progressb=
ar/progressbar.py
index eccc45849b..a8e2dc09c9 100644
--- a/bitbake/lib/progressbar/progressbar.py
+++ b/bitbake/lib/progressbar/progressbar.py
@@ -106,7 +106,7 @@ class ProgressBar(object):
         if widgets is None:
             widgets =3D list(self._DEFAULT_WIDGETS)
=20
-        self.maxval =3D maxval
+        self.maxval =3D maxval if maxval !=3D 0 else self._DEFAULT_MAXVAL
         self.widgets =3D widgets
         self.fd =3D fd
         self.left_justify =3D left_justify

