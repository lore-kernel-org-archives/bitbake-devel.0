Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E3D58D71
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:22:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.40])
 by mx.groups.io with SMTP id smtpd.web10.24049.1732555358904555666
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:22:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=Udd4w7R2;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ0uS8wSldiFMdNIuBuRGFrPdiyd/AIWf7J6qW8KSCIsjDITKdoFo21UWjRw0EXFnM4Mtckcm8FL3+LhVvjswGfwkH08Bev/D0ZAiqNgv7lienV7+YxuYAkwU2aVdUGxVN87R31gLmw8tW4TPEcf03JMAWSoDg0CYagk28+LMKIduUjP2tvDBHU1gRmVqgf1E0HGa/QnMw3I4pp5KoQQGKr/c8+nrxOeR2VbBMO3/J2gP3KYq1pxVxvAHbxx9acpiyo8rc8mKsLZB2+rDsRjoMnRDZhCnsqNgqHs6+BBisJ8BJ0wDXe0ubSybEGRalhfARpVl5el8fbzXVq1400Z3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLCc4aHbltNJCnYL1iXYk/NA3IXF4rueMKYf+HtzanU=;
 b=lpiHBHV7yxcbp0OB5y3DEKWU5vvN8kB0WeulwK9xX+5SyB9Ik+rYcNyAp3+KpO2bnKWPSVJKlLsX+XZgmJuNNfCiZFsMQQlDldezdXxb+9Y1D7tSvs7nAWSfozH5aSfWtMbwmsyHKtF1kWiCCur5uBRZTEpIJGW2LhJ42lYj3kacFkzfeGzL1LZTk0zUpeTYUMTgf25iQoGb45ti50/k40FY2SMwqntID/4wuD/kGk1b6u2iNVyM0WGYN8ECI8wiAsuK8uoUkUMndYCDsKkZpJ/huaqY+pCCdEyIXLj6TGIK4QQUm6QyQsuaxPPNdJNb5P6w3qs1Is6P1AB2S7SKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLCc4aHbltNJCnYL1iXYk/NA3IXF4rueMKYf+HtzanU=;
 b=Udd4w7R25aaXa2zflstvyKtRFPTKRikik9BcLxNv7IRALIGVwHQRmaE1YzTdolJAvTlSzTIiqHqPPZqvScGXqA1rlGXPgZAWqIo8YvqQsr/I5lxTuZIbSz9IElLIpeDZ3XPWg1RH8gC24xEVsJluv2csxObijwaijVUmXRfKsfQlTsSGgyiAi627bwnQePIWhvSd4nHRKcMKbMjr5Kr/2jhqumXvALo6O+HqNAv+uBtPFMgZk9B6YBcCEYboHEseajSQC4qge6iu2dpRCIBeW6dhYnzPHM19jjG3BFwGE0mCYLfT0Jf5UWV3vrL2kXLkOdCPeMen4n7dgOwBE6pr/A==
