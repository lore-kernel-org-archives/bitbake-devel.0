Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E9C02198
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.110])
 by mx.groups.io with SMTP id smtpd.web11.6855.1738739758488645702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=WZu1NNhq;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSinEEm0wpDF1t+QQZEQp9Uh13xSbsiXzGkqBvLVdUuUkyo262+bHCLN1s31WUCP8ECAlVuXA0p0JvPu7kaqNJ+0UjtvtAlBBaPy59X8bOKtmRfOunRCYfICn/6CjwW1+4jlJ4Iy6SdV862yQVv/PlnqzYHzC7PZc5uM6y9zjCRTz+sTxVIiuLI0IgAPB01osj4kN/1NQRLLEapCqu1zo74sc3Li8PXSzffiHnegBculb/dLxmWc2PrhxltY+7mVuSvB3/Kj0Z5OCIvQEF6on9/7RNw5GyDc3Gs2s2S3KkEjn1ftVVdSuHDavQbCFedjWGYc7TYBnizMezvk9PeDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFrsIDCTznAVEwj2pHqE7g4ibZPXvKg12zDmzt3unP0=;
 b=kkoR5zO1NY8uXW+Zohw9RI+Tlxxfz62DFJZhIeRuRbVdqlbRT6koZ+szz3qMQO7ALwfii/4SkEi/tqjqHdeWWKBKro1cX1wN6xQ+0es+/GoFB0w22Ig3TRw6MOsrKkNk4lDTXDJbXggzMIRKivkMYPgm0j4XamcGlkb+X5943Jaj7Jpo0OxkyQWzONF4RlKW26uT8Nv3JMjvllw56M7cpWipjGwLM49Pcp2+h8mLeNCBQz/VCuToiCJwX8XeJYgjB2xyKOjJLcgVxy0UX4x0WBzpLpkH9VuadXt5TthJWgaA9l+w6FXgZZRS3apHt3V/or2RWReBcFU9a6G/rHSdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFrsIDCTznAVEwj2pHqE7g4ibZPXvKg12zDmzt3unP0=;
 b=WZu1NNhqPhzFybyORmji7+1EGOq8ogtaO/WE8dqM/Qm30neMXvLG0rOrL5uCVfvaFfJRsAJUc9OQSh18laQ+6fqKSkOB/bED8UTHpQ1ZSk/LJnI2JhlKovZ3v/oG37EKazW2qshgU7gKdCiIgq6tnkqfW+KAEQZVZAMKDEqnO88fo2xKEeUurqLhVhVWoemkz4xhSBOkMISPD5e4bmcFsS22X5e+mmPC8OAsZ0MaSv+tSQg5k2hQIGJx/2TYA1+Wm6WmEGegHRHLImidR36a44XiOFtP6qPjqsEISAzk20f1TVIIq5+pJ5v0eckD2CeSg54m9HjQcqCe7X8RnI7alw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:51 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:51 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 04/15] fetch2: ssh: use common localpath handling
