Received: from NAM04-BN3-obe.outbound.protection.outlook.com (NAM04-BN3-obe.outbound.protection.outlook.com [40.107.68.54])
 by mx.groups.io with SMTP id smtpd.web12.10078.1596378937528783823
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Aug 2020 07:35:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=gYzz9Xcs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.68.54, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2oT99rB8MQzTgod/VC67/S8hLEuStc6HOr/Kh9XIwD/pSBt4Nq18sgBXoYFoslphB3R9hJNjsR/A8a2NnD4G0g6HRuH3Iok2dcuZS0UJkR1FWctPyWr9dN/5yu8CxuJm1AB6BeJfEhD5q/SbVfAMal9gdQH1pSxH01X0ijCAbb4GozH6YMO/U7EeY+69o4e1dDwHnmR/ToosgUpHOtxcIplFJsZr0XHwhilrrVipiQv31RNMFQmBV1e+I4bSVINXwCp4tjKoDXgyoYMBX+sJkCliJ/kK9Dqw4+4xLy61cyh6IT4twkljcM+bWgF5Tjw4d66bj1dWB6xIPyN5U+SVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPcVSPZgMw9UzlbU9ii4+F0eTYA8nBXGy+vwOT7uFu4=;
 b=Om6zqdBh80ICiHcPhZ3Ea7Mj4zOO6F9Jeq8B9rKmfO3Q6Z/UkqMFGXQZc2p/vGcKof8HOejgHiBfv6doMg+g24Y2jeO2dU3NYSzBwj0k2/H+kbwWdAV96wkwAf6/f88s6O5G3CL0RgV8AnIPABmutjJMDGEb5FnRZlOxMTaj6+TRF7s54q8OMEvUazepcNqT3SoK30Zwsu7RB9sh869Idxk2u+uQDD8NYcRWtqV1ZK+xzcPaBgEQa8LMvMhr3os8CsQkHfIiuJf0QtsB3tr1FE6wNiaHtFsdJncMCsUPjzbmEhKLwoxdc995GgCjflvZahGKox96vmDCcw5SHjyUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPcVSPZgMw9UzlbU9ii4+F0eTYA8nBXGy+vwOT7uFu4=;
 b=gYzz9XcsUJLrMG4M6SL6nn2NV6EzjrqiC5jpLPxM/kdrDeyB3ysKjl+DLVZOZHT41ra5h9sjJx2ccZcqQc9pNe+z31ceWB26ktkRFOIPs2yTPiRNSOitFo5igm9eDizz7lsfzEnHkCKmyJ6a0NmYuWwdJc00MmuADneSvffAREz3zOKau+f8jbxdDRuj5B9Dd8qsU561CiDtT3f8TIkK80IQ6lK/vA/KXykJYmUCqC8m7YtsHCteBxY4HcuBO2jH8DEgz8I2nJcY19dvy5Ol6BQ7pTp/WXrSSRflDyNCj+Clc4wn/l5U4nC6B4KaFjNuCWTMl1NoM1ZVo6boQTUhNA==
Received: from CO2PR04CA0164.namprd04.prod.outlook.com (2603:10b6:104:4::18)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Sun, 2 Aug
 2020 14:35:33 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::46) by CO2PR04CA0164.outlook.office365.com
 (2603:10b6:104:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Sun, 2 Aug 2020 14:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Sun, 2 Aug 2020 14:35:33 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Sun, 2 Aug 2020 08:35:31 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 1/4] data: emit filename/lineno information for shell functions
Date: Sun, 2 Aug 2020 10:35:02 -0400
Message-ID: <20200802143505.88409-2-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95ab8853-1967-4e5b-9ef8-08d836f1503b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CY4PR1201MB01202410F14B76751EF5488D8B4C0@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RtZdN33wNNBowVLFHi4B7gtC4xfHIUDiVz4fwve1iFZ7pEqdLmz8Qh3kccFRVjy2S1xwJE6pC+TOavC+fslejRvj8/RDqysTDAESTNl2AdizgeP16mxhRuMNgDU38//IE9Ej8zuo173G54MJmpjGWS8eoqX2LFnOyJwplL+oUG/zijHlcEPqC+1ujAeeCGgJwr0WroogL7CfD8Tf71JFOPP1mQdZNZMi1YAJ1TU18bnC3gvzf8Pp/3GzifaFTD2NXmWwEiPvW/FG59ny9z/ck98hIpRbYOwJ+Hx5a7LKY4NixrQd6DwsGnZFf+mJiq/gr7kTN8wxqdMfxPppRRqP8YjqbUxPmOBzSPtJDKGi+sa/YPJAGj3kwhDFLieWM9kCPBdFF8oEIX58P0p38jLh89sf9W0DeGJTJksfJSQVKGs=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(29502001)(46966005)(5660300002)(2906002)(186003)(6666004)(86362001)(83380400001)(336012)(36906005)(26005)(316002)(1076003)(2616005)(8676002)(956004)(8936002)(356005)(7636003)(6916009)(4326008)(107886003)(82740400003)(478600001)(36756003)(47076004)(44832011)(82310400002)(426003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 14:35:33.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab8853-1967-4e5b-9ef8-08d836f1503b
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Content-Type: text/plain

Make it easier for users to debug shell task failure by including
some breadcrumbs in the emitted .run file that (hopefully) points
to the .bb/.bbclass file where the shell function was defined.

Unfortunately this won't work with functions with _append
or _prepends, since BitBake wipes the filename/lineno information.
This shouldn't be too hard to fix; for now, you'll just see
comments like this for such functions:

[YOCTO #7877]

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/data.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index b0683c51..97022853 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -161,6 +161,12 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return True
 
     if func:
+        # Write a comment indicating where the shell function came from (line number and filename) to make it easier
+        # for the user to diagnose task failures. This comment is also used by build.py to determine the metadata
+        # location of shell functions.
+        o.write("# line: {0}, file: {1}\n".format(
+            d.getVarFlag(var, "lineno", False),
+            d.getVarFlag(var, "filename", False)))
         # NOTE: should probably check for unbalanced {} within the var
         val = val.rstrip('\n')
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
-- 
2.17.1

