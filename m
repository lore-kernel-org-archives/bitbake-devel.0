Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.89])
 by mx.groups.io with SMTP id smtpd.web10.49459.1597078549462989683
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 09:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ToVaQk+F;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.76.89, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/QfiwHUuYOGUM4vTwfVh0rCfrhkHHI88XhMXny8dUqBySlqu2EPTG8Mq7yY2xhrK8f71zM95hl6PpbGd7eYAC4o9qnmyEW0P2ArZin/6teY1HzPXPxRJzhoJi4F8JbO9EjYW/JjyJr/ZiClU+RbV4OE8qcaEDyiNo4I/uNZdj8JpSZU50bLqapfV9BOSwZepEIsVTdKZm4az27fphmN84gsniuScNGLzrwVq0KTnNpEHsf0fh7z1jSykA+b+ru4kLrj+4JXFCPBmg/71eBViUEQzFV8ShqTwPPPlwlxSGcHLe+1+8M0c8AXnZFofzRifh/WxZG1q5qZI0DjMf8Jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAtM6Cgri54JkSG61TASWQVmmSL6PaIRHstKoeb+R5k=;
 b=mxyKv5u2o89HDMLc3DGd0RjcIETo9ehfOpH+0UYRShuXQzgjNLA40LV+lNsUHv/P9t7iNbPa7+fW72IATIvS0s9pUokC0Q2cv7rK6YRGec0OLHI6KU8x8mo832qm9PY9ZbIFu1+rR4hy5yVBEA1eaJx3PBYzF10EeQ/mfAlWECisETIFXaDWJR4a73SYgrQWuCvIvLUlxqNiDbwDIEXufGD3Y9hFf3l963SpK9FgWjwcsc6wuqZib7iJUXEG6SArLpYixGsblacc0P1Ipt3nGFJj3eAJjC98dmLK+iYYYCBkqdVRZiCirx/0QY1eheV2FqlhiaL6GoQajhbK7af6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAtM6Cgri54JkSG61TASWQVmmSL6PaIRHstKoeb+R5k=;
 b=ToVaQk+FcN1W5/m0eGTNJU7X/hpy4V3abTEhuaaHnfbO+1QlLNgvH+2Wnq7hyK/7GlRgWu62sZyQ5BFM5PJPLaBwiwbGF8Y3FVTZqGPP+Zl8XAxYWvThRcVfNGb6YBSaRmXG1V+SHZhg4eXusnINFvK4izKWo7XZJaFupA9J/xChYrU5gaTux3iaFeZuZe8VNgvcMULMOHtVFlZGGSaDDf8MI6HaJY9KboZnpnBmjGZAUw+i3meuLMZqoUGNUPNKPAPEN70gkx6Mf9nMcZHhyzQezaqaLL2BosCT6zTt3wmi6wGIrHq4yxf/I+huekUiaZqzzj6gRAsGG7CwoRHahA==
Received: from DM5PR1401CA0005.namprd14.prod.outlook.com (2603:10b6:4:4a::15)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 16:55:48 +0000
Received: from DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::9a) by DM5PR1401CA0005.outlook.office365.com
 (2603:10b6:4:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Mon, 10 Aug 2020 16:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT022.mail.protection.outlook.com (10.13.179.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Mon, 10 Aug 2020 16:55:48 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 10 Aug 2020 10:55:44 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v3 1/4] build: print a backtrace when a Bash shell function fails
Date: Mon, 10 Aug 2020 12:55:21 -0400
Message-ID: <20200810165524.37417-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810165524.37417-1-chris.laplante@agilent.com>
References: <20200810165524.37417-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd14bf68-96db-4c07-736f-08d83d4e3b20
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN8PR12MB3073BF0A64F1C01A9B74897D8B440@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HEgrRngAd/khD2WEW1nxhTIktPRsWr5j4HrbmBfPcGDBa8zfqmsGF9VwApER0SlgI72Zq7yNqd8sfy0GRKLlUVLhzPuN1gcjBoEOJZQFrBcBzK0bZtqkBGQjB10Wdm5i20KHoHM6Eb9eONSM7apqX81BQtAt/xzl112QL03ypOpeW5OV55bI7LSQ6Tsc3pSjkqohMtKhsvRbocNz9m/sV0uO3VQuIB/G7vvLZE5e1Wp+M/jCSvzuCWPDV3i+kF1ACD8+1gHkEr89LxE6BZjGF7QOlo66XolETzRc1r1TPtr5UjLVR3Ql3BdzCbZD0h5/iQraYceh9ySdpIMeG1j2ym9tpZDNRErA8eufNCGhEdpmgPw6svKwJS9srLi2VyTPXadHglosecDxRRtAfIdcdga01feCtm7ho9eYCdmTlBA=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(29502001)(46966005)(82310400002)(82740400003)(8936002)(4326008)(83380400001)(36756003)(47076004)(5660300002)(54906003)(70206006)(478600001)(44832011)(86362001)(8676002)(2616005)(107886003)(6916009)(26005)(956004)(186003)(426003)(2906002)(6666004)(356005)(7636003)(36906005)(1076003)(336012)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:55:48.0431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd14bf68-96db-4c07-736f-08d83d4e3b20
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 977b02fc..ad445aa9 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -304,19 +304,33 @@ def exec_func_python(func, d, runfile, cwd=None):
 def shell_trap_code():
     return '''#!/bin/sh\n
 # Emit a useful diagnostic if something fails:
-bb_exit_handler() {
+bb_sh_exit_handler() {
     ret=$?
-    case $ret in
-    0)  ;;
-    *)  case $BASH_VERSION in
-        "") echo "WARNING: exit code $ret from a shell command.";;
-        *)  echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'";;
-        esac
-        exit $ret
-    esac
+    if [ "$ret" != 0 ]; then
+        echo "WARNING: exit code $ret from a shell command."
+    fi
+    exit $ret
 }
-trap 'bb_exit_handler' 0
-set -e
+
+bb_bash_err_handler() {
+    ret=$?
+    echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
+
+    echo "WARNING: Backtrace (BB generated script): "
+    for ((i=1; i<${#FUNCNAME[@]}; i++)); do
+        echo "\t#$((i-1)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
+    done
+
+    exit $ret
+}
+
+case $BASH_VERSION in
+"") trap 'bb_sh_exit_handler' 0
+    set -e
+    ;;
+*)  trap 'bb_bash_err_handler' ERR
+    set -eE
+esac
 '''
 
 def create_progress_handler(func, progress, logfile, d):
-- 
2.17.1

