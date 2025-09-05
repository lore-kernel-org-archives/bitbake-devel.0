Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8BCA101C
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.127])
 by mx.groups.io with SMTP id smtpd.web10.15209.1757054681032438910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=t4drvTaQ;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv4aos1mZhOw+qP+uM6OooaCetZ1hE89jNoPJ0TJZugs1+HaUQhtRvrCOIe1LFWRLh0991B5HLFBNFw2BuaKG+nG660olcgI+1JZvx5QjjEeNWhIp6UBOBY7lU4JurmkHoIq7guPf7YrKwdTOrdak915JLur12mpuvOn6wDnkz+qcJI7n/c3oxNJujBDh5J/JFWN/CX/X2FdEAmD3xSw+YrQLFJWzIVfDMLbcwDWJL76f8Jm2KzTiL7Sktv41k3SZZqQ+jB56KNR+i3MX1awf0etTS9HNZxkFWfiYREbVx4Pxb/sI76Rupy6MTPzCHYomIRpWTGcQcMCQPBAWXVd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vbNY4nNhco85/WzZaaoorMppU41en3nvEJEfqFy8WI=;
 b=nwVi1NuEMGkX5OrYs5WBydwvwNN8NXRY/kWPxK0sALRG0e8eHm/d6BnGFPxyaOFIWQT31Utc4FeCOPDDe+m3cFoAyXssWZ/DpMJJGW45MhKnips29pkxOsYzqNVGx1qLUD9ieTtFJmqquwgKt+p1fcx16xcdHROlZDp76CeZf6FBMnC3MEKg7w9bCV3vLcvLDL37zBdkf/BR6EBo8sV+SsDw44OoEFIAxa9AuaDXEbFs1Da8nuXyOq/0grPHGDy8lzwS5MjtzGKcH1ucw9GebPPhOOt9NNfQEYgIpAqdZD+B/H7yWeooEmAgTW2XLQVQY4sieXK8U7UbFSTOkdU+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vbNY4nNhco85/WzZaaoorMppU41en3nvEJEfqFy8WI=;
 b=t4drvTaQNYHb3EHrdxy79og4ZSxjmuOy7bzh2UKcneDaPi7u0BFeLhNG7EuzmakgMvD+KL2Ac+iyFB0gfg8oVXojiQ2aEz54EG7LIcVHbFql7bvOlw9o8pURd8PcAPOmn1TPyu0Xr+HW2tkUzHlLuFhRez+zinYnvBc1XoLwCFYg7JyIa1Ke4TsZ9Zio9EESOCvP/d4ZpxgtpwDUtbwAsycybdwWXYtC95fhUlmF2SeJycN5eUF2IKYQAn6aF1UFSDqYvhO1fKBQyEWrUmelWTNWn6OsaatdfD2wDvkNooC9P+zzFOkSOwOeZgZv7bak8twVndSY9iB/uDJ0Hevr7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:38 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:38 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 4/7] fetch2: call functions within loops of Fetch class
