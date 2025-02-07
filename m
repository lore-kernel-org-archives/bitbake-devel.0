Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7071FC021A2
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.101])
 by mx.groups.io with SMTP id smtpd.web10.68438.1738932445099229225
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=2Aevs04w;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgqukmDS5oeBnMDDpIqKlNT4FzmiTIj6Cv44BY2KHb8i1+c0Bhv8WmMpzIrWdHK1GZaa9D5ysJn+9mgnotIEE13Ivp0m04YDIMuv+GZufsKkJWpKvy8KJPywjzkknbxN0zGO3dKTNiRW5Q+b6cRxMIeN1QbgPOjNWWHfdjFLDIYhhIgt6iF6aDnx/HFZSBd33NhGA/i9pfZUE8FmXwFazHvOVQ67WVVID3jP0agTq6aDtgVdah+i1/5+LkFsV6KR2xEZKKeZD+AiUlVy0ueHjdpjrGdxoUY9kC3ubkuoBZt+f+rPLoSgD5eAD4CwCY0JXUo8Yt/Zo40AE0qee76Owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez4FpGCxQ2KAvrXZjcXdx+AwiyuugMQwa+zeyWgelDI=;
 b=keq7K3+iR08vW4wmxQWCnP6k51eLbaJxSVKWZOGAYMqn5pNdCdyD6tbRaGbmfeMLTGu8ByzGBI/CqKBoHFjgkRQRq3QlRjRrQX7+Ow1QUHhmtk5KIkrqPn8i4tZKoFlxgMC3f4vOLlOmJJf7Muzv2Ks7BATUrvaBQfVZbREgx8zo1pHQYb9f6JcVo8Jq5U/v1GtzNjo0M7bqcMb+6ue7RIofmn37mQqfuHl5CG4U0BkQ+avOMwowL6G2L6zAfEwEM9PzVp6UWmG7JUzxPgTM3GxaiBnLLASZlx4Ke5d3WOgHhbge1B/pUOlkW1eqGQm+4PMIGvAM7x+FPrG44ZdZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez4FpGCxQ2KAvrXZjcXdx+AwiyuugMQwa+zeyWgelDI=;
 b=2Aevs04wJ9XdgKaQEERwL90csVyXm+uGImih0PJOx+0Po2/P+Ti3/Fru9qYvAhpQNsE8wXartPEDN88iaH1l5UC/3ZvK04RaeR0Xbris/1uhyQcWEJZPq6SibIhBaCQ/E5sWDglrPDExlY+BkJhFAdoF9s9mv/JV+6FweujvWuNhmTuIACh+5rCtxI6NLjV8ksNF2NtTvMMMLq8caFgEeBf/Rn/l/vhzch8ZMhI5xdfg550t0yHxHL53/7OqDplqQhF7HU47D9l0euE1a3x6N3qPWG1hUzlycaxx0kDSW8OA5NqWXhb6OK7w9iATWFhxQbu0zVkyuZNck53cQhO6TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:17 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 07/13] fetch2: local: use path variable
