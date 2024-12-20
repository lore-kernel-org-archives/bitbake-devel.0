Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF75E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=P+iHf2fr;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5TuVP5KcR3LSQg7ovFexeWEqDvcRc3ZTdhR2YHannIUVELTvQjxbv+Qqb3w5GeVlCAX9kMVJAmB2WKVnMVjtV/zvLMUAnIE8P5iVNdLI81NrIiXjABNwrc7CxjQKZJDMqBWAzqPN56MtwH2ltkvU8Zg4FABer/BxLsSltFYzCSd1E04sOsrqU46BPXhP+HG4+mQyxklx4oOu7vScwfQ4HMnthZz+Op0splX7SwFEB21m1dk49WaugUi4ZkKjXgd7mBYIHgqp/6NJDMbii3ILY+GZBYIfAOgWVw4VPbl8Xjh+OIRWpCr9WCkeH1KASR4zF9TX4QontrkiaAe7xtTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvdvJvJB6+N3H9ozFzVfup0kjThedpLfqngTHxqOgM8=;
 b=g6LufJ/ONd9fqQEvF8S7/khtP/3oEbUtzbA9eW168TWKKK/ph7bDhgfSedoRFWdysjzaKArKV7ONoPCLM0TreVn9N20FTimjNLqDMC8Y02KLxeSGRpykRHrPypb/Yz33b08etHgeWYuV9PsCRc11GLbfT4LxY+Hn7fyWvyZIGe+zJeOVU+Am7DptkdPEOrqkRRpBCcdnf8u/+BDiquL1QJPRu1uAAKdAK3qg4O3UtTfsNtJWlhHTZxGLp0XLv9zXHolKuuZg0olRKI4aCscmaF7/o+KekSG8USQ/vSLjV+29XOlZ//D62kltxSBJA1v0mkf0zLH+DosiuA5KOB4TiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvdvJvJB6+N3H9ozFzVfup0kjThedpLfqngTHxqOgM8=;
 b=P+iHf2fr9UPNRyhKh/aVEM/iIa5BqeTtkZBZmv2VKA/U0rHBJ6Anwa344xEao5xdKosck4SeYXcm0zbrZHYjdamUxsI1bcVON8RExsH1A40R5F9ELPm/liq229RM0X0PCQDty7HgWCtinbQsk+/c4Qh5Od1PO1tU153EtIG4rXmfj3MpYIDq/fucA+IjKc4+ijDoLz9YB73sKRw3N+Vp22tn2h+7cp/S7eKsgp9IYN71owIHK6sN3cuU7z8tNaXIqT1kuoOFLd68jBkoABhibH8/Qxkcn1lSth/u/WZTJ0Uht0liwYVVlLkb8IzhnfiNErK1i/5F3Pvv1BNADm6n+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 16/21] fetch: npmsw: migrate to dependency mixin
