Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9264C433FE
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 13:00:22 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.59])
 by mx.groups.io with SMTP id smtpd.web10.11801.1637845217309637017
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 05:00:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=3gU+dqcG;
 spf=pass (domain: weidmueller.com, ip: 40.107.2.59,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIJri4k6INOgk8ZFFs4UjH1t6iqAX6njohUp5exHyrAx7YhaPG16invM1jNGmGmNeXdfFIIgCUlkumIRi2weZ9D6yEU+THEH3d5nv0e/FwK9eNmV+d2OXyupBiiChTVkLRLcuRl3cqkLRNUFo2ob4u73yAdPQTIXdYK2IUUwCzcpTvcU7EfRHZ9+IPxq7TEQ28zyegNn0OkfYlwAycN3d1xzuHlqpjX9Cvq5J7PGLZ0BgZ/1w+VMDme3gBO/pmwSVLwuB1riSajMVsnkiDIxoBOpOvMqpSsljUcF7zHB9ofCC0tbZIagmIGKxODH2kxgfTNU5+Up8pDJHeKPo+zaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZgwLcpmV5KSUjJ9ZtwwSPejrhXzOZwzWUDA5EUJtwI=;
 b=RlxTpZJdFMM3ar1LbHjy5mWVMy8Ah0TfVdLfd5yU9qmEBcBc/YAqaEcT883182OEx13oE0JOICWe9UdzPf8AQfSG3V0FvgluleFm/cGgBs/OoV/Bul+mgchUMQBNuPvVk5zbVgvjnoLTcmvQxvSuzfkDIvYbLXZBSPksv10zhrN5e/lZ4ptj1ZOh/GOZYYf6+QvYOR+E9f95U0KqawNZ7MvDCXTUMekPh3SewEgLEQ/4D2S/44flhfr+1m4BDnuAxlhOGt+/aJ0ZhJGB76uszhGCBklXfmnzYUwaBQilKy1wOOhqpb4/a2bVB5uPUxVV2lTDDzfzpXBTcQrPubWPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZgwLcpmV5KSUjJ9ZtwwSPejrhXzOZwzWUDA5EUJtwI=;
 b=3gU+dqcGCdpuusqZnIpXJzAdV3w7ItEpMWJkBRnjesi5l/SsZ2N3tB9D29Oo23rZzsobCDtlzOmg7tNNQ3wrMa8hDN+EVtjMMeKEj9vsX3oyJa9+qbuo9qvdHKX0U2wOdQdG9If5rSvAW81gl7ny+iDKrn+LIiJtBI3ioZ4P7R4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB7020.eurprd08.prod.outlook.com (2603:10a6:102:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 13:00:15 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%7]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 13:00:15 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Martin Koppehel <martin@mko.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/4] fetch2: Add striplevel support to unpack
