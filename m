Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C02C0219B
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=IEv62V64;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqKQHfVq+6AUCNbPH36jfQTCdnd1fhpNi6Xx6DFvgq7N+TtVhDG3wymWGBJnPgI9Mt7Tbucrd0SL48lMA0Pymndd0SzJPMqx1Sx1c+eEWq5CUxZtK84BvkXJzPmhAreEqJysFXkO6pIRe3Yed3Lt0WOZgTUTZdzEs5nWGNfNAB3AdySFXkgbHYqPCgyyTdMt2w+ZCyDH89jYgn/41lVptslk9nF1X4VfpHid39r5o/NaTX2mujpn66Je8EpYp8LTHkMq6LDFqnFGT3nT7d+NmhdoPDmlYNfyiJS4GQ35VnkjwTX3tGubnHO6Ee4iwPaa7a7FQzRSZZlSNDTF/3dO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHGAf4v/9lUv8VxKLevKzpCq4/EgJYbnNyC2bDVvC4E=;
 b=IgtHs9K+ravxLKGG8LNNQ8G4cIv8leHmXbElaDfpBfRHMFtH5ryRJQJ1WKmXas7q1NM/jM8ERmIcyGwzSxfLEX4xPHChcZWtRIHhB85VK0wrW0rhtUVsO0xf70IU9KJuMTrcm0m8U+kl5rDtcoUiORh1X/41xWU7eBLD9O/HEBAKd+TLFFZ30lEucLrlLUJAIB3MUCtMKOlWbpNfl2XgnZFVcr3VpzZRJ7ZM+dlcjNhQFc1IGComcYoZapR6ogHn0tno/FvyOHVt9yU61lVgtyVe6NRky3OJiTW6yVSFUBCI5nyaqc7s/h+r9hQhP71uy+SaEeiGBN7BWwcw+k/9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHGAf4v/9lUv8VxKLevKzpCq4/EgJYbnNyC2bDVvC4E=;
 b=IEv62V64OSMx2QNJFGtB3BtfLg2ifRFNLf7UIWyRYlunSN/H3Ibt3JDM8mng/pPce6lZySbvUN0ZAJgvxdFKJ4HDHJH2ZAn5cZkY8l4Y9Qv6dsGF99ThAdpHy0V6cXm8zwO3gl/wTNEugmzsq/XXFsBP7X4yJy92wgoLt0ECV8VtNGJ4RpsxL9uNSWCF9a9wfMU7o0eZ4jErW7jQi30cHAJFXDdvTEAqxWLzArD/RybJhvm1fnHoHLDzFKNWWzT42WVve+B2aLcWNFh4jUBE8ZwzNxAf/h7Nb4B6fxed46nmgZVngncnJEDTPpl5J9lC1KOfSzjdGtwE2JcpI/95nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:52 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:52 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 06/15] fetch2: remove basepath from FetchData
