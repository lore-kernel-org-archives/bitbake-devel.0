Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B84CA100B
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:16 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=PY8Pykz2;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvH8Y+77ucxkGewkNtlH41DlHld4YkCvFCsy9X54xjXv1d0Unv/1+3R5mR4HjWDDhrSrpw4U/j+obJaKsC+xqwX9ZIzd2Bpp4RRouoE+OETo84d1o0z80N5w7OZ+5icjBfuV3+YjYRrazRfh6N/0NQp40NcC+QsOyz9lqIHKJFGgVCvOJJBgavGXr+6zIUfAqeuFWCEXG5EXRE2xqGqjM3oJINzLfzWAaTZ8CEqiE7MtseffbcYtSch9ZJNTR8v1q9p8J8eIKBLA0hD+qFzmqRmuoa/bD5jbNPxBKq1mml88v6jAAs5aoRGOqnSn+WU6HlHBnOBoXpoOCtyJcHaODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2IF9fEwEnUnMtk5pF4IUJ6EDh2/R98M6c6h/wdEOvU=;
 b=vSk+JY3HWOiQt5t8Vr2TDyn/YQyGddaVFWi1+EYwmjz6tODRv8cx7E34lQczO8lfUfgG+nEKUKnNvAdtAS85Wb7a44kPh7D40jbRx9G3bbaI8xamvra3KvBapdC8OA5Np8H4F4tjUJ43vqH3/byHLgOkdhq7C8m6Oojp0Zgx6/V9MxO1t+82XpvuaxK9jockqxHe0TTD2YmtkcRCGV9AkGtVjrrq2BogLgtQ9wqv8vTdSaWSNl9GEEOBWjpIfE4ksygIV7waWH1WSS8XcqGbGRn8v8LePQlLkpm/sU9xCJ8/w9Nprg8lrsu9dsvfejGyeavL1Ezzhw7w6guiv8DTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2IF9fEwEnUnMtk5pF4IUJ6EDh2/R98M6c6h/wdEOvU=;
 b=PY8Pykz2jZ+aF3zFaP4XAUgDbxHQB+XE+HjzW9QpKlAlmH8sKk/D69stpDUylf9IDjlyGMxJOcjAHniNg2iy5Rre5mep7m0G5DJfN389SIZhhPhFx0HONsVmvUfguoxNh29WpHj2cO4KWlCat2irTjIU7/w2LaKxHXi+c0vGy0U9weN+U/doLNFghHgj4h+A7ktsTFOl9ltKSQPvV3iw93wizUTH8XvXWgv2DCiaaAJ7Wr14lcmFWbwARUHM8xXcAi3fu3SU3XeVXOOCE96jwaLs+YROXzPawMlCWI7fyB42qB2WYDIEFEE0m8BYQ+by9CYRa3eNJp2cyVeEPbhgrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:07 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:07 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 0/6] fetch2: add support for implicit urls
