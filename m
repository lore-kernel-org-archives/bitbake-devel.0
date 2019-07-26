Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr780048.outbound.protection.outlook.com [40.107.78.48])
	by mail.openembedded.org (Postfix) with ESMTP id D63757EE86
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 17:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=jqRC42PjMPDQZAVcAW9yBzgPApIeBO13ma2X/EeqbjIzHOAZPlmrzEOq9zgz+BTZ1Wtut7aiXNAcyLiO3kbjKCBWc9ZEHBvvmdALGd/acR8m2UqolsE4LUhgu5nM9Ao5ByhGBjLYrSs+tc8v/u5VDmXqga2GaLhl8Rk42csF03e+7wjtgaicR45ne/woIA8VnH38W2G/EUlZmI5AkkWqder3k+DoVLVNZL+Yrb65uOeI1//flczYn7WkLb+d4cs0fCijsRkzhMdpz/djb+j7ThkuZn5nfZTWAxLjFWYlFByAkgVQDTkq4DzNvtKt8R6CDOmnfe7+2kmpCeJ0HOB2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ltg4UYl6AtlDmoDD6+PDrwsLUAPGLw2oPAoxZigBLNE=;
	b=M5QOrnCWq0lY79Mor1ygOxLHAriZW31BAawPaMbLMWmyre/QEyhtvptkkKveTQGpScFcalQZzXvIUOFDF3R3nVbv/rPRsscgpqzsc9g2S3lr+sGAh2/RMDBAgINdCjsymItXFp9TgvLhTuCssSxe0dCs5sX/uOmMa1pnJMakz87rSb20aUcSJVKYI9EFSA3GHgbVq5gdzXxqkgtkkZFIid5ZwE7w826dR6vdZF2gYzhHf2B+3HASYzkNvn5lycQ3xlrzFYuj2pxKSgnfl+PXanBJFs9IgTr4/Wl4R12WOLxoksR8Kc6hkOPr2AqrIxBGwTjiDIr/FMI1VGq+yUpMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ltg4UYl6AtlDmoDD6+PDrwsLUAPGLw2oPAoxZigBLNE=;
	b=UFVr4lspZsB+q+mbp22PXK0gNba2CwxE29bl9V7Ws30y9iD/vJn8FtfemN7pJ0yPv8XPxlacgPX1ITpaXEjaXq5CeKSLUPqmzv+MPkj59oAzdpnkSpFY4vXq94laTk37mUTkngmurM1B31JfX5DQT48knV41LCiZkT/R2ki0wL0=
Received: from CY4PR12CA0047.namprd12.prod.outlook.com (2603:10b6:903:129::33)
	by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17;
	Fri, 26 Jul 2019 17:19:31 +0000
Received: from CO1NAM05FT037.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by CY4PR12CA0047.outlook.office365.com
	(2603:10b6:903:129::33) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.16 via
	Frontend Transport; Fri, 26 Jul 2019 17:19:30 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	CO1NAM05FT037.mail.protection.outlook.com (10.152.96.150) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.2136.7 via Frontend Transport; Fri, 26 Jul 2019 17:19:30 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 26 Jul 2019 11:19:28 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Jul 2019 13:18:37 -0400
