Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE9CCA100E
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=xKPFBJtG;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jap6TYkeh4vIuLMRrKx86pqYsoFMkxR11bbZvHvr1PoAAqcGlC6sgMVpvl4Oysq0XeiWbg4jzUfQgPx2K45EIsr7o8qvHL1Li3Dvl+VpmUw4ysz6uLA/sTSACMexomfZGirAH6/dZ8kEhZ0ZxPPKVVXtokensCzDNrrJmqUztwYlSeoj8F03zEg33mqe9CqIRBkrCo1wLWZZ1qStw2ji/eW30+BDiaINBRtW0JE7BgpJbi5FGM49nniwhbXGi2M5lyH+dPHZrzmv9bq1SynhOKLZQTuaBAfxsNX6LpR3AKrvH7cBSqbV+bdDSo/2ASwMLnJVGUcmDI0Qu3NFmELd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXc30iOzwHnw1svFcZ+NyNzL3YUsMSzvpacAe+E8W3E=;
 b=zRWbTOhBof0hRNhNqAJpJQ2uEWUdGrnhKA4awzXOksBi0OKBndOGga2VBSzBS65dJ9GZR/rsIai8OnVszR+dcocYAZYguJPv/bmD8aPgKygj0Aq07+Hw5HGhxBCQ9jP+73dJrwkRCsW+QJoW3ovgyxrv2StiUdAcBhrpY9yyCa4FVCSpt4fyAsRg/y438Wps2hYuF7JhAn/YpX1EWGiE8EP3XD2n6f+EnPsBZqIjPnYDjwdV361ApmZgoGiCG1zOYTTYl0YPDNwLp58mjslvR1A1H9zG/e4Juqc8QUX0Z8IKdQTe+BCxjxau9sJ0YeCdtvaZt5Rmxn1e9vFiRI+h3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXc30iOzwHnw1svFcZ+NyNzL3YUsMSzvpacAe+E8W3E=;
 b=xKPFBJtGamr00Au8mhwTCkFYE7UMPsUKYSqwKvmpicLR5xiwAz0dh9mePoODHL+rxqwGgpGTcNa8GaNBjKgQ9TH+9j7enLAAgCb6TQFDmQPDlRM4jwhoUoYjQ9dXjB/zbDeZAXvhKzhtdSm/JRcoTWy78re8cET+2Uh8wEZzyCErUBFXuwvwzvn1wU4ohdcxlUWAT4GgvQfQaEW7s93Rud//3mHr1U1naI7mOpsFxtpyzLLZhKuxUTdhtwr+m7Bjel0rN1OWj2uTToABv9yNWKRgO/taZtrTqF3sxYZjlq4yFK8rWmJzXEia2pg70RSOwF++nYpt+L584FxKHb8nfw==
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
Subject: [RFC PATCH 3/6] fetch2: add helper to get urldata in Fetch class
Date: Tue,  2 Sep 2025 08:55:04 +0200
Message-ID: <20250902065507.35737-4-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84e067bb-026c-4743-6319-08dde9f1912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m2lLxrxovwGv82/2O4mIpG8/F6yNOlcg6Vt148+5v5uEmbkMiFo26X+6Ldve?=
 =?us-ascii?Q?97IsiGKuPW7lFXyXOH+J4fojEZ9yRsWx9rCCc6tSc5zEYeIo9fsXpNyeDmHd?=
 =?us-ascii?Q?Dl98G7iw/mEf2FNDEAaPiuUNISL2APd9fCyqySsTjqZMPZPldYa3gnMpstt4?=
 =?us-ascii?Q?MBnwOn4RzYqzOhseIzFEWKIZy/5/G5aQyj4ReVCcH9sgOvnxTt0A0A3878M6?=
 =?us-ascii?Q?u1Pxzp8E3xbq2UODB5az/MTMnUF4f9O4NJ8GoA/8q/uXpouI9gmyecQvRdE5?=
 =?us-ascii?Q?UHEUXBbPOrVpV5OwsLxX5RqRVoxwYGFbVW9AS0naAUwEg4qA0hcyg9dobxk1?=
 =?us-ascii?Q?sIsXRFlRMKVhsdDO6lznG4JIZnJSlgx2OQ0mLwpPZ6tpv8KwA7LiAaV23pqR?=
 =?us-ascii?Q?nUItnWbJ91xKPDqaoqEW1VC8cNNQ3mKjhUSKqKtcbFsYzYGnzI4KSinyUooV?=
 =?us-ascii?Q?6+ENsGFoDZOdOB/jUFDpwEMBFTclqpP3AYD0f8AH55jAnM8zkKjExUOieirm?=
 =?us-ascii?Q?Iypt+TuhWpZX+pPdxumK87s4MG16OGPWO03VgkhYsgYW/RYvZ0qVaLwQv2GI?=
 =?us-ascii?Q?EHLc46JND5rSroFy1tOdPQ604gX3/mOMXTB605p5SCGWZEt0+9KSzd66jJZV?=
 =?us-ascii?Q?gIBHlrGE0upTycwgzQDzwJreFPS2zIdysuA85BCqmcQCWMM8r7si+mbVtioj?=
 =?us-ascii?Q?CVpBdvKqs+6ORNIlAz8ku7FVVhT4snsfJ8jddwTMFKFRUDjg2NJMFpN9gzNB?=
 =?us-ascii?Q?Ms9SuPy7tR5vU4t++xO6Q2Oqe95Y/nhtMoF7Eyw6Vqp2bV1zDEkowTbdSyju?=
 =?us-ascii?Q?85vD5CbkeJr4mRDgF4eoJxC4Sa/aGm+JKUS3J60ZvGskBL096m/HgLf70lk8?=
 =?us-ascii?Q?1OtL1oeBFQpEXvt8UP4qvZmqjL5NhWhNK+SNy1qtF1o1lH7L/0Oxe8UJumH9?=
 =?us-ascii?Q?unCQQWUCh1arktye2qjJrO53LovIa6y62IvveAWsusA7J4i+GuhYRay09Oze?=
 =?us-ascii?Q?uevdvrrLw2wr+mlPEa2jFFtGuTVX+vFKEXT9YBV/hlvJH1eoDcht9in8acJc?=
 =?us-ascii?Q?zyISWE3EDB0hIfPy+r4x5frxLOP4wkfSCKRasR/ycYkeZjLzPCXOms9kxIJJ?=
 =?us-ascii?Q?vRaExCsWx2wX1NapLNDFWN2F2rRrnSx1WeZTdRxMapHnlsQcDLtVlLdEYYvP?=
 =?us-ascii?Q?ox+XRfgiw8G5v4GCzNTPqeH6FkBYtWJtmXKjk7a5TBK7bn7LVUwfwCif66Vt?=
 =?us-ascii?Q?41jx02nNy3oZw4lrbd/SK5qzaxz4rtfxdH7lAD9Z+wto2TX6wZSyFzIHbY/S?=
 =?us-ascii?Q?jA7DF+hd+G2ScJGeAwm2mucO0DoUYKUWOMnhuMHonDa+++kE5DfFSkcFG9V3?=
 =?us-ascii?Q?nGw5/Lf+JLDlyaxUQikGw7sKQ+snr6eIEiYJVbtiY20RdF5OdX4EX/R5dizG?=
 =?us-ascii?Q?ZFpk96yQ4EfbSu11Dgh/VdKBFu06vNzBXx/emApOpgSJOHCjlwLPgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gg9ahCYwyCoYnTE0xEUqgLnPjZxnHUIl7SDdeF6+/0FChcU6YaoFiQ3fufjh?=
 =?us-ascii?Q?djnFH9+emDVL7RJ0wOu0wYkP9vP9H9SSv0/nLZ6pmZe56F8KQdO+i8EaxJH7?=
 =?us-ascii?Q?HxYep4gFipza09IJMDhlvTVr4PGpj06BJIk9fdqInK9dA5WS8X4542K4p6z5?=
 =?us-ascii?Q?uO9Xj9pMdKH3P5ChR+sam1Jf1YPs7rrD4sfrCkOryT4y5fGTUsr8VOVf55D0?=
 =?us-ascii?Q?HSX35HmfpPvTAjzjItOltiIRWVBPZ5DVM9m/tAYdr8/X7vipy6FSkZmTN3gI?=
 =?us-ascii?Q?7W8XrHLlNp03QwnV2E4/JilnK09ImUjX41IbQqkZfkHd4Ji+Rk9Wtveu3SZC?=
 =?us-ascii?Q?CXxHkuR0tGmzoiEebsYxZdpW64ahpX90WB7m/hjIXamxX+Ya0VvvWDmTzLTX?=
 =?us-ascii?Q?Xuk5h3L7H/bpZqevMS51cj0TAp17YaZLupsypwftbCm+mMMzn1uEl9aj660d?=
 =?us-ascii?Q?L2P2zDG+urbqeUTpYGCN1qlx3tZQMRGy4Peqgo9/HhJclygRi6/WzH5QeiNf?=
 =?us-ascii?Q?aT3zM8zF1N2bfLsyhojgVC6ChEO5Ep91my86rgJJBiXnG3ozpLzZEj5jepu5?=
 =?us-ascii?Q?McLVsbLuxXaYHlSBe7faoGs+ip5dH9qJcY8FpBY+Ahrh6dmft+ducbsvOhaX?=
 =?us-ascii?Q?Ub/5w+Wqd4Gl8QLDwO+M0sOf0womyUdI6EWVzue2mB1xiPnG4hYivi4fEPnv?=
 =?us-ascii?Q?2ON+l3F//Qzw3oqU3bnofUhFey7nD7gYXiG7SlWG9B165yrUDv3JCbg6txw9?=
 =?us-ascii?Q?cSZM3ZA+B7XPp59v6JjU7RtiVNw5OKWL5z3NFuN1IfknbeoSh0ilzJXtC3iM?=
 =?us-ascii?Q?FrvHLGxAOVA5hkxenemr64YxntHvgpp7XZjJ8O8go/I1DrkDVF5nzeMGnKd2?=
 =?us-ascii?Q?I+56/4PKKY6o+3u96Y7QcIinEIQokOcxQ2rmbvTIPEb9DbM2ng9IuaUzoUcY?=
 =?us-ascii?Q?AslA9qB/6PO8cGvn0CMsM1qzvlW9AmOxPRCVCbpoltm40wr5KZDT6Od3A9aG?=
 =?us-ascii?Q?8Z04LOnzvEOwXlA2m4es/LJYHlEMZF9sD40ddy5sTIyT+G53YAbG+qi5Xp4q?=
 =?us-ascii?Q?UvGqj/7cVkFDpcMNyBWDJYnTjkDsXrdCBg+gqxnkMW4M8G5r54vBXHhcMCeu?=
 =?us-ascii?Q?+7UQHYxiaDRl94YWZw01Oh5UWDhoFyTg9ZCusvnS7KynqQK0CB+bHTQ5fScZ?=
 =?us-ascii?Q?zaK77vf/FG5unxFjOnSQfkXoxIAzd4FSu1DV4bTp/2rXxJH5iP6cfZ509UvU?=
 =?us-ascii?Q?87hUdoG4/ULq2CiNXu7L5K+iES8nEo3ca/EQm0RXmgD00cZh/XvhbFUrWs4R?=
 =?us-ascii?Q?V36eGf02AHgnWsVnnw2vwd1BVkjrEfYn/uq6hBdcQX/dOswG5KnBgg6w2lJU?=
 =?us-ascii?Q?nbfpryyqb41YPp12vHdOl46EmF3eiff9QBhIEA0heS3BAOstg0rw3nE9Tqv5?=
 =?us-ascii?Q?GfpKCOXkgpfXmF8z3VnXsd8d1H/+ZSVoSzp8pHaTkuiflWtupgn+ibDb7vzJ?=
 =?us-ascii?Q?+Ygoat8HQktnV9EkD83oBFc1fgSpniC2oL2WRR5q6rA78l3nareqL1E8Qwci?=
 =?us-ascii?Q?9DEptqhu9Ql6kGd4AqrvqdPjWfzxlN9UkuYtj5S6N2hgew2PjedJKUBthIxq?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e067bb-026c-4743-6319-08dde9f1912c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:09.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiKYgeKMw49dCzD2tlUCr4WyZROkMR0FZBvOOVb6sIG9N75W3bJ5AY+LPG1ywSe4er2QjgYYXwcJLy364us5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17940

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a private helper function to get the urldata object of a given URL.
Create the urldate object if it doesn't exist inside the urldata object
list of the fetch object.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 80f1a0c08..6da75008b 100644
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
             urldata +=3D ud.method.implicit_urldata(ud, self.d)
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


