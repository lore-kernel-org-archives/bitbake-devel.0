Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCAE7719B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=i8++gokS;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbUYSy3SGP2rkL97IuKesJk4ibvNnDQwQbjRDH4XvLZMVACh9a4Uqsi6W1rlPFxgzNv0qcvESxlR+hgCRJs+hZWbKvX8pu9mxBIeTllvPiiAogHJJ+CPPjwXLe3izQZMm0VdfrhDbxbpqv3ShgCTpzd2MdWAhVLKo3clwSTPPFVDmoeNIc+hCIu7qZ+2YItA/DhiXoTqpoi1VViwwHu7sodaGwozxzXlrGRQGQmnb21j0+TJSqx/ehoMhhVInsXOsgrIZBO4Zci/hjKO+qjuT9KMW+kX0Won/LJx/HWNwFGdJa9VlP7+llOl7GO2VUCijhKGZbY6YYYvxwOnA3TxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWGmKD9aRvjtx7U0RGt1riNrMstd+3AfVtEM6WR3xqc=;
 b=QII875k3ZE9Gx1DC3ni2vVgx31bOhEiiWTAMEdmDeFhxPQvRbZ5JieMyMR5wk1MXiaG4ors9TrrUR4V2QWADouTXA8mT99a1iZaloNpGIndn/U4nUNf7RiiNNyaoUnvyOiK8cjFPsU3L0degmcHT6ICMuXPM6YQ6xsCbc0ABGOU1LnOUEQlxhyQSFJtQ7rBw49wFTkgaqfM++V79NQSJz/g6A0ZoBIhDwl7ix+R27srRjC17Y/tSR6b2JTuHsYjTDQiuO7uyHCkIXN04K8TJtMGed/OKHy+dVQ1B63d34IRGx2B2aWMGT9MRMcRkpQmUWpjdHIoiJMlofqTZsBSZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWGmKD9aRvjtx7U0RGt1riNrMstd+3AfVtEM6WR3xqc=;
 b=i8++gokSTJR4A5kb7f2X5mTPGAZDUrmqs6K3oZ+txWcr1ZnV0YsgPiEVQr0aOIzuodcoCR1y1nAwcdtjVpGPtBP4RRgQXTf3VYLQFG79Y32M5k5lw7jzEv1kuWLsv+SvDH4Fn9v31XNrEJYL+9XihcN4Flb5un4lO7rm4HsXXnH/gKmBBxYayzYmDGxa167rSkNEEX4I1o1yNxxiOBv8KVimSeUKAUtXny5D9FiJlmaqHv6EQRE5U8lGw8eQ/55pXmWt1xCWLTC/h+ALUze+wprf9N3dFJDdAuj+6syEuQKletuAaCDqdZEXNby3Lsibtr3ESD9PetHDDHWMcXNBNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:26 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:26 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 07/21] fetch2: add unpack support for npm archives