Date: Fri, 20 Dec 2024 12:26:07 +0100
Message-ID: <20241220112613.22647-17-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: a389a305-b96e-45e3-4b1c-08dd20e925f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y3huxe38ffn0XP53fvlVsBCIcJ3CagXN+uP+anoAOuJI6h4BudhqyLdZ/h4x?=
 =?us-ascii?Q?BgPz4HEVjxqYil7xlgmH/PlLn2q+is0GnGhpKl3Gd1U+klKzRE5JF6UzX8o2?=
 =?us-ascii?Q?wgW1dheCFfy7mNVDLjDuD5uD8ti/3FFGiYXH9ryE2WvzrRMus57X1QnocE3s?=
 =?us-ascii?Q?f0OyLXRye4jKSbCj4GRlUDK6StPu0G3He0UL6s5ZxdjnpBrVZEf7lkB4zE2D?=
 =?us-ascii?Q?mwv0NVokYDDJMptIYOpNKsYXhoJ8rMZCFMZxrMt2G7j3W/vgrHQOGFIB8qxV?=
 =?us-ascii?Q?RJKDOKt4kFe5b0Tg96r1a7+34Pff6Qfcmp756dBVyGRli+23WOU8+sGp8sC6?=
 =?us-ascii?Q?YeFinIL+k+G+Jktdrj13I1ESgCGFDAuQEy63fuu/4wCAXc194FThuSkt6DJs?=
 =?us-ascii?Q?PL6D/5SR9bN2zvw/N/0yjAHn/+NV9VQHXKO1o59Kwl6pL8CoSuj2vopISLlU?=
 =?us-ascii?Q?LEkVlKI59BaER3FNsS/k2EP2opyGyZdjxLHrG08qowjVsnR1jc33H5wNhPZ1?=
 =?us-ascii?Q?OibKjkNu+aKUDtmTD7JFWprLVILedmhisILIkr/MNsR0e0xj05QsRX6q+GeT?=
 =?us-ascii?Q?pbIRFbWUl4I2Kh8ntMwhVTeED2mCp9hrKLfzam75eiOmISyyQ6Wt3wVDQI5I?=
 =?us-ascii?Q?x36WupK3q1MYlne3J+tndUxF16OwQhQzdKVhWUauGIPV+MeQNxAKecXJ9j2D?=
 =?us-ascii?Q?0Y/bklo6fQgdH1MgiXpvI+mXJ9X3zuVWbqHRbLGuSAtnZu15ImVBZeffDz05?=
 =?us-ascii?Q?VLbcYlTownNHp7zxp2r9Ina+QNIfMu7cRPRcENKgT/t8asg0ZLViuY91sfMN?=
 =?us-ascii?Q?GQcG2zaLLRqdbPlz3hFtUUHDJNc523lgm9bSFfuM0QFeQc27Qoyqxg/a9brF?=
 =?us-ascii?Q?IQIU9vMEyq20dYc9EKvqRb/DKaTd8FR2IZ/Wb6zQePjIuAbT5FcG67hQy2fp?=
 =?us-ascii?Q?P0k8wrx0zFIVUStIWJJnjLpOE3PKQqsBZcYrCfqlsqlqQSpLvfLqy5pkoeit?=
 =?us-ascii?Q?XamvO557frioxNvvO7lGbPqcHdASLg5Ko0+dcaUYv8xlXIDIsGFvMmv+crNn?=
 =?us-ascii?Q?yWU17VqOanuBP7Ms0JuzeqpPT1yBUwlf4dOlI5o12qgFrrW+zjMjFOI8wv3V?=
 =?us-ascii?Q?7UF2rrroB2XcWlq6/3bX4k/mHtGPp13L10E2m8xVeeRW2MrEf6/qDbt6cu8G?=
 =?us-ascii?Q?ArtbQkRFNe4VR4glfv7/Ko0rl3K9WDXfA/7CXLfcDApvWc5ADofWe/x0poVH?=
 =?us-ascii?Q?rRo6b7V7GVZt0omUX3IkmQcTZUhZ58D006pPm3avdoT9Yv59ntFaMMTlQHmt?=
 =?us-ascii?Q?J4+jvVwNrqjddCzr8Z7sNPzQVeHJRXqeJ87GZ0e87Zj2QXP+ciyQeIlKL0xx?=
 =?us-ascii?Q?JABkVzYkLf/A54spIYELbBD3fgW2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cPEEPENEtWnx/xpci+Yq6517UqGbNzDS+LJuDxWWtBQ/+JPOu8/I4RSl1ENf?=
 =?us-ascii?Q?ef8Bpuk1p4wDN9o6bX0oZ11pxv+EvFASUzimyQNjPc49yg0OjVC1GVy/DPex?=
 =?us-ascii?Q?vBxzHbu3hMTn5/b2VEt0Nlmc+PJ1g/MY/9UKnDtXDAvXLpwXzpAWyagK7PIE?=
 =?us-ascii?Q?FY92eyjmPA3QonXT+XeB98Qr3gM2CesTQtVmKZfIlOsZk1fYXu1jgE1sm3Un?=
 =?us-ascii?Q?Gsh0yKLfLNhBv6tnlpxl70ybG8dBun9DO3O/uEVP6FNLJMtaB1wHyfUB2PnK?=
 =?us-ascii?Q?aNmNb9fVbckgl+I7FUBUcKj+balTmKv3JlUuegt2L43Bylc95H+oWp5VE+iE?=
 =?us-ascii?Q?qeX2fzvT0XVoTJLkLJAeze49ZY3p6AitZktDYwTTM/Y8FubXZGDBnjbCMwZA?=
 =?us-ascii?Q?rWanvLxS4Iemgor6M7ezPg0vSJZuGbYlOYPwPH1bJ7WJpA6u4ibRqWG81PdU?=
 =?us-ascii?Q?jfdZVHR5Nj1670b2x00Gwj2jygtO8Q8weo+jGV+dsw06ueLeylO57ixZZR/R?=
 =?us-ascii?Q?nPb+RmijtHXcfhfn96gpFSjyNlaLp0VTf5sFB8aM38aVCh6PX2EaDIpZEbOC?=
 =?us-ascii?Q?u8vzsubunSlNFiHedVNtQGdKDllq/1QCKIgvdw8V525zkYY+20LPD9nOAaY1?=
 =?us-ascii?Q?EMG211boopdHj+DV8JDDPuBtfDrUVgX5KC3LlVHIrPdbdjgYNlOA3JzD6YD5?=
 =?us-ascii?Q?LwTdBKxSIOkfUTtXDMCLphZHOjdDi/nM7jcHSYdA8gLuZuEdNwOBAc2nLGqq?=
 =?us-ascii?Q?ASTo0mveaA3XDXMBbm+yqmC99yR33DeJAyJ2CG96am2ToLarBPuk9OXqNM7a?=
 =?us-ascii?Q?QuPb3RkB0jN/S/VJPUiXiHIsllSfhr+sYNXDa8DCoT0m2K/yDLNDZtOVCjJj?=
 =?us-ascii?Q?LW266L8BpCWggSX9fp5h+ulDsjpOG3RqSlpnBlQtiOMlrTNEeF2CNBtoowi9?=
 =?us-ascii?Q?B84iUX+hWAf6yD53ogdYC4kupzKT9JQ1UqE1++wLM1+G1oMMrUVr3UdkS7Lx?=
 =?us-ascii?Q?mZzGIPY2TyrYk2B8/PVX9+S2Ggbf2vmF4a6Dt1EI+Y2IWr6VtOq8kqr7ucrQ?=
 =?us-ascii?Q?Ne/Q1Hs+n/BKG08UlxYQHaH7EvBhmbLhMMzsZXQLBaCUsMON1CBSMCjF6RQr?=
 =?us-ascii?Q?mAaWgvQNFUHsRlEKOFP4nVgMiVOHThHWn2rFcPXIhExd5EJyIUgewyDrhhvq?=
 =?us-ascii?Q?rNWfBvtEINUbNQec+TkS3iqyZu7cgnnt47A2v5gsPE/DSCxkxHEFr6GAmmZ6?=
 =?us-ascii?Q?jq0ufLORsl0jG2BXiA5hDEuetH+3TbF2XkAl+YPVvCUfH3RLZ3l1ypbnBQ/p?=
 =?us-ascii?Q?PQBSZ0tDcspRZhX9VWL2EO2hFvoFNV8wQ/6GAnKgZpbcewX/+Iy6Qy9Bx1qC?=
 =?us-ascii?Q?waXpiJDYdACyVIRqT7RHWtPmofwqQ/DGCOjwa2dYRTh7jK3lHgz+Yh1LkhP1?=
 =?us-ascii?Q?PXlXJyWj3PbOQjNJhx6R9wCxmUqmIqxjVHuk2rOM3IYJB+GKzvJAPbFikwBs?=
 =?us-ascii?Q?ej1YdgSWTh3cgEZ9QwYFSTWcuWXLnuvchjQ4ig2mK33oEbCm/6UZmYM99CKf?=
 =?us-ascii?Q?uZlHyGuR/WztTGYW9Af6J1fjFxlkWjxvV0n+eod/fFBGHFb2430sBPAjv3/X?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a389a305-b96e-45e3-4b1c-08dd20e925f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:29.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCAfQvzwLeJ8O5xWz+LREBxYJITMOGdarNbuc8kmje8kfGsAPWhSE92GNEqqq0cM2lIe3c9XLENpBc/IUT20VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16929

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Migrate npmsw fetcher to dependency mixin to support different fetcher
subtypes. The migrated fetcher fetches dependencies via a
npm-shrinkwrap.json file or if missing via package-lock.json file. It
supports different types:s

npmsw
    The fetcher uses a local npm-shrinkwrap.json or package-lock.json
    file to fetch dependencies.

    SRC_URI =3D "npmsw://npm-shrinkwrap.json"

npmsw+https
    The fetcher downloads a npm-shrinkwrap.json or package-lock.json
    file or archive with a npm-shrinkwrap.json or package-lock.json
    file in the root folder and uses the npm-shrinkwrap.json or
    package-lock.json file to fetch dependencies.

    SRC_URI =3D "npmsw+http://example.com/ npm-shrinkwrap.json"
    SRC_URI =3D "npmsw+http://example.com/${BP}.tar.gz;striplevel=3D1;subdi=
r=3D${BP}"

npmsw+git
    The fetcher checkouts a git repository with a npm-shrinkwrap.json or
    package-lock.json file to fetch dependencies.

    SRC_URI =3D "npmsw+git://example.com/${BPN}.git;protocol=3Dhttps"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py   |   2 +-
 lib/bb/fetch2/dependency.py |   8 --
 lib/bb/fetch2/npmsw.py      | 272 +++++++++---------------------------
 3 files changed, 66 insertions(+), 216 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3a7030bf3..5dbc0598d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2134,9 +2134,9 @@ methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
-methods.append(npmsw.NpmShrinkWrap())
 methods.append(az.Az())
 methods.append(crate.Crate())
 methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
 methods.append(gomod.GoModGit())
