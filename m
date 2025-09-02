Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77040CA100B
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=VGE/UN4j;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPYaOkww4E8H2gByh8XdFuBSNcAzXL/NOTGIF23MHW8jPGiugPfpGmuAk/5y1tTtOgNhWivR0B7RJY//0WS/+riCe4ete53Rsvmkd0+J+ohSRU3VAIlY5EY+Uv+85ubNRsZsYTpZ5jS0r+WY3Y9WLiQsKd0rUbmKmh8jJOODW/7RP8HqAoVfyxnE/vEhDMQhjIcaEHtgfO2kdYMm756JbvdJ/s+wmQhpmFZbFy2AghKIcmNkPgIPsAc9Reoef8Tu8g2/Ta/ELESY4xhBdDS2nznD02Ov10UOsEgMOeo8Z8kdcLiyQL5ppHguSPp4l9SjZLfGCWGBWU8vD4PAzqtfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNhJlNuntziFIuzpj/rkcazv3h8DaXRaQPq8UKwKwqQ=;
 b=JzYGPxxZEyLgdsQcskQ3lEXfkvq+WP4ctQS4UN+fDIiWlNNFHuZvl6s9fa1QYMry9x7rN8Q6YERwWax2VnDF40niUmPxhsXnyrF/BhlBZJDw7ELuQ3hN3p1wWHiYSbA1YWxhNVdv5scy2ou212+5Xc/IX3ByIeI0cIokZUkrZv2M4KUxdafBUihY8auktg7s7s7jXGkVFpXCq1BFnjUZKzWdwlPjoiOeNIbhltKIcfdf0D0Fs/wF4g6KQ+lttU3JNR/RiyK7eiNLjGD/QGLlf5hZSaDZCruxfYx1BY486Vb99R9Fo6RH++xkeaMUkvZ47dFVCc1ZqavvjLLC69JBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNhJlNuntziFIuzpj/rkcazv3h8DaXRaQPq8UKwKwqQ=;
 b=VGE/UN4jncTVohbke723hIGOwH6WFiF+qci5RPGpUYoc4LMa7tCBSuGi40c3bBTcHXAAA3bUeuFvvAMJ/JG/ZNcGE/3lfT+2PljxDED7nI0F9pOiuSqnKPVt4vVwwsmR1R5/xf+YGj/rjcMFwtd0IR3RLlhkFXYy2gF5n0GvJgmzKQHFTvsJ4/MnbhbupG/zYWPc3H6KlsrqSWh/5IQk7qNqMNoKLgl6vwkKOGktfVDD0EnpvJ40PnJP4o+GVWA/EUr7vDf+JbxB0cqkDJx2g0jozGbmlKI9pJ/35aT0VHTnBM11I7/tnUYs2sdDOcWfkTF+idYhYii5mbQXJLtWdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:08 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:08 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 2/6] fetch2: call functions within loops of Fetch class
