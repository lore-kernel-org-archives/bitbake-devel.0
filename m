Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017FC88E73
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:23 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4863.1789411376476842971
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:42:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=VXRT4Puz;
 spf=pass (domain: est.tech, ip: 52.101.83.25, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdJWMPYeXe3LZg0AUAqFNOkOoEmuGSxoAGJz6lz5TRRr/4+W94MkTyuAOJCZbZeIMgiuhooyckN6aA2m5Kl1hlIiPKV3dTw+XosWba6T3zwv0P/v0Jn9eR/V2w+vZ8hyxP+iDElBMPKDC2fJmr0jQhOcGM84ZnhpWgexbcJFd8b0ayTvkUFU4pUOBVjuTetgPuKn17m6lSAFenrFY8TtSWcS/lOPG+/jg9/gQP71J+e8vahBuW8NBfC1wOtOKq5CCHVeO+brzj1fL9CHEdYjq/uxWw5lNWDgWxjOrr03FyQxnHvJw0rjpJN/YysQzxQ77mnKv9mVYFsuqiGdm77veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhPomrdGvIyDh013Cf2KMmhSp27skPjvKFWZZiRnBNQ=;
 b=nY98b1CMf8j3Q63hH7BJorEoYVmCWKdvz2OQE9FQQosvyXuKLhbjFBQF6cXxOYAKkKE0CothAP/TbNcwUMIiJib0lJlhPfF1OeHOP1sPlwchNvTMjh4SRwoiBZYmeS8wVlgcIW1vXSZ3/AXS3J5vf2bHhWy6tA69e10umAM1xi4TkV93LcIUOk8QklK+rw8EGADk3amTiLtbAqW0M2kcllL5fhPGEIy41/i8Vo3hS1AX4ddR+yAzrNoniR+lXccwaNgx15PPGFt2kXOKgbajGTmXfP9ZeWV+J31xtBQxgcu+ZwzzzoxpKzplh2TPCu//EvLGItLsKgrGHjRXY0Q+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhPomrdGvIyDh013Cf2KMmhSp27skPjvKFWZZiRnBNQ=;
 b=VXRT4PuzMw1qGHNI7iA+0Ztr1ydCgoZzEhzrDiPm9TIIP+BXtgrMA3Vs+E/LT7Krwl0k0sIh5HvhEIrgr43sptvenKWPawp/9SeclhyuJMg+Srz0eWwLl2i7VbPsF5Ugt+n9gHVXtocy9YXMOtKIu7dqW6eXg1haf2SHmqnmXDRC5Z/8F1r7knEC80DdasxSkNyUwTPdp3HCzBYrq5zKYJrm/z5+3+jPg5EVLOLwo+g5ujnfas7BJEmL44Y8uQZJsxMO9GY2P/a7QaGP/x8x0piZU+nzJCvq5FSA0pqGDreYu43JGvARkTe64QamX2k94i26uGbxkKJ9IEXYodwACQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:42:54 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:42:54 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:42:22 +0200
Subject: [PATCH v3 1/5] utils: Add landlock_restrict_network function
Message-ID: <20260914-landlock_try2-v3-1-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=2373;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=Zycb63z1kUQGDPk7Mu7fPr7vhKWxpq3CkmmKUmoT4Jw=;
 b=ibuwMfDoTkLC0XY6npZlBrPJCnyzvMyS3BI3DSkxW1m1R7PpGSht6cSaf7L6d9qvcKMnrf9nc
 +8CP0QK/pwBAkO6K6W63C6MGA4pdVsej1xWL1atk1T6Ok7+NAEo6dlM
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::10) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: e12b038c-5742-4075-f7fd-08df128ffcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	+41+e41l+Faym/EDragBX/wxpZwuBvQHWSZ2hOJKUbwVo5mfGikFVGh3Ct3fE6oiS4gTpmhKnETKf1Cv5jxXeP55tpDuJ6GNkjJjRY4PK8uBov7z5BIEGGepI4LYSt8ho1/Y1qEEtdNWeEBSmmHgPCivhTYMDpsHgNw19sHBOZuVrLKvhSOgQGjiQ8NEaFKxEiNMtmyf9UL4OSiPiNWCpdZjh5vGozbaO3C4yTr3RY1X5YTziH3EqnsqG37s9gEA2p5nSpsNcOxlQRaWp+g/okkqIVQqRLCuwUby/sNlqByOxUIIyHuKfleOwXFvVBctU/7m229Tue8HowEtGr0XkxeFgtCgEU0BZ4AGjcUagbuq+wEqJDY76ko2xwjrhxT1khdoxgI9TNkJ52g/bmxGAubpWPVgfBjk1C2HGptYCAWC/bE1B9rXZhmzm+Sk/y0xtgMe4nJtwu/3Jhp7NX1NTgVNIBbsl3NZI/P8DcZuwSmWUgDYc3rGyyQnTCWiNwJQDYZgX2akuV3J+sY+/WPxWsLbfE9LsIHTilCgD6jGwl/dZ4zBQ/aL4SfVosUFdghiWtalpQ3kEk/o4TGuumTgkla4XimdyzoknwSMBGbyErHv9JRwTX/0se/xPmn9TDKlt7G3Wok5swvvj2M7uxEj+aJnMWbp3vuC58DDrq7YdOg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zCaIumT5h5LguTmfO8lJpeWZGH5JxnDQ82/qZXIjrkYYuc1CPM319n2cg8yN?=
 =?us-ascii?Q?bAlcvsKWPlkONHRK38WLfAtgpbaKk8udncpr5OjeLhuxlRoqLGPuZ5/KDxFB?=
 =?us-ascii?Q?eePJh9KHAd9rghKlnfca0HqFrRFSxo+aeZl2dqJoV4iYl9MzbtWRILT37CHU?=
 =?us-ascii?Q?WPcFQvg1sDDH7/dEAwlMT5e/R6ECU2mu4NIRH6GdgdeF1kVC2KVOdQqUgtSZ?=
 =?us-ascii?Q?SA6fqqJifohUyR+TnN14JR3GXuRnMudSniXF8NJA5R9qjvFQJua3DzQHZVJE?=
 =?us-ascii?Q?NXNjmFvxkNhQoH4t80bbrrGcCEygL/12/BodcEExqsbGxQaV/CueE6gL4esN?=
 =?us-ascii?Q?fH7SnCFM7shNL+Rov9YWOlO8wQhAZJpzvNI91TIjKeA0WXKKNvqF5vOoBpoF?=
 =?us-ascii?Q?tktvosuU5CHpTpaegP72xuO7eK5btcOfKKpPRCSVVZBLrlBJysmFRfyZ9CgN?=
 =?us-ascii?Q?12n1TtvlEB6psCXaImJL5eD12vFqG5hyJDbjdLlHQqSxz48UvSPkFIbfdJ+d?=
 =?us-ascii?Q?Od0gK2odGdXMUxhr13Fd//R2TGH9Bq4gHq8ND0FJ+9gh39mIQw98LYuNa35A?=
 =?us-ascii?Q?iXN8qc4vHNaHnADtjODPJxR1iI4r/HY3NvqXh8qVqX8jvLMF5CTfRdbHD8+v?=
 =?us-ascii?Q?mtxAwfvLRyqq2i1TfSUtIGyA7ez+WiTxveSeP+HOaXAcYlfTSJsC1QI2+bqO?=
 =?us-ascii?Q?zkHPvA0V3I+68sScXl0oSfcE7Q7+aLWrv6VGBmCC3SuM6wgVT1bq+q8Zj6cz?=
 =?us-ascii?Q?N7MaSatFcHZG3Err3CrF3SQqx/ZBj9iwrqrttTsxby/OfHuXagWB4yy5cDhK?=
 =?us-ascii?Q?Shox97echxJ+4cbsYs6iLXyceYMbvr4KGLyy4LZt24n6QtuZJuzJxLksgRa6?=
 =?us-ascii?Q?tFW03eCAMf9na8SdEfplgJLYBSOTJdEIrosMCFKaIrd5Pei6SM7f9vMx1KgS?=
 =?us-ascii?Q?y2J8yfq3csraBt0hU840kVp4Mcv53uqd42r+Ig8PMyX6MI0JhGY0sygyJpV3?=
 =?us-ascii?Q?4ASx5JdvYGuSlyS63Zy/BXRWPTAs2F3UiiAyP+IWKcjpQFTjIC+5r8YwwEeo?=
 =?us-ascii?Q?c5PQVk/3Z5t78cSTNFJVcOi3mq+EH5QIe2FdJG26J2cu8zrRO1RP4Wg0txYF?=
 =?us-ascii?Q?tFSOuc+4rzZsapoAJC+2+iJR4fq2MLksBinW3RZxVBIZx3rqv8QBamEP+7c7?=
 =?us-ascii?Q?e8D8+jdrkowCBxs+rT7cFibYsavecE+ZTHVOmv20krWDt6r3mMJfqdjzWmAe?=
 =?us-ascii?Q?isnzGPUhzx1KYlNguF8XQsDD08ehhzA0Ou25XOql5U3DqksU/He97slbZD3L?=
 =?us-ascii?Q?/RZ2RpNzN0RPHWQDomp08ib0A3nOBqbTVKj9EAbeok+N2QvOWE1cpYqt2Qtd?=
 =?us-ascii?Q?I11r/znlneAKVXR6bxgj28Yiq4bMhZ5ufbz7Pcw1ll4tQV219Q+peU+KK1cz?=
 =?us-ascii?Q?WTZYWEcX+Z69hU8mdyIGQsFMGCcwQKF7BDhf0sqO+FL4WKWDyw+shVU+1QX6?=
 =?us-ascii?Q?vTrwgukb54DG9O8b1Fr33xCD/B6QecIpdk1eRlIbeTTDsp+fnBFb9Sr3YLMT?=
 =?us-ascii?Q?yz3JSxwoMMtYJ7pcn5OqHf1fpd+QEMTKZsgPcyAsmBHefNFO/rMAypgoZo1c?=
 =?us-ascii?Q?ZNfLON/2wa2O+i3u4c9buUTXr0ZAsiBViXSrNGqnR3dBozmycZv3JOjzzsgU?=
 =?us-ascii?Q?hipMDWp3Fahqp2RXHzbGv57N3uuBV+VVLLh6OiGrbEQhU4Lb5X5b4qN3Fdv0?=
 =?us-ascii?Q?UtnvwNarlzoFr+Oe0z40IpxnTuXCuJ09mu8dgzkIX4AfKmBlh9f+M8m+teTn?=
X-MS-Exchange-AntiSpam-MessageData-1: vBVjCSdtVMRMghBXYOvBPtH4/K5wJGIsqCc=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e12b038c-5742-4075-f7fd-08df128ffcc6
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:42:54.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nUmkmFH3kG7ghmmoLJMm2LeEsooGhihta1SwrntwJkq+mhMgyZNVq5cd8GjtKF4eIUvGY1S4Ow6ILACS+ZqBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20207

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


