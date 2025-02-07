Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC6C02199
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.129])
 by mx.groups.io with SMTP id smtpd.web11.68552.1738932444338795086
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=leiSyZDx;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyaXcGkZM+OuLcCoEB8nMi00Jok/U1jSDsRhaqJX9YOTDIRP4ELeYz9j3TjQMt3YPFnZp/XNIqe/Ald48py3uxtwMQenNdajQTQeh4PDGhUckmsyg+kgxbadE/RJSkEoh2Na6qxav+VHpyVBQNAAKc/jvvP0ehowYgzbUg+3GHT5X7oFAnENO2UEqIFGDItQ++q8k6wRqcSUVds7IdVTKKNc2aW2AnJKLgDDbBs7oYCpx6JUi090NYV4gtR7xwHzk0mrP7NCW79SPBGwTFEqO8IJgnVLLYkn8ZC0SoE7amZquV7VOEAI/eARuTzmJ44jPHZqeHiFpywhe00I03txKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmv7hksz5Sqvz1EDeLwsF0l2sciZXa/WU57kAW17UzQ=;
 b=zVKzg2qxSS3nGeOtj0V1Um2nS4QV/yldv6iUedKT56DK15fHBWOLSmrPfql8cP/zwE+pO6hRtCN22XTE2NSt4dGpgD0KtT2+qkr+nout7xfAqwCZ68M/iunaykw318c70djCWlAsqlAm+CPeIjKBZ3WNXtXWi4KwjWBP+t4yn09mnZZdKZHVETpfZTU9wNPzcuakcTk8ppt+d9L/ymbN2Tirf9G1HIrkFRduvbz3v+3cJXrPp+6+jqD4o/PaHJUMaUNaBWVbMrzF28F++GT+NYDCV/DF4jbEAP2hHJgZUkf3rGY3oOxCWBIyv/F/Bs6B+oSWVcxR+dlFxQNuFRzAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmv7hksz5Sqvz1EDeLwsF0l2sciZXa/WU57kAW17UzQ=;
 b=leiSyZDxUd2YFHE69rnnhphrE9SBkTVWXBLqk2LEpUHIwuxjXXGtETbX37WJlkpl5Mtv6+CGJ+WJH+guO6wNeuboRmgYpo/HQMa2R+SsKmWjPwaIFiaVBsmo5+mAAErxN/2/Pq3SVeHMjweCAQ3Dg94Ocbkevj53WXcvehSt8R4zmoP58SGe7JPXp3EVmpWserv0MaFjgveIPEE6T1/we/LeqNoIhmeNaQ6XrjdS1e8TQYvXGEBAdKinf41A0xdxETv17X17cVVnp/eyV6pJ3NklZ15t9geGR25Pc/P5eiuXiv75nSvj3OwScXGcXeatytYrkPGnX5B5nsgMQQaSWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:21 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:21 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 13/13] fetch2: use localpath instead of localfile