Message-ID: <1564161517-28530-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(199004)(189003)(29502001)(186003)(4326008)(6666004)(36756003)(14444005)(476003)(51416003)(7636002)(50226002)(36906005)(106002)(8936002)(8676002)(47776003)(50466002)(305945005)(316002)(486006)(426003)(246002)(44832011)(2351001)(16586007)(48376002)(356004)(2616005)(26005)(336012)(126002)(6916009)(478600001)(49486002)(5660300002)(70206006)(107886003)(956004)(86362001)(2906002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1661;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d917e13-21c7-4bcd-e7e2-08d711ed6b80
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:MWHPR12MB1661; 
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16614E6AAFBC21A93CFAE74F8BC00@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01106E96F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8G7SBVrLEDkwOfvwqoTl189U0FFyaLSCjCntS79Nujbpb7Xq1R7lGo1VgDgsZSkpNKjnXigVbXzPWdHMW8ZoNTizJ4+CeKVb8NM7dg92LGCWl/Joq+14nBYwDCrRj0DPqptnxXP+Yezbi+OtrDy5lzUjUIgbQnlD5Rsjy5PLxc30gJCYPMhu4xn5VKmNnZIbkuj6tZVAC3lq0IgbM+kJCmQio0nooRcY8uXtXG//bhmrJOA76MnQ9w139vI75wu9BYtCB+CMAMFhlSa8+O6n2PCWl3gzyhjry0pMjNdT7Sb+vXpQZHdckc8WtZJ1N03suwtIA2LxQFm0SMM3Fn8lE4IjNshtoueoI6nqgqwBIRo9W9YwvlohkYf4vnx8siUx53jvRnDmresndSfpXrqZadhbcE02mcQxhkpPE20QweU=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 17:19:30.3474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d917e13-21c7-4bcd-e7e2-08d711ed6b80
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
Subject: [PATCH] fetch2/wget: avoid 'maximum recursion depth' RuntimeErrors when handling 403 codes
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
X-List-Received-Date: Fri, 26 Jul 2019 17:19:32 -0000
Content-Type: text/plain

The code says that some servers respond with 403 codes when they really
mean 405 codes. But we still need to account for legitimate 403 codes.

Before this change, I noticed that sstate mirror checking was taking a
very long time when I purposely entered incorrect credentials into my
.netrc file for our sstate mirror. Instrumenting the code, I discovered
tracebacks like the following for every mirror access attempt:

    File "/home/laplante/yocto/sources/poky/meta/classes/sstate.bbclass", line 839, in checkstatus
      fetcher.checkstatus()
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/__init__.py", line 1736, in checkstatus
      ret = try_mirrors(self, self.d, ud, mirrors, True)
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/__init__.py", line 1077, in try_mirrors
      ret = try_mirror_url(fetch, origud, uds[index], ld, check)
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/__init__.py", line 979, in try_mirror_url
      found = ud.method.checkstatus(fetch, ud, ld)
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/wget.py", line 337, in checkstatus
      opener.open(r)
    File "/usr/lib/python3.5/urllib/request.py", line 472, in open
      response = meth(req, response)
    File "/usr/lib/python3.5/urllib/request.py", line 582, in http_response
      'http', request, response, code, msg, hdrs)
    File "/usr/lib/python3.5/urllib/request.py", line 504, in error
      result = self._call_chain(*args)
    File "/usr/lib/python3.5/urllib/request.py", line 444, in _call_chain
      result = func(*args)
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/wget.py", line 280, in http_error_405
      unverifiable=True))
    File "/usr/lib/python3.5/urllib/request.py", line 472, in open
      response = meth(req, response)
    File "/usr/lib/python3.5/urllib/request.py", line 582, in http_response
      'http', request, response, code, msg, hdrs)
    File "/usr/lib/python3.5/urllib/request.py", line 504, in error
      result = self._call_chain(*args)
    File "/usr/lib/python3.5/urllib/request.py", line 444, in _call_chain
      result = func(*args)
    File "/home/laplante/yocto/sources/poky/bitbake/lib/bb/fetch2/wget.py", line 280, in http_error_405
      unverifiable=True))
    ...  (repeats until recursion depth is reached)

Solution is to make sure we only attempt the GET request once when handling 403/405 error codes.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/wget.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 0f71ee4..725586d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -257,13 +257,15 @@ class Wget(FetchMethod):
                 fp.read()
                 fp.close()
 
-                newheaders = dict((k, v) for k, v in list(req.headers.items())
-                                  if k.lower() not in ("content-length", "content-type"))
-                return self.parent.open(urllib.request.Request(req.get_full_url(),
-                                                        headers=newheaders,
-                                                        origin_req_host=req.origin_req_host,
-                                                        unverifiable=True))
-
+                if req.get_method() != 'GET':
+                    newheaders = dict((k, v) for k, v in list(req.headers.items())
+                                      if k.lower() not in ("content-length", "content-type"))
+                    return self.parent.open(urllib.request.Request(req.get_full_url(),
+                                                            headers=newheaders,
+                                                            origin_req_host=req.origin_req_host,
+                                                            unverifiable=True))
+
+                raise urllib.request.HTTPError(req, code, msg, headers, None)
 
             # Some servers (e.g. GitHub archives, hosted on Amazon S3) return 403
             # Forbidden when they actually mean 405 Method Not Allowed.
-- 
2.7.4