Date: Thu, 25 Nov 2021 13:59:52 +0100
Message-ID: 
 <20211125125954.15890-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::27) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.181.29) by
 AS8PR04CA0172.eurprd04.prod.outlook.com (2603:10a6:20b:331::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 13:00:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b30106a4-4635-4aeb-82ac-08d9b01385c9
X-MS-TrafficTypeDiagnostic: PAXPR08MB7020:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB7020F72CF57A39ABE8C40670D7629@PAXPR08MB7020.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QO6sRL9v4vInF19odn5WWNfczgcJ+3EY4IF0JIuVXYDK5guFPkU9495bJhYSQmOky/ZrgYGpiPIHvwry4JTvaneCh3ufIMSJVf7ukmNkn7I2TGGg1GkgppSdJSDHxoNPpLKKnYTlNkJLfU37A0NzpM7Pj9yNcCCLLtq2jW7R+/u6fQ7hqn+wpm0opQB0dKDXZK8kWA1vF9KSQCAaFztP8NWzJB3y+pfFSiElL/g65dQ1iyNEzt67JknaaFXqdAht0b3QaWvrWz84cuysZ5U/C0v5MhlJItGjoCxrZLlMSG7FAHxtGPF/MOo7TPMy7m+lKcjvZxiaDwLE5vORw0PTJGXw4DGMCw0JOK7bwUfyaNDTN3KioJ/scZbdfJFLCt/Z5pIZF0Tej21ZXDKkaZJAJjNRscb/gvppBdlxYRkRrsy/isTVp21wBmmkFR1zMaADOSePs8TuYQmK9j5yT0hGZujBXT5tCa3p8HxalxD0tL3fAMY4lRoxc01rtzOOcjpYYyV6piyPnrau5nquKj9FSYmdgastY1gv1dNDjajI0KhbXcm/Z7Urb71DY2Og8F6vQ1U6KrQIwGkVnTG5MfbzNdF/hEdOWeAftFE/uxVGazQjC1TZ0RRHXrSO3oAc50n61y5CszYI87j+u2EXejRAVl3z6zgp4OXc7yYhZ1j9P5PYLg4++jlGPkbcDnEaK8KP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(66556008)(2906002)(1076003)(8936002)(38100700002)(107886003)(66946007)(110136005)(7696005)(5660300002)(4326008)(36756003)(6666004)(8676002)(52116002)(26005)(508600001)(2616005)(316002)(186003)(86362001)(956004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HB1e3Yqpt1fI/2+thGZ7VxD4cb3wbkLlNAI8YAGK1JH7DITFxTUznJYhRgjc?=
 =?us-ascii?Q?UYpoFuRZkxJm/eJPhOUve+VaTtN5d2QpWcNq8Zp2kD6m8ORF+y4dEfEtj107?=
 =?us-ascii?Q?mnXVQUgiPIu2bXzSbyuSwqCoJmJd9Tje1wtlU4vSkLYd+InkMcbT7gwRc22Q?=
 =?us-ascii?Q?Xde3rsnAxRgnTHbTXNjcjezlATMfyLx0cI+KufnbM8/8jXTJxCYm/qNdN/Bn?=
 =?us-ascii?Q?Vob/QjXDe/DlelWca87dM8DcBggFjgPptBP6OBEFHWH7OAaiNMkUXd8byPt+?=
 =?us-ascii?Q?ypLO6xgJa7Bp3A0a6fBdnp32XguzH8RclOhQTfWu9jqvleFXF6P8f2a2Wh9S?=
 =?us-ascii?Q?bXb2GYlBkgWevFZjtKObGBT+9CX4yOJWWfQMv3kvrcYKGQ4j7FM3FH1nkQd0?=
 =?us-ascii?Q?advzXgVgs76O4+B+nTsOB8MuO3yI1IpF7NT6JFpEKYYY146Chp3VX3D9Mp0e?=
 =?us-ascii?Q?1dJ6SVvS9zbPYtiAxMOx8rs3HpF0iQdVV0tc8/l5+2WTZXxxwlUyKg0H5ovc?=
 =?us-ascii?Q?2b4I2HtgEf4iVoj1OM2wgSfc1TRR+KmmDgWg7efOomKBBHpAxo+x9PMwvcqS?=
 =?us-ascii?Q?uJMjKYNTq3ctrKQxZulQgQ56VUTuZ/HJ38V1kN+l8qp12ipeisSv83P4t87V?=
 =?us-ascii?Q?JBW+kAHtLA70m90WgN1bAiXAWtGcIofS6ogFmIWPn+p87Agpf8aZmvs1r/Nk?=
 =?us-ascii?Q?MD4rOY+xiJLCg3lwQYZuVxqoVFwAqufejZAPeu9Z9ALbMliM82YYvT6WThbn?=
 =?us-ascii?Q?9FfJNIvBxnvhotDKTBGosVoI+ynHkGMdbRbtA+eZoNVZiJ/MAUGYhgnAy5jh?=
 =?us-ascii?Q?TeBThm2tCsydrXsHxmoqekLwSJGvxz7K26u3VzvGc3N79YUmZHzGd2vbwdlk?=
 =?us-ascii?Q?T3Q/30ZuC3WaKPHGtjJBogk/aGsceBThawj7JJAyvOPNt3wg8DbkfdhyzQm8?=
 =?us-ascii?Q?FBU/He3UmsKa+Sm7pI3KDbVXP4P8/7h0aZM7jmWxkzc+EJveYTbwzjHIdPxK?=
 =?us-ascii?Q?KwOoC9N7QdyWYUJwKHyNhZu1n2cruITY7aXxQbU0utxE4i+Fwz4fMVkpksy+?=
 =?us-ascii?Q?1pVrFghX5ikGyMlKMfjbk5yhQww9YjE+Il9VWQ0FC/xm45VcoofYyfJq5Uph?=
 =?us-ascii?Q?sbhrqQGXFZvNCVKsvDdaX9ericow1RoWigpqmcy8KeJ6FwezK+iipM0qLWUS?=
 =?us-ascii?Q?K27C7X/u2lKoe8rik6cBrLgBLbYKH1pbKw6w38H+ibysJF+eZDf2jyzex3Nl?=
 =?us-ascii?Q?bnaGD81egxxFv9bTzkHu8/jpGsbYq4FD2rrmwhsCOlZXQiXUyzjmMg3KT+p8?=
 =?us-ascii?Q?PYpYVcDu/VpdzU3ECeX6FOVmrrjFLpADwGxuD6VilVmIFPFQNBf35k3vlmbL?=
 =?us-ascii?Q?5Q9+eSCgFRGZbQ6nngx9jtpmZlesGT0FFL9FSMRGiUeNUBQTCAvRfVFK1qDS?=
 =?us-ascii?Q?biywDiOrMVwipKsdimlHc9Yb619lX5vEglH+J8G+6YIvuoKnVVmDqRwwXAau?=
 =?us-ascii?Q?vKAp8mL5BTVzyWbfT5DQLuGpEUv+SIGumB1Aqc/IO6o910CWADrqnRcnp5ya?=
 =?us-ascii?Q?KIxtK3rX+NCjo5gB0EY+NJNmUC0ecAwxFuI+xY14bcVP4/H2TTSwUKwT9lix?=
 =?us-ascii?Q?uMXBH5H1WvhOyJG6XUF54Mg=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b30106a4-4635-4aeb-82ac-08d9b01385c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:00:15.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 6UeOFt2r7UyCaKoyM1BGVubmVoK85yvOXipiyyBT2OnKDeCYpj6pjO5X2QHfsnSfkoS2bK8nywP/UcbL5tgFtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 13:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13109

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a parameter `striplevel` to the SRC_URI to strip NUMBER leading
components (levels) from file names on extraction.

For example, if the archive `archive.tar.gz` contains `some/file`,
the SRC_URI `https://.../archive.tar.gz;subdir=3Dother;striplevel=3D1`
will extract `some/file` to `other/file`.

This is useful to extract archives to a specified directory instead of
the original root component of the archive. The feature is required for
the npm support. The npm package contents should reside in a subfolder
inside a npm archive (usually it is called package/). npm strips one
directory layer when installing the package.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b0d5508d..0b39ea6a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1459,6 +1459,8 @@ class FetchMethod(object):
=20
         if unpack:
             tar_cmd =3D 'tar --extract --no-same-owner'
+            if 'striplevel' in urldata.parm:
+                tar_cmd +=3D ' --strip-components=3D%s' %  urldata.parm['s=
triplevel']
             if file.endswith('.tar'):
                 cmd =3D '%s -f %s' % (tar_cmd, file)
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file=
.endswith('.tar.Z'):
--=20
2.20.1


