Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E717CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:16 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=MHghlYxC;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJjUGt6DCcMnqAcuYyc1lENrcLLw85EVf0dTgp9eEglK2hnstxeWydVPb7E5zgGGjTJyJu4lvTQ0s5elG7SiHeaFqAujCB3ni6tSnZszH24N+gp2SIyo3hxpcMxhnpdbisGHfibKFxjgrg+rOeVRYROlUdcDoHUpuayJ3yY1TQ1N3Z9W767PVFcrGxNCOGbu+RI+dOwXpCp89j2+wNroHqBfhhalqRtS31+Pozj7KAeduFAKDqrsFZjqU3DPLCS9KrD+frcLN/EEolSKqOskyxQsLbLRBTldnL2GSAUiVrAKnHmzQo4QfyVEu/A0qMxGSeO4sQxPWNLmNNRxnVQTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi9BGBSKl9qQyc3mrCBRxEu5LFf1qGOp6oGJWigkmug=;
 b=rDcGVlu6lOmrB5Hnvr8oOMmmpdoZn9ipdxxGq+U2GY8aF/ck0gkYWAvqWAboeYq6qCJo8hVr74r/DxxKAdlucj2eTCjBCGhQX88cp2K+Bb8qcjgtIp89Ab/+u+gQ6B3zL4P62n8yfdp6COduUes3FtaIas9hD/7DUPMo+ElUbkwlCg/AjfMwFEK/ZVBVtVDvwpqC0SrpSvLaOCAqamfYPKGG1bkl/Nh44O2L3dD7QedJTrBUoOx7IQGLej+RDBs+KaTsOnnJm3RrP0C26pgkBvIJK5mfgfzmi9bxvD+VkNw+oDVvhVkIhe44nyfMvP0eUzibPoTIP4mQ0vxboDz6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi9BGBSKl9qQyc3mrCBRxEu5LFf1qGOp6oGJWigkmug=;
 b=MHghlYxCovSn0uuW7TRwY5uhN+00WNIfi3P3y5QGhEWcu7dF5lJErT7t23TSw5B3ixeScJteHCVOt72lDY3yy/sejKBKviZBFXH5S1afnoqC8t/xHgyZiEuAhMXZ/Usqy3eipnCJF7jMqK1TGPTqFmijoeHZhj+ajXzQlgyH6LU+n8UAkLEP755CTaiMZkfKxxZKM8zHzjeYKNjuj+3e1BTjqw5xEtgwg6mkeTVmey1dGGV4tV4FnuI1/3tvz5uoMQg57SjaWljTpBSWHBBEXIPylO5ukt/Z2Y5zqILjzYXbz51OOJ6I9mrPpb64IXDSGIkOlxRx6b5/h3xRXwwnYg==
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
Subject: [RFC PATCH 1/6] fetch2: rename u to url in Fetch class
Date: Tue,  2 Sep 2025 08:55:02 +0200
Message-ID: <20250902065507.35737-2-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4e8777e-180c-4a1b-379c-08dde9f19098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PqLB67jIMBHdyYuTC9eEcqy12J81O68MGxRrFqNUuoUxIhiUXbNw/sfubr//?=
 =?us-ascii?Q?zaNW20r1bG8t/AqlhG+rPdHbTTqTMxhIwPBxDIdhVWPvMryZNFQFHma8GIVP?=
 =?us-ascii?Q?wYWDv2sSmLmlfV8hzGG12b9gw8MGul8UsF9B3REMwWTrUoSs3l17qSlTyy8+?=
 =?us-ascii?Q?/khH+uyvThq19vyE8xHILXLhS83rliTmIGFYHzAOEXgfjYdP3DC0aEEJ3Ifu?=
 =?us-ascii?Q?J6uFNmomrY4mK5kQXlHAnQksH5xR613Sct2RNVHYuIgYfEOxlPAwaRW62l/+?=
 =?us-ascii?Q?qgekFbNj3eo07L8VwgBwz5vUWx6wXYoBuvkGjkeVUCjEaomgvNznmRWmS+3B?=
 =?us-ascii?Q?oyWPUZ3DETYvs4Tfgxmz4EF9DenJcNSavOgx1NkmdjU5bDOt9PDoRBTgETy3?=
 =?us-ascii?Q?whJYNmOaXg7+ssGd6ca+03Qinyb3jR7tZU5rTRmhu7Da0WQ4lXYAlMGCSvw1?=
 =?us-ascii?Q?mTfWosb24E/lxreOsnA/cVRFoAprEpl2tkWXYl0Xlkx5aXwU9p+sLCwEJs2S?=
 =?us-ascii?Q?jguhCeji8YFQM2sNqSzuoKkkK3h7JV+XFjLUcgzYm73dXcUQlsxtqjq5TWRH?=
 =?us-ascii?Q?KRjphEhe/JkIf7fwk6TcuqJ9wGCUmtQXtYPhySS87Bhsa/71FWhQEFwgWiRT?=
 =?us-ascii?Q?Zgd0k7ya+9UjeVkoeWeKzNwQKGOYqqGwL0gdi0+HkSAGf5bCmi4+fez2RMOF?=
 =?us-ascii?Q?iZ41E1NCCdIcogMzApCjC7c91IJGbLL39QJXCW5+Xkv47jl09aUHYwyqnhSQ?=
 =?us-ascii?Q?9jcpPFNgL1I6Fr2huJdeCnQt2Et4U+Dp1kEODtHDPT/luaptp2o57C9D8Myv?=
 =?us-ascii?Q?aIMMFvKNWqWeNqc0C2HH7ghk/k3l/IIAO0azPy6js1ul2L+Z4wnKXXgk+2kW?=
 =?us-ascii?Q?YXaUlsEch9KZl2IVTzizQrhQEw2JEmtBAGxK/gSve9Nw3B7D4wzX71vsAj1F?=
 =?us-ascii?Q?K0Lu5RhY2yulS2JFYPGz2SPhUJ6TU/N6FCvIFPFWBpOxmfi4XEAmT7fYYHK8?=
 =?us-ascii?Q?Mo7AVpGZ3jENu6YpsrhX/OHW2Zbj4+7BVqPixUQ1hfzJvmdBXmHN/vBQozpW?=
 =?us-ascii?Q?o3trbVL5oLdUuWSVoGAkecHeHcJ8+ji/U8vbqbtJaWPBj5A7FNZ43ESJvwnm?=
 =?us-ascii?Q?unEUicHX16GvKm4CUlv4mBdJFFGw/CAhfeeB4gVkPX/Mj9cdvS6gNy+qrx/d?=
 =?us-ascii?Q?UWnfGJgCmzA691JquRULiUQrhqcJJMiTsMrbLPuH5UTOVsnTVlL96q8qrxH1?=
 =?us-ascii?Q?cnKIVUJevF5IqBp+OL+eIqMw7bsWLmlz+UJyyFW0rWU4lk+/q0DumNjSmRZk?=
 =?us-ascii?Q?UwQDJbeYrne3yFL4634s6Gz4IYEaMwwAnqES2brUqVf11NhR3/C8K58jViCX?=
 =?us-ascii?Q?bLSbRxaeKKqhXRpUX0XHoQq2JBeY3McbP0wOMNUF5xUXdZtF7pUKPAzE+0N1?=
 =?us-ascii?Q?aFvgNG9P5BTS9mnw2OZ5sQ4PWH02mIjFlGFz0S4LD5bJ86WmrUy1wA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Yfcos0+Ip41yW5uV0uykzI+MzZU/lz6t1pj7WzmW0JmYnxOMwn5w5Nl+s4ss?=
 =?us-ascii?Q?PKZ25tuNNplu9sjxtjyx4QInc/pXR+FFq1UQyBR4jsZwcPOAtSOkgwVk5rTh?=
 =?us-ascii?Q?lpNPP7KS5VWrdyrVGruAieOuDEbDRUNcwvFopjHBLPk84b0eeizt2jcpQMNn?=
 =?us-ascii?Q?w4fWDTijnlwFJWJxvZvAsBoYVXSd9EKzpIJcCaBwWS2BYtLNXFuRy8tdXBaW?=
 =?us-ascii?Q?b648N2vDo+cqcwb2ZYMnvnJv/NxNYajttVDtOQ156DA5vuo6wr6pUbD2xnQC?=
 =?us-ascii?Q?Tyua7ZbalGGo+Fkny5XQ/OOzCS0CfHz9JsqnurG7Oe4c7JrZONPqsvNUF81L?=
 =?us-ascii?Q?xN+HVt1S1BAQPxRID+C4CXukIlNNCKDAmDHtAJK58/GcYDkfa/TrIlJrtk0+?=
 =?us-ascii?Q?9U/ddIIN5IwS4UF9mx80OOvFSYO2BV/LYauWZnYuCfUfl+KnsQ29jMkZo1Mt?=
 =?us-ascii?Q?+3PN8oLU1Mt8l5d1mB/mEDCf/CX8YSlPOqDFrvhirYeO6YvN/vofa5PVo+qB?=
 =?us-ascii?Q?sYJbLRM3vIysBCVMcol5MmwH/dk6ZUHDatPnVRY19TxpRHFKKsQ40THhw48f?=
 =?us-ascii?Q?HCS+VJsAdnKE9DXhaiTxoiXovNo51KjUlEpemGs+TUS/DRxM8mIUtzkFoMwt?=
 =?us-ascii?Q?j8/s/aqD0taz9SdclGHKMHNKIbVOmWCKLj69hTNFwDrl2SENMlv/m0dMQrAo?=
 =?us-ascii?Q?Z7tzql1xSWxFTpl1uDQ16nQZMWkWtGHyIqv6dJdmQZFkHOF1RDdyRP667UPy?=
 =?us-ascii?Q?BX0d6fr0Ag0F/H8ZEaBv93uerBfMzhIgH7mPtu1RfhjGrifoE9C/1wzzfIyr?=
 =?us-ascii?Q?3HJyUlJLMHUxbVnC47P1A28lzaBC4ItXRugfPTUGCD0Kobwe5cb3EFGM5EOo?=
 =?us-ascii?Q?U9icv9i6fsOEX/6bwkfhW1uTSI64kJu7AXEIgqhwkjlnLi6GdroC8cbavvJK?=
 =?us-ascii?Q?Co1VCnnMszouui2jFepGlN+I0znOkJ/yivj5a1Wz/7W7EZ+tXAEcvZIraArv?=
 =?us-ascii?Q?rHlBGXsCmCQPX2CJfxcZXbGGeLi2h5jce4LdL1CXHMmCeIJFppD5gDIxxBYO?=
 =?us-ascii?Q?029edK2dcnjkVuixHTu7EDEG7kpGp38sKQ3jWRM9cRnrXjSqFm2Luefwf/3g?=
 =?us-ascii?Q?wWy14noEai9lV7DFlAwGM5UBBMZlR2qk3ZlUxoFZ6JpDlyqvUs9V+B/Y5rs1?=
 =?us-ascii?Q?sy3Dflbm4AiU7vdUoI+OKKVVQNCBbPi5tHG3m4a2LOCnsj1FxxoIt0BjVGrD?=
 =?us-ascii?Q?XFxWQ504Nmzt9M2xnslfVfurOqvnX99iuNxsL9QHkPOi19HR4xvmdSDqm5ix?=
 =?us-ascii?Q?ZVTItJTEu7vLyA09CxUrFR/Yz7Iqcp11a1E9pACHl+dupIHgszVj8/4py9eU?=
 =?us-ascii?Q?3u6aTFv4tVTjMmx+Bl0I9DlIBw7JEu/FgHqrzvmMoNRg9Dm7OJ0GMRvc9Ej5?=
 =?us-ascii?Q?TZTmrxPuQ0zkwwvNBP1mflV8AHmIm34Y36RHNGQtmNa1zdO5MeOVdYdb/LHH?=
 =?us-ascii?Q?3Vpbm8B9C86eVjz7871ffawJl9ersp2h9/YsDykSbvCDQnCNoEPflcD4ArGt?=
 =?us-ascii?Q?50fNH9syOk4wwp5MwHjzoPnrRtY0+OYEbSWA61HCaUoet4FihRp5W5X8riMg?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e8777e-180c-4a1b-379c-08dde9f19098
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:08.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzBXVCAN7AMO8AkL/EtroPNWDVW9+G/iPSgBOPO1jLJkHAFx2LbHaIvD3nO1oprjm66zPrU21gNAeaRD/jPhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17935

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Rename the varialbe u to url in the Fetch class to clarify its meaning.
Avoid using short variable names over long ranges and simplify
subsequent changes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index de301543a..bc9808da1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1841,8 +1841,8 @@ class Fetch(object):
         """
         local =3D []
=20
-        for u in self.urls:
-            ud =3D self.ud[u]
+        for url in self.urls:
+            ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             local.append(ud.localpath)
=20
@@ -1859,8 +1859,8 @@ class Fetch(object):
         premirroronly =3D bb.utils.to_boolean(self.d.getVar("BB_FETCH_PREM=
IRRORONLY"))
=20
         checksum_missing_messages =3D []
-        for u in urls:
-            ud =3D self.ud[u]
+        for url in urls:
+            ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             m =3D ud.method
             done =3D False
@@ -1882,7 +1882,7 @@ class Fetch(object):
                             # contents mismatch the fetcher can still try =
upstream and mirrors
                             m.update_donestamp(ud, self.d)
                         except ChecksumError as e:
-                            logger.warning("Checksum failure encountered w=
ith premirror download of %s - will attempt other sources." % u)
+                            logger.warning("Checksum failure encountered w=
ith premirror download of %s - will attempt other sources." % url)
                             logger.debug(str(e))
                             done =3D False
=20
@@ -1914,14 +1914,14 @@ class Fetch(object):
=20
                     except BBFetchException as e:
                         if isinstance(e, ChecksumError):
-                            logger.warning("Checksum failure encountered w=
ith download of %s - will attempt other sources if available" % u)
+                            logger.warning("Checksum failure encountered w=
ith download of %s - will attempt other sources if available" % url)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
                                 rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
-                            logger.warning('Failed to fetch URL %s, attemp=
ting MIRRORS if available' % u)
+                            logger.warning('Failed to fetch URL %s, attemp=
ting MIRRORS if available' % url)
                             logger.debug(str(e))
                         firsterr =3D e
                         # Remove any incomplete fetch
@@ -1934,13 +1934,13 @@ class Fetch(object):
                 if not done or not m.done(ud, d):
                     if firsterr:
                         logger.error(str(firsterr))
-                    raise FetchError("Unable to fetch URL from any source.=
", u)
+                    raise FetchError("Unable to fetch URL from any source.=
", url)
=20
                 m.update_donestamp(ud, d)
=20
             except IOError as e:
                 if e.errno in [errno.ESTALE]:
-                    logger.error("Stale Error Observed %s." % u)
+                    logger.error("Stale Error Observed %s." % url)
                     raise ChecksumError("Stale Error Detected")
=20
             except BBFetchException as e:
@@ -1949,7 +1949,7 @@ class Fetch(object):
                     checksum_missing_messages.append(message)
                     continue
                 elif isinstance(e, ChecksumError):
-                    logger.error("Checksum failure fetching %s" % u)
+                    logger.error("Checksum failure fetching %s" % url)
                 raise
=20
             finally:
@@ -1971,24 +1971,24 @@ class Fetch(object):
         if not urls:
             urls =3D self.urls
=20
-        for u in urls:
-            ud =3D self.ud[u]
+        for url in urls:
+            ud =3D self.ud[url]
             ud.setup_localpath(self.d)
             m =3D ud.method
-            logger.debug("Testing URL %s", u)
-            # First try checking uri, u, from PREMIRRORS
+            logger.debug("Testing URL %s", url)
+            # First try checking uri, url, from PREMIRRORS
             mirrors =3D mirror_from_string(self.d.getVar('PREMIRRORS'))
             ret =3D m.try_mirrors(self, ud, self.d, mirrors, True)
             if not ret:
-                # Next try checking from the original uri, u
+                # Next try checking from the original uri, url
                 ret =3D m.checkstatus(self, ud, self.d)
                 if not ret:
-                    # Finally, try checking uri, u, from MIRRORS
+                    # Finally, try checking uri, url, from MIRRORS
                     mirrors =3D mirror_from_string(self.d.getVar('MIRRORS'=
))
                     ret =3D m.try_mirrors(self, ud, self.d, mirrors, True)
=20
             if not ret:
-                raise FetchError("URL doesn't work", u)
+                raise FetchError("URL doesn't work", url)
=20
     def unpack(self, root, urls=3DNone):
         """
@@ -2000,16 +2000,16 @@ class Fetch(object):
=20
         unpack_tracer.start(root, self.ud, self.d)
=20
-        for u in urls:
-            ud =3D self.ud[u]
+        for url in urls:
+            ud =3D self.ud[url]
             ud.setup_localpath(self.d)
=20
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
=20
-            unpack_tracer.start_url(u)
+            unpack_tracer.start_url(url)
             ud.method.unpack(ud, root, self.d)
-            unpack_tracer.finish_url(u)
+            unpack_tracer.finish_url(url)
=20
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
--=20
2.39.5


