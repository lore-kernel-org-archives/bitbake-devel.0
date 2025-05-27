Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80948C5B549
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 09:59:18 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.3])
 by mx.groups.io with SMTP id smtpd.web11.48344.1748339952297077984
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 02:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FzaJ5L+A;
 spf=pass (domain: siemens.com, ip: 52.101.84.3, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl3BZ/hj/7F8K1alZwfAm66fazGbRuyTT0PyLYqDZxAtfMjXwfyJ+GKHeujZ9ZYj9gJyZC9xYTtCIGrpSpZEPVMSngWmNKWoTBdnc7K2Ty+hyW2j+7VcZzkS13yLOvglfR5boVarPg56nf0UmqaJmNV6hItmHZN7HbsspYAXuA7FR1SuTSOm/RAmHbQFG4UbE/gazWXIym80ydE1bOCYhbv7nwr7JpGctX7JkKwX90bn+WlDGOW0bp9vTdzJFCJNIBikHjqiJVDYEgOEq8VweTJYrs4KTOKHHaWSybCblD6DAxcxgeivLQizYk9nUf2Y+58ALtzYF/xIFsY+C+nFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ53C8YIJJdrfVZ0RXscNxQ0q9AVVoqchV5NPw7ZpfU=;
 b=FVNKr89IhniXV9gF2tbJ/lel/Gudos+2TX0PfEWtEfTTEhYrgUFoZdNmQvSMCoJuIA6rM97LOx9CniNwGJQ422qHadledijZkCgtyvci9rcixc2AmRXgRN2+FkXb/yZTu4IDv4EWekeGbsUzF4/0tEg9iRgnYoblOfbPdSutAFrz8fVVrVZhYqID+RlocJf2igoRDqpLoWHtVyU9RTGDHMciFJ7koq0FSWOS2lGiG1x2tJqKL1+OR0Sp3dN3Vaqql9CX//5Kb7+WE2nGYptVQYd0PCIkP008h3F8U/2OzxfAbci9kVwhQD5qxO/nwQEEoA7yG23d7zzPpLRiEUVIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ53C8YIJJdrfVZ0RXscNxQ0q9AVVoqchV5NPw7ZpfU=;
 b=FzaJ5L+Ada9tHDHpSuzgPiaKW4+n248RDXy7Jrb9Ea/Q2l070gcbdYwifDOML+FZWr9If8HkpBXHASmIrCmH+WfJDDex4lYz6/d8xkKW/8nf78JKBo1GPqI+POeogSCoy4fHCtqVE50Wb5sHR1glcD08XN4R0aZc9Z6EFIxLEMRe/jUoEAlJdAYcYwYmS92pR+ueTi+4nrvFSXAvcfyQ6z9apZ5yfpvhqOjmzIVf5zbQaTsaEth5gDbYJ+efctN3yrXcErQxQ940jqpdOhNdKD9BivtLkVrl2wdRfbnZxijSlFtO2iab16SAlxeH4Aym0b+ON419eQEdtfFbMGBhXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM7PR10MB3192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 09:59:09 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:59:09 +0000
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
Subject: [PATCH v3 1/3] fetch2: Move the `ensure_symlink()` function into the `FetchMethod` class
Date: Tue, 27 May 2025 11:59:01 +0200
Message-ID: <20250527095903.2300556-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AM7PR10MB3192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca24cb2-72cb-4090-4113-08dd9d052001
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MOoGexne1SnywL21HlFsM2llpQ7e3OVYN/Pk/wxvYlSLyQ9WPpqI81mqHWOA?=
 =?us-ascii?Q?1IARs2Y4MPbof0XCz80BXOVvTmFHdMFd82AvG+pwgXqT+aidIsFYIDzCQXBB?=
 =?us-ascii?Q?jOZv2Ko1cGaIGgY+Zxr+PP/EKBJLEzIVmaKV020m2Q+6NRA7VbBv73rmQsBM?=
 =?us-ascii?Q?7dNLMTm9j/EiVIqoY2NuvBvUYxXM6AHqZd2H8mRmM+rte7Ao2eK4GciEIAnw?=
 =?us-ascii?Q?2GiqJLe0Rv/Wp5Y+UuS9xSv2f62AzuEHCyjByzlalEQ0stR5KiUsOK395bZh?=
 =?us-ascii?Q?wgML79WNqz1EmCkMkmbv7vSSMNxEoG/p/ylRQ0M5agbg0/Eo2AQ6SUcm1mMx?=
 =?us-ascii?Q?hEKjU1St40RqJBWniqPKsbsTeGNtsnifrB5Wyb9YdZn+mJqIpMIGqvVXu4+I?=
 =?us-ascii?Q?+mgMvARwp06QmOInpoz9d+fCs/haue3o4c0/pvvR8VtBb6dnd4Uf1g385LJX?=
 =?us-ascii?Q?hmURxm/rq76uunUoUiFss4AWSgeRyMuBGhLmGg5tR2wFiWjI3tCWETCsnd2S?=
 =?us-ascii?Q?i+rZoHc3+5VTPj5JqWnLgVI6k+rLI4UxYdMSE5jvM0/3aPOapSnb1hrJx3NM?=
 =?us-ascii?Q?OPJwot7NnOFmC91juyRG+OWeuEHjNRsS+4njh0fEt8kuxsG8OjilRZ2oKSOB?=
 =?us-ascii?Q?OrOn2I+6nZa5LmQp49EZ/wKsAaoyUrU3ul29Cv8PZO3J/GpBmrNMy6q+g1qo?=
 =?us-ascii?Q?HQupDoqbNPMkUQ2lH8M7s7JMustjOoulhu4AgvfE13S+sU9pzvrCy2GztxA2?=
 =?us-ascii?Q?Q7Tbn9rIT4TUJe6/nASy8PGX/8nA8hIIXeYn7+ahYl1y3qcR7LM30j3sbGDg?=
 =?us-ascii?Q?1zGX9Vp0p9ZwCZ4B0qEeoS+n//uj+sT4LfF1xq3ynI18YpOKjv50+rnCYKNG?=
 =?us-ascii?Q?0tmqHKUYvMPIejdhjD/4Lr01EtdWreH+GhsGrlJn/9luco9XSAo9SoAeVJN3?=
 =?us-ascii?Q?ZRbL4GLpG9YIL7dxZe4xYU46bBG9D+qoSkT4ryrS/FCU0EVgrC8PDN7e6hyG?=
 =?us-ascii?Q?9CDlmq0v8hOvPmJ9Tswjg5yDBNGnTpTcYccNJ4jIBFPKgDDSOnjRNiApd+iM?=
 =?us-ascii?Q?3Izp59nozL0qY/N2mg1Lo/IfkFIlOcI9ELZcDnOHyJNRc55zwccGcktZqMuA?=
 =?us-ascii?Q?PTrn6QZjiIPeOsatXNJRKsBZmIKHZcHP2XQuCWN03CeUAk4kg4MHccDQ0MCq?=
 =?us-ascii?Q?8c6Mfxtt2jU6FPpeSYY02Z6k59GTd7yMBRUlpqT3Papbsh2J4pZnvHfeon/r?=
 =?us-ascii?Q?QOs0WJKwn68GQKFZx3rDc5bf36xkVdeFJ15kovMzN7ONdi0EZzPV6q6Sb2jF?=
 =?us-ascii?Q?vv6aktJROivIc+u+BFu/tG8LSCNWsAzE0VLFAhYR/MGWTumJEcc8WfoXO+Y6?=
 =?us-ascii?Q?Ljwsf+nZ73BJlskA3isS9dOezutPrdI/909b0JPuoI5wCCzl0BRfvbhdD5K/?=
 =?us-ascii?Q?wkwLXpK3J9o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XYsHsYuNv4X5LULtCUDwerwLElKje94yuzYXCu+xWsE2yRX+c5+39Mjk6BuC?=
 =?us-ascii?Q?duB0l7P3lWKk3z+15ZqD+S03uXB/SMTbQeDMp+BdDktjfWzj1XK1nCzrQ6oh?=
 =?us-ascii?Q?UITbql7wyUsU2eSrJwsGHLXPBhVyCCypB/VNpQA1EqL6DndDvpBUdvQ6uoZu?=
 =?us-ascii?Q?0KKSrJOY6clK57vToLw68z5ojKmwHZ2X1fwovhaIR8b5OTRAeEWE9m+j+WSr?=
 =?us-ascii?Q?eAFpSyrETOjf35O5cIrXc2BxqVP9jd+2raDt1WriL+LJquzhUzATxvdZx2b2?=
 =?us-ascii?Q?/ZkAmaZ0oD7uug4lLPuAKZo9ZlODLvsynn55+blqWOTtBCOSxrQs+CQrD3dI?=
 =?us-ascii?Q?g8x+557GceSQLSMLkjaTQov0eoR76E5qAdsVFGhcgQG5wdiQRX2Jg8eYoQzd?=
 =?us-ascii?Q?EmYqHlH0QvIiES7BuW5BcZD4uAxomUY/WSKMqlI5DypxkkkbFcDKrsjTc5hQ?=
 =?us-ascii?Q?nSqs1t22909WsDFgy62ihcAj03RFXAUNKFNVU1GtcUDrLz+IiwPeWyAH1ajw?=
 =?us-ascii?Q?NvdVtebwCsHcGnICtEMlVCivBm0CZWLkNRhyXbW07ukiXB60/eVk4J/cfhXz?=
 =?us-ascii?Q?bCGKn4dXszzdlKIx3gdjku2UJ/y5X233GWXjKI+b44KDNIKG+kazjFVw56de?=
 =?us-ascii?Q?FErh6JwlwSKg8ZfhRtOLg6RxPj+pIQGbGaqiDD165V6dzzrP6R94tCam5lme?=
 =?us-ascii?Q?2JoEw0gkvvL/J5cJA1yGpuI6LAjvMZn5vfuKi/s93CRcTqJp0n/A9y3V+heE?=
 =?us-ascii?Q?ywsAppJY5O64+OY6T5Csgpye9Xj8H6y1XE9XkHnIjsZV5nBEwWwgeSeA6DwF?=
 =?us-ascii?Q?8Gu6LiaoQUHBTYWsesMvdjM11iOTQhww4a/I1mw94qxrK7b/21XTL05/DBkp?=
 =?us-ascii?Q?AMLp6WG1H2Puuanz23aCJHbOsk1SUeI7cCKh3IYH8mPw7c/WhRBp+6dAWoKW?=
 =?us-ascii?Q?2fE60qt1Xn+i5ztTXc1tkF2FvQGxxG/b/xuRMkvOOcs2MD+1+xg3okWBmAQd?=
 =?us-ascii?Q?hf7AF1pKXXPw+2kRO4RcYYF7+Cmj/mPK+mqqoATHiGkO08e1Wz8dvvUxr/qH?=
 =?us-ascii?Q?zV6V9W70s95EQkZZJvW7SFo7wHTbcw/TIhYKwmxfbfQOYFjpI+dWlgK2WbIX?=
 =?us-ascii?Q?au9ECoUeKwP2kpVWUY5heS291w4Ua1wbsDd4mBqaOgGq19UGT+gCezn9i4z5?=
 =?us-ascii?Q?Nj3gCTbGVpxovRD1FsyF5eU+Bf2RzfP6ApiFgiqAxbIz8mSxlJoPzjzR3YLF?=
 =?us-ascii?Q?ns5Xc9soaJnOcAfxePEyM/Vxav1xf2n8GQBpjGTBIa40KAejK90I6LJ2f1lN?=
 =?us-ascii?Q?U849dVIAWSI9SXpHZ9OuvM3j/XpP/qQLEWbVdRDx7UZVEMfm/4xyR4EZtXGd?=
 =?us-ascii?Q?7y4U+wi0IwHaaax2dqNCCdwxglMX+b9/ccGi4+O/ZaA51iNDOj+PGCOnhEov?=
 =?us-ascii?Q?WAszQHdNbCn0Nz1T4Rob2YijjJT+xuQsrhqkMz2e4bRYvEZyCMp+zf/zHHpN?=
 =?us-ascii?Q?TmZ/ONj+QTVTNNCJBgJJJvbWi6iM8beAJgopSscqf9GPSPiuk7Py/iQ7mtFS?=
 =?us-ascii?Q?+T0BkhMsvn6Uur7CKW1GqFJinXEvITaDV5cglbhRwcrqsTkk5UNgab3h20AK?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca24cb2-72cb-4090-4113-08dd9d052001
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:59:09.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXCFZ75uJUB0PeG1M6I+avCSYwwnj9mCBZdEQ91WuG+BceoahbbE5UeHcoo57vxQfEnRb5H5G0zXYFdfvudwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 09:59:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17645

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/__init__.py | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2de4f4f8c..fe6c1cee2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1151,25 +1151,6 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):
         if ud.lockfile and ud.lockfile !=3D origud.lockfile:
             bb.utils.unlockfile(lf)
