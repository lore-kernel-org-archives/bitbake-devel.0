Return-Path: <cal@brightsign.biz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E334C61DA3
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:31:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.128])
 by mx.groups.io with SMTP id smtpd.web10.15491.1677238260933529566
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 03:31:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brightsign.biz header.s=selector2 header.b=MHdNjSBW;
 spf=pass (domain: brightsign.biz, ip: 40.107.212.128, mailfrom: cal@brightsign.biz)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL9ZjLrSYdb+eB4LU+DyyTBP5a9g4xAvq/tKHkeRPN5AARGO9p6ER5ZusnDBLjOzFAxEjUyBl8mPUojL3sa/yZNNMiJhGCLU7/lSt83JYGInHAEeOpwXkImgUfK20x40WB1ouTbIV5s6Bn3zrFNr/IdLvZkjqPffpimsE2Aep1LaFtC+rVICOC85/AVUeu9TpCl+HG4oIGt36ThP1LLv1gv+EJOO9dAWgUcgtKdyZK7QeWs8qrG1f+yYas23w7eF0dru8UaP873mezID3e13bITIQmQ3HVyrxKHXN4QEyQ/IQ1m3ROONIz322FsUo1uwdQznu+p6yR3CZhY6BzRGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWPWsi+K8j7D/ZoDp9H9hOanIRXZI8OButiVaMntdEg=;
 b=J0VuAiWsG+0nlH7guDsLhhLSjezhXz8XIdFscouW2ixz+1vQViLdzRYWMr1shO0eHmVw6TmH1Hmec4XkH9/lr1JAj4XGqHPjswe9mQuBMvSyCRc3fqzd5Ne5n3zH47JnPC19w0yCqf6TBc7Wd16F4vZqC5BraSSiYUUOT0tCrSUtO7SDZRMqfromMfWkPfr3sT2D3bQjFZ50HBH23+QtA87VimkG8m6x0A7KazYTtd0wJPiVeP177r3O1eUOPCFfIAVDSSm+kFLXZoLypqmTKHPQZxCXjsLWE+Y1PtW1WXu3XbCOQAzB6h7XZcTbfgZe4wZDCGh4a08azAely+iRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.222.38.66) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=brightsign.biz; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=brightsign.biz; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brightsign.biz;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWPWsi+K8j7D/ZoDp9H9hOanIRXZI8OButiVaMntdEg=;
 b=MHdNjSBWpz7sRbQQZqTpOlcKY3wVunbKskiCowRMt9oLP8kDPrbAEPuJBckps/gvgRXMbFSzOdxH/AbwGjS96dqbMV9aGenTLhLJ7H+B9Dwc9k7wv7u9hA/8i60ZhDvZLniT1eUx0SxMCJWvfUWWS0vCwn2x9MXDtW9R56TQ594eoyNxZwXn4Ei7YyfK63Moyh0b6AkMLNWQmw6gnogpaRq+7tXPg47+fK1wQ9fiSOg7f7RK6HdLl7ooNtLAdYcuqsECUWICYg4GRAMWMBD2VXVdM73ke3tQgLG5wNMdGdJ26JrILZRoiySnr0KuDT8EeTxYnEErhgH6zqZDEaf2DQ==
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DM4PR22MB3652.namprd22.prod.outlook.com (2603:10b6:8:64::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Fri, 24 Feb 2023 11:30:57 +0000
Received: from MW2NAM04FT028.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::5f) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 11:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.222.38.66)
 smtp.mailfrom=brightsign.biz; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=brightsign.biz;
