Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE1BCA100D
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=3Q7YtIEc;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpSmyLS6OBlZtMiqrLicoXqxBuzGZRlTRxRk5YlSD1ckHodJe+1zSobvP64VqIAr44bkJykI8fIBVMqUN/K08kho7J5RqoDGzeBoob/qz/Zt6y0f+yA3B1eiu0vCulCDr0nxrNuIJEWYCmoDDqApCm6x9skWg9qVAzgv3o7DYRWq3LaGqnInMHW7jMVVUOjJd3oUyknvtZ5DaOzy7ffDqujEQhJbz2w8qeB8GByFX4+EqrDa6D13DSszvvBW4ZS5vlzAXaTET2Il7y5ZT+SGVCXZBT+AvilpIMRaynYlM1f78qCWuLZ8NcTCYyuTzLmK0IcR3bYpBm9CCeedAj3hiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pyibmCDjVxcOUl8+AZATsxhEiXUybako2ZqMaqNKEU=;
 b=QzYqAP6BLxkFxMip7BJ8BC2Zo4kAAJ9io8MspD0DkzwwsT0oHUbcCwM8R8aaMJ/d+3ekpNXYuKpntMgW9ayLo8pDX4fnEZ2Ky7SQqdxxOMbEnk2HQyjlKyTi55+mWxjasErI0tZYeMEAEMdIARUtff77PuSmOFkxA0kaikPiKSdEMgxYRNQ4fw7gR+OA1DcWd1535O11vXTQNIv3avt/R9vLko7uO7fSpa+JuA63XRAWSW6Lz7pbJlVr4YB52VYW8gBFi/DK7osdz4fGmQXljSJAKZ4hFmWIJql+rThsYB/Yx3TLNo2PZU48Zlty8DwA5Ln+CzRx/wGk3wBc1BAzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pyibmCDjVxcOUl8+AZATsxhEiXUybako2ZqMaqNKEU=;
 b=3Q7YtIEcZ2lDuiQtI6XffDY1/Y8HvJaJgUBg9cVPI+oBWm76bP2pOH68Yoa6T6SqU+Io7qHE+pPDesWb0oPOoaRRzdR5mqh1tAN/LLUxIBZUcyMpVBu75dW05FDwVq+2ip8RRtCP/7VMZMuGV6KQDVz5nXKTLLCpM+7yDopfqgLA0pZtE3WMd8DBHbSfZuF5gELchGMtchFbOvd9Ycs4jU8PDsPtFaT7lMsjzCMn5skgVxwSIgT4C7ElKN6SLGIZ+3Q8L3m36OzATHhnOZdvBCzhUmi2ABQc2A6JXW7w11Fcf48wQL5B2+e/Q1Z2fLsfm8BMC7MlYw4fa4+bKpUxdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:09 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:09 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 4/6] fetch2: add support for implicit urls
