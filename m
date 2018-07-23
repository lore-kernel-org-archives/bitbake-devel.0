Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0086.outbound.protection.outlook.com [104.47.2.86])
	by mail.openembedded.org (Postfix) with ESMTP id 8DBA6751FE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZceUAdSqA1RupeszdEDfbtKr1vKL6+HscRFU913icuY=;
	b=D2Bo4qxp171sw71JFbPEKaBQhmus8Pm33MVK1rF3JYSCCHH4BRCGulfYim1SgrlSdjfQOwzoyBxEkvSxyPZYRg8t/m+KW1ErN6gNlayydnBBDHCC8pJ+893w/ENvnmRDhfWM5TX1wGyddZmvoeV37DWEFht1l67vNBPUolApMSU=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:44 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:57 +0200
Message-Id: <20180723154259.9076-8-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af6249b-fea5-4588-4b12-08d5f0b312d8
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:z/YLFNhaLdWIZkrLp30zDuNEmaJExs0R2ubCpF+gTsWnRXLtvHRF+5yCNdkN6Dqh2d2Tg58FAXhAnuhppEp9S9zlXj+v/LvMAc2Y2IMnf/YxWHLYPu8ztlR7NSl1KQhzU1x4VIqUQ0v+L02kP2ad70XzjZyBUN2MjY69cLMZ/JTWBOQk1Wc4T9+M2hDdxiNyyGFEcehAJIDLzyBOu5Oz90LSaVOFKACWre1v7fUTkiT3pq3s0d5HibXEGnP3YqMB;
	25:spaqlUAkZPQs+HnFRLtxRj5Xj3fIvHq7syt6f4MgHBNSFf5efkRTAtl8UvAYiJrGzscDTiz8s6JMMuqXtk0IgS0K1N+pL9vspkUu9jmOUu0zJ+JfAtkETtkUjSOtTwNqoaOUDOP6SStZrtZeveXgeTjhx3zK/weTSennnR9gUytaApprvAkTv33S9Ae699Tc9pDn/Go0fhuBqrHfhK1KL/hmedMYJaTb7amX6n9Pj45L1/8cL+5zKWYTW/x4q592CiRawO8Mzo8KEXS9OyhBvhar5nuEpcJXrJtTq+M5zm/73izWrs1d1N76H9ESegI85xThO7Twkxr28xuWzlzwcA==;
	31:vmIgu3wPo0mPaaCDYvq54PrjjnS60ROYKp4QxzzWhViy02YhchGdHYRymqpTvvwo9ThdKntrj0si9lAkYlAFyX9oYSkFf+65VQ2hKC2AZbHunB8exJN87otLEfbl9Qkj1OeqQzjEWkvomBtBN3K8x4RMb3fo0+sZvneYFd/ogiYOgF4o6GoQDUc/2nTI4LoAuXISkGqZxHLJXVuoRh7h3iDlX/OjtlGsRIL8N0UU4vY=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB382719EBA4019D3FA9900F208F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:/ER/SuQdERXmIhUakCzamwxymrwiGVkRo9cnzdhyU1ITQbL3yAJZXUZ/YRct2o4Y1B7qbuaNX42msUlg76QSq9vdkmBgqpUQfQa9Cck+Kc5B7/JkbntNq3j1ZBQNL3yv+uBQoRTGkjYojPtuffUb7GZaVNncSOQgwUQhMpXxVfdqqNxKZ/nq2SMw3C4n5AX7kBWiD3uKipCIsK6w9pbcfIWSCmdmZrJxXFKVR9RflGz1MJlkvQNCjVMdpW1Nv5X5eNxaKT7SJAlyJg3zqwIJ7XhE46Tpv+erSl/4IDS52vfCSe97bFSd7Jrc6Jb/ZZFBy9Hc9IlpMbznfqExr14rksEjM08UHYeD8bZULzVUqcRcNGOEFkjm8A4o2lUqdyn7
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(575784001)(81166006)(16526019)(186003)(11346002)(446003)(14444005)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(19627235002)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOkxmU2Y3emJIZjhLUjFVbC8xODh0YXI3VVFM?=
	=?utf-8?B?OHQyM3Ixb0JrSnoxNXJVN21vK1BYYVZsQ0xHMmk1SVM2YTZkaFZaR3N0VVZG?=
	=?utf-8?B?Ullaa1I3d3o0dmR2ZHZwTjRWejk2c2gvQVZRdzVsRlNqWjJxeENoU2NKWGdQ?=
	=?utf-8?B?THhzRkNCS0pNRU1YUWRTMDNsRzZOSStZVVRVbHl5V1N3Zjh6bDBFV0FoK1lr?=
	=?utf-8?B?V0p6d2tEdWdZMlh6YmwweGJUYlNtcVkvbVhvMnVpWVdqZCtxSTFCOEprb3lY?=
	=?utf-8?B?MS9ldmVac1FGRWgvZmNPOFh0U0lTWUhnaHFvUU92K2Q1MWtLV3BUcFNaUzVy?=
	=?utf-8?B?MlRnU1lZblRXZkdicU1GWmpBQ0tNT05BbGxSb0llb28yS2JIN0xZWDB0NUl5?=
	=?utf-8?B?STd6RTV3SzZZemhqQS9tSmVuaEFGQW5YeXNES2EvRUF2ZU9DQUw4SnVZZ3BZ?=
	=?utf-8?B?d3ZRWkpod1ArNEZuQVBmd3MvdXM0d0Q5Nk5ETEloVmJqM1dxU21RUkFNWXQv?=
	=?utf-8?B?NHRUWkRoQSt6cG9uT0QrZVBNNFBadG13L3ZzSmEra2Z5Y2R0R3FFUDhhUzVm?=
	=?utf-8?B?VE1rNjB5dFlRTlFtNkV4VlBMeHlQL2haZjNWVmhLeW5BVzFwY2tvSjJTbkp4?=
	=?utf-8?B?Mll0dk9tUWdVUjlDVlNRSUxaVVZjMWw4aUhicHVacmFSNkNqSkp1N2xVc2h4?=
	=?utf-8?B?aWJqY050ZlpCU2g0K240WFV1VTdrMVlkSC9WUkFxWEg1UWJlZEc3dldBODN4?=
	=?utf-8?B?QzJPdmJhYU5UTDRpT0pnZlc1TVJDNWdmdk9kQ3JlRHFqa1ozMWlDSzhZekJQ?=
	=?utf-8?B?andhR3BxZmZRaGRGU3RUTHBwVStrZ1FWalBKVExkWmEydVo3MmlOaEhyUjlw?=
	=?utf-8?B?aUZGMngxUThrMGtBbGlrb1FlbkZKYzN1NGVYdTFhYWh5M0pDOHJpK2hqQU1r?=
	=?utf-8?B?T3ZJSGhqWWVqOCtNazNwWDNIT3JSRVpoczVZTHVtN1FMV0JBRmt5cXlVUVFN?=
	=?utf-8?B?c2Vwc1dwMFBITVFwVGRrNjJSUnlXc1UzLzhyWkZUUkhwVW1SNWFZSmlqREww?=
	=?utf-8?B?eFRKelpWVkE3cTd6dHUzRjB1QmxPSGExSnArbEZWVjdMd1lwSUUwbkNXWnB0?=
	=?utf-8?B?UFBWaHdQMU5LZEJ2RkdFQm4wUGRGOFhMTWpDNUVPV3lGT3lmQ3E3UlBkblAr?=
	=?utf-8?B?Qkk3Mko2bHo1V3FROFdzaFVOdzV0Nlc1T3lpTUVlRlZ3UUNtLzBLVTArajRE?=
	=?utf-8?B?R3JFTlU1UWhDQ1JzWDJtaXBBQkM2WGJKWE1Hd2xqNVkvdHdBYThza0FqTkRU?=
	=?utf-8?B?QUMwWjQzb2RKUUw5S0gxK3o5ZnlRVDhHRlpwV2dxVVVkTWNKNDdVVEZoSXph?=
	=?utf-8?B?M2lvMHhnWlVla0NHYzF4eHNKZk45b3pHZm9lMVNUYlUyQkZCRnFEd2ZWUXRC?=
	=?utf-8?B?Y3Npek12YlBCZ21laUFGVWU5QWF6VDU1Y0F6ZHdPdFp3bzd5OEVETmt6VHYw?=
	=?utf-8?B?TDBReGdiVjJGdFRTZG5oSmM4TEtiNTM4OURLbVB0bEtRU25xWlFLc2dGbE1N?=
	=?utf-8?B?WWg4M291OTg0K3Qxb1ZRNnUrNDdydVRpNWhJQ21QeTA3eW9IamZyZitQYytQ?=
	=?utf-8?B?bi95aVlCYjZ3Mi92OW9UU2tkZE10M2RqT1FBYlArK1UvZ1NKRmhKa0VSaXZ4?=
	=?utf-8?B?eFgyekpJVFZNazJjai9HaHVWalViYzdtSUdMWGllT28xVWhLanBKbWppbGVR?=
	=?utf-8?B?dEJBY2lhTGVFejdXRmlXTlZFVisrcjUyb3BWV2tsOVJxQ1c3czhVdUVjbDNB?=
	=?utf-8?Q?bQ4j2YdYfV/qW?=
