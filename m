Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE308CD98CE
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 12:01:39 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.68454.1781264346696923401
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 04:39:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=sSLg8TYM;
 spf=pass (domain: est.tech, ip: 40.107.130.29, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVTMVj7gKwDWgPnzjMA6ObhCGohYsaN6j1W6UP/M4BX7vyHAiXXSGYnKEkTKGIKs1O0t/Nf8PmwoRr+J0PMgY3jrJR25xcvozzIeQ3izObHnvhL3eh3mNLjolVn4CbpaW+A0G9uGKiOL8ulEdtybiBdTxGyNDukexnvJ5r0W7oqgRNwNmc0YzE8s5VFDQuAElDLrBPWfOj05g7RQ6+k2Wm0GPkruwB1lUJSyPvA52rURhiGjchZR4RqKaexMdIAxkMFgbW/d0dsu94YMIZ3bAJsplpq5Si39/ZlByYULY93x8Vr2cpXrcGQv5iuoofuMWmODrvZcprN8ALi3z0L1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYNuhIGn+mk211Orat6YXd7ymh5IvHUmb30/bTAb1d0=;
 b=bxhJupn+Ququgmr3uTCnmCdT3z1XraPubMwVvYTfhrRnlc6iXsGgnk4rZ+p/RFtO6U1v+BrljA2jtfJ77JJVcJzULCVFZrhWcbZlFTezI04oUp09Nmg+sNjeQJiCqh8dlDhm21C4RZ7qGdfBd2JPAm10VVYGSRZ4aZ/v+bYPutAHIfY3GhZWosHoF6fk+qQpoADoSKLH7+Nn0BjAUGtWL4p2E9WFhvW8sYHo423KOrL7JSeUusmEC9XsxMIDDKNgCCP9PZ2xilB1h+DvSffH1oj6gYAsypFBEhGR+Ma0EjQDnKx5GL8r5VIWZCTEMoIiBbkayhkfIvYgLjLj/MgqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYNuhIGn+mk211Orat6YXd7ymh5IvHUmb30/bTAb1d0=;
 b=sSLg8TYM9n20vzzYLY70Ujis3dq2WTMe+TffyxIWFjVmA4zaTSFe/HGWLzNOQ7vF49wXE+tKisu/kvC0iUP75rZYhbUe6/sybmRtVd55F9ALeaOXK+p4rrUV9o6e2yVRgc1/JaJdaCawZCifMaJuaAH0BlGT3PTqmTY6fTrnLRIRuIu0T2z+prU7X/XyabJZkMCKn10wrzHBu3dccSOteKifrrV92OCyF0xVWUv/ZQergawFg0/4YIRHxovuK0d5+9Bvs8wrSmwTvrMsL+QfeYqnZ2+/zHiumeEyUFAlDF3H2a43J2LAw+3O8dp8yLrgwmujV1aVx8tgdmkoUzAg4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0693.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:39:02 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:39:02 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Subject: [PATCH RFC 0/2] bitbake: Add basic landlock support
Date: Fri, 12 Jun 2026 13:38:30 +0200
Message-ID: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ND3ZzEvJSc/ORsXTMjw6Rkw0RDU2MDUyWg8oKi1LTMCrBR0UrRQW7
 OsUqxtbUAGocNPGEAAAA=
X-Change-ID: 20260611-landlock-621bc1a15305
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781264338; l=1547;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=ZnkP/iyCUCifIqqkzewRYgcCeYpXwCF0kp58nkt+338=;
 b=zI5YrxX8M+TTew43xmciKg0uSnA+AgpqI5a24yVD8k4x5Hc1qtw39ZB85AxEbQ6wTYpmLz+EA
 Ci8c++66/kaAsQ9R93GgCdR3sKhnlB7dDKe8flsfge+j9kiPkWguk/f
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV2PEPF000239BD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1bb) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0693:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae45e98-95e8-45c4-e081-08dec8773393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	PER/1Ze8/4Fvwqa6zEw9TOFIhBTNbDOPcgeETAQCgXHsiUfY8oY4FJ/rYJozw8+CYz0gIshZHeRCizLHMGEOPY5Q3XYT1dTp7oXqhantJYoaUBtj6DU4jJkRKbgpYoZeGsvQi1aE9k+Et5el8lK6EVKyrZLQYdZhPWo1pnqckMJwjH7naNrsuKL5PUpRow0ogIZMzgY1naqm1GCNQoPDjP3KpvrcrlxZCyGJMdrGjeZb/9hVuptyjOutrxa8qo/GYdo1t0nzMBbsbx8EnpmFmcsjAfaoTkhFw7Y5maSThtDvHqr4uCHU5/rDQBVo7k1wNhfugv/Uvd+Gtzl9uuYqLTs2RbYCo19E97q/2XxbsEr/hDX24jwPpvbSKw0I/QhhdUe24UaBfnu5U2VG9OnDjM/lP2yF4LgdFws5DB8n1M/8ydOJ331QBNtXBasiPnfOx/gBEjt31/QXY7jpKMv1QNkFxGrzg6KDBzdGFd6fEqSRZOMUEjX7MNzI6Q/tdgi9Vd+vTtDPDDIDeczjhcxWfPA5b49ovkmQS6VEyqIBl8ACdW0LPCThvrjLMeS1ggDcLcjrwpMTZqVjhrTHAQj0zqkPtJx2cJYwB1ZuZk4dUurPixHq+0vOz/9OnHh637hjY3XlKocBsJtRi8/bFJWZvIQtyPNt1/9ezjsGaYuQu9IRWpI3toUbOQTajMRa0WNT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2AfCaZM94iavi/Jlz2i5G5WaSuSbO6GI0SPhGLfJ60C/EPsWsHW8AYTlUhWa?=
 =?us-ascii?Q?ZBJaZNLxSlhPEM4AoDBBZPQzgp2QaRP4NRAM0haZAPiViPZYNE9ubO1jw2Rn?=
 =?us-ascii?Q?x1G9Xh174fM1X6HDL016uPjpNrB3ido/PHMF4a25C3ZlCyYthohSm0kgEEHw?=
 =?us-ascii?Q?SwdVDF1RJkchvQMKmMGaQw7l2EBNWuBrVfXrZj5LOX7R0BzYb0wOMvKfjGyS?=
 =?us-ascii?Q?yY2i738YqS3lQZ1CjB7ZvfFmp1bqUTGD7emmW2cCwMgN0DLosMST7wveVXSD?=
 =?us-ascii?Q?ngE4gawGfdkI9KoJImEeq08xtWncVTgcXGXFrvFHYPz233LYnjoZ64JY2F7u?=
 =?us-ascii?Q?k6gFZoZ40MwvHM3PJgLAqtgg8mAeTl66eDk3Nd2Cbiht4a5QR2eGUcN1XCzq?=
 =?us-ascii?Q?lHs1h76VHsuGVKJG/RQCxXxRkPl0uczSDqCPOg+emNuUI0ZR28Wmj8tP1Tgp?=
 =?us-ascii?Q?LjMSZIRsApXAWzKNYm23obzk7hqPzVNr5ME9NKFmJj7V00yexl70j9CFcKIN?=
 =?us-ascii?Q?6FZ9jWmqORCIh/eXaba2TrOpYv+PGwt0xIpBb71z8Yo+ws8aaPGj01CRj5op?=
 =?us-ascii?Q?s909upZ3k+H0dAC2SEPdjNw4XDF/8Ze3iXske9uJ8JZaM2YwUjPRs5Qh6B45?=
 =?us-ascii?Q?EBByAXSwUqYAqrfr7zOy03gdDgW0s+VXAB8BhxrXgTI6TdQtICo4YDrwGK7Q?=
 =?us-ascii?Q?YJKsOjTVVnLbGdjQYiwwFj2xX+VLHUpnL7f3o9+n/6Ryl/kfjkiIwuXMtgwO?=
 =?us-ascii?Q?LUCS2xmezUrPQzI8oUH4NsdA2b1XXKjBzVPVNKTI8fGvf9GoRCEfuC7e7WqR?=
 =?us-ascii?Q?S18EbOF2Fv/rEG2GS+gIvdfs9x12Ojdd4LU9niGiu839n2taemoWC4TX4Fd2?=
 =?us-ascii?Q?66n/rY9mM/Ou14bkMKmZB3ZsjLa6x1XZW+KZ+kUkFHE/4Y0/N+bq0d/rz8Hh?=
 =?us-ascii?Q?P3LrQ4UE776+nJm+2SfQtx35OSDOOyUF02nFidz2ly4aiVyadsWqArsT1vyq?=
 =?us-ascii?Q?D0FFBkTWhsMY0aqWDayrx8AWCzInAgDsIp3FBZ/lIcZyDB0/Cq/yWrF5C+I7?=
 =?us-ascii?Q?edyDrfbWqvu3uCbCmBGf08F+RN864ciWr2/Y+3R9aC97urW1qoxixipjFxRy?=
 =?us-ascii?Q?3RHgbAiE8xqtmPCuzP7+05xFgj/WgEAWhU4R/xfUBkK0XWRBu1sz1vcuUaSh?=
 =?us-ascii?Q?n1Rqhhe3gQl9w9i6KhPtiGZVZBqQduJdRH0F4EOgiRkya2jh44YaenDWbKxU?=
 =?us-ascii?Q?xUV8Alla6nu84MRasxkQ1F+MWMJ/a2z/Qurk4wAbhEcU5wjo1bi8Y0OD5IM5?=
 =?us-ascii?Q?aRtMyytmswweQ5+EhtLtPsGcnhB5W9FapemptDJcXsX1m4KnvqYr+Qk3HjFx?=
 =?us-ascii?Q?aWSwpLRQbuSs0vVLg7oFmEYci8sHLv4iG5JZArvgCrzWd3wjFXRdHwNueEQ6?=
 =?us-ascii?Q?6H3FNS+708IfLr5XAlIJ0g1AwAy07SUferQyde4LhHMxyYuHeXxHt0KsYKtn?=
 =?us-ascii?Q?Qm/5It79BmR2mrmb5FelVCSArvaTCjUJ7Oz0jKrOL1wqc9yqW+tGbq+rNOZF?=
 =?us-ascii?Q?emhFyIW+Hhu3lgKsKKNuEm4Zt4EdlEd+u8IWHOqLv41KrbV7yqg/2R61iImX?=
 =?us-ascii?Q?vbYmsHHa5u/wU3yLi4ITZO6LIuHLHfKHrDV6cmgKhvxFsx9e+NWlFxQJZNua?=
 =?us-ascii?Q?kAuPqyrZQ+jk4/G7LW2xB9DiqvuYun7svKpgwkwhVJYnklu7jjkedajgytMz?=
 =?us-ascii?Q?wOdZGPjjzg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae45e98-95e8-45c4-e081-08dec8773393
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:02.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRbpa7PnBsmy+RG1K7aeCEQnkdwMBJhfWCpiFVfAU/oxYPVP7j8SaSF10lcRCeZ3a5+qoBK1LcfCbG9TQbh8cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0693
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 12:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19672