Date: Tue,  2 Sep 2025 08:55:05 +0200
Message-ID: <20250902065507.35737-5-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3add107-0abe-479a-4d49-08dde9f19176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3Ks5U0/sVL6azFgxDeergpylC/Er96V3j7yKzvQPf8HxOrpGX3WxhzWIcNuc?=
 =?us-ascii?Q?autAQ6bvu6c2dtAp7QrG+aSi42c/YVmJ8UTGRfogp5HQ4hKptXlWJ5b+TJ9N?=
 =?us-ascii?Q?Ad2NLOLiQyVBDQUQGIAPAZhaZdZtKNyn3KZklpZ5SEwQC1TbavK94LJCzR+Q?=
 =?us-ascii?Q?yQA6FYIHE8oZeC8n/4ww1fjP+GA+iT3JLFmKePuklTYXmCNLFOGoo551AioJ?=
 =?us-ascii?Q?Qe705hqFfENBmeck7jqpiaU781iWPnionG2B8QBnpMdJwEUJFuBBbldOnBCq?=
 =?us-ascii?Q?450cb5YKlyuB3BapXiXudOxXquy2HVa7jOaw5nHdFp4bb62M8Q908NtmGNme?=
 =?us-ascii?Q?fA0KqeraQ2x9xr+JVESbn4EwEtqAUEGtO3Z2cSLHV2jAo4bLnMZP6LkM/bKb?=
 =?us-ascii?Q?RpUKUxG4DNwS8gAbl+iX/Z6NmvzEv4jIulNXbid7DQ5PeY3XCqEfjh8eHqCd?=
 =?us-ascii?Q?JSgXMYis1HRiiT5EY/4lX1g9DHxGtbsDzllV5wnL+ID8MZdQR/VtPnm3R8mz?=
 =?us-ascii?Q?J0SWoSup9QZ/Pt8kAu0Ug/o7M1ObNlSoXqasDbh8dxKB7HN47wf63HjQAydS?=
 =?us-ascii?Q?kJXYba9RaPXmV9pGYQCAG406xNmjS1wYFwnltWu+sS+ryFbjRHgwgH+RUGy0?=
 =?us-ascii?Q?aHtA4gNlmHraRVJ9UH1yaxMe58UkQxmmQP9CEnHk3FVFmIXiZXR+n3TJ5b8N?=
 =?us-ascii?Q?Pc51KLYb5f3rTIBsCiyUlt5icSt3S+mENUXoEWmV0fnhIYReoLw17nHuPAz4?=
 =?us-ascii?Q?Fw1JlwoSGmtZ4ughDG4dwhQjAOeEIVsJxt4m2Zx3n6GyTs3EF5b2alY/eO4F?=
 =?us-ascii?Q?io3uJrL9B7wuKgqByRFilpk2JgZCS2wqj43TDCZTEJiiApk1cXWZLaR1o1v2?=
 =?us-ascii?Q?IGSrGvoblQL8F2VjRyp4kvb+OK9tLvczAG2swRpNaj04tNF/fujhJnHGwRiP?=
 =?us-ascii?Q?7/pIwZTMA451/kMFhrGbXEKdA4e9XH+bWC9TJz9DO46PhVApEovfsUTMoqlG?=
 =?us-ascii?Q?TyiXc8flfRh58YORwKAndj0OkzlQ9YqUnZlnz3pSNPd3QrXA0BmlrrfOLj9M?=
 =?us-ascii?Q?SQZLPkDVmldozv3kv1MyiLVY4uD+7d1GPSFZrHuJ0cTuIg4qnMUYwWotUtBq?=
 =?us-ascii?Q?5M5Ur0n8KkK82+wFa3PtpdYiTxT/J2PQevsHdMqxwjOpIA30lWnIQ/rEBgsB?=
 =?us-ascii?Q?H+CY34vqlLTO8SdKbyjmRITDcCfJFXKsRryivkWxqShovNJzHVX8Yw2YQiMA?=
 =?us-ascii?Q?wnAMSVcEK4owu5MNfZjc7mNnR14XzbkbHcPkmHHeoyiWqyaeHdtJBVLv4bT4?=
 =?us-ascii?Q?B6lmDEle3Rt/Tc9ep0q4j7OsIKBCFrqTziQ0GxZ1NCrFMVvRqfaJRAhoHSF/?=
 =?us-ascii?Q?iB73inzz4jNo+VpHd0qYltixjWWM5m6BDuNkFhDVzpB5TwLtqXzQfK9y/BtG?=
 =?us-ascii?Q?bjsv3Rb2+sE8WRjN/9zDOv7t+0CxeNQu7mJxKEgufaFFksWFxpa+fA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LSW+Tbr5C5EI6eRWputAL9A+32/K0JqIfthKXvLXn2Hn/DkPLF57Qm9UZmK3?=
 =?us-ascii?Q?tl04ZyLIs8klIXwOZGqkw2HYtUroKzqTzWgf28ts59HlryAd+Uv36zNbrWGf?=
 =?us-ascii?Q?g+tLrwS7pkCN59xseKO5WAozNGJnXz4ht+XVE0J6jIwIeIT9bQs+RYg8WALU?=
 =?us-ascii?Q?I2f1utOJo9JGRcnZSeEKkFCxvAVddNq7GSRfYuCmbuKF/SnElxpIynBJ6xWd?=
 =?us-ascii?Q?wkwGFNBMn/0UBxkHETcSGZM/NbNScvM5g/0eDVN38eOd52hECI2DYBb5A5xz?=
 =?us-ascii?Q?HTrNX0ye8qyT5noVjGftROjDMfCNLcWStgfmXApRV2PYKG6r/kx3FZL1YCSU?=
 =?us-ascii?Q?nJ0wTWdGpSYMg0xFNl2AEKE4fD9tgpp/rXUGTdXewpJlwXHK+bZNsaM5MPPf?=
 =?us-ascii?Q?7VwYWTLsBnU9lr0zQ1M64kMAUXqzoF9ulgfeE9+VZyeYGdsx9bkc0qEv16pW?=
 =?us-ascii?Q?SOGfEhluDnmwbWr4XNemCYdwfD0VSQg44cSc8pYOrJqqW3VTSmKBi9x87/Qa?=
 =?us-ascii?Q?cZT4TruOvg5Mln4y5xaZ4tzbCLPSIVdJCCmnUYWLJA4cE20OpRsVrYsfeyYf?=
 =?us-ascii?Q?ucrHOD8scVZib83tqsnxim/bfuNQb8dvwAv5oKyWc5Ata5dr5IYl4jU9o0q/?=
 =?us-ascii?Q?bwsl+/6+x9sv+dagZAayxh3U1XnNUkjR9Z4lBHEpjShM95Kx7/qzq6jYIyZW?=
 =?us-ascii?Q?TKzLFUA1G0KjDGdPJedZtAowRfOhy3Go1jcqwZZiaFx+GBdGUzHbkETlx16I?=
 =?us-ascii?Q?fxzXxFG42/aURiEeji0fNujVZvFOtoLjYBHsETZWT+A4DlD2GL9PyCKkaaH8?=
 =?us-ascii?Q?0Jiy9ovlIrSdDLU/fPduM1ZK/iuiyYNr5zQQRft3PezWkj5jA5ZhQS4OqYBo?=
 =?us-ascii?Q?fsAkxE5JLSPne7dProHoR3oZ/xLY46yT+VHMB7OfsRTMBvE/Fgyo3aFkUAsC?=
 =?us-ascii?Q?36AEMNNN3g8G9qUj6y/L3jpZ9LoLNQQeWy8kGyCEL3SG9KEeM7IJdhsOdwcg?=
 =?us-ascii?Q?HqPz/eFZGTOemUMet1+Xux20rgtKG4pX+geEG7OmJbMZhImNaeZSzD6hB3L+?=
 =?us-ascii?Q?FevgNq2Pq8pPO+wvlb82A951+TU4Pxmhu9Kbp0voHdHUgp+Pcdllxc3W+hjn?=
 =?us-ascii?Q?Vq7pAaE8seNI/rBAI9riTzKLSmXXK9+OJS4eKz01lYLdWJW/Ln5at2U4rOZ3?=
 =?us-ascii?Q?1yPi+ZU5/hNZeu9lTdAFQeil3LLCcyDsJNWpOtR3eWKNMVMOiizq+RpOQdtH?=
 =?us-ascii?Q?vGhHxdpZRFyXAba6Ezx3dnDLy3QlJx4VqdJwqBMDNLYX0/L9X5nY9bcfe4BJ?=
 =?us-ascii?Q?p9KKenStOlttJ1bSvEfGMjxXVuB6Qwo4Jjpevb3RrP43FKJifCcv1WoKXDJ+?=
 =?us-ascii?Q?Qiy9Qbz3HoYiOnwZBq5VkJk93csBnN0W/6gFK+jOYOYiGcyRVJTpMgne+wCb?=
 =?us-ascii?Q?Aqlc76G7pXZ+gsllyEBCY0uXr7Jo1YbEgX1iuQrhITFjBNR2x6WvhWC0cfjy?=
 =?us-ascii?Q?TNbqxn0TxHKk7goRqtZSdu35ejR9UWRb1gMYEsBultQ7ixEwX1F7M1nhU5To?=
 =?us-ascii?Q?1u1oRtLmH1p5baYWh1oSfAiIFcuG0QYc+K/Wqm8XMRqe138cr/xfS73U+RzZ?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3add107-0abe-479a-4d49-08dde9f19176
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:09.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZA3ctS55lOUiYCkmllqK3eDDsrXh2yxb0t+2ViYwXM9xdoFA1RpW8AZrqsIjAqqozBUdrwfjU5dzAF7JLFdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17938

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add support for implicit URLs which are defined inside another source
like a version control system (git submodule) or an embedded lock file
(package-lock.json, cargo.lock or go.sum). The implicit URLs are
extracted from the source and thereby only available after the download
of the explicit source. The integration of implicit URLs beside explicit
URLs simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6da75008b..e7bbdac14 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1312,6 +1312,7 @@ class FetchData(object):
         if not self.pswd and "pswd" in self.parm:
             self.pswd =3D self.parm["pswd"]
         self.setup =3D False
