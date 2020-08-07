Received: from NAM04-BN3-obe.outbound.protection.outlook.com (NAM04-BN3-obe.outbound.protection.outlook.com [40.107.68.58])
 by mx.groups.io with SMTP id smtpd.web11.7168.1596810255174711858
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 07:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=gqUF1vxC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.68.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJV7J5UGGqMmHoPCv080JdaSfr5Y/wqjg29vZGEoK3MvySseTdZtwKimeU149yrtf9augY3jfowvRJJhwJpt/y1LkIS3+onhYEBq8ci+0EuvDR0KqNeUO7Wr5B1nVg9yv4adMz+6QM1v82ueGoYteuCqmY/7fDVlUhwisNFioJWBo81L18yyIW/JrKsZyjGBuhw4IglADD7M2qK5Fm9r6B0QWgOiftaPMeWy/ovM7tOo0M/sAftPbMJkRgXel6lrUBQR1/7znfe75ZDNtb1/85DRITcSXmu6f+xDE+bP6s4ja14ZG1is78X9QT7U+jokTvjAx8wKfXNYBkkNqCJRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b+ihZXsiFJ+ZVshtgdMsYAujwhtU3k2+TVTl3MKXTM=;
 b=lYlvKB96TRXxmKTmefDn4/d7HJCt7yUC6PaWVjtYg/t0v9kPGsUKrjuMXl0K9aeL3hUfGrhDCySmFYIJ8NGeVl2Xl8Q4AJBIFWxWSFQGfa+7j6wTpRL9NKrRbodYo4t+UiNIf6dB4YXeLhrnWW/HPqUYdpc9/atDnL6+Vi1nmiyaUx0juN1QpEVJ8g3TM1qmKwDrHU1stc9taKzN9oZ1o3UCMRDyqSrHJApUy4/p6q/h4LrI8fqFn+wsO6OIUjUpy6UQqxUKnAI1SUOe6vSFX31QDSgpNhw8IutPNVmljn+W9pXHuyziBqM228qKqxrjENyTfIWoc9ahGJAIIqPulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b+ihZXsiFJ+ZVshtgdMsYAujwhtU3k2+TVTl3MKXTM=;
 b=gqUF1vxCct3iX4vKBl1DWM+aeWnE39zp+Y6SMTw+KkAgLfD9aM9VPegfHKWDJejV01LYGkO5vCdl4fqPsyAhVSyWnOf4ETDeCR3pI51lRQRr37lQm5vVM/tcKjqT9qyQhNojFgvQJcNPFQIHUCMFSbhX5YGuyDz6cT+3hxVXa1ost6ldIlhTnZHbDNSKz3v+Zugp8QJ/1DqwRkxZSG7ZFP0TU/Hj6TlSVlOnfBBBF9wEitZzHNivkGjKlh+mPONE693UwXUaQ1UkBAkDuQGWpSNsACdINnr5kHJR2d6xAdPAmuVGrRmfL3UJntdnZ3NeZNkPAgvdJ7wpKEu4bMHkKg==
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 7 Aug
 2020 14:24:12 +0000
Received: from DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::e) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.7 via Frontend
 Transport; Fri, 7 Aug 2020 14:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT065.mail.protection.outlook.com (10.13.179.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 14:24:11 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 7 Aug 2020 08:24:00 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH 3/3] WIP
