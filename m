Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C3FC02197
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:15:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.96])
 by mx.groups.io with SMTP id smtpd.web11.6852.1738739753081335773
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=5JutMyxh;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.96, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqBcVMItwGbgXUDOYJGnjhHkTjrnBkhb0kFt+Xl/HU1n/wkfSTbOUxUp3gXcBB05e7ydKBUV48gjlgGarS6lDuZ8Ll3ozKUsGXjclCzADwBlb8CMtF36D4m6481cQY/2YZAF7xxwnxl6sUGwmZ903LPNPtZtT+X9E570IOHtDjk/xdyXyA+R+zEj5C2/k9wignUhBOzj0EU/qNNDz5i+yGrZ4nfWfZV05AIYtId1caZL7QStnsZKslavvMgf5l1hSSpUmjV9DhKwYJ+5nnAF97of5Xtx1SeU2bmkSiZO4htViE0OzHn8fGjyOQtDJOWHFNGQDsYdLLPfiKWfpwNcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV7mZGoWzGJLCy0RYUq31esZRWHmC9EhNHe+NR1feII=;
 b=vqMYizOyw+FY44kN+KmMY2mP8k5rUeu+rKjm25Ag/YEGSAjdl1rKDeTx1AW7d5unhwuOK7nik1+HMZ0RPU95AYGwz0zHxBAPcB1FaP/AcUOU1wZMxn0jS65FwICJKmFdrI7LLuVKbcjN90Yuw4W47Y5IeVHcgeDzmnjcwjxqGFa7OXM9C5nxdmdxNZFR+nT3UEFdecqDH0VuHwR1YJaUIP6KavfAie5uZpcdzI+rhBPSxKnwBZlb1LR/+tvPcADDu6DhjvVYFlOLjwSFVglBtVwyR2kMNMTOZuU2oHigDAMFbbVlLQOPb7tjOegVFq5kG7xRqAp5CyGv5/KOqAmwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV7mZGoWzGJLCy0RYUq31esZRWHmC9EhNHe+NR1feII=;
 b=5JutMyxhaqPu0gDWWUO4OX82D/BWxSe3WdN7aR1FI2/QCRcymgGvIhVv/PFDHVerLaoiMeRkNL7DMBCiK6Rmti+XB1U34vSNamyYi5dw/1aRcDfNy6fea8V/OYLtyiNX9SyBnEGCQ/9PrsNmVvRPmy0WXqGi18agzXuYV+4vGWy3FpqJYwvRPdw6olAJp/acIuXe9Cwtr8iEcz4JZL/kLkcT9IWiewO1UyUKZ3Bhmxira7BZjucGeRUng9xVfm0EKUKVNOA21lcezMlgO1G6vaEBNUZQwGksB2YwleqY4wlzvszUgTeeloR4Uz7eLtPuBfaMUmqGG2jOvhGUsXupCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:50 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:49 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 00/15] Make mirror replacement syntax explicit
