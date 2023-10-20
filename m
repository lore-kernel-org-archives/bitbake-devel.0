Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBFEC001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:45:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.75])
 by mx.groups.io with SMTP id smtpd.web11.62629.1697827526262750277
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 11:45:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=W5wrNs4N;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.96.75, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THLIsK0K0m1T12vRcq4EHDIjDDsN3jEd4uRAfWuu5KZg44y/pSVYL3YthI0TLsxEXUSzQN1M4EcMXrZK/mrw3yQuC/67r68v+OWTEDLZxGndlrPdT1dljcfLrCcwSg2s5z3O7K7xcIFRhuX6MO1SV+V2uzhvrWxtkAY3L8yeCNl0ukT/qa78KnX/66wmgxstnbHiiM9ZwIenTnpvcdh5YqF+p5AKT8VHl4Nu0y9vwvgRX86RZmEoLyllDgUP9VOfjuAhJ8p4HAPdStd89XbR38ZOms92mAOqpQ7QjFRSD5DFwO4OIla14z+1O64/IjB2UlnbCUopQCNmPmJTlz3pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DkQqyBWoi3Z8CubTv4I78TIZRoNVcEUpBjm1uoCUgY=;
 b=XOrWVbbv8fAsvtWty9PQ9eeHx/xS3GJNAIiKVvM0zk+JhieRaiBg1n6h5ie3p9JIJA6BGkonVrqVU1E0QzNeYXwweNNC6MnHDxMVmr2QRgTgzO9xQChGzKmZgHj0IyljhlJ9n+kff7msxq7dSRsb8kIBVdiz38/FRKXCdgye2dqiYAWGepmSqMMdQYnpNS3Juftl7fpF21enCQQKlRxPwQUC4B9InEtCUGYzXfAXxiZndnnXOEPbDqlLoIaYiUCssDzrvHUSbDpkBsSPItG7Y22qoT1w9un63i+qA0HycwrdUpbY5D2tHI44U25slSM9xofugLGHUxaDU2wc4yflxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DkQqyBWoi3Z8CubTv4I78TIZRoNVcEUpBjm1uoCUgY=;
 b=W5wrNs4NRPfPEyIoESjVG6xQ4UHH/zGpT09Vlia7SxoIGDoa8vYRgMgHUJKKntzqsB174hpVRhnkKS8Jt+LE1G+StR4rFXORE4pADW4C19rQt6AwXcQGPkkllnmBa+1NjesBIV/l0KN0oHVK2qeuzTAF9K6XAwSMGGvgqcaqR6fh2uhAhSq/iPwaHdm+QXAkOsbu8MrJmBBFsIwEOSFjeVQ4kNlWIjAJYKgV3ro0j8HGfd/hi2pZbissRJaoaGcJWJ2cxNlIEWOekfO0ttW1aqYZOJQOk3eepTHblzDSvFi4dGRI6SK+OXqfE/PDmvi8ttkozulj+x4zK4sprYEeaw==
Received: from BN1PR14CA0019.namprd14.prod.outlook.com (2603:10b6:408:e3::24)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 18:45:23 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::1b) by BN1PR14CA0019.outlook.office365.com
 (2603:10b6:408:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 18:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.8 via Frontend Transport; Fri, 20 Oct 2023 18:45:23 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 12:45:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/3] codeparser/utils: clean up more deprecated AST usages