Date: Fri,  7 Feb 2025 13:46:55 +0100
Message-ID: <20250207124701.14787-7-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: c96b9a69-6648-4c61-1b0c-08dd47758c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/a8QEFeezs1syY7FIQMCcLEVHL5Hx3B7VGuDq0LXkQWhiLT/fnVOoOqiXFtY?=
 =?us-ascii?Q?O7cs1wQwPoPyKb8uSqa6JNaO8RfkuJm0sB1EWFQC3kuNYD+Ydm5p/29YtHyO?=
 =?us-ascii?Q?/hys5Fdn3Ic60/I9pp7CphEpS9RozgEgcqwbNnfY3CHocgblqNTDyeQ3XvDK?=
 =?us-ascii?Q?vZDhCyvTCe+wp15wkQEKXoZVbsuBBt8KzV9wfFerEE0vWEFrUpGNLrPdnPoV?=
 =?us-ascii?Q?BgYq8A4lWeUReqlBg5UIVoZxl5W/VIMnLp+yay1MoYNteYMeApOC9L2z4wOK?=
 =?us-ascii?Q?pndSWRBtoPj5GE5BzTFqqeqKEhoFJzQAnHzWxEfzIVbepMuKfayYWtBfF+tR?=
 =?us-ascii?Q?s1cDT8YQ5lThg/RWK18MjCKQlnp/PyelmKmp9N1hoom0RpAdxfs+h67Rm7+K?=
 =?us-ascii?Q?uw4iqGIuTrj/l42BcaA+gkwwd/jYZKPGtjWrlqvkTIwqs5vZiU0JRq/3iPDF?=
 =?us-ascii?Q?AxrY5uEqFhZk9m7GQJ91TfJV2twUSbw6S8ML+araMbDguDwLwpGPbRs1snxF?=
 =?us-ascii?Q?NmjWswl1soeki5tYzx7v/R9nkw/2lrcuLQLI7d06wnyekipuV3jTpgGyRaaN?=
 =?us-ascii?Q?EdhwGrWZacDUggyfaPnRswkJlzpu6MCy077YIdSoVfyvc4vSYwIu8RrBRrcB?=
 =?us-ascii?Q?3tzKnjYHbODZxjX2SzUBtFdQEcXhf76WGjXeNDZX7vXovIahxENKvdOp2y9h?=
 =?us-ascii?Q?h3AYyqKUdVeoApDvdEx+CLrCCtcPkY4T7ARzfGDLDIr9KGHDPOeK5ZXf9xiQ?=
 =?us-ascii?Q?nYPbwGolH1oqS02FDzVVOzuOkrDCpSVybOOepcTgnvf1hDGjMOZorSDn5MEB?=
 =?us-ascii?Q?w49ezXbNi0bpNSfrXku5DMI/TNn0WdRsG2v0muq9Mybn8LVTm/YJZLXZWUDw?=
 =?us-ascii?Q?JXbr+//FqBN+bzGhZGBycbr9kH8LdbclgEj+E592WjLLLGRxXWyTSzTEpXnR?=
 =?us-ascii?Q?VNgUX/iCkcWnDw8dXP3logIZMa/WgjaPYtk4vGHz9GCJGdQDSqjcaM7mD8p3?=
 =?us-ascii?Q?lZC5TpKO7jbdY5I6tYweeJgI9Vdh09szni550rRuNFGMOSeR38jYFHKXg9+a?=
 =?us-ascii?Q?2cUA1+jXk3a3MmOr6owScQtPJNEWQcZzYGHFYQrvC4yNPSfGBJ7Z2QtVKzO0?=
 =?us-ascii?Q?UieoHhpISNy/zIScVd+Ourv25rfa9Kv2MIYlWZYSJ0i89p3JF+EJ1MG6Eq5m?=
 =?us-ascii?Q?8fYpf9Vcjow7tf6QpoNCc8lk8eQJtkAqdm3Lq+J6d2u1lwkk4HXPVhYGA60S?=
 =?us-ascii?Q?v0iNYuNt9/EX6D34mHHvAnIL2MyBClSWHH/HH85sJDZdcY6iEhoqirs3mUST?=
 =?us-ascii?Q?ijB0qbsqQ1am/8sUBwi+ly4eMT9OVLi7XXcUuLkOB0vGyL6Eybst8Lw0deim?=
 =?us-ascii?Q?SnvyZfbpSeXEfQCfleB0Qy4Ti5/dms5luXpTxAQ4qc2CC5XBsqEQblknrT4B?=
 =?us-ascii?Q?EMiCqPuOY6G0w+KWuLLzS3PwaDZM4g0n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6xBSmOHdQNNEggnYl5nBEHvI9YxE5JGz23tkgDvqeWLQVUR8HWDPVBPE40WZ?=
 =?us-ascii?Q?Kl8KkTQrJ0481VyNu50rhcKpeMAs+7hbsERnWQwa8QLT0zLFwx/e1FzrfYWw?=
 =?us-ascii?Q?atdsYNATkP0RyOX8LTrGFQiB4JZV+a37kvFEKmVdBHyzdjm0yp6PZhe75i27?=
 =?us-ascii?Q?135fcQeQV5J+kRFV2LMrfMEcuECz4QFa8WkcJbacCC8xHLMYWV67cYBTxGB4?=
 =?us-ascii?Q?hjKpT5UiJjHU3kEM/j2yuBUBtcnxq5d7rmIgkR/nsLC9CgujJTsGWeiD7TqZ?=
 =?us-ascii?Q?ANTbCBcHxlR5iBPyg05gJVWHvInHH4c3Xz5424uEVQrnCspYNmBL5d28dRrj?=
 =?us-ascii?Q?SXb8rcMfrpGsrqSR1MWafzcwt2f1UyjPtbhrYUYKEFtYFgOi6QQWpJ1mXoyv?=
 =?us-ascii?Q?1cZKKmnosVfIbuEJwSbTiH7OaGd9ySfXr00Ib1epvKQ+1P1y98jNEnQt+ere?=
 =?us-ascii?Q?CRbqIJpVh6T6GFsJN20mfVd7u+QrrADFwRxmXq5K50n+MDiMcDgVtBHchpVk?=
 =?us-ascii?Q?kvtdzLBRaph1lSGeTc7kYIInzrabkVt02u44XucAqVhCnMvHiDog3OwlsaBg?=
 =?us-ascii?Q?6o/Kw3wb/HFFESJo6/GhhAmTHI0k7AKxXbsRh+YkkY+Owg2vqOmq2chZu7UN?=
 =?us-ascii?Q?kjRO/kTKgWrilEx/8THjqy/X9Rd9ST1Jaf2HdgHiLLS3QD5mCMEB0x3B51ms?=
 =?us-ascii?Q?F5xMjMogAit3OeVefcKPZX3n0vx+1UakIOVAApLB2ayS+O/zxn+pJRVU36s2?=
 =?us-ascii?Q?a2sWpT26RquDhXmPZQfmai0oMe1AsAwoO5pXJjch4k4Ja3v2P0AtfWMZA8IX?=
 =?us-ascii?Q?Q6E0ZUxbE7Nya5UbX5WbiaUxVvcBmneCI0TwXRENtjeH8d2+CM4JId2LFSC1?=
 =?us-ascii?Q?amfS56NURC9h3mCzNLxznB0LzI5CpMDFKDk70U9ijSTY7giyqES7apOBoQoJ?=
 =?us-ascii?Q?YpKaLwOL6ICSQg7F7XQeAagraUd5xxgcbU7NWMYKd9S3q1L0zS+e8hkdS1mY?=
 =?us-ascii?Q?1N5FkP3PNw0Zh9zjV4Ym2nfs2/FobZo6hJcP0jGWPFy1TNpx5XqHV7eZ7V39?=
 =?us-ascii?Q?mQizfTPO3mh32oXicvAhuH2qg6VAbxKo1imE/LhBNQ/tdrbEO3LLN2d9tXC6?=
 =?us-ascii?Q?A8yAlHBIXn1EZabhWyOPTUb81pPsZpKCx+TKgp25y3+HJ0lXInX3BRmcYkL3?=
 =?us-ascii?Q?qDgI/liNUPSd3xiqMJbB1WfB15h2a1SVwYG1FFwxz8gufBzi/fLHWqRSkroA?=
 =?us-ascii?Q?sqqfIy9iEdr5397ogIp4nmDbnRTfA8WpiaJeadI3bxyjXTPywd1Iz8129Tdy?=
 =?us-ascii?Q?7LftR5BckOYBIBSOIpQSqr1o0nvSySUgGcTqGj9pSe/o3F/S8w7lUKuNvu5K?=
 =?us-ascii?Q?xRzWEl631+NjKHi0l+dI5YGpmiC829tpF5VOC4CU5TX9Dj1+9Q7e2YSizliA?=
 =?us-ascii?Q?He0PWcE7bdjDJGgOfyQTwTP4kIg4Ub//oYL8WW5xaHm5bk+SPAoya+djPvAC?=
 =?us-ascii?Q?fBKRWIOV5YFflyCRPPjD3scCpcNbMTKZa7TYXB7vbeu23fa+hlI8E5UNAzLA?=
 =?us-ascii?Q?YCdg02bc4fo7sXkodHeYFhX7whgQTrMiapJzwu8bn8ONojefQwRKkQuERUQ4?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b9a69-6648-4c61-1b0c-08dd47758c9a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:15.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUVcryDm99f3G0hnmyrlS7bJdLD0/YTeNhdkDZl8Pbqa1GLVxn+bjFMko4u0+jWihbSFDz4xAF0Q+GYXBX9aBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17176

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the path variable from the fetch data instead of decoding the path
manually from the plain unexpanded url.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/local.py    | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 628cae023..bd87f18be 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1236,7 +1236,7 @@ def get_checksum_file_list(d):
             found =3D False
             paths =3D ud.method.localfile_searchpaths(ud, d)
             for f in paths:
-                pth =3D ud.decodedurl
+                pth =3D ud.path
                 if os.path.exists(f):
                     found =3D True
                 filelist.append(f + ":" + str(os.path.exists(f)))
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 7d7668110..fda56a564 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -29,11 +29,10 @@ class Local(FetchMethod):
=20
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already l=
ocal!
-        ud.decodedurl =3D urllib.parse.unquote(ud.url.split("://")[1].spli=
t(";")[0])
-        ud.basename =3D os.path.basename(ud.decodedurl)
-        ud.basepath =3D ud.decodedurl
+        ud.basename =3D os.path.basename(ud.path)
+        ud.basepath =3D ud.path
         ud.needdonestamp =3D False
-        if "*" in ud.decodedurl:
+        if "*" in ud.path:
             raise bb.fetch2.ParameterError("file:// urls using globbing ar=
e no longer supported. Please place the files in a directory and reference =
that instead.", ud.url)
         return
=20
@@ -48,7 +47,7 @@ class Local(FetchMethod):
         Return the local filename of a given url assuming a successful fet=
ch.
         """
         searched =3D []
-        path =3D urldata.decodedurl
+        path =3D urldata.path
         newpath =3D path
         if path[0] =3D=3D "/":
             logger.debug2("Using absolute %s" % (path))
--=20
2.39.5


