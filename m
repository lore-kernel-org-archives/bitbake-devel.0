Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3096E7719A
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=CpvTifc3;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXkMpLdg8sYEVgSYUY3vXQbBnTIDMuw/DytaEbXWGcFY8Xe3ep5I7jkViprovS0V0dDn2gFn3qnwtcFefg3gw24TCAgsadebAronVWjuj/ZMbUrj2+x1SfrEbhBMl4tTKBUG20hsWjVLvZps8H4o8udAR28P7TdTKd/e9tFgeoqI9gpbDv8w6jlB/JRr7AQKdT4Wqxn56kCokgXjKbaKde79V47w6dedUQByCa7hfX2eSzjbAJyFXm/HE0uQgnCeeMrNIjJrM/rKPVUFxXIucisz0qT0Xafklt+w30F0IIaa6RvilGKfH42kL4CaLL23g/tJjOh4dtPPshx0vKeulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBuSYNeLoQQrMRmg2THzhSs0jVpnuplbbs/jpD8Dqec=;
 b=mjEYMeD4TotwVIWAD6JA/cDAAAJMf91i7C6SEPO5zQCm6/xtCDzgN0Zvbfs0JGzCIYV8RGXhYb7f03V74FmCMqE6AxlSj3iZ6mb5Qu7gxqOYjghauDl9gVLZyDR0WDMN8uevWScyg2gHwaT+uGLqBXXMnyJbNyHeOmnLuJqkmQpE1YKNAqZm+lriz9onnUd4r8JekqUKE6856zkt5MfsmGQxq694AXpdeYKhicYCGaPy8BH7ljbJLpgDg9OqiJmB+3pRu84b19hhpXT3uicUo8E5clP3/ra8SYxxi5jOUJM1zCQWjFCfD9Ke0dMsF5IVSO5H4DYQWiF3NmKZ7EcMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBuSYNeLoQQrMRmg2THzhSs0jVpnuplbbs/jpD8Dqec=;
 b=CpvTifc3kK+E3kyeW3LHpGm+gFF7CmPXoE+njJv2I3636Oq1446ugICdjT/MT3xT1j9n67CJ3ZSRcJEgD6YrlF/LJ7wwY+FCJJUGteD/Drkwl2SzmFzN3BIvS77VptZUZG+Ty3NTc/8zd7qaRZ8gkm8B2SbkJlrXawdXQZHFRkCJWII+ktbmeuf2uk+lmNpcEAeJhhUQ+VXpunYVxV6J82vV/6FrG5toTMDMAUpnCSGWchvv1faFnYiWrU9TsUJEsGwcLlwbpwEj9mGOcVT01fWFTwzDAYALEqJ38uembhVLdz3CdBCXvdnx52/eokgu3ErjAcptprbm1/yM/r/n0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:27 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:27 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 08/21] utils: add Go mod h1 checksum support
