Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.57])
 by mx.groups.io with SMTP id smtpd.web08.235.1622650859967197074
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jun 2021 09:21:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Ui6iOmeh;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.95.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9+leS5xNj4pieXGseTnmXABuMsnMo10jciDE2+pjPk6gdDh+bOFBXvtNXrzjSvvxZLcZS6/9GsG9EBR7w8XAtz8HXroA725p0O6L+T2KuQWsMKJ1iz3FbrDjc+0gMpGEPak4d2Zh/KLbPGo07SNNIeEmFa2aYLo0U/u6htyfXqftGHZprN7gdfnW+3RuBCY4dEytpW82Fd7TZXHnaaBVMXzd/BoApKXLl2ezGoOcioKvWP/k1voh6i/hQPT6qoAU9bVYI/whUclRD3jUtDoYAzNkA/8WjxoBdCxaExcSDciHVi6Wbuy1bm8+HrfJAMDiPWBvhTeReXDiuJ35pdw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX5f4l3qwYPz5tWX98LWzBa1JAODdAyD0ipRH53mHWs=;
 b=fkbNpr08xwGf/WNnqC9zmm9laptMknkRrCi/2k6Ezpc6klV8ETlI+1NaRoLD0mdQjdPPdOfIUWGihtXrF4tycaQzuu6AstSJiCY7WckUhqN8dsPoRW0seW5I9EPSFLNsXczYTfUpTM/86Ww9YRDrvm4MKo/Cp4Ya0XQiB2wj1bGMSm4WAWu6kmY5rGj6IFDNCFwhDm2uTx/krAAaCmlCaEboEsyKw+9u5n//M6iKOYh3WmUEDvl9woAJX2O2NUehNIMd3eRm1l892VwysIZ0/stJBcYuwqcJy70bER7IopqT5cDOFcAHIw3c2XHty24Vwblv3xHqc0qTPNufHqyLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX5f4l3qwYPz5tWX98LWzBa1JAODdAyD0ipRH53mHWs=;
 b=Ui6iOmehFz4KrLvoyCFL0o86mbqij48d2g5/nAxvh3QoVHmx3Uq6uL6+KDpmLnzVqdMcFtAbvcwCVglKhyHP1YS5S4xoKdcbuA4X604EWR4jNX6ypClWAm/2/uxL6SiuXq/i4ZeSDDvcTugiAtFTI8yZ+j1FY94EWQD3t6k9Enpr30vw04zK4fp/zdRJd+EnnQY2r8bpPqXhvOnr0zFCvGLd1xX9R+wnI1ylB5FF3IsDbB0IX5XTCqY+J8ZetdQg0PYa26EP0wJyjZalD4cNIei+h+GXbB/M+5IFt90xeJtezH1pN9j8/qGk8/pOuUcJ5ie0utw0IYv9pLMn1+uHRQ==
Received: from DM6PR07CA0044.namprd07.prod.outlook.com (2603:10b6:5:74::21) by
 CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Wed, 2 Jun 2021 16:20:58 +0000
Received: from DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4b) by DM6PR07CA0044.outlook.office365.com
 (2603:10b6:5:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 16:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT020.mail.protection.outlook.com (10.13.179.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.10 via Frontend Transport; Wed, 2 Jun 2021 16:20:58 +0000
Received: from laplante-lm-19.localdomain (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.2242.4; Wed, 2 Jun 2021 10:20:56 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: warn on setting noexec/nostamp/fakeroot flag to any value besides '1'
Date: Wed, 2 Jun 2021 12:20:38 -0400
Message-ID: <20210602162038.17323-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b877898d-6ddf-4289-12fb-08d925e26807
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CH2PR12MB376719FDEAAF01BC421E3DBE8B3D9@CH2PR12MB3767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uO5oBvEJcbLp2oHWLv82TC19E8akkf1BJbrHOLtaXtRgY4JEAwWsp92sbrDSNRrhdwiFj++R61TWTMn6l9PdEYm7yQh1xsgpikUyTL1YQdcf6leEQ3VCo/pxb0GXFsjC0FHIL2fX892x0AjkvRxxShimEnbox3QU+o5BFToAndgj55oqGDWNSrdCeROZzIR3+gjZQvvT9tiA5luBF0D4wNru+3WnDy1EwrkzA7eqPKJD51IbBT30hT2XfyExsWznLNvXwtWxlEmhSlHhn665OnRxzj5o9tJ/j+W47otAZg6HxfCNFpWlThPXYPyQsfJcAkYeYtZCI7HGeKaxIIFkxowq2ZhWqUu8E5JdOZmytVFGcZ9oc1tc2nDhQl7ItWTXjvuPVeuWt7ZXpTiBoy4SpJPvDHWjmGLAA08R5vs21YGdyrkyAwdo4+y2rjOoUCZ7arGZf1NvKQ67ENSvVJMNy8GpJ2BKTnD2nlB+muDUBNFGJFreJ9F3Bl/Vsra6uVxznRaD6zy0Er8gLJH2afQiiJLJbgcRmQOKrvO6zo+1qp+yV+gHhWCeRq8ZS69ND9KgYJnfd9wwZHTi4XpOO88/rq4nPvQ0NdWtVS/7wn3scCCbQkSf0eF4uwUstFqzlwa380pyPm+Zih4AKW+Xz1kJ2XapcFQzFmhROtnRG+cSJOT4fmRU5uhIiP486WlI3T69
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(29502001)(36840700001)(46966006)(356005)(316002)(83380400001)(44832011)(1076003)(478600001)(2616005)(7636003)(6666004)(956004)(82310400003)(82740400003)(8676002)(6916009)(336012)(47076005)(36756003)(107886003)(2906002)(36906005)(70206006)(426003)(36860700001)(86362001)(5660300002)(8936002)(26005)(4326008)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:20:58.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b877898d-6ddf-4289-12fb-08d925e26807
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
Content-Type: text/plain

From: Chris Laplante <chris.laplante@agilent.com>

Currently setting those flags to even the empty string "" causes it to be set,
which is contrary to the documentation. In a future version of BitBake, we'd
like to change the behavior so that setting the flag to "" does not set it.
This will allow conditionally setting noexec, using variable expansion or
inline Python.

I found no places in poky or meta-openembedded where this warning would trigger.

[YOCTO #13808]

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b2715fc5..6ce8f1e6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -927,6 +927,11 @@ def add_tasks(tasklist, d):
                 task_deps[name] = {}
             if name in flags:
                 deptask = d.expand(flags[name])
+                if name in ['noexec', 'fakeroot', 'nostamp']:
+                    if deptask != '1':
+                        bb.warn("In a future version of BitBake, setting the '{}' flag to something other than '1' "
+                                "will result in the flag not being set. See YP bug #13808.".format(name))
+
                 task_deps[name][task] = deptask
         getTask('mcdepends')
         getTask('depends')
-- 
2.17.1