When current implementation runs in an unprivileged docker container,
basic networking will be allowed by default in all steps, ignoring the
network varflags intention.
Introduce support for landlock blocking of bind and connect, providing
basic support for blocking TCP.
UDP is corrently beeing worked on upstream, but not yet supported.

Landlock requires PR_SET_NO_NEW_PRIVS to prevent escape,=20
which is also attempted, this prevents privilege escalation from child.
devshell and related are already tagged with network varflag and
can sudo at will.

syscall ABI is asm-generic, 5.13+ for all archs except alpha.
On alpha, we leak 2 fd:s in the childs context before graceful exit,
which is cleaned up at child termination.
Don't have an alpha target, so this is not tested, evaluated via=20
static analysis only.

Landlock also provides a future possibility for filesystem
limitations with the purpose of catching bugs, and preventing
persistance of supply chain releated payloads. writes to f.ex.=20
.bashrc and friends.

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
David Nystr=C3=B6m (2):
      utils: Add landlock_restrict_network function
      bitbake-worker: Call landlock_restrict_network for tasks without netw=
ork

 bin/bitbake-worker |  2 ++
 lib/bb/utils.py    | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
---
base-commit: a0158cc8d8f29233a9ade63a4c3ce2e939c4bf16
change-id: 20260611-landlock-621bc1a15305

Best regards,
--=20
David Nystr=C3=B6m <david.nystrom@est.tech>


