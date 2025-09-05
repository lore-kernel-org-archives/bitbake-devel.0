Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A10CCA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.83])
 by mx.groups.io with SMTP id smtpd.web11.14987.1757053273481196655
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=qsdcW34m;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.83, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLhVSZb+t7GUx2gIuR7Y7BdbsJF5TJQ8S1v4PmLwnncFhV2Iynt7CntRwEx0tmiGsb5ZpZ4B+p6iXCbG6LK+CoOoWrrWwZ7rsMmbSWjU4c6OGo61DR2zCZR2FHAZTYnm0ik0I5mwfVW7UTe5vq2vRxCoWShIe8CMq/YTvP8XzuUzeaBh8aKCX6+T2TMtxNo8UwTDASM8QHEvlV+RZd0V69f105OUnP56EUnBe0Iv9e2J0Ur9TX7+eELYq2qzjsUoKwebWIWBwWDeqDYvqT+gZY0T5DQ2r+cM7JuQR0UaUKshLrIElDNW6htAt8beayMXw8O/lrzstCrBGFO1xzdkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHAhhYGbrCxow1zNwwpGZDaw0FZa4od5bKSlQ/viiEM=;
 b=Dx+GuN7WpB9M+axgYm2n7h5KvVPbYvbetXdZeZCg1cfG7Y8agz0+pbBuQSQUumPAiRzStKdG3nU5m5bIuELmjPmZLcTeweRp4N7CqDI4MMCTgOy6znw8riK9nwRJGVVE4THjI7Lo08CwzXr1wQRsWUs59b0G1God+brRdN52xCW8SDOeL7Y+p8U5jtwgpIcfgPUv70y1ueSPVwaxL/dTNAk7u04ipxzpVppa7/P0pUpYv6RObrc4XZ79Vd9mJ+PmAoinH0NVjVHWSqZM1Ze1YWzWTALEGJGzvPz37Xb94hWpwEEtbCuDRQq5piOD0UdC09x792scSQN2n2ygXlVZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHAhhYGbrCxow1zNwwpGZDaw0FZa4od5bKSlQ/viiEM=;
 b=qsdcW34mw6VZw7X0iBYOImyRNqfC6FD5OHzQ50+EHMWtBQB+7Q4Dny+J+j/nFj9V2S6FisFjtNN8RGxnhYfJWJqaGTypFgK7BIjpSuiqiCt2Huvj6w73KXnshNzCaB/lWzEat/ubV4YEn6f06fmgcG/+xQjo6FXflUhUo5CiO2M6B9rSWcUtfhmTt/x5SxOVGy2dqhIOxArCCez4ijh14JpPZUoE0eswNUmxAoT5+FfCsoCk3YXzVQuqpDXvEfTfkDiA6IJAoynj75Noo0HmvQk3jyxcMsBG2i+JDDcx2ImNrWH7lWCzctSjJ7LlHanDB+nMZyxhETaooBDsU+PBrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by PAWPR08MB8790.eurprd08.prod.outlook.com (2603:10a6:102:333::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 06:21:09 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:09 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 00/15] fetch2: gitsm: rework and simplify
