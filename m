Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FCD58D6C
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:12:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.59])
 by mx.groups.io with SMTP id smtpd.web10.23801.1732554766238310574
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:12:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=ALrwalmJ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6MsRFosknbC7b/cjpp3a+9a3La3cMOXBxhOxoHBIHdsEvaX6ZSEk2Xrs0rfPYA2eqfUL+APPpsyW0y9NzQnJ7EgyM64aXm1mdFflab1mTtHfMbJjyvhwlSta2v4iKbNjWJCdsuLNolq9iBHcLrgydQX7KrI12uWU+p78qsM1hGpTfjr2HDaiwm6z31/6KGCxF/Yn0FvMbT5YOcbd7wTLBhzutDVBswvERFRvq2dfaMvZ7CglofBgxYOKFsaX9zEEYhbpH/swelk/hbqcSXs8ZXAStvrTVNFtG+1uDZaax0j4yEp+D0xT8IQbmWRQhe3zV0kCbawiV/pJp8aMOnMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDRxsgYWzbb3FVIcc8i6KWCRnWdaY5PuvK/WOqg0vrk=;
 b=sJZJL64veMQnwLXVf5AGgddp7AYohtb/Z8BSfd1eXLN7/WRboRc02fAMa5tbYOmiH32tkqbX8P5/ON3GthAI2j/yxAiM1uVeACr8cL2gmTBsrm4F+zV04KNx02b86PcGuJN4wgLDNWygY1eADBkBMCsJUUYNjChXeBNBgKy5gnf3ve0dwqHXgH2lpnUUGh8XFKp/PNGEKm1jjJbZ30EDX+xYCzY+Yoq2rY7ZetlIov9gCjKda6Au5jJp35BJmJ6u5EApGqhG1KCp27rX/o5mfHTBy3YGg1VRzDhn2b65pTb0auA97Yuez2xfsh5EmbIakovb529atyQx04tFmtozEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDRxsgYWzbb3FVIcc8i6KWCRnWdaY5PuvK/WOqg0vrk=;
 b=ALrwalmJI6BlgVAQvtcWAlgaT/n+Mu7H68KB8mQt4/4libkIWvQpgU9QE66W6R96h9CglTRztkcfy+FEeo2eYuPKZmYC9sQwQLG+rvpPUsBnoVxoK7dEQ0Fg1mOvCji4lZZ9aSbOFLnUNjcWeqx6GxgaZJRdBCFPrTlUWAMfyyl5GfKA1fqxe15EyAmS2yuQ5yCkXGdJdH8CHvXt6MRjzbvsDenfeOm+Ko6reDaGms+uS2ppQaRBSU1zw+5RYInnxeaK48/mm0F+BB3cT14iZJY+tFs9qnx4bWmTNUfVyKlIFscJgjpWosIyZnzk8rIKTFVMZl6q8BtXcvfhZCG30w==
