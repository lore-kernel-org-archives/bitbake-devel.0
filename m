Return-Path: <chris.laplante@agilent.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
	(mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by mail.openembedded.org (Postfix) with ESMTP id 4D2D27FBCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 19:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=YWlJgVvLH7QulyzK+HjqQHI8MNXCabmwzLCPMbNHUKlcWxMFMyskScFVREzfwbeFVg6mJaeUTF72r8M5CIPns4eLRTittiJkXmbNsXolB5nc3u3Bn4HRsfnNv+y26p1hYt+rwUm3d+q97fXvDo/aKz476++gE5ltC8hXedEn/Nj6zRR6GSKMF9U1DJ8xvO0u48BgocMYOya4+l6frRRSnQ8sjh0Y3GBh7ctJAjEE+CCXdFQFMwyj5cYzGxFJGDCsyRJg5oLL3KggOiUCSs9v8mX8z2cu7rHJq8koNokk8jLZTvK2nhb/Zsd/TYEe+uGUx+d3m1WqTejocjqhyPxH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kiWADKvavB1U1awAB2TXVEyvEJd0uG26CoN8NAr6DPU=;
	b=CoAZp9/ZOlk+AnuLXXAMhdmqcagBBbGR1o5yYabZR6IXPSgaL5YQt8fHxW5K8vmrm6wMbk7c92AZnWBTxDNmsSWHSChOAdaLPVMcQEMx/sXByui/6lJTSa29zCffX2rviuZHFSrY6bSWkw82t5/piM26/njGblOluv4pRrdcYI2zVurjrTkJAn46Khtn7ih4RE9dbbvF1YruT4iXJ2DpimIlj3Fk1cIEIn7RcQjbCF7STgwTE7Lvq6A5JIJ1FFOi6cL8HhRHWdObFCgW0cyPtmg1PsHmaCDg7NuDGgbNGD/nzdqPaAQLGX8hNsTq8T/6cqlap08Rco8eR8JQTE/8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kiWADKvavB1U1awAB2TXVEyvEJd0uG26CoN8NAr6DPU=;
	b=KqzUnY+/vv0CKEkBi843HUwPVcbJ1MrJJnPT8SBYsXV956g10Y6VrBr4Dt27J6cFKvHylfFfrghK2LxSiVsfsnRY6t5yj3XVCMYoT1WibfD72IFS1YG6QDIcbxnjHo3VQV1NHRl32/E6kXgL/W10erMuiXElK7f2iI6wpnx1PkQ=
Received: from SN1PR12CA0094.namprd12.prod.outlook.com (2603:10b6:802:21::29)
	by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18;
	Fri, 17 Jan 2020 19:40:15 +0000
Received: from BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::207) by SN1PR12CA0094.outlook.office365.com
	(2603:10b6:802:21::29) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via
	Frontend Transport; Fri, 17 Jan 2020 19:40:15 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BN8NAM12FT027.mail.protection.outlook.com (10.13.182.138) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2665.6 via Frontend Transport; Fri, 17 Jan 2020 19:40:14 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 17 Jan 2020 12:40:06 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 17 Jan 2020 14:39:55 -0500
