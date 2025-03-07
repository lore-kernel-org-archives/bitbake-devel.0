Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E0C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 09:43:38 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.136])
 by mx.groups.io with SMTP id smtpd.web10.7629.1741340615886651356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 01:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NqXGzlwJ;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.136, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slSfRxl/e/hm/w6iXfRBdfd6U4Ns7vkWxnY85Y3tf40XtCukfxPQK8CRq0kt/OIHEnxr/AQ+pq6f+yRYRvUobinFeqx19akyQV6k3KUmvAWXIHU5kkFqS8WKdlX3+dAlSQWMrLFroDPdCOsLr99ZSxJ7mNH5lHyWvrbkvc0BCHxxA0qV+age5QnPwG6k8P6mPLwP46Zmwa4IAXtiRoSgSrB4LAyZO4JsEXysZDlUNQHGDP4GqGgYSu1BP3roBgQYz7C47CWz38XzIbDn737A5xF8111fD1/qsnomzNKxYCNO64r674fF81ckIp3p8ICnjREzPWRUUvA2PMiP/Ekm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oILsBLD7F3hGhIc9qZj6R+KE6E5L+cCkkCvcWF9Pfvs=;
 b=g1Ecip5Hko8ftXYkgd8IVnmzpbd32QqwfWZY23UzI5MtBLWy6g3XQXZEHF6OLfS9cVjxdRjQD6F9JoNZ1k8hnKQheOyssDtypXF1rSSDhyBaWGfLrWYyOvSwiu72ixEmPudgvSnbhtzyAGUqYV6C6kxVjJQJvnAx+5JICfF13DvevrFY3uCOkUsELr2o9HZsGxLIeOd7B6yYm+xaBk0CEHCISP2DN8SfA8LsZKgTrImRLjZttQ4hLubvZ8IcAQvOn0lWtu5T1+7wy8iSZ8BkEdgY3//ajYSvmHD9DYv45nZF4Qt4WtDewru8kBoc5Q2vCihjD2Aq++Gbxo3J7FLJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oILsBLD7F3hGhIc9qZj6R+KE6E5L+cCkkCvcWF9Pfvs=;
 b=NqXGzlwJFtzribmnicSz256WrvTbOYPPqatcVV6FZ4CIGvY2NmFwpIHLq7BRkb+MhgOVca2RcbbOZTq6F00sqpYC6GDzhMsNSOdfBm88cCOvDeCz/2mkdgWu0HZoiPG63jdxgVDFu3KFNtWQStnPkmPF1NS3x6OuxN6ZiVWaoiWDcHTWlta5P3ylyU0HxyyxM0q9qOnuCzo76QUKWJSwv2DKAq/VfRwP2FrMbQK6UZHumUXW+K5Us2UGNvU4OA1jWYyHKyzz5S2wARnKXaTcW1mzaEo7VnwswOKj4U0969KIa7hfHLYm0F9GMK3ZTIlsN6OukKiROv7BksgLdu74Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB6511.eurprd08.prod.outlook.com (2603:10a6:102:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 09:43:32 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:43:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 1/2] fetch2: Partial revert decodeurl() to not use the URI class
