Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB0FCA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=MpT4BtBD;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxF0MlmEox/37EogwkrgpjIEJV8IWQo7K0MWeeARd7hzWO6U2ciEmeW4Jxacd9zO0+EWoAAk3frI/R1arlG6/yTp2gK0C5zcc9TC2qRq1eliR5LVkkd6LuhtFuKzK6lH0nItsV/CfQcjzJZsSrjoY2smgHAjucUcJxo4z9H4W19L2lOaV+zwrFGbvMO0OQGxtajZzr0FWuuLlYINHJ0R66nXqem4+zHb/F8Py5F1lcWVWaIAp7DbqsCA5oXFlFqGOUD9iJnhFowWisX+2j+VGml4rLOILxBrtxH1OGEbCzCwEGXvIk7xmJEDZn4+qvNzpAKibGevPfby2grLzPahoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP5p0G2Qi145I9pDmauGUYaFuRDckZbLSdt3To6PHz0=;
 b=ggEDK3BvWYLnjroNDTdnilLsc82zB0aEKBqtm9I7clc4kYGtOJWP3afYzyExrnijotQqytO6S+gy8AZuTUifdk+6Nkj0zVGd4AncFtwob+9bRZ+ZwqiRV8G/r6i4UfWIgddvg9UJcttae9dkSwYMb2nmvUQMbXQpBUjiYngtsPRgQ32APFVoy64jqNyNkhFs+nDN9TvPHyHagpl61/08uDMYpvha0jMtZQXOCBOfcuaS7SJN6dDuDY5FtJmRwIW47DpJrclxJgQkMt3zuvDYHAggIlrGHfpO+jW2MfvX4gAXIXBSLPl5J/qTbz3VIp8HRAdmINn32ZSsGh4kT2+hqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP5p0G2Qi145I9pDmauGUYaFuRDckZbLSdt3To6PHz0=;
 b=MpT4BtBDS+x1ml8Lpp06JAEQW/kV8MDNZWXrUdDA6Ou3skVlIcFyVvrufQ0YYY4nNiQLi6Hgrt8cRTYHqKvxUHpNhELpKlEtI17MHSVP9u8qwBoXVgKWgcLpi1FyJg5DsbGrkk/xyGax3ftivjcGo7AQHxlAAa3gQI/OAB/n1XldH1YfH831Y/9G/TNa+jM1FOFrt3/OmOjvysQZLJX2Abw5mHru0Nm9zAbVOkgNH9qK/aI3vLnCmCoL5pT3Un+zB3OyQDNhBcen6OZumpwayCk6nGTwOkFgBm0I5wDzu4aWhPtX9Y6S1R1W8fzo1ImYpnWSFPnPSu9HkAfyZfnlVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:10 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:10 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 5/6] fetch2: gitsm: use implicit urls feature