Received: from CH5P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::18)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:22:32 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:610:1f2:cafe::5) by CH5P221CA0024.outlook.office365.com
 (2603:10b6:610:1f2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Mon,
 25 Nov 2024 17:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 17:22:31 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:22:29 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [styhead][2.10][PATCH 2/2] fetch2: use persist_data context managers
Date: Mon, 25 Nov 2024 12:22:04 -0500
Message-ID: <20241125172204.1601601-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125172204.1601601-1-chris.laplante@agilent.com>
References: <20241125172204.1601601-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 237ae501-4905-43df-b8fc-08dd0d75bece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pr/wzHdzVIq6BzLD8gwlXgfwaMmmIsnvEwZnRhij38br+YOXqEgE/HnqHMcZ?=
 =?us-ascii?Q?nE6tG5pSxIQbEV1uG41ydKf6dwLUsmHxWYyCYBGRvZfWIhJkpJs3n+qZEtnN?=
 =?us-ascii?Q?kNA/CPfioQ5bbnfoP6UQwXE+gABBPmkP2ytEBP0KG4B+BahYl3Vk0IbdkBqc?=
 =?us-ascii?Q?FHn+3pjDyTAMTWdIBeiNtHsKg/J8bNBJiNLoEFGdGh6bGurm75kaulYkhF3E?=
 =?us-ascii?Q?Y2ISq95Slw9jpr6Bmdb19z+RjeWdH/6QvD0An9Jf7aAOzuFGYmqtRQSJ8Vh4?=
 =?us-ascii?Q?hI68jsLvf7HauS5/0BeklaKDOMjDDzNeJ/2YwuQaUJRGLY7vNJpFSLUAGobr?=
 =?us-ascii?Q?x08uK1iZW7ISKHr8rMCIUTMj7lbVOGb8dTXTf3oq5r9oVtsIxLRs9SRgskkR?=
 =?us-ascii?Q?kzsC4rHx7x0UX0TKpIDKs6Nq87JeaizlRRhCXTo5MrLE4/ninM1hYyON5+vx?=
 =?us-ascii?Q?Cdw1W2WjjNNbpygVXQ/OafUs83p6Ci3F3qhtKkVUCKqRnYzEylhsn0ZNsSt+?=
 =?us-ascii?Q?J5W0VH6w/KlN3PgJOLjHRHiiukEsgWFCaqLf/x6Zb6k7ZVyDzSXez4yDDTnf?=
 =?us-ascii?Q?qaRFt5c2n8+Om7WbtQ/R3gxromgkY4VGrebrLLG9cjNqHPQ4PXzPOEeuDNwD?=
 =?us-ascii?Q?rqLYu0ZG0mDlsHFuGXeMeOveJhFY60/XMgeeg++lGnqeNzfML5J+zem4Z5/b?=
 =?us-ascii?Q?WOmmenpCW9eTMjS3Y4f6GlyZZOiO2F+7VCBsWqy36G1i7W6QBb2/YdUEKFQJ?=
 =?us-ascii?Q?G5catG8XoKcdmhCMv+cE7PZDY0eHrruhJkyUm3E320Ex4/c6HmALwONAMBqf?=
 =?us-ascii?Q?CZhfZPoIyQ6tD1UM585LFJrzxcIsqOAR0gRGUScxCrqw25y0vAVfUCw8w1MI?=
 =?us-ascii?Q?GM2P3g68DkncRK9Rm2yUUD2Zu3y6Ftti0YTrXIVtbXvMxHaQqWuHzbE1wi5L?=
 =?us-ascii?Q?iLJPDKiBCOPofiXGH/qks49J2kh6c8p0kx32VgdOgulsZOR0MKA2s9ejhW/r?=
 =?us-ascii?Q?u+yMYcg3pv0TeeWDGrKwOvisGq4eeJaSGr4GGXzoSd3kPV8fjLbbQvrxOt9j?=
 =?us-ascii?Q?r8JRQ/N0XONk4OBpr1YP49rCMo4RW6E+LVlaTV/tqHYU0RaKBbZOc/inIi5n?=
 =?us-ascii?Q?y2Yb3rGbSf1aaNsZo6zOHpj2g1qr6ntNaeaZRsid1dAzlFgB9yb4WelILKRb?=
 =?us-ascii?Q?l87sf80Mqon40q/TmYGqi2mal5T0GPpliaZZgXKYkmgMz0jv6aT8OINjYNtO?=
 =?us-ascii?Q?z45OwuI8jqi2otjdHuhqW9XFeTRVnaqwuz8Fhs28bJBZ2OkdvKOQ9nCAamhQ?=
 =?us-ascii?Q?afa3w+Kb7PxBO5MVCbu76P1d4ZPg97NjcDZanejHNpqddCcwKpzYz5PsHsnU?=
 =?us-ascii?Q?ELAcMu4Ot3EmK7Sj8FMpTyOVjnV1+9b9HPT+LD/Ozq+KKesyfA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:22:31.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237ae501-4905-43df-b8fc-08dd0d75bece
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16833

From: Chris Laplante <chris.laplante@agilent.com>

Python 3.13 emits a ResourceWarning for unclosed sqlite3 `Connection`s.
See https://docs.python.org/3/whatsnew/3.13.html#sqlite3

The previous commit fixed persist_data's context manager to close the
connection, but we were never actually using `with` in the first place.

This change is not necessary on 'master' because persist_data was
removed.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
(cherry picked from commit 61f803c7d92a012b62837b0cdae4789a394b260e)
---
 lib/bb/fetch2/__init__.py | 62 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 33a8086f2..8f0ed2b9e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -499,30 +499,30 @@ def fetcher_init(d):
     Calls before this must not hit the cache.
     """
=20
-    revs =3D bb.persist_data.persist('BB_URI_HEADREVS', d)
-    try:
-        # fetcher_init is called multiple times, so make sure we only save=
 the
-        # revs the first time it is called.
-        if not bb.fetch2.saved_headrevs:
-            bb.fetch2.saved_headrevs =3D dict(revs)
-    except:
-        pass
-
-    # When to drop SCM head revisions controlled by user policy
-    srcrev_policy =3D d.getVar('BB_SRCREV_POLICY') or "clear"
-    if srcrev_policy =3D=3D "cache":
-        logger.debug("Keeping SRCREV cache due to cache policy of: %s", sr=
crev_policy)
-    elif srcrev_policy =3D=3D "clear":
-        logger.debug("Clearing SRCREV cache due to cache policy of: %s", s=
rcrev_policy)
-        revs.clear()
-    else:
-        raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_pol=
icy)
+    with bb.persist_data.persist('BB_URI_HEADREVS', d) as revs:
+        try:
+            # fetcher_init is called multiple times, so make sure we only =
save the
+            # revs the first time it is called.
+            if not bb.fetch2.saved_headrevs:
+                bb.fetch2.saved_headrevs =3D dict(revs)
+        except:
+            pass
=20
-    _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
+        # When to drop SCM head revisions controlled by user policy
+        srcrev_policy =3D d.getVar('BB_SRCREV_POLICY') or "clear"
+        if srcrev_policy =3D=3D "cache":
+            logger.debug("Keeping SRCREV cache due to cache policy of: %s"=
, srcrev_policy)
+        elif srcrev_policy =3D=3D "clear":
+            logger.debug("Clearing SRCREV cache due to cache policy of: %s=
", srcrev_policy)
+            revs.clear()
+        else:
+            raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev=
_policy)
+
+        _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
=20
-    for m in methods:
-        if hasattr(m, "init"):
-            m.init(d)
+        for m in methods:
+            if hasattr(m, "init"):
+                m.init(d)
=20
 def fetcher_parse_save():
     _checksum_cache.save_extras()
@@ -536,8 +536,8 @@ def fetcher_compare_revisions(d):
     when bitbake was started and return true if they have changed.
     """
=20
-    headrevs =3D dict(bb.persist_data.persist('BB_URI_HEADREVS', d))
-    return headrevs !=3D bb.fetch2.saved_headrevs
+    with dict(bb.persist_data.persist('BB_URI_HEADREVS', d)) as headrevs:
+        return headrevs !=3D bb.fetch2.saved_headrevs
=20
 def mirror_from_string(data):
     mirrors =3D (data or "").replace('\\n',' ').split()
@@ -1662,13 +1662,13 @@ class FetchMethod(object):
         if not hasattr(self, "_latest_revision"):
             raise ParameterError("The fetcher for this URL does not suppor=
t _latest_revision", ud.url)
=20
-        revs =3D bb.persist_data.persist('BB_URI_HEADREVS', d)
-        key =3D self.generate_revision_key(ud, d, name)
-        try:
-            return revs[key]
-        except KeyError:
-            revs[key] =3D rev =3D self._latest_revision(ud, d, name)
-            return rev
+        with bb.persist_data.persist('BB_URI_HEADREVS', d) as revs:
+            key =3D self.generate_revision_key(ud, d, name)
+            try:
+                return revs[key]
+            except KeyError:
+                revs[key] =3D rev =3D self._latest_revision(ud, d, name)
+                return rev
=20
     def sortable_revision(self, ud, d, name):
         latest_rev =3D self._build_revision(ud, d, name)
--=20
2.43.0


