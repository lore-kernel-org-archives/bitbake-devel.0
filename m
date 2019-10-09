Return-Path: <aehs29@gmail.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
	by mail.openembedded.org (Postfix) with ESMTP id B5543751D2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Oct 2019 00:40:06 +0000 (UTC)
Received: from BYAPR02CA0033.namprd02.prod.outlook.com (2603:10b6:a02:ee::46)
	by BY5PR02MB6338.namprd02.prod.outlook.com (2603:10b6:a03:1b5::33)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Wed, 9 Oct 2019 00:40:07 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e46::207) by BYAPR02CA0033.outlook.office365.com
	(2603:10b6:a02:ee::46) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25 via
	Frontend Transport; Wed, 9 Oct 2019 00:40:06 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
	smtp.mailfrom=gmail.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=fail action=none
	header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
	gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
	BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
	via Frontend Transport; Wed, 9 Oct 2019 00:40:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <aehs29@gmail.com>)
	id 1iHzz2-0004Sn-Ts; Tue, 08 Oct 2019 17:37:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <aehs29@gmail.com>)
	id 1iHzyx-00080A-PN; Tue, 08 Oct 2019 17:37:35 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	x990bYSb000994; Tue, 8 Oct 2019 17:37:35 -0700
Received: from [172.19.2.8] (helo=xsjalejandr50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <aehs29@gmail.com>)
	id 1iHzyw-000807-To; Tue, 08 Oct 2019 17:37:34 -0700
