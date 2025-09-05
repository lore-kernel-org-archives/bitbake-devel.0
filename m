Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A0CAC580
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:45 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.128])
 by mx.groups.io with SMTP id smtpd.web10.15210.1757054683279460090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=yw0Tzs00;
 spf=pass (domain: weidmueller.com, ip: 52.101.84.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL05VjUhY34erKh7V/TV4OhZsvQauP7EDF1hR8zUPv2wKSGqoGoHV5Bps+6ASE2nxwhjPqjwt5kf/KOvqDdaZUgkDPFC52B2sGeX/+4D5SgXTINGUD9ZwBU3x7lANs7+ebkm1YMSXOgqptIylCcy9TqHN/3nJjq8MA0IUicyT6N7VZHgT/PuFQBN/83Iw6d33dLS4XHqUAqN0uCIOgQ/RYAmylnO0J9Y6Gqr0OsktbXrq+5MqGbu2IqC0fkCfp11olcm+/714/dYZd1vafQIMQ05k1uEuH+SjGEqmTv/sIELADN5/LxEULQMgRiBqQOz2Xj279c5WDzl/QgqGk5w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ3ZRvNfeqJ2KurW15t+l4Q/7a243ILJWk6vHWJxYgg=;
 b=QA9XC2OnMO5IhzYGA76llr8hshJHZsaLvi7mr1AiFNeOBhaAShXTGrAw6O36p6HV/BMHOUrFQ4nI6mRm3cZHfYrQBejOB5l3IvQhy+ULbXr4CNCWmDzb4JcpGH8khGjuG8GRDMwsaX/SvO01r7t8DQfPGouY48kVVZWSIwOlTtnRwTUx+ef8i1IdOrB66pgNUKDjdHPSE62DeRhABVXDWWupjbPTwnDrMZWU3j4PNqHwZRESDeFiWCoxUenbD+zrlWAdyeG03P7m0w8StHQQnNYgC3aTwajaK9ydMlgXFhy408ys9s6I3KQuDeNrttPG2t9IgpcMlNdl0xM8gd9iWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ3ZRvNfeqJ2KurW15t+l4Q/7a243ILJWk6vHWJxYgg=;
 b=yw0Tzs00a8Tyy0Z3NJ1L66aCVPkFAIXMRUnGqNbi4wK4OCMsWfJMYtuTMBHry8Bm2RSehQrGz5ygJBBmk4urWWhwBjRUEQmVeyV0anNY1zEplYL80ODtp9rljcZAbTuRquwZU1ualOdSYYtr1eaujS9kQbVFA0zcrJ5vp3UgKFB0aQWD5Zaf1yLDdk9THMepNu+fTpy6NDfArSk3tQroDvaV6Ro5ToGd8VTJsv983BXeLtYJoViG2fStZYqWNUoSmyMK+TOCwgaa08Kq966Vkv3YjQPZE/9O2F8p5E1+Zf/17zmjK3X4z3pYIXSIOygu7bZNBGlGu9efHh7FC2cI7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:39 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:39 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 5/7] fetch2: add helper to get urldata in Fetch class
