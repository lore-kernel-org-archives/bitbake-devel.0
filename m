Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F95C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:51:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.112])
 by mx.groups.io with SMTP id smtpd.web10.23078.1677257470347691245
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 08:51:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brightsigninfo.onmicrosoft.com header.s=selector2-brightsigninfo-onmicrosoft-com header.b=Mr5QmidM;
 spf=pass (domain: brightsign.biz, ip: 40.107.223.112, mailfrom: mcrowe@brightsign.biz)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5rlDXdsZbMOQZgrpw4Q3JJ/QRFCveAW+GO4TUzcLtpxRj9wy/VYKCK+4fVp6hYbc86bzaWn38ogOoH6yoVoKJuqDARAZcwDRlQtx4NmZGMiZRY/9Q1bThQDisSjfMIlYYMZ5oqWy7UaS/MLne7/7vG+e5xggE6aBnGcbhx135gJQGHlyaBRyjkxg0kD/KRwRitsAE1Dvhxrcjvucj8BsUPkA3QsJ1ieZrff6jqvPVrqURmVHtcHrzoMImMf7oldLLwHZP/JfVn/qHzrNdjiFs25QU/5CLYrgTdyHyErBsVEtDg4X7prcpj2IDeKSTCO9np5tYPhp8f7mVYpbCWRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUuAxNQCfdbrkWmvSIYEA/umMVXXocpj4Hh13w2Qvuk=;
 b=E8l3oA4wTehc39gUUE43+SbF7Z56RRF4x6mYqG7iZQJtYkN3Iyj618G8FWuOISCiOZ5lHiHxp7rBWx2nO0sd7aWD0Q+HReu4HJYlklWUYtzSuJe0oRFJ3SyyZcdGufODBRIAIZttq1leefKd8s74vvi8RkPy8+CWsDyUP3aZhlz0uIszKOfteNK3r7aYsZAn2FdcjoV0+7aZV12Ypc+lHlf8pkBuke3xX0xPdOp97DNCxmoG8kmMnuYhg6tEErOcFcjcKa1GTk1TIH2AHsEG/nt6YFflpHIEH7LPt86qcfm5C8YcaTaGqBMxoNUsiXRQdfvfRAROa8tZte/qhoo4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.222.38.66) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=brightsign.biz; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=mcrowe.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brightsigninfo.onmicrosoft.com; s=selector2-brightsigninfo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUuAxNQCfdbrkWmvSIYEA/umMVXXocpj4Hh13w2Qvuk=;
 b=Mr5QmidM75BfT9dyLhzUsTo4EYUAmO8JNFCVNW94+qNO2dyH4Dzrbwxeo9Gfvgc3pnOTVGEnUEOVC0Ok/eJX63loIH+xy7ulS3X3EP3JQm7M6oTj4ew9tJp6FQd17pC5Q/KM6KxhTc2Ku8aT3t+1Uc6P35oXwtFYZINbA7eSpTA=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by MW5PR22MB3734.namprd22.prod.outlook.com (2603:10b6:303:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:51:07 +0000
Received: from MW2NAM04FT043.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::8a) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 16:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.222.38.66)
 smtp.mailfrom=brightsign.biz; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=mcrowe.com;