Date: Tue,  2 Sep 2025 08:55:06 +0200
Message-ID: <20250902065507.35737-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GVXPR08MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: f02677d8-cdfe-449e-05d7-08dde9f191b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gh7AfGMYSFRsY34cETWZeCbsMZw8WwqQEcbFYH4TaAgAWmwhiugDilym57Xl?=
 =?us-ascii?Q?FIKoQjLhInKRcu4vTVci3KNl1eBvRzrHorcqtNjnsb9G675GfyxneYorgNfP?=
 =?us-ascii?Q?55Ps4nNZY2WRVxwMFsEi+9dQoav1GVXNfvrQFbQM2QYBTy9vjLXUhcqGLFYs?=
 =?us-ascii?Q?B2Ul2t6PikVVm7RRW51+9TEkRwLZQs/0LCOSRqIKTGQI684+VeXgE0YPzAxZ?=
 =?us-ascii?Q?SkSSaa0Uqf9OaFUxyxaShXMydAkQTt+UyzrOiX06hHv3l2oDQm056tL352+d?=
 =?us-ascii?Q?bgR9m1UearZFgAdMyV4C+JQ3D/pVk6eqPWiEm2VDN30tHbx2G+2RVzpgq7Kh?=
 =?us-ascii?Q?B3JIGmBfIS95cfdnwij5slfzg8sUwLobqDTCCzCweE/bx2g5feGVMPzsPtEo?=
 =?us-ascii?Q?KoiQaTmP6IiMww+zH8Bs4QGvrL5D4huBJAGh2x6/Dw4FiF/phNl449TnhJnN?=
 =?us-ascii?Q?3riHPev5Z0ZJnVcnQ6aLrhNzb0bx52lSvqlflf+u6W2Bc6BAVchuGdlCNp40?=
 =?us-ascii?Q?XxkxQ+fhWXmMqwkmc+pK8YLwwrUcpnx/PGIQoCD+S9SQu2V91h1Beg9sONqF?=
 =?us-ascii?Q?QVjA3425s2t/WzCMF8GGCXZV3Gr3QayjYjR+cFMLjFMtBmq/MyedDP9ullXe?=
 =?us-ascii?Q?7Rr+1XvILIY87wKlMCKvgQ69RSo5duCB/r0ytCck9BH92Xxk/CErPhuA+eqO?=
 =?us-ascii?Q?AyWzNIHlN+Srcv/8Q+Q8pht0L2DRxpCDwGOvTp8lt5g9AVz/R8IsTectfx+n?=
 =?us-ascii?Q?A55/R/Rpkhl4t6BU0GKAPXiOFUXdBEVG2GxJqRCicjT4HaiaF+5N8PnowI7E?=
 =?us-ascii?Q?ovc7bi4E1erdlDtJ5uIz7LMqm+Am5hAJpRwPPJQo5fSDyEz+b2n2QzmbV3PG?=
 =?us-ascii?Q?di5MBmO5sbRtcX8x+ODEYuRQ17ebd5Xg3OoELVuBazmaS32sxz4WMCh7H9UO?=
 =?us-ascii?Q?Eo+ocinEzs6k9qYSPUcvNqfzwovNE7T34aLPs+ozO2Imhb8kDzBxByy1ELsx?=
 =?us-ascii?Q?8+HxA204yQWhA4sdWQgoQ9IbfURRd2/u7cPLSreOgFEcz4oywU4/ka79L3ML?=
 =?us-ascii?Q?dXso5iVvdhbsCzTuXa0cG9SsqiDUZJwCVyg5LQkiFpONgRKUs5PJ7J5tuJcd?=
 =?us-ascii?Q?bcA35j5thsBB3qM8xsrj1vxghzypd9g4dUbNCVrnBENvQpCJkE5C56T2LHCQ?=
 =?us-ascii?Q?3snekKaWkqiZPl/tpTYZ73qGorq3r7dvViHFgsxsL2absfuPdqF2UFb27aSD?=
 =?us-ascii?Q?/it7vj0HXJz4uMBxLwee0ihG8eV8o25EKkpatXgZgSCj4PPkyaGzn2LSnGnB?=
 =?us-ascii?Q?hg4LLw23YMj6LFULHFga1j/1ki5+WrPXr7cJt/A5zbPTP0lS4vM3QctIqXhq?=
 =?us-ascii?Q?s9eNHYNRgoVrqt2qchzH8JsCLiEZ9e7VomNJ59+I+kyyBaqkAWmdXFSVT2Jy?=
 =?us-ascii?Q?v2DHs3GuhBoNAI5SYfJ7DMDY7Mc0RHEDT550jDa4weh7MCmWyu8OVg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sSGymrt5p1IvL4A99mrMPmMJzGyURQxwBPs5bjiWiLtxACHJUZbFck7NegTv?=
 =?us-ascii?Q?KfHQ1VrlUXR0Y8il/X1fvGiISxQewPRuirkF7K9o/bru9AV/Jz+oOLFkRy85?=
 =?us-ascii?Q?mYxt3qIv/fbN7ooUJrNArY3zLRh1OPa0u83WC2C69yV/DDyyx40qq0gwP8Bd?=
 =?us-ascii?Q?iEElmRQaCLHqrVSgyqjI/Fl8gQA1GOiU7YpGDkvN7hS5UfjANtPOSENosfll?=
 =?us-ascii?Q?8xrhbJ+L9P1mOrLAIOyWvC3mqzlHxiCrAULy6AIh9yMx9a/7+aupHQMdQyB/?=
 =?us-ascii?Q?lJy2XgDQYnaVvfEJH2L3RbFBcFc2VOsHMEW5ZZhJpTffOMwUe8DM1jbDvVTv?=
 =?us-ascii?Q?n8/gnfmVDW8xdOT/kWprHdIxQf80+pKsA0eNvcBc9nxUpAOEqHnn+WOcTkfM?=
 =?us-ascii?Q?vf3Ah0KuxdhRjAobb7tbzv9KiiAVjypItf+nm3Qm63xNj83NK129SrD8t7yN?=
 =?us-ascii?Q?s+47yd21y4pUmo6ZmyoDlWDaD7J0evfPuFIcFCdS1mXYFJRi/km6r/Ikqmvz?=
 =?us-ascii?Q?H1URR9NNSQgM/FDOPAfOD7g3No9gGb9ChIe101y+4Y2QLd5aJIDhEM5P2Gk8?=
 =?us-ascii?Q?4bXUwhID4axLn3KI/bzPn3RgcRvAYryzDM0rKVV+IvNOv/z+M4SO3dFyLbGh?=
 =?us-ascii?Q?j9K6jxkqhNSV+c52eo5aaH4eNGr/loRAF5m1R319DbvdCCX6GInvzCJsgw3A?=
 =?us-ascii?Q?YaEMjDn4Xz+M1UpPLZCxVNNmiFjqvU+Ufsykxu8qZrV8qCMDS9QlFmydPbpj?=
 =?us-ascii?Q?axDwqNi5JtTM9l5qCgs2W2XWgXkAzWde4S9ktSokF2iXgAG6gZJ+IpV8xlXC?=
 =?us-ascii?Q?m7ljCSq5Dm5BQEsGzwhSlYhJ6WqkKc2HOVqMsjbhvR5+g1SGA1Z1+irblXxm?=
 =?us-ascii?Q?Hc+OgpxKCaDuOnDU3MD+f9P1TEGq4Fkp/J71EyTVRlUR0Ojy4YdcLGtolT3s?=
 =?us-ascii?Q?qrsGsBE6ubxtFMnaMzjaPemZ0htpbSupDpcCeoTBgjR4l5QRuf31b0vCdXwO?=
 =?us-ascii?Q?6U4JiaTju9+50lkLNkX9fGlf2PblyXBKahFYmAPc9d9ccbOE6SoTwaDHRyoC?=
 =?us-ascii?Q?3aK0nGODj/5E2KfMxMuflnfajQgAEbgtoyhWbU5UvZhlDdSjTd610YfpzVSB?=
 =?us-ascii?Q?5E/E4Jq9YM8oYOCgDFo7OMhCG76QkA4v9Wi1g71Y5HyJUuHMv08NCkZTMLXk?=
 =?us-ascii?Q?Z6egaAgJ+zCwiS2wN0Qcibt3SLvCNx+VfwhDfWW0AUBlTsaT2toJO3kxm3JU?=
 =?us-ascii?Q?XiuhSteqO/4taUOI/Z8/qqMWxt/MbUte7wfG63Wy9Sa6qoHB46+Rm0+0aq+8?=
 =?us-ascii?Q?FOMwwhHk4ncC844zZSsFypEB0oj0mPjchYzJ+B8UvWhzG7Q6EkO/ncoIufyV?=
 =?us-ascii?Q?0qXuZAD4X1E83YByAmaXM45Z6U7O3EuTtfuc0EmGdn9AP7JoDswE7cn3SHTY?=
 =?us-ascii?Q?nyAVz9m/OON7PJeanscJUrVMNwAvB4YA9bykegmsNYA+1Jt689FnhQrAlLpa?=
 =?us-ascii?Q?X1OCpIlaQN1nVzf+EYyY2XADu4+js1bJDs94HjKLvW7keHzyclygedJ3SsJ+?=
 =?us-ascii?Q?vpj5NW3Tkh6l8iGulYiMlDQSzL4YozMVXA4+6ZqjQtosl2n9J7XVG2vj+u4V?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02677d8-cdfe-449e-05d7-08dde9f191b9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:09.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdbGCtQStQPCO1gedK7nOHWtvQOoVvSB0IZopSO9V+0x8LXaRYdcpPT2v7C+pg2oxgLbZWXaC9rDY034uGZ+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17937

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Return the submodule URLs via implicit_urls function and remove the
manual handling of the submodule urls.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/gitsm.py | 46 +++++-------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5ddc81f86..90fe92f74 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -24,7 +24,6 @@ import tempfile
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
-from   bb.fetch2 import Fetch
=20
 class GitSM(Git):
     def supports(self, ud, d):