Date: Wed,  5 Feb 2025 08:15:29 +0100
Message-ID: <20250205071538.2681-7-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e15bd7-d4f7-4c2d-2162-08dd45b4ec9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cxfVswzmIuYMDlJHFeeTk2P6fGYVq5UXuzRNknRuY1IMJUamIeghAVWeHEgV?=
 =?us-ascii?Q?Pd4H2lh0pSTXxHVky5HTUg929ytFVfzWGYUEqHM7vxvDuXywnH6VlvTYTzpd?=
 =?us-ascii?Q?B7aOAqPK9WWTeG6NNwfUtXtc5qF6R8+tI3pFlx+p/cKsK9PwSzVE2B8LjWWl?=
 =?us-ascii?Q?3ogMt/snonjPYiNLuUy/U/iO6nlqU4H9KjQtT6/bTjfESZYUJkJVQSX1rGNz?=
 =?us-ascii?Q?Va/hykaWMoH9gA0BSwaiU35kJW11CJZUZPyXmWR8R3jpJLxdT0xFSHzmntt3?=
 =?us-ascii?Q?AvT8zz9SrRWV9NriFHs1Qd6qlm7O+pb7EdAFWYbbdgrRvtmSRqmT1YFdVQLa?=
 =?us-ascii?Q?nr3wYZ2mHcBPMkOupGufpEvPVervT6DLX/M1599JwZalHCOBIUHLjhAyGtin?=
 =?us-ascii?Q?1ZLSX3KZ34hMUWlWrpJKDMQvbcnd3zcXqbd4KpWffgdjrc+a8NeJVb0g9pGl?=
 =?us-ascii?Q?k2zV8xFXOw0meZ+LpMkRE++kRjFbm2+2hc3oxRl4K3vE9kRefxosxWVqKXOm?=
 =?us-ascii?Q?dY6QEGz2Um9je6xy+hDNGekFx+tpx0ldEHSzX2xkpVKqMtglqDXlZdDs7gSE?=
 =?us-ascii?Q?cK4Hp7ZMbpN6wfSSxi6Q2sDs6/cxrpu9uMY8PDaoybVxhar8o23+uAVPfOzH?=
 =?us-ascii?Q?cuVqyHBXMpnqXv8UvJptJPuKrr1SUrPFToISHby/OzI0BF1wODZgBCd/PP4i?=
 =?us-ascii?Q?qnHgvmTlfBGmcADhg2Jq+twZxkyIl7h+vI1Dm4+qcWGvvmhJY0LT9UVeEzM6?=
 =?us-ascii?Q?qfLO3hg7wkyFroDdCI32qNrL4bVGissjHXWcPLGeU6JsD8mJ+pSAVUBs28ma?=
 =?us-ascii?Q?T1sygxsEIkMWXj3aK5LCb5/mzLbRF6sThoIrkn7sqnTwxO/Az95cFHElwcMp?=
 =?us-ascii?Q?NcLhrQRokrp/4N5b91z97ZVkIUdo9CslnXkn8Zu2UvgHs5ZHM0BVPLJCEuHS?=
 =?us-ascii?Q?oZ6+16V2ZDrsXktp/gFEAR45gxKUbnvXGOt+TrSdI33Jt09VToG/4jNUvuIy?=
 =?us-ascii?Q?buQJF2icSxP2jA/ZVfNQPcuchIvXeWNmfG3UHEN+mVCA2ElYJKOIG4h1NI3D?=
 =?us-ascii?Q?dBSnJfsSbN60Y2yTnglAp6asNtbhuDJL6Nt5xMLyeEp7Z3PSJm9CjVD575rj?=
 =?us-ascii?Q?E9xmNB7fxp057Wyt2ulf+PQRl6b+0XOvCoI8jBU2WCAQjUhz3eKopl9Xcxrl?=
 =?us-ascii?Q?c8uxGj387AHd02Y/7Ylofw3ocaVkmC99qTCtQ9Ct7hZ3eGmCCoazYW+tsTDN?=
 =?us-ascii?Q?jGKFsEzqIYYJwkb7jjcqkp0OaA2WeObvlx5wkJT/OfuH4KTJ3H7B6CBv1sLq?=
 =?us-ascii?Q?IEf+ifYCPi+LymrCqxRrf5UAtSSpCN3ZLaBnnV4Z64OLtZ8gSdCMvC0zLQFI?=
 =?us-ascii?Q?pRQMmBK0v3k4/ixIgLCZc69ZTgQ2qGkqXO3qpO6Wmm86CRm6y1HjNiAXqLtd?=
 =?us-ascii?Q?PJS2r8AG0bT1FRPsPR+5Y2dGERv1qJm7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BnGc3xbQpGiQ3UqL0NecmjyAWdGRZEj74ANp7zCb/ynVdwp/l1u8VaFteKU6?=
 =?us-ascii?Q?9BkCdrTOv1A72c0jf3zjqC064+kYQOaaR8r5YdYFLyNh8J6vcr28zBVoDNP9?=
 =?us-ascii?Q?NY/H7EPrJsq6Ox+vgl1a9E0I3EC9FAZbyqLYJwcnaFwd6tNNVYgjpx/wMhMp?=
 =?us-ascii?Q?BSNUAqdJjI3HWN14ALoYhirXDjQIltSeK3HTr1q5qcH2KASmwQF6hnyBcopo?=
 =?us-ascii?Q?MWM8j28yS3c/RMl1d4Dtxm/pgzTwZkpZcpreNTVYzZHx+wmq24VIKW5wk8jz?=
 =?us-ascii?Q?9biZ9s/q4BC3pFzNIruOPErTTbzwxAT0BBgin8XOmCw2Ih/+Xz+EF8+dnF1Y?=
 =?us-ascii?Q?anp3RL3FslfNpn9zhfn7SyomwAkGTrN9YaGr0jDR3XrOJGpbUScVjKPqu2YT?=
 =?us-ascii?Q?HZ9u+Bw8++jCtzvVYIp03wnO8u6M6tf/QqI0UKo92wbpnCI917fF2uw5VzQz?=
 =?us-ascii?Q?9H4OPZysYKx7QAHu8hWdQkbW6INs0w/nG+lj6yfKV7ejrwxUQaZ9qfl9vmMi?=
 =?us-ascii?Q?3eoAmn8Qb6lP5hrLp/21YpwPREXvDDUJ/5cqPTVOcRF2kyrfzvoXCDC2bTVC?=
 =?us-ascii?Q?m0TZO3+BNskAWp+upO+bYYJD7mG5YTkjoGZBL4kLQJ6CUoiW/vk8qSAgf3xx?=
 =?us-ascii?Q?MNucB9HqOZCdGmxqGKpHA0zV5ndTU3cAzSU1E7LD5cuL3kJ0FdL07zVcG4nd?=
 =?us-ascii?Q?35cBbPOJxiYuBzM2WtdP9aZVxV0yQsdpXfbC2m0rfaHUcD1yQbNq226sJCC8?=
 =?us-ascii?Q?5ot/R5S/qu2+M81cZQN1B5FYudPUhRk3nwl06SXuUBam/oNWVcKUykDLghvA?=
 =?us-ascii?Q?75rveaVP+xDN5Y31RnknjbBwuMP9HfOAmvZeuArEz8sIV+008cLwn3lNzAOB?=
 =?us-ascii?Q?+k5u+1dk56jle2PeTlUONcn8msulQjdIc3fBGv2He1S/5GX6sMPnliPQ4ero?=
 =?us-ascii?Q?zy4qJwYPT3R8Syk5c+vOoTVO3zq6DjxWsquO7tvAf8BspczCCShAZp1/XpUC?=
 =?us-ascii?Q?nlw48GmsVZRpD0igJo1rWMOJ5SS8LVp4dveGhkXfUgJdaNXIQd+m3FzcK1DV?=
 =?us-ascii?Q?bQgFCRXU/3AqvSLz6h6b3SU0nttBYUQ2Eiw7zHe7KafOcrRQIatqya3vzIbC?=
 =?us-ascii?Q?vDciqRSssX/QSiNewOsamheHJikqsRvHJa2MaOSDiV6N77cOFTsbglLR5ZW6?=
 =?us-ascii?Q?r7mPeqa/zKm+TKXEh5+YQ3nk0qfJIylNmri0x4Nw35rQ1MlrDuFpCU+kHwFy?=
 =?us-ascii?Q?S7RUKIAy5UOE+copRfZZbSWU+E4DNHmaTEr0A0NWmv1L2XyZiOYI6pvyp095?=
 =?us-ascii?Q?P25xPVM9F1pe83YaRZPQHyTKpUq4QPUh40y5HyjXWlrmxZWnOfvk9dDn3tmz?=
 =?us-ascii?Q?ZocFavdhAaQ11LO/+aFGCfE0Xp30QoZVY5PdJ+IpC+bivWlcDVMOnrmCerbV?=
 =?us-ascii?Q?w8EUF+SZHdSc4S0OU20+/I34vtQmIHUgP0Ro3eAh7o8zOF60GKuvb8MYOgdF?=
 =?us-ascii?Q?gE6SdMmdy6OnubVsg2y1Ru6jZXLKU26jE+eRe4kjGkZX9SJ8zwoVaaxq8F+F?=
 =?us-ascii?Q?398i68jRnAqDost6ULYLA7N9ohLaB8xJwLuYBJS1YPX5Pv/yL0OJaEsGOp1L?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e15bd7-d4f7-4c2d-2162-08dd45b4ec9b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:52.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO6PlDwdrogqnGM4KtL9LMK2cyjc3m/B0EFGjR7KQrafLA9LjB4K1dKcVAHmDsJVZwPoZ3nAdRBwO8CXxalVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17138

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the basepath variable from the FetchData class. The variable is
never used in the class because the only user of the variable also sets
the needdonestamp variable to false. The basepath variable is useless
because it contains the content of the path variable.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f282ecf17..f4cf25cfd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1305,7 +1305,6 @@ class FetchData(object):
         self.lockfile =3D None
         self.mirrortarballs =3D []
         self.basename =3D None
-        self.basepath =3D None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm)=
 =3D decodeurl(d.expand(url))
         self.date =3D self.getSRCDate(d)
         self.url =3D url
@@ -1378,8 +1377,8 @@ class FetchData(object):
             basepath =3D self.localpath
         elif self.localpath:
             basepath =3D dldir + os.sep + os.path.basename(self.localpath)
-        elif self.basepath or self.basename:
-            basepath =3D dldir + os.sep + (self.basepath or self.basename)
+        elif self.basename:
+            basepath =3D dldir + os.sep + self.basename
         else:
             bb.fatal("Can't determine lock path for url %s" % url)
=20
--=20
2.39.5


