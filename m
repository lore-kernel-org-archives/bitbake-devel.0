Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA69C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:29:43 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4556.1789410124949907937
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=TgS5gCCK;
 spf=pass (domain: est.tech, ip: 52.101.65.30, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4bHRyY3bKUR4lscwBKOdbDnqJ8jTvcSnQi8VvYcceJAtW9O24nfgOfKN6O1tw2PyB9koBemI7xDmvJhCTgC6D8Yc3C6RdhsGuFZprEn57kBVd4qPIdI+MuGRlCfE2tYY8HZvuBSMrONPyrGYXE+S6J18tCrYOmU2ounnh4jLDdtKRDHqlDfSh6avIxu+ApI4YeFweyvzIDv4RvS1nlmTV3MxIHWq6dZUgffCc1KNlfvJY8ZC4giYte9J7/wfiN95dlgJr3wEcYPDoxrBajO5nMVMhxsVpugI0WBurL56Ht5tNqgrJvYs3h8LPDJme9kgG/eGv6nSBErua22gXOCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhPomrdGvIyDh013Cf2KMmhSp27skPjvKFWZZiRnBNQ=;
 b=lryLNloRkfh16gMW6ggOnjigxPqeFfCROgF8FdW19Smnoq9Af0jBGr1iR8t96qYHxN9+a8Ktx78wb9xJURt5XM/oLgRg7eThi9GvuytI3V3ziUanXGJSM5p/cpzJxgx7urkUuBuy/klt/oL9dptZbB56FJEclufHYLo+SfJp8Gt+LLKr1M/rj22qLJnGo1PweQ4nv4DoBik0ZKaL1+zkYvqEMa5HiZKYedtuAzntzKk+v1xKashUj7+FYadNzJC+XiVM/NUN72XS4SdloO+iLxIN/pNLgJ/ShDwq63bpayxFYTQsWHOamD7Befy1MN8BR66sgx5LHvR+f0hsT+SbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhPomrdGvIyDh013Cf2KMmhSp27skPjvKFWZZiRnBNQ=;
 b=TgS5gCCKg+keC5oH/Qk9NRil2gDJJejAXz0Tu1eb3vSrnDg3C0VnQjCLpz6/VwdOSK4fQNggvQjaqt9qkqKyatz3keU0o14QKCEaLKjHm1EmOJ2jF4F4WHMjcT6UHKsqU19jwgLXHm0Mr9BT+8SowtB7lsCDyn6ayrgAIH/gxASy4jUv1P3irNLmeOxVx7CkGCG+KTb5pJvRUA4BXye0EsdlQkKIb0MYMVr+KXLxrcC9cyUhbJlUv8BL3974sjkxZO/zgwDwpFfve2a5kgQWx7sAjdZcoBIwukuLxH+tM+G4/IzOaSR/2ro52R+knltTgmyxwQyVvCJm6M86pCMffA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by AS8P189MB1302.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:03 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:03 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:21:40 +0200
Subject: [PATCH v2 1/5] utils: Add landlock_restrict_network function
Message-ID: <20260914-landlock_try2-v2-1-0a1bad3579ec@est.tech>
References: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
In-Reply-To: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=2373;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=Zycb63z1kUQGDPk7Mu7fPr7vhKWxpq3CkmmKUmoT4Jw=;
 b=LlsS/+OhhuJJarKB9YS89+LhW0gjxCVd4t1SdN/XSVlgPS2VKDOw1nwsTgT68P4dT/uNqdLrd
 l+ni3vSfzrxABWYEv/MBsBgPFiYoRIaaWGybQFhuOxsC59g8ervYnjN
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::12) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|AS8P189MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7a1b8e-870a-463d-6efe-08df128d1388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|6133799003|10063799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ULmJ0dv1NQmcvE4CD6b9Zj4pxDM0JztXNGfJVRdD3Yg3nDAA0BjNZoveTmlXQR99wx6UO8IT7m5aKKSIk77EsIfpQUWJyynL67caORaIvSmDRKj1hIq4ihL/6BNLwGVGKA+FO04ZLrYxoLdW/kB3oYozH31UrkzgRO5a94PF8GySXPW6dRZC/kvYeBgUOShA3ZtyQf/zGZfxn2A8deK4J8z+saoAem+FxMSxTPuzW2H6EUrA7siNSg2DX53QYx2E7R3aYmUh6nfg1FBw4Z7nlko6PrsRWQHKsMZFKZeOAA9IkgudJkh4G5E4Ipf+jnHFpZ/i1fskOF0dQLUQqMONYasUWi4bX+XO6b9usGH2z3uAeEaWHo+syXgHniCd0PaKkvVzrZM7gu5tCWHI1sXFs4G87A02LE8zTHXQPe+A1P1kv/D5M99GdaREenfi6fC/gpNSJAjRz36WvUuA4QgyTvzxHBIqhXtYJvoPQqnC1cuQyvcOX9qR73x5/ytv6xVmLN/QtMmz1docUnZZTVKj3LawF6cvXxWG21Vt1zlo4BwIhxzVWxPzQTYAhdhptUZANa/5emN9+gcICriuIMZo0XJ69qIjOZavZJIcZkH1mlRGj97WHKglY6YR0PP20If5WsbVLtaCSOps1GFJxvPw+L+2/0IvYquZo9y+sPPXLQ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(10063799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JvqLB6rFO5q49Z5bnflc981vCpH7tj5HszVt6+ZKbRXux3RjOL7KnNYXFInA?=
 =?us-ascii?Q?HAipKRFBgBaC0GSd8Rnmpx7lLxRsS83yngEIk7DSnln40ino41/RDm3bKCKP?=
 =?us-ascii?Q?4V5Ee+XlXhkPdfvCgJePGKT552Yjh8Gv3IHc+IltPeXK+XYIPMhdSRieibld?=
 =?us-ascii?Q?i3GmaPbQGeO5Q14XNkpfqTPxtMHWk8bsjDa2wL9ZPB+MP6lQF85Wfxc/Butj?=
 =?us-ascii?Q?sn1zls2FLZLcpcSjHoeScTChH/6zUYspF+zOaRrC/1eSOgd3ZEKCPkq7k1Ic?=
 =?us-ascii?Q?Acia9K+2H93GfEyaIaCL8PMZpr1C76Y+jjwLwjxJsSMHodqTwqTWuuXw2yKx?=
 =?us-ascii?Q?vG1/PjMp0fXPlXiQo8rZJzBKqDoJ1Qs2zDG2xGr/BysgOx7Q5ATljcSa2EcI?=
 =?us-ascii?Q?6zWxOeN1eCRByd/gxApL0Pkrh5RUvQItX3g7rHASIinHWsXfArqSd8A26zNo?=
 =?us-ascii?Q?tBFPkRhmTH9QlEs9eic054oGTw98zbAaoDApWnxipqsS59oCtibgTQTMJeID?=
 =?us-ascii?Q?MT07Ld7I9VTPt2PquQ2nbAZQHpz42ZDK9B18TDkzXeB1zrhS1F6hBymZAWEW?=
 =?us-ascii?Q?Q1eYi36EwslxsrUSbEqi43pqARk1i3DyIkjEDPBqmPyiHe6BsloekbuXl8LX?=
 =?us-ascii?Q?ZNgQqjwrmEGlD9vTwYNoeJ6WloMRS9FOaUqMnIubOBhlgn0Hu8k/xoGzLmE/?=
 =?us-ascii?Q?mZA+TMy2D2k7Iw3ZGIkBtX6RNE2/IZX5Mcb2FkDs5dmyXW7qcVrmvKPNoVSu?=
 =?us-ascii?Q?5b4GWAO8a3Ev5qLkpFt6tFeNS7enmRSpHqJeJddyVmQsz9C6Z8x+v1VQXWtF?=
 =?us-ascii?Q?lzppUnOymcQPq59MCIo7GUbLRnPsWzblG5sN4zU7FaZ5rMMf/oQWvyjtoAWH?=
 =?us-ascii?Q?NtYHCgzhZeMDUp3KSVXA1JXLCje31z7vgPBIF3gZZ0W4W3U/i/NFhywz2t7J?=
 =?us-ascii?Q?uVcPXH4Kq+1hdmpCttH597pm7+zw1oo2pOM/KLNAKk3YN4pN2ECOObiwDC4Q?=
 =?us-ascii?Q?b8V44UVIBH4bWXMzW6g90WCUrH2+xASpOuYYqgZvisYwa/+eWYV0OevjR9+c?=
 =?us-ascii?Q?aAY8L/BVxFB5WqLmp/urRVrmXgRPssh+xO67ptnLPJirp2D4yhQDIKag7SGR?=
 =?us-ascii?Q?uZ+euARA9YGM0pAUBO1CDXHa1/ki8kiaiKQYFM22bfpAisP5SKzOiMMkypXO?=
 =?us-ascii?Q?r9eXpNML5ktzIwHBBqzt1X1uDCGCrJMRRiAUWQ41rVWNBSMLH5qonaY8OTaP?=
 =?us-ascii?Q?ibeko/j+g1Xb5X74IP3opOJsVhGwgoGmiBdvkCQUPfdLEEYTI/xn6BYQg8zM?=
 =?us-ascii?Q?5TgUm/2chp4D3yODkIxjNr+i5tPmaAjze//Q0xajjglH3B+G8gjlRmmTxL7i?=
 =?us-ascii?Q?QJBMUG7XcnJX8dt3EfTjkr2toP06jCfkcReF95Fn+22f3LPZrIprrf0sSF6v?=
 =?us-ascii?Q?XcYHxeQFl24tFBUzqqH42bNAB61ggCOGLzD1MURuH7QUUaOmKMDo79YeKWWq?=
 =?us-ascii?Q?vgDyoKo1XpY/iroG5iYT4vwZ0cIwf2jf9u4Xd+3dvvNpOZNclTtSPdInF796?=
 =?us-ascii?Q?n2OzN8oMoGz9UgYXuMrTG1zGt3YG8UEgldQXmnyTsg6pcB47g7efwxJENIxk?=
 =?us-ascii?Q?e3ycS1HZimjkVEWcIsg92EF/UCdaorXxSFm0OsjMIAgTXThbNYF1QeSIrjGj?=
 =?us-ascii?Q?eIQIwhFrLirMO8oJBTXt8bupiQ5vdw1xQy+N5etioXMl8d+HLwqEGC2eL6M5?=
 =?us-ascii?Q?gKnAtgxMWJ9lBhPHxrrqJhVaVWE/Rj1yXeh1cftJeo7ZW1a8DH1Ybz5TurqW?=
X-MS-Exchange-AntiSpam-MessageData-1: 3HYD/ILUxd7Fj1VCaSKo5AlTO+NxyQcpPN0=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7a1b8e-870a-463d-6efe-08df128d1388
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:03.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/aROJB08ugvbtUqnJkwV6XEko97kPNQyHNYreWwXbW9JzCFhCSXhropCGEAWbCYkrrf1RqDppUWTGQXy+YJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1302
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:29:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20201

Add landlock_restrict_network() which blocks TCP bind/connect using
Landlock LSM (ABI v4+, kernel 6.7+). Designed to stack with the
existing disable_network() namespace isolation, covering the case
where disable_network() is skipped for non-local UIDs.

unpriv landlock requires PR_NO_NEW_PRIVS. Any setcap/uid:ed binaries
will silently execute without additional privileges for tasks.

Gracefully fails on older kernels (ABI < 4).

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 lib/bb/utils.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 7667dee8e..ec6eb2181 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2080,6 +2080,44 @@ def disable_network(uid=3DNone, gid=3DNone):
     with open("/proc/self/gid_map", "w") as f:
         f.write("%s %s 1" % (gid, gid))
=20
+def landlock_restrict_network():
+    """Block TCP bind/connect using Landlock LSM (ABI v4+, kernel 6.7+).
+    Gracefully skipped on older kernels. Stacks with disable_network()."""
+
+    NR_landlock_create_ruleset =3D 444
+    NR_landlock_restrict_self  =3D 446
+
+    LANDLOCK_ACCESS_NET_BIND_TCP    =3D 0x1
+    LANDLOCK_ACCESS_NET_CONNECT_TCP =3D 0x2
+
+    LANDLOCK_CREATE_RULESET_VERSION =3D 1
+
+    PR_SET_NO_NEW_PRIVS =3D 38
+
+    libc =3D ctypes.CDLL('libc.so.6')
+
+    libc.prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
+    abi =3D libc.syscall(NR_landlock_create_ruleset,
+                       0, 0,
+                       LANDLOCK_CREATE_RULESET_VERSION)
+    if abi < 4:
+        logger.debug("System doesn't support disabling network via landloc=
k")
+        return
+
+    net_access =3D LANDLOCK_ACCESS_NET_BIND_TCP | LANDLOCK_ACCESS_NET_CONN=
ECT_TCP
+    attr =3D struct.pack("QQ", 0, net_access)
+    buf =3D ctypes.create_string_buffer(attr)
+    fd =3D libc.syscall(NR_landlock_create_ruleset, buf, len(attr), 0)
+    if fd < 0:
+        logger.debug("Failed to create landlock ruleset for network restri=
ction")
+        return
+
+    r =3D libc.syscall(NR_landlock_restrict_self, fd, 0)
+    if r < 0:
+        logger.debug("Failed to landlock restrict_self")
+
+    os.close(fd)
+
 def export_proxies(d):
     from bb.fetch import get_fetcher_environment
     """ export common proxies variables from datastore to environment """

--=20
2.53.0