Date: Fri, 20 Oct 2023 14:44:58 -0400
Message-ID: <20231020184459.1420806-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020184459.1420806-1-chris.laplante@agilent.com>
References: <20231020184459.1420806-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT068:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cb9210-a75e-4fe1-b956-08dbd19cb7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2U85OeO6Ay0NYb5THlH2w3iuIXyvStsM8uMww3r4Bv3xukk1rMoueLsWOkkBduYhihBBmRW/Iv3Dfp22x4X9pLgZ8+Pgt+6eUqbGNX7RDAw+EOQqZMHl2K0XJqG5kxNdTtCZlhS3160YSLf/Y5h6z0pHhGLIYLnKqkuUnqSOt3IRNUaE59EPe5OPa6CsH/U6oI9VeYZ3hwULyERTwF5oxYR9g48UrtFQ4ujrpSD5G0+5lR8X86oyZw1HGMFABPk411um7tYyJ9BRvzbE8y0+xXs55Gb+SL6u4Y87GEz0Dqu0s1bg1jTmfcWY5m9Q7v6g+XkSGaOFiLBfDfdN6SCmfSxO4XWuhJA6jXLh2Ec2vXi+j3Nu3+V9OZdnqsD/HDm5S/P3KziYnVOqWbMO4nNSKQDgnPXH//kUGGGWzPK6Gob/DILV6UxDN2v4b5imVrdKaNtLZq3fHd6WYvj+rgob0/XEzrgkb9iN1XewCXNwWhunKllURAtFg+CQCQYJkUlSCa6+9AyYCpMj20ioRnZqCQtY4eIT62Y8lSLukiTEPN1iXeGvCsANs6+OYjhNu2Xizbq0I8zkSb6sNu+V373bQXgsxBbtN2Ss+Nh9dkcBrlHWW2zwGYDjBYvRrQLur3Yeq/DrEmDWMm292cpKAKi71PsBtBtkJ93doqF9TklnpsgnKV6dz2/0X2cEr/Cbx4ZRM2DgfnQA4OBKUGiszzTuOySigh2YuYlPzrRbsi0AURM=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(70206006)(6916009)(316002)(8676002)(8936002)(6666004)(478600001)(47076005)(4326008)(41300700001)(86362001)(83380400001)(36756003)(2876002)(5660300002)(36860700001)(26005)(107886003)(956004)(2616005)(1076003)(40480700001)(356005)(7636003)(82740400003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:45:23.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cb9210-a75e-4fe1-b956-08dbd19cb7da
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Oct 2023 18:45:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15270

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/codeparser.py | 22 ++++++++++------------
 lib/bb/utils.py      |  9 +++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index cd39409434..92ed31fa5f 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -256,19 +256,18 @@ class PythonParser():
     def visit_Call(self, node):
         name =3D self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.get=
varflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Constant) and isinstance(node.=
args[0].value, str):
-                varname =3D node.args[0].value
-                if name in self.containsfuncs and isinstance(node.args[1],=
 ast.Str):
+            if (varname :=3D bb.utils.ast_node_str_value(node.args[0])) is=
 not None:
+                if name in self.containsfuncs and bb.utils.ast_node_str_va=
lue(node.args[1]) is not None:
                     if varname not in self.contains:
                         self.contains[varname] =3D set()
-                    self.contains[varname].add(node.args[1].s)
-                elif name in self.containsanyfuncs and isinstance(node.arg=
s[1], ast.Str):
+                    self.contains[varname].add(node.args[1].value)
+                elif name in self.containsanyfuncs and bb.utils.ast_node_s=
tr_value(node.args[1]) is not None:
                     if varname not in self.contains:
                         self.contains[varname] =3D set()
-                    self.contains[varname].update(node.args[1].s.split())
+                    self.contains[varname].update(node.args[1].value.split=
())
                 elif name.endswith(self.getvarflags):
-                    if isinstance(node.args[1], ast.Str):
-                        self.references.add('%s[%s]' % (varname, node.args=
[1].s))
+                    if bb.utils.ast_node_str_value(node.args[1]) is not No=
ne:
+                        self.references.add('%s[%s]' % (varname, node.args=
[1].value))
                     else:
                         self.warn(node.func, node.args[1])
                 else:
@@ -276,8 +275,7 @@ class PythonParser():
             else:
                 self.warn(node.func, node.args[0])
         elif name and name.endswith(".expand"):
-            if isinstance(node.args[0], ast.Str):
-                value =3D node.args[0].s
+            if (value :=3D bb.utils.ast_node_str_value(node.args[0])) is n=
ot None:
                 d =3D bb.data.init()
                 parser =3D d.expandWithRefs(value, self.name)
                 self.references |=3D parser.references
@@ -287,8 +285,8 @@ class PythonParser():
                         self.contains[varname] =3D set()
                     self.contains[varname] |=3D parser.contains[varname]
         elif name in self.execfuncs:
-            if isinstance(node.args[0], ast.Str):
-                self.var_execs.add(node.args[0].s)
+            if bb.utils.ast_node_str_value(node.args[0]) is not None:
+                self.var_execs.add(node.args[0].value)
             else:
                 self.warn(node.func, node.args[0])
         elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b401fa5ec7..55f8231999 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -11,6 +11,7 @@ import re, fcntl, os, string, stat, shutil, time
 import sys
 import errno
 import logging
+import ast
 import bb
 import bb.msg
 import locale
@@ -1863,3 +1864,11 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
+
+def ast_node_str_value(node: ast.AST) -> str | None:
+    """
+    Returns node value if it is an `ast.Constant` str; None otherwise
+    """
+    if isinstance(node, ast.Constant) and isinstance(node.value, str):
+        return node.value
+    return None
--=20
2.34.1