Date: Fri,  5 Sep 2025 08:44:17 +0200
Message-ID: <20250905064419.2589111-6-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c91eaca-8308-44d0-7ad7-08ddec47ae97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w60X6NxMazFvHDs8lGMhC7GVgEPIrgUprMEcQPLh+02kdnaI6ovfEVP2q2ue?=
 =?us-ascii?Q?z88LjAgfbxv42p6ZBcCoG9AK/MEtvrZlLWQewDvjavvOzkCQF0vy1UGn0qno?=
 =?us-ascii?Q?Emb8yXgZIMSMFFM1m/nt1gmEvkjzzM8TdiINjbzE/s+jlWMdC+Ak1DAFm2Rk?=
 =?us-ascii?Q?LXHTsOBUOd4F6OV3hEed5Hob07V6j3F/sVeu1ubUfm/Q/3zfounxJV+3CUQ/?=
 =?us-ascii?Q?8THsRo7jjc+YUEyA9VoARf9pA4iISnWsyjtaDxq486YL6Z7Jp7hdh6lfEUx+?=
 =?us-ascii?Q?rSMuqpSVpO5KwqOMFxHhGAbMxAU8P6ocoLXId7sLK5gKcq5fn6aj2QoaoSTJ?=
 =?us-ascii?Q?28u5DwHyKNmf6APwG2R5KO7FodsRQOa5vO1nlGhUhfJ5UEn2w0V93bOHBftP?=
 =?us-ascii?Q?L/2swHkB9o/eVjQUVGeEmMPVdLV1WRUrxWEFHyDFUO97dEEQWEmbgkm9EYY6?=
 =?us-ascii?Q?8/ykS/RnO30CDWOqVW150MQ/gj+hqy9umTo2KHAU2lW9esCOyk1dX2AgWNtx?=
 =?us-ascii?Q?Mw/JCicnUepsc7Vsy8IBM6yODy13NNQ3rkuv0TE6kFm84UYiodOjIrmHhLVJ?=
 =?us-ascii?Q?wk7KviSUvpR7oYVuRZz97buq3LVPzL8Jh+aPo0CDyKOhtI59rBvqU/hO3GTD?=
 =?us-ascii?Q?wx8uZrUUHngmXGLP/ejf1Hei4LFk2FxpJfjGr2ux6o2L5xe2DzOYppK1A7mq?=
 =?us-ascii?Q?H2Zih9+8qmqmRRm6nkZCoMO3C1Fk/0YWjRjywMyPF8xSC5MlLt9rIg/aDbeF?=
 =?us-ascii?Q?ZNE1vmimyMOFG0CLwIqIMQQ1JU8odX9SQ3E1UpplF5wX6VzHwIy8wPOnWQPR?=
 =?us-ascii?Q?JSKGqbltuUPa1CdHKHez/NlfIsmdKyZxNLdt/nge5X5bFF9uS20Q7IN68OMY?=
 =?us-ascii?Q?TQDUFljuPSG1piRTtLqla75/YnjEXJLObPkjVIsGf3uk7eQGFim6tHXe1ail?=
 =?us-ascii?Q?ZiHy+yLBUx0oP60mAajzFBO8EhWh3rDIdkVcXIzKOIgnmHP4IcQObKiXkglJ?=
 =?us-ascii?Q?Q4H12Cp5TS/InpRADVZdtwK6WkR4GeFm6TJo7KAD3F1Ls4Ct0N0r+EkZGJms?=
 =?us-ascii?Q?cWtEl+ucJ/DS7l1HJybA+URq/nG15038kmic9yuIaXoY1aIF1G9tVxUtYmRW?=
 =?us-ascii?Q?pow6byW5NMryfPf05S4PzdV0JLCJebn19ofWpOk4goeb1yBwiFjtFyJAMnUW?=
 =?us-ascii?Q?VPyd6niBmN9sqqnYU6D+k6MmTuCj9v8kHmf7b5OgBIn/VyKM/4a6Q6nxQAt8?=
 =?us-ascii?Q?sKXtSPxpFnu/n6lIQeXKcOVn7nIeNU5wtGwqOcdG/qDKzndN1ri4P94IpJ8g?=
 =?us-ascii?Q?6wVX0ZxBosTo3xJDnGuLZsESJilYy+odip8dXy5ZDOERHe5pHG5Pi+9IT7/Q?=
 =?us-ascii?Q?Erm+zunpo/WKkjbwiK9E8Pq0rj9MXn9pmhQjUH7RoOOaBu0a7ywgIzZQ59tX?=
 =?us-ascii?Q?dqPYWU1Mtkm1qrhfDzxaVUMPzEriMzTK5Wk4ERGvqfp+ZBDdHxT2Dg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uhCilHqfpAaquEXR9n98rn3SD7tCCNfCfNxvIcvqO8rJkJCNT++bfoZp2cAf?=
 =?us-ascii?Q?nMEkydCMnf1C843Zc1LiUIrNq7J0KXAzUCNlN4E6h9IkqDaHyfF3nYANhH7o?=
 =?us-ascii?Q?/3yYz1hPtxtFb1pOFxE4Mh4nFrYE2wXMFCRzsiWSudM2DLygXlJ11Qy4edAt?=
 =?us-ascii?Q?bBRbJFNi2jsWEd/aJRNpvjJB13AIJYk7o/hfBoFwKCNOpK/8IBnmZVvAc6er?=
 =?us-ascii?Q?/abDox4yTojdOlkph+Kk/UtXSQE+J4QhzYmCmzwaXy998RgSq+lRu1nnCY41?=
 =?us-ascii?Q?SEoFYSHGNGm2TmwOlXNkKWIBkKr0lFZNTyTMngqUmoopCTvQLBI1tx2cYqOJ?=
 =?us-ascii?Q?7ODuowT6fYX1zMYOpW264eeoicy0xhyNrFMjIhXKLgusBGvu58MZ72GOSAm9?=
 =?us-ascii?Q?AOYeUpqy8zCJF69LvnXc2hGo5BtkEZzh9iCcKXb25Hn2z3xYxJZvv1yelYJW?=
 =?us-ascii?Q?B7FTqTd/R3MvCxRmRCDcplFkyjozFKL5LdS9w+lZQO2PnKFQ5uJgX9TD+TVQ?=
 =?us-ascii?Q?ys9RHUHjk1Awrc05sq/ivqDZe6Ig4tu2/ldq5EM66VDoLx2tMAlTmeJkWpb7?=
 =?us-ascii?Q?SKaNJcta/LRnbLysz7yisLNUiLVOXFU0Iv/GzW7PRTEYz0DmA+JxyjWI9LKG?=
 =?us-ascii?Q?JYV0fWps9kqQSI1TlVjiFTvDrZXFtv0Z8o3QKkeqQXDT68LGOsbAkeb69j9k?=
 =?us-ascii?Q?tPl7VzetXO+qQDts1iMYj3M8W4kOnSOaZvg0e1hOn0ORgIfa3k7L+W9juc13?=
 =?us-ascii?Q?MjRDSKGv4wVUyKm0IwFR1+CeYgSETk3YWVfqIunxEq2LVuMsW9/aR/EVhR7x?=
 =?us-ascii?Q?EDH1MHAl7p7Hxjnx96Ib/jnbUyntPt83AOt4FyS7uknBSd4RJC+1CgNoci8Y?=
 =?us-ascii?Q?A5ipU2mZTt7H+LayPelndOa5xMmj8Y9LQO8cYKB+QKRJdwf1VTG0KFPXwOZC?=
 =?us-ascii?Q?FiSFQfuwYwvHc5/pFwEBqyBpzQMq8/vCdNijZJj24YCNK0HEhzYjuPphSh55?=
 =?us-ascii?Q?3UxwCf+B45BI5vevp4qjTEaWKVlRHZ5y4VqeUke2ypjVK8hxNX0Ypyc7Aq5s?=
 =?us-ascii?Q?8qUmQcf5FU3ik9YzPSmLjmEakDaljxsGciyqQpPc4/rRw4WCOAawTxdAegAA?=
 =?us-ascii?Q?raHvAWCQJHqY6SctPO2pjjXrN26jRNNSbN1N9zFvOKGdavcEvimVEGEQASyy?=
 =?us-ascii?Q?3UzC2JSE6HL2NVHNIj72Sk1KSRjCEH02chi9yojUU7sfHuqRxDX+TMHUDtHm?=
 =?us-ascii?Q?c5+VZOrJ37t5P0NDapSoZqisi8y6H9XbITp3VCx2pekyXcdrOVyqMJbB1ay6?=
 =?us-ascii?Q?IXPNSTBbcslMkEGCEy7h/QJCGlYRtC86w/nYMEipqizrwOim2yqbHdWPSc/t?=
 =?us-ascii?Q?CAg85AXqrZWpnP+YndbHNhrQU2XXrxXZBCGftMsJ9gHtRipaWFXfwbdyNgM9?=
 =?us-ascii?Q?EPd6K+N/VB2hsx1koCP9/NlyaY+w3Zi+E3zq+tMBHKz13r2zLrrTphNfc+8U?=
 =?us-ascii?Q?HAvZcsxoJ3EeeaNQ5mKXBtiZaGIYW0jvx4wAHLpj9JyBw6HpqlHaiirzeMZw?=
 =?us-ascii?Q?qqcI5J2i+VAf82dMiReNEQnW49ZA4t++k+rAU5Jk+IiArk40w4Rqpv0s8LK6?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c91eaca-8308-44d0-7ad7-08ddec47ae97
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:37.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+Gpfc0BsJjLHvQ7a/tRKKfxWJXAFK+6ngxRNcD3SHMav4eICxMMqnkd3muP3aJdQrbQiGADzpj+ZztqzzkPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17978

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a private helper function to get the urldata object of a given URL.
Create the urldate object if it doesn't exist inside the urldata object
list of the fetch object.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/__init__.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3ff08f817..c4d7cc033 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1829,11 +1829,9 @@ class Fetch(object):
             urldata_cache[key] =3D self.ud
