Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3439D58D6E
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:19:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.88])
 by mx.groups.io with SMTP id smtpd.web11.24241.1732555190170477222
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:19:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=xF1fOVeu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.96.88, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgHIuZdVT7+2xooko97mv0CH5CmeFDobR6BQBBR3y0BweGoKMmtLb4LZCCkUcnYXxdqpDNulmS3MJOHpOxl7N3vgP9zh0SVDgTuUua7U3dwlhHOlxC1bFhJMMawhaKFfSNhxpDf6zozAKoZUycpGCfQ36w8hpVlIaq0MFcvXbYS8lD7gErVAmfZ4GLUzNsSeFetkG2TuZcVnFyVi2fm8yBIqtx0xbg6hW9CbdbWz6gW67a7iKEuAC0nP2qIIzZsnVVDYed7nnIiUkbqSMFBSpNPob5FZFD0PopHqfiW2RZolm44ZmdR7DdDASJmCBZB0Zw9qSVVHhDJo9uxaQHjruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctaIwoMMw3ceDx5bqIGsXMvMij+qzD0DbYY8PzTbdJs=;
 b=crTlMuEzcsz5Le6ZfE+tvnWO6/xk4gP9ZZkXWfwawxFLPiway5/+oGbiIV63EduLYTc3y1088kyWGQMcY6fFcWImy9gSxnttgujKKjDBDNHI2cHuN+MSvvu6pKniCQ9izxrkjJKXNTvV/voTiEKA+uoYRxz6a2NPO7ynRAOtlw/Grc9w1o+sXAAltTmq5yz3ApKNLv3hCnxetr1L/bpj821zKVzSjKrGRidU3P1hbwn27Y/eL0rmDu8X7K0UG2dB4tK2TS4Y1sr/ozSH9wOylRbWzLCLBhgh2vVhuhb/HPeKq5qJhPgG9gAYFPSIUS6QELLKBATTh8DPnoous2wk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctaIwoMMw3ceDx5bqIGsXMvMij+qzD0DbYY8PzTbdJs=;
 b=xF1fOVeufIkECU2xLW5niI6vlxKuNc26O+7Z0DM2LdrmP+K1GF7Dui+h5VjCtT+RN3vMv9gva/LfSIk0O97+Na2Z1p226E8CCv7HDYWjwB2vBpjykPzT8y4B+j7KgqlNnPwrGFkb33B0La6RIcKPWSNIwoozkOcSc3dJweU0jP9MBXlYn4p8Uosr/zZeBlTGPoEeGsSLPvwaGGdzjBjkthet5+IZEAqXQGAdqXe6wURabohHpOR2OFRCvn4ub6Z/5Uwg9Vo6YCVWeJUEW3YS6l3tYs+j8JAmIy72rH9+XSJEWiWiGFwWGfqoNsSVCXoJjyER4OPLhg6Gz43C3AKkWQ==
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 25 Nov
 2024 17:19:29 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::2c) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.11 via Frontend Transport; Mon,
 25 Nov 2024 17:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 17:19:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:19:23 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [kirkstone][2.0][PATCH 2/2] fetch2: use persist_data context managers
