Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0187EC02194
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:24:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.35])
 by mx.groups.io with SMTP id smtpd.web10.10469.1738149871051466691
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:24:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=shkSRYG+;
 spf=pass (domain: siemens.com, ip: 52.101.66.35, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5RCICsAiV68PLAThLbFNgTa8CI0A+NqPEsPm+ornQmC28enj+1866OFxb4w2QynU1tN6On0PwaetrKRxvo6WNR9ZNgUnHkyv8h33WynrB2+khstMcA7TFkJtk9ryCl2tEm5gRtZyBLmTPM1ZZwJzbK9c/eGt84/0rUQEMJzuck945te5U/a94w1HnTCvIe+GvHS8wketX7gjCNI5PDY66YH2midvEmJ5LuSKjIDo8E3LZnJchz8ldh6FDFB0WwvLl1Bp69rP4WzIsi4mi25NtJ7+YHqmNH6nQOY3pDOQTVX041cQ80O/aw9pIhRjGGLcq85uzsWjefRgC64KjKpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9ZxvhGjtNOHA0fb7WdOxHPeXH4r4HvxmILX+SMwLs8=;
 b=acJ2hAnEFqhPJS/O34s1OM2935UQc7NBCe9G/ZDh5Zf/8WvOhTVUEfzwulGvKHJhw0gN0xyE4tGcR5uNCuJK2oieeUFo7R2gymtzqMz3yZMfCVbtsR91QTG1DRTgXfJzXhbab5mvVgnfLt1AkfwKcWpD6N2NjXcNdwGdO+HnRSzarAJckBY0kjaG0EW0qK0U2mWX9uWfj4c1TRUVXggZMQA2siyuVj1PIkEQq9iY7vV9MmDLI7wpbvRyndNlLvcXvY/EzyYWCxSRL+BZOVNYLCe7zRsGfM7tCAHdkA5KXwP7YSiSzcNSH7kuwX7qJsZOGoAfN5MADM0whykn2riD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9ZxvhGjtNOHA0fb7WdOxHPeXH4r4HvxmILX+SMwLs8=;
 b=shkSRYG+VdFbdyteGn26Etfu/KCp8G46DP7le66kI6Xk+KUlDHudsYcJeTli6odJ5t33YXMNbbrH1ZY9a1WBzWNwc3umo/jtkOhyFdKsU0n2vCYm5+8GoFlX9q/P2FTUOnTCrFMF4j3MuCSA6Ho55TRpK09nHx1c6gcYaotmO0LjdBOuN6Ai6Zn1blQ+GLPInVQh7nbKBdtgEFVZ//bMkl6TP5Af/vJnfk2DPE2bPA2hzLfH9OP2XrQg36V3M5J2CZoBQECIbue2hcd7Pccy7fLSYRYZ7J8G8bXcvzMwl9AxIpluPtpcxL8wN1wviSkPbNUSLMLWiCdKvYWGlGjZpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB6421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Wed, 29 Jan
 2025 11:24:27 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:24:27 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 0/3] fetch2/git: Improve shallow, lfs, and tag support
