Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
	by mail.openembedded.org (Postfix) with ESMTP id 802227F523
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=TBgrWzPWWBbSe82oy6TyqNRmySu8t5GAOxQg1+9z25bsZnS/Zic9nMT97eSMZVANYM825pR3RUEBV2mNpUAysG8enV5JpzaS04BjYn8m6eTdkk+hUrPMmAYYWQJuYVvKVm5jpErWRsK5L/ybvh5omdVlR0HJlyoRp+qyJpUCYQ4xmDyindc6G3U0+j/xug0643yvgMjBYXbGWLU533lE5iJ9GBhLJPzf0bvRNm1hhFN4e3AqqDhxsBASJmauL+reqypbI5IvkeHTTU20aqurYbaUj47vbnXcFXeimxdiJjYfx42kf1blefxqo3T063UyR2GK51qldNQPUu6tguMFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=W11UTTfOyaTN3FBLk1LPpBkwSwsbb+G8PlVWbq8S7OU=;
	b=ZwUjA+JcFK5dwYdYodwRwe0mYvisYlm+ijREbCdmmlKmNxmTTwq4/YhwNX1A2usdo/OW66hJ4KXJ0BEGpZVZLHacoiPATKKCGco0JerCyamIZBmf4NXcmcaMvX5Bbw85HwohJz3wCKj0CqUAEX60XdTx/27wSIc4l8j2XJm9IroNjTsC20I9P1bum+BiEVt+5PW9wjT54bZRT/naYEWFiv12/MNgTc3sbrWuoCRX+v8uynmDS/l10UX1Bqig+4fqGyXtctYjmk8e8X//ZN5C6H5mfKWmocclefKS6BXi41iif74a8YU5S1FySX2Rpe4R3TQ734dfB77zwzHMYYsvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=W11UTTfOyaTN3FBLk1LPpBkwSwsbb+G8PlVWbq8S7OU=;
	b=KokSr7SLLMq5w/ScJApTmX7U3pMx4feXqq27qOYPeDiBDaemdUarShekT7UEFJPpqgR2s/farkJcchZyZzrvBD9X8GJBpTCZYmfZfxpMCjmyE1OXtZaC637kzlay72coxVS9DygpF1hx3AC5Fk5MuFJ7aW4D3gWMJD0O2JO0bvM=
Received: from BN6PR1201CA0011.namprd12.prod.outlook.com
	(2603:10b6:405:4c::21) by DM5PR12MB2455.namprd12.prod.outlook.com
	(2603:10b6:4:b7::39) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Thu, 17 Oct 2019 16:37:10 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::204) by BN6PR1201CA0011.outlook.office365.com
	(2603:10b6:405:4c::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:10 +0000
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:10 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:23 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:48 -0400
Message-ID: <460ec91261f500a636d9506e7038834d1399bd0f.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(29502001)(8936002)(107886003)(356004)(316002)(486006)(476003)(48376002)(2906002)(36756003)(6916009)(426003)(956004)(6666004)(11346002)(446003)(4326008)(246002)(2616005)(8676002)(126002)(44832011)(478600001)(50226002)(186003)(118296001)(26005)(336012)(86362001)(47776003)(7636002)(5660300002)(50466002)(54906003)(106002)(16586007)(305945005)(51416003)(76176011)(70206006)(2351001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2455;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg1.windmz.agilent.com,cos.smtp.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37565706-4733-4fb5-81f1-08d7532041eb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24557E0BC98D6BC3486896068B6D0@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq8nET6lloH1jq+BR8ouatSGSRWiap26W/QoVVToQekh86Mg24pEYE0hDBKI20vUI7TkB+kWITWMqOTliFRVUup+yP509SEhtNSGNWsPrZhv0PtD1nELFHoLApX+3AHHenAXU2Z4MAVbXP7H3KqwWfr9mw+rwphaKY/jbw2sdxORIK2awDles4WDzVMiCvZAFKrFyQIoqHKhFomUW6spoWNnU6z6zG27SA92gXBCdx48DuJaTQdAK8FUrCmPuCT8nzLMarXhiWyT1+aIuELDl/MFQLCihV1CbVf0Cvx2aSMiwgzMQLsaNyDZp/REsKuwdsNh0mbRLrz6ymfhLrqR0h7ortKx0heCQBCwETHbqPYqrKbnJ38t/0obtaRcXeEEjfWY/PUdGyCl5i2vjNPY2yw3hf0lquWZKcbHDmBT4vQ=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:10.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37565706-4733-4fb5-81f1-08d7532041eb
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Subject: [PATCH v2 2/9] bitbake: contrib/vim: Modify Python indentation to work with 'python do_task {'
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:10 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/bitbake.vim | 44 +++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/bitbake.vim
index a210cf5..ff86c19 100644
--- a/bitbake/contrib/vim/bitbake.vim
+++ b/bitbake/contrib/vim/bitbake.vim
@@ -79,8 +79,14 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if parlnum > 0
-      let plindent = indent(parlnum)
-      let plnumstart = parlnum
+      if s:is_python_func_def(parlnum)
+        let parlnum = 0
+        let plindent = indent(plnum)
+        let plnumstart = plnum
+      else
+        let plindent = indent(parlnum)
+        let plnumstart = parlnum
+      endif
     else
       let plindent = indent(plnum)
       let plnumstart = plnum
@@ -98,22 +104,26 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if p > 0
-      if p == plnum
-        " When the start is inside parenthesis, only indent one 'shiftwidth'.
-        let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
-            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
-            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
-            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
-            \ searchpair_stopline, searchpair_timeout)
-        if pp > 0
-          return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
+        if s:is_python_func_def(p)
+          let p = 0
+        else
+          if p == plnum
+            " When the start is inside parenthesis, only indent one 'shiftwidth'.
+            let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
+                \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
+                \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
+                \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
+                \ searchpair_stopline, searchpair_timeout)
+            if pp > 0
+              return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
+            endif
+            return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
+          endif
+          if plnumstart == p
+            return indent(plnum)
+          endif
+          return plindent
         endif
-        return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
-      endif
-      if plnumstart == p
-        return indent(plnum)
-      endif
-      return plindent
     endif
 
   endif
-- 
2.7.4


