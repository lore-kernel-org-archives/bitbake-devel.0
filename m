Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E0E82CB7
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 17:16:35 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.58])
 by mx.groups.io with SMTP id smtpd.web10.22978.1695834987265342611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=pk4grOP8;
 spf=pass (domain: axis.com, ip: 40.107.13.58, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS+wc/dwX06AWhC+QKD/EfXDORAKjzS7vZd/58PMZ0jhCvf/QhbdDWN9e+mogI6pMalD8QYbZnoCk8KtIR1emlA61uC8ew1nzw/nLhu0AMU2/kNmF3Z17kCavrj4axvhO78PTEou1pxi8hOSH3IE/pqD0jkOeKMORayeNtdVwcZcp7OUjyBPbH7dd8QbLdvCgvZKkpflHhNM8vr/9v3+8Ij8n9LBacYd9gmoI/WxXJiZBR0A47hFAF2igHYO0HWapOULmSVZkcRtbQ25Mqfq8/gO8fI04USpi2ZrFKPkJHmNtbhw2kbnahbS3eDuOABETdQ6lYhRJjJ/ZZQVFhOkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=758i72X5GZfWaWvu9/43TI8d5wC6k9+/HIbY9SQYoJ0=;
 b=VyNlpi1s4S9py/Ts48b/wqyc3sqcEX0+Plak+xhZmBSC/EkLbvwlnKENi9xix3EyPT3Eb6LdfUUk8ogE00VMKCFV361nFlIz0wXYZp6orPvTNracWkhpMAdPtfYFd4jCTJuGWhwp1sLuRWyUdTkxk8Tch1AdlUjE7/ZFAo1w5lJ1iOjZZAtmKg9dCWrWG/vvcQoVYnvyCRjnIx/j2CKU9CfgAOEQ6ksUc71+HOYAoigcJZI2jC1VamiBkoiIQMzvArPGuVhtIlGNRSmVOJZMQ/BxlakVpRkiYD2L0ArPK6y1S1UaIqVc3TyZB93j0svG9VCys3YZ2K9gqg5pjzsYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=758i72X5GZfWaWvu9/43TI8d5wC6k9+/HIbY9SQYoJ0=;
 b=pk4grOP8y1VjWLqOKChvkU5xch1s+2Z9OEM/8oqSMxZT0y59PZQ2MmukfaVB8/w+MJVIuSPQN/WGxIoutWF3skjf15pei8lXzNgxPQjKx8ZV3CEDK16fGmUwMepRE3nh7sS6K0MXWUODYG9YuTvKU3CWikDtmu9/6ZeKdYixs24=
Received: from AS9PR0301CA0038.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::9) by DBAPR02MB6357.eurprd02.prod.outlook.com
 (2603:10a6:10:197::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:16:23 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::dc) by AS9PR0301CA0038.outlook.office365.com
 (2603:10a6:20b:469::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 17:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:16:23 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:22 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:22 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 19:16:22 +0200
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 975AD1A75
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 38RHGMX23352829
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 38RHGMco3352828
	for bitbake-devel@lists.openembedded.org; Wed, 27 Sep 2023 19:16:22 +0200
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 1/4] bitbake-getvar: Add a (suppressable) error for undefined variables
Date: Wed, 27 Sep 2023 19:16:16 +0200
Message-ID: <20230927171619.3352810-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|DBAPR02MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b56e474-ea5e-4b1c-bfad-08dbbf7d7966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kc9JyzFOjC+rvE+X/e/Gb0sDPZ5fQv/9yQzRRqmwMBsshpLzyknrr9BmPPkDpfh1L7ZnX+WkwXbAJtKF5cnByjQ1VOTE7tvvsRUf8C8fj3bRsxrGtiZ24ogooCi4dPHN6R7qTTuaXusLSpCFUrGLaTCuEdeI9geTV4bVMlRE0JC0ljiK4LacZmYJk++zgvF+G2Ouq51+2kR9MyYCi/FRotFVwxCX0u8W8fjuQgw/+RwUFEXcZS9IsvfJsfB0yDErhmpjVVHaCpdsjNEXPepGqP7abiPDU7Gk6HLS312ZjfArvypk+uo1Y9vXIh/LrPb7jq8014zksmawkHXyolO5lf379Ut36r8p15fQUWhMhiOIfWwlYDH5fhSDDpLDFmpglDNQlsyVOxsllPh9B+lsgpCVlIs3WODIBBqwQDS3GsuoJgLZOT8OsWvzLuYQsWTy8XGBeNSEfPqI5qXr9EQa/lTUPY0/0jpMaSKfHShmT0WKFBggMLTRmXRT9ipSBSbXIRoIcDUi/oroi+ZiSbF44q3tV7wrSZtt6ZeTLpMCyN0RpnDUOOzDpSzT40xYbU0lawrewYQK1u4XK7TPkqjjo58QxhIjd4MrKyFq4ZhVzCdeNQMXVQQV1lToYEtibDFMFS6pNP/FCywlEewWBLidkdYrZKgJQETxW+a75kvJrV4Fj6e5+GRhXn8I4MeJ3U9vMosBf1+jIBGoo76bBxkC+T/fwoghiWT7i9/YXQbZpcvDAU3sQbXlyDjOu+dIU31e5AJ3ifNoxz9zKuNKTWSoAg==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(356005)(2906002)(40460700003)(26005)(6666004)(336012)(82740400003)(70586007)(1076003)(36860700001)(70206006)(47076005)(81166007)(478600001)(316002)(83380400001)(5660300002)(40480700001)(42186006)(6916009)(36756003)(8676002)(8936002)(426003)(2616005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:16:23.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b56e474-ea5e-4b1c-bfad-08dbbf7d7966
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6357
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 17:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15139

If an undefined variable or variable flag is specified, bitbake-getvar
will now fail with an error message indicating this.

The error can be supressed with --ignore-undefined, which matches the
previous behavior.

This also changes the errors related to specifying --flag or --unexpand
without --value so that they are sent to stderr rather than stdout.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New solution based on the discussion after the previous patch.
PATCHv3: Dropped the idea with the --default option and instead went
         with errors for undefined variables, that can be supressed.
         Also split the changes into multiple commits to make it more
         clear what is happening.

 bitbake/bin/bitbake-getvar | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index afd2849846..53ab900693 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -26,15 +26,15 @@ if __name__ =3D=3D "__main__":
     parser.add_argument('-f', '--flag', help=3D'Specify a variable flag to=
 query (with --value)', default=3DNone)
     parser.add_argument('--value', help=3D'Only report the value, no histo=
ry and no variable name', action=3D"store_true")
     parser.add_argument('-q', '--quiet', help=3D'Silence bitbake server lo=
gging', action=3D"store_true")
+    parser.add_argument('--ignore-undefined', help=3D'Suppress any errors =
related to undefined variables', action=3D"store_true")
     args =3D parser.parse_args()
=20
-    if args.unexpand and not args.value:
-        print("--unexpand only makes sense with --value")
-        sys.exit(1)
+    if not args.value:
+        if args.unexpand:
+            sys.exit("--unexpand only makes sense with --value")
=20
-    if args.flag and not args.value:
-        print("--flag only makes sense with --value")
-        sys.exit(1)
+        if args.flag:
+            sys.exit("--flag only makes sense with --value")
=20
     quiet =3D args.quiet or args.value
     with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot quiet) as=
 tinfoil:
@@ -44,9 +44,17 @@ if __name__ =3D=3D "__main__":
         else:
             tinfoil.prepare(quiet=3D2, config_only=3DTrue)
             d =3D tinfoil.config_data
+
+        value =3D None
         if args.flag:
-            print(str(d.getVarFlag(args.variable, args.flag, expand=3D(not=
 args.unexpand))))
-        elif args.value:
-            print(str(d.getVar(args.variable, expand=3D(not args.unexpand)=
)))
+            value =3D d.getVarFlag(args.variable, args.flag, expand=3Dnot =
args.unexpand)
+            if value is None and not args.ignore_undefined:
+                sys.exit(f"The flag '{args.flag}' is not defined for varia=
ble '{args.variable}'")
+        else:
+            value =3D d.getVar(args.variable, expand=3Dnot args.unexpand)
+            if value is None and not args.ignore_undefined:
+                sys.exit(f"The variable '{args.variable}' is not defined")
+        if args.value:
+            print(str(value))
         else:
             bb.data.emit_var(args.variable, d=3Dd, all=3DTrue)