Date: Mon, 25 Nov 2024 12:19:09 -0500
Message-ID: <20241125171909.1405732-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125171909.1405732-1-chris.laplante@agilent.com>
References: <20241125171909.1405732-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0ee014-1779-4b5f-5ec4-08dd0d7551d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mroIaTWPvOejgnTOtGPclAjR2iZTdnuM95OSMeNI4itZ7Lxov1Q1xXHg1A+g?=
 =?us-ascii?Q?Ynm11hw4DUSXnebR4MZsap8djAcvMyBHyhRKdo9IEarrLe8YKIGa62xAR36t?=
 =?us-ascii?Q?dd0W4lMyNEfpVBgSmwKqtD6c5OHhabWgsKWHOuQywxiN7sMr0TUXFjV4biuU?=
 =?us-ascii?Q?kUKZdpjzsr52bLafUznnAinRCkVHvG/BjeD+vscSKUaQ16xGAM1VM/SL1liY?=
 =?us-ascii?Q?MjqEkyZ6YBt6hHlm1rkxcmDe3RsUZmd7Tq2WPPfxm2Zec3AsbrYBLW0XoDtz?=
 =?us-ascii?Q?O/MKSwoI48hMuIHT6rhwvm626XFsS3CJTQoocRSYZ72xpHOVOtXutr2fJdVW?=
 =?us-ascii?Q?7VlrWfj9FD50pDD/NixHo4SWwvxNQInmfiEfCyxqIw1i+09BG/a975WuvC53?=
 =?us-ascii?Q?KT4DFfVKhFZRsVCu5pL03t3TrhDo0bzeIMvMbqoMh/B3ySXwG9tEMziM83Zv?=
 =?us-ascii?Q?9ME8hQFUt7XB5UdFGaAZBxjRq4/yahdvpa1OvjlBhPxJgrc5uUoYAsXG98KF?=
 =?us-ascii?Q?18pXrhwU93JuMiSkv3KGIpgryNzN+jD5ceOBibrURWWpGgLdFnwwHHbo2vaL?=
 =?us-ascii?Q?qpeWDgVwxUxZmabtBdnQjRX9suHSSkeS/opq7bZZ1lbbYsNwghphR8sfaKly?=
 =?us-ascii?Q?3lsFwOxgjFHuxpnuke8Te+wsr0iNXAUcaY/FtROv4Oe/yHCV9zWNzDk2nMLQ?=
 =?us-ascii?Q?zh8It/5hiKML6Achj/gdqo97v1suv7aOI1wEHxPQSg2a2IzhaaL507ez2/NN?=
 =?us-ascii?Q?uv20e17qHwxtsBaCpJ8B5sDVee/j5CNCwTi9zRFBVJwIqBatD7Ck1dHQUny5?=
 =?us-ascii?Q?/OBRlI00qoz8Qmv2sFQkdSpQFWzT1kzh/Z4OIDL0UsWiJiShlE4HKll9JIHb?=
 =?us-ascii?Q?yzIXfZtatahzJBK1XSlDrTil9TOm/O4w/KMxtpmyG8m/TwI9uDCRSZOSCjbV?=
 =?us-ascii?Q?RGOki3eqOmGeK+x7+5IfPwBVHISVG+V1lj9XQujG8AshLw3wm+3RD/HuCKkh?=
 =?us-ascii?Q?A+puLN36dJMz/uRspl24rOX+4RVKD4JD3TPiNuvec5rjYNn8HdnWTYma9/SY?=
 =?us-ascii?Q?vXRevrS/+Dn1dACx2g/mdf0iIQP/ZOJ+vC8lNJ8fwXKootCn4Xwyz6Jopt8T?=
 =?us-ascii?Q?IBHw4jxrEVVqIVu4ZQRodLR6bhi1WqylsYmA4HVZVzTelKjg0RkjXIFB+e4j?=
 =?us-ascii?Q?12QvaPYGGpF2GZwc2VgetsZHHs256VQbPmWi+4nIb/BgDmIM5rAWomTeCB91?=
 =?us-ascii?Q?YFRyTNNMszxIeY9XnATK5Tms+DukkwcKniA9vN4CNpHCtvoKT7q8AMscMS0k?=
 =?us-ascii?Q?yEel5jDYTsikcFTi9rUA+ESrbulaxjvUmvJuKtEq+1FYMBdo+ZYhIiVtdMAD?=
 =?us-ascii?Q?HtFOGEiUzRSDVsE1HGk/sWmydKNtLTUO1kNYCPTEbLq079D2+A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:19:29.0435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0ee014-1779-4b5f-5ec4-08dd0d7551d4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:19:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16831

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
index a31406263..f66bddd4b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -498,30 +498,30 @@ def fetcher_init(d):
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
-    _checksum_cache.init_cache(d)
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
+        _checksum_cache.init_cache(d)
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
@@ -535,8 +535,8 @@ def fetcher_compare_revisions(d):
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
@@ -1618,13 +1618,13 @@ class FetchMethod(object):
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