Date: Fri,  5 Sep 2025 08:44:16 +0200
Message-ID: <20250905064419.2589111-5-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: d952952f-3629-48c8-9d98-08ddec47ae54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?56acAshlVuADjqUUth82ZaJ1o0NXsH7P1So3Banli0llYyGMKJMmvRsS1eZw?=
 =?us-ascii?Q?i/kCKQ4GlpLYpvxfov8Aw/LRAEM6MjcPIW2z99nQtH11JACGPgn7vnOi7DXU?=
 =?us-ascii?Q?nbd/QFVjs700YTSYyJ34mH1+FEwbS1rYPsu5wdYVZItR9jm2I0MSY/bvgLtq?=
 =?us-ascii?Q?xHuuunIzNX5gmskkjdohEXfGHDi6xcQOuRR2e6FIM2a54Bce/mJEtWanAAH8?=
 =?us-ascii?Q?yLO8YBQLmlakXx/AbNPy7xiwRQ+gODaaFGd+JgSq0HYQuDq8s1fpiq7JuvAU?=
 =?us-ascii?Q?+VY2SFn6Rcru0UUNNmpDV+F3Szqllmb7Cmwrco93EWiF8oWWtRIeM+jbnWux?=
 =?us-ascii?Q?m456vrVbpMdSbHQEIggZiznyw61P7SjqcmEJa0fwWR+b6nZd+THCmJWLTPlC?=
 =?us-ascii?Q?e8BpAmIhdlhLkaD5z+P8p19T6S6Uct0bYX5poJx6UXJVJVShbvdTlbBsbXu1?=
 =?us-ascii?Q?1hlvIadrZRaNFbE3KOoeSq96tL2V1WKkMoj9yURALuMAviXXywrMpaBcJKv2?=
 =?us-ascii?Q?xKyRexxEjoBppclE1en9X8eZ5qeFc5XBTrrMN7N0e63tLqAK8dohr2Qo/hYU?=
 =?us-ascii?Q?0LBAJyF+i7wkRBNGyFskMWECimrX/mCxt7QIHZ7NjvAq5lmqJ3gk4h4dD/rA?=
 =?us-ascii?Q?0QlPb8CWRWG3YhIdksXJJ9ve1dEFrmpD8lzIIRXcld1S4QWpnISbpwkSXCdn?=
 =?us-ascii?Q?VRx6UZEKwgVNzxkwidNBaxcI2fK4p3H4LgKz0x98gFuqfeWeSkX54WVvf5eY?=
 =?us-ascii?Q?NSvUQAN9ID5BPxqjPhQZOp2ZS3OuNh+nUw3MFqTFPsd/BrLWi1pXz6VZPygE?=
 =?us-ascii?Q?yJ3wgDAncGt3/Cbz6wqfS4h5yUkGc+3TvibzbBJ4NVb1fQS+0uZShx2AfsXM?=
 =?us-ascii?Q?aFSBlf9mLw6Oehee9vb3fhMYEvjZ/52jTRpKFgYReft6ew8JU4wHEactwwvD?=
 =?us-ascii?Q?KE1n21MlcsBK69Wh3riuRajuYLO5JGUqXuikV8gVfTMqhC1dzvihlHvpSpqv?=
 =?us-ascii?Q?IFJrVy0ZhdBV+8TAK304E9gdmQeW8JtGwHQz6zM67ZQB2COfilvlwITmyGl1?=
 =?us-ascii?Q?7MUtpR5MidsBVM7t9h2TmO1pdLi0inaehq2iiuth26ubJzkZXZfD1A2WdAZ1?=
 =?us-ascii?Q?xKVGkvorzw9X8DBW+GUO7uPyt/U2y8vM0gJOdv2GhheYFwIRlFm5Wa2wDgGo?=
 =?us-ascii?Q?dliXKlsGsJ0EzVFvsZCGLEiCOQeR92bsbnzWD0Cy+IiSqr10RDnMlu+EnDAW?=
 =?us-ascii?Q?4VD6U39aozOsdCqaM4FFF7XW/SBbuLk1h45j6eRF96iO7Xp5o+97XZ7oJzww?=
 =?us-ascii?Q?uoavW7kt+uTcH/GaFNAo2Cuqp/3mfyt1BkUJYIqb3b6njoN3dZG9garis+Dl?=
 =?us-ascii?Q?aLKpQdAokipnAoZgBLkASSfqzd85g8zEcHrFQIbf0FvFsisCnWhQdQc5U68X?=
 =?us-ascii?Q?6mf6kXrJpTxD28RGvdjFFfFEu6ypK1g4jgY8xz2CNgPvt4AW2pEU2Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0K9WNmiZbDx/yEg1rUYVL+8taXU7GJRH2zffSm7kyKnEqoivU81xRg7Lu5iI?=
 =?us-ascii?Q?w4lhjHtqL5iYlqQolHNSUtVphNnQJLjx08nORbFpsbTKnkD9Igus1xQcXCqd?=
 =?us-ascii?Q?p2IfqGZY0iNpW0OekeHTdouBEwtEpD43Ab46CeblsGRYBtONKEJ2KWvJ9oF7?=
 =?us-ascii?Q?0pdJ0JQaW6O9rVcRFiGG6m+m4r+EAg8ukH1w8/Vs+2HjC8RriOv/IRMFArKc?=
 =?us-ascii?Q?x+9bTNjFoVUnWAj9eElLFcSdBjXUO4r3HvVfjei7mG7Q+zbeOPgoXK8kRYtH?=
 =?us-ascii?Q?dRDdEvKpdwptLjFmALPpBFEpWiec51xDWBqPbo5JOBVVBqp0L64BZsJtXhSt?=
 =?us-ascii?Q?5thBgu5NF2ITyL085E2PqC5YLVyv1+1NtW73iJvIFh/mttpV6FtdGuJKa742?=
 =?us-ascii?Q?mJvQbbXqITXxgk5O0BhaKBFZCyr1PJ2q/1TcY4bT2urylQrqgnDNwQ4nNz8f?=
 =?us-ascii?Q?2eYNXqXQK74KVqOyl7lt+a8N+b5SRD6N9RLYT64wxK7CNNHzOJSDyVpKp6Bk?=
 =?us-ascii?Q?ECIVNFmwVXIJCo6wWUtFo6O5phoyZ5kFTfz5ZvwTPX9C1vcmNDNVzIGxZJJB?=
 =?us-ascii?Q?UJjvJyEZmqqg13urqSuesVWl34+tukAXHJXGKKFwo0KJrmYgOQjsEIAj/0ev?=
 =?us-ascii?Q?Yyoi5knglJWF0z0SOlK4QY5s1jUNl+eEfvcCXnQNAkfMXuUo3qjRsCR22Qnx?=
 =?us-ascii?Q?xT/xrVXoFNuGH/30EKjEyZVEoV0eD2hMLjrh0x62x2cYcD9IKTjvxk+nS/28?=
 =?us-ascii?Q?GoIhiZ3cLMMRPTgNQU/sb0qBprVOpKVWJNzkkv3ICAFI0ujuEaOSynL7ekSp?=
 =?us-ascii?Q?glC30H55HE4awEAISnmDLSf+34oQrcgD9rMuYP8NupeRDK5tqSJbkYr14bRM?=
 =?us-ascii?Q?7ouBg/0/ZSGoGbmSzQOLg0D0LDwOMOXZ+3zNowKTPIxhFrQKC9PpBLGCRrkW?=
 =?us-ascii?Q?GWiG/9GQjj6x+WHTCofk5XFu3Qrb69iHOFr8QqU85sga9zC8SpVTIuugBPTV?=
 =?us-ascii?Q?DSq1mPXCZtZf0XfXgGG7Hj8fFdkeyQ4eyAWyDmWq64pjBDgSLuWrsXbvrUcx?=
 =?us-ascii?Q?k3szOZCKGw8PLkvlgKyb6GbaLzh8Md+Iajgd4/b5vcVoCP6X3vQYkRqAN07d?=
 =?us-ascii?Q?H06kUYSlW3nbEegXx4EbwOWOx5HiShjDAIT/PicbVf33ansGLOypxah2djUv?=
 =?us-ascii?Q?3ej4Zj00aByhcm6cOQlFxmXYaHnPSsMoH2mUA3+ZcP6teu/4wJM/oLDzxM3K?=
 =?us-ascii?Q?JfYEPaB3XdtJQ+ORlVUPXJdhcjOU44AMpflOIuD14rSmRoKQimVQi1JsCNJ6?=
 =?us-ascii?Q?RKke1P83nQXtiX3ojnue0/aUu550oLaYgCxk6lVPD6WUN5lJzP4KFqyaxJh6?=
 =?us-ascii?Q?bBbplnUoJIYGHn+TOaz4fLIebiIrjEoPCz5pu/tMUUrj3EHpcOXYJNR/2OvY?=
 =?us-ascii?Q?EzWcIFePln1O6phq5XCJuip7bLQqVrXmhVOUbO+rfUGT62fLTL94iLGCD6eb?=
 =?us-ascii?Q?v2Vfs1/oRPxjIzt+/lUL2kTpQKxZrlprcYIrRErWyJD6ilPgfZ9Dy3LNSW7w?=
 =?us-ascii?Q?MAVi6H9YhkP3ui0CpA+E2sCrQvVpOpoac67mF5bNVJa2THVmW1dO+sO97dgo?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d952952f-3629-48c8-9d98-08ddec47ae54
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:36.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIPTgl0SY6VPU0jy4W/1yIEfJpKuepy962q0LInRy/Fj6+xk5KbnnaRSjwVxiwwsYONVL7G7VXfYrBQLK9tt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17977

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Call functions within the for all URLs loops of the Fetch class to
simplify subsequent changes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Fix UnboundLocalError of urldata in expand_urldata function

 lib/bb/fetch2/__init__.py | 43 ++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bc9808da1..3ff08f817 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1841,11 +1841,14 @@ class Fetch(object):
         """
         local =3D []
=20
-        for url in self.urls:
+        def localpath(url):
             ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             local.append(ud.localpath)
=20
+        for url in self.urls:
+            localpath(url)
+
         return local
=20
     def download(self, urls=3DNone):
@@ -1859,7 +1862,7 @@ class Fetch(object):
         premirroronly =3D bb.utils.to_boolean(self.d.getVar("BB_FETCH_PREM=
IRRORONLY"))
=20
         checksum_missing_messages =3D []
-        for url in urls:
+        def download(url):
             ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             m =3D ud.method
@@ -1947,14 +1950,18 @@ class Fetch(object):
                 if isinstance(e, NoChecksumError):
                     (message, _) =3D e.args
                     checksum_missing_messages.append(message)
-                    continue
-                elif isinstance(e, ChecksumError):
-                    logger.error("Checksum failure fetching %s" % url)
-                raise
+                else:
+                    if isinstance(e, ChecksumError):
+                        logger.error("Checksum failure fetching %s" % url)
+                    raise
=20
             finally:
                 if ud.lockfile:
                     bb.utils.unlockfile(lf)
+
+        for url in urls:
+            download(url)
+
         if checksum_missing_messages:
             logger.error("Missing SRC_URI checksum, please add those to th=
e recipe: \n%s", "\n".join(checksum_missing_messages))
             raise BBFetchException("There was some missing checksums in th=
e recipe")
@@ -1971,7 +1978,7 @@ class Fetch(object):
         if not urls:
             urls =3D self.urls
=20
-        for url in urls:
+        def checkstatus(url):
             ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             m =3D ud.method
@@ -1990,6 +1997,9 @@ class Fetch(object):
             if not ret:
                 raise FetchError("URL doesn't work", url)
=20
+        for url in urls:
+            checkstatus(url)
+
     def unpack(self, root, urls=3DNone):
         """
         Unpack urls to root