Date: Fri, 7 Aug 2020 10:23:43 -0400
Message-ID: <20200807142343.8648-4-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 575f1543-c9fa-450f-e377-08d83add8e05
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB2869AE3E7C7AABBE913268748B490@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dE7aZBmorPEWZ/y2nwYHfjfeydQWGltY+07UuOkrdEK6A9Uudhb+5IPH587cvUJlg05HR30x1g2gY2zQcf++vFU36og/xI9JezNg2OVBRX4Yd1xjYquymZ3q/wO0v5pU9xc0YB1g5XvhCAWD8ENEiRT1ciqjff1vm8zq/o/j6NS1wHHXg6JhHB5E3cEuOO5Qh9Sh4Q3pV8AHkQ0oN7brLCsgRJByLIV3wGv7QzDCt7qjH0JYi0AahdBn+8KL4gih/Ji81u3y0+OZDtRKWP4YAjilvMagkKeoIC74aWJsDgwJj0hEfvs9LoVdmC+2ddrJ/7Wxe831OpdEj3ZmQouMeY5OQ1ScaUKCQLJCxCgEErb3FxdiXvns0+EnHcyEJ4znesTISrd8Bi2HVimASkVIOOTNEDFXKFH0D4gHpQ7ScF0=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(346002)(376002)(29502001)(46966005)(54906003)(426003)(1076003)(478600001)(356005)(8676002)(70206006)(82740400003)(47076004)(186003)(44832011)(316002)(7636003)(36756003)(8936002)(336012)(4326008)(2616005)(6666004)(36906005)(82310400002)(2906002)(86362001)(5660300002)(83380400001)(26005)(956004)(107886003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:24:11.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575f1543-c9fa-450f-e377-08d83add8e05
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
Content-Type: text/plain

---
 lib/bb/build.py | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index bbea20c6..c424519d 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -315,24 +315,30 @@ bb_sh_exit_handler() {
 bb_bash_err_handler() {
     ret=$?
     echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'"
-
-    # Determine the line on which the failing shell function is declared
-    shopt -s extdebug
-    function_line=$(declare -F "${FUNCNAME[1]}" | awk '{print $2}')
-    shopt -u extdebug
-
-    # Grab the special comment that precedes the function declaration - this comment contains the filename and lineno
-    # that BitBake tracked as being the original location for the emitted shell function.
-    prev_line=$((function_line - 1))
-    function_location=$(sed "${prev_line}q;d" "${BASH_SOURCE[0]}")
-    pattern='# line: ([[:digit:]]+), file: (.+)'
-    if [[ $function_location =~ $pattern ]]; then
-        relative_line=$((BASH_LINENO[0] - function_line))
-        # TODO: handle 'autogenerated' (e.g. from _append) by walking up the call chain to the nearest real file?
-        # TODO: actually just fix BitBake to include filename/lineno information when _append is encountered, maybe as
-        #       separate varflags.
-        echo "INFO: ${BASH_REMATCH[2]}:$((BASH_REMATCH[1] + relative_line)) is where original shell function '${FUNCNAME[1]}' is declared"
-    fi
+    
+    frame=1
+    while [ $frame -lt 6 ]; do
+        # Determine the line on which the failing shell function is declared
+        shopt -s extdebug
+        function_line=$(declare -F "${FUNCNAME[$frame]}" | awk '{print $2}')
+        echo ${FUNCNAME[$frame]}
+        shopt -u extdebug
+        frame=$((frame + 1))
+        continue
+    
+        # Grab the special comment that precedes the function declaration - this comment contains the filename and lineno
+        # that BitBake tracked as being the original location for the emitted shell function.
+        prev_line=$((function_line - 1))
+        function_location=$(sed "${prev_line}q;d" "${BASH_SOURCE[0]}")
+        pattern='# line: ([[:digit:]]+), file: (.+)'
+        if [[ $function_location =~ $pattern ]]; then
+            relative_line=$((BASH_LINENO[0] - function_line))
+            # TODO: handle 'autogenerated' (e.g. from _append) by walking up the call chain to the nearest real file?
+            # TODO: actually just fix BitBake to include filename/lineno information when _append is encountered, maybe as
+            #       separate varflags.
+            echo "INFO: ${BASH_REMATCH[2]}:$((BASH_REMATCH[1] + relative_line)) is where original shell function '${FUNCNAME[1]}' is declared"
+        fi
+    done
 
     exit $ret
 }
-- 
2.17.1

