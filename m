Return-Path: <Rasmus.Villemoes@prevas.se>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0094.outbound.protection.outlook.com [104.47.2.94])
	by mail.openembedded.org (Postfix) with ESMTP id 0CE986B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2018 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=aRJlnNZZoa8jVIYJDU4pWPtfdxXWCoX4imN7Gyx8WTI=;
	b=SDgrjQHo3FBqNkip///v5fvuRBV7+AZyTqleKBbcY41kkNQlc43ytXcT1GfAWnxyTVL04ujEnKfT95GWFofxo1dpt440QiLFBWnpqo/tJ8CONF9Nn6jirrnoFoEXxw3QIhuQF1O7KYiyioZsimfquEBCrgTW3XDRpysLxkKmsTg=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from prevas-ravi.prevas.se (81.216.59.226) by
	AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::22) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21;
	Tue, 10 Jul 2018 14:06:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2018 16:06:12 +0200
Message-Id: <20180710140612.26245-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180710140612.26245-1-rasmus.villemoes@prevas.dk>
References: <20180710140612.26245-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM0PR06CA0025.eurprd06.prod.outlook.com
	(2603:10a6:208:ab::38) To AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:200:98::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be8d6373-2f05-427a-3844-08d5e66e5250
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	3:0A+XiA2pUN8dXPK6qLej/m5yXvcUcBOC48P4M5H1LmWWQK0Wib4sU25tbtGVOe7zZpnKYZsS13r/AdfNtgECJvnvpdMPN9pwKbqlbDro2om3asaVMsMKwmcoFyS2o8Ogoqm6ReyZCNFTBC1zd1yxIVFZuOx80uA4kveSKbHcJLDBjNMEwJibo2t8EbnGm9x89/0CcZU2hA1nb2BFe+hN1kUPOfXcu5+c0zB0yTZ/jLEIeA38oBzfrVB2MzpyvvvX;
	25:dy1lbiEfvl5K2xUtCdKr+nASIU3LPpNmk8wjIY5HAjysO5uptwGdc2dbVXiUPtg6K+QqKpmHxSM632HGJCkysBHOOQiOq2ZJ0eV8OFF4YRbmzZg9yefvU2RaO+/9hic/EZidIZOVm40KLww7A5qBeTeVPsOPd/VVAo92w2V+pfxwkumbgpPsvUHyJW61X6/tOdUYBdefcE0x+CYxsMHu3fom5MSIte4sFz6PVaLqcQry0OA0kul3gVCN5OCa7Pgau20Qu2D9gN7nJXRnkr1uluwMxcH4td3wR+7ZSXYFQNWEJn3CcpSHexPpA0PZgD6JFRoUGActf9c8Ko+iyIdNzg==;
	31:gqazG+VQcplSVnBYdz3OCq8O5hYIBwiQaItfQWFsh7sonDrnHoaB7iC3wlfIpKV/OgBadjVt73JzVCr2tsecEfXlS14uUFyKAY2v6PevplEG+6HpkZcUG+27zjdQ/ePbbJw2J7ZOFLUL582P1rh61zei9ZnrYKDz2DHB4IHu8fvnczrGuoyEo9FTHP8jOC0J9TkvPNA2RLMfqVVbjqmymUqclxMzj9KOm4+GQm9ef9Q=
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1332:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB133273668C679571E21560898A5B0@AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM4PR1001MB1332; BCL:0; PCL:0; RULEID:;
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	4:p+TFlPLYjPkpFya0/8o2/a93dryjwIZ5gvkbt3Z+HDy7YbkQqpcGGu1rUNs8Tgv54VvEQkkBy5MOgFO1OOZOQmrKYHQUKaYu5jOuzAnwZs2L9a2KQlsI0HzCfOkndQ9v3wqwI3ccAW1c6cPuxSJMidmYDpl40yfywvC+W4ubrp2a7koereYKepNCLPjlCBxMy9asH2ChcaoTNItODIbyM68v3332oF8sc3JqXdU9RYQMbiBr5976d3q2oy9LUa6mNEk42DjxaKQUK3RqT/OTQw==
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(136003)(396003)(376002)(346002)(189003)(199004)(53416004)(50466002)(48376002)(69596002)(44832011)(6666003)(6916009)(5660300001)(6116002)(36756003)(3846002)(2361001)(956004)(476003)(74482002)(47776003)(66066001)(2616005)(11346002)(2351001)(97736004)(486006)(1076002)(25786009)(305945005)(6506007)(386003)(4326008)(26005)(105586002)(186003)(6486002)(42882007)(16526019)(8976002)(16586007)(107886003)(72206003)(52116002)(51416003)(76176011)(68736007)(81156014)(446003)(53936002)(81166006)(2906002)(8676002)(50226002)(14444005)(316002)(106356001)(6512007)(7736002)(8936002)(478600001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM4PR1001MB1332;
	H:prevas-ravi.prevas.se; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM4PR1001MB1332;
	23:/XmwYIKGz/O6bTysMiKNA9Ic0GuXs8a6XauVbvh?=
	=?us-ascii?Q?jq9syKFdUPXKHBavaIa3D6MwqdXUEt93/QW0o2vrx2cKCiGdAl5wmDmvrFvB?=
	=?us-ascii?Q?qMBmmmaGoXoEJUek5cWT/nOKHcly0viUe3Bf0wqEnBbJktNOkIaNDhPqf7CI?=
	=?us-ascii?Q?s+Y8iuwFBPxlRL0v0Atsi/nVixn4vQMKufx0WBa94vdX9nC1rZtXFV3D+a9L?=
	=?us-ascii?Q?+mfMHtkIL+Rzo8WGXZSiheYZLpr0WzE8B0DxTXPqyFcPSC/LLDLrW1A9vGC7?=
	=?us-ascii?Q?hAkZ/lFjf4+5nFzmo07EFflkNEX8ez7ygwjRohImhxkNltwFIFzixPhLGuze?=
	=?us-ascii?Q?dwxRqjAlmhl2Xe0MPgIecnXg2P6ctvMc37mYpRpUD38rgpdnMjANQC1JLoa7?=
	=?us-ascii?Q?IWfu/Yh+MJLay53QEsdRbpyyEdqHECMhGXE6VFsiP//q7aT/KGmyePSGnumY?=
	=?us-ascii?Q?jL1mg0UOSxsSZz57V5CHda/41HICAzvqHKehTCmOZjpsQzN2xyFv1v6lbYhy?=
	=?us-ascii?Q?Uhdg0M2g3oMC7/TY6UmU+fmdt+sYXCNUZx98Mz+TANeVCc4l6u+GTRRswirp?=
	=?us-ascii?Q?8uNV4XXnHa+RL3Q7z26J8QF0Z3sieu4NvmmStqvzfC6xKjxnE20O8IOMymgA?=
	=?us-ascii?Q?JWNF1diQa68mrjdfhq4NkNOsF5W3gYAVXKGTZW2YuKGnEJswZY5initmZjBa?=
	=?us-ascii?Q?h9TwRyYYNbWZp3Tlkbxaex4vXJQjj2vkFAdzPxWhuUT4rfbHwwc32JtZqiAA?=
	=?us-ascii?Q?iwtZoUhfx/hcs4kV7bUQRaNyrKUQxSj3miGEouakWaHzBeaX3V2ncBBORUzW?=
	=?us-ascii?Q?EgKKAymujr1UtdrkF1lvTdjhtSwYbmLtpCAwJg9SyOu1DzOL07/WEM5MpWQ1?=
	=?us-ascii?Q?VNJud+DdeR/361NYd7a7exZ9GWNeXBvnd6R169RVyFRd0Wa/7qxwkgCHqBRx?=
	=?us-ascii?Q?hkx/P3Sdbtt1B2AEDWN12G+IPQQKqRBMaohvLOsFIRcT9bOOI3M4pXNaoTu9?=
	=?us-ascii?Q?e35k721YLZJDlWoXAHiE7ZQ0cgNPaVARtPjF5dX/h0bxWmxCmKMnEziU51fT?=
	=?us-ascii?Q?IJnhKxht6/eTb/Ay1dPU4i18+aRKc0EX+ONpmpOfr2bn2iN575WvjE6ctP8j?=
	=?us-ascii?Q?3w9E0iPMEc+Nbl2NvvFUVHdVzGC0TAQOnz6Ly0EhsJq+7J0FS+SO4hIcjNGf?=
	=?us-ascii?Q?gwt5FVv8Jz3xnmBLUyoqkKyDyBcAbkcPbwtDevZ3zdR6EG+prZjRwTHMgvUo?=
	=?us-ascii?Q?0zawS2AQ8EKyybh80zaN8gtBR6nk70m/D6uwujKHZ1oIzKAjfEHFCQ/Ll2Xm?=
	=?us-ascii?Q?5qvIyVnd5mm2IXCh4rpa/q0jltIuBkeBIEsaa7vuB3lAal0FiU33lsW6Btt5?=
	=?us-ascii?Q?snFxhIcG1NvA7yjv1nZTnSwvu/p8dtrnqeXUXKVIJiHCiuma4?=
X-Microsoft-Antispam-Message-Info: z1AU6TocicfddR9eU+pyvwUrV03eWoJSr2Iv4r8IiBtkpUJY9rpw5C8PdkAPT+ttFRKmfhcaDAIIPjgUKeF7y/9T65PAcXYedNpFjDxIB34FTcpTYcVjTF4a9Tyavs6PaklbSUns98eW7fnndUpzuCht6NH8J7Rp7reuS6JMlOnLz/6dEKkpYPQOPa/G6CpRRjvpR4PbPTtFBLmsOJdSkzh9JME+acSI9fXkNPsiHdUgF98bAN7pBDFw8jT0wOcReOj/+ktzdsRMzAsWJg22edyKQ3OOlIY1nIJtvOmmabgdQDDXu/cNZnZGlRxuDwhnJEElyL5Oj3tgqFICHWwdAH4qa45+mP5Qhcn6BdMH+E0=
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	6:bo12ulmpyv0IoFSbzWqPIOYtzINGG0P3lF01zq/YMVkJIdkL65Pa/+RVQD5kGIOesfc7aXt8gm6b24AIMPnV5XPgTQxFI3epkeQAzGJ7/Q94xGhL5nt7aKcO7a5ifUI98vrdNExf3RqPJpubxe0T+ZK7flPR0+KrKOEf7wjQeS1P8vxw/DnBrxqp3MkCa+8HA6VkCE7gIcWlZF6nXBVD2V1xahfsHpHKkoT7jOkFwpGnWQ3Yjvy6BLeUZxdo5NH1XHWG5iowd9kja7DJanm8hKOBUNCqFx4qmPjsN3wIWRkFD/YnRf+gMVh59wbtYMAWvoVoNJSaQUOSr9hn3Dq6Zg2a8dk6/5kI/KEtWmlMZO7tlPf4iMpVIc11mc8CHySQ2MdcTnAdhg53cXucMPu1xDVLaMzW54wjE8a6TaOtjDBK892t+af9xs+aeOTQNag9hAJEI02+mmZGDq1AiRHlxA==;
	5:Y1+W59cuKN9QL3hAEis6Lbb/65opvyz+yTQJjmYskxabI+rgCWvAa8252g2oiICVoiv4CE0LLTSIo+ckbykv0T+L5uPzqUjatl9BUKbPuGqfPxZtLs9E3268yKO1lAUTUyTgVjxK7BWIhBWgBzvIU7D94V0VQHgp5bGg6XLVark=;
	24:3grEHGotHe08HqNPV3jE31vYNcaqdFyg1U+J8t1my6MeDq3xLfK4KVEi1I1teEbqIiErrKDjVsPOdXY91GA3sRz7iWS8sDA8r9OJP0ppsSo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	7:nTG+tsM+78lkTbnSN+CFm40XMxZRgR750XBPK/epTlRJ+2ACVKi8SyKs9r48vVi5cEPdVPt56LgSCh/Whoo91wYlGNzYeVt6OS3+I6MtDWYp9zfqgZ5XDzBGepATYaSJjcsNp6aSEFUuAJbWGMda4y18DAjiWvtE6JhJJ1SrhGc2g92R7Sr7PAQiEhu7yeDZAxyeKKG5tTjnZEaHkZddqTD7znHP5gyjdfB6G7xbrbCGJzPjI+QD4f2UVOwENggW
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 14:06:24.2841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8d6373-2f05-427a-3844-08d5e66e5250
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1332
Subject: [PATCH 2/2] bb/utils.py: implement (md5, sha1, sha256)_file in terms of hash_file
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
X-List-Received-Date: Tue, 10 Jul 2018 21:37:27 -0000
Content-Type: text/plain

Testing on the largest tarball in my downloads dir (linux-4.15.7.tar.xz)
shows that this is ~twice as fast for md5 and ~35% faster for sha256.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 lib/bb/utils.py | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index cb7a6fa2..ef7fc932 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -547,12 +547,7 @@ def md5_file(filename):
     Return the hex string representation of the MD5 checksum of filename.
     """
     import hashlib
-    m = hashlib.md5()
-
-    with open(filename, "rb") as f:
-        for line in f:
-            m.update(line)
-    return m.hexdigest()
+    return hash_file(hashlib.md5(), filename).hexdigest()
 
 def sha256_file(filename):
     """
@@ -560,24 +555,14 @@ def sha256_file(filename):
     filename.
     """
     import hashlib
-
-    s = hashlib.sha256()
-    with open(filename, "rb") as f:
-        for line in f:
-            s.update(line)
-    return s.hexdigest()
+    return hash_file(hashlib.sha256(), filename).hexdigest()
 
 def sha1_file(filename):
     """
     Return the hex string representation of the SHA1 checksum of the filename
     """
     import hashlib
-
-    s = hashlib.sha1()
-    with open(filename, "rb") as f:
-        for line in f:
-            s.update(line)
-    return s.hexdigest()
+    return hash_file(hashlib.sha1(), filename).hexdigest()
 
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and exported
-- 
2.16.4


