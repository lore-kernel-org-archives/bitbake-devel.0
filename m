Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.77])
 by mx.groups.io with SMTP id smtpd.web12.986.1595892092401160850
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2020 16:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=BcwjxpIo;
 spf=pass (domain: agilent.com, ip: 40.107.77.77, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btiXQaiipzsfTQ9k1mJFvQ3NpujqztMDN82edL0A0iZO7dHikA/lQyTHHERZNG0WwFTXjg93SiN+vkKAv739Bps6pJdb6V4bAstP82J88ksukA10OkANS9Q6DE3hVQwmzaO5RLnjk0Yz1MoGfaQC0f+ZjkvYfUoXKyNLeHuP/92K7hWRjkCs6pncitWCTn9jfbDPzIicjsFnlrS6gZ7wEwetFX5D7FFrBHcx91OnEDO30yg7VAJqpT6lOce0wAOei+YZ31c/EE19nUUmjSU5zKB97q6OLYrumubFmC4CZWd9FCHYg9MfST5eruLyfCUUpn9vRQABp3SjpeofnuOjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBg3Doc1YSLSwyIMqlnCiX5Vvo1Vm7CjQ/+2dMyn6Dk=;
 b=Nca756FiLhFPZlbVgTzcKXtOWvWUzlq9BDFw+AeL4vvvDem/JtMqjG0YOQqeqImU8Cu3UkIe4SJaoVbmzOzULE7pdKLLGGRm7NnCe/SNvJOZ2rYIhbbXMNcALwhMPn9QIgDUf4ic3fKOZrdi/cMxSOpL8SxcCU+JyPeUeAzHQc4PTUqi4DZ7wgU0Thi1ZOBS25jqVLTI90IareQX2fmPtehgag8y3d+U7r54xDVGIdYxzAPpUvDJgIwU7/2dWw2JsKk2kvT4zN0084iDbZTTIZ14cB4ijlSOLKcIPwhvpf05N3vZ96FKDAIdxoNfXFgKcwAOrGT1Omts37YM4W6pSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBg3Doc1YSLSwyIMqlnCiX5Vvo1Vm7CjQ/+2dMyn6Dk=;
 b=BcwjxpIopBSIeQlFxf6oHvw5V3pmrH3EU54P4N1OCSB/lKuPssawNzyubwrsfNcCFMzsXZ5gG56SKgTBQeMhJZ4NZJvHwM8Do01P6eTHcAiGLQPJAUHz0VXY4OxnRFYTeis92x6MghA8G+FybbG4etqtoWEOJTK22qKwxJUGUx82xHQJYRrBcKclueCZMNz3nz1Ah1RAPQdS7A/yum+oIMNW4xmaDUsT1Y0SkyumfgpZaGBN/NiptCX0VuHFoIv7LsGCSK8iVXSbC3C41xqVKQh75kUkT8sLH8TOjmXqJ7N3TLXYaiD1dPYPN/BAxardIOyjRNEPmivAedvPghZ8rw==
Received: from MWHPR14CA0002.namprd14.prod.outlook.com (2603:10b6:300:ae::12)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 23:21:31 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::8) by MWHPR14CA0002.outlook.office365.com
 (2603:10b6:300:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Mon, 27 Jul 2020 23:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Mon, 27 Jul 2020 23:21:30 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 27 Jul 2020 17:21:28 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: print traceback if progress handler can't be created
Date: Mon, 27 Jul 2020 19:21:23 -0400
Message-ID: <20200727232123.23131-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2f9cfe3-c185-4a1d-f876-08d83283cb83
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CH2PR12MB4151BDB72BB14B8B43D9FE578B720@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f+E08XydUOGBpIYzuyrmyZNYzGCGKYLY9/SR6iwA86EkIkjVlH9Uz2TOxB8DEmnyfKW2MqOWjhalW0e/6lusqGGl9/Z45hS7n3cG1PM2ucXeQr/+VMPCacPoQ3aSGEODFt4Any/csQXZR/io8RXYtFZB6KV7+FdVOEcu1tImen4BgTGFDt/dtjMWvS12XM4mxwYknkNlgpxzRq942OhSw1jQ+ufhgWd0hRx7ffIgVGHbAL+nCRlMYBBWeMkNOVzedv8CORM7inTs3Z0qWBVvEgn+4CNQXzQcHQGfijx9O55NVUPue/G00putTJWTiKdtOO2jziVWmJHFK+FijaRy6zBTwvjzqjUwBD+lyfyJPW87j0NSjKnrgnYqKMaOCIMwLNMVSnUY/P2JylezhRu0iIw/AR75OQonc3ppW7/5iaU=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(376002)(29502001)(46966005)(478600001)(956004)(2616005)(26005)(5660300002)(6666004)(6916009)(186003)(316002)(44832011)(82310400002)(1076003)(70206006)(36906005)(47076004)(426003)(2906002)(4326008)(36756003)(83380400001)(107886003)(7636003)(82740400003)(8676002)(86362001)(356005)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 23:21:30.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f9cfe3-c185-4a1d-f876-08d83283cb83
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
Content-Type: text/plain

Before:

ERROR: expat-native-2.2.9-r0 do_compile: 'NoneType' object has no attribute 'get'
ERROR: Logfile of failure stored in: /home/laplante/repos/oe-core/build/tmp-glibc/work/x86_64-linux/expat-native/2.2.9-r0/temp/log.do_compile.90289
Log data follows:
| ERROR: 'NoneType' object has no attribute 'get'
ERROR: Task (virtual:native:/home/laplante/repos/oe-core/meta/recipes-core/expat/expat_2.2.9.bb:do_compile) failed with exit code '1'

After:

ERROR: expat-native-2.2.9-r0 do_configure: Failed to create progress handler
ERROR: expat-native-2.2.9-r0 do_configure: Traceback (most recent call last):
  File "/home/laplante/repos/oe-core/bitbake/lib/bb/build.py", line 400, in exec_func_shell
    logfile = create_progress_handler(func, progress, logfile, d)
  File "/home/laplante/repos/oe-core/bitbake/lib/bb/build.py", line 344, in create_progress_handler
    cls_obj = functools.reduce(resolve, cls.split("."), bb.utils._context)
  File "/home/laplante/repos/oe-core/bitbake/lib/bb/build.py", line 343, in resolve
    return x.get(y)
AttributeError: 'NoneType' object has no attribute 'get'

ERROR: expat-native-2.2.9-r0 do_configure: 'NoneType' object has no attribute 'get'
ERROR: Logfile of failure stored in: /home/laplante/repos/oe-core/build/tmp-glibc/work/x86_64-linux/expat-native/2.2.9-r0/temp/log.do_configure.22982
ERROR: Task (virtual:native:/home/laplante/repos/oe-core/meta/recipes-core/expat/expat_2.2.9.bb:do_configure) failed with exit code '1'

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 23b6ee45..cb2e75b1 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -398,7 +398,13 @@ exit $ret
 
     progress = d.getVarFlag(func, 'progress')
     if progress:
-        logfile = create_progress_handler(func, progress, logfile, d)
+        try:
+            logfile = create_progress_handler(func, progress, logfile, d)
+        except:
+            from traceback import format_exc
+            logger.error("Failed to create progress handler")
+            logger.error(format_exc())
+            raise
 
     fifobuffer = bytearray()
     def readfifo(data):
-- 
2.17.1

