Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F406C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 17:59:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.62])
 by mx.groups.io with SMTP id smtpd.web11.22124.1737482335468559548
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 09:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=TdlBSTDc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN/NKvEdjbFgfgsOEmRkNF7njPzY00I57UmweG2itdbB1HSwo9YGSrJpzt8JAldUAzx3g+Jwg5M4wM1qgrZmCJfhTkstwdFOhYTNbNyDBqs0GA8lMM21+rfuX5pfq0ViSHSOmGzVpXLtXNLLDtWrCY15A+M/H/6lVJB/0/kp1rYYiimPqjb6MshwdTtaK6OZSGsrTjJ2yZ+dtBlsVROBrQxdVXICq3yY2XrrLpD15MTJxNetL+m++XQKVoN8/km030EvCvXdaUSCTkd/gShIT5S05b0nytYkjgoXckmQMoI70M7y+xheLKxD+P+rAterID1qvALqOLQbPQWbB+0OWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xllmsvekucjQ5GNE12IDGxA8Q9VGq1dampvZ7nD4Zo=;
 b=ED2KroJx2R1jtyeWua7/IEq4R4lWpa80l1xKXWVO/BCPL5j4P1CdHw5r8bnPbBZuKvZMvHz0El3mb/y2s2czgmWx96PJE6560sP2uDUomOiiYm4d4phwrFnfCPU+7tsTkEWEV2xvu99iK2x2izY9OAZjgbvmtQUqLv67xEPXMR2tVQa3/ijC+AadWpNsqVt0+SbbjxuDvbF8XKF40VJf/do60Zl7/Cbf1VBDG7MvoD11dbZjWt7z6hXSuJFYDj7JbID4NHY3dFXeTe5krzEvyLoljIOqLCG6wNp9gYK1VteauiHbwjrPBz0QJeQVUClMQO5EbrMc2ULD1IS9JnRQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xllmsvekucjQ5GNE12IDGxA8Q9VGq1dampvZ7nD4Zo=;
 b=TdlBSTDcPehxHfS71e6PtflyY0WStKMOzVuk0bPCeF7xymOKqCHEXodIsS5KzUtfFjIz6o4ODgKNofN9jwMgp1hxbhYm4wtEKN+hOMccLjBm5ziWcYwNbT0SIrtTsiyGWVosD2RWnCaeiD4VSHHASXnFplsaCb4DPFCEIQSJeW+dErY5LKk00/Jo5u2GC0tPMTVu5bvT5I5LIz0YeKHRek0TGVn6AFcayiNw21+/91ZhYttCMoRqmXMWNOvyY/NJWDZOxymYTI/57gdcHrvcmIz7syMklwH6g5ZMtkFyUUGcFF7CYaoX9hmx1EgAREM2rAA1vCxuC+SQA/3cdotaXw==
Received: from BN1PR14CA0001.namprd14.prod.outlook.com (2603:10b6:408:e3::6)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 17:58:52 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::e2) by BN1PR14CA0001.outlook.office365.com
 (2603:10b6:408:e3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Tue,
 21 Jan 2025 17:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 17:58:52 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 Jan 2025 10:58:49 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] server/process: remove need for ConnectionWriter to have self self-reference