Date: Wed, 29 Jan 2025 12:24:03 +0100
Message-ID: <20250129112406.1660522-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbdcc98-c569-4cd8-1e9a-08dd40577dc4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GuAsNis/+qmi3X17NPaCI8j6e80L0/nS9SszSV6rJxO/mWg/Y0A9Q9xNSkNe?=
 =?us-ascii?Q?n7qUxPF8/aKDVET4DWhBQktrPM5tsC1D7q7bLTD+gByqHyp+espE628Mk1lg?=
 =?us-ascii?Q?HjgmHtkGWk5aRxWfE/5nrIjUWFcP5F/tpjmExNLtqYzVSIoCphjL7yzB6ZWg?=
 =?us-ascii?Q?68NzV2em75SOm+8qF7UpsHAw170O1XZsNMPJ5HSgW9nI0uvG8uMvezQLAsyH?=
 =?us-ascii?Q?tlITfifJqNqlgMtz1yFE7Zvczd0b5pRQYaQ16g5mxLHEc4F648ZHl5kT9xfj?=
 =?us-ascii?Q?BtqAn8VLmULGxhpcuMGaBAWrCE9IPWsQPsYHRXX1iXmvl6FNnvtDH+3bBd3R?=
 =?us-ascii?Q?loezv5IwU8Tn9RktbhagUP6x6Fsp+i35Z3ftZgwAD9EJe8a0aFi5cQxkKsHC?=
 =?us-ascii?Q?rC9dbVoOco+oTh6kfWwnnrivXMdA29s9ONc6n+q1XGX5ACXWYHoDJF3OZjk0?=
 =?us-ascii?Q?u8Iu9Byr5dn6zselyf8E3WJUbGgbzcnKZyDJh0IaNeFuS+FGDPi3IiXpBgds?=
 =?us-ascii?Q?vrHRbHGv4Lweca4KtB0dw1TrdBbbefIjngZjuJzsHlziwymcHO7fYO0zRoRl?=
 =?us-ascii?Q?GUlMgNDMh7XH0rPbZMHEBL78S54zc9VD7Bmk2Fv1E0y4aR1nHjsfHmK251T4?=
 =?us-ascii?Q?sL8/ZOt9zKUPAZ0nCSlw+ZXOZUb/N0AOnBJKZUorqjPd42SnobZ8QhqtRRm/?=
 =?us-ascii?Q?cgpf0yCKvQ32UugyPchqfWGKfMjGgboiQxcL6qOfpToEyk4vtLytVasIV8qN?=
 =?us-ascii?Q?e9VrH4Nf0JGTKYLJlnGnE8t+SEz0ggMXNyi7/MkxvLcYhvoEN8gSGL2A7LE9?=
 =?us-ascii?Q?Wn6Ad4fh6/A0xuzIvzgPoKywbLpCqypRMxo+YSaaIOqfbCUmNid1vXE0erIi?=
 =?us-ascii?Q?dfEYrfNDV5A1u3DXolQtPqdXsHNJeBNqGlW/ExzI5naZw7c17toeDj7IzEOx?=
 =?us-ascii?Q?cmzEG3JjTch0SIRX0FrR3YbOuLBiOY3VcAIF+ZBK6WAv1ahEvYQ5nFspstkQ?=
 =?us-ascii?Q?LEZ5hLfzNxuozQme0lTk1PTgwvl8OOarW4sAqBNbBl6noxRF/lJNf3n9B1YQ?=
 =?us-ascii?Q?Kf0hJ/qaD1Ei2/6aD5epH1sGFkXANaPX/tBX5htI2x2PMrw6G8rwlGIRp9Kt?=
 =?us-ascii?Q?WGVXjV1IuRK/zlAqYIe4lfZ2Yg71aeYecg17kOZHWdooPYvdQwNJO3seVXb4?=
 =?us-ascii?Q?Ba4PB+3P1gjq7zRX1c/O7bfOs1FzUynREqBK427cCm5h4ycrRFpltPZq4xMW?=
 =?us-ascii?Q?MOFtmR2lI0Uihc5Zkk96cfBoQl5gQ64FkrFEWgiPO1ZxwBP7NPoDFXs+B/Lq?=
 =?us-ascii?Q?DqiF4Qdv1oKqgnVa0B+iMGOs/pLA++QQhVeBMqSqfSlY9L6j6Z//oLoI8qS/?=
 =?us-ascii?Q?r8NxvSb6mQAMFQEN1lIMAlhmz6fz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xg5m1QL3MN5PfCjIxw1O2eEX9ap7yBil32324Dr7ZPvuDUwvz6wusP7JWtYc?=
 =?us-ascii?Q?Vbrs1lSbBmUEzIM3OX1vrNTSJDgJmR4e6eLqfn4mL+BseNhKt05WIyIcfVyE?=
 =?us-ascii?Q?1UvdStGCpyn7Lw3hPJQTwtawxba1sB7jb/r4v68OwX24IP46Xyitk0Ctyp8A?=
 =?us-ascii?Q?BQu7N76XQOiQMP7idz0TCeplLyfrfVqcxosnP3aF6LAu2L67bDZ4ViRe/MSY?=
 =?us-ascii?Q?I4Z3LTNq0/KkzkLPuNLdrkonVPjNX1pdQOSo86u1RhuOwE+bLkYKYDoVCawI?=
 =?us-ascii?Q?QK0HkvP3Ozxm8j89cTThVqTSWZa9Wk+AGE4c2QvRdrleRAvr0rfAge8TMxWY?=
 =?us-ascii?Q?mTSXLwyf/tNMXHj5FAlbJTRi2iR1Gk/od/dvla+8DTmaQvomrS9n91Xt4c5k?=
 =?us-ascii?Q?WVca+r5foA6d4xcQ/VhWzJYKYCtLflF+JSkDiruORbdqtMMHZ5GseFmR5SEc?=
 =?us-ascii?Q?y/oyPAnlkfx4Gm7ldpgBMhS+piUNkMqiMuL0DiZkmfwFz+EeYNd/Vko/GhP+?=
 =?us-ascii?Q?2Z29/4S3DgxtZ5TFs0TC4SLK7iXXq+FOPXo7Knt6k35zXtTW7s18mSG7CME9?=
 =?us-ascii?Q?tfIwcKJbIJi31J9ZhO/04njPqjUKRePjHH3qTy/z64Y/OIXx0nVlSwfOZw+W?=
 =?us-ascii?Q?ZOOFcQLVFbeQ1kzxc+m2mtOO/rF3g0XK10OqV5IHujALvawQGNXfPRGXSUH9?=
 =?us-ascii?Q?k1mx8g1CjomUguInwU7iG2XiRC3V70+L7AuSnbIrvgbkl/FNmXfJQ0uyfX6D?=
 =?us-ascii?Q?j0UrbYVOtHIa96CXcON5Dn/mbDtIMtIQiKZ+1ebPrEiQXyLEHF4LYlwDgIxf?=
 =?us-ascii?Q?gt6rHekJxpAXFjmdgxWLxufeKrc5WTiWEPY9mMaC0wD5zH6P8xt3LTceZPAI?=
 =?us-ascii?Q?zZe62J2OmnN600daJ/hDGTDYFFGtIO5pPCiInUIx88aHcRZg7o7VfEWlAVZN?=
 =?us-ascii?Q?Zpbt4WNDySaAhcQUDicb1I/tkHRGsoevM9W5X4F1qXowbm+6Am+2X9Seo+jk?=
 =?us-ascii?Q?ZKB4emSKJf0O6rmXS2eYpxpBdKZ3MFA/BIrS4aAIwyDgk4N5pa/MXAu8fR2z?=
 =?us-ascii?Q?3UyblC9vdSapEnMEe1qUCCMIyiZDLvfoZyQnqZ6F5fRD87eJ+CtRcu29KQQi?=
 =?us-ascii?Q?u0/X65Sh/L74TcXCr4KdZPyDeDBCFWqW9G8S2teb04rT5Gl6M7hDSwOEYxP1?=
 =?us-ascii?Q?WuAViMpskn5w42wKQhk+oYhyRBpoqzAuc+FPAUWNqG1HGGf773gcLHroachb?=
 =?us-ascii?Q?Mf8CASL4tQXdQ32YXhcEjNt+z68wzWf4786xQigtbchVOGT3cHxamWz1lcTV?=
 =?us-ascii?Q?LRpteuSTnOYfa1jro11OEhMrKD9AVZjK6rEr2gkUECkZ4kftCIFmP4pN89hE?=
 =?us-ascii?Q?q8awnYQP2YV7UW/+qBGR7/81NRxTGag6TgR0WXPfrehLHqaQtCxAIrDBxfVQ?=
 =?us-ascii?Q?GiK147O39jt1BmxUrVJVQTZFuwG1T7LvsYE8d78/3zwrK8Hd+uL48ESSyygT?=
 =?us-ascii?Q?hibO41ws6npejYKOns3mJCfV15XCY9yoYeL5Wcad6GSlJlazCL0kCem7GmJN?=
 =?us-ascii?Q?FTugo6AuQG8Z9KZk6hpsDEWTeiQLLBJ6wHhGnKcQ4n5Me5LRduP2sisky38S?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbdcc98-c569-4cd8-1e9a-08dd40577dc4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:24:27.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06MpA3w71WF8QJ6EGSPmc5Nc8Am916gRNrUb/ygT3rklh7YQcxu4azBF8H/HBrAEsXTET0INlVbK8Qe405u1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6421
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:24:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17108

