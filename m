Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A31CF9C5B
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 12:09:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.55])
 by mx.groups.io with SMTP id smtpd.web11.8496.1726920588726382491
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 05:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=ZLtxKxn/;
 spf=pass (domain: outlook.com, ip: 40.92.90.55, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJi0ZjtpqPzdUtCERl/wbYHAWnh+j54PTFcJPtdzE56H1fr11TNLiOKTCTKSzYHbU8vma7DHrbyedpuqyq7jUK5DL+5NpeJY+0QrGALqonXaWmf2reQBx01XOeT6qHFJDpcY+Ov2dp0eb55pmwZZC3vBa8BYlXiX3tLK5wYMN0uTTvoX8/OLZzUChVvH8az6CkskVJeHGfs/Hl9GQZk+WFgkRdlP0NrhcFN6a7z7NZTrdN8lNF0EZJqhz1CwuSgxhpgHjN87MPfWOIelDbRjfPIV9SCd/Ial9LBGQ5zvnFWUIb0tsP8xLmUMmQlqLRjhCabUOugJd+Tfx9bWqZL0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYB8WERUkYCUxFxpzPsUcEuabO2ikiPHZT8O08H8GAw=;
 b=TndvOTWhA0L2ZVad7Xv5TkzgGvGbzbODmphoURJsjoPdDCiHZPytDZKpc4L38g6HYCHyMHxrR1NGa4XkIo13lAO7lYNFfDnBZulETy/6JpIIB0Incj/8rUiJIGVI/xMB50wWbASpszJA6Ql1WTS2jkb3AIWLOWdms7rQISK7a/QefddIJcmpFUDmkCAQwpw3fXNO+uQBukv5O8mtGkdlgUGy/8XMlvfopghbKxVggk28wgvOaW98OlQ7J5Mi/bYadECmLwEX9ksqwSncLw2d+RjEIfgvHhF1A1Q6nac1FSOlHCQzumQr09Q5N4JKLOZSN8a/YYrDOPRM+or7agDK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYB8WERUkYCUxFxpzPsUcEuabO2ikiPHZT8O08H8GAw=;
 b=ZLtxKxn/AsAb+X7uNwLGaUvOpqi9xsXr6fpY0JdFYp0oWX/fTdMQbtrSFfctzyyLEauDO+vKBhje1Q6/TSiWIj8og1kkbY0bFY0IpQLYb3ukC6A6itsxKc9wstcgmjml7Qif90tIG4b26tiyEgF4AXB2McYyzNzzpIn02GcQbhuLLupZujPl4Sq5DIefYAa5yDZ8XjFx4o9eiiIVpPOeCZRCDasO9T+6o5GYG/1iMao55tJ2aViCj2tIpx3otRMi6G4qY/z98JoNeLUH2YMAZCOi4rGyJC7jNni6Eit/+JFRVqoARxSg+oxqoPOb6O7Il8AaRVbSzrCsL8YSdxk8+A==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS8PR07MB8992.eurprd07.prod.outlook.com (2603:10a6:20b:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Sat, 21 Sep
 2024 12:09:45 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 12:09:45 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH 2/3] bb/data_smart: fix override syntax warning
Date: Sat, 21 Sep 2024 12:09:19 +0000
Message-ID: <GV1PR07MB91203D2CA5B12F4DD0287BB1A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240921120920.240557-1-kweihmann@outlook.com>
References: <20240921120920.240557-1-kweihmann@outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240921120920.240557-2-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS8PR07MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddb46c6-c304-48ea-fa30-08dcda36484e
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|7092599003|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 
	xknjh6mxn8h3jO47l4/jUuLS3SDcpWOoSP8kW0QNmO3ZpdFJphjGkwIcJNeG0P3AMYtPeOsRvb65WIvP3ANiVdZkuNUlaRGYlvVJNUrt+9pFTFDOPRY/6DzUiZH+c44BIGwgNGMTubEM23IB1p3UaLyJJMqeLH/KpQRYmiTE3DAD0mrmhWD+n/l83kaqRqELIoiHAMIe3JqvRet/Pg7ZlxXAD+6Vg6RPmCude7NyUCaKt1cIpReubYr/xHqYogx9madSAy06Rj8s0Hrwwph9qyH8pFabV7TgAYRGrYUaOJoroG8fXKbEfm0IKh5tN02tUHtDmeue0/qwjW1wW0/lbSxADkDLdjSS25XBSL/Ans7b3G3y6bfKLpTuUzaA0YpjmVyVkFVZC6ZcqkxSG6HgGaOJUMa0qDNJX7mhOIKv0TfuMCxVZpDnPSwi6IwpQMDVfe8cw/eQibGfd0tnN/SaiUNAkIJSNsf3l9n6/5sKtErjwACP+KyXs0aYb8izBM1MmGCk4xvwgaPDeolvZmSA3om52hicU4JdFeFyjQELV5wEaXn9xqtBYMaQ1ch8wfvqaRC+jIv7ew0B6bJdM+kYcEbmZ5Km/shC0OGMYqhq1hlNIiBW6TixdhFkwSzVTo1Zzg8jgaqYdkCxv1emHKFN/AAP1M92yqqm00IhLRDjVrHV4xAE+kv8fQVAPpT2MgLfzMyqrvlXxAj+DxEKBK6tsrX3OMY2ac20aoH85INkf2mCWpZ2xGSfKuCfb9WkoEjD668OMjvO+dmSNFhJC7p/Hg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JwI46bhzG9Jih9geo43bvQqGf9Gg99gLizexecHcNqmitnpOSIjy6ixtwUWl?=
 =?us-ascii?Q?2sZdn8tGAJOcsAuo+CmmFAnbrHKTN2brTRtIi4pclhJyh5r2qCr3YQba1x2G?=
 =?us-ascii?Q?ggq9UjSmasMRuGYFE0DXj9WhQQ3/iGUSLewgsPsdFYr8f4X4ZQkA28eIjUGQ?=
 =?us-ascii?Q?imOXww63bXP6o31+FcN8QNYBBxTuPdOQOheLzuj5KidtMs7RXCd9IQiOimGt?=
 =?us-ascii?Q?hjBMIN8ZaxkmNDgkonsvpXMVGEUcQZKGoQM9D7NeuCkVAKrTqyRAmXY4AcVL?=
 =?us-ascii?Q?EDx/ghHbfMZUDAekRmrFvR4dAvuHYAwAvWZzI+EseNbwQOldW/RRj6185vI3?=
 =?us-ascii?Q?5qCNgQx+EC4I3CzF+dI++bsHn+28FKRGz8VrMlzBb1CUyyjUKvYjZMlVLLtU?=
 =?us-ascii?Q?UvRGiWTBE2R2RFIlsqxjtZN310SlsCpA30F278lPvFqybePMMT8923Tje3lC?=
 =?us-ascii?Q?no4CVKaKsLMNmBEif0M4EeXnsqWoPp0n+nN1TqobYrNwE7URivq/fHTVo0Gh?=
 =?us-ascii?Q?A0hRqqBfD5Qo+O/jjZg4pKbp0RE7IGE0FPXOSuuBbS+CZ5RB/hc2zM7EWNF4?=
 =?us-ascii?Q?7XV9bQyOiRoB8lloTHqyGwwTYhGew05yw0RY1OBG37nnHMpNPpcfS/Z0Z/kw?=
 =?us-ascii?Q?lUUH/vjZegaU+lSh1cl1kaN/KYDw7LnXpwprX0bbw/WRU4iWoPH5te5SM/z9?=
 =?us-ascii?Q?Ai19LBxUPSIMhek248mr3JPPXHEHgog+wy2ZNXqHM+cYB9HzWSgAzfEDiIig?=
 =?us-ascii?Q?vS7FZS5wKzK1VyT0DbSddnEeeZlH/a3xHr7QF/a5BJzz1dXtq5WmaivJaS+W?=
 =?us-ascii?Q?FIYnxcOsuhZQEDO+BoSu/+Y8uvNDDYkhR8GK8jWYVc82r/CML0P/CBYC0K+E?=
 =?us-ascii?Q?W7gWgx1i74z5Bf74wB2wpjccCvT8kFOhUrIryYsB3amv9twhNIs4wl1sZyIE?=
 =?us-ascii?Q?rVUolq1MKIvXx5OOdbBFxTo8GJ7W2G/ZIaw5Ug5Uk3rzZ/7qYcYG6jv2eou2?=
 =?us-ascii?Q?mzKPYhBNUTcjl+mOBh0u3+ONDqz+cQmSeLx5WuIg4l9VRp6BQxoeG05uzdeK?=
 =?us-ascii?Q?Rnio6QCcnvZHHkfEHyHPdJX2QdU0GZlCteUkYLkx7eheEpEBn9D5C9oxrtIB?=
 =?us-ascii?Q?K/9FsuW3UpJECMy3bGG6jjag6tZUN2QJl8+Ie7ky2CwfKCWe0AXfX2CY7P6q?=
 =?us-ascii?Q?EsZ/MYWZ+76+NYxxf4hPOs8TFdKX7aH84aT/gw/SSl7HbY45y2JMhOX++TIv?=
 =?us-ascii?Q?1X4JjZEW3p/CEOJlGuBabFKWZaYPyDN/0edqVKg2/dAMarFrsbtB54aUnYlj?=
 =?us-ascii?Q?q5g=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddb46c6-c304-48ea-fa30-08dcda36484e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 12:09:45.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8992
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 12:09:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16578

when defining a function do_removesomething,
the parser warned about

Variable do_removesomething contains an operation using the
old override syntax. Please convert this layer/metadata before
attempting to use with a newer bitbake

correct it would be to search for a override operator at the end
of the string or for the next operator

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/data_smart.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4e15a43c2..49cd4357a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,8 +539,7 @@ class DataSmart(MutableMapping):
         return var in self.overridedata
=20
     def setVar(self, var, value, **loginfo):
-
-        if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
+        if not var.startswith("__anon_") and re.search(r"(_append|_prepend=
|_remove)(_|$)", var):
             info =3D "%s" % var
             if "file" in loginfo:
                 info +=3D " file: %s" % loginfo["file"]
--=20
2.34.1


