Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF8AC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=j5JQ6lm0;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEMadNVGMX5oArOcnQTFj5JXrJedPZUXijxno4dAQTjHC0jfIgzC9qz1CcLEwpPu4Kw3QwimgCl+Ok8uenDki0r3hn2NXwc1lLPWUSB7ThoU4Nai9zfy3uVBd+fOK7R9hzkId2Y5OHhCi3JXmNq3idAce86vI7sKQgpur57xF2lDOSVBKJOVyJ7X8ymSNpd+55N6VaLxZjrNtQIS9n5027BxPpe1zYb6EAzSEZXoc0nmU/3/AXBot7j8Og7KaI90WbByXLNquiNs048ouo/Tr6u6ONV/mfGbwPwBnVAsKo4VlKkYQv7bJ7PuXRUONKJlSbrcBtqc8G9K3uow0KnCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMLnpLftIO+2gZhPlgcT93HfJ92/IHgGjXO2lKiLiM8=;
 b=qA5Xgf+H2IAgrQUTPupPgWRWUk6FxFlIrGwFQSa0shXDdfn3tVINiAD/wCn6SSCUItdjmkCiOO/zJYzA49fh/p03PrSqOBbLC0VDhdwRgF7/bYwzl3bHYV/yr93GjzlAE6ATqFtLiL2IWbsLYtIZfLsXsqSiNhDIq2K2Hf+BGZ0hOwm8XIozhJ9JTm7ugSIa2X6kHbq50MmKuRxHq5xCBTb4onPE+dIQhxYXmaQGogTFkCaXBwWz14QBRko19eGbLyQCkqdopmbIgFHQn4ni0/KdS/dFDOdJNgF7TrZoqZyqtqvWh2bs8rE5XFt0gRwEfDYel92jMUlRCsMn8pdnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMLnpLftIO+2gZhPlgcT93HfJ92/IHgGjXO2lKiLiM8=;
 b=j5JQ6lm0IlW0XRFj5bBpk8fkx8LVeBrkFs2WD3Rj1nTIijQHbHPUlkVY9dxNIAVeJxLm61I79HCMVE/kwlw+uEzyQNijdY9O8WAJntIowEapStwSx/lDAe50Go1yQ/TfohBgD5UZVRrnI6+YdnAa+nHxNI8ofruHF3Jj0Ayaxovfg745CIyusLUjD3E6cMGqYi81H/D7eJpB+50yE+YmndUcN1m4ml5t6lbpPOpj+YLEPW2FsGKsBRJ7dMJ9pXuUzNhHCaBQJi9cjHwwAiNCZtWLR9QNwWu5bYbEjoJhz7iam7SmJC1a2Vl2Dtq12KitgKjx5REhU3fqFG0gPupKLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:54 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:54 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 11/15] tests: fetch: fix nonsensical replaceuris in MirrorUriTest
