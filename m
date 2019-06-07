Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 14484 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 07 Jun 2019 22:58:22 UTC
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810083.outbound.protection.outlook.com [40.107.81.83])
	by mail.openembedded.org (Postfix) with ESMTP id 344967E528
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2019 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AEr9sW9hLmQiBqdNeDWqryyxa2tvxhoruCE8iC6C8Lw=;
	b=CO7UNnJEa+GaoV9r/rNzeWc1AdcEChjYU0MGyUJva21r8bmkm9u5Fwco7Mr3rmqEyO3+rkVVXWDJ5lgeikuMSjOkTOiv2Xjzf+jabHU4zEPUDB1hWMrBJ3V5IZ+DgDb/cy9a1TZUqvoMMVoflmldy00/62P3XY8daurtRDtrm1o=
Received: from MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23)
	by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:4e::30)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15;
	Fri, 7 Jun 2019 18:24:36 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::201) by MN2PR12CA0010.outlook.office365.com
	(2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22 via
	Frontend Transport; Fri, 7 Jun 2019 18:24:36 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BY2NAM05FT003.mail.protection.outlook.com (10.152.100.140) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.5 via Frontend Transport; Fri, 7 Jun 2019 18:24:36 +0000
Received: from localhost.localdomain (10.46.26.152) by edgeappmail.agilent.com
	(192.25.218.41) with Microsoft SMTP Server id 15.1.1713.5;
	Fri, 7 Jun 2019 12:24:31 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 7 Jun 2019 14:24:04 -0400
Message-ID: <1559931844-116966-5-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
References: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(29502001)(50466002)(6916009)(86362001)(2906002)(316002)(36756003)(36906005)(2351001)(73956011)(70206006)(305945005)(7636002)(106002)(8936002)(26005)(50226002)(186003)(51416003)(76176011)(246002)(478600001)(77096007)(5660300002)(107886003)(426003)(44832011)(336012)(11346002)(2616005)(4326008)(49486002)(446003)(47776003)(8676002)(476003)(48376002)(486006)(356004)(126002)(16586007)(6666004)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2531;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,exch.smtp.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8260bf8-b073-4da4-eba7-08d6eb756573
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:BL0PR12MB2531; 
X-MS-TrafficTypeDiagnostic: BL0PR12MB2531:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25317D9029A7F264B5D69D458B100@BL0PR12MB2531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0061C35778
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AnSIbUH9wi2qHhu/rHgVrYk9L0m2RUeRp2n1QH8DQg4EBrfXhNiHTTPZgIEoNMF+l2fk7SEfWD+z11qV2DUNkvz9ga/CZ5kZhG980zqG8SCiYIku5AC1+DHp5QqEw5gscnQ53VvVbGFsDQR4M4K/cleHW6iC0BGqnhbiych3QjMgqwkRt/GnhquNhrvx3/o4NPMaFKlKqmnY/ZJARfakCTM4gkq1A044wSC3jYV62BF+b4bgb9u/nthXSxmSZYLB8cBm/tuJ5v2IXTB0gbbCSU0/O0hfwbOMs+orv0EEDQFaCkAx4kvVtJ4fW2rneB3JdKn6tHtXjdSjlWA5+Kr6uFOIyowNCzcw/oZkh33Vo15G5+Fp5tABSM28BYR0W8pejZW3KTfZNhCqdsjzDpj/d7gu8ZIe2oaIIPSvg1PfXVk=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2019 18:24:36.1107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8260bf8-b073-4da4-eba7-08d6eb756573
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
Subject: [PATCH 4/4] bitbake: build: implement custom progress handlers injected via OE_EXTRA_IMPORTS
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2019 22:58:23 -0000
Content-Type: text/plain

A separate patch to base.bbclass (in poky) will add the OE_EXTRA_IMPORTS
variable. The contents are appended into OE_IMPORTS. This provides a
mechanism by which layers (in their layer.conf) can make custom progress
handlers available.

As a backup, individual recipes can inject progress handlers into
__builtins__.

Custom handlers are expected to have this __init__ signature:

    def __init__(self, d, outfile=None, otherargs=None):

Recipes can then use the handlers like this:

    do_task[progress] = "custom:mylayer.util.ProgressHandler[:args]"

The last part (everything after and including the second colon) is
optional. If provided, it is passed to HandlerClass's __init__ as
otherargs="args". Otherwise, otherargs=None.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 85ad8ea..e2f91fa 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -356,6 +356,27 @@ def create_progress_handler(func, progress, logfile, d):
     elif progress.startswith('outof:'):
         # Use specified regex
         return bb.progress.OutOfProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+    elif progress.startswith("custom:"):
+        # Use a custom progress handler that was injected via OE_EXTRA_IMPORTS or __builtins__
+        import functools
+        from types import ModuleType
+
+        parts = progress.split(":", 2)
+        _, cls, otherargs = parts[0], parts[1], (parts[2] or None) if parts[2:] else None
+        if cls:
+            def resolve(x, y):
+                if not x:
+                    return None
+                if isinstance(x, ModuleType):
+                    return getattr(x, y, None)
+                return x.get(y)
+            cls_obj = functools.reduce(resolve, cls.split("."), bb.utils._context)
+            if not cls_obj:
+                # Fall-back on __builtins__
+                cls_obj = functools.reduce(lambda x, y: x.get(y), cls.split("."), __builtins__)
+            if cls_obj:
+                return cls_obj(d, outfile=logfile, otherargs=otherargs)
+            bb.warn('%s: unknown custom progress handler in task progress varflag value "%s", ignoring' % (func, cls))
     else:
         bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
 
-- 
2.7.4


