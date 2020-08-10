Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.51])
 by mx.groups.io with SMTP id smtpd.web11.49250.1597078550758027401
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 09:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=r0ZyH8g6;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyYHXkLMCrJdOac8CVasEe/DZhCJVZN0/dLx6dfPR5sq6n1JBLXsC+SZJrgQMgebq1MTAqMrIEnD+8lbqUWp/yJjZeS5/65J/Ua2ba1Nm9Q1DN2/TlKX7jPqXgXNl0DvbJKu3tUXZNUcHaC7b1saotV+dwhFY/N9Ab4mv1yTTNzlvJbcMwxpgx6u0ATcd/0ET8J7LPRFp1YvHFZvcTaKyJ5o4+gzzk1QeQoLTLpHjBcFrkUnUdKG6VcdGd9BrBVZLIrZENMnLORgtsGGi7buOeZf/3XHkHZFp5pC6G0NUDhQp1FJoDFSoP+oMCjrpz0nFbnqSDR8v+2DYwYfJcwoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A61z0GrIHa8Z8h5qUPFGPY8w4oLH4PSzU+YcW/Sab5Q=;
 b=cxvBwLAAMNY2fBSPBS9LdS+yhKmzwkCLiicwI5FkXuBfPt+j/JcmalkSSg8PXPaaxrJ54nJROizPwSB6cu+WNSWOjSNzlNpNI8/MV33L3gW9O7RoZDcW1kHAlS5Ok0ejhrGkcUSkzQXSIAg2u4ahJnYDwPDJoZazx8NNhyrqyi7v+2wYcdGKtJhaVuCxloMdH/OohG9P1FQAsZU9Qaz/ZDBrkWsin/yZofHkSFt53IzY1791b2UggiwgBQgSJbM6V6Zc6Zsi9OvZcUDksPppxFUxytigQOZoPLa/6E8PS2g/nb4xbm6kIdBcZ5phrm+riMI5tKOhzwTGwJzmR+pNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A61z0GrIHa8Z8h5qUPFGPY8w4oLH4PSzU+YcW/Sab5Q=;
 b=r0ZyH8g6ajhGMN2hdhOWQqZ7FflCSwjkCQy3QexQNdXqpg38ztpcOgBF5yZsepQ3wzHpOyK81SJ0K+qKFn7hQceFyHjthBdtHIPAYuZVQGWKEH7DvIazfDq7s2R02B2VwWTdXEd3NVuLYbQtinO3w4LoKfZByU8uEmMsRpTipmn33zyEQN8P0nnGJLhD/ueYLmbGXZ3c+Xt/FtdjEQtcrbOIJiMlIgIULOJNHU5smmPB6mTQX6bXenyR/e5P+s8ckZgtQTFmp3CHJFtBgG8fYZsJpWPA5cT3cps7PoNXbLQgKcdc+3om7pmcvGZ0e5Ugsfsfdn+PqFcW7ZC0Fs2zow==
Received: from DM5PR07CA0073.namprd07.prod.outlook.com (2603:10b6:4:ad::38) by
 DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Mon, 10 Aug 2020 16:55:49 +0000
Received: from DM6NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::36) by DM5PR07CA0073.outlook.office365.com
 (2603:10b6:4:ad::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17 via Frontend
 Transport; Mon, 10 Aug 2020 16:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT010.mail.protection.outlook.com (10.13.179.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Mon, 10 Aug 2020 16:55:49 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 10 Aug 2020 10:55:46 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v3 3/4] build: add back the Bash EXIT trap to handle cases that ERR doesn't
Date: Mon, 10 Aug 2020 12:55:23 -0400
Message-ID: <20200810165524.37417-4-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24d6d06e-3708-475a-4881-08d83d4e3bf2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB3980FFD72667DE7BF5262DDF8B440@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c+AKfCRjHj6JqLxbJz60GvKLW6LohoW+9rQsjKseHRtgIZLMzUEDex3GjgIRKppX4RK3McJRQt7gHxeuqxY/srgTeVC7u4CXHcnn5pnF+dk7tlge6BXIqjMlnaf1YzSnQRcU4j5BucgeTXS8NN/T4mPbnyMA4GEzvs9PuNMwo4jAX3SDz0/ms6O+Ts4uX0KIRhVcUMrdPtYtJAHqJhAtK8ils+VFvl0LE0mw4zkTTPQ1uSSqutisICzb3AFlojtc6ZhMeVybXf1AF3DFePZRvzno6sGAzcDfSpQtElQjCckSZUWE7GoqSc1JFfeORv+yMcCC0yOFgSYow4ApgcGzkbt7IRoi2MLMsjgD5dpZo4VT76U3QVxND0LXVqui5wFYalQfVBHmshxdGwVFJx717k1Vu5ueebdOHSYD1DWTznZehO5zfWjgAi4hQRHrfFXz8K0CE7/0a1sdKxvQV6K9+wCXaIQ/xlCZMaodSOHhujcZL/jlKcXqAMojXj425gkX
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(29502001)(46966005)(356005)(966005)(107886003)(7636003)(2616005)(956004)(478600001)(4326008)(6916009)(336012)(83380400001)(36756003)(6666004)(426003)(86362001)(1076003)(54906003)(186003)(82740400003)(2906002)(47076004)(316002)(26005)(82310400002)(5660300002)(36906005)(8676002)(8936002)(44832011)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:55:49.4183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d6d06e-3708-475a-4881-08d83d4e3bf2
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
Content-Type: text/plain

ERR unfortunately doesn't trigger for e.g. 'exit 1'. Unfortunately
the backtrace we generate in the EXIT trap won't be able to get the
correct line number for the first frame.

See http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-exit-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html

Therefore the metadata-relative backtrace will just not have the
first frame. Example:

| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057:1 exit 1 from 'exit 1'
| WARNING: Backtrace (BB generated script):
| 	#1: myclass_do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line ?
| 	#2: do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line 156
| 	#3: actually_fail, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line 144
| 	#4: my_compile_extra, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line 146
| 	#5: do_compile, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line 137
| 	#6: main, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.85057, line 180
|
| Backtrace (metadata-relative locations):
| 	#2: do_something, autogenerated, line 2
| 	#3: actually_fail, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 36
| 	#4: my_compile_extra, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 38
| 	#5: do_compile, autogenerated, line 3

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 834078fd..a6b7c5de 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -314,6 +314,26 @@ bb_sh_exit_handler() {
     exit $ret
 }
 
+bb_bash_exit_handler() {
+    ret=$?
+    if [ "$ret" != 0 ]; then
+        echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
+
+        echo "WARNING: Backtrace (BB generated script): "
+        for ((i=1; i<${#FUNCNAME[@]}; i++)); do
+            if [ $i -eq 1 ]; then
+                # TODO: maybe manually track LINENO with a DEBUG trap?
+                # LINENO / BASH_LINENO for the first frame in an EXIT trap is wrong :/
+                # http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-exit-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html
+                echo "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ?"
+            else
+                echo "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
+            fi
+        done
+    fi
+    exit $ret
+}
+
 bb_bash_err_handler() {
     ret=$?
     echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
@@ -323,6 +343,7 @@ bb_bash_err_handler() {
         echo "\t#$((i-1)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
     done
 
+    trap "" EXIT
     exit $ret
 }
 
@@ -331,6 +352,7 @@ case $BASH_VERSION in
     set -e
     ;;
 *)  trap 'bb_bash_err_handler' ERR
+    trap 'bb_bash_exit_handler' 0
     set -eE
 esac
 '''
-- 
2.17.1