Hi

This patch series improves BitBake's git fetch mechanisms.

The first patch is a _working_ *proof-of-concept* and should serve as a dis=
cussion base on the mailing list.
Currently, it uses the `ud.shallow =3D=3D 1` switch. Maybe it makes sense t=
o add a separate switch.
This reduces the initial clone size from CIP linux kernel git repo from ove=
r 3GiB to under 0.5GiB

The second and third patches add support for tags and lfs when used with of=
fline builds.
Offline building is enabled when `BB_NO_NETWORK =3D "1"` is set.

General example using raw GIT command with the Linux-CIP repo `git://git.ke=
rnel.org/pub/scm/linux/kernel/git/cip/linux-cip.git`:
- `depth=3D1` (shallow) data transfer for Linux-CIP via git/ssh is about 14=
8 MiB (default branch)
- bare mirror clone data transfer is about 3.91 GiB
=3D> So the bare clone needs 27 times more data transfer than one shallow c=
lone.
=3D> The shallow clone size is similar to the size of usual kernel tarballs=
.

As long as `ud.shallow =3D=3D 1`,
* with shallow (first) patch:
- BitBake always makes a new shallow clone for any update - as long as no b=
are clone already exists.
- Therefore, a shallow clone comes to a similar transfer size like the usus=
al size of tarballs.

- For non-public repos: It's possible to use SSH agent-based cert auth than=
ks to GIT/SSH protocol.
- So there is no need for an additional HTTPS token, as small cloning is po=
ssible directly via the GIT/SSH protocol.

* without shallow (first) patch:
- BitBake makes an initial Linux-CIP bare clone. When `ud.shallow =3D=3D 1`=
, it works afterwards on that base for shallow functionality.
- This is an advantage for updates because the data transfer is probably ma=
ny times smaller than for a new shallow clone.
- On the other hand, there may be very many shallow clones needed to get th=
e same amount of the initial bare transfer data rate.

Patches:
1) fetch2/git: Add support for fast initial shallow fetch
When `ud.shallow =3D=3D 1`:
Prefer an initial shallow clone over an initial bare clone,
while still utilizing any already existing bare clones.

2) fetch2/git: Add offline build support for tags
This adds support for offline builds when tags are used within `SRCREV`.

3) fetch2/git: Add offline build support for LFS
This adds support for offline builds for repos that use git-lfs.

Best regards

Stefan

Stefan Koch (3):
  fetch2/git: Add support for fast initial shallow fetch
  fetch2/git: Add offline build support for tags
  fetch2/git: Add offline build support for LFS

 lib/bb/fetch2/git.py | 113 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 29 deletions(-)

--=20
2.39.5


