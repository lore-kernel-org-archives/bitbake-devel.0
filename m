Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF2E77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 15:15:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.98])
 by mx.groups.io with SMTP id smtpd.web11.22924.1736262932271212229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 07:15:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ZrgYjNme;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.98, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1Jfv1TOywpsVXd6vxp0lPLnETCuXPWuuw8kmGsu7P7u4QZ/Db8ZFF70NG7vke6st4ZmuXUez4HuuIecV6MItIb9OHpSbcDzsUwjn53pqyw8QPASjiXxHgbMrRwjUDO7oFvv7VbQPfHiPmDhPCSBVa09EREsw9YzeIYRIIiFDedAK/w1xJDtokzwVQYoj6xOEqzAeP9MoeQDpZsPZKi/lbvIaiBihIX7eFE3MSgNzPD9/CLw8BJ2qBZ1xG8+nPkdfjyZxZ8K4L3Q+A5IdV0CRwRFxWjkFqmHJ0KlQii4XWskASXrzs9Vs3/SPJaQ/UvBOl9+1+tdGoeKqGYSrt4fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pbj55CPFe25xB3fiBrLj9pEp8pJo74Je7GJhUMbgW4=;
 b=stKhdx5n76HNC6t1DR6+F05SH56jbTBB+lfb0ObZTFHBNDMMG39VNhBgWPceyQDJcZhBYmWbD85c/P+gmLymcTCwI8EQ6IWJ78l0D4xoW/STsGTeq6SLJegJ8qBJvGFXnw0XwWVeMALCbPxE2TFgDzczDGbP0feqbWrRhaC5xqZzuINPrcfXGjpVIp8YH3PYmqHq3scWXYb+QShh8L4lCxUDQGQdOHw0FjlbdR4EpaGcP2gZCCYNZ8AME6+WHUO479yzUGtVqMtue67L1xriq6w2ARIF6kl6Byq3OHwMHBN4RcXDkUb3exxIJSuLCagYYrsnERnQ5WLXhpdSAAx/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pbj55CPFe25xB3fiBrLj9pEp8pJo74Je7GJhUMbgW4=;
 b=ZrgYjNmeH/ygNgi0t36uHhIqgH6Dht5fY8N934w6mgB8IbBzHD6rmRvjhsJtf6puR/VWUkaSByRJOROh07NgoXsEhCq6Cw7wc8qdjpXBVBYM6HL/e7JWisLGiPffPHsZKOzC9PrcL3wtJdyOlrcLgBDoGjEEXnIYpGXyHbKQfTV0fnYHspxomQtGSO+4BVsRU4Y4fqAWdTU0gDaJqnQ08PRfBewHJHwuvSOnvlTgPABAHR5RQwNm5cweUl3tQOsng2U5Y2nUQv8j6MhF1clNRRRgUKKH6MC0FIsSQqQ+7H1fQCi/f4VrnAABntwv76MDIuvD1cz8Od2wiDZJbcHbKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by VI0PR08MB10538.eurprd08.prod.outlook.com (2603:10a6:800:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:15:24 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 15:15:24 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/2] utils: add Go mod h1 checksum support
