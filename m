Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810087.outbound.protection.outlook.com [40.107.81.87])
	by mail.openembedded.org (Postfix) with ESMTP id 148777F5B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=SHlWpy/KSvAMmKQFGsRzvFnCOVbNWWMhliTA5RaLUZ9LHzaxxQCLRCLrV5DxBlASwp/vTCGOk+p7F4M/goIDN4qzXa27xPJr3u3jRJmuAneQ7QOPbH7586dCOYih6+0F6VBGY1PX1oDBaAAuGZZg9DaxJ6/Zj/dKkXRgboe4ETUbVfjiZuAhV6PZkd/eIhO8yNxkXBCBNL5531Gq+1KWG/b4K5Xs8Zq+LLyd+ScsvSunU/oScgst3F6RlFjjW9LR6at1R3P3qNw6tQWCcvzM9oBfQxIC+b+931RsBKhrU84LkihSOhXmmK/psUNjDWTJowmXhautyGUygqLG7uuI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=44ABxfWvpa+mUpKhYrScSF+Dol5nwmFhcvDEi2o9BRc=;
	b=lGEVg/55bvRXBcHxfKDaJZG1k5ezahH9RSp506p6Lh2zuZgM8ZNy/5cWxb+96aIBep531eBD49gEgc6wkbkCFED+pAyrhj5kPm6v8Z6kyUl/tbJPT3h+1Yk8zrTm46wXDUiSXhoeatMN7ppVo5G7K09HMZWYh4zOtJSFjLp/wnHxcAF8IxMupaVBGFWvLMkGlpkJIT+W7YDsh5R2o+8qNv5Wfs45lKQYezSaNoVKUKArsqQI7U0/K0sOjq8oPIAEZIYgSvDmCsfceyxFkpjnn/mx3K4K67HOdyx7lezVhmpFydXPoQgdrb7Y5Zs55pCCtDJ7qeXENVSkJKame9H3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=44ABxfWvpa+mUpKhYrScSF+Dol5nwmFhcvDEi2o9BRc=;
	b=AxgII4eLPSbDADDiDCsu85njREAvOesHetqfoqp29/8fuc/UyrMAnoepIF+1WCPCecuTM2L5MezwfwtEYYfJrI7Wl42EBdn+TIbnVh6S8Mq3jXtgJvUdFBit+9xba4wv73l3gfoFs7geTfkzUT2RDIgYr2i/0jgvJBAJ95+AuBs=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
	by MWHPR1201MB0125.namprd12.prod.outlook.com (2603:10b6:301:55::12)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:37 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by BN8PR12CA0028.outlook.office365.com
	(2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:36 +0000
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
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:36 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:26 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:09 -0400
Message-ID: <a0fa9bd5b2cec57b0d3c11a8a344a171bb9f3fe7.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(29502001)(5660300002)(44832011)(26005)(107886003)(76176011)(4326008)(51416003)(70206006)(186003)(8936002)(6916009)(7636002)(50226002)(4744005)(246002)(305945005)(8676002)(6666004)(356004)(86362001)(118296001)(126002)(47776003)(476003)(50466002)(2906002)(478600001)(426003)(446003)(486006)(54906003)(2616005)(956004)(11346002)(16586007)(2351001)(106002)(36756003)(48376002)(316002)(36906005)(336012)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0125;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aa2509e-5522-4ee0-b475-08d74e675e4d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0125D6B413CCCEE91F71E7DE8B970@MWHPR1201MB0125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GpsRGJ1KUUpZFR4F4N4su0omrQeI215+9b2Xpy/Qr4h91HEvKLRgsGOIp0FHvZh6Pb2l36q20M+Qgfcg0Pkuo7lHkT/lvsy1UkFO1ZZONu++iDCI1QOyjephtOaWPFrMNgB08mbP59AdKXU/aFoiNTLgOWJcOCrJ5rSZKG/MsJgk/+zkK503lmf7GZltobcUWX5asz3FP1Da2Sdo3lzq2CbLSdMlJJfz5/hDEvJNMmp851bGbeJJA9s7z9EsloxbRf4KYUrKtbyZ/I2vwyheMAmuAwHgw8rWioWs5kkIhhvO+LKJ0zSS4c+2Q/DMpFeS7GeaachWdW0uT/WhKJi/ddVcUUlgBrGQXRK23ZyZ5v+i3Y5+qeRWI0nDQrON6QrGpTEw22LUOHYIpRhnw5yM9b+Z6cEIYxNXGi+ogjRP60=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:36.4191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa2509e-5522-4ee0-b475-08d74e675e4d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
Subject: [PATCH 9/9] bitbake: contrib/vim: Add copyright and license notice
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:38 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 0cc516c..44e3cd0 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -1,3 +1,10 @@
+" Vim indent file
+" Language:             BitBake
+" Copyright:            Copyright (C) 2019 Agilent Technologies, Inc.
+" Maintainer:           Chris Laplante <chris.laplante@agilent.com>
+" License:              You may redistribute this under the same terms as Vim itself
+
+
 if exists("b:did_indent")
     finish
 endif
-- 
2.7.4


