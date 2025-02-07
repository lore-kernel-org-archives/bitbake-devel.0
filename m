Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC0C0219C
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.129])
 by mx.groups.io with SMTP id smtpd.web11.68552.1738932444338795086
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=XqrehPX5;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh7NPkP3R2iipmEUlRxrgUCyCJ589os3X7sLbYmxG26qyX/NH6UDdSKVIWHCzkLtyKbUKrDStZwIjcGBHccUTTeQJgxzuco/Du+IylaQb4Pacx1EW825wfEX9OGC8fNJgbGkgfCQYHRghaVAwJjmhU3rNxpyhIvUJGtkBWdSEoIgPArGsRzfOd4Ou3CeF4/xLhwAqzZu78H3lNDSy8XblARBwI5QQ4BO720o+2fClh9yBR9MXr74/aBb0YV/9bCovwzLYuPu5hh7IJvk2OMFF7DA8LBpFgyH19OOG4OFjbt8WzPAQfZXns/X4tuzbCKBWhqn5xkcpcbDVbhX3XV7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8MStnRz9o0D7a2oN0qOK6/H9nEajUDEsJRS473t5TQ=;
 b=t5mXuQ7J2QXJ6iUE3i7LN614UvgOCuOeIQ+3/UvQiiOU1OiQJSYwVBfszXxw78hW3cOW5/1hhMaiQ6Z8+IrafDRKVQxd5HTFe1Gsye54//tIInKaJ1l+nGavp1RA20a4xpH6plh2+L/Gm55ea25C7q3uYO440+Qugf1Dj68aE9ziIN5h8w/knTEwSeYhVLZ80ktWRrAB1idch0ICjlOAtdmJ32Yyyg3zlRAJc20GuPAUPCdd7ZYFYDxnYnj2r2K3LpO6YlecDwvYLtYS7PFLRW9ICgYoVuTa9TGS5SHLkhrHwkvAAfuwHX3if1feG7+XkOv3INxQVMIXl+UvjMGcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8MStnRz9o0D7a2oN0qOK6/H9nEajUDEsJRS473t5TQ=;
 b=XqrehPX5d5/zLwZFx+eZCzR1/vxKuhBBmOUWHPkkTWdv307TeRVpqdw1TPlxlEnDuQcQ78DZz3srg6z71LcICW9QUBqwVZxN/TvTAOA/brnLJ6juExnuqkBWvhKaAagcRKlbEHn5d9TIF+p00Lcp6F67hGbUB0MbQ+GMVbq2K+SlJ7v3ogZu4ivKcP7Q+9dHK8AQ6A4nf1YLqVQBishGOeRsCuNo4UycL9wPmf7sxpqrNkDanNBJ26td6hugnE0kowmsfOSxY/EGw3jljZCa0gIO9rfqYQspUJiGM4mzahwRFwKp6NDeZaUeKvfu/ZjSEVNCOkl5jqcjl0Q1ERF3HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:16 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 06/13] fetch2: remove unnecessary expand function calls
