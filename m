Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA539CD6E4A
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 08:34:59 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20091.1780389297137930943
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2026 01:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=DPAJM3f2;
 spf=pass (domain: est.tech, ip: 52.101.83.2, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc22ptPJqFeuwA3z2c+mt+ydYVeiEOBuL7hBnF5wAVXxJEPhLU62gs85GKar+UuxBJG9JAAzcrcca6TAuaYZ5fOOCu/KCsbK+KRtYxVXfsHC3Wb+mSmvx87xhkPv6lrcE1YKWmJmCQOTx5xwfy8Vfnec+n5ONYWJuBsrhdMZR33RtXhCsb0jW5hiwHOdZDkxGwzZaaMMeJpErZJR3s73DuOqmarKGN3VNNx9ZdoQ6EgN2AT3tLQY2Muu1vmKwqBWk9Cxvb05imRH9mwPq/3QXpkluoNBHsPbD1asjBHb9f1PZw6iNRUQhyQVOAZ+rgBFkhPFU4zYbVIrHoXLxJ7ikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaD15eQjcQLE7hQxP5R8LeWfeI7EWWPOyC2ns825Inw=;
 b=eBOcDg5cN4xIQqGJdDcafBkFNGRx8asTaz3conxpI40np4CY8kx3QYthdRrLmWsMymMNYWNMHC/4aKqLq5p1qRqTstLVr0/h+sUG0SOtVbgpqHsIwNRUOa8HcdkDz8RHLyUGHihbL+Bwd8e5LA3ihjcoh5dA1raDHGNHh9+2zjmiLksnn6ved9PiKBaV6dwhkXpC+7dxmd8FxJTyuhBumgmAQsOitLsr1EYS7kGGXJr2RK3vT31i4YtVxxfy56wx+5bNaQd1yIYzPm37Zg3FdPQGgTKlOowFyhto9TfftfIQJlMqeK3TSDlnPwNNc25ourXEdf1R4upUog236yXrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaD15eQjcQLE7hQxP5R8LeWfeI7EWWPOyC2ns825Inw=;
 b=DPAJM3f2AoBOOGsSVxBKTHS5ZJjBTRtBnPuh9iGGSLsKHovvDglIKyKjCGT/SbePweQg+bcUExh3TpgifpvVitZolC+Zd2Gf0/tAUNSkEHve2BmNceOSmXWCeNEUnSAmT0trAcgome+no2YS3krD05rTnq5UBeJsDuGytbkBf5XZQszmmj3G55ReAwZCdWc31acEhEysFMnAmG1QJqewbL1i8+typbKWX1voyjjEiR48xWb9im596sP6T8XxpHw44Wn5YJXB8BehgsuQMLAnQanP92aGa+8wp6T8i9hkkk2BC2XquOE7oK7yG6bGhaYZKi6ld3TFDgHd9aVGOZFHpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Tue, 2 Jun 2026 08:34:51 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 08:34:51 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH] fetch2: Unpack RPMs with --no-absolute-filenames
