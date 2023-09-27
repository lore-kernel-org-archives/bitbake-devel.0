Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C705AE82CB5
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 17:16:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.22982.1695834994295475697
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 10:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=OmugYh0D;
 spf=pass (domain: axis.com, ip: 40.107.22.86, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3HNv7nPlUWU06PJEPg7GUntak69UTQeN3sbcOi382zxMCLWGJxCH3BzvGC38vSx+nZDzVdGkuAv7d8GuUDrr+bmijl5SfeH82kevbvzseONuup4HIw3h9T+Kb7InjxdONa4DME2B5dZARNQihTBNO2bI0faFqztB0u6t7zkcuLKEnMVqOurrfG9tKIPO3n+c9EL371lyqJER1Kz0lgkODcIFMEhEwYTkC5wzkg/O+63Jz5aGKaMsYTodcSdgYEDV5tdZCNWxlUCKRn55fKnM8qvkM9js5hFZThqF7FmQqVwBEGB9+AQq2E2mi1NN0n4WLCoH6mRUi5nklX87Z3dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB+B7A8dIcmiSFK9dqaFPffwTAcHpwT6y/8NGuhE6cU=;
 b=cEqDvbO/0kNO4YDuSPzwJNkxzcwbPmUFU7Qp3SbzAlGZOX8a0O3ImkJDopS9bmu214T/avRkYkn8NttILA4oWjxAPZw6oYLQAHzOexomTiBJxocH9eHjspzuWCe/4US4qXTb1yA3mNP+Gmo8b9WTT6V54ahIaa4wGCzyW1D0zzgPQhHLPz2dij2MXBQFuULKrtObrpbAqrcFB8+3T9UFaaxXutzW5dJiBy+kOJAED4qVP/P6jbbuAfAKjojzX5W5wbV/9NQ0K1O/R2OyRypttqpBs/Og9snz2l3He28UFt2Vx9Veb3PUXbFacHxHUhsekgpNQXMXpEuWPHJ4Cz/ZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB+B7A8dIcmiSFK9dqaFPffwTAcHpwT6y/8NGuhE6cU=;
 b=OmugYh0D2VJbg73rSbDe0guJHXLyLB+K91By78i8kUev3BtaJvwqMorcJwTfxctLAFSxeFcHcP2bMb2RuIwRY+olb1A3o0V1lYk23glrRxsrkTUNrkPdpGR1MLikwyXpWjcCNeVYoaHIo/jQe0csBqYM6pV346o1ZjfgVSO5d6c=
Received: from AS9PR0301CA0040.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::26) by AS2PR02MB10315.eurprd02.prod.outlook.com
 (2603:10a6:20b:647::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:16:24 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::d4) by AS9PR0301CA0040.outlook.office365.com
 (2603:10a6:20b:469::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 17:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:16:24 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:23 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:22 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 19:16:22 +0200
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id CC6891A75
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 38RHGM7b3352837
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 38RHGMYl3352836
	for bitbake-devel@lists.openembedded.org; Wed, 27 Sep 2023 19:16:22 +0200
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 3/4] bitbake-getvar: Add -s as short option for --ignore-undefined
Date: Wed, 27 Sep 2023 19:16:18 +0200
Message-ID: <20230927171619.3352810-3-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927171619.3352810-1-pkj@axis.com>
References: <20230927171619.3352810-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|AS2PR02MB10315:EE_
X-MS-Office365-Filtering-Correlation-Id: e3986536-0351-462d-f40a-08dbbf7d79fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ds7lMzKVf/nTKC9BemIjlIK/gtvyhmQMq9BqZL9yJt6f/M1EdimM299VvaNgJ5MsC7Lp+Wq1wVO8DMiYo39JtLcQQZ7OtwjCLR/4ST40DO3SYCloG6oum+iDPX84oLddIXklHyLOHBaSaN8moCFEEn2TBbAUd0xeB/Gz7ejrYFUAcBm+1yWb4LMxQBUw+GNqxP1lp+8GimgEmTUtIqjWYMqBeA5UkqYj6OR1vhP1IU+Ritpv7PDV1DRtpYG4rVF3wNaTFzGuZjZkpQClUKiQ7SCx+VAbP90M2kFNruNgBG+lxw0AneQpk7AZwB2AwDWrP1FtoyRAPekbM6MMw1H9jCw9It0HUeAxWIlp1yKHragKQLeFn/0lLsVrSlkGx5LkdLu0WphDLXtamYOkD1xQVa6WlZwcjsxz2fcrkXONxL8VWXqW4l4htKcASHmpKcYHAyPSjvdfvEGhtyJeDLlt8BsE0d/RbWKEnm1LvDf2OdlAXL+NkOUmDoSttGIgnJXtBekfLJv5LYco0s26SNsVsUZUZeBvOweOUL3XLQpbew4/xLYGEWcAt0ChtMtrFoP7cF21Z3Kgf2R1/qXvlXd7Vt9PrnTuRZywJM2c7XhvY/IVWAilAVy9ACIJjknm4E6zSwkChGOunlXWNw7LKzixdJ4f2fsrfj1bmMNSiI6mtctKm89efo0Rt0ck36VSizRJONzdZ4A3AnFsZxwuh7GBtHjE7n2JInhFngWbuL0KiY/M+rAicyB13UlCLQrfGb1KcmJxeT7ZsN+sG2IJRQFKuw==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(36756003)(40480700001)(5660300002)(26005)(316002)(42186006)(70206006)(70586007)(2616005)(336012)(1076003)(6916009)(426003)(41300700001)(478600001)(8676002)(8936002)(47076005)(40460700003)(82740400003)(356005)(36860700001)(81166007)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:16:24.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3986536-0351-462d-f40a-08dbbf7d79fc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10315
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 17:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15140

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv3: New in this patch set.

 bitbake/bin/bitbake-getvar | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 8901f99ae2..1b5bb2e1f5 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -26,7 +26,7 @@ if __name__ =3D=3D "__main__":
     parser.add_argument('-f', '--flag', help=3D'Specify a variable flag to=
 query (with --value)', default=3DNone)
     parser.add_argument('--value', help=3D'Only report the value, no histo=
ry and no variable name', action=3D"store_true")
     parser.add_argument('-q', '--quiet', help=3D'Silence bitbake server lo=
gging', action=3D"store_true")
-    parser.add_argument('--ignore-undefined', help=3D'Suppress any errors =
related to undefined variables', action=3D"store_true")
+    parser.add_argument('-s', '--ignore-undefined', help=3D'Suppress any e=
rrors related to undefined variables', action=3D"store_true")
     args =3D parser.parse_args()
=20
     if not args.value:

