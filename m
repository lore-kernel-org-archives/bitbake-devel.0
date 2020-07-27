Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.53])
 by mx.groups.io with SMTP id smtpd.web12.1032.1595892282803538169
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2020 16:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ZAenH8xd;
 spf=pass (domain: agilent.com, ip: 40.107.244.53, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii+qUUGXb+UaI0CC4yQnXe1sevF5BIw/sGEVG/cr7frrvgwqdwehrYTSvU2A5gsG2Qfn6KCY18ZOSRuQo43Aca+ArVI1nIF5WVl9xbFMeTB82jKz1H28HnfNi8Q+fMJOlcQDz0ve/clqjUD4f1Yqv9ampAjHzmJ1ZCAbFY+wPSpaulgrQu9NsK8RewGYvX6Et7w767KCKZGmk2h4kOa5emjX5b7SIFhhVRR8EwQa/GPy9ryasxXHjJ0Dm6Vd2+D0PTMUCt5BQdpsofoxvrW35/ecZ08pKTDIyAimCxTjlMeADLHRVLs7+R2gynX9RBuST5pEYs54V8xk2QdxWtsWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NsmaVSx0pZB1JaHX1VdfScoC1t0S+E/bONiDO9mJVw=;
 b=TUQt6+Cp6yV37XvTiUmwEDZfSiL4DShaVi2fw3oH3/VWjd04XOk65A4c5+FOva8IAaf2bj1rQbH5Gerd/9XdClUlCM9B5toOWBghMGkiw6IZFgvRfiH7s8yxQ88dW01dCG9dldF+Q2j6OMhbR7FrEgGOGMaQ2LGepKi7BkzWWhQkcS9cDbEIGeCjgToeBiOoG20IBt9qURpXxA/k97wmLiw1Ijyup292Ry4ny6JSLTTFh6ujmJ0cQNKaZJfCfL45asRnzDGmobHH2V6/TB/X5qncevdkaeY6ChD9ZFL+uIlmUDX5NsHUx1vQstq+Y88A4nwJoA/q08FpRYcZZSfQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NsmaVSx0pZB1JaHX1VdfScoC1t0S+E/bONiDO9mJVw=;
 b=ZAenH8xdiX7nDR8JaNrXr/xg6XspYoSQpuGVTqwSFaMonpk4svVuwUzmkUBXEC+r/NUuMohhV7htl64OlPA57Iz2mbA91zJ756wFK7SaXCPpht7oI44t0WNMhsmtIrGD+1twleJBjhDDK6Ue+bBSLMbcgn8t/Ckwnivl1HcuXAZ7m4tUV9cvKGctIjEfO+UX7NYoPqZE3qWCJzNchbxwM+wZi0TAAtCuYVvQwHQkF/POjBkEzEqo6dtg6KxYnWbouZh3z5DwZ18TMrF9DfymRYZKCDFVAPU5M6QiOj1+mMoQkZF8RQh4ZQLHPTj6w4t8RYAxnGO0s+OQq1ChEVoiVg==
Received: from DM5PR19CA0060.namprd19.prod.outlook.com (2603:10b6:3:116::22)
 by BYAPR12MB3621.namprd12.prod.outlook.com (2603:10b6:a03:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 23:24:41 +0000
Received: from DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::a2) by DM5PR19CA0060.outlook.office365.com
 (2603:10b6:3:116::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Mon, 27 Jul 2020 23:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
 DM6NAM12FT027.mail.protection.outlook.com (10.13.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Mon, 27 Jul 2020 23:24:41 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.1261.35; Mon, 27 Jul 2020 17:24:31 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: create_progress_handler: fix calling 'get' on NoneType
Date: Mon, 27 Jul 2020 19:24:33 -0400
Message-ID: <20200727232433.23291-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg1.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e5a576-0cad-4b22-1698-08d832843d02
X-MS-TrafficTypeDiagnostic: BYAPR12MB3621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB36210FA801D7B773CAE6DBDD8B720@BYAPR12MB3621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DWjtGYCBNkadeRET8Jue3yNsVwqn1tM3uIZWRedfg0tBoRs1yk9/cTW+jc4rOPVitg+evU718M9A8rfaDv/8Ftwd8veXmAjfH16PKpcY6wktxUNPzr04sT9AZjYYEzRIqDJX6vPCWigp+YJwsT+DyGk4WDruPlbsVfcAELL08A/47TedkB7wT1tjzj0WafDAsBf0PWcl7gaitCjIgplNrQPNDl5C9xdIRv0kKSM++s9u6uI5iWQWTpm/n4faqnVbk7lo6QG741gwc2rwoZDULo4tbguzEXJoPgL95A/ROkpBUXh2hAl0CHsV/dChHri/onwwYj62E5C/bxzo/CV9dUyc+mycfGrPTh0M4wssQ/pS9BkONxyFgDW06IA5dQuyHo9xBF7JLJCJX2Dnczj28RS5lqdFA+JNpjFWc2CivTY=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(136003)(39860400002)(29502001)(46966005)(4744005)(5660300002)(7636003)(26005)(86362001)(1076003)(2906002)(36756003)(70206006)(356005)(82310400002)(6916009)(82740400003)(4326008)(44832011)(478600001)(956004)(426003)(83380400001)(47076004)(186003)(2616005)(107886003)(8676002)(316002)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 23:24:41.2374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e5a576-0cad-4b22-1698-08d832843d02
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3621
Content-Type: text/plain

Just use the |resolve| function which already takes care of it.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 23b6ee45..d1457b84 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -346,7 +346,7 @@ def create_progress_handler(func, progress, logfile, d):
             cls_obj = functools.reduce(resolve, cls.split("."), bb.utils._context)
             if not cls_obj:
                 # Fall-back on __builtins__
-                cls_obj = functools.reduce(lambda x, y: x.get(y), cls.split("."), __builtins__)
+                cls_obj = functools.reduce(resolve, cls.split("."), __builtins__)
             if cls_obj:
                 return cls_obj(d, outfile=logfile, otherargs=otherargs)
             bb.warn('%s: unknown custom progress handler in task progress varflag value "%s", ignoring' % (func, cls))
-- 
2.17.1