Date: Wed,  5 Feb 2025 08:15:27 +0100
Message-ID: <20250205071538.2681-5-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 995a10ea-e7c7-42e7-11f2-08dd45b4ec0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kb9ASpgcO3Da+gAQSn04gIfIoqBH8iIzOJkL9wqP/tpP37Ftpt6biHrBp+0Q?=
 =?us-ascii?Q?DcQpdez+1Nf56hrqFJ2BR8eQbLIfG/6PlAxrW/AcWfdfJfEVZy7AMAfPrXly?=
 =?us-ascii?Q?I9g/RWhEzf8GbhFfBSX5IGFpxPQIgSoyd7rRb11jgRn8/L38NJQQCeUfxnOC?=
 =?us-ascii?Q?C2ceOeKTSOQd41k3/s3qXKGQMbka4qiq1LJpkiHV4Zp08Ku2fSQNxufXLfhT?=
 =?us-ascii?Q?x7Hf0gw4s4frSTMLq+TCFmvr4ob5SxE3DtLUpaR9aPffY0GX43/bXYE6Th77?=
 =?us-ascii?Q?yw0hmoBwg4+H2imBacKqXQXWscrmWkWZJEo9cNfK7U49EcFjDJvbrj7HgeGw?=
 =?us-ascii?Q?X2AJ/pFlQPMxgoq0a0w6fbFRRMudZeOwAD7HSJrE8CIIZtLSWnYl6n049a5f?=
 =?us-ascii?Q?PqhZMO9ZS1o/x2BbWdK4dxZjTWgjegLmyijD0mWkGZ6CAc9Z2V0pKRCbCaSX?=
 =?us-ascii?Q?VlzbR9durtGUfD9qoLkP9hZ5y8mb1W5TvvTGGthzH36p4JQfGsNgNSjlRfu0?=
 =?us-ascii?Q?gJRpctcszDG19bpgy3xddd07g4mb33kqlVufrvJjD78KaJ151kXxgr2QAU+i?=
 =?us-ascii?Q?75HMzA6rLQWoCsN8seFwg4GxYFLsJ9AJF0fum7HmMdBdOYMxV9WgGua3ayoH?=
 =?us-ascii?Q?nmJPPZ+DBL8PhYYjjIblR3NfaIIusRTdrwAgM52Pbf/y5un5GynIOdMOhjnG?=
 =?us-ascii?Q?E40p5bF7GL36QHBaB5QSGRLlOdxmxn2Wva+aEJIkhPaB3sfVp3LfO70zXCdW?=
 =?us-ascii?Q?OLsbH5rANU2VDJ9ygn69BG4jkWmdgsHz0taDSy443MDxtbnDcHq+7yg8RpHI?=
 =?us-ascii?Q?bhyGTYQAi/OXNUSJxB2sxCIsLdOwt5niFP9YBUKwo+0P7XKlLBmU2TxrFyiD?=
 =?us-ascii?Q?xSJyu3bPhafvbUWZPxS66eJsPw8SjI+7LQUAOiM/xrRgZxd0P6lHogGfxyH0?=
 =?us-ascii?Q?ng//BSfNiRBilmR7FSogZ4fCqSdRbiD9cHXsjGb4Jmo4lKT/1XbzkdMTM0ZX?=
 =?us-ascii?Q?2HG2/NuQSA8bWqQSYa071+cdtdj0I8JVOpDvKY2hPZZcSeOwvX6QVd+Z8vst?=
 =?us-ascii?Q?iRTrLJ6TQGDTC70bm23ZQ5PXOWaiJd3SEMRjWCdXKVv8JyZhZaHMtpOohjK+?=
 =?us-ascii?Q?7TpfGmzB6n3WdikRoweRgjTp71vRQGT255aAOSyZh7MRfSoprE+6BqUqCJg2?=
 =?us-ascii?Q?5Dyl59/l8892lRo9A30Sn6+FLUT09ubXX70Jw7UKgf3GjPylR606IQtp90TC?=
 =?us-ascii?Q?jQo9lcVUxccZ5TwAwm/EInuX3dtdaTdBuhzw4hMwBe7gRxS/TsIBcsogYEiZ?=
 =?us-ascii?Q?TsU1wrOtacxdoqQPoQ8vWJnc4vqpoIaRqjwYOjpngCG5jsr8YzH73GejgS+d?=
 =?us-ascii?Q?nguUibgpqEd6xuxO9baV9piHQUuXPl6z2dfNccnQR4ECwyJoNb2jj+MmHlUf?=
 =?us-ascii?Q?k+d1DvqZV0dikCGIO1EoNCt/KkkkfTNm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?50DuI8W8x/MIDL1jasKC3cpYxig0INhE+92FoJ+dW2kaMiZkTC1I2PPGp1RQ?=
 =?us-ascii?Q?ET0PRYN0CLTQTmLdyzP6oTS9qTqTIksNlFiM9OOydZpeOQCAIcc0KdwYecKp?=
 =?us-ascii?Q?+nK0Fjdtmurk+r8R2VccGgdu4yA8xLafqbIzbNERCzoB1O2KnwhdidWo///+?=
 =?us-ascii?Q?G5qI5b5GZiTf+P8K3lm3hG40UfxpDflSNmpWWOrz2bqNVvAQjrPvJCaMwsR0?=
 =?us-ascii?Q?YD6/uxXahycnCKUgStHqVMEsrZHbcSA2XdLdmPfek20kIrAiNsVKeS1bzrsu?=
 =?us-ascii?Q?Qz3cxOFteWJWgBDdQYQlPVb8jji1WnQZ4GBeS0DCEdR0UPuWGGHzP4GnYQRX?=
 =?us-ascii?Q?7sXYeZaPxPIG/5xrq9sT7SvavWISC3YlyrJv8d//wHOz3sii9Abi8ys1sRqD?=
 =?us-ascii?Q?ioBe1FJ5aLZF7WJh6oEmBU62cdt0tlfV8iOOOug37vZG2N57e2yGZH6fhVLv?=
 =?us-ascii?Q?F0jEIXTsU+BEe2cqq1Vj8HyvbbrwzOC+BTL9W2tkgfaZEwXicuIElBQiwwDl?=
 =?us-ascii?Q?2oYph1A68jTZxbjPvfU4QWxCMrZ/0sARdfENdKOb8i8g5iKDeKaJEziP1N0b?=
 =?us-ascii?Q?MT91PKvtETYs+1WQ+UNEipsSimMVQA6uApraohZRy9kL/J23R/jlTWgJJbY8?=
 =?us-ascii?Q?cUHwyjFXOqHf2nu4AAFTq+6R7K6vvozCv0Cswwrq1KnQQZNxRd5T3gub+ZSc?=
 =?us-ascii?Q?dH3TJ5k/frG6+wsC/TKYumaWIL3pAHrBJmPQxrW68/w2XUySMWfxceVPIiGr?=
 =?us-ascii?Q?j1do9FgEtWodfg8k3PoV3uCYxgBxITvGA/f2ZLWM8TCC3jbZ3rtKAj7qChwm?=
 =?us-ascii?Q?7K3O2a4+eIqm87Nc/171gNEDy1vsYsxA9Tm5WiU7+49PJA4gBdfFwDoKdJJk?=
 =?us-ascii?Q?8uZzRdfw9o3CMlWiNFy/smqwpMxtQAqKwtG9P3sxZyyJ75tJMcg4xsJj4Hy3?=
 =?us-ascii?Q?Xy0mjs1U7E8yfU7b9NGj8lUkgMSlhfoRbt9z0CTVSljuzIbNixt8KEd8t/xE?=
 =?us-ascii?Q?IJAQK+CbjnA8C3qArwdxPo3ZxzWB6xN/ka6KUfHtM3ibarjK5dIjkcJi6Gpm?=
 =?us-ascii?Q?+5vObHtbeyRTwEim6uj3HvD5AaSPOZCrigLImDxivBrP8Q7/avv1xHevx3Bh?=
 =?us-ascii?Q?lWbXNSYTo+7799SRe4SlZ/bU1m2JLqxnuoVA0zecdjB2xEEw3DX+b+uxTMAx?=
 =?us-ascii?Q?yJWNzCjkvbY+mToMQyomWoK4Me+4e2L8vYxxpVtSlInXMJbxDw7FF+P/YnMf?=
 =?us-ascii?Q?6NO+nAaZFNm7Y4HqCG5bIxO5p1gGh+reZRXQqJ+MSKx/7ZdB40r53szaz74H?=
 =?us-ascii?Q?Bn1CvM/7v7EK08KTU6p1SATaRxAtKLXOAT53+MrcH6or1JjypuhVvOtsBrXZ?=
 =?us-ascii?Q?Jf8MICOlSr83UhQqUzmXhnfBb/imrVUMOHxVwMRnSKeSb9LSBgbqbuRr/hWh?=
 =?us-ascii?Q?Z1nOxpMH3B8piU2eJqN9VzEL3Zfg8dfEHFiUP49up50rTBfzmCk4ZEzcKU7/?=
 =?us-ascii?Q?L/M75ux6wjkjDJ4mSLOTOBkQNqSG1iMH62koNCqGBTJsbB5tw8rCgfmNkd/Z?=
 =?us-ascii?Q?aL8fF3N/WXiX/5wKG/gQEvGmFxVZRSLKOCmNUMvGKOKRhMDYgXJLxOaVh0sY?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a10ea-e7c7-42e7-11f2-08dd45b4ec0b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:51.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZf/GtbWl1vCC4MKeDUp9nGIz/u119DywPtuwmKYZlbH48O/aMZe3JViS8dih57lzSaKcUQNTNhyyE9/Gk8P+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17137

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/ssh.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 0cbb2a6f2..2a0f2cb44 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -73,8 +73,7 @@ class SSH(FetchMethod):
         path =3D m.group('path')
         path =3D urllib.parse.unquote(path)
         host =3D m.group('host')
-        urldata.localpath =3D os.path.join(d.getVar('DL_DIR'),
-                os.path.basename(os.path.normpath(path)))
+        urldata.localfile =3D os.path.basename(os.path.normpath(path))
=20
     def download(self, urldata, d):
         dldir =3D d.getVar('DL_DIR')
--=20
2.39.5