Date: Wed,  5 Feb 2025 08:15:34 +0100
Message-ID: <20250205071538.2681-11-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c809c06-a64b-4a5b-f178-08dd45b4eddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y8PNgP/Z8W4htelEEBGLmhvLCLlCM7DQJYld4TFDcSnH4oT0dvsZiKniM7Tq?=
 =?us-ascii?Q?tF31081Y+fYDBRvPgf7CEWZv/Eb6fJ3G+UjEfe2n+UkYH5MW/OgzFOFqlZy1?=
 =?us-ascii?Q?vB66BYoHP8gSUq7cjD/C5KnWB91PoHlBmtA6o/J31g/CmW0+bTU1AlnLu3xD?=
 =?us-ascii?Q?4gXCsnsf5qI9SwHYFluoOe7cCmYPRahm1o7wxfjeZnEXjdIiO/KQbd77dlLo?=
 =?us-ascii?Q?F03HnWe22mFR5P9t0WYrwJ1UT0ZctqivUnYKq4BIzDE9jBVla+K6fzjMTNzb?=
 =?us-ascii?Q?4j5TS5mAr3Es/GL5IUZJOWT3yMUd2LcD/R0JAvh0J7TxCHUdblZUFNhMWAs7?=
 =?us-ascii?Q?WatNig0r2VR01w7HRNJQDo8V3qq/JL0NMvusglPPM66+X1jmCQ6Y7HyCzQOD?=
 =?us-ascii?Q?htFwUfjqaAEna85FKzPJNTtCNKLJPcNNc2L4f2A7NkuhI2IRE69QXByjnU5w?=
 =?us-ascii?Q?TpNUk6tfSVnXEH7ZoN6q+pwh5m1qGuQnz++kMp+5mWGsmxZY17ZcqRyYRd6e?=
 =?us-ascii?Q?y6sKoAUHRnH3XODuSHeZrr0qpJbar/I7AU6HTT/i2jB0985F8n7Fl2q4suUe?=
 =?us-ascii?Q?9rbiAaCIbzSiTACeSvJkYcWlaeXvEdxRrOhUf3RBIRCTrMxcJhWEujSJ2/ze?=
 =?us-ascii?Q?WO+q5HC1g491kPEsiwnt+eJgo7WPa67oPhHQR7hcs9qSCj+nOfOSF2eBu4+6?=
 =?us-ascii?Q?f9j1V6NA6K5JyzIY24mE2HWLxyG23zmkXHoVUFLIsrp2KJfQSA4HCxrt0XaZ?=
 =?us-ascii?Q?z1/cdj23RXKuAQCq5T62hLuqyl9p6FQV1n7ySM1pRzEq8yBKxAmMSHGSAA+h?=
 =?us-ascii?Q?q3Js0St+wI0ZtkmdJd5Bjwdp3rlDXYSHnTzReNc5YJuoODGBkhCUN0q11AZd?=
 =?us-ascii?Q?GXnGA/1pZVfEufoC5aIjF5re/XI/o7VaYzTYWO0elZl80YsmfTs8rcLOyFwm?=
 =?us-ascii?Q?M+2UsYheuhmmnBiImS3lybrbf9TTxIoSr2EwBlf/hAzDeXGT3ujQ5LZbILJq?=
 =?us-ascii?Q?57ux0Uk1ReVALBJEIW8VPCRQyO8NXVBlmsSm9oDkdfTujXrMkcSmfu3XzANP?=
 =?us-ascii?Q?BQ/HsEBsyKVFr01X+s7/86F4MAlyfxOoXFJA6CrbEliir/lH5yorBdSgPcJ0?=
 =?us-ascii?Q?Mjwh2+CmuRzBty6jvlEWPdXLfEQIoCl7hKfdQfhLCbsCY30bsmTzUnVPEQwt?=
 =?us-ascii?Q?+7mPVSrtpDHj9w9XnL2abrvPNzpXso4XxA4vKerZL+VJgxH5RCKfrowt05rR?=
 =?us-ascii?Q?aSG9ON4TwOVzMFxCdoXNeJ7R7RggiNuCt+V5DtL54AcCBVwLOTqGrAf4HssC?=
 =?us-ascii?Q?TeyXzEDPJ/JTfQeOmSIJbyRRj27aW9NDzHCFvD2ifWT+KHdfokV+dSJ8zdGF?=
 =?us-ascii?Q?76UzvqhgJ6kiQvVe5TZ/Jp0Sr2l4l5eXXVDRh/o6huWTFsa6Yw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W1bsYL2IgzbLj5CahDOhlWI6po89EOGXQYT1849HBT+7W9Ez+T4r3r6dQ6FR?=
 =?us-ascii?Q?wJwK2lTivTpd8L0G0RQSyy+b29Cw4KjKXwjkp7Zxh71XQt1++15K3JZuwTMN?=
 =?us-ascii?Q?OtlXb1PxTNJXupK6WliuV3JxCcSYg+uVHuoxz2SZb8/Ghj3eq7bILKn8OStw?=
 =?us-ascii?Q?m9HuEA//1xa/IAJ9qdiJXejRM7okrF+vGLxLokWfC5yauZypX8ZG8Fi3C+b1?=
 =?us-ascii?Q?K5u2XMDR8u66pn6fHOEa61oOJkAeDA7N1rWhb3rI7ZoIkTOegml6CK98rLfe?=
 =?us-ascii?Q?wu0DQArzNGAlHYs26F7QluJahRBp1XBffskwGwPFz0aJoYCGxhVPZEos8Mr1?=
 =?us-ascii?Q?SQ2YkhNiBoFu13q6qB0zgxqIHjrnWdPNtcr/OkkmEZwT8T3SVVa7msN6r9uy?=
 =?us-ascii?Q?TWHb9zciQZsQlDvaAPkoQXG5i7OagqQEhj4owTRqLppjmbpQsSG/kpw8LU3O?=
 =?us-ascii?Q?iXm5x3IHEU4qeMm6Ugq5Kw8eJD2glsw8+Q0Hx/L+hGqL8yOlWqAKOxS9LYEz?=
 =?us-ascii?Q?NIkl1/gYF1U/MAxctU+rJdJ4hJovQqgxt4dhKtsBjblTk2kmTur5s+0d+1RT?=
 =?us-ascii?Q?W7Jx6I3M7L6JImYGx0phHPnEqmkVc6Hba+IR2ayqFY62h/4Qdw+gwM/q0fde?=
 =?us-ascii?Q?63X+1RRMrmgZZWt7HxeqzzkmuGkOlKlJ+xWGYlzslrkaMj9VhBZ+jX8TmAqI?=
 =?us-ascii?Q?xgSJo2GLkfszLlZE5z5NptcwckIMgcRwnuU00vYpxwTl0xn+r68uMpHD9LTN?=
 =?us-ascii?Q?LjzYSpPkDEekEx8OzEshqYHxaXnmSPnpXaCQVy19fOhQIZqVBFT+edtMIH/N?=
 =?us-ascii?Q?pvecEFkYXURy+fLD9LSlxoXb7fMpqxNSslhBA2w9G2UZYJ8MVI1MWjezYGz1?=
 =?us-ascii?Q?oOWoyTTkhNLGggfG4A2VkNS9jjwpqsoyNPf7GkqiaAtR/vVPbHJjEUjvKbw9?=
 =?us-ascii?Q?sAJENSh4/IFC5ZTmgiTi/YUPpf25kUqfbG9acT+J2xK4/ktWYdfeW2sHig3q?=
 =?us-ascii?Q?lSFsHBgJLKDF9gwHbX1p4/hOWxi0legYEAJDFrWCSJ7tTDB4h5Q0fcd2nVSb?=
 =?us-ascii?Q?ebf+hurFUQPkv25QNvaQelPNwDj1iQBOy77moq6oBe/WNiEbKmxW6bqxd1zp?=
 =?us-ascii?Q?H9P3HMkmmNDzQ6gNYIa77Dsmkv1PwEKPgP6a1y1BFvxuQmZ5GEgxByXfWEmS?=
 =?us-ascii?Q?29nZ4fgVttDUBQSMpwQuxBUuwnc7KTomRNcVydRCvvoScs+HptyCGiNE0xMd?=
 =?us-ascii?Q?EyJFBO8Q5fVlzrb3vTpcT82vw/RZwRvdNZEt5/A0dZN3E4mkIPoqZrDkAMTz?=
 =?us-ascii?Q?mnOGlj9AC3Hv3RG1PwIHCdiHHPDCB3lb6xMFkEFx/JIrRA0iM7KBP2w3UFtH?=
 =?us-ascii?Q?5vaCKZD++OAfU0HP1jhlJloUuZC+WkPqWfQmf2553MeYi+fl12J9G5MTCsNi?=
 =?us-ascii?Q?gGfVgdR82yhKOVvUvlqCvKyqkXIc3Vh3FfpD52FJzPIl6yuylWxgXKqcBz6C?=
 =?us-ascii?Q?NH54CNbFVInGYfdcHfWUaXajvZiqfw6QQPzZoJ4UM576Z2avp7xZiJJ5UADN?=
 =?us-ascii?Q?eMiBOKUlg9XvWwiOMjFvTQXIN08p9l/s9B9du3ocruP0WgNu6ZQ0mOzMUXoB?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c809c06-a64b-4a5b-f178-08dd45b4eddc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:54.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ROU6CFEqJpxFLGej71LthngSQ88bz7TXlfOHYLqnOKcLoFmhZsYs5BSItl8YOU7FcQCsOQo5vMKeUEcpgAbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17146

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

