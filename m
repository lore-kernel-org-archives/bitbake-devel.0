Return-Path: <chris.laplante@agilent.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr720088.outbound.protection.outlook.com [40.107.72.88])
	by mail.openembedded.org (Postfix) with ESMTP id 817247F5B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=YUNoEUHbCCAaMkTj9Nz0ZTBdKtuVeDHzAV6jUsvCASBpHbAfp5CYumKs1wIS+rCbH3dmpiB5XJNZssDXhkfV/Tal/qKmqs1OUO3VhoCGwVT+el70+Fz/NpqQwfSKJB1rQGkBjUEy9Wn0yYohTRaFi3WzSW1SK/+bZz39Fy76UiNg8jNXGhxlaiWEvZFXcd9WKxX6nN4VcrCKneh1C6dEo7nDE5TSIuGLP6PY9biRpZEcqzraqoNT4vYrw7Cm88o0p3/RfjB3EcjWSVA49e9qaax2fmIf/32FMQeOCZDlVjpZv7JLKsFso5wbJRSBrfqEyIJZNgm6Cr4Otvv6wGuFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nuUFBA1cAkd6/l2YSr6hTlGVGzqRUNt8tfmm8S+Z+q0=;
	b=QgyOVhaeimhXZ1GL5+D0BbXze5SR00le8TqkvQeIm17cNJQbv2O8ewDPOxbInVzH+/i8mf8jRBYU89QQINGb6RaO6zU/O9j9eq7qqzI+jKUhY0sYA/6UXaAPAteQrjaGD9IBBwBwzvIJEENkKXUdiNjF1z3vSSYKNNwhcXJwXgdkal/2fEqhO3X2g4KlTJA6ROm1/3uPIAF7roe5TrT9UK9kKMNEFhmveb5u9t+zoEfrsfK4EpIQdAGGVHqBMQkpDTOh5wcoFMHJJFqOiuFjB57xN+/6i8L9YXUszee4vBPi7hccK+NrVhA3Y01NKFEjukJ3BLP5mrB627y4B64ZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nuUFBA1cAkd6/l2YSr6hTlGVGzqRUNt8tfmm8S+Z+q0=;
	b=KJXz0znljqe0oeeqjf2lfMSEdz0CiYFfuJrlBbAjhZjikomXj7gqfJ6eKujspHVTymzTqarlG/kvZiRW1tmUOcvk1eDxhxiROSKx/ypl51tK6IaZrYVSK9QWXBVufTqWvXzEPR9JPwaKUbBnn87XTRolICPjC3QAcyXrq8dVWIw=
Received: from BN8PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:60::28)
	by DM5PR1201MB2474.namprd12.prod.outlook.com (2603:10b6:3:e3::8) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:36 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::207) by BN8PR12CA0015.outlook.office365.com
	(2603:10b6:408:60::28) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:35 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:35 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:26 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:08 -0400
Message-ID: <d868fe9c40d20639bf412d3ad29f199fbf105ce4.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(29502001)(189003)(199004)(2351001)(956004)(6666004)(8936002)(54906003)(50226002)(186003)(4326008)(51416003)(16586007)(246002)(356004)(76176011)(5660300002)(336012)(446003)(316002)(11346002)(426003)(36906005)(48376002)(107886003)(36756003)(50466002)(8676002)(2616005)(476003)(118296001)(70206006)(7636002)(86362001)(14444005)(126002)(305945005)(2906002)(44832011)(26005)(6916009)(486006)(478600001)(106002)(47776003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2474;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09027276-d770-40ef-944d-08d74e675dae
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2474B6A62756F5F324985C668B970@DM5PR1201MB2474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtPc7suw4XJaQWkb2LDIzHyHUfohtGZ39vXrL+iGWgE7JkSPiJFMxvr89WW0eFchq1YPhfJpYGoZ0QDSzVsynXcc1ljMTZw6Uq8628+bRBB1BmtqJ4NhJ+58z7r6M0+I/OiYtt/lj1gySRSLfd3qfmBxn7KzlCQ4pDe58B4CRZ4foQ8tcrdBsQHj9aS8rogyExddjxTT5NgG+gRyQZxEFx44qNY0lJ+6jtd5eWGv7l4Leabu7DBrNF8eIDMiV2v5t1/mDKVt01l7+64cMa8Vklwn9cEE3fyg7Z+a/0ZOJscIzNk2NBYgiHNXyP+71W1uJ1enTkWcWvU6Mc6bryj/fgl1hXGCy5n3+E5K+gIdlsAS366TQBTS847nyzmpMOczpG5CLgwKIHSDMTYeJSFUKWsokxKgGmicdG5gPL4Xw3E=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:35.5213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09027276-d770-40ef-944d-08d74e675dae
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
Subject: [PATCH 8/9] bitbake: contrib/vim: handle shell indenting
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:36 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index ed2bd32..0cc516c 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -318,6 +318,18 @@ function BitbakeIndent(lnum)
         return ret
     endif
 
+    " TODO: GetShIndent doesn't detect tasks prepended with 'fakeroot'
+    " Need to submit a patch upstream to Vim to provide an extension point.
+    " Unlike the Python indenter, the Sh indenter is way too large to copy and
+    " modify here.
+    if name == "bbShFuncRegion"
+        return GetShIndent()
+    endif
+
+    " TODO:
+    "   + heuristics for de-denting out of a bbPyDefRegion? e.g. when the user
+    "       types an obvious BB keyword like addhandler or addtask, or starts
+    "       writing a shell task. Maybe too hard to implement...
+
     return -1
-    "return s:pythonIndentExpr()
 endfunction
-- 
2.7.4


