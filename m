Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.41])
 by mx.groups.io with SMTP id smtpd.web08.3131.1604873544701218474
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=a4sh98kB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.76.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKxgGLII/aj+IKEcsNlbjfG32tNaGR1Hgf32YE0ULt05Kxn3jhKvgqV3uEoYpqyZjjMe0Akraa1pplZH1R7LcL1zF+P932PHC3IiTNjb6C8RPJMYrcUOCuii1ycUWbB2BWzXogTTLXZDDvPs4Mqfxxq0e/PkLN2zrSbA1RBPCR7eWRfAz/CS1xeBtl7WpJZh69nimjTag3uvA2JeYRWsgBNoPbAPCcURVUcjSXwi8AetFQIuJXdSTF0hBjPO4WMfz7K5DTcXg75qdE4mhmNfe+5MX4HsnJ9UlhmMyeEWoMw62gj2HzAqX8MJ1mIpbWJlURfu4LNF2T1BUyiGgEjP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaJ3fDXtlaZLx6aN/9UqPES5X0gBsRBy1m2tQ9gJXLs=;
 b=dGMBK7vsfB4Sg4Jp6aGwZSaiV7dmPn/FCQZY35ZJ5DLnT0isfhMa3AR1X9cHfd88IngJcL5FlwqGMU3+wCKv2lGH1jcxKCWRN0JdyUkr1Aa8dPVUicILxRBPVUEOL+Vwsgjupk9VMNnFmjeXlKnNaIS8gWOIMRTE7RORzrAgHQbTt+fENik4JYO0gfcO2TGZxPE0rukgI/QYMLOeoONDTgnxQiGrsCV/74FbMoaOUysaUvzL7t535JSkU7HxD9HO8qd49wd0lfOyzTYDFAyAa3LAi5KyqSyygMHO/A465cTyDpdIsVgIQHImYDJ3xv2LqAg8RPYHZo+xBmoThoslBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaJ3fDXtlaZLx6aN/9UqPES5X0gBsRBy1m2tQ9gJXLs=;
 b=a4sh98kBK7UT9KUYNZ5Ts8BBNat4v3RPE2UFSaRLfDKaRCs4rRgWw9fh8+O+lwicUssqYgWF1lVpHZKx6mxh+ZSTqjdMlUZfqv+cj1ww5SRAzoLuX2BE5xSsyM8gbhVUmlPTHf3Q7lmnDmb/pF3bz5E3TZm/c0+NBHReEvHlI7bFwe2wY2YhPEfS1qt1lqbHeSCmAfB1qSuLAqXaGNVW6KW7Z4Nu8cFbkYOAWvCdLNTFS5FM+E3fz45rvvtlCjg3YGWzwf1D69OhEwBp7xNyB3LgCwZHmcJn23jf4zLmH4kyY7F/8IMU9hLJ5IPsLkS0OVEDduqzJV0KabvSGzMKZw==
Received: from MWHPR18CA0032.namprd18.prod.outlook.com (2603:10b6:320:31::18)
 by MN2PR12MB3646.namprd12.prod.outlook.com (2603:10b6:208:c5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 22:12:23 +0000
Received: from MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::ea) by MWHPR18CA0032.outlook.office365.com
 (2603:10b6:320:31::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT062.mail.protection.outlook.com (10.13.181.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:21 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:18 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 06/10] main: rename list_extension_modules => load_extension_modules to clarify its function
Date: Sun, 8 Nov 2020 17:10:55 -0500
Message-ID: <20201108221059.16854-7-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0c940b-b834-4920-f3b2-08d884335d89
X-MS-TrafficTypeDiagnostic: MN2PR12MB3646:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB364646755191C65F812B5B1B8BEB0@MN2PR12MB3646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	icPPDug+skwMYktcsEq0JynqFLmYHzoY8odlU/HTcD+y8GMipK18xGcTPhaqvdrZVDH5wfPPR59ODdBbwtSM+Ruh87FYNsfTd5MQsI5kE3UU1JxgfB6sQKUamZVTMqLigx9Oi6RRsIw5dNaOQb+scD0G9omdzJegAPLlwkRMCIuaggDVFtAGBETsySf3+nkyzF5JTAFx5PKuyjbomHuwmtjgyDY182oJAVEa+oZgE7yzU3iUpwcWtBPq7gxiv29XqDvufqdlOgToKUEV0KALFZYmW3Q69Xck4A+snqgi3yj4w47IrbUGuyIEXwHGIUFo69jJdHC3ef0QsiGm8MNGUYz5g6WzRL0NZjaAw+V0XgnJhEPH0fbpMWxJc7/bvf8eBQnXs+fRxfV2RIHwuhy0stY0mPA+A6w/HA5pUxLgaLY=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(29502001)(46966005)(478600001)(8936002)(70206006)(36906005)(8676002)(44832011)(83380400001)(316002)(107886003)(1076003)(6666004)(2906002)(4326008)(5660300002)(6916009)(26005)(186003)(86362001)(426003)(7636003)(356005)(36756003)(2616005)(82310400003)(47076004)(82740400003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:21.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c940b-b834-4920-f3b2-08d884335d89
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3646
Content-Type: text/plain

Also clearly document in docstring that it is the modules themselves
that are returned.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index e211768f..ccb844bb 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -40,9 +40,9 @@ class BBMainFatal(bb.BBHandledException):
     pass
 
 
-def list_extension_modules(pkg, checkattr):
+def load_extension_modules(pkg, checkattr):
     """
-    Lists extension modules in a specific Python package
+    Loads extension modules in a specific Python namespace package.
     (e.g. UIs, servers). NOTE: Calling this function will import all of the
     submodules of the specified module in order to check for the specified
     attribute; this can have unusual side-effects. As a result, this should
@@ -51,6 +51,7 @@ def list_extension_modules(pkg, checkattr):
         pkg: previously imported Python package to list
         checkattr: attribute to look for in module to determine if it's valid
             as the type of extension you are looking for
+    Returns: list of modules (imported via importlib)
     """
     import pkgutil
     import importlib
@@ -101,7 +102,7 @@ class LazyUiChoices:
 
     def _lazy_load_modules(self):
         if not self._modules:
-            self._modules = {module.__name__.split(".")[-1]: module for module in list_extension_modules(bb.ui, "main")}
+            self._modules = {module.__name__.split(".")[-1]: module for module in load_extension_modules(bb.ui, "main")}
 
     def __iter__(self):
         self._lazy_load_modules()
-- 
2.17.1