Date: Tue,  7 Jan 2025 16:15:13 +0100
Message-ID: <20250107151514.8115-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107151514.8115-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107151514.8115-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|VI0PR08MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d95acbf-1dcd-443d-c9f9-08dd2f2e1bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4ZPcP/N2mxKeOILtKyStdGbxgyves3UznCgeRjcmrM6h5Jfw692Vuhc8t4vQ?=
 =?us-ascii?Q?SArf9vHtT1n8eWd5/LGMoRKky9ofDYTXgTHWZUGkUptB3RyfSRJKf0GPjGm3?=
 =?us-ascii?Q?Cy8lfapUzO6O+3FioEXlx4Eh3zZ42t8u8HoD7Cu8XLoXMA5J5gyOJnGKnvio?=
 =?us-ascii?Q?tm7qhmOlrWx37avdwy8KFGfx5gavIStWPDoVRo/pWtizfydHk8SyUj475Ily?=
 =?us-ascii?Q?eG1IQUWcKt4pNmulZfCDyM7z+kb9cEaakiGXEbzDYyMHi62k8MtRpY8oSmsK?=
 =?us-ascii?Q?nID3Fvi0zgZA3x8LeZ/cN9XLl+q4IM2zhZKgHySZrxlk+rzZRI94dI0Ga2Pf?=
 =?us-ascii?Q?+ZMcUASIXIhHa/tlz2itqNShCr/bjNiVDjDTdGE83Lyh/X0r2m8AUxOiuQ3V?=
 =?us-ascii?Q?Qsdpuo477SW4iYrxdMLKtlOFuG3XKiMwtbzbvUrIeHeBC9TYUG7k9Dn8VC1D?=
 =?us-ascii?Q?BFoNIpZN9VzyKgGWrAay/V/VFiNWujATSTj73AvmSFlcXXm0qNCyluNq/bfn?=
 =?us-ascii?Q?n++fOYH8cMEAo5MopipEz0vKBQ7uQYFkafEcpKj7xdLJiIoUxJlBZdc0GBro?=
 =?us-ascii?Q?vcc3QSWuY9+jCbbAbWk6qdWT9KC/QzO8FhjEdg3K9AQRBeLspGWE6BT0F3iX?=
 =?us-ascii?Q?0UlavdHB5YVBacYQyzstbaLoEbzobcXhFOaf/d8wRDQoK15vOccpdLKl9di6?=
 =?us-ascii?Q?kHuEB8NDl5ioVyqsvJBPeQeKwL+H7KIHxcrpbKxvaFrRnW8FJssXLc+5BHki?=
 =?us-ascii?Q?g75rvVAca/DNDzjUdDDb6cHAw9mBqcD2mkVZp4RtiqJJXy8l/VWXNzXULdqD?=
 =?us-ascii?Q?LfxV91F6GQ1nyt/BWgq/+OL5RVVxuEWpi8TYpVzpnDWASa790UUpsCwHhmST?=
 =?us-ascii?Q?MwSnuu0bEvWFGmzjLu0YK83Iw148Rp3UO27cLmAOmpAbGHDWQ9S1nJSzT1bP?=
 =?us-ascii?Q?w2Kn+PaHufyVNY760HTC4G2xSh54X1HOPZwpZokOybIa9fBNhhUnJjvCKDRl?=
 =?us-ascii?Q?alb4jl/iIECjzOnqqw1QOJSpphSE+FUuiJJGkqp0BadjQAxMg2lGrHaq/xLa?=
 =?us-ascii?Q?9gP2ByByPRHqrB+hMVz6wqpiYDYqTzRTElFuHWQXgXz7i13PYAUK6LGjmNWl?=
 =?us-ascii?Q?HKVeAO9dnpYjE22yxteQdOOys9kyAF/rszhYKbjtZzKNJCYzYicB0O7jd/Cw?=
 =?us-ascii?Q?A4EmVHd7gdrg/yvcNGtS2ZHtVSet9+heOAkY+/ILyh+8TDF4jnhXY6gXiM4o?=
 =?us-ascii?Q?yYFb+q20rBh4YAhjGYcOVIEdk88lUT32YxqtUGBiR5UoP8xCPjKl+kOI933K?=
 =?us-ascii?Q?aCOWpdmMQpuBVsaEAmynsghwiHh3zu6KfQ6/fd6rKzpi/OPzXn37rGV0e/Pc?=
 =?us-ascii?Q?070ciBSbF7odWIqNrXG4PYF18ef9IG1oAwt5vs4aY3bESiwzZdbS6C8ZyV4Y?=
 =?us-ascii?Q?uKSGGDAZazjpz8/SVW0bTJfT3K+jV9CJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u1HbDOgHyHcRY6SHgFmQ19VGQTHmbPdnT+z/9LLXWZEi3o97NTkcY5yOD2Nw?=
 =?us-ascii?Q?5qMrrZNlCW0V/ERcZKsFNnmKcIiSpX+RcnQDrnc/AVIQAxOpL3Km4wB6ogyg?=
 =?us-ascii?Q?nRRBV9DH0eLYXorTaPkuVZsM/K+GQLyuzu2dOBX2CKW5iEIjPGAdJz01T/IE?=
 =?us-ascii?Q?kVjqZbK8z417XWrk2sfloGahyb6WdgySUQH+BmCKlIZFVALxpulSh2y9ahe7?=
 =?us-ascii?Q?BsM+rtHoaieHF7j4HV3UmsWgWUuRh+02dYayvKlMYKzrfJvHfPic2GJOWVJC?=
 =?us-ascii?Q?zTDPajytQvWobHpS3pcAqDX5BfblVtaoSrZqs9iZ1UStWQnH6DmaF1zZPTb9?=
 =?us-ascii?Q?v3pEgxLfNQY1mGHZy/VryJKLGudl60aCrmyinoKssYpSPG46HTy7K3LYn80X?=
 =?us-ascii?Q?0Q4qWl91uz1vsagxWiU+xEhgfwqYTUO2JDDI2ME2Sykcz1fFqQXGFdPLMpzy?=
 =?us-ascii?Q?sSAljflGEaLe1y5EjsCVJDCunwsOGpQnVA7HkxQrE0jVJ5mItpGwesMI2RM1?=
 =?us-ascii?Q?8Fwj0kM2eChSyDdAGWOHTo4l6bUFz+qTKhBdzH6xKUW30U6jc+vKAqaGtCIX?=
 =?us-ascii?Q?yhrvLkhgYwKX6O/IKwEf0IZ6WR3j6xXl//MguO53unTualVN8N3GYwzl0O4Q?=
 =?us-ascii?Q?rSA5GHlNlIF/sqvJBMgdn1bwTx/+VUI7AUaKlDC+xo8akxE1eGpBCJiPcHR9?=
 =?us-ascii?Q?tRmRQMulSxu7OQOA2bUKHZg3PDN+VY9f9VzAwdVLeNrSFy0wBVxF3kmqJvLj?=
 =?us-ascii?Q?j8Vv7UClgoPp/Q1uu3iWcp4wulk7hXpC2toE6FvZPcTiI3zWSRWzO3ZYhMsn?=
 =?us-ascii?Q?/otp3mUL/Ixq3S2v4VFCdcbwndmOornc7La8qMKAHY11u1wa8HXyP7Sqjy5l?=
 =?us-ascii?Q?emPYRa8QTdeF0l7qKcyRnaC3FQbhUm3BRdIJfp3OCmW+1pHv1jiqOYIfH/ZV?=
 =?us-ascii?Q?EG7q8hvafUaR0QIxEBWSSOGkzpW+jBF5H6PM3oHAupSouO17Qh2RFm/EC6SY?=
 =?us-ascii?Q?Ai38sZ7U1IW1OsBY2eck8I1RoisXMZAN81Fd5t5BEXS1IznqoUjI4i/i9pT9?=
 =?us-ascii?Q?CxSuHT08B8xZf17HN33dzc6KADrQ0eVYlFP/NOKZ+YofxphggBPSBEso+ytj?=
 =?us-ascii?Q?NfvlXPwR376hJe054SP5fHHNt/smx52YRDfg61lF9uADTiHc3XKe1C/qX6oN?=
 =?us-ascii?Q?ACL1ECfqzURutbzwnc9UVGlJ8numi0grvxCKAB/r4O9ghzJbydVlFZi2EWJZ?=
 =?us-ascii?Q?kA6bZGjR1p4sG1dJIBye26JGwrnoFOGlMTGQM8ZaMZQTOBmpGIooR28tmLQA?=
 =?us-ascii?Q?lVn83P3nU8YzGmwEbcQhAFufj2HBZp+so8lHmo//i1gZpmYQzFWvL4K7cisW?=
 =?us-ascii?Q?OeE1eElz6astGXAS5ezy5Cx/YjFaDb8JX8DMvNdadiUjazkf0sxsordrakod?=
 =?us-ascii?Q?+IX2EdqL/+oEZOmqfYjgNEsvm+XuKezxRN5f+rne/1yJV0+wkT33IxQUEwTi?=
 =?us-ascii?Q?8EUn/gZhqEA3o5dY5PEVHPWGHD739pjLl2GnSnP+geB/S61WczfUhHGokxJF?=
 =?us-ascii?Q?B5LdPcCkfAru6HOgxwEg8+W4Br0Hx3PhgyvX889nvXQar/X+FBeBr/HWOd2C?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d95acbf-1dcd-443d-c9f9-08dd2f2e1bd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:15:24.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/v6jzfLUbUjaY2FCzMUCR59RGS+jYSTkfJITKkXC0QN/LfHy0bnIOe8Mul+S3cK7jOmymNTZwCEipRO6pr5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10538
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 15:15:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16979

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add support for the Go mod h1 hash. The hash is based on the Go dirhash
package. The package defines hashes over directory trees and is uses for
Go mod files and zip archives.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/utils.py           | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f79e278b1..911b42545 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -34,7 +34,7 @@ _revisions_cache =3D bb.checksum.RevisionsCache()
=20
 logger =3D logging.getLogger("BitBake.Fetcher")