Date: Tue, 21 Jan 2025 12:56:35 -0500
Message-ID: <20250121175634.3723325-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d8b48a-b352-4b7c-ddf7-08dd3a454428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g6Z33pJ3SzU9tLd1RI/Vj1e0PgjZsKwEE2ZBndzLXa2suZk2foHgF33A5ZXz?=
 =?us-ascii?Q?1X+fjs759BtsuIS9qrcKAc697qbdTV0fv4jDvrJHDRwCQ1F4YTk5VxZzRVmk?=
 =?us-ascii?Q?Hzp4IZY6tf17/bZ/8ocsN4vkXYsAckV32sMzzSHfJNBKMl1WmtOQCwVuNbAo?=
 =?us-ascii?Q?Ft5ufrxejlMFxZeFT4453XdU6IcAOmF8Dc5p3jhE7XebjtsCtsglYkSHoOFR?=
 =?us-ascii?Q?rJZNlO8XSBZZtCU3H1Ht8QCuYQWY+MQqQteeVmOTM2F/3Er1chZWDWRsvn32?=
 =?us-ascii?Q?j18XiJ582XJcyzxezENsLjB0DbqYeY89wjEuXH2rN3+dcWGznaN8qzhvWFd7?=
 =?us-ascii?Q?FM7H4Qzz6g5BbDK2zWs1TaiB7lOVwajAmGZLCxmSaBj9iUZiQbUwSY9s8zzY?=
 =?us-ascii?Q?4J2jezhd1hOeps1W2U5cTDFUtDEd+Q4WcJRzAMIU7hsegJCZsdMnv3HDcdBR?=
 =?us-ascii?Q?JhbI/PUcZ08V73PceSTVmDfM7QgnPpnto8/K7aVeii8VXPhHrcCVI6Q6RsIU?=
 =?us-ascii?Q?HJZ2E2Ikypjl/kwZzq1Ubc30XoxDJ1njB4RvyAhQytQGuOfIqvHyo6n99ys2?=
 =?us-ascii?Q?ijhg6dhpIOd3s4CFDSuiaLuAI9WKJ372aBLi/k/XC2b8Z7VMOesKhGkLbyT3?=
 =?us-ascii?Q?zmwBVM5zOSSc4lnvMS11pAFOtUkzpxdS+LhAsZosnnhBs3gElMqUrCOfB5zR?=
 =?us-ascii?Q?LNGxChmYowxRx+45SSz7X7cEioiV1vrrgeL2qUVFvm0mPd7xpZnQUHI6HVVv?=
 =?us-ascii?Q?BvMsJu6HoDYPTkhUsi0ARRBNdGDK0SAc2tj7XbpRrBtlURQR11EErMJI+OuU?=
 =?us-ascii?Q?C1pTPfTJwsAEGDF6vM4MdCQcIhsD0KSrPk3PjnPVv6iTyE/2u4eSvgoayeie?=
 =?us-ascii?Q?x3NdUCuMrLxoiWu+QIST4yE33Xld9ltXZ79kdnQB/F1kVtElRmdN/XLMnuG3?=
 =?us-ascii?Q?DKvad2y0GXJpz8DEjhzZxP6Z38v1lkJKCo8aT83YDA7rx+Vn7VrVDLnGFA+V?=
 =?us-ascii?Q?9HuIjzwMDSYtS7KkD4an7G8bTehpgk+YDahvZlLbinZz14tmQcINe9SmI2ql?=
 =?us-ascii?Q?2zYO6PPJI2d49slGkLFcXi2/q/grGstqL3PhpB56bcXQdKcex6C2U7ncRKm1?=
 =?us-ascii?Q?ddXo8zQbHXNR+RwN2k4xbCrRv0+NZxmkMjGSqIowAmR7/gHiXDSjKdcv0zp7?=
 =?us-ascii?Q?hNk0V/aMHN60MGAnlycsRtwmn4U/u7NZuMUhZ3KMRQimEW4anqSFEwm+zcEH?=
 =?us-ascii?Q?uF/4m1AXy8ZVpngG0t/hOkAGAe/l6FDknbPE1vu+g3Twx0KCtD9BjzVPaOSX?=
 =?us-ascii?Q?slP46HpwmY808t5iAxT3uP+QQHkjHbg0thgIMJtXX6wHxXsqNeVgzKhdtaFL?=
 =?us-ascii?Q?+srwuhBoK8KVhsS1eBLfTgqJuHnrTthM0yhwNeT0mvFI3HpMCVe3z0LEHIOQ?=
 =?us-ascii?Q?uE/lusFPpiZ+TFiwCtiP5+UAnoSNVUFzyO4mX8grFrK1OzCI1o8cJWTjl7kI?=
 =?us-ascii?Q?gvATfK4qMnhLJl0=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:58:52.6068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d8b48a-b352-4b7c-ddf7-08dd3a454428
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 17:59:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17047

From: Chris Laplante <chris.laplante@agilent.com>

It's a minor thing, but the mystery was too enticing to pass up.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/server/process.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4b35be62cd..8dacb41f47 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -12,6 +12,7 @@

 import bb
 import bb.event
+import collections
 import logging
 import multiprocessing
 import threading
@@ -250,7 +251,9 @@ class ProcessServer():

                     # Where to write events to
                     writer =3D ConnectionWriter(ui_fds[0])
-                    self.event_handle =3D bb.event.register_UIHhandler(wri=
ter, True)
+                    # bb.event expects an 'event' property on whatever you=
 pass as a UI handler
+                    ConnectionWriterEventWrapper =3D collections.namedtupl=
e('ConnectionWriterEventWrapper', ['event'])
+                    self.event_handle =3D bb.event.register_UIHhandler(Con=
nectionWriterEventWrapper(writer), True)
                     self.event_writer =3D writer

                     # Where to read commands from
@@ -850,8 +853,6 @@ class ConnectionWriter(object):
     def __init__(self, fd):
         self.writer =3D multiprocessing.connection.Connection(fd, readable=
=3DFalse)
         self.wlock =3D multiprocessing.Lock()
-        # Why bb.event needs this I have no idea
-        self.event =3D self

     def _send(self, obj):
         gc.disable()
--
2.43.0


