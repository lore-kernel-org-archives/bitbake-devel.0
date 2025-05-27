Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D3C5B54C
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 09:59:18 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.47])
 by mx.groups.io with SMTP id smtpd.web11.48345.1748339954286886601
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 02:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XEQDwRe5;
 spf=pass (domain: siemens.com, ip: 52.101.70.47, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNVN98joj80LCDj1f0xFdJpExwYKksZ5FNZ9XRbuvqyCRYvO/vfzXKIH8eb5yKylXzuHzm5vUIvpWUSRicuZVEMczY9j2kVCBHFI+gw0ZpZlN6D8Gi9oorypjfeMKAO5C7L00POUvbbRkAj3Bz+xRfve9R+vTwoRbDXtxxQLJbfE8By/8eMITVUllbB3zfYdkfCJDT4DjltyEqf0ESD0fuut9MNa+VLtNQBoLS6FUIsi8F3EbTwYY73SdMjaQLfzA1pvOWYqLzOAjLYAVdrYQh2kb0IGcsdZuVLf57XnaTciNHo/2mJWDevtTAtuTKT/gR0xRaqvNZrjUhq5pi5bMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSp96LgtxxVk8ZjHjXWIFcqAEsZWhrsZ3Ozav0Nkdug=;
 b=VGAA68ltaekS/fxSj0jXq4CYL0ZZ73iqQyN37L72S5pMo3SE3rWKxImDQmLX+KKkNZ37Bq5g8egFsHZANcGmYg4DPhiuSEpGvsQhucNq8iExce5StA9qWNxenbPgma0po8V5XK4ycLBkwVafSxRbs57tQdjKB1SSBXK7LaHN459v4zIap3dVseTXHYE7OM6n7vA83exjNtasPHivOR6+n0VKmHcBZLiHyabdgqT7yqhqylfh1UTiu8wNQRevkYYC3RHXD48nmsd9WJumGCoqK7DQYKlod6ZoA0nTy9ZKNDOdlLSG7ly+Gs2F7zgJQswOgH+k0ZopKH1rhqYYhm3k/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSp96LgtxxVk8ZjHjXWIFcqAEsZWhrsZ3Ozav0Nkdug=;
 b=XEQDwRe55hdQFQoa0Sq0TCszWxivkTiUqq2hYHExi+fR1fIpppT2Kzq0EPNRa2MepbHAt1ACif+nC44Vk0tWeiRtKUtix01gFszmunGvmB7nTK7Hk3YQyLaj7yKmeSBVa/oFulv1taTDmcy3T+j4JDfnIhMVXpfLpD6x0LeBtMWxTObjKmpNyBjJH6zBvpRjsSgWEH3USluHMaecPoebmkHWzh0z6q1y8cerVhXuoh6rD/xeETrikVeDUrAUqYXpjHOGaXVhEpj3G/9SuMZ3/EPnPjO6GfrrgyUM82VvauA9piuNzI6fqAUpKo7HH4Jo+cgSHrfkxENcaCdChegtqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS4PR10MB5442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 09:59:10 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:59:10 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	richard.purdie@linuxfoundation.org,
	liezhi.yang@windriver.com,
	niqingliang2003@gmail.com,
	alex.kanavin@gmail.com,
	quentin.schulz@cherry.de,
	jan.kiszka@siemens.com
Subject: [PATCH v3 2/3] fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow cloning
Date: Tue, 27 May 2025 11:59:02 +0200
Message-ID: <20250527095903.2300556-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527095903.2300556-1-stefan-koch@siemens.com>
References: <20250527095903.2300556-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AS4PR10MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 279a2508-5b0d-433f-eccb-08dd9d052086
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/XHXBwWPfVBZKIvM3KJA6XozlHf9+aQPEJMooK5zfnhk3yO6l9p6r+YCHZzx?=
 =?us-ascii?Q?LB/PnmfH5U9Rll1rIM4oOegZi9OvlwytzwoGz8MbpKEibTyDaxrx4PQoqs8d?=
 =?us-ascii?Q?Avdc/1t1GnvOzUQjwJPm7nqgNn69slVCY+srvQ6lSYuHhdDucDj2LjpPIXQW?=
 =?us-ascii?Q?zxAL1fg6YD+OPnZvlo5eQRQhBXcY2t6y3fX9jDVAsGnvwf/jtLXVwnPMVr7t?=
 =?us-ascii?Q?iHejr30eqq+NAqj12m9MLknZpobUfGvW4kmF605QAH0RXGH86i/+OXXy67Ko?=
 =?us-ascii?Q?HfxSRcqfXQ3vuC5GIu3xXXPJwUy5X8kLtKxkcjBruFJhDxzn+mZpunctc8RP?=
 =?us-ascii?Q?YhpAdDOkIdoGj9jJ7j41HmQwnhn5ZjOTxFhZ6qwCwg3M3JaewRhkfRhjvpJD?=
 =?us-ascii?Q?WKauOevlHlX3bPcC3tfeHJKbvMzPN8CaAPYITbMaOQ4s71Dj1z9ppdNir9pR?=
 =?us-ascii?Q?T9XqoCiVP1aSx3iAnB/bP//SbqBMxzHVyJg/PlDnZQDrl6E9dYgq5y3wCxqv?=
 =?us-ascii?Q?/2PAMgry17gZOEFXtexPVs4O5D8vUkINxnD9k8dvhd0JdiJMu6SFC8AWfB5w?=
 =?us-ascii?Q?cYgFNPXqjxzl/LwlE6t+A3X1wj+w9PNWhh5WedJWBgLUJ1++MOT5wnshqdJb?=
 =?us-ascii?Q?Rd6OQYVwptwpE+eFPi2l/oR/+kofuusOQ+O5IWvtBMOBpvsldDboGsephBlt?=
 =?us-ascii?Q?WpOnA7sEqrcqNKCK9p01maGhDKMM3h9yZog19X1Vfn0OXX250KeAh2YfyxHE?=
 =?us-ascii?Q?/AsLxeJKSB5hOQXbnQQTyhvb9pa9hzf08TY6azoOjAq+HsVz7H+b5EdK5mXj?=
 =?us-ascii?Q?QKk6W0YttJUxdsX+mlobRNJHkk0BkOFLXwjs1YVK/sZH10/RessWALkxbUZk?=
 =?us-ascii?Q?rxZkRi496Z8bNsWWZ1gJU01ZrazL0HHPzGaSut9jwNOx841FFCjojzxu7Hxk?=
 =?us-ascii?Q?T7BCo5YaJcrZltUge7psfSyKQ/qlGENc/ZMHPO5XBXR87F7Goq3Ie4Ln+Mc9?=
 =?us-ascii?Q?1kINjx/Q28gtOrVqx9X5b41XSqwLEQm6S/cj/MNMXyv4qRUb1mUdbLY+E1XM?=
 =?us-ascii?Q?7Sws/H9tgjETBdY10hMiYKh9F5YuTi5LeWEhFip++4mhhn3xQhFFnkscBsKy?=
 =?us-ascii?Q?h/0kuSFMFPWJgAd+Z1UeudSl02MVFyBT9geDrHCNLWzWnVIoeGMOiZwS8sXR?=
 =?us-ascii?Q?WVqWaC/AITmk78rOOqOEchBinLoq+z6gtq5AkvcLfY39SqzYEJzSutg/6geq?=
 =?us-ascii?Q?UpJMrJZwg/IMPKoZR7wphl7HUqO6r07M63/HGxFuj1RYg1eu6Ht6RwFKWZDI?=
 =?us-ascii?Q?bCfC10cozEX2WM/G6priuqEwTMkvgnjQ2EXG7AxJ8ougy0C7hD0ufGCr6Ltj?=
 =?us-ascii?Q?Nke/ERuTLtdHu46ogHe0EZcnhGc7cJ8L851P7nxRcara6h3TRUi+IrqwwKZn?=
 =?us-ascii?Q?N6oK6EBEkaY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?N/6vGQbXtmS1duPAlEVMdN+DEhm2oIdTDmm97diFpTVIZGtsBuSI2KKaBZ4F?=
 =?us-ascii?Q?NMD0BmEY8VjDAdt9PgRdWMqC1VkCuwEB2xbn8KB5gczlZTobYg39Xo9xuHik?=
 =?us-ascii?Q?vcU+VPpxvDZfp2Hx6RYFHM78EFvOfeyIH54rg1Xun+op4OyaahPUH3Se3fso?=
 =?us-ascii?Q?djLvtPLZI3iT0gKM6XlITOkg13rFtg/Sb8tAMZiLEOMHJMNRnCfJA1RCTGXp?=
 =?us-ascii?Q?3wtGbg+E9yPpTLrXGvymCBtkL8p/PIjKiKs/8SB/9tsxR+rY/dVhQJ11uknF?=
 =?us-ascii?Q?ETikBeta03QcwaMIfs0n8voXFDkKcWOscMP4kezNE/S5Fv8iV9YJ9nGcS2QS?=
 =?us-ascii?Q?xTX4Lgsaxq+YzCTQu56t/6jyDX3UVjKiC+UFt7HdmhObRzRHT634o65UjO4Q?=
 =?us-ascii?Q?Qq/SHbc34Imz1ukk8Mdb6OoaIq6HJ/0aPo0m1HcEOR28NkThN7SwuY4en3jP?=
 =?us-ascii?Q?PhCOt+b+mn5i5kjDxJ1SS2je9SRPx+VIyA3WKrCVl6u2NQp6M4IZyXYk/vJp?=
 =?us-ascii?Q?PamtL+tIYAeoRMj9R9VA3WWon8WQA0SCdPmYolVtmPbsZ36GKwU5xxMeOc+h?=
 =?us-ascii?Q?FAWiqEOGibnAbCLBet9/Ln9boYi+cECcLw1Fu2eMBznuXOsHZZzECZkdXVNe?=
 =?us-ascii?Q?dKpKncWevd8ujL8nmbOGP77uvoW50r6LGWZqARfDBjfJNfTLQy/zrGLBFSKD?=
 =?us-ascii?Q?Omtdt6YUvdNz4ZLnD7VV3lVxPfE28eq7OKA0S/PIz8O6gTp4qmi8c7ExNH/c?=
 =?us-ascii?Q?f5xG9VEflSgONERwy//Mc3NK2oAy3U9iDA/SzZyiJ0Ig+0FGI6jiUSlOJ9ZJ?=
 =?us-ascii?Q?6QJzCp3RmUoBNY6d1IbHdPdbNwZS16y6bPR7sAPIHZqxmFKG6timQSea/LTg?=
 =?us-ascii?Q?3MGjMwngwzHG95bF2o/qzsnzUD64PTh1OToAQlOsDdsk39Q1lat966DoKLSO?=
 =?us-ascii?Q?Nlsd1M+B/Kxhb9hKHXrXJAw8l5BUzHeenSzvZmpmly49sGvDktHZX4d7tAVK?=
 =?us-ascii?Q?qyNUydF+DeV52oLRKI++lRSJGeAGVO2jfdbh4QTljLt2cPBFLSMW0rBdH2EP?=
 =?us-ascii?Q?CIYPJq7DWhXP1+SeamEQB5x/M0unIG6Q766crDnNRLqtYffS6wAGiIEzIdRQ?=
 =?us-ascii?Q?JzFHhc4MUNCShMiTYGnMycqy3cATfkmgGjhNaE5sQZjyaeNVpbiO7KWwtyUz?=
 =?us-ascii?Q?yAC+LY4DUz9R3dSOoR2DUx2snwq3sODNEiLQ2xA7ldVRA0nJ2zrXvg/wGrkF?=
 =?us-ascii?Q?FangQqXpQUXf/mu78bzkaO+KrWlO/dWb71hnkrvzbo801GEC6wQMbRLtzZbV?=
 =?us-ascii?Q?wwHyUx++phpHCE/o0zjCL9hc6JdfrhTczpGjvcNRnf5dO/mw8nBwxKgVsYtA?=
 =?us-ascii?Q?ipfbMZAL1Tf3zV9yt/yGsZqy78w7pZeNrZcMM8lqzt7ox0r8bYtMhI873jMH?=
 =?us-ascii?Q?dkaa2MZ7Gjt26XBtB+rxORBSurTWwB94YkdIIKV2zE3GqT3zwBAM7vrxiyXq?=
 =?us-ascii?Q?lmiGnzeU8nOr0tmMUX/CifwBPuv/6DxjKoxHDk32mJGj8qZfVYmRkMNOYB5b?=
 =?us-ascii?Q?5R4JUUnuD1tRVpGRxF2j/NbEK6wZwf2vxveFpR54mCPuZYo2TAX/+KhDBMg3?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279a2508-5b0d-433f-eccb-08dd9d052086
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:59:10.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBHJXZxzIyg+sDz6rmqXtbBkMNFRZDxiREB4JhQ909dYIBIrOEXsSykmIiLqEOEu5W0+/DeX1dV+zqcwe9fk6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5442
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 09:59:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17646

- Since `ud.path` contains in that case the `PREMIRRORS` prefix path,
  this change ensures that a correct symlink is set up.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/__init__.py | 10 +++++++++-
 lib/bb/fetch2/git.py      |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fe6c1cee2..dd2dbaabd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1117,7 +1117,10 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-        ensure_symlink(ud.localpath, origud.localpath)
+        # This may also be a link to a shallow archive
+        # When using shallow mode, add a symlink to the original fullshall=
ow
+        # path to ensure a valid symlink even in the `PREMIRRORS` case
+        origud.method.update_mirror_links(ud, origud)
         update_stamp(origud, ld)
         return ud.localpath
=20
@@ -1653,6 +1656,11 @@ class FetchMethod(object):
             except FileExistsError:
                 pass
=20
+    def update_mirror_links(self, ud, origud):
+        # For local file:// results, create a symlink to them
+        # This may also be a link to a shallow archive
+        self.ensure_symlink(ud.localpath, origud.localpath)
+
     def try_premirror(self, urldata, d):
         """
         Should premirrors be used?
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 784a45bda..55dd084ab 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -348,6 +348,13 @@ class Git(FetchMethod):
     def tarball_need_update(self, ud):
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)
=20
+    def update_mirror_links(self, ud, origud):
+        super().update_mirror_links(ud, origud)
+        # When using shallow mode, add a symlink to the original fullshall=
ow
+        # path to ensure a valid symlink even in the `PREMIRRORS` case
+        if ud.shallow and not os.path.exists(origud.fullshallow):
+            self.ensure_symlink(ud.localpath, origud.fullshallow)
+
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only pre=
mirrors
         # is not possible
--=20
2.39.5


