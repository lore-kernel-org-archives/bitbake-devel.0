Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9756C021AD
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 15:01:04 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.114])
 by mx.groups.io with SMTP id smtpd.web11.1129.1739286053053355666
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 07:00:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=p566mb0V;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSTmfIqliBH4jarx/QkbPLXvbvaoiShCmtP63vjoZ08h9PAO0kdSOjIkDlJb6WB4q5rdkuJE01mnHXzwJS6YQ1GAuMnqiJoTeYTTCIqAaH2Yu2+DcOjayBa5+cDHCjnAxGdzkA8Sz+EdBHVo6Y9+Ko1nN4J4ZM9U+jnyl4iztqRzVCsa8aAaXsswsc5xIBJgSryt/C1e4wtteijA8/NqcBUpW6SwrVNOo2HSqzNPrXey1UCi+VtEt/yl/8ouRXqNlqjM5wiOdLyRJy9tXu5t/lWyEre/mBh9ngwGAAAy6zd/1lMwlwlnFLB5h/mIZgKTOSOXS+nlzHXV8yoWAHtJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGN3YPCE/fZyPFoFez808nQbHnz7Tt6QB3XAt1LwNhk=;
 b=uxU4OMhsXq6psWUwvZm3Ma0IDFugWm7M6JzROBCXzHakwzFzC+7TvgIV4m33XfWuZVCWpfRJMM9tja3GNLX7ePIFQzoF7lEMLAoCQlYoyjOINdurWfRJTylomqzr6ki7jjuTZQmuSRKkbH2F0NieK/RMASneatnFUyEaL89vnlww8sseTIwwTDmSmNP0rSRN468fgzgMASBD7Vzxrdt1kxQ4mFuO2k9Jo2mHbheObQpYzJKc/9kGDN8Vb7Ld337ZpMQPSQJHE4LusoKl/BQg+JoEuG+g/7slb2PzTpRkrojps780gJDUILQ1neaN8ObUpFRJbboDBzdv2zmnRznleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGN3YPCE/fZyPFoFez808nQbHnz7Tt6QB3XAt1LwNhk=;
 b=p566mb0Vw4fwgbL1xlE625PtTQaeCPyqHnrViUmFpbAj1Hh1YPRudoDEWYolQc7fB3aiciCmuoW8FRo/F31ks+wNezyIDsyqqR2DiqU6G4e/rmrOp2vQGSdtwFOxOVbh1QUd0FGWni5P6SAtkXbWmtf3fdlT4rpcpItZjePbfZRzZvBO+fEo69P9dNyWX2ZKuuzYXONafYHxB2p33QX86gu4dYs3lEEl201FWR6cL8ZtyFEvVt0FjI5aj4NwHuY//c1uXUGzUK7rlRt7mJb8FOOiS4qNESAR64Xd78yXIVaR6J+rAKV+0ikgo1r6ZWs0ZanLgHOsv8RX5IbCPjwHJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB9840.eurprd08.prod.outlook.com (2603:10a6:20b:613::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 15:00:46 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:00:45 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: openembedded-core@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	bitbake-devel@lists.openembedded.org