Date: Fri,  5 Sep 2025 08:20:43 +0200
Message-ID: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|PAWPR08MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 705ae34d-b720-4aa7-9278-08ddec446747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aD63BCNPEhdGpj4a7wzFauQjZ4Ne0tcG6lE/iOHZrycciygdxHuvF+dB/yvu?=
 =?us-ascii?Q?HiT9NGnWTFI66UK0MfQRcRNkalyWApx4nDSjM115kAdxXjrlp18E/V1ivJc1?=
 =?us-ascii?Q?HVbUnyXPNIqxdk5fIU5UHngwOHmJmZSTlbBvdgxpWkdmQTGZs5I0MMvcwiKU?=
 =?us-ascii?Q?S2Rax7EXDUVouiXS12GKaQc/EVjRqzZq1X5v8dtOCt0DOqVKSHNQKKua7RM+?=
 =?us-ascii?Q?TyyO9V08VfcFttuiehPUb3uZ2WB1PwTuBxIGYe+YzupfcnMY3+3GdM1KhzFC?=
 =?us-ascii?Q?A+fWtHufaQ7kAAf6yuiXP7fSR5nUNn5vHr5N9XewIIRxc1sDl2SHh8x5I50J?=
 =?us-ascii?Q?u7VMiPZ9tvtWXRzDzt4KyNgZOvYzQltKpKMxepmWpIc1IamfECfcRElmX3am?=
 =?us-ascii?Q?4kP0BNs/Q02mm1rYugg/JGAsIFCR/RM5oY75j7OlM0jZlQVsPpJa4Gm/kLJR?=
 =?us-ascii?Q?R3lhxv1F7jw+DL2LGIPIl89r+bMFja5WhefaAfhpqf537sPlnzvuIZwQGfix?=
 =?us-ascii?Q?TAMruEqd2nWQWdOoRlV/mC5WDou+o7puJkjRNx72aRX88+NOJOZHBZJpa4zy?=
 =?us-ascii?Q?Oxp/nxG6DYrC97a7VpF28sVYzVr9SdKHDn6Vvm2BwI/bgHeogd4odFnpHJ0k?=
 =?us-ascii?Q?iv929EVyKBP/P6wO0mCjyIuz2Tcx6DPIngP4/djk4aY3y2EuWZX5Qz4gXPvC?=
 =?us-ascii?Q?OpkYuJ37kbkw3/BiMyqh/dOT/D4S5bYGzVS3bdAjCn/yzQtN8mbKmrzbeVOW?=
 =?us-ascii?Q?ga7S9NONO5LZSlMCIhmJOst/gRY9oqE/sEkmYSoQtR6YYBWnQjYxviMEN3Vn?=
 =?us-ascii?Q?m3P8uLP/qYyZIgPoWLAeH3vfvK6hRiPbldpSutqdtyXsrzI6ew5LyQlDvHqp?=
 =?us-ascii?Q?Q3Dq6BslVRY7wA4/bzI1X9ai3aStfE+sAIDqZlU4MUurLPD02ojP664aH/kz?=
 =?us-ascii?Q?zAqKerMkdvct4Mx2JCSBd9ieT+FLlDG/r3BMBfEl1fwsT2S5Hk5XZ+C736gw?=
 =?us-ascii?Q?1vQxGKJrnqosHylR2lkL6rgFk5yOk7tp9jYwok2txKzVgklClQyTJ26vK1PK?=
 =?us-ascii?Q?U8QaRWeWMpDugPAGg70zB1n12Na0WI/poDUnPOjkvS7RSzZX8OMneKBi4m5/?=
 =?us-ascii?Q?kzjgDBIE49ahldSgu2mAAtK7w8rj1eeeyiuMxUM1+AazoojhpREOXiDN2z73?=
 =?us-ascii?Q?44R7Bcgs6R0Rpqd3POIx54JAclKALa4GGdk5xXeFTRr+/7ILAaJ1z+k0w+Hs?=
 =?us-ascii?Q?tS0Li5Bkk4QwuX1x1DcZ2d4W3d7eWu/kVztwbqHdt2wojh/yEORXe6/3MsVi?=
 =?us-ascii?Q?3rsEzesafkMIVwBEHa7qmx1jQf2+cl+5frB3CjaMBYjEziaz3vZmN/MxgXji?=
 =?us-ascii?Q?iw5ABEQugVhKgy3hCXfr7CPmzlvQCqvUyw5uV10Vnde1NqfOXn067x3WJb8H?=
 =?us-ascii?Q?sMmAzDT6eK6tQp7oErwTLDk3f6TlLhW8f9m1ZUfbeJ+Dr07fPCk0uw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UHR0IsbUYgvHghwQL+FV8BBuoOCfxwqEybM14ONpY5c5REw6V/vI7ShJJqFh?=
 =?us-ascii?Q?Rq+Ree7mHm/q4mxlj+9RY8KUG+qqVt07pdZQc4xp1gJb+2Jzf7ecaCfzfkjJ?=
 =?us-ascii?Q?jLLQnvUa83x2oGD20Ll1wnDC9j2wkog0KotM3Jkex0Uo0RnhZQFHNWrK+vZ6?=
 =?us-ascii?Q?EemYgP5jgP3MAaXgbiT6WMNIWXUNZoxwqAog36Jg2RaaflsiixN4H0l8cjSV?=
 =?us-ascii?Q?U60DIMv1l8DZ3WwdcB5gPG8MdG7W2po3OnhiOqyzNTGn4b8KCOIonm3F/Zt9?=
 =?us-ascii?Q?bteghWvbpKk4708ntGhiopcLn6vxaX2F6rstFjp0rzwyK2esSg8IS2lcKQng?=
 =?us-ascii?Q?fqwsNJ2ovHHuykZVOYoTjRbheenueE5/yOhveE138F+ZW/6huBGI/9nvhpb8?=
 =?us-ascii?Q?jTj/EO3ktpvG6XSEz9erPpLaBWDm79aqxxbVG7zgv8izvIHIbiwjEuZZvwWp?=
 =?us-ascii?Q?YNp8rO4VdjTqyJE419y+CDWzira/k30gg2hN6Cu0EkTUsBFszzOs20vrBjT3?=
 =?us-ascii?Q?wU6oJD9mJjnKQttMbIRZm9jW8U7yivWA5FEjXoeya0Bh+JRkrHHGYiezOK13?=
 =?us-ascii?Q?cYRqEDbyW3GcB5y0MbB+WknTkrRemv15f9lz0UkR+0V9kOkjvCMieHqp/PvJ?=
 =?us-ascii?Q?F6Fo9pN6EfNhxwkTB0MxU5TYwyjtm5rBQtcyJMvNq7VWrhj4kWI9H+lHaduo?=
 =?us-ascii?Q?zD5tqCEJFoR6GZ0vtm+2aYhHn92RuMCJAZvczdvgRkrglBkzeG6FcFM6Mxn7?=
 =?us-ascii?Q?Zho3Qi1PO7eucifWIR441NoOHWLFpRHomKezYpZ6QtHXGIiW9yA/Td1hcwiT?=
 =?us-ascii?Q?RovWW/Y+Xi/ml9kNIKNmeJsla/AvKljCzEmv5IcI4r2P5BhtCheXWutDxhG+?=
 =?us-ascii?Q?kRK4FyY3hzb8Up1C208kzK8xSkgHn9ysIbSskx5s62ORzqD6C6/l/+gIjbW7?=
 =?us-ascii?Q?sx5BDIFGXMxeb8oFx89L2HS/pR00GROajK8qv1/pPfLdBpRarGIxCEcby8/4?=
 =?us-ascii?Q?bIDl2bjoNS2roEqL67jp5TOfwBMf8SW2AJvHlmWoWByRfj5EgnRK1MvhKmNA?=
 =?us-ascii?Q?BRjuKbY2I99HlyEwb9AGkIAS8L+BejXkSNKayDJ1Tb31kq7X9zFyoEJy4KjX?=
 =?us-ascii?Q?48ExG+sMnwnBMqH89aKq0LkPrJl9uVYyeCANLfi7hhLGGV2YB8Cn5gtOWZda?=
 =?us-ascii?Q?tRZXrxrOzyQc9fHV6otyP5h9ETTvQAZm9rPjnRJhYYwarZXmjYmGJ+auKurX?=
 =?us-ascii?Q?59sSH2XhQna9GWpBLvBrY/bEk+/cTZKrIpEeRebDBfafAxJiGryv7TNhRqPH?=
 =?us-ascii?Q?ub2Eh1tOdAg8xmBloHiZ1eSwG0yUtvHuFze7XNkfJL+CCMWb9EGj6W8FP72I?=
 =?us-ascii?Q?dfIjXmcSzzACqno32jCuAed5SIcWRH3k9+2u9lg77t9L4dAfWoDQAyRit4Bh?=
 =?us-ascii?Q?j53p+++xatfjQlPSCGHz6jff3MHsHbIFy3WMMddkLTRBZiQde224qrNDQNtq?=
 =?us-ascii?Q?KYrYdXm++5W8wdhfOV7PYL34aj6oj1Ptli65FwVgYv9zmrZVAstRxv5W4XL3?=
 =?us-ascii?Q?dHB6mZ2RA9C3hzqc7CUAaC2r1/k4ECkcE8fFadzTXRH/6zyddM8YJA5KnmjP?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705ae34d-b720-4aa7-9278-08ddec446747
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:09.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+hIp0aQQEkxm6NZv/Imua0ICtu/+GJPpdBHIJjsfi8Up5fmyxAB/7nQHnM5lMq1pA6717WsDCoq4XEWuMeWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8790
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17957

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The patch series rework and simplify the git submodule fetcher. It moves
the properties of the git submodules into the URL and uses a single
private fetch object for all git submodule URLs. The series minimizes
the line numbers of the individual fetch methods and moves the git
submodules details into the parse function. At the end all methods of
the gitsm fetcher class call the corresponding methods of the git
fetcher and the private fetcher object. Only the unpack method contains
git submodule specific code.

