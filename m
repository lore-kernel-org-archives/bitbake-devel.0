Received: from NAM04-BN3-obe.outbound.protection.outlook.com (NAM04-BN3-obe.outbound.protection.outlook.com [40.107.68.45])
 by mx.groups.io with SMTP id smtpd.web11.6.1597438632914901162
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2020 13:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=iQrAMwdv;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.68.45, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A88UiEZtOsMu3S54dWWa6s/BzmtIgUZrFt6xQj3lOwfWe71fjA0vlrASePrtOaCaT/bxekAiAngyF2uPoxolZVHuNbrKVK3Czq9G8bhjOSrt9ec+cqKdxOhvKGJPGwLSMM7padKQplIr8pQW8wSjUdROb9WH/AP7Skj/K1zG1+qlslUZDmomHiRzGrrOw0EDnhBibR/S65Fh4R3G+JsRR6FI5EPuP5gq4AJiddQBK5aPhziOgbrPg0PK1UodLItKSMSXOT0tKQk8KkWTgMUUiP+/pTODqefqhkoAzNLUXBNQ3noBek557FHsvJFWR5Mxn9q7lDf0qtm1ggrSN86vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a8BgK1HUzai47NZcR+iPeCoGZg2tPAvTpPqdkJihsM=;
 b=Vdzz9xrZoDG7Pe+YXH80GbSGsu8by9OntfilMz+zBBwsJt43CPJwXDEdycCWrngn2yktLMFHwr6hbrR6bAn5frmgf1RFMlwg+wSgJpDxTIj38vRkKpnQQmgM1OIIDkRQ1ba4dk+8wcvWyk9bjiMsU6B6LaHsVXpYogkKX0KAGhS53P8hgXgBqB499oAGRik01GeiJu1rp6NkLm3/phT+HT7ELR/CLX1RU0XJB2fmnkraJVkl3LYLckIH5LOpnKJ0LUvA1ChLpD1sxE75c4fnsuZwyyJqfln0xeZ6RsxFJEGxwDJabXH3klwcw7yJpBFub4YGbd1llBQYIum8GjUIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a8BgK1HUzai47NZcR+iPeCoGZg2tPAvTpPqdkJihsM=;
 b=iQrAMwdvquio+NhMI2lGL0qhaXudyFGx5b1s5ruOEhkal8JBGhTEfgRml/AMyiDFINx/OXLp7R0wHRS4y2zMPzALwbgeszxuChweBmh7fQa01q9+fh0IYTQ7/pTBEd74DGutFtH8YM32qzCRJx1fCYviE9kGGGo7qAySKwHHX06aWI+bgHFqXR4j5GU9CmZ/CCh4b9cUSN+SbrnTKRFDhx9rbaczVHFCMSFjDFsADENdu/J024efkZwfmo08fzgFnPOtd4wEcWja/UMLuQ3/Oe1v1EhWnGk1s7SkwdTOkIANhgPkl7h3W2C4pw4PEIlSPtBej6KBKZk1UFD63488Dw==
Received: from BN6PR22CA0033.namprd22.prod.outlook.com (2603:10b6:404:37::19)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 20:57:11 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::ab) by BN6PR22CA0033.outlook.office365.com
 (2603:10b6:404:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 20:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Fri, 14 Aug 2020 20:57:11 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 14 Aug 2020 14:57:06 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v4 1/2] build: print a backtrace when a Bash shell function fails
Date: Fri, 14 Aug 2020 16:55:56 -0400
Message-ID: <20200814205557.69655-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200814205557.69655-1-chris.laplante@agilent.com>
References: <20200814205557.69655-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f124b80-e181-48f4-b6a7-08d840949d84
X-MS-TrafficTypeDiagnostic: BY5PR12MB4276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR12MB42768A7F814E00CC38FD13568B400@BY5PR12MB4276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(29502001)(46966005)(36906005)(36756003)(54906003)(426003)(336012)(82740400003)(8936002)(86362001)(6916009)(4326008)(316002)(2906002)(2616005)(356005)(82310400002)(8676002)(956004)(5660300002)(83380400001)(44832011)(478600001)(26005)(107886003)(6666004)(186003)(70206006)(966005)(7636003)(47076004)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 20:57:11.3633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f124b80-e181-48f4-b6a7-08d840949d84
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
Content-Type: text/plain

The trick here is to use a DEBUG trap to record the line
number of each command as they execute. This is so we
can report the real line number of the failing command,
which is otherwise not possible in a Bash EXIT trap. See
http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-exit-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 61 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 977b02fc..98cbc48c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -303,20 +303,59 @@ def exec_func_python(func, d, runfile, cwd=None):
 
 def shell_trap_code():
     return '''#!/bin/sh\n
+__BITBAKE_LAST_LINE=0
+
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
+bb_bash_exit_handler() {
+    ret=$?
+    trap "" DEBUG
+    if [ "$ret" != 0 ]; then
+        echo "WARNING: ${BASH_SOURCE[0]}:${__BITBAKE_LAST_LINE} exit $ret from '$1'"
+
+        echo "WARNING: Backtrace (BB generated script): "
+        for i in $(seq 1 $((${#FUNCNAME[@]} - 1))); do
+            if [ "$i" -eq 1 ]; then
+                echo -e "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${__BITBAKE_LAST_LINE}"
+            else
+                echo -e "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
+            fi
+        done
+    fi
+    exit $ret
+}
+
+bb_bash_debug_handler() {
+    local line=${BASH_LINENO[0]}
+    # For some reason the DEBUG trap trips with lineno=1 when scripts exit; ignore it
+    if [ "$line" -eq 1 ]; then
+        return
+    fi
+
+    # Track the line number of commands as they execute. This is so we can have access to the failing line number
+    # in the EXIT trap. See http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-exit-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html
+    if [ "${FUNCNAME[1]}" != "bb_bash_exit_handler" ]; then
+        __BITBAKE_LAST_LINE=$line
+    fi
+}
+
+case $BASH_VERSION in
+"") trap 'bb_sh_exit_handler' 0
+    set -e
+    ;;
+*)  trap 'bb_bash_exit_handler "$BASH_COMMAND"' 0
+    trap 'bb_bash_debug_handler' DEBUG
+    set -eE
+    shopt -s extdebug
+    ;;
+esac
 '''
 
 def create_progress_handler(func, progress, logfile, d):
-- 
2.17.1