Date: Fri, 20 Dec 2024 12:25:58 +0100
Message-ID: <20241220112613.22647-8-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea2a2c58-e7b7-45da-a7f7-08dd20e92432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DgNLjK/nHkP3652lmCOOczhqciHVF9OJxpQ8zi13/GoVuWyxi+EMkRrlHS0a?=
 =?us-ascii?Q?MBFjpvymHZ4xhBOmcW3iGgsjcoK+AhqmzP9nrsLiU1dELEUutWj1RxUUzUen?=
 =?us-ascii?Q?VgexREfDXck33YlRvpDUCEfwRFUOP14+K8sDs9V6AVMOvn5gAqDQh89FR+7W?=
 =?us-ascii?Q?4+CivUYtH0y2/GX2zZ/vwr1iVQMcdKTDJ6oeMOmLIAJTIY0RWl/lVgYmRs2U?=
 =?us-ascii?Q?b6NGNogyGxLLY/kqZN4ZASiXR4whb3Wp7bJXb4EhOsCI4T8dqPM7HZH7sdRQ?=
 =?us-ascii?Q?0JIra0NqEFyiZk0OS2vkXMGTH80vUiZ2nhe2gkHluiF7NtvzDTpE0pk8MizK?=
 =?us-ascii?Q?ChBy/IkjZoBtvAOKFy4mZJkop9AYsEoPxrOGn3/YXMK7WMd3jjQIiGrMMiYZ?=
 =?us-ascii?Q?MpCnHlr9DtEPWM4f6oQc22DPKxgLo7NtXaKx04GWAIxXu6ezYbsxZXqZ7rUW?=
 =?us-ascii?Q?mQJ76FqIUTD8rOeCcRU7Jk93XZvIksKs4wkXAINkuf60447qLZJDDuQmUPTl?=
 =?us-ascii?Q?f9LdRdMC8HHDxReggswDpp9dAlMAZisx09Ls+VoeV1VsRk0gSeGSN3n4cjOa?=
 =?us-ascii?Q?OsBc/X/EZ3pzYp+d911IDm4r7/yExvei1JSIwt9Whv9Gk58bl3KvdyimAI03?=
 =?us-ascii?Q?a5fqg5fE9evnd3Q0wbJRdxeHSPMW2Gyj2L06/+Z/E3VWNQb9jQmWriQFjpo/?=
 =?us-ascii?Q?g/fYgj79V8pJ+21/4MCCs5Eu05Bp5B8d5fY7RENSpDUwuZX85zCNcLjfwxqe?=
 =?us-ascii?Q?Pb577EdK9GTnhPKEP8iJWTLhZS2ks2OzB3qGfxHprUbWAHhQlRd9Php6Pwia?=
 =?us-ascii?Q?8OTRPen5RG1JCtu1+6Te7xzvi8Z8S8DKU7wsiHmoICZykg4lveir0s+ArBT0?=
 =?us-ascii?Q?uGL5dnWdwILpmn66anSAE17FA6kBEzzebHMh+N8SI4VU+Ntl6DgtdbwnCk7Z?=
 =?us-ascii?Q?P6o26zHOEpwY1OcY1B7nCChxJ/t5N5W9ge6L2gbaLNJjVBFTf4XJavS03jTc?=
 =?us-ascii?Q?BxYk5SEfe1/RjTDfn3Q1BSfFmcJFEYXo7bsCzw3yupOtW2gLR+ENUOLFpbaa?=
 =?us-ascii?Q?wyeXRKJeMQvOmfcHHvbhTyI+u7Y9va4z1X4ZcVPVlsvDsDFDOFAyMwBxtaN4?=
 =?us-ascii?Q?fo1//tdXwlTDk8S6t9cxUO44e1kSPVgRQHyVWPUme03Cdy+o/LpJ4xkBxi0f?=
 =?us-ascii?Q?fDDPm+pum5MfYrsY+lXBUEgkcWFHQPcX3Dp+0hVdxd0AiD+ep5Yr32R9+uMx?=
 =?us-ascii?Q?qog8ZFJUwnyjZNhFqc3fbvKY2Nr03iVjvMsxAia6sUDeSErDm7rskQONxyzj?=
 =?us-ascii?Q?PYyFRSQQM5eaa3IjDTLXnbUfxjuxwNhzrC1AOmX5UefSZfAI969a1z2kUu7/?=
 =?us-ascii?Q?0cyR/zbrSAAHoWDpP2iDHMfMR1Y7oa1usz1vQJRWGSZuzI941eikrIxgQlS6?=
 =?us-ascii?Q?OTBX/iT6OA8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ApdbZLG/3a8JdqJmPEUbvLt47jH34yjs2HzT5sOIHCt49rrm42tXK06Ns8ua?=
 =?us-ascii?Q?SesIfuRJDbrMrI7tkmjRFw8pXTF9Xc1JZp6Fc4Db8s0HcO2kMsV9gagL7RiX?=
 =?us-ascii?Q?kRqiKD0iPXXZlcwxGdotwoD9dZUdR+URxoXKzVtQdgp5+S+HBZ0GBmsATZUZ?=
 =?us-ascii?Q?FBSy3pbwPJCl51B+WhxQZcsWo9uwjzXzyawhM7lmnTJGS08UlZAe7/MWjYX4?=
 =?us-ascii?Q?hyI3oW/Fej51Gc8e8ds+3Kn61tVxNTxezmPjCZN7vYjq/Hb+vrA5IzwsR7R3?=
 =?us-ascii?Q?yKcJWg9uBhWJ6HAgBWKJnVTTyC+JGgqYgiieGY6y9qappkpQaDD32JwKpX+W?=
 =?us-ascii?Q?az6j7wmmBPvp5ABjbiDMzzjU8IZDSUejOENUyVv5Hukr95VQrouZS9Ix6yYo?=
 =?us-ascii?Q?Ys83vadPHGWaifsgZ9ntAxUFIi+/1FI2xs72OlTGrolKrk24k18uMCxOwnZw?=
 =?us-ascii?Q?UHc9ei75iuciCyg98uIQcXpw2DIavCIwCcKDJzw+g00dglANpCdbw6FV6IF9?=
 =?us-ascii?Q?i/nTm0vAfnZQlMgaN+RozN8myD1piqMXWo4Q5NQ1mngBTcSDQAYQJX84Sweg?=
 =?us-ascii?Q?GZf47O5WCs8S8Hve1hcXOXikHmMwrLfityAmwghKK3PskKSlzXH8GC2Dn5AO?=
 =?us-ascii?Q?IDcoydwn3smVrltrQhZi5rObLbIOCKC3tAaTpYLu99gR1vRKr1El45N89Os6?=
 =?us-ascii?Q?aCWyyzrJFFf4LI7whKNmuv3Ie8j/q4vFgbQd5nygGl1FilF0JOwjxi9EUQde?=
 =?us-ascii?Q?FemS0vxN27FF9QrWBO99x2n5e0iMo2m+PkMy8vHUxE/Qp93wOt6EFaZ/IgZo?=
 =?us-ascii?Q?u7GO/n78crWFrrdqsRj4DKr7x7QZLwr8a6T80dO2UrrYXkJTcXNhiPGLuL+3?=
 =?us-ascii?Q?wBFpQR7Cc+cmXFS/VXZV9FT2Aluql/KTlwQI83roOmgYAx3PibEcdxlSaf26?=
 =?us-ascii?Q?RNSdcKLK/eD8T4p6QKzo3kLd3EdFkGYJ8n9eIW22gzo3yy8QLH5LQIL6cwdT?=
 =?us-ascii?Q?UUU3f5tCyoAmL4cNsr9qYqSbagYJmXYdLsAzhzoj9nfSq5jc8xu1pl4254YY?=
 =?us-ascii?Q?1txFOGHl3YOMzkYWGss7XLDq4VY4WcFicRquADFO5BHGDNQ00IR7+6nBaUNa?=
 =?us-ascii?Q?wbGzwXZtKmVkLY6VStCkkWUjOegzXO73O6vpjesidenw8rKz5czHyEGuths1?=
 =?us-ascii?Q?3b6fJQur0J8yNtz94xEKemS59U4epE44jH4LGBbiUMmgKGS0Y0P4NwPOoNjk?=
 =?us-ascii?Q?Qj57p4ApLrqVOId9LwGA6o3ziRzirMUhkPCZSUx2nNet0ExC3Y0tNVyLWzUY?=
 =?us-ascii?Q?1YhR39m8E4o4X7gUOwxapbQYbqSXQC1eiNRoHP9E/M386Qp8IseRcQ3llGKc?=
 =?us-ascii?Q?/nGgwKS7vBxj8cWehbRlV90k5cgi4tOsxBxXf3cfrk6e5VUywAplyXvre1Ht?=
 =?us-ascii?Q?EV4VIAQqPq4inJ/WppG3mNQywykmEx8E5Xhj+XrZxAfuHI8Z1igXQOlBY+5b?=
 =?us-ascii?Q?OCLzHWk4Kpt3AHcVUmKLrQ+MZ9A23vJJm2zb22ZEDFE4NpoEdetYV7dOPh1U?=
 =?us-ascii?Q?Vipzl8/qWaWswHoycd/vyq64UmYvuEgQWBxsdh4m7Nh3w2k9GhzEcFeabexA?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2a2c58-e7b7-45da-a7f7-08dd20e92432
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:26.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYlMpGezDOQ1zRvyat3zWaqZFJSJUAvJj4K0ODrK4ASBs2i0uTq8ub1KbmEFdYv4OcMhmVYC8I7224jz6I8ndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16927

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add unpack support for npm archives with unusual member ordering and
disable warnings for unknown extended header keywords.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4b7c01d6a..7d8f71b20 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1535,6 +1535,7 @@ class FetchMethod(object):
=20
         if unpack:
             tar_cmd =3D 'tar --extract --no-same-owner'
+            tar_cmd +=3D ' --delay-directory-restore --warning=3Dno-unknow=
n-keyword'
             if 'striplevel' in urldata.parm:
                 tar_cmd +=3D ' --strip-components=3D%s' %  urldata.parm['s=
triplevel']
             if file.endswith('.tar'):
--=20
2.39.5


