Return-Path: <johannes.schneider@leica-geosystems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D9ACCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 15:12:23 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20172.1762269135428907549
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 07:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@leica-geosystems.com header.s=selector1 header.b=KSQy6HY8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: leica-geosystems.com, ip: 52.101.83.38, mailfrom: johannes.schneider@leica-geosystems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFtrB6/893ujmkBp01GzjuvIzaHX9aeitlLxrRowo8TWc4YcXgGoaf0VNeAqFJu8mRbkAUa3G0gSomb8FxdYEvdH7+MIF7ePUzK1+vUb9dh7kY/PBNbD8vIonls+Fty6vi7V2l2sd6NQk8A9UfKBQCTNKN7dkTQmvtEksqB1l9e84h8JfCkBVqgtXUC0yjvQV+qWRIfNOBStKxNaS8OM8Kn0ioPUDQt7Xo1ikFege9PK/WMcuLCLiVgdV2x5wWBO+4JoQuzfx5eR5U6FcPPeUrIiwQ4Hkggs0Gzd8Vay6PMRJVowfwFWhp+TXqvh81/D+yfdW1UdhZTA3q4ZAyEoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dykJ3JH1tT/OQV/IkMA69JtxeYPgVaTh/BQS0W5GZoU=;
 b=aT0VyGXyjt4H1l3uQm5LYwDfocRwtMZDcPi/iY4DnPgEIjQgw0cEB8xUH6Uy2lH7KQ0R/TNXQLxrqJCwUw8p/1ryL9dexzYnUrlNWojsjlqYZyu8fvcQMQ+OiK3kCGMnVvoWPFYSN885t3jXguP39SByMRsYEkDnXOBpHDAddeJ7sjeQNV2wlxGG8eKUHimu8gsxLoM8hnmTH+1aisPkbFymiBlNUXcr1nPKWhtZAFhTqjgR+3FlubxXIdx2AjBGtp50xGBrXxjVHViE7x3Kem33+TrJs10pcgUg8d+DUeAwVD6UIl+YsJMI7AolznvmezDlBWbJuPFjUe2NAJQiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dykJ3JH1tT/OQV/IkMA69JtxeYPgVaTh/BQS0W5GZoU=;
 b=KSQy6HY8DkRYx92Ne3xlsaaicZeM/KMejw/S7LyRYedQXe03d5jbD1RsvyBQ8TZz6LOvLsf32kKY1GF6Uj7RCoCbaSTv6Bk1qh3HKAtlwAA3rkxmMtHVDJkoaMNG4poXCu2wLNXw/e353E3YCwyE2lxsPv/JuJMrUyQ/OUc2Nzs=