Date: Fri,  7 Feb 2025 13:46:54 +0100
Message-ID: <20250207124701.14787-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a941e25-87fb-484a-ef95-08dd47758c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N0Xrmo8dbj8QUDGABiqPaZoY3tSiuqaNigB6sfsl0sYQBFh19DtNBqtaYF3s?=
 =?us-ascii?Q?3w2Sv9SHAQfvM5Q533/v3vNqVlxC5Fg/xVsAx7ECSmFlKyi2fHmP3nVwFa+P?=
 =?us-ascii?Q?LUUvvgwDGo6B9IA/J5tVgCcTd9mRawOa8AfBT+/09JLHP6SUMzeb+tSh8VP+?=
 =?us-ascii?Q?H9jZa31UJjAftTBKijpiHS5/n3UAbSu8y2iOSYFVwzVduEH/Xt6C81M760Ej?=
 =?us-ascii?Q?bxVTamrVKgNQipZBrkg6lUdXQSmxPXhF5eqIKoOqem0H81qGWCmxWWJBjd8E?=
 =?us-ascii?Q?W/3rf+KBr97utTf8EC40vOgd9Zb/8hRe+kNei+rpfxxmvXcecVwEF/ezyIBM?=
 =?us-ascii?Q?zWnjvPxMzkWgj/J1/gOTzS35VvYXkwT2mzMOG3jRIJbKYnc4FZZGMWHRwsO5?=
 =?us-ascii?Q?nozlz5xKWPnI4wtC0o6gDAmi4us33NuW56Ho1U8FDN5am70oNBnAD8RMIynh?=
 =?us-ascii?Q?A+WNYyedMoOBa6T4MpnIwzwDCZmSQFma8LHUpZZ+loohEIy06xpQT6fcjCDe?=
 =?us-ascii?Q?MuKC+iw4PPjAvFz6rgUEz/kQIcoBwU0BQQ/8XhXKlgvUeyJq+4xK9bqM1nuz?=
 =?us-ascii?Q?AAsZlwE3ebPKgL9kQeqadUkdOeRSrEXjqJfbuxhJDbVyW+dQP3HjrPqdPdGc?=
 =?us-ascii?Q?HYXYTkHfxLRo0vVbOcMogR5WbMolLTSPtDeiPnnOr6kLmAT5bs2vPO/InM7g?=
 =?us-ascii?Q?VUOJ+Je7z5uSi65oEwbrBL1bLXtBmWePMwEtPZrMJscLMWdxJCJ2qmQBzKMi?=
 =?us-ascii?Q?IO2JCt0wcWB73a+Nrfd/vF68Kss9JIsK8khAJwBqO8WL5CEZQ1g1yw8AMQ/4?=
 =?us-ascii?Q?WZpKdBvbcrZKsfrSTO6BkqyxYcCkjS+8xzFv0emyKZWNORzdC8G1La3RUceo?=
 =?us-ascii?Q?o1x4Ou6u/pXxVRQACbHqkgu+9dWGaLus/4hkDEpSeP0JoGnJwQqRnUvTsTFr?=
 =?us-ascii?Q?iUM9kj2ZouttLQRN1MEVwfBM06vjzw8uCaABUjwaCwi8kXQEzoPDthHFHljP?=
 =?us-ascii?Q?reHnkQmI61uQ+/gWkd5mYyePNwYi5c4Bz+4LxpvSe+L3AbLaqAMX5iBk/iDG?=
 =?us-ascii?Q?kLN1hQPG2K+c8Bn/7kPtoZcl2wf7q/WfIDEiF8NQv95XrY4C4XsMrTGPuw4N?=
 =?us-ascii?Q?XI5Ewd+/bKo6UZWPLdbzAJZ9Bb2O9tswm0NOa/COQRR+ink4n5J0IfeuxtML?=
 =?us-ascii?Q?7eLVez83NGf2YbUI7TKXSjVLUr5Qrc3XVzYNyYpC8lePQzJB9qJq+sPvAqHR?=
 =?us-ascii?Q?ctVch0aZkiBJGJnu217H0OoxhbImJWhKR63bn8qvBJLYK3qpQAmtgaa2c+oC?=
 =?us-ascii?Q?qN6HfzDxLqM/5z8hXU3TVFgJfemUJ0cVaaXt3Fi22cIc4Qmx86jfyAixHgt4?=
 =?us-ascii?Q?c/YFoauWq5IuokZ/MF0JQC0iEPdW5FKzxs8GbieLVyQJkh1rZ/IMgfzmJvG9?=
 =?us-ascii?Q?+TC8OMUVHvSpImYegwGvWHWz/aG8+sq1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q9B0xCPT0eiKsiVVu7VIN0WPX+1KTvD4vxH6Tpt9BR9VHc4zLvbotkX+CEkc?=
 =?us-ascii?Q?3N3UyQ8Rbddd7JqNxjl4Cpa0FnaH8BB9m6+Srp8+PlkG6/wkxoGhWmW43LBf?=
 =?us-ascii?Q?/GPqVeUofQlIXN/H6jC3t47VWS1xLi4nUNeZKEe/1bTq9u4tkv8neWGrcVEz?=
 =?us-ascii?Q?o8pMdnwKYt4tmyjEBDN2ptdhG1cU2F327neeuTT9H/YaltYTz8SVTgEqDBOv?=
 =?us-ascii?Q?MCWC6Uu8bhDPGoRLrI+Ye07G44M0FURfqCoDOL0ICEenuzhdIqY71PHdyl2Z?=
 =?us-ascii?Q?N0qqcft94+2CpVlOmCNYUGpIydmT7gRxNVKC0Gy7DQsY2GzlIzS2ilBBZfcT?=
 =?us-ascii?Q?g22i+EWh2Y4qkxzyGq3PaX2kkNz5qCexw4D097GGeM7H+etjxf5b+oyKUzef?=
 =?us-ascii?Q?4+5IXhJsDQIcp3bJVmSxokVltiLMCAC+DQdo4G0EC3laE1KqUxJp03dKt++Y?=
 =?us-ascii?Q?Z0R0I696euPe2dGn3u4KqoKDUHOzEtDFumYLIRGOFbp+/+YCoWFlThyfTwKD?=
 =?us-ascii?Q?6GU2vklWWvTio+hENpBuT8F6Z/jwjA4xFdh3qmVzNXblUZmYzkaxqZv0zke8?=
 =?us-ascii?Q?JQogRLtuGQ1RNO+IOjghGrFXbLKaEdW5CEVsFCQaCYE/3TmPoQxVfvuDt77Q?=
 =?us-ascii?Q?8Ixwt+Qawl0WvoOXR7UYT9Y8tVFvXWy1WxyrTh+aispP/pPrPn58H7+Pal1N?=
 =?us-ascii?Q?E/iVJMWQzfj5vj/QGT1RxMRe+KK3kF56vRkw85GLktUzhc1vkVWE+mdM+JIT?=
 =?us-ascii?Q?OB0cp0vL76yrk+TSbKskvOrlI5LY3KxS53wvBypQl9FpJdP/T/WRDaXsguPs?=
 =?us-ascii?Q?1uap8tsM5dZq/JplWDBTD3VjHfuA5xvzjvY1SpmuIaIXbX8u9tlAKlJJ4OyE?=
 =?us-ascii?Q?ZhJfWjwLwiNzxQxj5qu9rqqoqSjNc0YqTEk6vO9//ZysKSjnYnK1by1MU3NQ?=
 =?us-ascii?Q?9OjOQyMZtiGkLcSsYT+Tjis9dAEQZz3zaAkW9zrRWs4VovhLlKXfDOGu20SY?=
 =?us-ascii?Q?GpSbtH4mbiHTGVzWn6kl41++VmPtnGTFiCJAjyTr4Bgw9xD0nWVIFtvdgqIN?=
 =?us-ascii?Q?bQqA2DoWDmetSXb3kvVtlu4Rjm4UujufulNb0tHmwB2bX5syYY/HsMKLoBtC?=
 =?us-ascii?Q?uMllzly6Ek4bMeyNuEWBIqJayQkpK3JXxzExBw9xE/4qpLw/P9O/Z91/Eo8J?=
 =?us-ascii?Q?1kAU+3QMXDQo1Z94JDMsIqgu1Tnb6FC/2ufrMt3MYCSABXexUIg368DdmmTm?=
 =?us-ascii?Q?yljR/YBgVdogUtD3lM2adZAp9VY1NgjwEB8K2RLXhqKBtQu2ySV74Fc8O101?=
 =?us-ascii?Q?gHJ4LWBGYkjmnetnpk1qrjPMBVHb9ejxLDmL3TgjeAS4ZH0/+GL5itMDZz+a?=
 =?us-ascii?Q?hIs/y1CbTFyFTQm5EHmAqlULeWRIw+3VYm3zBBclYoqYdABdIHjmAA4X986h?=
 =?us-ascii?Q?F7AkxTJ5hss7xW0BNHnTpMfCYhCzLkGDK00ZbVLU8DGTk5YKjtxzuja8FJpR?=
 =?us-ascii?Q?aV2Dvnf5LaPZjYIyPZ63KvMrjyCX/ImegkE9B6W9felWAMlalzHchAoxVsQf?=
 =?us-ascii?Q?I1HVKg/LzkTLKm4/xx/ujzS2tRBuhpKYV0zjCfh4HF+PnAO2abJ3crFknRHS?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a941e25-87fb-484a-ef95-08dd47758c5b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:14.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDZI7aYvdcoRKv1hXYiei9ppW6bPPhVp5Z873ghxtqGzojcwjpUg3EtpBIQKkf3zid/Ys4+o7eXsiktvDnaz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17174

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The fetch data class already expands the type, host, path, user, pswd
and parm variables. The fetcher classes already expand the localfile
variable. The getVar function expands the returned string per default.
Remove unnecessary expand function calls to simplify the code.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/fetch2/az.py       | 5 +++--
 lib/bb/fetch2/gcp.py      | 2 +-
 lib/bb/fetch2/npm.py      | 2 +-
 lib/bb/fetch2/s3.py       | 2 +-
 lib/bb/fetch2/sftp.py     | 2 +-
 lib/bb/fetch2/wget.py     | 4 ++--
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2a60e94ed..628cae023 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1147,7 +1147,7 @@ def trusted_network(d, url):
     if bb.utils.to_boolean(d.getVar("BB_NO_NETWORK")):
         return True