@@ -2000,7 +2010,7 @@ class Fetch(object):
=20
         unpack_tracer.start(root, self.ud, self.d)
=20
-        for url in urls:
+        def unpack(url):
             ud =3D self.ud[url]
             ud.setup_localpath(self.d)
=20
@@ -2014,6 +2024,9 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+        for url in urls:
+            unpack(url)
+
         unpack_tracer.complete()
=20
     def clean(self, urls=3DNone):
@@ -2024,14 +2037,14 @@ class Fetch(object):
         if not urls:
             urls =3D self.urls
=20
-        for url in urls:
+        def clean(url):
             if url not in self.ud:
                 self.ud[url] =3D FetchData(url, self.d)
             ud =3D self.ud[url]
             ud.setup_localpath(self.d)
=20
             if not ud.localfile and ud.localpath is None:
-                continue
+                return
=20
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
@@ -2043,6 +2056,9 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+        for url in urls:
+            clean(url)
+
     def expanded_urldata(self, urls=3DNone):
         """
         Get an expanded list of FetchData objects covering both the given
@@ -2054,10 +2070,13 @@ class Fetch(object):
             urls =3D self.urls
=20
         urldata =3D []
-        for url in urls:
+        def expand_urldata(url):
             ud =3D self.ud[url]
             urldata.append(ud)
-            urldata +=3D ud.method.implicit_urldata(ud, self.d)
+            urldata.extend(ud.method.implicit_urldata(ud, self.d))
+
+        for url in urls:
+            expand_urldata(url)
=20
         return urldata
=20
--=20
2.39.5


