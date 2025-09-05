Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E625BCA1015
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.127])
 by mx.groups.io with SMTP id smtpd.web10.15209.1757054681032438910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NMcGXiNL;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFg9Hpugzdq+7tVjz7+0u7U1PZo6IwjWO2wUobtHwUh+6mm8pv5/Y+NePoKPW76yY8dHY7Zl6M2/nc1fTbeuw2Sm4bhOQyTOzEGItULzpcVAY0waPOQPUuZAds/cfnZ2X9fdwcZhNvwNU3XvfT17vsbJoLN11q0qIsHuZBnj1kiYdFzjwuktwQRwIg76ZzHQJw7lFEZMqYpLwwj4H56uT4ZrjDwC779KBngasZ7nIZTAUqQDOEP/4Q8c7L001BbL/JiMVVbkc9ClmDFNUZIhgXLBG4/B++Nmm6Syg0+BQ9Mz1sMoMb7LVGWUMNAZDvZ8GrW2vFaUtwm21t1SJEa64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjATs7rc4SvkhO8UwMhwlj9I+q4D3JdRpeWCSUkITu0=;
 b=HPtzOq+H1unn4Unh3NtLkbB616PMeODEHd6aeJzkznZ6mRCa43GYrHZqf+Tz2ZJmTkBW30QMJic01JAfSpcJmTcLKOOnodLq8gJhfV6X9Z4P/SphidumrrblVJHnm9BP3ErY2CXn2EubSui/+gXhPORVJbL0cqqkj9vP0KjlT2T9G5FjVItE6yC3d1wNT+D0ihK7Z2TmwL1JMbFqijFC960RXGTRi9aUWNP5h9QZ024MiIuTVYo6susgV1NYZinGECveoGMuYUpopXjkQzuQcGUpWw9bHxanlgEUv4pgFBLPWgswP3aPeV+eZz2Lyo5oZYLyndwsJYb36g8rwwy0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjATs7rc4SvkhO8UwMhwlj9I+q4D3JdRpeWCSUkITu0=;
 b=NMcGXiNLYEYDOzUtngk7Q54p8zA8VpacIugbg/xVkvkaRuYIs/W14q2dfksI4TZAtQpK5wsCQkKi2wGYoRvQ8+m6niuhzYNMRiMtf1f/58QMqBnpB6EMyk1m6U25p3wXB1yLq6b5pO3Xft3SxbsW6tjKwDJpQVdNU8UiUvDC5UT9RETXpDwAq2GNA0iWBp0BzY1RzRBP4sX/guWRt4//yB/9vbdV3sdbur027WevTtnHNFzaAZdoA7jWSZtPVp8GYKS5novIGiqAL8kmfi6aq+E/waKw/zCTO9qABLACwXEBinAbGbM3W26x2CTshoyYbqc5aY6U9uswfmHhqoWdXw==
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
Subject: [RFC PATCH v2 3/7] fetch2: rename u to url in Fetch class
Date: Fri,  5 Sep 2025 08:44:15 +0200
Message-ID: <20250905064419.2589111-4-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa471943-7ebc-4c34-940e-08ddec47adeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U4RpIhuJ3eBA4OUrpVX6H2HRB1xwWUoKwiKqAOVu6KLJ9duZCwO4UiohJ/lw?=
 =?us-ascii?Q?RKf+0R9zydQlQWp+jVGsdh3ySufuGBHNmPR8YJKwzwQJIjInVA0thKDB2hpR?=
 =?us-ascii?Q?88xJ5Zvbk3JxV48Ouc5EOpeEMXHv+6889s8O471w55zfkqBu3Vg5AuLH0Uyz?=
 =?us-ascii?Q?3G6ZXCbdWSCP6IUDhZMO61ovoykKP/L46rSF/eNU+kCFR8jwIybssJpvVTYq?=
 =?us-ascii?Q?RPUHe1ADBFLlxh/LuMkT4AsbVoukLCIfEAtYvI8P4bWJ6SxlcD0HclbBf5/q?=
 =?us-ascii?Q?yRhnkFBD9detB9+o0vhtVaktpu2Tbr48qD3cQ8iBrHFGtwd9DCjxOqqCFpk4?=
 =?us-ascii?Q?C4MrEI3pQlbOFf0IFgWjN7Fs7fqajsBN2rN+dWDw2oF7JhIq8jxJhhuw1Axc?=
 =?us-ascii?Q?kRu0I0ESMv6sNAErnLM8oBtnytMkTitkIfpxVo/x4wQ/7DuV6GQd5E42zRuu?=
 =?us-ascii?Q?Eokup8NHPEan/YiuViGJ6r2loe1AjKgiARlVuMeGYVzylSjQKJ4pBZ2izYOu?=
 =?us-ascii?Q?tfzg0WNu0lz7e58GkbtnlZqbBGW5hqpd5s/crkBfCUJEn8ONC7h3eYKUEZFs?=
 =?us-ascii?Q?aCQ6pCZsSuLyNv1bWAtoAfz4Sn2jfEwIoFcPec4+pcxG7WacC/gg58KCg20z?=
 =?us-ascii?Q?3AGMvCF+mBYmN/ZyL0NXeqxmgmFBcP5dsCIQVAgiyWLnk4rvemLUjzbSd2FM?=
 =?us-ascii?Q?qmyK45cwzqj2YBKAmBSjWB4X6p9Pyyj2YBuUqHZrKgPwDNDZ7sgTuRuIjX9/?=
 =?us-ascii?Q?jkausfX7PxZpx4lwSmRAHNE8TySx6B/sTrIVYDxgphqVE7iY8I+yoncX/Z0P?=
 =?us-ascii?Q?owo6sa0DhrJvjp9nVWzfo9a3Kj7ivr9evhtQPKzPSEFsw4bK2vsZyPRwb6Oc?=
 =?us-ascii?Q?teIRzAcbukbe3b1OZP2cb9t6Yj2OLT9MvlF2KqOIOR1N9ZSX/fSJ2h3SP6Vr?=
 =?us-ascii?Q?1crDY7Q/swUTUmDhtLgF3MnUabmHgj8La5CdWODFuvPscK0hlOlbcZ20SGEP?=
 =?us-ascii?Q?2SJDs15X90FyD1NeNjac4uNhDGooXf8Bi+V2ZRDjj1fsZUipBdSuRCYs61c5?=
 =?us-ascii?Q?obu+yuTu8WfhWRrRzR6Gy2PGyO2V2vLLUOvwsPGIKfDfm8Fzf01AfiBcM/hQ?=
 =?us-ascii?Q?f6e67tgaMiaeckxZLmLEu3acvy4gV/ZtlJ1EOnMzvfrGIKffl3haZ1ICd4Q9?=
 =?us-ascii?Q?DE2Hu0zm35NhZadQhpvXhN3rUU32+Ig6o7ZG6NAm9c6/B60fd6/Os8fztrYv?=
 =?us-ascii?Q?C5Pkt1TdaDid20KNbqphoTkJ9ZukhKCjc6wJKGNETzbObaovKwzntcxE8UkX?=
 =?us-ascii?Q?mPaIpAVvpxt8+nFP+v/JyPTqtN9jWB6x9SOOIcsdYsAtTRNL5ZTZacszYwgE?=
 =?us-ascii?Q?e0Mmfk0knHo+kO+1ksxtBBwKLq9DTuS9Lq8aRt8t/kj7q6n2ngszcApsT5UI?=
 =?us-ascii?Q?d4h6EwPUk2/AhSbSbcbd7tg8kWEkUPm5kP9+Ao+KxwDyeYApiaBRXA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9/clZJlvb2C0QJ2bfUwCbzHC5ZOhYHvU/wuZbl7n8kEMsqr4cfQ12BLIU5kg?=
 =?us-ascii?Q?e4NuxQsUSfX79Vz71PUBh3BLiEjwFZNNE5Ha2Q5mY0hTBObYJlHfKLI659Zh?=
 =?us-ascii?Q?AwzIgf3ufJd3aPYjm+KYRcNkmEJcv7STEqpCj2Zp6vV8SW/zPmehp2zUwJdD?=
 =?us-ascii?Q?ThsgF3dgq+1u/e/7fkhH8YkkuRV3NNdbhI9oCON8uvXO2j8s3kc8PwpJonrC?=
 =?us-ascii?Q?ww+mTVlt/oARxkg4OsQOpmWW1lLBGLzxRsa14m0VasVHh3mAtQV5q3GXLzft?=
 =?us-ascii?Q?SY9HQDwK7pVlftp+bThpvud1YBoWui0TlQdsgswkl3IwLGsS+GJmKYiUxXcN?=
 =?us-ascii?Q?u/bCF5mLq1BvIvEw9fL9KdQgaOxdhh5taQMSJb6FhNJG9qv8XOoSD/WDuFAG?=
 =?us-ascii?Q?MmqzQASTv5+botqIyqu/IRxmSeG9uEwbpPnJdIMblhtsfHT7uu6XWeCZxvi4?=
 =?us-ascii?Q?9AolfAyg82cnpz04u3jf22WqzLDGIrz+JnuUNVoVBEptx1oghZ56fxgaZgyD?=
 =?us-ascii?Q?bg02M1F43jfdZIx9gKU1PXm9GE0aSKPIYWh+nSwwGtyg3QWbbZOltB+u8Xaz?=
 =?us-ascii?Q?nUrmvXSHv78K0BGbkaNAy50zX1d3aeO+lAxJwXl2/eNGp7GE6PPXVknEk0Wu?=
 =?us-ascii?Q?1mKTSVMjiqPVQ4yyGBRpiUT+s3Uv7ufAbNwANbuipx9g9HiWCAGd2q0mDgF8?=
 =?us-ascii?Q?VrQu4GJ4H/itrg/yFJ7M8ng/Wy142BeOKKml8LooiDZF18KpMSOcSmMFrINR?=
 =?us-ascii?Q?ferY3EMilyHsTZNgwSCyeciQOysf6ElXbrb/QDVJaQ92UWD9ecQQJdXHqavM?=
 =?us-ascii?Q?YQNdRW8mpYv2Tujbfb00c3Z1cyg78Tjiw/BmmJQbeqIktVzV4F2vo57zBk/D?=
 =?us-ascii?Q?Ej8o33SHnCZ+vi3TIuRVUq6gafYaf/5TsNUuI9+E3Lp09U1n/+94zKhyq5Fu?=
 =?us-ascii?Q?ExijNMwwnTzNo9WHFsT6HF8R0rN9xN5PAHRLNqTJRvZ6WFwVraGeWmkqyG5x?=
 =?us-ascii?Q?k0lO8rdhLEvO0dbTAb9o2lIAf3bl95ohQrJHroFVUFU37ar0VIIyocIc9udP?=
 =?us-ascii?Q?iu80zzDQgZmhsRPa+lQFJTeOQ/klsdNJBZcBABi7r/EyYDstf6mak/QYXkcN?=
 =?us-ascii?Q?5zpkiYzZuV8BwPMdp2DJTH4MpB5c5yPlj2SMKVvAMsN0dBBXWWgxHjMUl+z8?=
 =?us-ascii?Q?ADt9xGcvjKZaFZlg20e5cX9IOu/3IG083iJ1kYqw8ssonh55RjcJzBA91Ha/?=
 =?us-ascii?Q?S9tXai1emYHXUcib3Oeyr04J38v0FTeo1r54emyNkG+/8mWi8MSyrglz2IUW?=
 =?us-ascii?Q?kUJcGLTcJtKQOoJoF3VWR5nDwR9WAHcHIXBCAaaYmWOM0YRuvVdBTjBbTzek?=
 =?us-ascii?Q?dDCkEa65zlbI7t/uavOR4bO7pXX/8EILeLmeXTsFWNlzUNIG3lb5jpcxWdk9?=
 =?us-ascii?Q?PLT8XXZluweC1fF/I7Cea3oW8FfdWSMkkhD86o7r58x4WfTUO/a5qjBnK7Os?=
 =?us-ascii?Q?2/tx/ynQ0uzaNeb1+ZTrbXB8vtZwcMJqNnX0AgUjQWjM2UI8QOoNkqdQYM+G?=
 =?us-ascii?Q?sJwJrZcQ4ZFZHF8Ml4iQNc6Pgs1GlRfStYXnzLjBooNgx0JTWlpZfMoGC9Fe?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa471943-7ebc-4c34-940e-08ddec47adeb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:36.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9UjlO8dEhrLoeHIRwAQ9RdQphqZkXn1P/H+JaKDhgdr/dv4vkjv6ruSYDeQ8B9LtlBm4OEob9gxqnwtD5BUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17975

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Rename the varialbe u to url in the Fetch class to clarify its meaning.
Avoid using short variable names over long ranges and simplify
subsequent changes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

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