Date: Fri,  7 Feb 2025 13:47:01 +0100
Message-ID: <20250207124701.14787-13-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42bef2d4-3ba2-4f90-d8f2-08dd47758e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Mt9vQlvrvD0qtflV7KOTw2Gnl3TFy0QSgJ7BfTRnhgwlkAa96l/q0zqIlIK4?=
 =?us-ascii?Q?NuA3NvyHTKoNNOMRs+oa9a597Y1t2igJfwzKtGtJUPdI/RBEQ8AVCaHP92vl?=
 =?us-ascii?Q?V0UPXLmvIb+dSOibvdt8FIq/FigvnI0BH9N3mELoyWEdkdg6k5l6JkP2ZT4y?=
 =?us-ascii?Q?rddEoJciomvr9k+KWA6PlDNAg4GE6eub4WVyYxKfUS3tHOiTpk+19IBrNYTJ?=
 =?us-ascii?Q?ndk5mhsIVZ/7y3KTR7y2YXgo5YhHhLfI/86QJADG6GdjjXoL3lc3SPYMEt1A?=
 =?us-ascii?Q?FYIwIRtlpH3APBFLMp6rTD1KTWqPJF0dh83nIHn8NTaUO5w4pEOXDIS0igQR?=
 =?us-ascii?Q?3XjET4xZDgg9HG9jDOGIBAiAAkrDkzZHfv3t6RYX97gj0JuSGzXUwubmhv1w?=
 =?us-ascii?Q?J4tXpoidQ79jY8i/ZXizFTX7wBm6e8N2oMHWMcMblOggzKj03ev3z+0l8UOf?=
 =?us-ascii?Q?tNn43sqn6w/z2XRYu2DqslGZxxEQZLapYoOhSUzPjRakGNpG/q1OBzg2+ZvM?=
 =?us-ascii?Q?QoVAnjf3+KXfgC+ZKdys0H+LBn+blYVypyMLZ2RfeIf0EwVBQcGp9KCDqKkc?=
 =?us-ascii?Q?NtOKa4j+sEvMdT1tIBMAidHrgj1tVvu+eitK7R+g4bndLOdpcIjg6EDa8t5u?=
 =?us-ascii?Q?DTRH23tc5mRsIZROmHO9TO6+nxDsQIyoDnzduRjeCkYjRyphSWV+VxbzJL0+?=
 =?us-ascii?Q?QXMzQJTz2ZB1E34LE5UZaQ9cGAm7qMEgW9HJNt0ygKdxUuVPr5b2KU2ef1j6?=
 =?us-ascii?Q?KSUtLwfJr/fzvjErX/KKjlv7Trn3zOtNFSek48fLtYihYGMGur9yDKRyczf6?=
 =?us-ascii?Q?ayipq1v/GI+Jg9U3iWJnTMFuLiTVshl/0SM/O5UmsXkUBvFHoW7z1dBrR9iv?=
 =?us-ascii?Q?vfwdBxtii0cmTG07I+to9jAHLew6JmnaO9rOvOMG+s2XuGQ1fhDTjPmcvB6M?=
 =?us-ascii?Q?L8ie5TrGVtwuVPzPiXv9o1j7Y3KVcv7F/mHhHDBFQHVRlav9JMHFZxIzl4h7?=
 =?us-ascii?Q?o/WbKiD1zbc2tFLOlIAQY1K87eP3aRDFhWCaf+FPyob4KY1EBBAO3Jt/soiI?=
 =?us-ascii?Q?z7t8uLiaFicdV65tNYk+26pVOdfHCJgGgvDi5Z9K8Ker2cGxLwXGr7IU0BGw?=
 =?us-ascii?Q?JK50wLAUSVIFuCQguGMkpIEcZNwN4+6Y1BWfOg12rlk4KBWARb7FhZVtTZNo?=
 =?us-ascii?Q?3h0OD9Td6qVO/aBoM8dTv/L72QqZ1tm9AbrsCKcTr1bpHJGsT2oVFuQNI9Em?=
 =?us-ascii?Q?Q6xmip0HZJhnSad+VMbZGvLSunQGqZQzJA6Ezf5pzNJUm5z7+fNTLSwkImWB?=
 =?us-ascii?Q?Yj3Bd4KNF6bBuLLJoW1pdfcH6sa3uvyAuLmT2CHAsFneqLe3fX3wzPFi0sHa?=
 =?us-ascii?Q?dNwaCv3jM6dT6JCWuwXAn8X4Vk+8OVlt8qPkcDovXQZCIV4fT6T2AR57FMRa?=
 =?us-ascii?Q?MyDwAJKYg0I/cMlyEUZdQlI3/bGQpa4s?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SyFx5gJWHzW95/vWopTnFebTJAtCO0H7/2zN+7M8wcYhi+chEuCvM1NkGqi4?=
 =?us-ascii?Q?QCYM0/ticThLZWXF+COHtjUXc1ih8pGtntsqhUDdRh6WRgqt27VyP5Ic/JzR?=
 =?us-ascii?Q?gOTXjYYiuq7p4PBxpVoc9g2j2gDC9Eog7xyctLpLzZzzTUhI/IAuCYj+TWIW?=
 =?us-ascii?Q?I3yvkncbvChR3iGIY5tRWGJhW2QpVdIkF4GCzMLAZoGoV1CDgJNOjV9lsgE4?=
 =?us-ascii?Q?QwD2KQOPmDWLYTPY122ppZXJjsAERxcEw9DfJv+TaOwkR+5ydeeU5SZDzwxr?=
 =?us-ascii?Q?+eWvk8pf7M0F/47MwCOyNlKiKl6Bqs5DEPvVmtHi7YBsCnDbB0+H/3tmWIzq?=
 =?us-ascii?Q?AZX+TPE0/tERvNPYvBdbfFbeN4L3XCpv0h++Db7A2OAq0FAbnDg2oYMPkw5a?=
 =?us-ascii?Q?orcOWEbVqyV8KU03gPKuTPg4obhQEtDt6HCFZ0cBBiF3kKNlyJFwqE5Z9Ade?=
 =?us-ascii?Q?2w82GT8MnmfLncc85O6mue9zTFmy+4aG5tmp+ZgENoctpVXhcBokpRsVHekF?=
 =?us-ascii?Q?HaUncli1atq2BbEoI4UJGZT3BC2eOaoagu23pFMq23XwRppRVsQ2dQzB+ZuB?=
 =?us-ascii?Q?fUvlyhgABzIjTJ1yuavnzBKdwxgH+hwKirRpIXzJi7r6zGbsQ4o5OOb4emH7?=
 =?us-ascii?Q?5RZsGXK3NQ6mZjX3NRFaYjyxDCWmv0Yulud85ogEHJBZkLrgegLa/EiktFLx?=
 =?us-ascii?Q?HJHwdQFMf0YgGlNL0cjnZBUkITootj0bqJArDUAEQgOLWKK+GI1tabDp8Ev4?=
 =?us-ascii?Q?67Gh/RaEjAll5evCBNzPPE6k8MNah/OyOda8I4HsTgapL3PDYvRH+hTMgtr7?=
 =?us-ascii?Q?XYcSqzEzokBF5Ob0YruKBWV3d3Hs6PVpOzZSGjFxuu2VTgbjHUqDY28tfmKH?=
 =?us-ascii?Q?vJRHZkzsyR7KMM3e/56w806YpKOcmJQOSIr56CjhhR24Z2QwwHi6BTavZgyd?=
 =?us-ascii?Q?wQd8joX2OHTI4SSOy0py/l4p68CzNFFssc9BvPtKAA8whB7ksYZutGrBHRQ7?=
 =?us-ascii?Q?Er2QcLk0JswkknORLL6n98Ke67v0DbvBXNTlrKVanF/Kbpm/9OxqmZmJ05Au?=
 =?us-ascii?Q?WRCAXQ8k4kTF9I8IBqqNH8qyeqKxzab5KxAs7DcvvPg2khhsUr85o7uOw76V?=
 =?us-ascii?Q?BMTYmvz/sYldhTzAhqEd+sULDIeLkBCWYHzxEbvjIPu0w2Now1pHLRWtCHoa?=
 =?us-ascii?Q?frp6IPB6kZq6q8m2Wu6nn4rRyqmdSDbO14i6xnFe/ZHDJFtCWJgD+HG80QNr?=
 =?us-ascii?Q?lYQdk415n+Sqhf1Y5UaJr6+Fsr2alfPhiJ33PDBQV7KGZpbUwzIQEV1IJyGK?=
 =?us-ascii?Q?I1eiUJjXCmGoziBr6RoiIc3yI4EO80TK2jtdDojoV/rrGJAZmLN14NYznzPy?=
 =?us-ascii?Q?Z7ES4zAx0J892V4G+1mW1WSnfnGZM2LkDKvijoai1n3v/78od5c3x0MUQsmm?=
 =?us-ascii?Q?tpQ10sGiQUGu2FmI1eLswpu6fvSLIkTR9hN0sW0VW4mDt2RXK4XvtOYxESOB?=
 =?us-ascii?Q?T6Bd8Gghn/gAiKosHsqn9JKt87owMuvy70PoF0yle6lIPBoZ31mEeylFKETH?=
 =?us-ascii?Q?QMJEGW1kgw0P8JQX8ozuBGzGZp74a2ux/WyRb+DsSr2fQJbixK5h6VZGO0LM?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bef2d4-3ba2-4f90-d8f2-08dd47758e8d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:18.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFqj0yJSSLUtIiwkLOAtWGvNXiiDR71iiek0gpBPoIPs3k0e9NxaTThAKklop3oa0av+KGkkDDKl0d7oXJtXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17181

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use localpath variable instead of localfile and DL_DIR variable.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/az.py   | 3 +--
 lib/bb/fetch2/repo.py | 2 +-
 lib/bb/fetch2/sftp.py | 3 +--
 lib/bb/fetch2/wget.py | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..1f0f1337a 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -49,8 +49,7 @@ class Az(Wget):
         fetchcmd =3D self.basecmd + ' --retry-connrefused --waitretry=3D5'