Subject: [RFC PATCH 00/30] Add vendor support for go, npm and rust
Date: Tue, 11 Feb 2025 16:00:04 +0100
Message-ID: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8fb428-812e-42bf-1af1-08dd4aacdcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T1V5HufOdOuwE+3uKOI0eTM13k1Keyu/6TQZOKbjAqzes5xIe14v1vnoVDfc?=
 =?us-ascii?Q?b//KW+Y6DKUKanNcjbSdF9n0t7x8kMaHEh347MEQdxnBl57FiHt6czfThPVw?=
 =?us-ascii?Q?iEI9rXHxF8kDfN0CvZqyBwk7E8FlE2j4lcCMYTGV0F/2mXJ+3dGnBrSd9pfp?=
 =?us-ascii?Q?bNzLjWkEchSYf3Z34AjksnsOAqB7XeltxCwRVQSb3aiZ9ySPYYwoC4YLQwLj?=
 =?us-ascii?Q?0Xv6nxUoJzOEY+FsVfiliWJVHnsbIo4/5+U9FT7t+Tht71KjSqfCKjRmwX9Q?=
 =?us-ascii?Q?EZ32jLei1TCI9HFjxhhxfP2JWxYFzB08bO9FriDMq93DUJyIKW0mzlL9iQmN?=
 =?us-ascii?Q?wTbX/Hs3FoTQutgifoCmctZazTfowQrth86gaxTJf7O9nEWMDHPA0LwqJ868?=
 =?us-ascii?Q?HnvhA0RZ7gQb0zekpONAn9uSXc1EpDaFk7diXqpIfcrzgLjPH3BpdeyVmBTm?=
 =?us-ascii?Q?bprdh68Cy3GSXddbpfbXSaCyF3JJtmwn7wJ/QcHIpS/JX04m6NxCTFpRu7SB?=
 =?us-ascii?Q?g178gbHSeUidksDPClvwkobSpFAjYK0mi332qL7J53BBdppG6ql19ew3RMi7?=
 =?us-ascii?Q?uV7JQtqPL9NT1FxoJMHt3bVk9YRWwIEfYj8O0he0nD2CfHqCMexNYwXWwhtu?=
 =?us-ascii?Q?EvQfanImTeoQKzAAdj0/h+aawwuThFJx1uqGSidWy6cmJL+mWIDyZRQnwKdB?=
 =?us-ascii?Q?y4Ez8e8+Iu+TPCQhfkDWDl663PwSyGN9N/Det2/sFXX2ys6BiWnspReNAbR0?=
 =?us-ascii?Q?MIpcijMoQZea59VWD5rV1af46Giv5XWsDsv8rJcZwHM+zJ1EH0LQfEenJDqT?=
 =?us-ascii?Q?NxW5wOlzh7UfMoa+Lgv+QWtJx0aQp1eF9+AkLaDAtA1LvjmZHc1gxaN8/xD9?=
 =?us-ascii?Q?+aDiOJlW5eqCYH2nRdrvnywK7TYDj96IO7lmRKQ3FB19QYSXndIH60jx40o1?=
 =?us-ascii?Q?SnNrD6ONOWcBjQHNiR3zzE+5BnzBf5v0n03ga8O+ud/42ZuKcEyiSz2+NE3j?=
 =?us-ascii?Q?6xAZdhHJ4i6qp8u2z48XRn2puKGzNZEcXmswOk30w3YR7vhwJcbNg5nfCG4h?=
 =?us-ascii?Q?8GRopHGdqc3Le7+E4kKeVrXYatvheUaHESwlIemv3kLMBv5BZjnANuO9fTJJ?=
 =?us-ascii?Q?/KRS1rCsC1iOQfX4K6TqYI8mIHaJIpZg2jfD8cfLT6PuESO/jgV2ZxBwidFl?=
 =?us-ascii?Q?YhpdaSkcVuQx79e0hjO5l837EcSajlYUfSIxNYris31xI2ZFGep5itFxXPhP?=
 =?us-ascii?Q?QyfWitZOklkBpUWZsLKetJQnqQLAp76h9RD+IBBe+YNR6rjftfRUpaFd4fwJ?=
 =?us-ascii?Q?+aQavVfSkHfa0pNbzsnIFGHPC54+ZIQ2z7//DD3XJHTkq/hc9DD0klVmH/mB?=
 =?us-ascii?Q?F9KqxjbDVEn8intXp0BHQKABG9PFQm8sKByxmp4SYwPCXq0m+5DSXaFU1QbC?=
 =?us-ascii?Q?XL7BmAeDsLcoNSUOTM6ZNjZpqjekyB1g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FPQYZqTqw9wgSVFbVsEJXgs9L8LUStZN6MlZ+RxajvW7JrMUiBT09x0SBI0f?=
 =?us-ascii?Q?raiDGIPlwRDZtl8hQUe4jQ39f8hVm7Eu50B7+fcvAbW49SkXbIvn53iPBuM6?=
 =?us-ascii?Q?5d3qiEuacoCVApAWLjV3TWiajqBmNBtUGzNE2cPncQaR079lK34/BXjKJJuc?=
 =?us-ascii?Q?g6jhpU6jzN755Zk/eiLTBUCPrY/T+jYaQVdAZUKOS3VeShc40g9+ffgLgLUc?=
 =?us-ascii?Q?BcAEervqGJzghFs874DDCZ0V99ol7tkmHV1PcqX1jFHZVMvgHfSucoYE+mL1?=
 =?us-ascii?Q?FG124EMbbLW0Z+Pwb8NY7Zff3GPf+oVoQnXodw19Bf1VGff4TePTZixdG+YV?=
 =?us-ascii?Q?fyNsWWuRaUUFUKDrbFEVB2yFhZ/Svbk5jKTiGy+opYxbqKqxj/eOL2QGTvV1?=
 =?us-ascii?Q?FWNdCEAyni0EUV84dqwwAvbDvxdxq+eVIq3ELSJ67UpwatzGf34CB1TpeYRL?=
 =?us-ascii?Q?drP323p3OrLBESANftErIrV/DyyN++fOON4ikev89tMafhk0YQMHxUUgZMMc?=
 =?us-ascii?Q?k2kR4LlS9dzBk9ByTyqm+YOfkGgml5J70QRMIoDwaNbU2C3ZImXxDY4z9LKd?=
 =?us-ascii?Q?OZn2WYqQWoSFSSSy4K7MbhUfYUrbWhTKlo1WHqNfU21FBXttbgQa9jkuBnY4?=
 =?us-ascii?Q?GXuNoCTi2wHj2VLNNBbcLbRmbWs5+qvOppgD5PKKnu70TSNW6FDwXf8t7R1m?=
 =?us-ascii?Q?7XJSTV3aCk8znF0REKOl2qML1GDMK8ZzHLHGNAZYLOjDWoij1faxbdoNNFll?=
 =?us-ascii?Q?oUeNyUehV7TpTrrfeb3+vX3Zd5vhQg0n38xEWtc6dX8Dg8oV2tY0kVCjFkJ6?=
 =?us-ascii?Q?l+hCYcWSzEtv/4pFMa+0ubcSxWTIBE02iGBRZQ53tzIJ1mRZRDIBOvNzegbv?=
 =?us-ascii?Q?KSMpxZIi5wTtqBKHiXr/vTnES+GIXzWqh23yFkjtNVLMRzUbtb3zjrv1gpFC?=
 =?us-ascii?Q?SCoCapsWsZW1tuTM3ppuKprPpMtGm77LJknQlFHqCgnG4nPnbS5vIE48VVr5?=
 =?us-ascii?Q?jN8VkZOGCU0P9EPt0rnuzrOZztMljhFCbbVLKhX0zf6eXEodXYXO5D4Vm1mn?=
 =?us-ascii?Q?18Vlovpa46y/ymjRabWeG9BHQ1kjQxymdJSUB9ZFsUHBYGjStCttaUbE3Tlc?=
 =?us-ascii?Q?wj5QRO8mWewO6Xu+jfV2XRgRoQMMRVY+FESbV+rNXShCr8lQvmRr1m9qwWi4?=
 =?us-ascii?Q?GM46+34ftrdHSULI7rRVJZU3LuJuZ/Q+M959jo5RiQtZ6anX0oPef/ODYQ5y?=
 =?us-ascii?Q?f5HhvY6GbDjhWKX2fsTAnaBgL5gSonx+MA3jV0UPanRHxtdfpwkLvwduN0B4?=
 =?us-ascii?Q?Kv5vN9A/rSlKVuTnwsh6xh80TSd4Xv2pzR0VE8weXME4ay8t3YfIkUPcX9Ro?=
 =?us-ascii?Q?JZgEJo60rR8r7V5PMBM+YlIWL49OUEQ1dZNPqsLoZkTo7fHSNnmbRSg4oPY0?=
 =?us-ascii?Q?G7O3FDQ/xtx7Zl2ERY0tmxO28qXlNah2hdehM+5KDWqLeYGcximrcO7dG0CB?=
 =?us-ascii?Q?NygSMmUL72FrR/8UpVbhByl/L1VjA2oCqppYg+CgwauT/QKX1Vs2xfuRCeOV?=
 =?us-ascii?Q?7dnzsh/wys4o1fI9MCnMBqIzvZK+dUh4OWWbMDdnx58kfwQ2bBuyupi0pTkE?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8fb428-812e-42bf-1af1-08dd4aacdcac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:00:45.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM06+ARnz9Q0sFV1NaGBGOcdHQ4jnwXQkIY7LdCrVxCiCir7TP6vIw3OaG+uMd4VXerMcjUj783b7l0WfrNDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9840
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 15:01:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17192

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The series adds on-the-fly support for package manager specific
dependencies and vendor directories. It contains the following changes:
1. Adds an early fetch, unpack and patch task to unpack and patch source
   code with an embedded lock file for dependencies.
2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
   resolve the dependencies to SRC_URIs.
3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
   the SRC_URI files beside the SRC_URIs in the recipe.
4. Create a package manager specific vendor directory during unpack to
   support additional patching of the dependencies.
5. Add the dependency name and version to the SBOM.
6. Simplify the npm support


Stefan Herbrechtsmeier (30):
  classes: create-spdx-2.2: use expanded FetchData for downloaded
    packages
  lib: spdx30_tasks: use expanded FetchData for download files
  classes: create-spdx-2.2: use name and version for download
    dependencies
  lib: bb: fetch2: add support to unpack .crate files
  lib: oe: add vendor module
  lib: oe: vendor: add cargo support
  lib: oe: vendor: add go support
  lib: oe: vendor: add npm support
  oeqa: oelib: add vendor tests
  conf: bitbake: add SRC_URI_FILES variable
  classes: go: make source directory configurable
  classes: go-mod: make class customizable
  classes: add nodejs-arch class
  classes: base: add get_src_uris and unpack_src_uris functions
  classes: add early fetch, unpack and patch support
  classes: add vendor class
  classes: add vendor class for cargo
  classes: add vendor class for go
  classes: add vendor class for npm
  classes: add vendor_npm_build class
  python3-bcrypt: mirgrate to vendor cargo class
  python3-cryptography: mirgrate to vendor cargo class
  python3-maturin: mirgrate to vendor cargo class
  python3-rpds-py: mirgrate to vendor cargo class
  librsvg: mirgrate to vendor cargo class
  librsvg: update dependecies to fix RUSTSEC-2024-0421
  [DO NOT MERGE] recipes: add crucible go demo
  [DO NOT MERGE] recipes: add node-red npm demo
  [DO NOT MERGE] recipes: add nucleoidai npm demo
  [DO NOT MERGE] classes: spdx: use version 2.2

 bitbake/lib/bb/fetch2/__init__.py             |    2 +-
 .../crucible/crucible2_2023.11.02.bb          |   18 +
 .../node-red/node-red/package-lock.json       | 6096 +++++++++++++++++
 .../node-red/node-red_4.0.8.bb                |   14 +
 .../nucleoidai/nucleoidai_0.7.10.bb           |   11 +
 meta/classes-global/base.bbclass              |   47 +-
 meta/classes-global/patch.bbclass             |   17 +-
 meta/classes-recipe/early.bbclass             |   61 +
 meta/classes-recipe/go-mod.bbclass            |   10 +-
 meta/classes-recipe/go.bbclass                |   22 +-
 meta/classes-recipe/nodejs-arch.bbclass       |   15 +
 meta/classes-recipe/vendor.bbclass            |   28 +
 meta/classes-recipe/vendor_cargo.bbclass      |   46 +
 meta/classes-recipe/vendor_go.bbclass         |   59 +
 meta/classes-recipe/vendor_npm.bbclass        |  115 +
 meta/classes-recipe/vendor_npm_build.bbclass  |   50 +
 meta/classes/archiver.bbclass                 |    4 +-
 meta/classes/buildhistory.bbclass             |    4 +-
 meta/classes/copyleft_compliance.bbclass      |    2 +-
 meta/classes/create-spdx-2.2.bbclass          |   14 +-
 meta/classes/create-spdx.bbclass              |    2 +-
 meta/classes/externalsrc.bbclass              |    2 +-
 meta/conf/bitbake.conf                        |    1 +
 meta/lib/oe/patch.py                          |   10 +-
 meta/lib/oe/spdx30_tasks.py                   |    5 +-
 meta/lib/oe/vendor/__init__.py                |   28 +
 meta/lib/oe/vendor/cargo.py                   |  121 +
 meta/lib/oe/vendor/go.py                      |   96 +
 meta/lib/oe/vendor/npm.py                     |  141 +
 meta/lib/oeqa/selftest/cases/oelib/vendor.py  |  237 +
 .../python/python3-bcrypt-crates.inc          |   84 -
 .../python/python3-bcrypt_4.2.1.bb            |    4 +-
 .../python/python3-cryptography-crates.inc    |   76 -
 .../python/python3-cryptography.bb            |    4 +-
 .../python/python3-maturin-crates.inc         |  712 --
 .../python/python3-maturin_1.8.1.bb           |    4 +-
 .../python/python3-rpds-py-crates.inc         |   54 -
 .../python/python3-rpds-py_0.22.3.bb          |    4 +-
 meta/recipes-gnome/librsvg/librsvg-crates.inc |  590 --
 ...-to-get-an-updated-idna-rustsec-2024.patch |  398 ++
 meta/recipes-gnome/librsvg/librsvg_2.59.2.bb  |    7 +-
 41 files changed, 7633 insertions(+), 1582 deletions(-)
 create mode 100644 meta-selftest/recipes-support/crucible/crucible2_2023.1=