Date: Tue,  2 Jun 2026 10:34:45 +0200
Message-ID: <20260602083445.1378466-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0213.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::19) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaec458-adfb-4d6a-5833-08dec081d07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	kAhFiWV3up3EjgpcqHsAyLyaBCawyspFH7HiqzC/PrvU+0g/untxr42clt5naKIjcXlNCnJnuTEWVSwdmMspNew1GRSzbB2yLMmfvtTOiXTOU/s6SLV0zqbBm+xMKLciYX0/E/HqWrwIWsVjY8hZ2ovg7wA1RgqPG0tL0eJA6wex3jcdN0fX7wv9dLyZR3WaNAnimQn7FW/IeGHEYhXfpOQtx6NOg4rVGyUQzRFdrd3VkP6JJTkbYSLwWjRYYym6YMvxoy4xzHvaBvS9r2DmvTrzZUbGN1SRDI0tcEvUCv5uUeHU17bHAqn7XF01sxqFGkiZflpeIAQM9uY5WvOCwa0m1lNr81ByQAsKdrLb7bfFLRQQZFQKFNEkUo+Hvam1eNPbcBIqofo9HyvArc2NxvnQ+VRPa6VMzhvB0G0Fnw6Rrtp1WZ9XbPgc0uCkX8ybdD/tDgmvPirQP/2GDOV+vJ00fXGzgpHPiamIsiLrvGdqlkW2x1y34UsPYrGqmFMex+Mpf9jXh9fxBwZvbEZTzHxGU9D3F9RLJLzcXYwkvBalBmWjRcvWqqLFXPmB3K2LpdJ8VxqUWn+rtrN6AgGb3Xm7LMPm9QvDLSLN2rNd6IiJJM2NCfeUH57wie5KKP/SpihUhzscj27yDS4IuIrrU1UDaItgkDlJNsnj7LvfVeycBiPEA1zzxT4G4klSW9UG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VbrFCtn9ndJXvanMa/XRax6X10haRKAD6u/BUEQ7E1sKci84C/7pYIhlRugF?=
 =?us-ascii?Q?YFK3qoRJeKCA5R3KzbHqQEXO57XvThPn5/YKqqoagTySvwvtSphrFgc4p+2C?=
 =?us-ascii?Q?vUMPVVC/vVAbqbFH1LvxmN2CM+90TbeMzvrJ5p0bzWBD3gkY/FnMPIbtgz2K?=
 =?us-ascii?Q?JHvtU0TSDmMzWaJH2CMatM2KFQmvx41xTFWK8LQTlnfQy7Lfkn76Ar+lf+eC?=
 =?us-ascii?Q?jrzsTv/hwwyd10ahCfrRsKhpMKZJ2z977aT333N0LrUO9k3KZdOp/TwmAZfK?=
 =?us-ascii?Q?z0ZB9tCkoC03sTMyoHCDzby0IiZg8lMGDaXaQ+LdzUeSxdjV5Guj+myqX5Re?=
 =?us-ascii?Q?qyC0cvEyQtGaNyCWlzbKc1qhsm82biqFQYsm2zv/PYvdowNMIqNXdwSZNS8C?=
 =?us-ascii?Q?9/h7xMgJEkXH4lG9LVQ8t65Y7/gOFmgcDqqFO+8bOOEDIc/zr++Y24GwEwpM?=
 =?us-ascii?Q?bPEh8hsJosqTWGBSWnIUrWQvs12fuDRNR+tAwA2BSfLWsjpDSKpQApvNrAfG?=
 =?us-ascii?Q?qj6G/0sF/My3ipHCjpjErcyi/d107bpue1OF+GQ0B8BKuuoe42otB5L5P6fE?=
 =?us-ascii?Q?KXtxqTV/0O7B5GfqyfgmwJBKwStfOE6b2DfMi1Q5rCtiQ/7XpaiMJCC/NL8f?=
 =?us-ascii?Q?KP21DfbStVJuI6IZmtb5gJoqhvtPgGcmjZHwQNejLreLJjcWN33rqZnFDvrN?=
 =?us-ascii?Q?1ldkvFiqQIJSoOtsVpcJo7BqjV+PnlA3sKLXvFL1m9ZrbcNFSTjr1yXjaK2L?=
 =?us-ascii?Q?pZKU7sUX51t0JDZxZ5bjLPrHSFNC9h/7PEPcgy3XNq37CwBofpViQBh6vx5q?=
 =?us-ascii?Q?Z/7JdcBrjbZLV9MjSnqMrKlNoSOO6XOshP706P10UONlAgMCH1+Ps5ZoD4mY?=
 =?us-ascii?Q?aOpD5lnbe6EYWayXCPJEQF0yrKEISqv+yhXo9sKwxAqyn+dhnYRvUqoCdFvv?=
 =?us-ascii?Q?jRkx9Am7OzEXWuNNUN6GznMl1ljgh0yWNhDFytZc6Y/rfX+JHN1R8caT4t3x?=
 =?us-ascii?Q?BLYPqnJ56gHBOT4dPbryBm7vTklWvOx5FDBs8Fy+n7jl3QNrv9fqH80/FxNC?=
 =?us-ascii?Q?THowxbxX0SlLsF3T+DUDU4BE+1zX0XiyLv9g0Cxokw01tw5V2kfWqgo7Zjog?=
 =?us-ascii?Q?qJDV/7uwLRGwfpdiaOfplK+DDQzZPxTCeKu/j6DczDiyKuzeU57CjOZf3xQw?=
 =?us-ascii?Q?a0e0sjZ8/N+0cTdk/iMnYdZsmvDx6K3qBgEqJQJ4Iy7g8YwMUgOP179O/2Q9?=
 =?us-ascii?Q?RYdEna8sfa3qimXhfWzRNeo77J5YxFZg8dqdl0je3Jt86thEdWFB95eaJNIN?=
 =?us-ascii?Q?ErJvXnCmKLNAl7uoSEzeu4rvh/XnvWTBog5kSd2QFT40hjGreJRo3NtjpNr5?=
 =?us-ascii?Q?G9S2uSaVXpUqZGs5+qquvSPIxRg+9zBbIQJyhDTFJGrk/7OYDL9blSGtSQ85?=
 =?us-ascii?Q?+pYzdfJAakzHkk9n6+OCiBriDdd6eX4c2a11sU0PUXXueR7H8rqgxbBzu76i?=
 =?us-ascii?Q?F3giVvYNz3xe8ZV5NboMqbAKYSlcuZtZDvCcVM8tyrBbM7+8PRUoreIr5ovA?=
 =?us-ascii?Q?QumueBZeWvebTG6ibk7mB8CFlwCbrpkHsPwOT2mwM7S8s5ewKolVrBgBLOKx?=
 =?us-ascii?Q?qruRbaFphaSKqUXWfhD+BnmJw0zY+pyNW/DLXuIjmVQnit8zEE0nYmI0uW4Z?=
 =?us-ascii?Q?1m3FZviGFc3P8hbkKSeSxg7SeS/V28q6zpy/CFa16slNmuCuMUlJmHRyndpj?=
 =?us-ascii?Q?PGqJLNSaDg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaec458-adfb-4d6a-5833-08dec081d07e
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:34:51.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD7h0YpPP7QYmYTboxBdQshbLbI+0dq1oBmk3QZCSaaYzaz1ntVmsbPHXUvf8h9VgELVyGGdxpSL6rcka2KSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1952
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2026 08:34:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19591

Use cpio --no-absolute-filenames when unpacking RPM and SRPM archives so
absolute paths and parent-directory components in cpio member names are
extracted relative to the intended unpack directory.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 564147603..4234c62d0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1592,11 +1592,11 @@ class FetchMethod(object):
             elif file.endswith('.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file =3D urldata.parm.get('extract')
-                    cmd =3D 'rpm2cpio.sh %s | cpio -id %s' % (file, unpack=
_file)
+                    cmd =3D 'rpm2cpio.sh %s | cpio --no-absolute-filenames=
 -id %s' % (file, unpack_file)
                     iterate =3D True
                     iterate_file =3D unpack_file
                 else:
-                    cmd =3D 'rpm2cpio.sh %s | cpio -id' % (file)
+                    cmd =3D 'rpm2cpio.sh %s | cpio --no-absolute-filenames=
 -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 output =3D subprocess.check_output(['ar', '-t', file], pre=
exec_fn=3Dsubprocess_setup)
                 datafile =3D None
--=20
2.34.1


