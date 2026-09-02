Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A77FC624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 12:27:14 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11649.1788352025720735364
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 05:27:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=azqSspUs;
 spf=pass (domain: axis.com, ip: 52.101.65.2, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X868Q3PKIqBiGbQmrHeYHFeLzTw36tLMq4u3H/AOb7SgDMDg0iHskQRnbnfbak/Oo6lGzUyUkrNUYYicuffN9mFDGsNq+mQ3GUa73Cr7K+5f1B7hDFUtU/xlYJCeWljyf+O/rWHi/abmbkMQyFpYNsDhKIZ6Kcom4vS22WvFHoMA1JHCkZc8iU9k+9QtunDJzSsrKvbc4kWNkS/MLJs4eISobrD9TmsKTwpc102iwdRKwClqZIo7WKKFV8BMumAurW7aOCr8WXUPUcDPPKGGffPF6TVq+vUY/3PsxGW72J9SRnM0nKqG3i5aexzpb3KRFv+nPr2xPUtvg2GZNnjAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyQxLMETdNSN3PhnvYfnN4/F5NkZUfM1sbQ+k8FmVts=;
 b=Ga4tDG75rRORkwfWaHGx4SadUWvLUjpq1HoLNmYOt2ok6CRSHrel9k25VmXxFNjT9LAfNR4Amca4udLgrT5jBmCWMFjjU+rTkW3nGz2kYN0qRxuE7RPCGPIT6OqGBkjomhVNEt0IMJb8AiGc861kemeMI8pFoIaHRrP/gQn+L7iKAQAFpzpBkS3ClnhIRmKaTl66h/7XU5AhqAIfNT08dPDsAgx0EzsufD280tDbiz+S7B40jZd6erVTrqzVrAp5GtyPF79TrlgPucLhwe8xiSnENt9q9P/wHyRBZYdborWB2AEUkaVsx54bPefRobA1OwXoMZLzgJUiClzpFahChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyQxLMETdNSN3PhnvYfnN4/F5NkZUfM1sbQ+k8FmVts=;
 b=azqSspUsgZc/APUyNirGcIrexM+uRJs9r2F5GrsUDl33ZHkYhgVbx2BKp6LxNm7wVHM8m6LhqnKptLdK9cqZYL4p48X0Zf41sZWbZzJC7RVFAP2rVZXtFoqUTuShgHe0lLbk0ptCrzm9M9T0RlCu+DbmA7t7QsK4nFXqHwCBA8w=
Received: from AS4P195CA0034.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::22)
 by PA1PR02MB10984.eurprd02.prod.outlook.com (2603:10a6:102:480::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:26:57 +0000
Received: from CPH1EPF00000525.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::a8) by AS4P195CA0034.outlook.office365.com
 (2603:10a6:20b:65a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000525.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:26:56 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Wed, 2 Sep
 2026 14:26:55 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 2 Sep
 2026 14:26:55 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 2 Sep 2026 14:26:55 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 09CA18E0
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Sep 2026 14:26:56 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 0450B129A18; Wed,  2 Sep 2026 14:26:55 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/git: Clarify error about missing LFS support
Date: Wed, 2 Sep 2026 14:26:49 +0200
Message-ID: <20260902122649.1466784-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000525:EE_|PA1PR02MB10984:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc2e861-af75-48c7-d254-08df08ed7a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	PETBnApEeDUyRqU9Nkjv8GlTPq55Kj8Gq+nhBeXBipVkOUikZ5M2quv6Ngmn/vwPF5GrhHboJXIbIulfhsSQWW+XIfBwYYa+SDGqUMgJEguNPpX5ESVhR5r1GUsPkSQ/Z+0BdsbHM7UPuG18h0yOhJVHO9o+2vcTOBR1Pu7RwaUD65szMCa0wVEgR8fNQsElvIkdd8BE8fg2+I3xFapnd0xR/gyWlCa2bjeMOGrwv75jY94TifEQBsCye7eLKaOpmvxlSL7VQlEUJ5JmWkqp/TVcQLPb0+GWHAyv2h82dvNV7S2wy8Uokbru7KUEGQUmf25Jx/+hqqCo+C+mM5ndJheIdtdmlS6sKoIRRSDiYGYM8h8kxQt4FSqEu007kon32NXCecry7oFui9o/94F+mJkb36DAowF9lPrwyK099aT6GBfYQF+F4JQMVvfICTINXN16jcgSTERuuVJt4Q/1dIVZU4VXwOA3I4cd4WBl29ty9e3ObE6P8H9Q4y3eGdctQO+F0kA3OPYAoqX3F5y6ojqPhAp1kOcdlqsQhfwt/QBfJOl+7aLxCSdHlYUcu5YY9Ailt3wiJa3n7cgKjA9RhxJnYCaynu4W2LTYaXYwHQtwQ0qa+Vdlo0lrlUtcQuiUhs2Q9QuEghkevAAsYEkTakwGJ6aKTGnMwbTS5p7Cc9Grh5ndKGrRwuvoN10+4qY0ft1cYGajaO43Ja482fkOrQ==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qM0SqdvEYkU6T8v5QY8WZu0Y0IevBqBH20maGA37E6c9k+WP8DIi+sVpMXWE0HCtD4NXsYhY01IfVAZILVXVN9su0JrhDIy4ZEV47WO5DtI62hpPL+SfKXFeH+TW0FMqgYAJK9ufn/z0q1ee5WSqf4OQWzS3MccxcEOJop5nMU14KghuEMZzgxPn039LIXZU5siIdyN7NJsuEHkX/a99oH9mhJS7VspS9I1yDSfhG7yz/4sbiLQ1sg0PqW40OpIVKLB4Y1tbYEN0fkdap8znrcMORtXeVzv0ZqywZmWdF4xYlcsaSllQ9sQD5bEvk2Kv2EFJ722RBR5O/s5to3n6fiaM0jScDTo6IPL3yHD4vhNYphKQDZDwfb58+H/PWPAFEF7r/c1TdEtWYBgBkWvmPyDoED06doP1QuKeisjQM7wrKtL7oBIUZKp1K1LaJLjj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:26:56.5801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2e861-af75-48c7-d254-08df08ed7a8c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CPH1EPF00000525.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB10984
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 12:27:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20155

Not everyone knows that lfs=3D0 is a parameter that shall be added to the
URL to ignore the LFS contents.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0bb2ea39a..924a8f7ae 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -886,8 +886,8 @@ class Git(FetchMethod):
         """
         if shutil.which("git-lfs", path=3Dd.getVar('PATH')) is None:
             raise bb.fetch2.FetchError(
-                "Repository %s has LFS content, install git-lfs on host to=
 download (or set lfs=3D0 "
-                "to ignore it)" % self._get_repo_url(ud))
+                "Repository %s has LFS content, either install git-lfs on =
the host to download it, "
+                "or ignore it by adding lfs=3D0 as a parameter to the URL"=
 % self._get_repo_url(ud))
=20
     def _get_repo_url(self, ud):
         """