+methods.extend(npmsw.methods)
diff --git a/lib/bb/fetch2/dependency.py b/lib/bb/fetch2/dependency.py
index 4acad8779..e30d7fb73 100644
--- a/lib/bb/fetch2/dependency.py
+++ b/lib/bb/fetch2/dependency.py
@@ -46,7 +46,6 @@ class DependencyMixin:
         return returns
=20
     def verify_donestamp(self, ud, d):
-        """Verify the donestamp file"""
         if not super().verify_donestamp(ud, d):
             return False
=20
@@ -56,7 +55,6 @@ class DependencyMixin:
         return all(self._foreach_proxy_method(ud, handle, d))
=20
     def update_donestamp(self, ud, d):
-        """Update the donestamp file"""
         super().update_donestamp(ud, d)
=20
         self._init_proxy(ud, d)
@@ -65,7 +63,6 @@ class DependencyMixin:
         self._foreach_proxy_method(ud, handle, d)
=20
     def need_update(self, ud, d):
-        """Force a fetch, even if localpath exists ?"""
         if super().need_update(ud, d):
             return True
=20
@@ -75,7 +72,6 @@ class DependencyMixin:
         return any(self._foreach_proxy_method(ud, handle, d))
=20
     def try_mirrors(self, fetch, ud, d, mirrors):
-        """Try to use a mirror"""
         if not super().try_mirrors(fetch, ud, d, mirrors):
             return False
=20
@@ -85,25 +81,21 @@ class DependencyMixin:
         return all(self._foreach_proxy_method(ud, handle, d))
=20
     def download(self, ud, d):
-        """Fetch url"""
         super().download(ud, d)
         self._init_proxy(ud, d)
         ud.proxy.download()
=20
     def unpack(self, ud, rootdir, d):
-        """Unpack the downloaded dependencies"""
         super().unpack(ud, rootdir, d)
         self._init_proxy(ud, d)
         ud.proxy.unpack(ud.destdir)
=20
     def clean(self, ud, d):
-        """Clean any existing full or partial download"""
         self._init_proxy(ud, d)
         ud.proxy.clean()
         super().clean(ud, d)
=20
     def done(self, ud, d):
-        """Is the download done ?"""
         if not super().done(ud, d):
             return False
=20
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 2f9599ee9..fffb2a102 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -1,37 +1,35 @@
 # Copyright (C) 2020 Savoir-Faire Linux