=20
-
-def ensure_symlink(target, link_name):
-    if not os.path.exists(link_name):
-        dirname =3D os.path.dirname(link_name)
-        bb.utils.mkdirhier(dirname)
-        if os.path.islink(link_name):
-            # Broken symbolic link
-            os.unlink(link_name)
-
-        # In case this is executing without any file locks held (as is
-        # the case for file:// URLs), two tasks may end up here at the
-        # same time, in which case we do not want the second task to
-        # fail when the link has already been created by the first task.
-        try:
-            os.symlink(target, link_name)
-        except FileExistsError:
-            pass
-
-
 def try_mirrors(fetch, d, origud, mirrors, check =3D False):
     """
     Try to use a mirrored version of the sources.
@@ -1655,6 +1636,23 @@ class FetchMethod(object):
         """
         bb.utils.remove(urldata.localpath)
=20
+    def ensure_symlink(self, target, link_name):
+        if not os.path.exists(link_name):
+            dirname =3D os.path.dirname(link_name)
+            bb.utils.mkdirhier(dirname)
+            if os.path.islink(link_name):
+                # Broken symbolic link
+                os.unlink(link_name)
+
+            # In case this is executing without any file locks held (as is
+            # the case for file:// URLs), two tasks may end up here at the
+            # same time, in which case we do not want the second task to
+            # fail when the link has already been created by the first tas=
k.
+            try:
+                os.symlink(target, link_name)
+            except FileExistsError:
+                pass
+
     def try_premirror(self, urldata, d):
         """
         Should premirrors be used?
--=20
2.39.5


