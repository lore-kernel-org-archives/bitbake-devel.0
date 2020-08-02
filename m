Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.50])
 by mx.groups.io with SMTP id smtpd.web10.10206.1596378938113839273
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Aug 2020 07:35:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=OsjnSDYD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.50, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvwSHiuRsux7oQ8m+M6YMhORJNpkMqP5LoGIp59JmXMKnxH/SMtDd7Ss4Rkk4MTENhZFNt6SBQchesv2Kw0ed/B/f1gFDivBrG/r36ASfy4SYHgP6++3uJA7ObEZAGO6jAcpGsotcm8+Oo66sd/6RQC2J79xzW+ErkkKZS/iV6qE0Q67Y93bl3TpLRuRxHfnn9LQgB2RJLvpFZEXVwcAloIJhjVy1+EGWbj+ubx70pSmCXmT8/8Cw8TlDNC52qbOHfbpPb22UYqQl94y1twLqE7HXQtbfFMkNOeQlNHNjR1wtWLfnYIZ5g2ZmsZheS9WlEryMeO2xPbGtKXJlWsnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAtM6Cgri54JkSG61TASWQVmmSL6PaIRHstKoeb+R5k=;
 b=KHaU6TtSOdhETwSh7ZTERAC2yTczcrAhPQ/l9k7vtWTmxSYucxoLEzk+6t44W/CrDR7WUjckrImgGC2rm6ty9Q5fTAjIrIJEFfhacVkbj/PEVhb2sWpcVyHLLMyJN43KSlA/FZo2QIrwRTn3ESl4KD495YpDhCSIlTrDLISajJZmNuoxdU37nr4AiM2hc3bPlF51feYaAq/s6fWqm8L2fwLhGDE2NrDEAQZh3JZA7VQhrJnld5GbSZeFNJpzOhGUCIcPgiEPVsFkDXRlDcLSWoKsqvGyvAIyUEazSn6A6Cjo7qwmTjUt3TcgGI+Qk7AhaP+08vIdQyu+1NPDu3lxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAtM6Cgri54JkSG61TASWQVmmSL6PaIRHstKoeb+R5k=;
 b=OsjnSDYDSZzGOAV7M3liiO0qXOJomsar7JrHn8yvbSOq9vyI8wLbS+7z6vAv3RMOKscsrXtJSdAp81evFxeUn/INi1aPs7yJQXTZbRup4XI4X1wFqhsX3WP3nvk6d3MqVI+zxRPpaACZrqbUw0PU8+WaZ61D1cEW4fsjlGAM4C2DhfRJ6GpNCPyWcnEGe64Ph6ETr6rCqxf22YcVWkTwOmvmVSbj31lJZ6U0Q0rBLecBF9EJA+eH0JKDySG15U6K/i23GLXAmaPMMT4Mb8y2UZ5LAr5+jJXaBjDwsK0jVEbyvDgtFawpLGfYJQi2AEejVV+KvPWgdv8mgKleFcHBDQ==
Received: from CO2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:100::17) by
 MWHPR12MB1678.namprd12.prod.outlook.com (2603:10b6:301:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18; Sun, 2 Aug 2020 14:35:35 +0000
Received: from MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::79) by CO2PR07CA0049.outlook.office365.com
 (2603:10b6:100::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Sun, 2 Aug 2020 14:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT058.mail.protection.outlook.com (10.13.181.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Sun, 2 Aug 2020 14:35:34 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Sun, 2 Aug 2020 08:35:32 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 2/4] build: print a backtrace when a Bash shell function fails
Date: Sun, 2 Aug 2020 10:35:03 -0400
Message-ID: <20200802143505.88409-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200802143505.88409-1-chris.laplante@agilent.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20085aa-cad7-404b-56ee-08d836f150ee
X-MS-TrafficTypeDiagnostic: MWHPR12MB1678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MWHPR12MB16781E08DAC08F91D297D7E78B4C0@MWHPR12MB1678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l197oIi+xLmHle0m0RKuUxTF8zNlLslC1EmCInNfkT5PHrWKElVhnbSnq8+PAF6/HxMu3r/dhRGGgUojq1yb9O0YptK6WbKBrpILkBa59MkNAIJ+opLSy88YnBZknezWJN130fcNUiS144uHWFf9JVzO73FD+TXMKjh43gXncGojgZX9qzjSbhs/5VhA5Ye6i62B+Lo7GH6LYt/FKKF0/S1yzCUXjcFOj8Tms/lnkNFX36X20z4zzdAQiG6qxZedqxeUmeHy7sNhNgb4njTaxcVu3Tg2WWVzEdFhTMsxXFOPQ09gDj76kTIrgdwF3SVceoypvfrHYvfRehqEuDYLCc4W5TdmrTzzEIvcUD08Y+PDV3nlZS7DaoEVO25lzLW7r4hHKL2OeiIl+9e5xIPYugIUfEuFRs6QYQWq1UcJ/ZI=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39860400002)(376002)(29502001)(46966005)(6666004)(4326008)(107886003)(36756003)(186003)(8676002)(26005)(8936002)(36906005)(83380400001)(7636003)(316002)(82310400002)(5660300002)(356005)(1076003)(47076004)(6916009)(86362001)(336012)(44832011)(956004)(2616005)(426003)(2906002)(478600001)(82740400003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 14:35:34.4661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20085aa-cad7-404b-56ee-08d836f150ee
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
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

