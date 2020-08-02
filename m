Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.89])
 by mx.groups.io with SMTP id smtpd.web10.10207.1596378940284704859
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Aug 2020 07:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=bM1Gfi7K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.77.89, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWkHZ/P+lS1lSMlzxZjcngh/oCmbNnjwi9yW+LDmVYPJidav8GosGkRQVdEUt3gLtwTiXBC/ocvFl5BUz4d0hzWmwF8syVdgl52tC33xx6jBxqdMllEYwyohuYSKUtyZBahr0x2XN7Ee5mM/PKNxIjVO860qg4aM3aiUMHkhZ9NJtA1FtHxTCl3s+aFn7AQEFAFM9AnVwV8qtYKUmOk6uW3JCid/TiUwsoxufS9/4cYw9aujm/Xdcpm983KE5HiGy6H90TdFrvQLq38amai0b009BkeomHhmG1mvqPHKTEoIDJOAAHNhQ2LrmS5jeQFjKy9C00914xhqsbPoIBTAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A61z0GrIHa8Z8h5qUPFGPY8w4oLH4PSzU+YcW/Sab5Q=;
 b=Zg9BDUH0EjBaiuuEKt6kH4fzJTY3/m5T33bxTSAPBNw/mf/ej8ajELldo4FRCYmMUPxlXZZzB6x7lItICJV1uPgie5RjfDC+WEz+Hrtd+Uv9+CYuTdoznzxSnf9ddy5MiPwzOP/JhR7wVZ6UNpAFitfuW632KCAAwonjS7ws6ZFZ/MKkVn5d39NS0jLXDNi4rip3gCpsUViNFVl6sB32SOwqYqbwnsjVWuZTqnz16cdGh296hXOE61CWon9xzskHxOUaPTVmp/hyVjCMQ6nJtCKsX6gKUsW5804o5Xqd2gxdasZygUsvxXD+WPjvGG0BXesY7NZXa1or28v/Z6ZXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A61z0GrIHa8Z8h5qUPFGPY8w4oLH4PSzU+YcW/Sab5Q=;
 b=bM1Gfi7K6d8qNOIWD5tlTwyd6PlqPitiCy7nvoJWVGXBWYd8MZonZvJTowdaBgfMH+SGyiZGj5ycnQYHfHzUNz5cGmaIs/Xq6/NP1kC4xiIkHEJ9hT2QYdR+a6uw9VIf6mYwdAapG4P959llNmn0BqBxxZSgbWpkenBQlHyr9XknOEEPWuq3/celGgAQbE+wbE4HTzggLpeK0ml+cNN5EoP072ZGkyv185/END7YXxPAMecSz32oUCUrfsNZaPm655WcGgGma+hdyejrBZ7CkMTRp2Aa4+HS0NUQVCxxOYKb2yGrHcN7i7Hhi7d8zwKxaJw9urMLfCBFVKysP4tpmQ==
Received: from MWHPR17CA0075.namprd17.prod.outlook.com (2603:10b6:300:c2::13)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sun, 2 Aug
 2020 14:35:38 +0000
Received: from MW2NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::ae) by MWHPR17CA0075.outlook.office365.com
 (2603:10b6:300:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Sun, 2 Aug 2020 14:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT025.mail.protection.outlook.com (10.13.180.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Sun, 2 Aug 2020 14:35:37 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Sun, 2 Aug 2020 08:35:33 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 4/4] build: add back the Bash EXIT trap to handle cases that ERR doesn't
Date: Sun, 2 Aug 2020 10:35:05 -0400
Message-ID: <20200802143505.88409-5-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: d986e4d3-72cc-4ed1-7971-08d836f152d5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN6PR12MB1332DD2D85424EEC4C71BDAC8B4C0@BN6PR12MB1332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8o0hZce4dq6wHqpcAXGmxH04kQP0wSM5pNeQ7nZVOAWnt69YYBfH5h5cJQa0zHiRNfH+4yMmPcJcht3QtJTj3KehysXpW84e64R2Y0DvfumHZTboXd8RYEArihgGlLtj8efFNVMSSv5FQJb4DgyT0N8sMQWH9UnETkDcipR4OZFo9toPVoZOE/DKHCvdcTheZrlkQSJm9UNgiIe3LcWNZreMTYIdBhVAyrY6gsBKAFcryZ6+oojqb6t5AXPMflar9DwGkfw+Osd4BrtsWDT/UQsezeB101ToNBkuZ1/gjb1rFtotdYdiphaXvcrm4Eq/DI0ZM4bhacsIs79SQMfJSjVlxNmcLV5ThyxXqlQaWlGIfioLgWt1j4i2TxuyJ8pSFFpRyTt+mD45Wk3NTRpxSigfPoqky0+l3TaR+8zbPV3Wcar55GDkZBqwyIXYacvol4OGTkefRNfQNWxGyJmbGw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(396003)(346002)(29502001)(46966005)(6666004)(186003)(6916009)(4326008)(82310400002)(44832011)(5660300002)(47076004)(26005)(478600001)(107886003)(316002)(356005)(36906005)(7636003)(336012)(86362001)(1076003)(36756003)(83380400001)(82740400003)(2906002)(426003)(8936002)(956004)(2616005)(70206006)(8676002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 14:35:37.6576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d986e4d3-72cc-4ed1-7971-08d836f152d5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
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

