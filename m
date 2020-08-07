Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.77])
 by mx.groups.io with SMTP id smtpd.web12.7121.1596810253187223330
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 07:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=blQobnnX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.77, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLtWtnT98WepmilS87NXZayk1zv/oI7cVbEPHpqnl3WGflf1ZPyrdxLaw6UYZljeafigUB1BtGXtJE1zB8fF6qpdSpMA8hgW9cn844/mpmng7dbOYtCcQtNMlMim+CbvgwczsULzYApZxT5tpGvEuucecnpNzEVKL/V3sq72Df//4Kx+FCzrkNHBRx0/jiHIcHPckorJ7MmM0lsW4tLmwh4qE1p5MPA6QeOTyGuUUEGxB/OOTXu9xS+Y4FdxsMlQl7Zx5NQyu3eqiOrFh8S2/Gq9CgXcQ8uj+xwve+XuEEetnBgfrO4uPhM9ft6xE6D742p/oAXksJF3PdvW8S96iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68zcy2//HOUzewmCkjm29+ltBOfexVJKMvgFSPu7DjY=;
 b=Ri84JDISnknT4Qc4BP2vgBF82qEhN2sWHmYJKyL9oSOcCKrxunmvNZ5b/QHDgwfxupXu0Skac5mUeFRn80yzbC+Dy93s+mCyjcsGLAFaxqpJtDj0joTMqFTrIM78rrWffSRtOg/V0P1g1CZ2BA5pkmqI+lDsqcWg9KrVMjreFZD4HdgCWEkoXjaQ73PoOjAhg8n9Nt7Dj0ydVPgOcitzBAPX6Hqvc6t4mCn4p3EE3RayMiq0ZeZbHg2Kq8HDfPIJRpigqVsPqQxoESS1S5SblFEfijt7a+WDZSzBX475sEWJQtc1YDJsYRMNAmCvVb5PSG7g0BkUURjhA8J6fgL5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68zcy2//HOUzewmCkjm29+ltBOfexVJKMvgFSPu7DjY=;
 b=blQobnnXASrnxMBYy8xCG3gjRPAV/GT+/ePGTm+5uMZwyADYcC1IZhNiE5xmwpwbCWEom1Uzau90vC06prxJbOm0NjqwXJJ6fjFbKbJAGbxomqgfRBVVJ2EOYvjaQRBMto94qiHAqRDGEaKEJSOQuZXmTr9mdUhHRC7Waji3+dngj60yKo4bJs47NR2I3m4lJOkcqtEUumPeH5yqlOuc9lqnk/Od+8jWi1h54BwnO1YUTUXkcD3ZVk4R7YThQsRkwoYjXRa8oEMqxhd8NOyMuIyLDvYezJwXTUYvUDDRzFP0mt5Oq/DrUybS2ZdSiJjswGqT1P/wIOz6Rl1yzm9iXw==
Received: from DM5PR19CA0027.namprd19.prod.outlook.com (2603:10b6:3:9a::13) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 7 Aug 2020 14:24:12 +0000
Received: from DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::20) by DM5PR19CA0027.outlook.office365.com
 (2603:10b6:3:9a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17 via Frontend
 Transport; Fri, 7 Aug 2020 14:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT053.mail.protection.outlook.com (10.13.179.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 14:24:11 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 7 Aug 2020 08:23:59 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH 2/3] build: print the originating filename/lineno of failing Bash shell functions
Date: Fri, 7 Aug 2020 10:23:42 -0400
Message-ID: <20200807142343.8648-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807142343.8648-1-chris.laplante@agilent.com>
References: <20200807142343.8648-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1874e73-9de2-4b77-60f7-08d83add8e06
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BL0PR12MB2355242E5A86DD48DD9155F18B490@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t/vq7L1FHcJACFWaaUIm4ZyjQrztXy6Vuff4fq//4VRupWxuQgGc8mvszeCFFtPayvqBPkPORx6DdkZ/shhuPU8/BY2rCTyNozNHchHDyGjTO9qSqhk+ZPfyivXmxqa9/KD589hTbu94Hhggz88hAiLiDG60NP9xPbXZ7aaGtQe1a+gbjmZrX/fEC5zUzFGPpeHQ1CK/um1FFq61zjyhQwjpBaw/Tfiy/pEyJNuuIezY2PaCKIP4omrgzmnj0sComAe0VLihlnhCRXS+juB4T6NsOsOM4bgPhgR66P22mS/LXBv/EDbd8lFIg7i2wd7lrjwgjtWsb4DaDF2P8RL3PrAHadNt8nM1/vuQWIIRP2TmvOjPFu7jD5PglwOTieZLVX7n/HLn3mNuJzGffmdRTSZcx+m4ZM2PfzDT2pgdCcE=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(136003)(39860400002)(29502001)(46966005)(47076004)(426003)(82740400003)(6666004)(82310400002)(2906002)(26005)(2616005)(7636003)(70206006)(956004)(107886003)(336012)(44832011)(186003)(478600001)(86362001)(356005)(36756003)(36906005)(8676002)(6916009)(8936002)(54906003)(83380400001)(1076003)(316002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:24:11.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1874e73-9de2-4b77-60f7-08d83add8e06
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
Content-Type: text/plain

This patch modifies the shell trap code which is injected into shell tasks.
The behavior for 'sh' shells is unchanged. But now when a Bash shell function
fails, the following happens:
1. At the line on which an error occurred, the enclosing function name is grabbed.
1. If the shell is 'sh', simply report the return code (just as it did before)

Before:
| install: cannot stat 'source': No such file or directory
| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.95318:1 exit 1 from 'install -m 0644 source dest'

After:
| install: cannot stat 'source': No such file or directory
| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.95318:139 exit 1 from 'install -m 0644 source dest'
| INFO: /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb:32 is where original shell function 'my_incorrect_function' is declared

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 977b02fc..bbea20c6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -304,19 +304,46 @@ def exec_func_python(func, d, runfile, cwd=None):
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
+    # Determine the line on which the failing shell function is declared
+    shopt -s extdebug
+    function_line=$(declare -F "${FUNCNAME[1]}" | awk '{print $2}')
+    shopt -u extdebug
+
+    # Grab the special comment that precedes the function declaration - this comment contains the filename and lineno
+    # that BitBake tracked as being the original location for the emitted shell function.
+    prev_line=$((function_line - 1))
+    function_location=$(sed "${prev_line}q;d" "${BASH_SOURCE[0]}")
+    pattern='# line: ([[:digit:]]+), file: (.+)'
+    if [[ $function_location =~ $pattern ]]; then
+        relative_line=$((BASH_LINENO[0] - function_line))
+        # TODO: handle 'autogenerated' (e.g. from _append) by walking up the call chain to the nearest real file?
+        # TODO: actually just fix BitBake to include filename/lineno information when _append is encountered, maybe as
+        #       separate varflags.
+        echo "INFO: ${BASH_REMATCH[2]}:$((BASH_REMATCH[1] + relative_line)) is where original shell function '${FUNCNAME[1]}' is declared"
+    fi
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