Received: from ROAP284CA0264.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f1::18) by
 SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 17:12:37 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10d6:10:f1:cafe::16) by ROAP284CA0264.outlook.office365.com
 (2603:10d6:10:f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 17:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 17:12:36 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:12:31 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [scarthgap][2.8][PATCH 2/2] fetch2: use persist_data context managers
Date: Mon, 25 Nov 2024 12:12:04 -0500
Message-ID: <20241125171204.1263284-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125171204.1263284-1-chris.laplante@agilent.com>
References: <20241125171204.1263284-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: ba68d7a2-308e-4292-99f9-08dd0d745bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+Ub2e/V6LmBLO4QZbqd+pFxf8DXEfw5B+GJKORGs27kGuUiLa/aolju/nmL7?=
 =?us-ascii?Q?Yk23SAfCekMB+sh0Ak0kAbl6W3aAdixBppb77ky6v7C21egILfwNOYvjJLGL?=
 =?us-ascii?Q?DpcAhAZaF94HzYKVdVeSPa76qgckScsIGaIhXvI33P4MpbKqJQQVO/6t7+Cs?=
 =?us-ascii?Q?0rf7L6W6P4K3VyyAjbhiN3msCoWgXiC841A/8D8YQHVhtWXXwj6kgVCkzgy7?=
 =?us-ascii?Q?gDYmctaLc1nbvxRgAS05aMCSOXeBluMDyiDnUibcpN3MUpV/q1pa/qRc+XFc?=
 =?us-ascii?Q?N0M9EKQVopPnyirXP0b+jYKDn9YLYD5Q0CRA/g+J/ghGuSt4U5EXjGk77rUG?=
 =?us-ascii?Q?TY+3/T4d8/X4Gt3f69kxVZ+25TIKBJkvaQHOr9sT7kjd6sPUAw9v7qPg4t9j?=
 =?us-ascii?Q?5X/qBQWYSBtdK4i16w6nS53WcHr86ST6V6L7oecgF/NeVj6Yh9vm4ISliklD?=
 =?us-ascii?Q?ubZgAVbpbzFD80OdW4T0qlkflCC08AtSMCMunTvoWoXVgtLG5PBrnTiJQUj3?=
 =?us-ascii?Q?8NDjJiV17SE0ocKTxY1CsOntqCaXYgJA46dIJGvhLLr7l2cegWhnF54gFNMA?=
 =?us-ascii?Q?mAtTJNyyuRD1vGthtQ2cCkPPSQ90c9YwHINy5ysP4WbuoqZhazR97QzaXkOx?=
 =?us-ascii?Q?ZcoDzAaIeMoM7wi6ITRyPIAaUru4mjE7yVcNc+lGFyR6HLmhBt07PymP1wzd?=
 =?us-ascii?Q?41aEHDXFyHDxODmKYEXJrQ/pMIl6i1kQMo6tJcLmalS2yTSmxDGGqHm3+bQq?=
 =?us-ascii?Q?RzO/tG3GiBR5Ik2aQwUbkk/37FvPKDmxXJAe/xQU6QUjBJ0A/1w4CO2OZEaV?=
 =?us-ascii?Q?m/WliFD8h4QFLof1b1LYWHHE7EFmU8c5a1XbJMPDJVYG7APAAA7LZUR0qC/W?=
 =?us-ascii?Q?28kF1eQ+qPXCnkRaN8XpsEYf/8TSis1xChIFMitijYTJx5uw9nL4tKeStOLN?=
 =?us-ascii?Q?Qp2uurkxj5JrEN0o8CyQWL8WhQjaEI0kpK+G0Ukc8MuSViVYcijYax1BfZzZ?=
 =?us-ascii?Q?vXC0OsgTJ6Iag7y4HX/8NmRs5ESTy3Rju93u9yguWuXL6pI2IxVERF/FyjLQ?=
 =?us-ascii?Q?v7l8eaO0KtnnV20+fBHPpKsw2q86QaDNHttrLZjrXAOk122Zj4LSGU2cvBrY?=
 =?us-ascii?Q?weAo8O5qOsEjYbso06vOrmmhe28n1j/OozYsbsNXB56Ye0lHcOd9u3Te3yqu?=
 =?us-ascii?Q?7Pa5q8sNUEBeJigmnD2fA8Yzd/SFV3ga5wj3sZ1nCimQv9c6R4DUyBxZAjPZ?=
 =?us-ascii?Q?2zhIdjZrF2ifKpmfKbLLu8yQf0ekkQFEgqYoZ2VYW88swK9UvcfEDlLwonXH?=
 =?us-ascii?Q?xQOcZ+eHpYC0hO4LEUIQQW2/EfRqBIZhR7T9fbfpb6KXv6ml5MsTBdzK9VOE?=
 =?us-ascii?Q?EOtqRsVuTsEAUQHhZnO813BOv6wEyr647Y96oPzPTFzj1QuYzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:12:36.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba68d7a2-308e-4292-99f9-08dd0d745bca
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:12:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16829

From: Chris Laplante <chris.laplante@agilent.com>

Python 3.13 emits a ResourceWarning for unclosed sqlite3 `Connection`s.
See https://docs.python.org/3/whatsnew/3.13.html#sqlite3

The previous commit fixed persist_data's context manager to close the
connection, but we were never actually using `with` in the first place.

This change is not necessary on 'master' because persist_data was
removed.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/__init__.py | 62 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5bf2c4b8c..e698fde19 100644
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