+# Copyright (C) 2024-2025 Weidmueller Interface GmbH & Co. KG
+# Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
 """
-BitBake 'Fetch' npm shrinkwrap implementation
+BitBake 'Fetch' implementation for npm-shrinkwrap.json and package-lock.js=
on
=20
-npm fetcher support the SRC_URI with format of:
-SRC_URI =3D "npmsw://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..."
+The npmsw, npmsw+https and npmsw+git fetchers are used to download npm pac=
kage
+dependencies via a npm-shrinkwrap.json and package-lock.json file.
=20
-Supported SRC_URI options are:
+The fetcher support the SRC_URI with format of:
+SRC_URI =3D "npmsw://npm-shrinkwrap.json"
+SRC_URI =3D "npmsw+https://example.com/name-1.2.3.tar.gz"
+SRC_URI =3D "npmsw+git://example.com/repo.git"
+
+Additional supported SRC_URI options are:
=20
 - dev
    Set to 1 to also install devDependencies.
-
-- destsuffix
-    Specifies the directory to use to unpack the dependencies (default: ${=
S}).
 """
=20
+import base64
 import json
 import os
 import re
 import bb
-from bb.fetch2 import Fetch
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import ParameterError
-from bb.fetch2 import runfetchcmd
-from bb.fetch2 import URI
-from bb.fetch2.npm import npm_integrity
-from bb.fetch2.npm import npm_localfile
-from bb.fetch2.npm import npm_unpack
+from bb.fetch2 import FetchError, ParameterError, URI
+from bb.fetch2.dependency import create_methods
+from bb.fetch2.npm import construct_url_path
 from bb.utils import is_semver