Date: Wed,  5 Feb 2025 08:15:23 +0100
Message-ID: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ff20ab-3ee9-487d-3b6c-08dd45b4eaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7y9+orVXMW9quh+hJ+P45kJ4LvzYAjv6Kq1szWY9lb5Rm0Cqlg5XmoIDYMFS?=
 =?us-ascii?Q?hF4TLJcZIoCFlucbMhGBo0g+fL3XZzcNRk/x2J3BCOPBMI3eGYEmQJZUijQg?=
 =?us-ascii?Q?2UDCnNAZdr2WkQY4DZ5vOxmElZC6PHDRtpfRNg4qJWQtOj4PsvBVxJ1A16R+?=
 =?us-ascii?Q?gLLC2Ily5cRhfy7WziWcg6d+CxR/UarebAQaiXBDbR/x+cRiM0PxESwhLtwF?=
 =?us-ascii?Q?cjb8t1Ah7i4W8Z2HgHqov0GUUJHyCgbRgTEPBbr71Aj86I8qCYVdslG7q8Zl?=
 =?us-ascii?Q?a4k6p2TTH6+4N3AhypzplH/IChuRP6rxaLnj9PLCjXorqTRljGJwpQsyReNp?=
 =?us-ascii?Q?t4N5sWwX4sz0UeHEN8oLDpFDQs19t+QsP4G6dCA/FSj2tH4QAA+P3rQVJZ8y?=
 =?us-ascii?Q?40z1+OrBaBQfWZbPOP/LcLTrun0gk+qFF7bBUnuj859kYtwgal5tqctLcwWt?=
 =?us-ascii?Q?ZDh61zyqHxU3aPBwYTRDTPNvYJamCWUrp6CwfFFdBc/hJsKy+wN7D7dkkRKG?=
 =?us-ascii?Q?IPh4qTWgD3wb0+LetSa4ffTqyK6Lx+yHzhjTYXfJbT66E2TwUlH13cnpIIFi?=
 =?us-ascii?Q?GKN9fvlTyTMnyKoMsWPD6UvFLOe+qjJxXnbHksImzFN/yqeyBdPLSE/37VJO?=
 =?us-ascii?Q?xwE6sSN9JS/vpt8t2tStG68351TQw7COoAmyW+oTFUTknwBcO/0XDDTV1zGC?=
 =?us-ascii?Q?vE10wIzIOe8KnwVvKMjpD+KFCecgdxJK3LJ6tx1KpSWjEc9MYNuc/SM+CLc8?=
 =?us-ascii?Q?Kby0KwqgalYNVLAynKsy4VU4Ji0X4Cqvl7ewdut7hbwTzdwgrtLNJDtQ0tmL?=
 =?us-ascii?Q?LDtB6yo8uYDTduV7bkXUgweVuomJmAQRtVfMkM1TfimAB7EyRwPH0NGqU/5P?=
 =?us-ascii?Q?XEOK/9Qzr7aT/M5gGzm9Y90u002qv7dpBnym445sXtSWGLX3AvTCnqnWzo4a?=
 =?us-ascii?Q?FI9MDgiSKwuv93DhWvUeeWXahRSkqjDimiMQjd/+eGgtgFCh3xV+3SVmWGm0?=
 =?us-ascii?Q?zr0GETm0Ju8caE9KVzEa+6X7yi30E2WnD3nkz1cpl8l9vGvYz01/819Z+oXi?=
 =?us-ascii?Q?D0xPMN/ko0HKkLc+DTbYOOtNuv8aCarvTyO5FFg41vjWnd4cbs4UOAdK3qyg?=
 =?us-ascii?Q?asuroA5dEMoFCNksISyGvNj3fh1npCP8Zbz25l4E6ApxbTpmfqmxZjly0j4A?=
 =?us-ascii?Q?Sto6NdiPituOyjV7J7+1AjdmKY2ZJZHL4xkzbLwKIyYrPAUiOWa0saN/exPG?=
 =?us-ascii?Q?RLfhtmgCQsYQylshKmacIdRg6OQaYOgDRF78uxNkBrbyOBsozhYpDETvL4bs?=
 =?us-ascii?Q?AorlynkZOKtptMyz0y/xHgFhWi0fT9jnzYqezirSJN95RwDe/LX61kq4id8n?=
 =?us-ascii?Q?C68+TOfk8PKc1qKxP1jpV1SbKs00?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EkCf6Jn5qTI8c+/89TD6Dt4SQfoCsVicu5QhgUrfOr8E5zxEcoMjnrGBu8/v?=
 =?us-ascii?Q?WTHGDTGbxR6vQJsgawdzNZacKoxk7czSpj1tO4tNgsRwuZux3Wc32iTfDdE9?=
 =?us-ascii?Q?GEeq7b7qX9IZRKlyTtuqD5JRuXqfdJxlZuVDe7GMuFnq25AgEgxt7nUYdonx?=
 =?us-ascii?Q?iyZZCRLo+pQmm0fOVfzM16PTdvCF/FX71r8Nm79awAtBXem+yQvGct3rfNBf?=
 =?us-ascii?Q?HeycM4bd95T4CvIo+QsIgaAQ8M57rjQiIcQXzpYm4Sf2obZ0pTf+FDNTA8Ki?=
 =?us-ascii?Q?bJP0qoYp0Nlrni9LmpbF2LdF6na0hbWW/Po7VMQMHXqglCWdOObPqKhZ6R4v?=
 =?us-ascii?Q?BeKEcXid8TYCbkbWjOWkjCTGxqRNLT1vC2H99q9/UNl5cwowbJm2BZIZ1uWY?=
 =?us-ascii?Q?oq1wJwXGkwpdjDUfBsgJ/Yu9KD4WsI+7McD7ajeOvD/BCdIGHDSH3Jpmu8Vt?=
 =?us-ascii?Q?U4RK2LbqQh5FMTdHxZNV1RlRa2LK4S/LrimBxjjr5XkKfRduXmMg+hq15cJa?=
 =?us-ascii?Q?J+I3eT9CHKP50eS+8M7NDIkAHD2mra9DCki/LpSnQIgKQ67Kbt0+TkhXDAN+?=
 =?us-ascii?Q?G0CdLBZNnI6/omDjS1anB4SL5BN6yRz3nQjmSGqo2f8q/BEvq6f/MUochre+?=
 =?us-ascii?Q?Z8jOCCqW0U3QX9HLhGG1L+ds4zeb98JxGm4lQjcg1O7BjEBN9F1cFcEP1Fir?=
 =?us-ascii?Q?2hKkuncXROZxG47cednA591Kj3aLU0fqJSkGK+ccgjLadRK/hKSIk1SKEim7?=
 =?us-ascii?Q?5QnwpE4tUGxnob7fZk+Frrh7SEvtcaZe7qKFe5Tx996XAgzJzn0SVp04aqaY?=
 =?us-ascii?Q?RsvO9zzk/TaUA4OgoyOBdqqVgYvs1rPVPVYXlvn+A9xcsbQ9WY9MEjL91XEx?=
 =?us-ascii?Q?tH3lmK+k9D3ooGxsAJEz9FE+1fVkwzZ+0l2blnHwLphySamu+sOunnOAIG4g?=
 =?us-ascii?Q?IzZtjCymhKZN5lvN85htSFYkMVBmlsp3Xs8jkmpJtBI6DkMUhgkBDrycmw8P?=
 =?us-ascii?Q?W1o9KnxpccH3QbuLaGocdzSJFtQDhleE+SgpcAiS3H3l6Pw+vv7cGi+8+9mp?=
 =?us-ascii?Q?HLCyphmmxLQHhMAui8ugQ0vIt5KGXtpskek/24OuwfP5d8wyaZzeincqfncb?=
 =?us-ascii?Q?WW/JrFBa2ZbIRPvymqmDw8C176FIoUebunUWF0b5xhxaoDZN1nLUyCGGCiGn?=
 =?us-ascii?Q?bMFzvRPFB5ApMKB6hknRTY/uolT1xYs+IVB7gRrVmp1joJmfYrkdHi2t/0YN?=
 =?us-ascii?Q?jEVob+lagaRluOMce516uN2aXmzx7ZjdoOy4zXx1shoIecMj4DBhAxSH8Z5v?=
 =?us-ascii?Q?YXhhcFsHbbF1uwEYGojLY6ZpAi4qin2j2sWkxR/k1+4SXr2tTYjHI8/c7j/L?=
 =?us-ascii?Q?z4glbC3M8x1b0hio4NCuKfxTGEi5l4l5pGPmZW6Yeb+1E/kWc+buzaeNDNUf?=
 =?us-ascii?Q?e6Vy7Nmtfcrs1NXhCw+MGjmyuNFLM1YhyIc0Fu/HgXR1djp6f7GnuehII6XU?=
 =?us-ascii?Q?OEFgV4U/rFxc/7CTmQiCu1zU05p40J2Zdl2rBJ6FyXRNUCTnOnZNdEaGLFuH?=
 =?us-ascii?Q?CO/DcAbeKjkoZBlqZWrm9m6oWTymsRqOVeYg8GLjyR5spcsGMnD/6nQ0Cqwn?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ff20ab-3ee9-487d-3b6c-08dd45b4eaff
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:49.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFTQuNT+NcPpmcKyKw/gn/BJFVAsGQs5yaK++flN5dnQ8BFiRwix3WQF/xOyIBvr30hDy1iTqyqWol4/7xr//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17133

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>


