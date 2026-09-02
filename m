Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA0C624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8927.1788343080514925298
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=eFyyUJQu;
 spf=pass (domain: ericsson.com, ip: 52.101.70.4, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WisrpziDZ/31pMms7qFxUtFh4HXneUxi1DcguKYM2I95Ov/9I7dYwgcvwnr8xxKlIBapRhq+A79Sio3yvyFj1AGnyObyyOXkkyRSzK5gmt96yoIjdAmHO5NONHpli0LPsUMdxWwrKfhJ0RqCy6si7YcxbcSCf2bvUSc3j/rZNGrtNID7VYkFFbGNPVbpqZPx3Sd9uZHaVyTGeIQRoLmbNG2qEC3vvstr2kPVK+/cMBLvAmvnbdycXQoeAYdRjvxpYK2soTjncGD9wZmADCX+r+7AOws41U6Ey4POySRW2/ZrjjhvXSlKeEptdFe1RtnmnMa8nXQk9JI690niSptp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOe7y/DlMgLK0GtkiNXVsrzxtCkEYHRBOMDe07xEP7A=;
 b=eNZTDH0f6st4yFjRUFhYI6mwbluIWRxfcx0yli8oEvWnMgX3LzS4FNuavbc3gn9MnPHBX0aHSzUBolqFo8bbJVt/ZLQn/1Jtg7wbCxaVujUX8WnoO67nH3IWJp4KOdAZLX9fqoPMu9hap34pH2V0yBtZznB9yAkI3coo6Bwt0RkfX3Q2nwnD52zi4PhLJXfVnOmYNM0Grmy9ep5xHnSw8T0bq8xsB+O3PGmplOe+90zlQX5WQJS5f/ZZW/SR5vPaocMa0VVhmybsuHr9vPrOCVponLeBqlA618xPgEWNoDrLyiUv6CYUU5/xT306YXjWLwtWbZKbV2fwoqRaWPgZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=ericsson.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=ericsson.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOe7y/DlMgLK0GtkiNXVsrzxtCkEYHRBOMDe07xEP7A=;
 b=eFyyUJQuLPoOWHMTp5jFzH3AYuTLrZ/zUfTaEmLKRzWOrA6xlucxgVoPaqTFunL/iK5XjzzhCrOjOqzxO0OZYAoZsdfQRzicPnQZenAcdX4WtKOTg4buGdNMRcBk7Bhg3yDxf9K3t/Odf5PfAEQeUXlnvg9yK7JiyxrUVUPIrGtnDa1u/eDrzhJ4W0ZDb5NZeMk5Hmx1gTXckJ8ZmfOUxJgT14uYbQkNWQ0V16eEPZYewBBTOe1SsLkmzziXJexkEvyHPKGnkS3vCe+GilcGspDSqjU793SBBg7ErjEwqlEykRUDzD8FSDc7r63EkYzQB8nv5/nWep3e7hlU9lFrmw==
Received: from AS8P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::26)
 by VI0PR07MB11034.eurprd07.prod.outlook.com (2603:10a6:800:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:57:52 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:31f:cafe::27) by AS8P189CA0025.outlook.office365.com
 (2603:10a6:20b:31f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:51 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:51 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id BCE124020B6E;
	Wed,  2 Sep 2026 11:57:50 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 8CA7A700CF25; Wed,  2 Sep 2026 11:57:50 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Daniel Turull <daniel.turull@ericsson.com>
Subject: [2.18][PATCH 0/5] Add case for filter_regex parameter in latest_versionstring
Date: Wed, 2 Sep 2026 11:57:33 +0200
Message-ID: <20260902095738.2840120-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|VI0PR07MB11034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1d0fc8-7fb4-4877-dcb4-08df08d8a701
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Ek8OKEqbIsed/+d5Z+dlAgBA2EqknbkSRGT7b6xitDRAfPdKOc6YkwXLvd7m4CWpBSLRyVOA7iLRCcj3JofVyZSTW+NrAr7/9x2N5t7v0UJXy1ma58jz/COn8sy3bjogPJl8nSaPyJHp6VJyHLYHhkKUMyOo3rzbEzYlFEHmymjWfnnC0WIzSaFcNSH7BlCMCEXsGRIErzROdGC4BxHjAtC7itUKuA8pHg6vUcGlmIuiskBdsxFXg2/GtXZLALGxNh/yrKoqp3FrJOCDPLkhgxZR4AmgkCpEZp7qIug1Q8pPVSCbeh+8BTKZKy4QfBAck8BiETSu6ZLQMnozmYVXH4ebmrgsziRtJJL4lmRjFnAayWxr3bACotjmibv82r/+PN+eTifcg6+vHn99X2b7Mqoz62z4wTnMKaMyMi4qQmKayIOLKKF/9YzULOgRb62zAZWci3X++GqvB+QsRXFM5/Ot+SJkNraJlbGDqerKXQQ6Oe4q0TdjAtHvWifq3nY66TI7GjdsAqhE/uGyn9Yl2laOf/cnoZy7Kt4DsVqSs6nBT97SJT7o8/cyWEC6PPKfq2pXX4aAA/cfY4P8X5iZwaJHXPtg72qhx5oy8JgK7otcml+iIAMO5XZ4epCfU7+YmWHTxuyZXuh55C9vLvYI4dc/gNPNJwAw0+qHU4hoRCc=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9jaJ0KyG/tZL6YWchPQe0EJxiF4WE58YajePQlsINFN9sODyLVqbYTsbJR7oN9+o2bdun85YkUUkGiC1FNTfrIJIfOY295QYB/waCwVwGq43DBQ59313X8OWYI+/m18bJrzo2axKfU33htyhe+Iaf934v2RpskolGOqYFGodvyZulynm2QIAhKJwIUB1cqp/ACAps86lz9PBb2UIAY/ACA3DyCo03qfALsuDms5c5RDYTZEHyw5euFQUMlMQo6av+C2Z3bYTdNtGAbzMSzQXrofvTds5fSoRnHd0qUcQXG3iWSryLCp2vBIpHJhTtsuo9F+YYU8ACa2cmDLMBNQJQG/Taq8wpnXlNeXZSQ+lPLmDVIc1/5Kqecv2+B8hKM4nGj8bKW1PY0jYkdqEYneVeo7NjiqTd8967/8v/QaCDYRhyuQ7lbi0s6NUA3FI43wD
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:51.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1d0fc8-7fb4-4877-dcb4-08df08d8a701
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11034
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20150

From: Daniel Turull <daniel.turull@ericsson.com>

Backport functionality needed to be able to do stable updates
for selected componets that follows Yocto Project stable point
release upgrades.

https://docs.yoctoproject.org/dev/ref-manual/release-process.html#stable-po=
int-release-upgrades

All cherry-picks applied cleanly. Tested with bitbake-selftest

Pending Yocto TSC approval for backport. I have sent an email to
TSC for it.

Chen Qi (5):
  fetch2/git.py: add filter_regex parameter to latest_versionstring
  fetch2/wget.py: add filter_regex parameter to latest_versionstring
  fetch2/crate.py: add filter_regex parameter to latest_versionstring
  fetch2/__init__.py: add filter_regex to default latest_versionstring
  bb/tests/fetch.py: add case for filter_regex parameter in
    latest_versionstring

 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/fetch2/crate.py    | 10 ++++-
 lib/bb/fetch2/git.py      |  6 ++-
 lib/bb/fetch2/wget.py     | 17 ++++++---
 lib/bb/tests/fetch.py     | 78 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 102 insertions(+), 11 deletions(-)