The series is a preparation and motivation for the support of implicit
URLs inside the fetcher. The follow up series will remove most methods
inside the gitsm fetcher and only leaves the parsing of the git
submodules and the unpack functionality. Additionally, it allows the
gitsm fetcher to use the premirror only. The current implementation
leads to problems because the download of the git modules is triggered
via the download method with is called deeply inside the fetcher code.

Changes in v2:
- Move test cases for local paths into FetcherLocalTest class

Stefan Herbrechtsmeier (15):
  tests: fetch: add test case for local paths
  fetch2: support URL rev paramter for named URLs together with default
  fetch2: git: replace destdir variable with function
  fetch2: gitsm: remove dead code
  fetch2: gitsm: remove redundant set value
  fetch2: gitsm: remove needless SRCREV_FORMAT override
  fetch2: gitsm: use rev URL parameter instead of SRCREV variable
  fetch2: gitsm: remove duplicate code
  fetch2: gitsm: use subdir parameter for submodule
  fetch2: gitsm: add parentdir parameter
  fetch2: gitsm: handle submodules inside submodule unpack
  fetch2: gitsm: remove redundant check
  fetch2: gitsm: remove useless need_update check
  fetch2: gitsm: use TemporaryDirectory instead of mkdtemp
  fetch2: gitsm: remove indirection and nesting

 lib/bb/fetch2/__init__.py |   7 +-
 lib/bb/fetch2/git.py      |  25 +++---
 lib/bb/fetch2/gitannex.py |  10 ++-
 lib/bb/fetch2/gitsm.py    | 166 +++++++++++++-------------------------
 lib/bb/tests/fetch.py     |  12 +++
 5 files changed, 96 insertions(+), 124 deletions(-)

--=20
2.39.5