X-Microsoft-Antispam-Message-Info: Ri8PWvt/olJqelKquMvYoxN5m7z16mQuqInE//8ZB8C0w0FcnBOqqAIuMseJiOmB8nQpaaQFp69ECWiAM+mm5YSmRqzc2yb8ytqxEXbGcDuhwEScA8uG84Sl7Rmzu+LF3YXj257UaDLzJvp8PnFpRhO5aNQOVoo82R7OFP20AwkpownKofvicONXW4j5rxVdZB/KjR0046K6XGBa8sgVKHjXyNiVjkDoqcOrc4DESVyRFLALPTjPGfU/RIiQYNWWuzSDCQ22kF0LwzLh2XNoUbXfbwMOEkCpLzsoTU5pdv5d4y0nqQsqyBc3kcfIzJdlQtQlIdrptZ4j+0X61qte9h0ME6WlMX50KmoN2lrhwyM=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:Moh+zEVESgQXUD5p/tvy6mYRS45s5rlI55YBz5G6LibWvOgQSaO9TI3BfwHOljsYVrwZM/DcZexjSggQIoThqN+O/fekVQNZJtce7uf21qH0E0OE359HVE35xnJ6sAVrR3vY7zxDrnmFl7T23vvh1zT0rj8PqLU9Ofj2MWbdOe8D+AxmglUmukTGghZ2NKTq4vAsnN+xw56Gn9/s50aQGpT6Zu/UtG5E7GilMWs7JfGQeYHGzQSZi8Fgd3TqnoK5CFDz7minvlOhXO4NA/8K32KFoJN09SSmuZ7m93Aqm6+yyo2ltpmiV7pbPHuHCMvqk9QXINZsI2bkY3FgurXxjnKMUgx5fJyJ4eZ0wj1d5bWrFJKQkwdkyIfMtVG5ZvniazoF4oCWPvkIXSFrSBkHMYxt7sAcR/WWD8XTNFwNnvj/Q28Nqzqmoq2u96O5gydMU5aqIR8RMxbqJxRUjtdfMA==;
	5:dVeZpScrtNwAK0NNtgZGfb4D2ppvCGl2YPi6tXzMsEFjaZpZrF95ayhS3rkx2FfE0GWCf3mK8TOVNCUWoPGKE59QJYKUm8xNgc7DX6Vf1GoOIt4Fu6oKPhfdFGRne0h/WWUOPBPVocyUEd/P2RVy2ezH57aXyHkHj6yYbe21JAQ=;
	7:C4hYU2doxxpoYQmi1TY2Mn/ufMI7AABxsz3g4BP9PcTZR3IJm8xq0yY9CMIqxtkoYCM4fE3BVSt+JgIjFy+awtjevLNgJmpRgGgQiHTl+gSt/AfdichPj2UwvjUCZ8k+ZZEsKJr/GKhn6VcFmvYvbUJjP+3QNJ/hR7g5HcyLyDCGlGq+oXgzo8GAKhLaYb96V+wDelb3sQ6TPJssf1adgLsY0+r5KWepmRML7Gw94w+H4TyKJaMaMpYrgHp1I2NH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:44.6582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af6249b-fea5-4588-4b12-08d5f0b312d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 7/9] fetch2: provide original url in addition to the mirrored url to FetchData.__init__ and FetchMethod.urldata_init
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
X-List-Received-Date: Mon, 23 Jul 2018 20:17:05 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a mirror rewrite rule is used, it can happen that the downloaded
file is named differently depending on the used mirror. In preparation
to a consistent naming, we provide the original url to the fetcher.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/__init__.py  | 12 +++++++-----
 lib/bb/fetch2/bzr.py       |  2 +-
 lib/bb/fetch2/clearcase.py |  2 +-
 lib/bb/fetch2/cvs.py       |  2 +-
 lib/bb/fetch2/git.py       |  2 +-
 lib/bb/fetch2/gitannex.py  |  4 ++--
 lib/bb/fetch2/hg.py        |  2 +-
 lib/bb/fetch2/local.py     |  2 +-
 lib/bb/fetch2/npm.py       |  2 +-
 lib/bb/fetch2/osc.py       |  2 +-
 lib/bb/fetch2/perforce.py  |  2 +-
 lib/bb/fetch2/repo.py      |  2 +-
 lib/bb/fetch2/s3.py        |  2 +-
 lib/bb/fetch2/sftp.py      |  2 +-
 lib/bb/fetch2/ssh.py       |  2 +-
 lib/bb/fetch2/svn.py       |  2 +-
 lib/bb/fetch2/wget.py      |  2 +-
 17 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c8653d62..61009e43 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -932,7 +932,7 @@ def build_mirroruris(origud, mirrors, ld):
                 localmirrors.remove(line)
 
                 try:
-                    newud = FetchData(newuri, ld)
+                    newud = FetchData(newuri, ld, origud.url)
                     newud.setup_localpath(ld)
                 except bb.fetch2.BBFetchException as e:
                     logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
@@ -1202,7 +1202,7 @@ class FetchData(object):
     """
     A class which represents the fetcher state for a given URI.
     """
-    def __init__(self, url, d, localonly = False):
+    def __init__(self, url, d, original_url = None, localonly = False):
         # localpath is the location of a downloaded result. If not set, the file is local.
         self.donestamp = None
         self.needdonestamp = True
@@ -1213,6 +1213,8 @@ class FetchData(object):
         self.basename = None
         self.basepath = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
+        if not original_url:
+            original_url = url
         self.date = self.getSRCDate(d)
         self.url = url
         if not self.user and "user" in self.parm:
@@ -1259,7 +1261,7 @@ class FetchData(object):
             logger.warning('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN'))
             self.parm["protocol"] = self.parm.get("proto", None)
 
-        self.method.urldata_init(self, d)
+        self.method.urldata_init(self, d, original_url)
 
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
@@ -1348,7 +1350,7 @@ class FetchMethod(object):
 
         return True
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init method specific variable within url data
         """
@@ -1594,7 +1596,7 @@ class Fetch(object):
         for url in urls:
             if url not in self.ud:
                 try:
-                    self.ud[url] = FetchData(url, d, localonly)
+                    self.ud[url] = FetchData(url, d, localonly = localonly)
                 except NonLocalMethod:
                     if localonly:
                         self.ud[url] = None
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 658502f9..4be73320 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -36,7 +36,7 @@ class Bzr(FetchMethod):
     def supports(self, ud, d):
         return ud.type in ['bzr']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init bzr specific variable within url data
         """
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3a6573d0..ef1db138 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -84,7 +84,7 @@ class ClearCase(FetchMethod):
     def debug(self, msg):
         logger.debug(1, "ClearCase: %s", msg)
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init ClearCase specific variable within url data
         """
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 0e0a3196..7c5296fb 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -42,7 +42,7 @@ class Cvs(FetchMethod):
         """
         return ud.type in ['cvs']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         if not "module" in ud.parm:
             raise MissingParameterError("module", ud.url)
         ud.module = ud.parm["module"]
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 13b9b9d8..7f7951f7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -141,7 +141,7 @@ class Git(FetchMethod):
     def supports_checksum(self, urldata):
         return False
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init git specific variable within url data
         so that the git method like latest_revision() can work
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index a9b69caa..187e6b2e 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -33,8 +33,8 @@ class GitANNEX(Git):
         """
         return ud.type in ['gitannex']
 
-    def urldata_init(self, ud, d):
-        super(GitANNEX, self).urldata_init(ud, d)
+    def urldata_init(self, ud, d, original_url):
+        super(GitANNEX, self).urldata_init(ud, d, original_url)
         if ud.shallow:
             ud.shallow_extra_refs += ['refs/heads/git-annex', 'refs/heads/synced/*']
 
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 936d0431..5fe08e80 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -50,7 +50,7 @@ class Hg(FetchMethod):
         """ 
         return False
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init hg specific variable within url data
         """
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index a114ac12..9e1b918c 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -39,7 +39,7 @@ class Local(FetchMethod):
         """
         return urldata.type in ['file']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         # We don't set localfile as for this fetcher the file is already local!
         ud.decodedurl = urllib.parse.unquote(ud.url.split("://")[1].split(";")[0])
         ud.basename = os.path.basename(ud.decodedurl)
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 408dfc3d..cab792d4 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -60,7 +60,7 @@ class Npm(FetchMethod):
         bb.utils.remove(ud.pkgdatadir, True)
         bb.utils.remove(ud.fullmirror, False)
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init NPM specific variable within url data
         """
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 6c60456b..18dd6047 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -25,7 +25,7 @@ class Osc(FetchMethod):
         """
         return ud.type in ['osc']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         if not "module" in ud.parm:
             raise MissingParameterError('module', ud.url)
 
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 903a8e61..3a15754a 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -37,7 +37,7 @@ class Perforce(FetchMethod):
         """ Check to see if a given url can be fetched with perforce. """
         return ud.type in ['p4']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         Initialize perforce specific variables within url data.  If P4CONFIG is
         provided by the env, use it.  If P4PORT is specified by the recipe, use
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 8c7e8185..c56df7e1 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -37,7 +37,7 @@ class Repo(FetchMethod):
         """
         return ud.type in ["repo"]
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         We don"t care about the git rev of the manifests repository, but
         we do care about the manifest to use.  The default is "default".
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 16292886..e00f7072 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -47,7 +47,7 @@ class S3(FetchMethod):
     def recommends_checksum(self, urldata):
         return True
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         if 'downloadfilename' in ud.parm:
             ud.basename = ud.parm['downloadfilename']
         else:
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 81884a6a..f68cbca1 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -78,7 +78,7 @@ class SFTP(FetchMethod):
     def recommends_checksum(self, urldata):
         return True
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         if 'protocol' in ud.parm and ud.parm['protocol'] == 'git':
             raise bb.fetch2.ParameterError(
                 "Invalid protocol - if you wish to fetch from a " +
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 6047ee41..4f9e0853 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -77,7 +77,7 @@ class SSH(FetchMethod):
     def supports_checksum(self, urldata):
         return False
 
-    def urldata_init(self, urldata, d):
+    def urldata_init(self, urldata, d, original_url):
         if 'protocol' in urldata.parm and urldata.parm['protocol'] == 'git':
             raise bb.fetch2.ParameterError(
                 "Invalid protocol - if you wish to fetch from a git " +
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index ed70bcf8..be0e9eeb 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -42,7 +42,7 @@ class Svn(FetchMethod):
         """
         return ud.type in ['svn']
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         """
         init svn specific variable within url data
         """
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8f505b6d..bd2a0c6b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -74,7 +74,7 @@ class Wget(FetchMethod):
     def recommends_checksum(self, urldata):
         return True
 
-    def urldata_init(self, ud, d):
+    def urldata_init(self, ud, d, original_url):
         if 'protocol' in ud.parm:
             if ud.parm['protocol'] == 'git':
                 raise bb.fetch2.ParameterError("Invalid protocol - if you wish to fetch from a git repository using http, you need to instead use the git:// prefix with protocol=http", ud.url)
-- 
2.18.0