A replacement inside a mirror URI with a PATH replacement should retain
the original path and shouldn't consider the downloadfilename parameter.

A replacement inside a mirror URI of any path should retain the
downloadfilename and shouldn't contain a single file.

A replacement inside a mirror URI for a folder requires a folder in the tes=
ted URI.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index dbb787a7d..ec6d1c039 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -500,15 +500,15 @@ class MirrorUriTest(FetcherTest):
         ("gitsm://git.qemu.org/git/seabios.git/;protocol=3Dhttps;name=3Dro=
ms/seabios;subpath=3Droms/seabios;bareclone=3D1;nobranch=3D1;rev=3D12345678=
90123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilin=
x.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads")
             : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_V=
ER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
         ("https://somewhere.org/example/1.0.0/example;downloadfilename=3Ds=
ome-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/PATH")
-            : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloa=
dfilename=3Dsome-example-1.0.0.tgz",
-        ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz=
")
+            : "file:///mirror/example/1.0.0/example;downloadfilename=3Dsom=
e-example-1.0.0.tgz",
+        ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
=20
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz")
         #    : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-        #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234=
/sstate-cache")
-        #    : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        #("file://somedir/sstate-xyz.tgz", "file://.*/.*", "file:///somewh=
ere/1234/sstate-cache")
+        #    : "file:///somewhere/1234/sstate-cache/somedir/sstate-xyz.tgz=
",
     }
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
--=20
2.39.5