Received-SPF: Pass (protection.outlook.com: domain of brightsign.biz
 designates 212.222.38.66 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.222.38.66;
 helo=elite.brightsign; pr=C
Received: from elite.brightsign (212.222.38.66) by
 MW2NAM04FT043.mail.protection.outlook.com (10.13.31.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 16:51:06 +0000
Received: from chuckie.brightsign ([fd44:d8b8:cab5:cb01::19] helo=chuckie)
	by elite.brightsign with esmtp (Exim 4.92)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1pVbHk-00096J-W1; Fri, 24 Feb 2023 16:51:05 +0000
Received: from mac by chuckie with local (Exim 4.94.2)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1pVbHk-001HEU-Oq; Fri, 24 Feb 2023 16:51:04 +0000
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH] gitsm: Fix path construction for relative submodule URI
Date: Fri, 24 Feb 2023 16:50:54 +0000
Message-Id: <20230224165054.304484-1-mac@mcrowe.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT043:EE_|MW5PR22MB3734:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 011b9aa3-64b2-4020-30ca-08db1687527d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t2eg9OfXqukkNnoyb4mtfFNnPaM6S6rB69HaW/a+MiYfmcp1bLm1j7MOm10OBuwaC3HSHw/FZgsxRqSawegc3rsi463Is4mceYhx6bTzH32GATjNH50NLTIlrORjJP9nP4SL6izcu9d/3ZmY1XUwPgALzLF8LHlbf7JBeSyEkHjcCijjcwTb5e04+pcs6jonhZ/0Vwvkqwj7gzXYeIfRr5n0ffxoCpO2k4DOaF7TaQmH4a1fxPWRHiSzemsPnPKxSUweo1fpGR7qpuZGiUPZyu7ELbD+yUVkaPl1kdcx8n47q4rDCSp/L378+C1KuaTvJwuPnuSU3m85AghJ46BzQWKuu0j0+oaRKa4XmQQtqGUgenuf+uQ/9om5wd/ie8gK2IpmwyXUStY3CFlMOwIM1bj6/i2gvRbddbuClykXCtpXbVATTHl2LV8CAHg+O2tYNtw4vMJ71zfH3QjKrlySBxyznCHxTdvdkJf2UmB4wY4TYdPUYutDca2kJXi9QDv9Jr1tl6UBW89o435/OTJU9kth4lOVqKHks7dTzcHAVxONkcy/PYsEPoPa74XN4i9wYiVpxlg2iAmHhAw/boh4RfJKfXDvae4gN7chT/0quvh45yrP7R+c59D8EzmDGuwNeVYgqi7OKkgzF08NTvOVmQxYS5NudGsVWBpdTRNDz8PLJu6H7UIWWnY9/p9td8SxZFtlNbOndDdsIusSPezb2w==
X-Forefront-Antispam-Report: 
	CIP:212.222.38.66;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:elite.brightsign;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(396003)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(66899018)(186003)(1076003)(6666004)(26005)(36860700001)(36756003)(81166007)(40480700001)(316002)(478600001)(356005)(82310400005)(83380400001)(336012)(426003)(2616005)(47076005)(42882007)(8936002)(9746002)(2906002)(83170400001)(9786002)(8676002)(5660300002)(4326008)(6916009)(41300700001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: brightsign.biz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:51:06.3389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011b9aa3-64b2-4020-30ca-08db1687527d
X-MS-Exchange-CrossTenant-Id: 8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c;Ip=[212.222.38.66];Helo=[elite.brightsign]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW2NAM04FT043.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR22MB3734
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 16:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14489

The submodule repository URI contains a path to something not
necessarily on the local filesystem. This means that we can't use
realpath to normalise it without risking getting bad results if the path
happens to match something on the local filesystem. This situation can
cause very confusing errors if that matching local path happens to be a
symlink to somewhere else.

Using normpath rather than realpath means that the path simplification
follows simple rules on the string rather than looking at the local
filesystem and avoids problems.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
Co-authored-by: Dave Craig
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index fee40cdcb..f8e239bc5 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -90,7 +90,7 @@ class GitSM(Git):
                 # Convert relative to absolute uri based on parent uri
                 if  uris[m].startswith('..') or uris[m].startswith('./'):
                     newud =3D copy.copy(ud)
-                    newud.path =3D os.path.realpath(os.path.join(newud.pat=
h, uris[m]))
+                    newud.path =3D os.path.normpath(os.path.join(newud.pat=
h, uris[m]))
                     uris[m] =3D Git._get_repo_url(self, newud)

         for module in submodules:
--
2.30.2

BrightSign considers your privacy to be very important. The emails you send=
 to us will be protected and secured. Furthermore, we will only use your em=
ail and contact information for the reasons you sent them to us and for tra=
cking how effectively we respond to your requests.