Received: from CWLP123CA0173.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::8)
 by GVXPR06MB9097.eurprd06.prod.outlook.com (2603:10a6:150:1b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:12:11 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:400:19b:cafe::dd) by CWLP123CA0173.outlook.office365.com
 (2603:10a6:400:19b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 15:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 15:12:09 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 4 Nov 2025 16:12:09 +0100
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
To: alex.kanavin@gmail.com
CC: antonin.godard@bootlin.com,
	bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	thomas.petazzoni@bootlin.com,
	Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: Re: [PATCH 2/2] Add bitbake-setup documentation
Date: Tue,  4 Nov 2025 15:11:55 +0000
Message-ID: <20251104151156.3125937-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com>
References: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-OriginalArrivalTime: 04 Nov 2025 15:12:09.0058 (UTC) FILETIME=[639B0420:01DC4D9D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|GVXPR06MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f810a0-4624-483d-1de3-08de1bb48639
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|34020700016|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1JWQo1U1DbuBVv0nVrklYnl8lG28r6KLOyni8B+LbflQptyuLJLMwyGe10He?=
 =?us-ascii?Q?GjE03wMI8MYoqGxqVfpLrXyoE94FDFgapjSnxsqUxW+aEC0FGjmoB4sQUKr3?=
 =?us-ascii?Q?jKJefX976UHfM4UH2LW8o5JWwWz40bII5WDv3HMpSabukXPMBVikeDdqnONR?=
 =?us-ascii?Q?fCRCgxhWAtyQxd3yl852J4VHqHtUX5pDqCjdYNYK5SkvHs2bMa8cWdENjP70?=
 =?us-ascii?Q?vlVXDGZTNy7pd+1PbYPO5NvPrA4j868fJY9A9T0+kkm5L5OaRlRk/Rl0nHlq?=
 =?us-ascii?Q?rfIeexXopNkZ/uQrs23zmW/h8mD6/xP13ApaRbTZuOHZ7IRjseeZuSLkLHIk?=
 =?us-ascii?Q?tVCOZuo0QriA5P5DNMSRn7lsY0fjeGjnmGOlURzyiPLwiGM1U+fZnix9OwLF?=
 =?us-ascii?Q?YddPSHkDEU3jNLqnlwGYxEGT9IEf+SgBwXYy5DRYDa6AXslbv49qjK1BPq6+?=
 =?us-ascii?Q?FOCFgH60pD/mEog7Io9FhoSu8MoSkd2iNgkGrlzfZh9QZNNE/plKjFp+4DFv?=
 =?us-ascii?Q?sjrpijR+0MHrat8O3eWJdrmbh1lT0mGPPcCRlVAdFcKk7MUiYUjth91g8Rxa?=
 =?us-ascii?Q?B9feD0Y8oI65A4BwGocDdUUM5FILKbN3w9RurQfH/myh+vWi2zT5h8MECDLM?=
 =?us-ascii?Q?CFxsMLT2epvzHsd5SPCZ3Z2ZGVEvjuQENFkkRsUH6sBsUgRjb2NsQvtNq4Mn?=
 =?us-ascii?Q?BZ18UWsy8JzaUgc0n4q8/2KHLIS0nkvkdQ3QDpQCJ+fWnARMKwyvKKFB40hf?=
 =?us-ascii?Q?RvxPwtS1FVqUWh5JE3zrQMvpl3j07Mv4qWU8yhJp9CVe0Qd/jSDxXgJsqQaj?=
 =?us-ascii?Q?4/MxciT4SDxIOX0DeUEF8DIgfnoCI/2Fobkc7IojWJKoVXu2mDWDkA5LwbxJ?=
 =?us-ascii?Q?1bSXzSSjlkGmj9xwt1pQhCEfrxh66L33bbI+orfAx2dbdw2TbSaGwpViGGma?=
 =?us-ascii?Q?/iB3g9VKt8Ka0hW+IdxhWBPG0xj9fUnn1LDSp1qipQL3LT1EEHBqkDVvFhbx?=
 =?us-ascii?Q?hLHIZMAB+e9g17uedeOijtWOluth/Anuh8NtgqGqcdWuz90tBOJfwygDqR7S?=
 =?us-ascii?Q?n5btjeqjIFEYEiN5kPv5Wcx77llauXadU486CpM916XsyX4wdHEz1NUuqdqR?=
 =?us-ascii?Q?ZJh481Lj9lDBjoZiS/d8DffedXQ4d+JzctxkzWktL/1KwI0mDod1qs2VkHUu?=
 =?us-ascii?Q?sTo/iVL7pVt6TEEDc+mW72w+dBRHTi8Zrd0hUjm+449XreKGlX2oE3+KpRlL?=
 =?us-ascii?Q?st2Tz07ov8jA/AXzgPpzIQRWH1iEHbSTwUy7vcx8oD98XhG8T1wyK1exIzwj?=
 =?us-ascii?Q?lSJ7tzypk/1Z7q/uvZey8Qp2+RnlCISosup993Sje+ZgjoPpcxrTS4wKvR7o?=
 =?us-ascii?Q?LxzMIXqu5TXN4Dsozhxw6x6boKzwKPpzqUoDJSfv0cJKGowwSYpHWwxA6XQM?=
 =?us-ascii?Q?taKLeo71CEmzVtVZxxmYUnBvgcafRw/Y5C18Z6/Bi0tRUYMZsZyJs9l4nWAc?=
 =?us-ascii?Q?nPcH/ltgqW9k7XlR/iLxKYtUAgzAAButY/B2pVf/yJ4MGfEjPV21U5hEMZrn?=
 =?us-ascii?Q?0SzAJN8nTQMzc6Uu51k=3D?=
X-Forefront-Antispam-Report: 
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(34020700016)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:12:09.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f810a0-4624-483d-1de3-08de1bb48639
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9097
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 15:12:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18253

Hoi,
some minor findings and suggestions:

> +   :term:`Top Directory`
> +      The top directory is the place under which ``bitbake-setup`` reads=
 and
> +      writes everything. ``bitbake-setup`` makes a promise to not touch =
anything
> +      outside of that directory. The location of this directory can be c=
hanged

... except for the global settings, or when instructed to - e.g. dl-dir=3D/=
some/where/else
would it make sense to not make promises, and just call it the working dire=
ctory, where (most) things end up in, unless configured otherwise?


> +To illustrate, this will translate to the following hierarchy::
> +
> +   Top Directory
> +   =E2=94=9C=E2=94=80=E2=94=80 Setup 1
> +   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 build
=20
      =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 config
the git-versioned 'config' directory could also be mentioned?

> +   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 layers
> +   ...
=20
=20
> +      The registry location is configured through the
> +      :ref:`ref-bbsetup-setting-registry` setting. This location can the=
 URL to
> +      a Git repository,

...location can be the...

> +      this could the location of the configuration registry, or where th=
e

... this could be the ....


> +The ``bitbake-setup`` command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

could we add an "Examples" section, that shows of some more complicated (an=
d possibly common?) command invocations?
e.g. a one-liner:
./bitbake/bin/bitbake-setup \
    --setting default top-dir-prefix /tmp/bitbake-setup \
    --setting default top-dir-name acme \
    init --non-interactive \
    --source-overrides /tmp/registry/2025-11-01/sources-state.json \
    /tmp/registry/gadget_master.conf.json \
    gadget distro/gadget machine/gadget

