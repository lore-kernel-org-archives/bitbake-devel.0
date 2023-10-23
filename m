Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02113C001E0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 16:46:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.70])
 by mx.groups.io with SMTP id smtpd.web11.126225.1698079595068530041
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Oct 2023 09:46:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qAM32L30;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.70, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXNh5pJ4Pyox0obu1WD8MpStD3zxkcupLVNi4W1TkuXxhsbu9yVZkhnge2zDBh1PMpU2ISn1ZCt0UNw418nw3sZ1OljWUqcHNS6ZcddSBFP0xu+YYI5crn48bhXQpGYcnUrpF0jKy/GRCvFwsimiAA9rfHhbRG/qN8/4vhzzL2RIAjjtFAoAkAXQbluSvgRI9qmtYW1r9vKuD19XpGv9pWhIqDII88k6Cx3kmgBlzKhzAaGL6VKZoc/wTR/Y/R6VqEoF2Yce0gCEvHogyYiDcU7JdJ3jogDJP12NX/PSqDyBZPqAIyq87RYfzR6TDw+/Lx3mH6K+XDHMClLjz6wjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSaDzWKqqO7zig0Oho7D3eauz+CV/eJq4s2/E3nFgCU=;
 b=k0Uks78pi942wG4MlGAlYRUok4cRaxdnsDGcx0DZBw4F01j3ftb/rRyI18KrUUzd1VvEjHOJ1AKnSWXnFQNUMsF1d77z4dZ4ZQoduR/G974tdez//759RHxUOVPBPFnZxQIViVytZL7TOW7ljShm2CvmKc+Ur8haA55b9jo+Vmkl5IeWyyYs7kLxAtRRS88Xq00NLxubqr8NqbKUAD/aTxQ3pXcsgXqAj2+MahZrtSPCAeFBL9OootZ/qpeVH4IBaxUOOimRpDo+TDVBywoCevfWIr8WSbRofp21pT2saYzsibPRg78Nx9hcaPATN6TAwWTQYV/ZG+dpstl+G4+18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSaDzWKqqO7zig0Oho7D3eauz+CV/eJq4s2/E3nFgCU=;
 b=qAM32L30wkogrm/Js0quKx7ZJo7NwPn46wgVqPWsogRoyIBOrAlBs15Vjpx/sOWnvB+8mTVmWRcjmg2bn9uztxzmt+X/7sIHxY8stcQuSaXeBFFrAI096KL9osZBtpH/Ab6iEGnMkh6F+Zq0Aw3jvQS2/khDuOJYg0Kk6gQAOWZGE9td3hlqp88pgbT9hfbrwyH4zL8tFZz7GVWxTFQounk7M5v4gRkqDeDEi51QC5oebB19qJ73ggo+sENDUI5XdPRBMz3M7wVdP/o9ynaD8bkmQ3myk+0pYrmjpNg+1oonT8GrPHyC1cMIZqAJxL9UuiHRfZVUB/7Feru5anv8+w==
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 16:46:32 +0000
Received: from BN8NAM12FT110.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::9) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 16:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT110.mail.protection.outlook.com (10.13.182.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.16 via Frontend Transport; Mon, 23 Oct 2023 16:46:31 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 23 Oct 2023 10:46:23 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 1/2] codeparser/utils: clean up more deprecated AST usages
Date: Mon, 23 Oct 2023 12:46:12 -0400
Message-ID: <20231023164613.1441846-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT110:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa38c65-2f3d-4513-8a1f-08dbd3e79c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UvH1tqAVR2UTKFNrC3OcODPKwQn1eJsheRCAbr2lkrcDFj/BjEjoDBA9lFtmA3vNbH9tAN3ICwm8JqN2CoCFtpuh9MvjmWoLbR1ker8RNdZjCZZ2eYqBdkos/AioOkRfonbPo3WG7ZoU7VRfZtTql2skkcASP/TdhTuKDcWZemckdbrgDLDX30GuVt2baydHNehwOPPRFwuDZf5PwLLLSJtDox64JEM887azKqgOG3McALLDwEXUm+ibHI5vP77VvkvcqzfN7uOk8AnDnUqKKrVuL7fLdlUu0sJZPqBfcHNsCP8XNxRF9XoqHR11NgpsCow2YziXLapUGCxfzVejxMDVKmKJe0ljpL/FYdItLuYTrLKd2+/VU6eUmI3hBrFW0l3bAmv5ChNFFSyc/NTFUEHnXHDQ3SlDMqVtt9FfIvKvIDrWkZDwBjQKcxs4lSMIr8Z0x33ARksqQzOpmS31DgawII7Hk5oSNnbFr27TZpX594EmEdYSZWrMJ7eYiSvhG82aP2QET7WCDbX5dDwgsRp5FQp0Y5Bv2T7qcBvXCWe6lJFPwl/NzTPY1a5myjdZUkWLfVXDd3u5WcgHESWShiCgtHh5TY84+NwW9yGUvM2WsCEUvI0/Sr+3732s9g17WzpiN5md4Zxh7yZHvO5JnaHlihM69tYO5bfB1rGJqbI+yVuOcG5NNiTugQ68R6py9RYyCeg7TOMRSOAMxlsZaS9lriKpPIrWVW5531b1qI0=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(86362001)(70206006)(41300700001)(6916009)(316002)(6666004)(5660300002)(478600001)(8676002)(36756003)(8936002)(4326008)(36860700001)(2906002)(2876002)(356005)(7636003)(1076003)(26005)(2616005)(956004)(336012)(426003)(107886003)(47076005)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:46:31.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa38c65-2f3d-4513-8a1f-08dbd3e79c99
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT110.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Oct 2023 16:46:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15275

From: Chris Laplante <chris.laplante@agilent.com>

Also introduces bb.utils.ast_node_str_value method to simplify handling
of AST str nodes.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/codeparser.py | 22 ++++++++++------------
 lib/bb/utils.py      | 10 ++++++++++
 2 files changed, 20 insertions(+), 12 deletions(-)

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
index b401fa5ec7..0ac304163c 100644
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
@@ -33,6 +34,7 @@ import random
 import socket
 import struct
 import tempfile
+from typing import Optional
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -1863,3 +1865,11 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
+
+def ast_node_str_value(node: ast.AST) -> Optional[str]:
+    """
+    Returns node value if it is an `ast.Constant` str; None otherwise
+    """
+    if isinstance(node, ast.Constant) and isinstance(node.value, str):
+        return node.value
+    return None
--=20
2.34.1