=20
         # We need to provide a localpath to avoid wget using the SAS
-        # ud.localfile either has the downloadfilename or ud.path
-        localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
+        localpath =3D ud.localpath
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd +=3D " -O %s" % shlex.quote(localpath)
=20
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb8149..5c0edf1f2 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -46,7 +46,7 @@ class Repo(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
=20
-        if os.access(os.path.join(d.getVar("DL_DIR"), ud.localfile), os.R_=
OK):
+        if os.access(ud.localpath, os.R_OK):
             logger.debug("%s already exists (or was stashed). Skipping rep=
o init / sync.", ud.localpath)
             return
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 2a2a70a1b..b88dc5a28 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -82,8 +82,7 @@ class SFTP(FetchMethod):
             port =3D '-P %d' % urlo.port
             urlo.port =3D None
=20
-        dldir =3D d.getVar('DL_DIR')
-        lpath =3D os.path.join(dldir, ud.localfile)
+        lpath =3D ud.localpath
=20
         user =3D ''
         if urlo.userinfo:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 161c66bea..1194f0e7a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -95,7 +95,7 @@ class Wget(FetchMethod):
         fetchcmd =3D self.basecmd
=20
         dldir =3D os.path.realpath(d.getVar("DL_DIR"))
-        localpath =3D os.path.join(dldir, ud.localfile) + ".tmp"
+        localpath =3D ud.localpath + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd +=3D " -O %s" % shlex.quote(localpath)
=20
--=20
2.39.5