Received-SPF: Pass (protection.outlook.com: domain of brightsign.biz
 designates 212.222.38.66 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.222.38.66;
 helo=elite.brightsign; pr=C
Received: from elite.brightsign (212.222.38.66) by
 MW2NAM04FT028.mail.protection.outlook.com (10.13.31.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 11:30:55 +0000
Received: from ukcam-caltinbasak01.brightsign ([fd44:d8b8:cab5:cb01::7b])
	by elite.brightsign with esmtp (Exim 4.92)
	(envelope-from <caltinbasak@brightsign.biz>)
	id 1pVWHu-0004qX-IX; Fri, 24 Feb 2023 11:30:54 +0000
Received: from cal by ukcam-caltinbasak01.brightsign with local (Exim 4.94.2)
	(envelope-from <cal@ukcam-caltinbasak01.brightsign>)
	id 1pVWHu-003Wtf-BB; Fri, 24 Feb 2023 11:30:54 +0000
From: cal@brightsign.biz
To: bitbake-devel@lists.openembedded.org
Cc: Caner Altinbasak <cal@brightsign.biz>
Subject: [PATCH] fetch2: Add GIT_CACHE_PATH and SSL_CERT_DIR into FETCH_EXPORT_VARS
Date: Fri, 24 Feb 2023 11:30:32 +0000
Message-Id: <20230224113032.841394-1-cal@brightsign.biz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT028:EE_|DM4PR22MB3652:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7281105d-5037-4359-e2cf-08db165a9825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DBjvF4s2GkLWXSu9iExf3s2U7gCuhKK6Hlf157AI5ZBV6aIdtYnvkmwzQu5z7KionpuizrkFpq7tWGQOoOFqmjqfWRXdynZWmYW7s1LNF5kW2dlk1bbfELl0qa+noxdt6eTlITbU9tP/4/U3yAwMQ61Ey204RTQzXaX4jIX19tcAMnTH5dPs/U3nK5klPm5JwXnKI3miQnxUqJ5PmksdfRCqhppej920ZWFxQxKrM08LD3Hj5yMvVog1OgiADrDilYG8fuJnY1KGJYJWTqFjTuKAuHzk+bZAq5OjS1drS20NdEOFEkwm5zbnalKiaKv4QaxVrJWgtjsuzQN92dvteK2C/ni78LKjt3h8/ANAZ+lPQ9eaf+Tn3cneN1Q3lFyVgcZGk0K14CwxG9nGPSO8eBgFh+X+gLWeZC1EJyqPH3lTDfLXAlW75uMDCPrNcKFzPVa9/YdDudBj9zxmTp/pyFhrC95Jcr9MOvQyac1KHT+Ks6L2BB8vY4iMXN+Ekd/M7JamjukMvc7nLCfOSv9eYWvIaZYtnw+47oWl0vhcqDfOGZ4IoVYWv+2G4+1BnIxcDYuH0Ia6l10xvJayheEmQAtz4ocOrqBibDiIss40ooOlfrfnWGE6zwwqtUEMftc8Ocm57tkAwBibrQ2VZomHfb6YgMKOyZeJtFLFtrGb40m3Mn2UxEbk8uwJXS9SN6s41F5NV7YCNEMhYmBcp6TUSA==
X-Forefront-Antispam-Report: 
	CIP:212.222.38.66;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:elite.brightsign;PTR:ErrorRetry;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39830400003)(136003)(451199018)(46966006)(36840700001)(66899018)(36860700001)(4744005)(86362001)(82310400005)(2906002)(81166007)(336012)(478600001)(70036008)(186003)(9686003)(2616005)(47076005)(26005)(36756003)(40480700001)(356005)(83380400001)(70206006)(6666004)(41300700001)(4326008)(1076003)(107886003)(70586007)(8936002)(6916009)(316002)(9746002)(8676002)(9786002)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: brightsign.biz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 11:30:55.8544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7281105d-5037-4359-e2cf-08db165a9825
X-MS-Exchange-CrossTenant-Id: 8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8fbcdf64-1ab8-47ce-bdc7-43e23b04fb3c;Ip=[212.222.38.66];Helo=[elite.brightsign]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW2NAM04FT028.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3652
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 11:31:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14484

From: Caner Altinbasak <cal@brightsign.biz>

These environment variables are needed by gclient and needed to be
passed into fetcher.
---
 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 747356dfa..cf65727a2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -855,7 +855,9 @@ FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
                      'AWS_PROFILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
-                     'AWS_DEFAULT_REGION']
+                     'AWS_DEFAULT_REGION',
+                     'GIT_CACHE_PATH',
+                     'SSL_CERT_DIR']

 def get_fetcher_environment(d):
     newenv =3D {}
--
2.30.2

BrightSign considers your privacy to be very important. The emails you send=
 to us will be protected and secured. Furthermore, we will only use your em=
ail and contact information for the reasons you sent them to us and for tra=
cking how effectively we respond to your requests.