=20
-CHECKSUM_LIST =3D [ "md5", "sha256", "sha1", "sha384", "sha512" ]
+CHECKSUM_LIST =3D [ "goh1", "md5", "sha256", "sha1", "sha384", "sha512" ]
 SHOWN_CHECKSUM_LIST =3D ["sha256"]
=20
 class BBFetchException(Exception):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e722f9113..135c71c00 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -585,6 +585,31 @@ def sha512_file(filename):
     import hashlib
     return _hasher(hashlib.sha512(), filename)
=20
+def goh1_file(filename):
+    """
+    Return the hex string representation of the Go mod h1 checksum of the
+    filename. The Go mod h1 checksum uses the Go dirhash package. The pack=
age
+    defines hashes over directory trees and is used by go mod for mod file=
s and
+    zip archives.
+    """
+    import hashlib
+    import zipfile
+
+    lines =3D []
+    if zipfile.is_zipfile(filename):
+        with zipfile.ZipFile(filename) as archive:
+            for fn in sorted(archive.namelist()):
+                method =3D hashlib.sha256()
+                method.update(archive.read(fn))
+                hash =3D method.hexdigest()
+                lines.append("%s  %s\n" % (hash, fn))
+    else:
+        hash =3D _hasher(hashlib.sha256(), filename)
+        lines.append("%s  go.mod\n" % hash)
+    method =3D hashlib.sha256()
+    method.update("".join(lines).encode('utf-8'))
+    return method.hexdigest()
+
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and ex=
ported
     from the metadata"""
--=20
2.39.5