Date: Fri,  7 Mar 2025 10:43:20 +0100
Message-ID: <20250307094321.8993-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb2cef4-649c-48cd-70eb-08dd5d5c8579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RQ9cFrzUwKGJf/DbQlVvhYQJFGwFuEdbXRvs/PaG2uB6/3f4CDiIkJyg88h2?=
 =?us-ascii?Q?iWwKAYBeGILbiC7hHav9BNqIORkVIzLjSXUr+JHg8lCnM+v6pjqKuxLkLt44?=
 =?us-ascii?Q?aJzczpFN2QzqHuxtDW3wYojwusjKLKL2WITPfYHBDVF0l6fEmiFqz6JH8+xp?=
 =?us-ascii?Q?zURNwE827GEcHllympSJuB9Ql8gBDExp+fuh2JTuEeB2/bu/DjXRQLJZ4f8k?=
 =?us-ascii?Q?bNafh46TR2ti4BzxFQPhBmQp81mwf+ZMD0AOvPJXFgNtbsa1TJ9wmNL8bk3D?=
 =?us-ascii?Q?EWsP2arWZhrhNIwVaC2BXP5zc4W8Ut3/1ytxUfqGx8MqI4qSpiv6CysW7Sh/?=
 =?us-ascii?Q?X4/sXv+dMCmIZUjlPIHc8nML/8LAaiH79EW25QA2jf97X4/oIvXM3/wGtcsD?=
 =?us-ascii?Q?AG17WBMYoDlZawVaWvydT++CQwloO1rHDxEuPcqnsMjEaDJIs1ZLWZBtuRDz?=
 =?us-ascii?Q?4zPeyc/zeAZIpE/zKEcdL7BOHvLZYNqQJudrV2M4t+upG4hyilmgMCb9/LBC?=
 =?us-ascii?Q?EYB922bABhp8IqPkutR3XFVTTyWAIg2A5y7Z5PbewzPasK5YoifVBG1vSadb?=
 =?us-ascii?Q?RlOLYd9EwTmEL0BNhld9myMrnO5W5LZk0A7vABKwcWmponXWYS/4G1L8HCvp?=
 =?us-ascii?Q?S1bq5hgewCJYeu15I00+P9XZ23MLL1kcxRibz6L9PfO2Kuj4H8mpyNagnKKz?=
 =?us-ascii?Q?G/gO70bxgGNZjTlJwrslaIXxGUnP3MhyvHX0YA9dxR69TYH0s/Gy3fnyKwgg?=
 =?us-ascii?Q?clNeCN44RvH04pHrQssWuctmXxTCq3JKtzLAjKDCMbCGDgoUkMobMf18HzNp?=
 =?us-ascii?Q?ut3LlEjZR2S3KI/skfWB8WDFuxOHLM9AC1fvqsLYbfKFWcZk+5I6h9tBLDDK?=
 =?us-ascii?Q?8sYpEkDbP+HCmOabMaKh0dQBWRqG6u2RCnXwQRfDGDy9baztBzsIM2VJY2U+?=
 =?us-ascii?Q?sNh8yrHzb4gSTzE96154g6NVXwfK/d8wuQXyCCba4kDG6fypuhU95ZchZVFO?=
 =?us-ascii?Q?5lFszWnH/nclpuhHy0TMDMvaMg4hte5EsoyzudvISf94M3dx/WMpfvnSbBl4?=
 =?us-ascii?Q?L2S93+WeJ7biMKQD2IwSXmbfrrLRdUGsPFNp1tpZh3Gy8PwGYMdj3bHJ1d3Q?=
 =?us-ascii?Q?i9yFrDupm6LJXqaDu+ltfzQdYv9Gx8XQsSDIZbVnei7ro49Vc5I3J8eQvfPg?=
 =?us-ascii?Q?iOZXbHHQdvnfXSuElq2Sn7IWWYaA4h0kSgePUZ3ghlKyELZj/V/QHVAjLW8T?=
 =?us-ascii?Q?26lkmsoMgpSN7ICT+xCuOl90BvsMMdpSGPqoYflWItCqe1l1t3BFWjjAaDaP?=
 =?us-ascii?Q?UThoIDDFyv5C2ttfrlUChCxtgnzyZxTm9hl7by/bM8C+Z60SH7vCoSLV5664?=
 =?us-ascii?Q?k2aDfTXa1XbatR+XN0jn/Y8Q2biYaYH+DHz/FlCFZqsjp89sDA0/m4IF+ri7?=
 =?us-ascii?Q?hvdkQ91Cj6GIybzGcQ5hKy8Cz/OZv+zs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DjLG39ClyrETkYZ6iCsE3NmCMk66lqiFfJPH5B2k6BKvVUSBTQ/VF/1/JHVU?=
 =?us-ascii?Q?XGvkiT1lnFBIG4BkGrByuOxfm0c04HCeQ4cPxWxPgNClHkvShxeJbJe22mJh?=
 =?us-ascii?Q?Ka5dasQZnTTIbwlAhl3MpMppyeVJe1MpwvAFCeCKqihKziW/z6/ieE+HOP0x?=
 =?us-ascii?Q?lvLAm6ivffkadFEM7HSY37WwsCdxwuWp2h0X5oh1LoHBFZgEiTWEeziDaAh3?=
 =?us-ascii?Q?ZhcADWYOU5gCBl0w8SpWFIIY2HAP8nOiJW9hFG07ga3ZCDcKopY9RcVf7ac1?=
 =?us-ascii?Q?HalEakhJJEeNVXrSVXJCq1S4vDgvDeu3VqwXk+OVx/e+uJwB93x4tCgg3d/j?=
 =?us-ascii?Q?N6zqQw68yTB89PrqqH5mdi58s2gFPfNaGjsCkJEVDVsX1OzzttbvNuISSzEf?=
 =?us-ascii?Q?/SEihOZ4DH/TdFkdZY7kkAM0//1Ge2TuB+Tj6nn51cV5eTOPqyb3DUoWmp/N?=
 =?us-ascii?Q?CB/QAEcRj1caE64GkcArrtpTkKlh8csHJFG16eg8Ea3tQ5+V5ES24xD1ogHH?=
 =?us-ascii?Q?GLnPDb7/4XLqp6XQficbJzoJkWxlxWg5KUKBU1ZY7wla/tvzpL2xExtBY77x?=
 =?us-ascii?Q?vVqqwsqtCqUICYEHBVMcCJ3zjrwANNZAjNoyXy35+t7iijhYTTbiUL0mWC0f?=
 =?us-ascii?Q?tfokvAIKPKD6JUNprvcbXJVSDU2EW5wT+oIhFkA9Gbpfx8LoTpS3C316m2B7?=
 =?us-ascii?Q?Z0cl8GRX1Aer2+3m3I0HdkUd442dto4yVZNaugB4trQqMTUPaIT8cvt4pcz0?=
 =?us-ascii?Q?milu6ttdI819DtY5pku+ScjZrEJ+XsrT/UdCskyFeSPYx9xclCcgCFvv2Alr?=
 =?us-ascii?Q?ugIP94qVs+TB1oTBICEfLmfBKxBGgqAngT65F0K2ZEadINgO002MzJZbA77Y?=
 =?us-ascii?Q?qLqAMh+KSJ9eEO2+tkVvhHMFHnADZ2WI313Fpab0BMnUEX/mdiQmEVINBDn0?=
 =?us-ascii?Q?isPOKETv1GTA9CKPdSbF0pyXRuy1Qx9A658pA7dP8PR0Et/aHhpCMqoQ7zFi?=
 =?us-ascii?Q?16CYpYFdwWmPGl3WasWiE/Ju9eD+WXT+rlMKXnOrCYThaSojTU1CXVhR921e?=
 =?us-ascii?Q?Yfp+sq4av5Edkq1Xy/OXS0go2n9/5HTDwG4jnZcpTjyc+PfPfEbN3K6YiE4H?=
 =?us-ascii?Q?2i3UXPFAZgAChyqcAW+5DZ6C+3fUAFZ9M4y6NHU9ZLJd5kRGz/dpdE/jWrVg?=
 =?us-ascii?Q?AD8B4Qqmc3/ZMrdU8rNRr4EGKrgbpXyQYCo7DKGKrXdpNBJAVTvwOv7DgPCP?=
 =?us-ascii?Q?VM8n9yZf8zwNoFomZSJg1JVxEZmqh0jDEyBASZJVZJDi12JkOt/GQJGwO3AH?=
 =?us-ascii?Q?rhoNnnrITm4oi9djoUqKdh0FVEAJ3Bttw6QLTugoAYgWJy/m0eXXC7u6PoUj?=
 =?us-ascii?Q?aqpym9UWw4RWPrIazh6V75tsZiz0pkmdU08ZdEn152LwCm2AWSUu1bkArL5K?=
 =?us-ascii?Q?/yZUeulThtcAs05d4lwTejMrve8yLk3vaWQwQ0tKFEnwgfAEwXZh+5t0qhEp?=
 =?us-ascii?Q?K2z+3i9+6LsOV/1S4RtozmgU2XTax7ctt8TlaxyNfKQiZQUSFL/LkYCEhWgW?=
 =?us-ascii?Q?4jrokpRU50uAKUnTyTjPNa+ia0uSLri9rltmzwS9aCE1ypqUBAXBbk99t9Si?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb2cef4-649c-48cd-70eb-08dd5d5c8579
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:43:31.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nP4pj5VeXGG0LGjss/bWa58kAPceLCMMbwla8T+BVvkBNG3sEzhWo87Biy8+/Outl9rD1FRTEFXuWDiIeymJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6511
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 09:43:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17398

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

This partial reverts commit a5d569c94700f04b8193c6bccae5af619931b00f
which changes decodeurl() to use the URI class to parse the URL instead
of doing it itself. While reusing code is generally a good idea, using
urllib.parse.urlparse() (which the URI class does) to parse the regular
expression "URLs" that are used in PREMIRRORS and MIRRORS does not work.
A regular expression URL containing https?://... would be silently
ignored, while a URL using a negative lookahead such as
git://(?!internal\.git\.server).*/.* would result in a cryptic error:

  Exception: re.error: missing ), unterminated subpattern at position 0

The problem is that urllib.parse.urlparse() treats the ? as the start of
URL parameters and thus stops parsing whatever part of the URL it was
parsing. Restore the old function and use it in the PREMIRRORS and
MIRRORS code.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/__init__.py | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 93fe012ec..5aa67accc 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -357,6 +357,54 @@ def decodeurl(url):
     path =3D uri.path if uri.path else "/"
     return uri.scheme, uri.hostport, path, uri.username, uri.password, uri=
.params
=20
+def decodemirrorurl(url):
+    """Decodes a mirror URL into the tokens (scheme, network location, pat=
h,
+    user, password, parameters).
+    """
+    m =3D re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location>[=
^;]+)(;(?P<parm>.*))?').match(url)
+    if not m:
+        raise MalformedUrl(url)
+
+    type =3D m.group('type')
+    location =3D m.group('location')
+    if not location:
+        raise MalformedUrl(url)
+    user =3D m.group('user')
+    parm =3D m.group('parm')
+
+    locidx =3D location.find('/')
+    if locidx !=3D -1 and type.lower() !=3D 'file':
+        host =3D location[:locidx]
+        path =3D location[locidx:]
+    elif type.lower() =3D=3D 'file':
+        host =3D ""
+        path =3D location
+        if user:
+            path =3D user + '@' + path
+            user =3D ""
+    else:
+        host =3D location
+        path =3D "/"
+    if user:
+        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
+        if m:
+            user =3D m.group('user')
+            pswd =3D m.group('pswd')
+    else:
+        user =3D ''
+        pswd =3D ''
+
+    p =3D collections.OrderedDict()
+    if parm:
+        for s in parm.split(';'):
+            if s:
+                if not '=3D' in s:
+                    raise MalformedUrl(url, "The URL: '%s' is invalid: par=
ameter %s does not specify a value (missing '=3D')" % (url, s))
+                s1, s2 =3D s.split('=3D', 1)
+                p[s1] =3D s2
+
+    return type, host, urllib.parse.unquote(path), user, pswd, p
+
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
     user, password, parameters).
@@ -391,9 +439,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements=
, d, mirrortarball=3DNone):
     if not ud.url or not uri_find or not uri_replace:
         logger.error("uri_replace: passed an undefined value, not replacin=
g")
         return None
-    uri_decoded =3D list(decodeurl(ud.url))
-    uri_find_decoded =3D list(decodeurl(uri_find))
-    uri_replace_decoded =3D list(decodeurl(uri_replace))
+    uri_decoded =3D list(decodemirrorurl(ud.url))
+    uri_find_decoded =3D list(decodemirrorurl(uri_find))
+    uri_replace_decoded =3D list(decodemirrorurl(uri_replace))
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find=
_decoded, uri_replace_decoded))
     result_decoded =3D ['', '', '', '', '', {}]
     # 0 - type, 1 - host, 2 - path, 3 - user,  4- pswd, 5 - params
--=20
2.39.5