1.02.bb
 create mode 100644 meta-selftest/recipes-support/node-red/node-red/package=
-lock.json
 create mode 100644 meta-selftest/recipes-support/node-red/node-red_4.0.8.b=
b
 create mode 100644 meta-selftest/recipes-support/nucleoidai/nucleoidai_0.7=
.10.bb
 create mode 100644 meta/classes-recipe/early.bbclass
 create mode 100644 meta/classes-recipe/nodejs-arch.bbclass
 create mode 100644 meta/classes-recipe/vendor.bbclass
 create mode 100644 meta/classes-recipe/vendor_cargo.bbclass
 create mode 100644 meta/classes-recipe/vendor_go.bbclass
 create mode 100644 meta/classes-recipe/vendor_npm.bbclass
 create mode 100644 meta/classes-recipe/vendor_npm_build.bbclass
 create mode 100644 meta/lib/oe/vendor/__init__.py
 create mode 100644 meta/lib/oe/vendor/cargo.py
 create mode 100644 meta/lib/oe/vendor/go.py
 create mode 100644 meta/lib/oe/vendor/npm.py
 create mode 100644 meta/lib/oeqa/selftest/cases/oelib/vendor.py
 delete mode 100644 meta/recipes-devtools/python/python3-bcrypt-crates.inc
 delete mode 100644 meta/recipes-devtools/python/python3-cryptography-crate=
s.inc
 delete mode 100644 meta/recipes-devtools/python/python3-maturin-crates.inc
 delete mode 100644 meta/recipes-devtools/python/python3-rpds-py-crates.inc
 delete mode 100644 meta/recipes-gnome/librsvg/librsvg-crates.inc
 create mode 100644 meta/recipes-gnome/librsvg/librsvg/0001-update-url-crat=
e-to-get-an-updated-idna-rustsec-2024.patch

--=20
2.39.5