The mirror replacement syntax contains many implicit transformations.
The path of the URI always contains the base name of the downloaded
filename. This makes it impossible to rename or remove the base name of
the original path. It prevents upstream mirror for SRC_URIS with a
downloadfilename parameter. The base name of the downloaded filename
makes it impossible to use the download mirror for SRC_URIs with
subfolders in the downloadfilename parameter. Altogether the implicit
transformation complicates the understanding of the replacements.

This series adds an additional replacement named DOWNLOADFILENAME. This
replacement contains the relative filename of the downloaded file or
mirror archive for git and hg. This allows the user to explicitly define
the behavior. The usage is equivalent to the PATH replacement for the
sstate mirror from file to https scheme.

git://.*/.*  http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILEN=
AME
https?://.*/.*  http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFI=
LENAME
file://.*  https://sstate.yoctoproject.org/all/PATH;downloadfilename=3DPATH

Without a replacement variable the mirror will use the same base name as
the origin SRC_URI. This allows the usage of private package manager
registry together with a downloadfilename parameter or the rename of the
base name.

https://registry.npmjs.org/  https://example.com/npm/registry/
https://example.com/example/1.0.0.tgz  https://example.com/example/example-=
1.0.0.tgz

The series adds heuristics to keep a backward compatibility to common
styles. Because of the ambiguity of the old style, it is advisable to
remove this compatibility sooner or later to avoid unexpected behavior.