Date: Tue,  2 Sep 2025 08:55:01 +0200
Message-ID: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GVXPR08MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: e972e06b-9740-4ce0-c1f2-08dde9f1902b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HQjt57VPM9AmCC08AjqCWh8REVrHvaXcY+Avc3pshehhUji0NGAiaLfwPe18?=
 =?us-ascii?Q?sa/xh8Xrw101SYpLwXMjBy4U5TKhBozYll0Ras0dD2wGsf6WRy5eSBSaaj6k?=
 =?us-ascii?Q?05ZWYFRlm1MNC+wOFPlQlGgiOiS1gNO3cEa8FEnuMXjxCT04H7Dzu1gR9b0K?=
 =?us-ascii?Q?6rD+0Le34FyTb1Zv0PJzjz6TM7zrdfaMuLDFVLV7tZm4HAfBu9XXAHH6EpjG?=
 =?us-ascii?Q?IfbttJyiG224sNzHGmpqMtyyVCtybT6gKj3o5soNvw+Yhzo/L2JAAL0oYYl0?=
 =?us-ascii?Q?G40U4ORFuE6uHbx7Oi3EjWVmNb32MWgx66p/wn3TePtJolB+HYXFp1PRbNta?=
 =?us-ascii?Q?2niq31qRr2a9z+fOsdIX5GHPUogM51LB/KhprielKKEcMHtmg2QErGo1FYF8?=
 =?us-ascii?Q?LSrwkl/6Lollv89egCu0pnZcz7Q5Q97XiirywQNPvDK3XWZdINrjf5lSL4RQ?=
 =?us-ascii?Q?YSjZRJs7DPhe1gXmEAR19u/MC84GOIGHH6w3LADCIlDZKjnTAT5oNmnSdP+U?=
 =?us-ascii?Q?kctOnfpWGpxHqfvfHI9r1hRI/Umr27VZ3nJXfPgcovF8nLOmPlMVXXSSX9x2?=
 =?us-ascii?Q?YSG0MdkQo8yd92KtRtclT1eOIbmu+NPmte0zoXTeXlRJX1frUZsqhniU8B6m?=
 =?us-ascii?Q?5TpfgNLs+W3h+2rubEYhHopnOTS7sfbA9H3H8LCHOk1ED/PtR0Tz86ZePEDj?=
 =?us-ascii?Q?zImD3/OgefkR4HrgPLTYPC9Bd+SGDbhWP9Vo1I30z7pSQ3O39UZoZ4GxjUPo?=
 =?us-ascii?Q?A1RTsabVMZvgCFpIOM7pa5Veo+xYCUqhNpux7eS19p1vPog4xZx1wAZeqqOD?=
 =?us-ascii?Q?HGWR6x1cjJTWWV1ogBYvXzaEiI+sm0p2QnzeV6M6x7NaSR8+c7QI5BLCQecp?=
 =?us-ascii?Q?fg/FZtZJdJkIX+vBAofeNYnqgF5dBrddEmynDR1B4ADSWoIQMyHPz/30vr4C?=
 =?us-ascii?Q?PqQ42Dy8+b3kyiDGlxXIJwY/tYAZp1iCDn4ATh9MCLQ8NCFJy+ET0qM8nR1b?=
 =?us-ascii?Q?BFUWAPwg/ddo8G+PQJQobfSf9wTonNYJm/p04wQtRzaPsX293PJeFM5oyP6Y?=
 =?us-ascii?Q?lJp/ZWl8araCpti/q2EJvc5MYyupFreLhz2TSZlZBaKOI4K+D5gfTnSfCWw7?=
 =?us-ascii?Q?5+SOVOQf1O1JDAbb4VTxbSuNJ6PtcNRsc/1K1/TR+pb6VRYVUOmO8licMNN0?=
 =?us-ascii?Q?4qLoij1F2SVWOvMvZoBkE8dWXnlfkKaJwpRLRxVeuVQJgjM4Ab/O9Q1cZe+A?=
 =?us-ascii?Q?z5OOI5/13PrFf5oToplrFDh/fIMKMuEchX6xAT0fuJYGuVbPyB96ykLvHpIB?=
 =?us-ascii?Q?TidXnOkRm3heeIyUj9UUfCjNRmGh+8bFojO55qwhjGJnO3R56t9jJ13YQMCn?=
 =?us-ascii?Q?DdPSUDycqx0cj34woqgwfCauOerS/6Boychiq0Ivs4z1VePYRnLpuvFSZ+IB?=
 =?us-ascii?Q?BqR6lbQDamnIOngPTirQLtjXmXXsOBpuy7TM3wBsTm3E37EGSOOFvw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SYjJdMDgjO3LJOwEjwpt9zGNhM9rupOje9RCkU1RwTgjbTCy4DNFtxiBQJ85?=
 =?us-ascii?Q?kfQDWS+K4JcERNpAmDGh8JYe5Ece17yCXv9J2PA9QWSfxSyi0QrmqKbDgZSX?=
 =?us-ascii?Q?Cp5JNh4w6TcaxIOVlPBxxhk/xtNS19tjojjj/zDZdMlUhsU6AmrJaWNdy6XL?=
 =?us-ascii?Q?6B4/g1Vj9ZX3ftKD7WnjnrqepDM1RwjwpKQCClN7PxSYk2GbMnls51ZkDxwK?=
 =?us-ascii?Q?Ak9SqfC9FeBzgCCVLRUssIT5FWtclP8uCYBPLtLjnL/7iH1RTHqJaE9QVO3g?=
 =?us-ascii?Q?0cei3eCw9L4u9I3rZntnzq8u5KZLGPt8xryvVagkgdDHbXl0U1khnyTk7kqc?=
 =?us-ascii?Q?ynrCezefGulVldiGvUwJXOz+vzhbwaZ0XgiAF2R4VDO53Xh4ukWEK/YXr9Kj?=
 =?us-ascii?Q?DTYIN/GX3Df9Ayo82Xb6kTg8w7Py/XDoKVJwh1lDiyTTcOSBbLXcqaOMtqHD?=
 =?us-ascii?Q?1WSVfMKPQVtLrLfEsHGqLQ74vX5QnUsEj5efVdtboybm5IuEzv6Co+vilSXZ?=
 =?us-ascii?Q?KRGknKNihrsqR8sZgm+y7zJSl5EjBIQEM5jYVUNADeLTKrMcJ+ZmX9QJoHmB?=
 =?us-ascii?Q?u/N9+Z5sYSKLHbGdUR5Wn42A0C++sYpMOlFu54iWGU+In/E4iDRS5fxq/ZaZ?=
 =?us-ascii?Q?nO0qmJrZK+SU85R6JNsex0PbZfUkpk2oGV2jRFymCFYqIdSYUzlDVKTJQLtu?=
 =?us-ascii?Q?NBwE2h3xyD3Zbt2HCSqGtw78/FTJoDDN27JSZW1YWbD6Hhaj2vAoSAd/8gqu?=
 =?us-ascii?Q?z4vgwwz/4fwKA2uxOugtZLvCfiVJGjF5WSqmsJiSqQ8fwWeO6ItzcV0ciy93?=
 =?us-ascii?Q?12B4uGbG9bDY9MKJPPtyUiHo1UZbvN7CVaqOctvdDj91bgZ/Z+oMTJMRMszo?=
 =?us-ascii?Q?UoeYB/dC9gyFV0woI1mIr2sW8DMdJln53/pHbRAcQD2kCtVwpq1jeG0zOHOs?=
 =?us-ascii?Q?86pjNm+rrXLTa/WkKi56C+/vQm5BQs/Db7xxgtqCAMQWm9Y9L0uGFDrE/t/I?=
 =?us-ascii?Q?F+rlGyhzqx4fnrs9v2ghLyqKwyW4O/xr02j9GkFPpUFr9mgQM90ZuudI0yDW?=
 =?us-ascii?Q?gWH1/bSfsj9q89alnvGFZQpqrQNQgo6u1ulagxQaZBXfxVfhwSlT4jF3sMxo?=
 =?us-ascii?Q?dV2kYLxpOqheWFOUS5y7GNB2Q5yCTKlGeVSUQ7eq+lZboLVkd/C03HKa6biX?=
 =?us-ascii?Q?PcXpRI4prFg/SvGNVAoxGaIYE2gaG8oQv/knnEO0VbrXfZ2kDPaXtxcDyUro?=
 =?us-ascii?Q?lmzH6gJZ0lZpc+VqHrPMyOKVhLphTDf+43wzeM3DWW8k8F5OMlQduZSbxWZ1?=
 =?us-ascii?Q?RuqcFZOEJiNYjGCcB0X2+bU5h2qxb7H2KZJVQc2dkRytwpHJL/rZvgjp9x9K?=
 =?us-ascii?Q?JovXqGl+V+65jsjia8FNRD36agiHf+3v0VndOnc1Elqas1X3P9FM+5sAcX6T?=
 =?us-ascii?Q?wIbjLMSRFZePWyke+uFV0+arQDfwBN/7caHFkXN1hQlQ/TwHziL88q9vpgi6?=
 =?us-ascii?Q?A9I25uKc2vI+Z4BUb6aY+AjIy7oGgHk4YY6KXDda3Elt3E+AlvOzXRMOKs14?=
 =?us-ascii?Q?6jRWY7JIRgCdP20hT2qHQ6Ha0boa14kF/XS8TaBZybkEn06PNujlwFvDE7/h?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e972e06b-9740-4ce0-c1f2-08dde9f1902b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:07.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMZCiqr7VsULpkjvvwFEsOp2LtSLptmO7v/wZM3/ape0BWZ/1etTq7xFhFAXLvU+sjpJeijNKI0TeCHgDTR3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17936

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The patch series add support for implicit URLs inside the fetcher. The
implicit URLs could be defined inside a source like a version control
system (git submodule) or a lock file (package-lock.json, cargo.lock or
go.sum). The integration of implicit URLs beside explicit URLs
simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

The series remove most methods inside the gitsm fetcher and only leaves
the parsing of the git submodules and the unpack functionality. It
allows the gitsm fetcher to use the premirror only feature. The current
implementation leads to problems because the download of the git
submodules is triggered via the download method which is called deeply
inside the fetcher code.


Stefan Herbrechtsmeier (6):
  fetch2: rename u to url in Fetch class
  fetch2: call functions within loops of Fetch class
  fetch2: add helper to get urldata in Fetch class
  fetch2: add support for implicit urls
  fetch2: gitsm: use implicit urls feature
  tests: fetch: add test case for gitsm implicit local paths

 lib/bb/fetch2/__init__.py | 128 +++++++++++++++++++++++++++-----------
 lib/bb/fetch2/gitsm.py    |  46 ++------------
 lib/bb/tests/fetch.py     |  12 ++++
 3 files changed, 109 insertions(+), 77 deletions(-)

--=20
2.39.5


