Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.42])
 by mx.groups.io with SMTP id smtpd.web12.1203.1599670539274495804
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 09:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ynxviYKe;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7h5YjwJxa/KNpfkWJR03Jb5ik6Eox+RBvdf3TtRvnsM4egNAoEmZkRgWre92OYslCw3+S+3PjyoKIn07GKVnY9X/trjrbIiYZXpHgj4AUjDjoymRc4SK2i1KiAHqrVM1f539bqd6PTr7dSA9WG8S90o6QJkIJEoYzXESeQIJgkC0w7/napMjWIgDZS/crHVrU96vCgyTumXqL+fh5N9dhfTDinYfPE78SD8Qv/iHgN5cMkgdP1VJUXmvGtbqu4CO9tVcUsyt0CP4ZlUaBmt1B6MV3UUrfJ6TNtHbwE9zeLTkExKoaBmkL0QKBDE6HyVUhcZUFc/rN0GZvnu0Sv9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6fbR+w1fqXg5sG4gLy5iQUtehfTJMZPORXEIIAXdMg=;
 b=by9wRhHQUCN1io1ydhpaaGjCuj4xKjGgQGn39IreMzdhmuDog/88HZ6MO75xXZx4Fp9cGU6yeQZj0+0M+ltf+7oEhgBm0DZEbM7RJ2wAotmxUs4pqskMBr4IaN6fnpUAAImqprerfuCKnu9Gc29FBHvwOFj71eUN335Hf31Ya0nRK+lB2J5gHISDFAg2UdopZ2JGY22vCDXtoAGpjZvDHSZOoYCsQOL8pDzIaqVyHf2vnNm9AYBx8VGhbTnDAMXcSU/RkLkcG+VPKjpC4+EpBFNsU5hoAsEbdTqGft4FKkfoVkuPpiZrWA3TJijkMBN9hayJQRXV2OxsJNOJPHChpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6fbR+w1fqXg5sG4gLy5iQUtehfTJMZPORXEIIAXdMg=;
 b=ynxviYKe2Qpy7N0gLnAh/jT3x5cRag7gfxRb2PzFoF0Xger5grann8yPBHjmLeFwUjgpNABpihRgvqy1S2bubQMjvAB5wX7yILp5re5CLdwMy+IEvNMSfFUYJJz9fUyEe4dIfzeyFho1PKS4BURbfZDTT/ImRD0h/wG1BXrSW2PhaweeMh03JHBzDBC7MPUB9ERNJazZHvUwABau01stLpkrMY7SgpUrxLbCwSwEaVmkTUartapy3oux2wOA9jVcFtnlUs5lAtBSURO0oARu1e5MpV4wBjsd5bN89RR0kDjYOieiiUCv4cgDZdICZNRHZLjc+H0t9UKGZdZG/ZpHWQ==
Received: from DM5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:3:d4::16) by
 BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 16:55:37 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::a1) by DM5PR05CA0006.outlook.office365.com
 (2603:10b6:3:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend
 Transport; Wed, 9 Sep 2020 16:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Wed, 9 Sep 2020 16:55:37 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.2044.4; Wed, 9 Sep 2020 10:55:35 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] utils: process_profilelog: use context manager
Date: Wed, 9 Sep 2020 12:55:30 -0400
Message-ID: <20200909165530.110906-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1fbd4fb-b91e-4a1d-2c6a-08d854e12d3c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR12MB4003A4C10DDA6D45B1BCD54F8B260@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gjop2U2fSbT/dEsUM12+1H3nV8dkXz1h51AiomEPhiiVusZjSoBVODOjXDJQSeJiyxOtPtS6kaFVuRumNVvZrGylM4qlxEEVH8om+ZdLt8jfuBwP3h3mOaHB2qI6UC4yDKCxmWDZT6drUXEPG1sAe3wiygkB5LKSzsd7Ap+Sf/byEfN5uK//fyjrZhLj4ax+SCrtJfmQyHQ3DHSTLnNVHvoD7AJgJA9cuYzYtouaP261A1j+x9ViZscjngtC2Q4i/D6ybr71AR9W045FoiA/XRErBB+iQGxQ4pvHR0JWCKDCP2lXng85niuA2h0NSG5lyclUBnpylA5dVuMKZaKHYSv+oGPMjlezDiyry1RJXgJXHiX00XJ+xHsOVpwP36q7SDDb87067eC7PvbJ1EmO8+JF3Tk39jeQhdQ4UZsIkjg=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(29502001)(46966005)(82310400003)(478600001)(426003)(316002)(107886003)(36906005)(83380400001)(70206006)(26005)(44832011)(1076003)(6666004)(186003)(2906002)(86362001)(956004)(82740400003)(2616005)(5660300002)(356005)(7636003)(47076004)(36756003)(8676002)(4326008)(6916009)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:55:37.4968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fbd4fb-b91e-4a1d-2c6a-08d854e12d3c
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/utils.py | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e51b8ca5..2d4b258b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1071,21 +1071,20 @@ def process_profilelog(fn, pout = None):
     # Either call with a list of filenames and set pout or a filename and optionally pout.
     if not pout:
         pout = fn + '.processed'
-    pout = open(pout, 'w')
-   
-    import pstats
-    if isinstance(fn, list):
-        p = pstats.Stats(*fn, stream=pout)
-    else:
-        p = pstats.Stats(fn, stream=pout)
-    p.sort_stats('time')
-    p.print_stats()
-    p.print_callers()
-    p.sort_stats('cumulative')
-    p.print_stats()
-
-    pout.flush()
-    pout.close()  
+
+    with open(pout, 'w') as pout:
+        import pstats
+        if isinstance(fn, list):
+            p = pstats.Stats(*fn, stream=pout)
+        else:
+            p = pstats.Stats(fn, stream=pout)
+        p.sort_stats('time')
+        p.print_stats()
+        p.print_callers()
+        p.sort_stats('cumulative')
+        p.print_stats()
+
+        pout.flush()
 
 #
 # Was present to work around multiprocessing pool bugs in python < 2.7.3
-- 
2.17.1