@@ -141,9 +140,9 @@ class GitSM(Git):
=20
             urls.append(url)
=20
-        return Fetch(urls, d, cache=3DFalse) if urls else None
+        return urls
=20
-    def call_process_submodules(self, ud, d):
+    def implicit_urls(self, ud, d):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
         # Unpack even when ud.clonedir is not available,
@@ -157,27 +156,6 @@ class GitSM(Git):
         else:
             raise bb.fetch2.FetchError("Submodule source not available.")
=20
-    def need_update(self, ud, d):
-        if Git.need_update(self, ud, d):
-            return True
-
-        need_update =3D False
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            for url in fetch.urls:
-                urldata =3D fetch.ud[url]
-                if urldata.method.need_update(urldata, d):
-                    need_update =3D True
-
-        return need_update
-
-    def download(self, ud, d):
-        Git.download(self, ud, d)
-
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            fetch.download()
-
     def unpack(self, ud, destdir, d):
         fulldestdir =3D self.destdir(ud, destdir, d)
=20
@@ -204,25 +182,11 @@ class GitSM(Git):
                 logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
-        fetch =3D self.process_submodules(ud, fulldestdir, d)
-        if fetch:
-            fetch.unpack(destdir)
-
-        if not ud.bareclone and fetch:
+    def postunpack(self, ud, destdir, d):
+        fulldestdir =3D self.destdir(ud, destdir, d)
+        if not ud.bareclone:
             cmdprefix =3D ""
             # Avoid LFS smudging (replacing the LFS pointers with the actu=
al content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
                 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
             runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dfulldestdir)
-    def clean(self, ud, d):
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            fetch.clean()
-        Git.clean(self, ud, d)
-
-    def implicit_urldata(self, ud, d):
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            return fetch.expanded_urldata()
-
-        return []
--=20
2.39.5