=20
     def localpath(self, url):
-        if url not in self.urls:
-            self.ud[url] =3D FetchData(url, self.d)
-
-        self.ud[url].setup_localpath(self.d)
-        return self.ud[url].localpath
+        ud =3D self._get_urldata(url)
+        ud.setup_localpath(self.d)
+        return ud.localpath
=20
     def localpaths(self):
         """
@@ -1842,7 +1840,7 @@ class Fetch(object):
         local =3D []
=20
         def localpath(url):
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
             local.append(ud.localpath)
=20
@@ -1863,7 +1861,7 @@ class Fetch(object):
=20
         checksum_missing_messages =3D []
         def download(url):
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
             m =3D ud.method
             done =3D False
@@ -1979,7 +1977,7 @@ class Fetch(object):
             urls =3D self.urls
=20
         def checkstatus(url):
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
             m =3D ud.method
             logger.debug("Testing URL %s", url)
@@ -2011,7 +2009,7 @@ class Fetch(object):
         unpack_tracer.start(root, self.ud, self.d)
=20
         def unpack(url):
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
=20
             if ud.lockfile:
@@ -2038,9 +2036,7 @@ class Fetch(object):
             urls =3D self.urls
=20
         def clean(url):
-            if url not in self.ud:
-                self.ud[url] =3D FetchData(url, self.d)
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
=20
             if not ud.localfile and ud.localpath is None:
@@ -2071,7 +2067,7 @@ class Fetch(object):
=20
         urldata =3D []
         def expand_urldata(url):
-            ud =3D self.ud[url]
+            ud =3D self._get_urldata(url)
             urldata.append(ud)
             urldata.extend(ud.method.implicit_urldata(ud, self.d))
=20
@@ -2080,6 +2076,12 @@ class Fetch(object):
=20
         return urldata
=20
+    def _get_urldata(self, url):
+        if url not in self.ud:
+            self.ud[url] =3D FetchData(url, self.d)
+            self.ud[url].unpack_tracer =3D unpack_tracer
+        return self.ud[url]
+
 class FetchConnectionCache(object):
     """
         A class which represents an container for socket connections.
--=20
2.39.5