Date: Fri, 20 Dec 2024 12:25:59 +0100
Message-ID: <20241220112613.22647-9-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: a039e0fa-2f3e-4292-75db-08dd20e92462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Do62e+HtasyjBSg6X2jQN4zk4TdqCDae99QmxOHSuWXDwV9KIG79qHIqT5ck?=
 =?us-ascii?Q?rMFeZ4RmkPYy6cuieK50rsognzosbSJeAD57Q1fHhItydRERSuEfKYgZnmBU?=
 =?us-ascii?Q?J5nWTtf1AvDjbJVpwhWCaSxuEzgf/NCP9LyrbMA2NCotz06wBmri7PtjpSJ9?=
 =?us-ascii?Q?qu7g989X7HglWQsEUMD6OXaKzXJCMKlOGnDLiPZ+I7IzY3LJk9fEtvCqDHfv?=
 =?us-ascii?Q?3HpmXhQU4HeqWbxiKB6bp3MVvkjkWdfcQ3BM0gG2k87kmZbWihKraPZhPGQU?=
 =?us-ascii?Q?KjeHFwlwY+JqhQdngbNKfxyRIDb/oJFMPafWZKjEr9I/fH6cIi/N9A5EOSNg?=
 =?us-ascii?Q?sZLf9tMkt2OnZ97eRFUNI2S417iWehHLLx/AbW+yne7Pn3ajvy4elzmV0Bnx?=
 =?us-ascii?Q?HQGffRGpKBOfsrAT4MgrAQ2xK0ohAKZ7i8j8b63mEUrtoJbxolubeqZHYbY8?=
 =?us-ascii?Q?G8CZOd5zFBFUd8ep1FgtVl7eMN9BKHwwQfML8/6+ADkFdqo3rr78ha0uEZH5?=
 =?us-ascii?Q?8utEQMIWmuwAVVrpcta1KdblIq+wzKkIb5Sbmnmhl4tXs47g8JFlCX0Q1Uca?=
 =?us-ascii?Q?Xn/zmKqjxNDGDtAKioLKulOBjbNpuKVtQi/o2E7r1rXUY+cwOy1X9a8U5FhP?=
 =?us-ascii?Q?xpci48kroyLUZDc3BOpyDP/NA+i/BL8t5sjM1GouCxWOrXl58OmOgkL2ulHX?=
 =?us-ascii?Q?6RMSe+byOh8a5y4F3Gz0Ko47mGEqZyCVrQvuV18O3y3CkbxRv8NqUz+ipCeM?=
 =?us-ascii?Q?bKcYg4vg0kP1I7nPNK5bbzoQkKR305DDXOkxoJAS7ZPwr6SwIe79/Ml7KM+R?=
 =?us-ascii?Q?8R/T4YybJyYLn0DJkepq8SuOKdahDuO0sQpu+DYvYkzf35KlFwwkwG7dqn24?=
 =?us-ascii?Q?t2FgmNnV+VJaPueNOy0nqKh2eAnle2FbJRKAqDv3AuKdVOOF/Y1FfnPGgU2I?=
 =?us-ascii?Q?wVhYBjkcGqdc/jR5E7+W5F8aZ2/dTVQNKFHA+k2FOSxQAOFIxVIZLgMUT66Q?=
 =?us-ascii?Q?tmQbXCgfYQ/NH3R3kvSTuiwPLwo5fBoeoTg46xiZysd7pYgJ1O8C3j4caC5A?=
 =?us-ascii?Q?0aPZHvQrDLo06JmbLwJ5VhFbuptQJ16OMHo0kLksImrdUL8SiQFZvRHOHRkc?=
 =?us-ascii?Q?ydqS1A6+TPwu/9ZeyO21mbyNa66gSPcKWuuhYBVepBoEWGBQML6xlSH9DCMP?=
 =?us-ascii?Q?KxjZuAhNm/lQWr3XGpstyF+nLBKmqOrD6JDr4et9zjX2O6Un+8Z3IjTsYywH?=
 =?us-ascii?Q?suuvXAZ9B18YyKy8591oTLt1blealg2PE0SVlYPsa9umV2hpFs++Tyfr9cJC?=
 =?us-ascii?Q?erMRNCpjYfnzFlAI8JCETrdk1LE8ZgEqYAGuEHmQfDAy6accnem0QaZ8sl0Z?=
 =?us-ascii?Q?VYUDP5IK9JVhkYCTQGDAdtrCSTiTj0IJeEMKzF3R4sAGfkB6CkEwSxen6MFe?=
 =?us-ascii?Q?0hUL0ZWiytSmGMRTSpunUL4SpUKAJEIe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S1zkspHIswR7MYs1eEWWGpVcUDYdR3aChUTzjLZvajE4gTRvuKOTwrYwWSui?=
 =?us-ascii?Q?Shd7/NkaAy6hj6RKmAMsrbBNft8xILmsNSeXZT9ojho2tR4IxGjdaA/tLQyF?=
 =?us-ascii?Q?E8MYmylAt3dZO9mV7pWNpSmTjFqn7nYXl2Cn3jV9qL5XjbOh1DiMVUUVsJkU?=
 =?us-ascii?Q?Z2y4o8voVMVqd2/UyTCKQK8nm5JCOGDzvNVkuf2i0IPMwTeOaBZ8qcmZSosL?=
 =?us-ascii?Q?8Ks9ewpwIVW7C0kGYPvkqQyB4FiwLqwuaKmdPGdc1QbIOlbpvHqxJxMR8Q1K?=
 =?us-ascii?Q?UGjHlahnDs0YII4tQfFR9nUdTHXedCPwRGE6h/2yULBc/hcPLkSQJTEyBg4E?=
 =?us-ascii?Q?YszyzMUYicWRsxaGZKAJiG9Cl0J0losK2GMg1PjowHw8bs25NJCZtgV/3urc?=
 =?us-ascii?Q?e/fhd/NXPunWRM3C0qcF0m3Dm75o/oZ3cIpuX8Fmz58uhQ9pZFQ2p3/3VAwD?=
 =?us-ascii?Q?LB6BaexxPpBZHIjytNybU2+Yx3jWdDCKH3AICP92XDMS3gksVvarHekYY0v5?=
 =?us-ascii?Q?OMZeBGLAOFtDDq+FbekH5NTZUoOUDxkYFHUu1ACKDWQ1TO/ZvLNyowjWonDd?=
 =?us-ascii?Q?b5tOVsoKkEi7RstQDpl7Sr8KOdMoGTlWDk71XZr0uQjaHI2s8+YukfMRiU92?=
 =?us-ascii?Q?549adAiHV4y3An/8qxphMTtWsIWHBbfEn/4yfz/qQdmF6Oo+hKovMWs8Glib?=
 =?us-ascii?Q?noEq3/3qDf5M+2K/Smr949jeAZJp2Xzrv746pXjCLB11lLw2WRgISfir3wvO?=
 =?us-ascii?Q?cbtaaGF5g2Kxok1n+mvAl/ZIscsoN5aygO61bMT5JqZPym6FnAbk6gLOX+fJ?=
 =?us-ascii?Q?kfScP1R44UToQZxSyoQdxz5T9aDPl0s6/sszngsLtREzt3L+JLHAJd8lNVFi?=
 =?us-ascii?Q?A1P9D7B916EP+47VBSyL01gJaIO+/yiDnTVFalrTWESdlAsOjmeCbuW2Nfsd?=
 =?us-ascii?Q?05B7lOwfYAgMLj7/V1wItNX5Hf/A47wtt7BOtnuMZeihMFFETR76xMFE0Ziv?=
 =?us-ascii?Q?Eu3r8FumY5A5/n7NlXGwyzf2zCHvGR8u4+GDcSiZVFreO2G2IICkzyTU7Hpg?=
 =?us-ascii?Q?zKlD2rNX/IW1VYWBvYiK0EwZnjS6i3sDid/hZXejArW0WYO9oTJ16Hk0q6mj?=
 =?us-ascii?Q?EfqAOn3DNDSCNrK+gDZXNVcKqLOxJeVRO3F9HAeX/oni1FtMmlcBbQA6uQkp?=
 =?us-ascii?Q?pj28jC3qJkl6KKtTyYBzEOAaJI2QecgImkksxLuN8iWDWzoqUH3Gz5WXeKIb?=
 =?us-ascii?Q?xPDES/VNcA0LFeGeKBMTDHevhRWNQXTCR9mQ6VDh97YmavdakzrFIk9KCQXk?=
 =?us-ascii?Q?MIaovvmorShr8hQqZBzQ5xx3o80JMu+/kBml2Ft/owy0kUm9b9mb7DgyDyL3?=
 =?us-ascii?Q?YwpKQ8WxQsZDXHhIPXJAWTShDuxHScZOm+LSMU4do15MRPPttEYDjyukz1S+?=
 =?us-ascii?Q?i1nj9C7FZttGZQHH064rwDPU/a7PznqqtmmwiKhig6pMQdqSUoUXxdu8lr/4?=
 =?us-ascii?Q?HKSKWLujeVYSsJcJ7GaXhy2CV4JzBiQ/4FiEoTvc18MU9K+UTy21bwHqSKS+?=
 =?us-ascii?Q?fWU4IsVh23jPKDjP8csxgNzdCe2vfzAyOmKmwBeJux+DwXjVf1tz+PQoQwHH?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a039e0fa-2f3e-4292-75db-08dd20e92462
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:26.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgNXPaF8llY0iuYvdQuACmEMSuMXD5fxLEQI9g33QR6qvr5d6fH9j3TUkWXh/jN9vKXyERelBGNhGL9vRMuk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16928

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add support for the Go mod h1 hash. The hash is
based on the Go dirhash package. The package
defines hashes over directory trees and is uses
for Go mod files and zip archives.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/utils.py           | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7d8f71b20..0c2d6d73e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -34,7 +34,7 @@ _revisions_cache =3D bb.checksum.RevisionsCache()
=20
 logger =3D logging.getLogger("BitBake.Fetcher")
=20
-CHECKSUM_LIST =3D [ "md5", "sha256", "sha1", "sha384", "sha512" ]
+CHECKSUM_LIST =3D [ "h1", "md5", "sha256", "sha1", "sha384", "sha512" ]
 SHOWN_CHECKSUM_LIST =3D ["sha256"]
=20
 class BBFetchException(Exception):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e722f9113..131766e33 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -585,6 +585,31 @@ def sha512_file(filename):
     import hashlib
     return _hasher(hashlib.sha512(), filename)
=20
+def h1_file(filename):
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