Stefan Herbrechtsmeier (15):
  fetch2: remove unnecessary expand function calls
  fetch2: local: use path variable
  fetch2: remove unnecessary unquote
  fetch2: ssh: use common localpath handling
  fetch2: clearcase: remove double DL_DIR from localfile
  fetch2: remove basepath from FetchData
  fetch2: remove basename from FetchData
  fetch2: use localpath instead of localfile
  fetch2: make DOWNLOADFILENAME and PATH explicit in mirrors
  tests: fetch: unify style of replaceuris in MirrorUriTest
  tests: fetch: fix nonsensical replaceuris in MirrorUriTest
  tests: fetch: reenable replaceuris in MirrorUriTest
  tests: fetch: comment and add replaceuris in MirrorUriTest
  tests: fetch: add npm mirrors replaceuris in MirrorUriTest
  tests: fetch: fix nonsensical mirror uris in FetcherNetworkTest

 lib/bb/fetch2/__init__.py  | 62 ++++++++++++++++++++------------------
 lib/bb/fetch2/az.py        |  8 ++---
 lib/bb/fetch2/clearcase.py |  2 --
 lib/bb/fetch2/gcp.py       |  8 -----
 lib/bb/fetch2/local.py     |  8 ++---
 lib/bb/fetch2/npm.py       |  2 +-
 lib/bb/fetch2/repo.py      |  2 +-
 lib/bb/fetch2/s3.py        |  7 -----
 lib/bb/fetch2/sftp.py      | 10 +-----
 lib/bb/fetch2/ssh.py       |  3 +-
 lib/bb/fetch2/wget.py      | 11 +------
 lib/bb/tests/fetch.py      | 62 ++++++++++++++++++++++++++++++++------
 12 files changed, 98 insertions(+), 87 deletions(-)

--=20
2.39.5