From: Alejandro Enedino Hernandez Samaniego <aehs29@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Oct 2019 17:37:33 -0700
Message-Id: <1570581453-13681-1-git-send-email-aehs29@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.337-7.0-31-1
X-imss-scan-details: No--4.337-7.0-31-1;No--4.337-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132150552066580750;
	(f9e945fa-a09a-4caa-7158-08d2eb1d8c44); ()
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(48376002)(55446002)(50466002)(4326008)(9786002)(107886003)(86362001)(2351001)(2361001)(81166006)(81156014)(8676002)(50226002)(8936002)(47776003)(61266001)(16586007)(316002)(336012)(36756003)(476003)(2616005)(73392003)(486006)(70206006)(70586007)(426003)(82202003)(5660300002)(76482006)(51416003)(126002)(498600001)(2906002)(6916009)(26005)(356004)(305945005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR02MB6338; H:xsj-pvapsmtpgw01;
	FPR:; SPF:SoftFail; LANG:en; PTR:unknown-60-83.xilinx.com; A:1;
	MX:1; 
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4255c29b-5f36-4578-a5bf-08d74c513b39
X-MS-TrafficTypeDiagnostic: BY5PR02MB6338:
X-Microsoft-Antispam-PRVS: <BY5PR02MB633837005FA1FA95193FEA54CF950@BY5PR02MB6338.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZ3AJoWTcmgS/0Ooi+ADKHGHWhrz9TayS3XB+4Jgsjfl2C0BPnj5NC8T7yzxw36Doqy7haB00mkbzFt7v8PktpUqCz6GhwhpALdc/XfxCbhl1XvaPaiK9Hyu37392R+Q7HtbAi/9Jym2dJrXDVbWRfnVKL2P64BdfVDquRgNLpA+51ddjHhtyCAbN/93KZZgs3jqmOK6XBDw8uAZ/uRddVbDt1x0lZHgYMfwJ+mcD+dIuH4xvncKJgARSx8IX7eoj5p6cK48ANbWgjCcx+D+OgSEbT40Un/EEhgE3K+QFfRDXH1RkuLlA2En0KFVwYdXFGkGPVWdstcivdX7AJwRxgqPWQuilp+ewqXgIR0+BJ61IfECLo+QtBjeJ1kFvNov/WG1b19ANRBxVn9SxT6ggtvxnWyCxDxh5mtp1sa04bg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 00:40:06.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4255c29b-5f36-4578-a5bf-08d74c513b39
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;
	Ip=[149.199.60.83]; Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6338
X-Mailman-Approved-At: Sun, 13 Oct 2019 22:29:20 +0000
Cc: Alejandro Enedino Hernandez Samaniego <aehs29@gmail.com>
Subject: [PATCH] bitbake-user-manual: Update multiconfig syntax and explanation of BBMULTICONFIG
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
X-List-Received-Date: Wed, 09 Oct 2019 00:40:08 -0000
Content-Type: text/plain

The syntax to use multiconfig builds changed from multiconfig:foo:target
to mc:foo:target, change the syntax on bitbakes documentation.

Clarify that BBMULTICONFIG defines additional configurations along with
the one coming from local.conf.

Signed-off-by: Alejandro Enedino Hernandez Samaniego <aehs29@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index 02058a6..8f2a960 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -791,7 +791,7 @@
                     The following statement in the
                     <filename>local.conf</filename> file both enables
                     BitBake to perform multiple configuration builds and
-                    specifies the two multiconfigs:
+                    specifies the two extra multiconfigs:
                     <literallayout class='monospaced'>
      BBMULTICONFIG = "target1 target2"
                     </literallayout>
@@ -803,13 +803,13 @@
                     builds, use the following command form to start the
                     builds:
                     <literallayout class='monospaced'>
-     $ bitbake [multiconfig:<replaceable>multiconfigname</replaceable>:]<replaceable>target</replaceable> [[[multiconfig:<replaceable>multiconfigname</replaceable>:]<replaceable>target</replaceable>] ... ]
+     $ bitbake [mc:<replaceable>multiconfigname</replaceable>:]<replaceable>target</replaceable> [[[mc:<replaceable>multiconfigname</replaceable>:]<replaceable>target</replaceable>] ... ]
                     </literallayout>
-                    Here is an example for two multiconfigs:
+                    Here is an example for two extra multiconfigs:
                     <filename>target1</filename> and
                     <filename>target2</filename>:
                     <literallayout class='monospaced'>
-     $ bitbake multiconfig:target1:<replaceable>target</replaceable> multiconfig:target2:<replaceable>target</replaceable>
+     $ bitbake mc::<replaceable>target</replaceable> mc:target1:<replaceable>target</replaceable> mc:target2:<replaceable>target</replaceable>
                     </literallayout>
                 </para>
             </section>
@@ -837,13 +837,13 @@
                     build, you must declare the dependencies in the recipe
                     using the following statement form:
                     <literallayout class='monospaced'>
-     <replaceable>task_or_package</replaceable>[mcdepends] = "multiconfig:<replaceable>from_multiconfig</replaceable>:<replaceable>to_multiconfig</replaceable>:<replaceable>recipe_name</replaceable>:<replaceable>task_on_which_to_depend</replaceable>"
+     <replaceable>task_or_package</replaceable>[mcdepends] = "mc:<replaceable>from_multiconfig</replaceable>:<replaceable>to_multiconfig</replaceable>:<replaceable>recipe_name</replaceable>:<replaceable>task_on_which_to_depend</replaceable>"
                     </literallayout>
                     To better show how to use this statement, consider an
                     example with two multiconfigs: <filename>target1</filename>
                     and <filename>target2</filename>:
                     <literallayout class='monospaced'>
-     <replaceable>image_task</replaceable>[mcdepends] = "multiconfig:target1:target2:<replaceable>image2</replaceable>:<replaceable>rootfs_task</replaceable>"
+     <replaceable>image_task</replaceable>[mcdepends] = "mc:target1:target2:<replaceable>image2</replaceable>:<replaceable>rootfs_task</replaceable>"
                     </literallayout>
                     In this example, the
                     <replaceable>from_multiconfig</replaceable> is "target1" and
@@ -859,7 +859,7 @@
                    Once you set up this dependency, you can build the
                    "target1" multiconfig using a BitBake command as follows:
                    <literallayout class='monospaced'>
-     $ bitbake multiconfig:target1:<replaceable>image1</replaceable>
+     $ bitbake mc:target1:<replaceable>image1</replaceable>
                    </literallayout>
                    This command executes all the tasks needed to create
                    <replaceable>image1</replaceable> for the "target1"
@@ -875,7 +875,7 @@
                    Consider this change to the statement in the
                    <replaceable>image1</replaceable> recipe:
                    <literallayout class='monospaced'>
-     <replaceable>image_task</replaceable>[mcdepends] = "multiconfig:target1:target2:<replaceable>image2</replaceable>:<replaceable>image_task</replaceable>"
+     <replaceable>image_task</replaceable>[mcdepends] = "mc:target1:target2:<replaceable>image2</replaceable>:<replaceable>image_task</replaceable>"
                    </literallayout>
                    In this case, BitBake must create
                    <replaceable>image2</replaceable> for the "target2"
-- 
2.7.4


