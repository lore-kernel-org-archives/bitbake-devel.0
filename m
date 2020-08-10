Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.54])
 by mx.groups.io with SMTP id smtpd.web12.49104.1597078551709416512
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 09:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=tdQPL1r5;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.76.54, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwoS7P6QncGTXq6M0UW61TOjDNNQEGxS8aeynwOqWfBT7rXGJoJv95y1dXRIQQJU769NqPbGeMYFustHVGUxzZo4J2MwMMxgVwQAyPOKWW4WpyYe+U6BJ0XDY76Z7RnxeoTZ4pSqRoUXEcbfWLiYIgXiBe+rg6ocChbWjjJ7Zc4eltnDdlj8O1FSaoxLPJkoWLt7Zl/HdVPxrXRpTUYxSW+O8qR0Q8UbykwbiVkQWX3pKTIsvFGhduY8EV0wjYDa/94ekVYaOYX8+Z5Mrw0LIGFzGzHXj1WPiycDnSy3uvI8qOAfLB9SM6vLjuI54sFgj/e4DX119kVF0Se3EUQ/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw0eFUgb7f7xmrALx0atLndXG96agZ1vuphXNVxVqlU=;
 b=mYwSAgDNbUcqbxmMytNRAu3A3uC17Ju4OMWjmADJuLe7feaykAKpSap0/79g2Cu07eV0+t7ShzfBGf8DQqO1E529emj2Axe3KBrL75uPgLdLW+QJLikgltBe4rcy06oxMELSzaq7uOSBSklZbAmBoe6rEnE1bRCrfHv0NcNIkZ/SWe0m7eNGzdD0dbb2SIfiupBgnezHDy4dFoGPx8Im5Tk8XTp1paWH+oOOdzBnVnM4djCBfWdFHsqF0nE4cd3VGBevMcrGU0er8U4W72rRtTpgvV1ilqKr8kbi4ie/nh/ky+iixLF1f+LJMe6uqDy13p7LBX8UUQKK59nTQx2zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw0eFUgb7f7xmrALx0atLndXG96agZ1vuphXNVxVqlU=;
 b=tdQPL1r5uwEVS8Wa+80jDmsMKhXjcK7Eq35UeVKkBdtWea1dI7TQ/9w1KMtHMs9aB5ozWgoGSUpB86hcF3HGMfQ4A9Xz+uFA4NwBvoA+McKqaUdo4M9GMqc+yV40llVVJd1JQbOKKKfn4o/3XY3p2rEuSkem01mLdx7d1mH5wciU+dsaCOJhcmin1flJW4x99iwjq7yKy92846dUYxSP1KtPqU3jY+pwffh81+SeMg1x4TKOy5JZ4v3W3AMJlD80gmUGth3JhwnBJAw0PDX8Djt4T4sfemWC1ifC89FguqqYMR+3fLVxtTTg7YiJTnyMJmBx2zRgGXgpN5b8poUgsQ==
Received: from DM6PR07CA0052.namprd07.prod.outlook.com (2603:10b6:5:74::29) by
 MWHPR1201MB2543.namprd12.prod.outlook.com (2603:10b6:300:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 16:55:50 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::13) by DM6PR07CA0052.outlook.office365.com
 (2603:10b6:5:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Mon, 10 Aug 2020 16:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Mon, 10 Aug 2020 16:55:49 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 10 Aug 2020 10:55:46 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v3 4/4] build: fix shell trap syntax errors in dash; ShellCheck warnings
Date: Mon, 10 Aug 2020 12:55:24 -0400
Message-ID: <20200810165524.37417-5-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1a7485e-b873-4c57-539c-08d83d4e3c46
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MWHPR1201MB2543AAA76E8EEA8BD840EED58B440@MWHPR1201MB2543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e90AJ0z1yaw5BJb5ePAW9CKoceHxYroaTCLUzIGfzeXIy20w6Cl7tbXfm9o0QAFO4fydbLErEOh1J2TQg/5gHoq8+WwYEkTK0NWd7nfroVhJG2ZzOdZXv5jcWn0KiNqUHDIAyyNCm9bgMLlmOyiYDNVJDYkMhlllXZOCTRFO56dhXhEmesakyrbdc2HryKhM4kvEYmOS8O9Qgb3E1bwEiq9UJcbD4uXBd4twglFvXaPy75OBKT6HSljJ8hvqp2beXyEP1fdY1oGEt9vtvvspMn+umtLDGgL/fR8rIUauWB71Du/KjGSUZWYMpkZB1pB3GX5vbY7+xGwaqHyvc8Kc22qBHbkVOuUkXv5tGP/N72b6Re5kSgXrEf+wpGy2VgnHylt875PVrv2wICORELnlrjbBi4PXitpiF88Q5YtZJeSnouK89WviZ4ZVJXz6rKjyu3AzgiDts/eb46k9hy8QrrnzGiLBQNMw+swcH3qSDDu5aRNMC7Z3gN5EMzwBh9+H
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(29502001)(46966005)(186003)(5660300002)(83380400001)(36756003)(8936002)(2906002)(26005)(70206006)(86362001)(356005)(336012)(7636003)(82310400002)(1076003)(54906003)(82740400003)(44832011)(2616005)(6666004)(426003)(107886003)(316002)(36906005)(4326008)(956004)(47076004)(478600001)(8676002)(966005)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:55:49.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a7485e-b873-4c57-539c-08d83d4e3c46
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2543
Content-Type: text/plain

---
 lib/bb/build.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index a6b7c5de..060fc568 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -320,14 +320,14 @@ bb_bash_exit_handler() {
         echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
 
         echo "WARNING: Backtrace (BB generated script): "
-        for ((i=1; i<${#FUNCNAME[@]}; i++)); do
-            if [ $i -eq 1 ]; then
+        for i in $(seq 1 $((${#FUNCNAME[@]} - 1))); do
+            if [ "$i" -eq 1 ]; then
                 # TODO: maybe manually track LINENO with a DEBUG trap?
                 # LINENO / BASH_LINENO for the first frame in an EXIT trap is wrong :/
                 # http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-exit-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html
-                echo "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ?"
+                echo -e "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ?"
             else
-                echo "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
+                echo -e "\t#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
             fi
         done
     fi
@@ -339,8 +339,8 @@ bb_bash_err_handler() {
     echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
 
     echo "WARNING: Backtrace (BB generated script): "
-    for ((i=1; i<${#FUNCNAME[@]}; i++)); do
-        echo "\t#$((i-1)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
+    for i in $(seq 1 $((${#FUNCNAME[@]} - 1))); do
+        echo -e "\t#$((i-1)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line ${BASH_LINENO[$((i-1))]}"
     done
 
     trap "" EXIT
-- 
2.17.1