+        self.implicit_urls =3D None
=20
         def configure_checksum(checksum_id):
             checksum_plain_name =3D "%ssum" % checksum_id
@@ -1409,6 +1410,11 @@ class FetchData(object):
=20
         return d.getVar("SRCDATE") or d.getVar("DATE")
=20
+    def setup_implicit_urls(self, d):
+        if self.implicit_urls is None:
+            self.setup_localpath(d)
+            self.implicit_urls =3D self.method.implicit_urls(self, d)
+
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
=20
@@ -1727,6 +1733,9 @@ class FetchMethod(object):
         """
         return []
=20
+    def implicit_urls(self, ud, d):
+        return []
+
=20
 class DummyUnpackTracer(object):
     """
@@ -1843,6 +1852,9 @@ class Fetch(object):
             ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
             local.append(ud.localpath)
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                localpath(u)
=20
         for url in self.urls:
             localpath(url)
@@ -1960,6 +1972,16 @@ class Fetch(object):
         for url in urls:
             download(url)
=20
+        def download_implicit(url):
+            ud =3D self._get_urldata(url)
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                download(u)
+                download_implicit(u)
+
+        for url in urls:
+            download_implicit(url)
+
         if checksum_missing_messages:
             logger.error("Missing SRC_URI checksum, please add those to th=
e recipe: \n%s", "\n".join(checksum_missing_messages))
             raise BBFetchException("There was some missing checksums in th=
e recipe")
@@ -2022,6 +2044,12 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                unpack(u)
+            if hasattr(ud.method, "postunpack"):
+                ud.method.postunpack(ud, root, self.d)
+
         for url in urls:
             unpack(url)
=20
@@ -2038,6 +2066,10 @@ class Fetch(object):
         def clean(url):
             ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
+            if os.path.exists(ud.localpath):
+                ud.setup_implicit_urls(self.d)
+                for u in ud.implicit_urls:
+                    clean(u)
=20
             if not ud.localfile and ud.localpath is None:
                 return
@@ -2070,6 +2102,9 @@ class Fetch(object):
             ud =3D self._get_urldata(url)
             urldata.append(ud)
             urldata +=3D ud.method.implicit_urldata(ud, self.d)
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                expand_urldata(u)
=20
         for url in urls:
             expand_urldata(url)
--=20
2.39.5


