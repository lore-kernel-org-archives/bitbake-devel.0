Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D2E77196
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=pw0toZgX;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGeDRp6AklxvtAnt2Q6V1+ZLrEZphLtIizv9DlaXhX/A1L+dqOEMmQU72KqwuJPOQaspCFNotfS7RlkQLPJt8j/slfnhs2GUT7p1vYyGtyUbupJELBPgxVxoaO4ipdM6fuMiVtVAt8rIAB8H5ZefwcOyd3qXQRpJ89ojNm5XFjFPKQ3/e6v413XfyntNqspNltoBAgxONHmda1LwPrHGsAn4edptUG8ijOVDnD78dP5AplZkYMPnS+YvpFlHHXrQLS1Bhvp1rJWr3yqDC0tvbAMlwpBH1cGxg7XcEG6C7Px5JAfQ7A3ppT2A9nnEMNC3rWdHxoa3yHwInPI1ZqEYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tit6rmzEZRai1FkdRp8QgPPUeB/0AyLmW9ayX20M9nk=;
 b=IdGsPMXrntCojUhQ7yAg1DJj1cuhcK+YBKElbi7RTW0yRCDB3whWVpvZ20FHJRh1eqbTvpBwzZXQaNVh8ZjDG7IkGRRAsdJVQtB6DpD1XsR1NpIqw8rDp82D4LR12gYcRY/zR0IEv5EpkSv5xIarB3dsXYUWLqP6/g63kKGLgqiSdbFgYvwB74rUFk9v+eIAcVhW77wkS1nC7uP7d7aAimmFVTbhqJejTBvJRHvXpBlgv6uVteNO9bcBzJ9skZUBHTBzpK8myz5KQhOi0UVIgoa27wT9MTzs/Fh5Ky5cLPQmvksbuA2Y6yn7wXxsl4WZoy7SP8FLzh+Ra28l2svfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tit6rmzEZRai1FkdRp8QgPPUeB/0AyLmW9ayX20M9nk=;
 b=pw0toZgXoh7L2KzaY8IGER2lfJ70qFM+TSwoyyhWn/rrT6pWlz54h0znJwSDedO9gpvPR7LWJcRzrvZVLdeo0pEJQkIifqSoq10QPwu6ZvnzUowxDIzIzqqR8PxT7snRyHMF+KA3ng6Zb6g+cg1HV8U7+yAikvHevjD71WwjnHpY7V1vCDp6DxUi3Tr/0ObE+g7YcJ/lKtSO0re8LTQ76nmPMxsOJzHN6LuI/u8smhFbf+95VtpyIJV+4AQS3IZ6iD55jh1XDQqYgpXzgVLs2c/pOE6N2ds1O0xOx0PdofKdV/b84Xj0RvNCpqqAFtkImf+Gzb3rRNzdow8alLdxyw==
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
Subject: [RFC PATCH 05/21] fetch2: read checksum from SRC_URI flag for npm
Date: Fri, 20 Dec 2024 12:25:56 +0100
Message-ID: <20241220112613.22647-6-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: a88e4f9f-b850-41cb-fc6b-08dd20e923d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xtRXQRA9SuKeo5QOsJl44ynR5AkwSR0T33IY9mNNwnyUsOvKec/qjwLngUrs?=
 =?us-ascii?Q?pfOi2lZZzN/P2XBRleKUC9r1BL2qFxj/stJdc26w7DGjJnNx756t7G+d8qZA?=
 =?us-ascii?Q?zPQSORuWQKmfvGMpDvzO57YZrNbHrfOOAGypWV9GDpr2Ysle3MgNDb2dEAwQ?=
 =?us-ascii?Q?+j3ZwjI+8ptaUTsY6nnwp/IxJQerKvrYcCX0cKfu47w/3F6lEfmDyjOHdIkN?=
 =?us-ascii?Q?M6I3UnTSOyjC68+qVn2QuQ7hJMOoFfXrB0bQsHQ5cwNxoGaHtNym9meqD5mr?=
 =?us-ascii?Q?7P+D1KYuR+6o52GIX6PaxY0ogX998L6TcCYhmZGX06fX+TRZB3Qi/hFWuAMz?=
 =?us-ascii?Q?sZBWQK+UkdVgK8iLfXi3sQMQlniIDHd0z+6A4fRrZKkEHLTPLGXBbH3Rz2Cx?=
 =?us-ascii?Q?G5gb2yqM8ApoqMD9RyC379WAvI/NXx4xKj5X7VrNVB7BYgR00odXZmvfNk31?=
 =?us-ascii?Q?PmnOEX7kHEPznC1VljC5uywPz2XMnxwkXGF2iWVppvz7oCPYbJuRLrG6yp4l?=
 =?us-ascii?Q?OorlAHoAYLL9lqhiT/RYDMOLHlXx2gX3M9+UFDk9Nn7r/7mjlE/mfvo46qdb?=
 =?us-ascii?Q?syrJSVOp8Tr11QPlBWLTFuxjpL5cMQAP804em8OiRsZre3impApEkSct5692?=
 =?us-ascii?Q?qOL+jkbsC4xjTmMYUDAGupz2yHP9uuaPqWz3z0eaJiAVnzDcCb4iU7FrYqhd?=
 =?us-ascii?Q?y6Y4bEr2LXQu5Q0Jx//AJauXUbHkT3TuZSaAxDsa6Rq+8iIJ9brUR0HDd56Y?=
 =?us-ascii?Q?zrv72/As7LW/RF2h1wMi8rhEmgpWq97YvnofXxhSoW0f3m+745RRMLqiR1ZQ?=
 =?us-ascii?Q?wLdK8aiOmJoqh+8ZcOy7MUUlpjVRlSq87s5qJlbTHYCsY5zG9E3QnBQ+e5fC?=
 =?us-ascii?Q?uMfHaaXHOJzi9szHIgBGwy41JcT3yKtZ4LknRabfql3NaKuN2NEiWnXcPpmI?=
 =?us-ascii?Q?gN1djxwvmrc10pexKcu2O1kp7Jwr4eH/mCf8q/Ws4eJgG8LZSnVqN3E7OUQz?=
 =?us-ascii?Q?NaT1jAZbLLDJ7m6ozmpRVR3u7Gn2Q10cEYfSQhhPzcb/D/VWsQam5l0JtnpU?=
 =?us-ascii?Q?ELQesImmw/OidshQh75iYRLcli/KFlialVPhNENdTi2ZDuFXsRoGVAe3apB7?=
 =?us-ascii?Q?PYXLo8NuaOGUVdQtorw9oyARvgBcAAK0AwrA2cfJoY1UWyU0b6FGsNppfwRJ?=
 =?us-ascii?Q?psp3omRU6171I/x9FxjTmQGdyNI1itMEwkopAzrdNLgB55BZBejjzdkj0nM8?=
 =?us-ascii?Q?gs0hTuNiaX3Ky2a5JckSKTQIVH7J6VTc7n6UcVUo+4Bd/uFpYgCowCeT8uLo?=
 =?us-ascii?Q?gZmnv5T3y7IrHr3YSX1fhtI9H5FRp3ffmn3E8YqnJ1bVImLd7tR3kyvWi6B6?=
 =?us-ascii?Q?knLbuZsebHBTn4lX+W3GFT4kXYjuNNw7xE8fIA5/eIxbU2GmPmBIaXP5mj+y?=
 =?us-ascii?Q?5qD3uapiKUS/3d+XI8F5KscCKfqe7Msn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w1N9wEgI795VNm7xZPny2627cx4IQmao+f9sPGUzEfGkt4fRZr70AFEI6pWo?=
 =?us-ascii?Q?BNCr0ASviYm0Kzte6+ey8IBfqJQnL6842TNNmyldEM7+s1myvKpT3yDRR15q?=
 =?us-ascii?Q?PQnWaKPF3cSz+I5Yz8U8Ty2TyZqujAaITX2GM0mi2DI+8TMdATSTczLoEiJS?=
 =?us-ascii?Q?ppXzs4E9ywqnztWKutWG/BdNHRpTizmbqZpPJOmOisXnTBkXEruedyko2x1S?=
 =?us-ascii?Q?gKxvOuOG5UQsF2O+HXAgucXRGhIk5Tv4reKMBHd8dk8Xb9/Ik5BOfXLRgl+z?=
 =?us-ascii?Q?C3sx2rrgLSI2POCI3cDTq6MLthVNVKuoniTbJZXh4nVpFwuQb+hxFQqrus86?=
 =?us-ascii?Q?yQ3cRB9kkRpJBWCeTKW6mMsJ3rvkFKve+n7YqLdiN42Hc3cH1LAmZGrVudYR?=
 =?us-ascii?Q?/8YvNhkk7KdMDJxaHQm2apu2bzwaWld74dMw2JobHk05zjNguub6iizlURME?=
 =?us-ascii?Q?2QUuRj45EWcV3t/m8BXp0PKQRoZpSV887FjBKpeauagj0/6a5p9YXDYcifky?=
 =?us-ascii?Q?qoeBC+zUddhvMWD8XyfJ6CrRE48HYvPYeFSAa2gH6kkF1P9nI13aM+HDm202?=
 =?us-ascii?Q?Uf35N1zBfWbVRMO83zcVYjWVvg+L4qzI3oNA/Uv6FttEqdqknH8wKGSYuRyt?=
 =?us-ascii?Q?o3m5CTBLBvFwpAiGCsfvLnBswFT/mqT4kzuUHM3JlnI3wGUQe1KM3jq6FvpR?=
 =?us-ascii?Q?tHQ5aIBd7buJRYxsoAmR3Bxqe8EvbcvlVyUrgVZ4oI5QAlWuJ9MldRjdP+iB?=
 =?us-ascii?Q?h/QAKCIf4TxT77xUL1KIyyxdg7VRv7lmZJhBuc+1NuA1IXF7Z4Ir2JiRgekK?=
 =?us-ascii?Q?aZy27mKE0FV74SWJJDKD8fLsx8VxKgtx1lVev3hWf6pQFOp0NbJUBH+ZvHwc?=
 =?us-ascii?Q?XhXa4AHRgldN9tf2I+GuWEDMMFm7U9Fr+deX6YslzNI+3IK8kkdaZd2mjQQy?=
 =?us-ascii?Q?uF5FIItIhshxAbA5FoI7yfI9HT94598TAYOBT/pmw3clqHNwm0GyA/8OBuNV?=
 =?us-ascii?Q?yI+JkXQqEbdmOYeeinsu+SxIqoLtceiX3Pqjv28Sp0njLD45GKlZljUUTzWZ?=
 =?us-ascii?Q?qH4le9WnqxBc4uKUip2b8L8VaTWskXSJ4m/3NHabpamoJ9Ktg3V3EaJT9YNp?=
 =?us-ascii?Q?VzZfzBy14TbgoVDWCfQqS/3yVf9OKXK78VhiXJoNpyAftnPr/d5VrXnCBSsy?=
 =?us-ascii?Q?3Hf1n3k9uTdqRZwNcwgKhhEMiMcWXM8lgjGfkfiYFnkelx0zWVwvBmGg57q1?=
 =?us-ascii?Q?e7uR7C3Qnv/SPwxfbxAtP22fK9VWvVp0EYj8hf1U6RdIFuj5xalAHxouvGxJ?=
 =?us-ascii?Q?Gz4R6kLubTSuUvBnoUiV5f/NPOEzywAApQlCd2x4iD/jvsHmGbWxphwhMKAX?=
 =?us-ascii?Q?xNKAz1pbmx/GIgWzmnx1L+TqelQlrKPXNU+XPenSgJQ3S9Hx3z2f6WQgSI2W?=
 =?us-ascii?Q?UOLVfMit+qN0uFAcR93lXKOVb+a0nk7VpUBga68HrwlgpqU/3qSAm/dE2FLR?=
 =?us-ascii?Q?Al/gYEdm0PPrquuI9yHANitRVY7/aulq3s7NWY1ZaBLpBhpdsFSlxlmle4Tc?=
 =?us-ascii?Q?yJxS6O+KvAbq4VKf75VFBdah6tUveQbDJ0iu0PPpT+9ARLd5xoE+0yJK06MY?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e4f9f-b850-41cb-fc6b-08dd20e923d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:25.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be1s3TXD8DHsN1WwDpXUGwlxXypVEnU0wxJnx0Pq/Hc6knkdVTAJeei+ka1YpnmeCmiNBBN6zAfl5/ZNoi2B9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16924

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3d31a8d4a..d2a30c18f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1327,7 +1327,7 @@ class FetchData(object):
             elif checksum_plain_name in self.parm:
                 checksum_expected =3D self.parm[checksum_plain_name]
                 checksum_name =3D checksum_plain_name
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod", "npm"]:
                 checksum_expected =3D None
             else:
                 checksum_expected =3D d.getVarFlag("SRC_URI", checksum_nam=
e)
--=20
2.39.5