Message-ID: <1579289995-70510-2-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579289995-70510-1-git-send-email-chris.laplante@agilent.com>
References: <1579289995-70510-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(29502001)(246002)(2906002)(5660300002)(6666004)(107886003)(356004)(4326008)(8936002)(8676002)(478600001)(70206006)(186003)(86362001)(36756003)(26005)(956004)(2616005)(6916009)(44832011)(336012)(36906005)(316002)(7636002)(426003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4279;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8fa511-f8e7-4d65-699c-08d79b851324
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42797C02E626ABA31A71520E8B310@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0285201563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hn0zLiAzpmetsqjOYURRN2rMWYYjzzffFvTdglzWXXhduoQaI49Fcp3dklTPxMWYBYcogHjvMp/N90ieiFqL5+QKlMBkzbeiFwvWHDPEjwTdtgN2iZTHl3GXgZAj/VKI8kWsPBxZug9eHy86J58VfEUWdrCp9OowNSTuT+m9fFtsVsH/YAuheGxPO7Uqs2IUMdOSS4U01l1T9EcmvP+rDjAzXcnFKY9zvGIknp+8YljUVHdbSdGHOrJFSmoQABnWZmhMfoYUhmn2/FUKgHrciFPFJ4y/1WYeab0LUkM9/7DqEbAidBR1DDJNJfPn9udL8v3BzbxT9xAUFfwAHtXjRGTY5S2q56xsfPLs9y1WwguXyfO4gZ1CEda4XTbwZXz6/lhDhr6yogfimGD9QwdpJtI6cDkHCk3w1rKfDxqAqE6tfoTS9Fh0FoqstuOPi6h12IH9ImcGrt268hilDzSu+3ceyjauv+WXUknhQL/F3p+XefEageANjSnFpQfa2AS
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 19:40:14.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8fa511-f8e7-4d65-699c-08d79b851324
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
Subject: [PATCH 2/2] tests/utils: add tests for bb.utils.get_referenced_vars
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 17 Jan 2020 19:40:16 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/tests/utils.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 5c910b4..a7ff33d 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -622,3 +622,47 @@ BBLAYERS += "/home/user/otherpath/layer6"
                                  ['/home/user/otherpath/layer6', '/home/user/path/layer3'], ['/home/user/path/layer1', '/home/user/path/layer4', '/home/user/path/layer7'],
                                  ['/home/user/path/layer3'],
                                  ['/home/user/path/layer7'])
+
+
+class GetReferencedVars(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+
+    def check_referenced(self, expression, expected_layers):
+        vars = bb.utils.get_referenced_vars(expression, self.d)
+
+        # Do the easy check first - is every variable accounted for?
+        expected_vars = set.union(set(), *expected_layers)
+        got_vars = set(vars)
+        self.assertSetEqual(got_vars, expected_vars)
+
+        # Now test the order of the layers
+        start = 0
+        for i, expected_layer in enumerate(expected_layers):
+            got_layer = set(vars[start:len(expected_layer)+start])
+            start += len(expected_layer)
+            self.assertSetEqual(got_layer, expected_layer)
+
+    def test_no_vars(self):
+        self.check_referenced("", [])
+        self.check_referenced(" ", [])
+        self.check_referenced(" no vars here! ", [])
+
+    def test_single_layer(self):
+        self.check_referenced("${VAR}", [{"VAR"}])
+        self.check_referenced("${VAR} ${VAR}", [{"VAR"}])
+
+    def test_two_layer(self):
+        self.d.setVar("VAR", "${B}")
+        self.check_referenced("${VAR}", [{"VAR"}, {"B"}])
+        self.check_referenced("${@d.getVar('VAR')}", [{"VAR"}, {"B"}])
+
+    def test_more_complicated(self):
+        self.d["SRC_URI"] = "${QT_GIT}/${QT_MODULE}.git;name=${QT_MODULE};${QT_MODULE_BRANCH_PARAM};protocol=${QT_GIT_PROTOCOL}"
+        self.d["QT_GIT"] = "git://code.qt.io/${QT_GIT_PROJECT}"
+        self.d["QT_MODULE_BRANCH_PARAM"] = "branch=${QT_MODULE_BRANCH}"
+        self.d["QT_MODULE"] = "${BPN}"
+        self.d["BPN"] = "something to do with ${PN} and ${SPECIAL_PKGSUFFIX}"
+
+        layers = [{"SRC_URI"}, {"QT_GIT", "QT_MODULE", "QT_MODULE_BRANCH_PARAM", "QT_GIT_PROTOCOL"}, {"QT_GIT_PROJECT", "QT_MODULE_BRANCH", "BPN"}, {"PN", "SPECIAL_PKGSUFFIX"}]
+        self.check_referenced("${SRC_URI}", layers)
-- 
2.7.4