Date: Tue,  2 Sep 2025 08:55:03 +0200
Message-ID: <20250902065507.35737-3-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: aba03a68-1868-4fd6-3302-08dde9f190db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lJAhhqnccgjKRwiA/DqswXh8lAQvPfTtvTjnU+sIJsho7Yl+9LkhiwDbMBsC?=
 =?us-ascii?Q?s2ZReSLO07muaZwzcA8SJBCykfyNOHq1F+neYQxks0W7/2pICqzQXhiwgq2O?=
 =?us-ascii?Q?QmjxysQ6zGGeyNybSSUIhtjkZ2hDeZz2bFVEg+T4ru/0reNwPkKzIMu2YFwc?=
 =?us-ascii?Q?sfSMaZT0OHqwtLQUhnpTlVDMcunlVXzV7JFqkMBo4zKeIaibnnSWDSEwPDKs?=
 =?us-ascii?Q?6ggydOFbiUgVhCR3J+yzoXJfbgGo4TByY16Ol7c8oL3bn/QHRnsd21fdi9M+?=
 =?us-ascii?Q?l1bS8Reile1EjE6oUa0upw12KLE9WGkJJmnXXiOEcoRoEgqkjKKRNbba+AOh?=
 =?us-ascii?Q?F9BkEHMxWyb7z+3Z75M3nHhl3VZAWXI3DLKLNgsj8cWDUSIsH/DVdayAi3y2?=
 =?us-ascii?Q?oxYTBHAEOj02CvnM1wV6MILlLCuFQihMwcL3UX4q/5CfBgJkJqS6yTe92gUN?=
 =?us-ascii?Q?VG622W9vxg7Lij+SZsmDh+1Zg1GaZm65QN9uT6PuUapuUjSXNiJkGP9o8oo+?=
 =?us-ascii?Q?h64Ci5eXb2ekCijuBsJLvxbMJWoFB+13i8qsy+qPIUtq2MguZHmhxi19T49G?=
 =?us-ascii?Q?RojHURosv2Tak3YDIkxmZt7xO7ZrQDmYt7y7mBiojHGYYboQW8T3kuXO3Q0m?=
 =?us-ascii?Q?t2pi4duCmf46wnugOA5aMorGIMQxyeWscRdvuGJhCu9cw68JTTQyPE/ZZ1TS?=
 =?us-ascii?Q?YbZq61IWDnuseGVqEN1O/CFXBqjdD8us/Vw73SZONnrBa6WeclxDqJTEVVvQ?=
 =?us-ascii?Q?WQePbnfTdpEJBAKd1Cg+O4Cm4no2gSVWQtPPxJQ2JNAmPpNQgJzbv5VYB6KW?=
 =?us-ascii?Q?l4f3kSv/bi682r/EuxDmNQDzAadwbvy2cCqUtlw3pzKvxUfz2HzutBZu49X4?=
 =?us-ascii?Q?f0b3q1G+En54ZEkIP5ENXAPXjzQK8mIRDYs9hCD/5XaiNBCGUM8ZbPwtcYq7?=
 =?us-ascii?Q?g52HJLmTeiGl4vfUfZlEB39wTJkti4Rk/SvJAi39dmtqvLR0rcYqwEHdwL+p?=
 =?us-ascii?Q?gmvi7EYFp+fMomYXStfEEIWI90nvEwt3+853lbqpqc6oJjO5pNwpSSJ0Vudl?=
 =?us-ascii?Q?F4B7pGNv/V+riWAyEPjdxpkHirot7CPZWs2ml8XaaiNh5WCrSA/Bb7woMN0p?=
 =?us-ascii?Q?0nFF9xf6+MybdwKB9EiKSiSttYrUaM3UKXKXMHe6IqIchmXJ42Ic/RZVn6dM?=
 =?us-ascii?Q?5CgqQyOy5YuowL1Yb/78e5asfmOguK8fq2k4c5CEb4PEotHcEaceNgcUofRR?=
 =?us-ascii?Q?nGA/6cLU5HGlb2N3onlCu3HN2zy5xWrH8NewlmDYfhCKbGgQcsi+1SV4deNr?=
 =?us-ascii?Q?o6oEmmydvIMpjwEG/41Jxk1DYzKtHUb1ul3Gh6L2zBKgBGO1uEptxwDtGSE8?=
 =?us-ascii?Q?UYU8BEi51q99h0cPO1x6WJgIoZqH/rexqb3EixvLgj0xIZAG/jRXMxXkD93N?=
 =?us-ascii?Q?X/+TFmzT2XHuUaR35fevgRkOGB1krrPL7pavNi+uFrtbr85IbIh/gA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VbAqN2cNJLXhQehzE2A/v0yH9asllRg1AG7sfDhSFhMHCUl0qAOupc9psyeb?=
 =?us-ascii?Q?QyxRyFIemySQmsvKI2C1hfSj2FKcPl8n66n3w96fPz8jO2QP11GVexlnQaA3?=
 =?us-ascii?Q?2A5b2Nw1p0HY78JteGPtJvRtaXAJnpMKyz9+qpFYMVQbb64Vv1znrxl/aVUc?=
 =?us-ascii?Q?N39+nX++AKtKX9aQmluP7i9Yr/49HoMnHHt31qK2UaM5Xaf4JUpGiv31YLGI?=
 =?us-ascii?Q?QVwjIHgSnaq16Ie6Gt+RpmbqpPvzZReZHEN5UTzuqCIhhp3Drh4eIzY1Vi2d?=
 =?us-ascii?Q?w2TcFuULBB1pqVBgaytgfgzUcOH3W0pq72/x7isQrO3QVnjqud6FQPPYo5WW?=
 =?us-ascii?Q?/K1w6XJ7ZXN30xq770cJNu58EiW3JmfIKRQUhunAdkTpJd+L7E0XHbi5pdv1?=
 =?us-ascii?Q?uIoRVJBHEp46f1oi2ggQhUzrdbM5oXZkbDpvZxmWu6csvvuTN9tk88CAlsx8?=
 =?us-ascii?Q?P19rPutlbCiM33z+3QHNVF7+M2Tciog6rC1dLOrm6JIdap/IoK6o1JZj54aX?=
 =?us-ascii?Q?akjmCDdht03jD9GtOUaI45ld5AMy2GRK2TGTWprS7oYsXettcTXmHgutrRKD?=
 =?us-ascii?Q?oaf7NgenFH+DL4FaYmIU1afCJvWgjtKe8L2V2em6wQ4EYU73xbnE85jCKY2h?=
 =?us-ascii?Q?jpM1uOzRxAKO9qsb1v3ltrpPjdm4cUb1sL2l3Pv6uinmuSwIf4xS5hO1Pd0H?=
 =?us-ascii?Q?M+QrxbpsvaIVP77A5fhBCX3tJ32ZQxDf+vSLdq0Cfy66ARe3vBhFjdCTInwN?=
 =?us-ascii?Q?DTWaBobtAH/ajqe5GqIk9W/bjh64Ge6nl2Qb/SLtvZOC6gUF5x9Pw5FzCuRu?=
 =?us-ascii?Q?rQdSaq2kgyulolc7zGTVP5s/EDtYTeYPV9Ulf/5slmLhGQpTCEsZOPGDOM1P?=
 =?us-ascii?Q?7vQiEdwuoyjBcp6Py30NdYTriK+Ir0D1bUoJSMPcaYDoDWhT+MCO6cxGljGU?=
 =?us-ascii?Q?U4pLCtaF+C/CqwpFuL1BnimMH+lpD8XTMBRE+lDVsoMTNCo3R0RtawMDLRaQ?=
 =?us-ascii?Q?LIPyQesRPUa7Z9pNCR716GzQO+EA3qwZbQye7Lut9A2CFOW47DGiFc1/ER6N?=
 =?us-ascii?Q?r+CuH+BqiLGpXN3d2Y556AaAAPCNS9Uu0q7cHqwKGDZi35pWkKpsYmPejvvZ?=
 =?us-ascii?Q?3cNXWSzOJ54tsxLz+H4513GcbgLRts5XbJVQQuDO5omc8C27wS0u0Ljjhzfz?=
 =?us-ascii?Q?riLkcXMio95PO20YFPJfgkuThNZiNpXkPnS19fwhj+LgcuKv/qVrHlD7T9Uo?=
 =?us-ascii?Q?rVPRr6lsVEWknX/eEeCvSyPVDiHmxosL03Cf2ZpE8ijAsbvuI7G/iiG8uT6Q?=
 =?us-ascii?Q?yDQxDod5OujVcuSrn0EGl1qnYDAYtxNzQnDS/m1SUNATr71EgQzCaJqyVflR?=
 =?us-ascii?Q?5YRxTLeKsbaRKGqreRDblydf0+reo8K2n+brqei4/CYVoqyY0+n1x3mYaeqM?=
 =?us-ascii?Q?KWyU+tCQTL00aLlonUx4wKCyEfvfUxy91dq1u2e0GgCrBVvXKzim4nhFZeGF?=
 =?us-ascii?Q?zN3g354rkLYdXIbNPy2ojgkXYZt1NoW8Z3/Oo0A5hmgSQIMXstbSgG4GTDko?=
 =?us-ascii?Q?oXLM18lACwlGcdHfwR7pAB23HfokP4SXeYQeCSVHttSDpzFV7VAkhaYBL6cv?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba03a68-1868-4fd6-3302-08dde9f190db
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:08.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmXOo0Zoo2wczmpKe49tCAyUtCRF02NqMPH2M61diSjkgpn5XfoctTidycd20xg7KiGVMrsnD5afZqeBF1vFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17939

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Call functions within the for all URLs loops of the Fetch class to
simplify subsequent changes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index bc9808da1..80f1a0c08 100644
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
@@ -2054,11 +2070,14 @@ class Fetch(object):
             urls =3D self.urls
=20
         urldata =3D []
-        for url in urls:
+        def expand_urldata(url):
             ud =3D self.ud[url]
             urldata.append(ud)
             urldata +=3D ud.method.implicit_urldata(ud, self.d)
=20
+        for url in urls:
+            expand_urldata(url)
+
         return urldata
=20
 class FetchConnectionCache(object):
--=20
2.39.5