-from bb.utils import lockfile
-from bb.utils import unlockfile
=20
 def foreach_dependencies(shrinkwrap, callback=3DNone, dev=3DFalse):
     """
@@ -58,40 +56,31 @@ def foreach_dependencies(shrinkwrap, callback=3DNone, d=
ev=3DFalse):
         name =3D location.split('node_modules/')[-1]
         callback(name, data, location)
=20
-class NpmShrinkWrap(FetchMethod):
-    """Class to fetch all package from a shrinkwrap file"""
-
-    def supports(self, ud, d):
-        """Check if a given url can be fetched with npmsw"""
-        return ud.type in ["npmsw"]
-
+class NpmShrinkWrapMixin:
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""
-
-        # Get the 'shrinkwrap' parameter
-        ud.shrinkwrap_file =3D re.sub(r"^npmsw://", "", ud.url.split(";")[=
0])
-
-        # Get the 'dev' parameter
+        super().urldata_init(ud, d)
         ud.dev =3D bb.utils.to_boolean(ud.parm.get("dev"), False)
=20
-        # Resolve the dependencies
-        ud.deps =3D []
+    def resolve_dependencies(self, ud, localpath, d):
+        urls =3D []
=20
-        def _resolve_dependency(name, params, destsuffix):
+        def resolve_dependency(name, data, location):
             url =3D None
-            localpath =3D None
-            extrapaths =3D []
-            unpack =3D True
=20
-            integrity =3D params.get("integrity")
-            resolved =3D params.get("resolved")
-            version =3D params.get("version")
-            link =3D params.get("link", False)
+            integrity =3D data.get("integrity")
+            resolved =3D data.get("resolved")
+            version =3D data.get("version")
+            link =3D data.get("link", False)
+
+            if integrity:
+                algorithm, value =3D integrity.split("-", maxsplit=3D1)
+                checksum_name =3D f"{algorithm}sum"
+                checksum_value =3D base64.b64decode(value).hex()
=20
-            # Handle link sources
+            # Skip link sources
             if link:
-                localpath =3D resolved
-                unpack =3D False
+                return
=20
             # Handle registry sources
             elif version and is_semver(version) and integrity:
@@ -99,193 +88,62 @@ class NpmShrinkWrap(FetchMethod):
                 if not resolved:
                     return
=20
-                localfile =3D npm_localfile(name, version)
-
                 uri =3D URI(resolved)
-                uri.params["downloadfilename"] =3D localfile
-
-                checksum_name, checksum_expected =3D npm_integrity(integri=
ty)
-                uri.params[checksum_name] =3D checksum_expected
-
+                package_path =3D construct_url_path(name, version)
+                if uri.scheme =3D=3D "https" and uri.path.endswith(package=
_path):
+                    uri.scheme =3D "npm"
+                    uri.path =3D uri.path[:-len(package_path)]
+                    uri.params["dn"] =3D name
+                    uri.params["dv"] =3D version
+                    uri.params["destsuffix"] =3D location
+                else:
+                    bb.warn(f"Please add support for the url to npm fetche=
r: {resolved}")
+                uri.params[checksum_name] =3D checksum_value
                 url =3D str(uri)
=20
-                localpath =3D os.path.join(d.getVar("DL_DIR"), localfile)
-
-                # Create a resolve file to mimic the npm fetcher and allow
-                # re-usability of the downloaded file.
-                resolvefile =3D localpath + ".resolved"
-
-                bb.utils.mkdirhier(os.path.dirname(resolvefile))
-                with open(resolvefile, "w") as f:
-                    f.write(url)
-
-                extrapaths.append(resolvefile)
-
             # Handle http tarball sources
             elif resolved.startswith("http") and integrity:
-                localfile =3D npm_localfile(os.path.basename(resolved))
-
                 uri =3D URI(resolved)
-                uri.params["downloadfilename"] =3D localfile
-
-                checksum_name, checksum_expected =3D npm_integrity(integri=
ty)
-                uri.params[checksum_name] =3D checksum_expected
-
+                uri.params["subdir"] =3D location
+                uri.params["striplevel"] =3D 1
+                uri.params[checksum_name] =3D checksum_value
                 url =3D str(uri)
=20
-                localpath =3D os.path.join(d.getVar("DL_DIR"), localfile)
-
-            # Handle local tarball sources
+            # Skip local tarball
             elif resolved.startswith("file"):
-                localpath =3D resolved[5:]
+                return
=20
             # Handle git sources
             elif resolved.startswith("git"):
-                regex =3D re.compile(r"""
-                    ^
-                    git\+
-                    (?P<protocol>[a-z]+)
-                    ://
-                    (?P<url>[^#]+)
-                    \#
-                    (?P<rev>[0-9a-f]+)
-                    $
-                    """, re.VERBOSE)
-
-                match =3D regex.match(resolved)
-                if not match:
-                    raise ParameterError("Invalid git url: %s" % resolved,=
 ud.url)
-
-                groups =3D match.groupdict()
-
-                uri =3D URI("git://" + str(groups["url"]))
-                uri.params["protocol"] =3D str(groups["protocol"])
-                uri.params["rev"] =3D str(groups["rev"])
+                url, _, rev =3D resolved.partition("#")
+                uri =3D URI(url)
+                scheme, _, protocol =3D uri.scheme.partition("+")
+                if protocol:
+                    uri.params["protocol"] =3D protocol
+                    uri.scheme =3D scheme
+                uri.params["rev"] =3D rev
                 uri.params["nobranch"] =3D "1"
-                uri.params["destsuffix"] =3D destsuffix
-
+                uri.params["destsuffix"] =3D location
                 url =3D str(uri)
=20
             else:
-                raise ParameterError("Unsupported dependency: %s" % name, =
ud.url)
+                raise ParameterError(f"Unsupported dependency: {name}", ud=
.url)
=20
-            # name is needed by unpack tracer for module mapping
-            ud.deps.append({
-                "name": name,
-                "url": url,
-                "localpath": localpath,
-                "extrapaths": extrapaths,
-                "destsuffix": destsuffix,
-                "unpack": unpack,
-            })
+            urls.append(url)
=20
+        if os.path.isdir(localpath):
+            localdir =3D localpath
+            localpath =3D os.path.join(localdir, "npm-shrinkwrap.json")
+            if not os.path.isfile(localpath):
+                localpath =3D os.path.join(localdir, "package-lock.json")
         try:
-            with open(ud.shrinkwrap_file, "r") as f:
+            with open(localpath, "r") as f:
                 shrinkwrap =3D json.load(f)
         except Exception as e:
             raise ParameterError("Invalid shrinkwrap file: %s" % str(e), u=
d.url)
=20
-        foreach_dependencies(shrinkwrap, _resolve_dependency, ud.dev)
-
-        # Avoid conflicts between the environment data and:
-        # - the proxy url revision
-        # - the proxy url checksum
-        data =3D bb.data.createCopy(d)
-        data.delVar("SRCREV")
-        data.delVarFlags("SRC_URI")
-
-        # This fetcher resolves multiple URIs from a shrinkwrap file and t=
hen
-        # forwards it to a proxy fetcher. The management of the donestamp =
file,
-        # the lockfile and the checksums are forwarded to the proxy fetche=
r.
-        shrinkwrap_urls =3D [dep["url"] for dep in ud.deps if dep["url"]]
-        if shrinkwrap_urls:
-            ud.proxy =3D Fetch(shrinkwrap_urls, data)
-        ud.needdonestamp =3D False
-
-    @staticmethod
-    def _foreach_proxy_method(ud, handle):
-        returns =3D []
-        #Check if there are dependencies before try to fetch them
-        if len(ud.deps) > 0:
-            for proxy_url in ud.proxy.urls:
-                proxy_ud =3D ud.proxy.ud[proxy_url]
-                proxy_d =3D ud.proxy.d
-                proxy_ud.setup_localpath(proxy_d)
-                lf =3D lockfile(proxy_ud.lockfile)
-                returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
-                unlockfile(lf)
-        return returns
-
-    def verify_donestamp(self, ud, d):
-        """Verify the donestamp file"""
-        def _handle(m, ud, d):
-            return m.verify_donestamp(ud, d)
-        return all(self._foreach_proxy_method(ud, _handle))
-
-    def update_donestamp(self, ud, d):
-        """Update the donestamp file"""
-        def _handle(m, ud, d):
-            m.update_donestamp(ud, d)
-        self._foreach_proxy_method(ud, _handle)
-
-    def need_update(self, ud, d):
-        """Force a fetch, even if localpath exists ?"""
-        def _handle(m, ud, d):
-            return m.need_update(ud, d)
-        return all(self._foreach_proxy_method(ud, _handle))
-
-    def try_mirrors(self, fetch, ud, d, mirrors):
-        """Try to use a mirror"""
-        def _handle(m, ud, d):
-            return m.try_mirrors(fetch, ud, d, mirrors)
-        return all(self._foreach_proxy_method(ud, _handle))
-
-    def download(self, ud, d):
-        """Fetch url"""
-        ud.proxy.download()
-
-    def unpack(self, ud, rootdir, d):
-        """Unpack the downloaded dependencies"""
-        destdir =3D rootdir
-        destsuffix =3D ud.parm.get("destsuffix")
-        if destsuffix:
-            destdir =3D os.path.join(rootdir, destsuffix)
-        ud.unpack_tracer.unpack("npm-shrinkwrap", destdir)
-
-        bb.utils.mkdirhier(destdir)
-        bb.utils.copyfile(ud.shrinkwrap_file,
-                          os.path.join(destdir, "npm-shrinkwrap.json"))
-
-        auto =3D [dep["url"] for dep in ud.deps if not dep["localpath"]]
-        manual =3D [dep for dep in ud.deps if dep["localpath"]]
-
-        if auto:
-            ud.proxy.unpack(destdir, auto)
-
-        for dep in manual:
-            depdestdir =3D os.path.join(destdir, dep["destsuffix"])
-            if dep["url"]:
-                npm_unpack(dep["localpath"], depdestdir, d)
-            else:
-                depsrcdir=3D os.path.join(destdir, dep["localpath"])
-                if dep["unpack"]:
-                    npm_unpack(depsrcdir, depdestdir, d)
-                else:
-                    bb.utils.mkdirhier(depdestdir)
-                    cmd =3D 'cp -fpPRH "%s/." .' % (depsrcdir)
-                    runfetchcmd(cmd, d, workdir=3Ddepdestdir)
-
-    def clean(self, ud, d):
-        """Clean any existing full or partial download"""
-        ud.proxy.clean()
+        foreach_dependencies(shrinkwrap, resolve_dependency, ud.dev)
=20
-        # Clean extra files
-        for dep in ud.deps:
-            for path in dep["extrapaths"]:
-                bb.utils.remove(path)
+        return urls
=20
-    def done(self, ud, d):
-        """Is the download done ?"""
-        def _handle(m, ud, d):
-            return m.done(ud, d)
-        return all(self._foreach_proxy_method(ud, _handle))
+methods =3D create_methods("npmsw", NpmShrinkWrapMixin)
--=20
2.39.5