=20
-    pkgname =3D d.expand(d.getVar('PN', False))
+    pkgname =3D d.getVar('PN')
     trusted_hosts =3D None
     if pkgname:
         trusted_hosts =3D d.getVarFlag('BB_ALLOWED_NETWORKS', pkgname, Fal=
se)
@@ -1782,7 +1782,7 @@ class Fetch(object):
             self.ud[url] =3D FetchData(url, self.d)
=20
         self.ud[url].setup_localpath(self.d)
-        return self.d.expand(self.ud[url].localpath)
+        return self.ud[url].localpath
=20
     def localpaths(self):
         """
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 3ccc594c2..346124a8b 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -66,11 +66,12 @@ class Az(Wget):
         else:
             azuri =3D '%s%s%s' % ('https://', ud.host, ud.path)
=20
+        dldir =3D d.getVar("DL_DIR")
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again.
-            fetchcmd +=3D d.expand(" -c -P ${DL_DIR} '%s'" % azuri)
+            fetchcmd +=3D " -c -P %s '%s'" % (dldir, azuri)
         else:
-            fetchcmd +=3D d.expand(" -P ${DL_DIR} '%s'" % azuri)
+            fetchcmd +=3D " -P %s '%s'" % (dldir, azuri)
=20
         try:
             self._runwget(ud, d, fetchcmd, False)
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 2ee9ed219..268267b7a 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -46,7 +46,7 @@ class GCP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
     def get_gcp_client(self):
         from google.cloud import storage
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ac76d64cd..c09f05044 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -166,7 +166,7 @@ class Npm(FetchMethod):
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
         if "downloadfilename" in ud.parm:
-            ud.localfile =3D npm_localfile(d.expand(ud.parm["downloadfilen=
ame"]))
+            ud.localfile =3D npm_localfile(ud.parm["downloadfilename"])
         else:
             ud.localfile =3D npm_localfile(ud.package, ud.version)
=20
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 6b8ffd535..fa5292dfd 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -77,7 +77,7 @@ class S3(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 7884cce94..45b6afb4a 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -77,7 +77,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
=20
     def download(self, ud, d):
         """Fetch urls"""
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 198426065..7066d5e2c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -78,9 +78,9 @@ class Wget(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
+        ud.localfile =3D urllib.parse.unquote(ud.basename)
         if not ud.localfile:
-            ud.localfile =3D d.expand(urllib.parse.unquote(ud.host + ud.pa=
th).replace("/", "."))
+            ud.localfile =3D urllib.parse.unquote(ud.host + ud.path).repla=
ce("/", ".")
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
--=20
2.39.5


