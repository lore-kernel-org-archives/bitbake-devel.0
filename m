Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740042.outbound.protection.outlook.com [40.107.74.42])
	by mail.openembedded.org (Postfix) with ESMTP id 381477F63C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=U7ZT6qGCh6jsJ9+aKPmqdhOs5G62ErwUb/ZJ2ox+r5aGCWhQA6mTsqxmbeHZKeXcjaHegBHnBydhsAK5T7gvRwLdd6hQni76vrw1ZiLwZupHdK0iuAi4gardIGoIXqP6L5sXwXgjYmBwanVhz7vsLXqBbobyX+GP+HEZyT2sjRdRoOCBG8pgTwTQMSD1xfK4PlOKCyL3CkNnf+OYfghCKxjf50Wb/SlQxZ4uWHzeJK3hPgGoHpWwmHdVr3V2LAKU6wz66gGdWakX5eaM84ADTx57V11MLZ6vuCMQa5Dgods3OYsAZIh+ll3Ti1JuvvswbjkBE7xhR74F04ydFW5+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iNNDVr+dfnOp6/tbyH7PyHFTz43LoGEOqvH7lLys/mM=;
	b=M5wcH32eyll4K/guKFFMVYsSTAPaHstj4xJL8AzcW7a+umJi/up408Bn8V07sYM6YKTpgw2xqhCkC3hfusGUidKP66LPvawliP5bj7BFZrhuKnURNiukD9I3FPCqiR8/Xj6jYK5Zm3n+l0y0Im4IUz27CUvrhr3M7/XBNlaV0YDgX3iJs5oPq0NokKMOhScKCaWNKlGQkoKiBsY/KShcCbPhCluenBd2VZxqk+R6NZBaXEVW6FiohI+kWCKVu6t7ZchecZK0qYkkptwZqEzk2QWCGRiDnw7nMmX2yS3PLDBI2FRPCkTcMSsci9hjGv/PVDHSR1d73joUjXqFQjTRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iNNDVr+dfnOp6/tbyH7PyHFTz43LoGEOqvH7lLys/mM=;
	b=Mfb/kHYCJpdoZw7u3RcqQkb749qE+zzvOvQG7jwFKHtcsETPVN669DBM+V7dpRLp5Y+TYCGAx1LCrvHz9L3Sot98ug8y1HScZc7uPNQoDiH/ufMP3oGgSP/HI1/BSZd/6D7Y8gAfCRDNoWvNSWsb46O3Ol7wJLEX3IX312VUHBw=
Received: from BN6PR1201CA0010.namprd12.prod.outlook.com
	(2603:10b6:405:4c::20) by MW2PR12MB2523.namprd12.prod.outlook.com
	(2603:10b6:907:9::26) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21;
	Thu, 17 Oct 2019 16:37:11 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::204) by BN6PR1201CA0010.outlook.office365.com
	(2603:10b6:405:4c::20) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:11 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:11 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:24 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:49 -0400
Message-ID: <1b3b8e71ebb55ff80238387fc9b1ddf3908dab9c.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(29502001)(956004)(26005)(4326008)(186003)(48376002)(6916009)(36756003)(51416003)(118296001)(76176011)(478600001)(8936002)(11346002)(446003)(476003)(426003)(2616005)(126002)(70206006)(2351001)(486006)(336012)(8676002)(50226002)(54906003)(14444005)(16586007)(246002)(107886003)(316002)(47776003)(305945005)(2906002)(7636002)(5660300002)(50466002)(6666004)(44832011)(356004)(86362001)(106002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2523;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg1.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad713b6-cf7c-4b57-f073-08d753204257
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25231A2B13457DEFE964A6058B6D0@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnlcN7AiM5VlcTf4x46sEs7rvGGK8kWa1yrOlLvKLonxORJ0cNRJXNNIYPhgdm8uOCADuoUMZ7R/MSuso63pqLpQcHRQLtHH74FespPXQmjaMNNIY/0UlP6RV290+tUJRDei1EJ3NZlOip0JMoI6OR41bv9dCoghiEgAV56OAGuw4K0aET2u+ybCItfPB0r3VFdMHLtCHL/y3ALVJlYRBXh8TQq9Vsq7rfIst8mSTLmOXdt9pLTUvXDt1jPmkfBnngiIPNEkghb0V9p8iz+fIeWENOXOdKJ2w98evlEj8PgO7UA0YQm91orEPn4a86aUUWl20Fw53D2eDskhbc99MhO0HV5h3nvcxsevEFatzXw1H75vVaPN5qubF5DN/P714GpHarIkBtccPrEWzdtzaGnD/7viNrD9ZjAJFAGrloc=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:11.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad713b6-cf7c-4b57-f073-08d753204257
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
Subject: [PATCH v2 3/9] bitbake: contrib/vim: More Python indenting; move indent file to correct directory
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:12 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/{ => indent}/bitbake.vim | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 rename bitbake/contrib/vim/{ => indent}/bitbake.vim (91%)

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
similarity index 91%
rename from bitbake/contrib/vim/bitbake.vim
rename to bitbake/contrib/vim/indent/bitbake.vim
index ff86c19..1c35cb3 100644
--- a/bitbake/contrib/vim/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -79,6 +79,8 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if parlnum > 0
+      " We may have found the opening brace of a BitBake Python task, e.g. 'python do_task {'
+      " If so, ignore it here - it will be handled later.
       if s:is_python_func_def(parlnum)
         let parlnum = 0
         let plindent = indent(plnum)
@@ -105,6 +107,13 @@ function GetPythonIndent(lnum)
             \ searchpair_stopline, searchpair_timeout)
     if p > 0
         if s:is_python_func_def(p)
+          " Handle the user actually trying to close a BitBake Python task
+          let line = getline(a:lnum)
+          if line =~ '^\s*}'
+              return -2
+          endif
+
+          " Otherwise ignore the brace
           let p = 0
         else
           if p == plnum
@@ -231,15 +240,27 @@ let b:did_indent = 1
 
 
 function BitbakeIndent(lnum)
+    if !has('syntax_items')
+        return -1
+    endif
+
     let stack = synstack(a:lnum, col("."))
     if len(stack) == 0
         return -1
     endif
 
     let name = synIDattr(stack[0], "name")
+    "echo name
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
         let ret = GetPythonIndent(a:lnum)
+        " Should always be indented by at least one shiftwidth; but allow
+        " return of -1 (defer to autoindent) or -2 (force indent to 0)
+        if ret == 0
+            return shiftwidth()
+        elseif ret == -2
+            return 0
+        endif
         return ret
     endif
 
-- 
2.7.4


