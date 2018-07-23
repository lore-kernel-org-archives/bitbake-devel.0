Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0086.outbound.protection.outlook.com [104.47.2.86])
	by mail.openembedded.org (Postfix) with ESMTP id C72AE74F4B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4dYIj49tvQo0sy1qE+1aac5rk4EZzhsSK4WGx+VOewE=;
	b=P5LAqZCiqXRYzG8RkJ/jLAd37Xiw2J+94kjGgFNZpOXwARcNH9fCmytOoA7ZL78fPEU84GN9lUBOqInl7StZ8fiRbeiiKxdeeTfHPmAMx6Tr6pgvpA1u6wH91bgpcjsa68zk+1nn2OJnfLMnmRb46xki7W+EQiW33lE2IezOc0c=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:40 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:52 +0200
Message-Id: <20180723154259.9076-3-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f889be-5c76-404f-9edc-08d5f0b310a5
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:S4ir6tHuC8Bx8aqivLyxhXmoMvaTmxhHgPMj0piWHC2hVaryqYLPnNCtUaw3dWXxc+vT5wKVSpt6vvaNAENkVfn587YbdciQAg+g+L/tTaQoFmFN9Mk25PQdaEb0jJmhjHZANwCSPx+Fo08/JJILv5GbpnvZLPpxYukxw4yeDbFxmkzuBs0t0kbzkzJBEo6PQEs00hT1Xuh90auJJv38NzXu3kGkYp5GFL3TeGSFABzLKagAE+4x1Dx+KMnOkBsf;
	25:+mGLsoTCHbPmtQOF2EaEGiC8n6i+bmhBnRYlVxAlG09Wv3WYg2DJKJiHgdE0o3aBfQo/la8t5u5dCzlLWVrAXvRLJLtVdhC4RGmjigcxxpR+pU049SttUox2nSOyzIQDcJE0ot03xgJeY2FAWb+/lCmxL+YPWE4h6zOuiiDHp2g1oyq56eGPLWbEDMe/7f4YIbJwenpSV+hzFwy7fSRZ39i1ztI5yZnpCeT0UR9BAMRzdHa7Ag3ArM/V3uX/Pk0Cr6/CvTzEaLmLNGtveCk4Kj4fy6obLmcWuDks5+YQ2l72hLYt9pHIMoVVYkfyUHx4XOG1bTv9USvEdiKiRrE5hQ==;
	31:nWuzCbpaX2+Xd5pMlbOVf4y7yFU+GSP1YEslm/I9gvtCe2l7z42a/oD3Yp1TLByle+bDhzL4wo7rbkbLAFlUa26zyh3s//l5tYrCd6YVyK6gKBp+QcAErnsoXGyl1opSXhis7gu1AFW+TcFS0yBkF5+46gneLh1g/cy6X4ULKubbL7xKL5SQT2FwBl8vwi+q9QlQ5hmL9jhhGQQP/TRGO2KLKRp2lJk9XsJbpE/84tY=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827420C668CC63A34D5F9518F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(166708455590820)(126837547833334)(33711482430040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:d9epmTWkEllFA1JvWnGxF7DAA0EtvWeXJ2slEyd6/xYBeyP74MFUqa/fvqqsI8Hvg0XP4E8lKCsP6n5AAb09sSAeXOIupQ0pMcgflQ1WhqD/2T/avY72MTm+AyIlJTELJIIXT+HGFTxBIbKLBph9c3Zmm/vBRTI6FMu7edolMn3DobdbdnIQd7+cA2ZMtW9aFF3pUpHUFoRJmlA4LO9seu4Lr+fALj4PTgWHJpVqaQgVnQ2XNV3VjqFapmNRqyO2Us8jSyWNaajOgoJ/sLZmUgy62dr1bpoQh6j5AqXmz7ZMg4FPCwKzYE0X5/Pv2ZGumbigxoSuE/X5hwH5bzm7R634myv8OUCQva+t0+N85/sCCHlXNe2sTAwN4xny1lhFaE5FAmSgDi8P5XJxQtlbpdajBKhQOp4bH26Qkbnwb7I=
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(575784001)(81166006)(16526019)(186003)(11346002)(446003)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOmpReVA4bGh0VEIxZUpocFJ5MnllbmdPYnhV?=
	=?utf-8?B?Z2YrWkdzcEQ5Tk9hY0txcndHU2paUkRQNTRUOFBqaUFBN1M5TndSRERBQnBC?=
	=?utf-8?B?bFhDbjU3K29ONjZaZVgveFFyN1EzWndRZThqOEZtNEs2dXNaaTRQT01BWUVY?=
	=?utf-8?B?UzBINkd1eTEwQ1hiUjR2b2tSbGxza2JVMTFpK1hwbG9lMWZWK2F0QXZYc1h4?=
	=?utf-8?B?cStXMnVKdmtDay81RVVGblVqcGRQNlhRS0J2ZUExZldES2ozMGI4TWQxbHZF?=
	=?utf-8?B?cSt6bnZJY3B4Y1E2SHlHQUhsanJJY0RWVEk1RGRwRS9PQ2d5Z0t3WFlxeklx?=
	=?utf-8?B?L1pROHlpdmZFZnl2bGp1WXFiYjlpYkhKSUQzQmVEQnQ2TzR3czJOcVFxcXIv?=
	=?utf-8?B?Wnh1TlQ5cjNYT2RzK1h6RVVkZm1DV09CRzJsYmZLc0VreVJhMnA3RUdreUlI?=
	=?utf-8?B?YUMwWHpncFlDcU1LamhZUkgvc05DWlNnM3VWcVVmYUJ4YUk3eWtFdzhBbjBS?=
	=?utf-8?B?WVMzR1AzOWtMS2VWQmZDaXgyOHA0QkFBaW9Cc0dFaUs1MVBqcllpMW9hRFRU?=
	=?utf-8?B?emFMcUs3bzVWRlE5M3lxV3hlb3N3QXVpNnlrWmRJcldCbzRsSW9nSGJNYXp0?=
	=?utf-8?B?WlBaem56NzdUcWJpN0h5R0NyYnRBcTlRTkN2WDZOcUV4ZXhjdE1JUGJuQWJW?=
	=?utf-8?B?TGZCL2tnYlp5dCtIaS92SGJHcU1CR1R0WUN6WFY0WDlkdDBXT2kwY2U0aEM0?=
	=?utf-8?B?QWtORUFnYVhQVmlyUGRtWnZjT0NvY3RnV3JIdjJaVTJ1cklsdlRhTFhSMUtv?=
	=?utf-8?B?azcvMFdZSHlNeXVyMkdaa1pLN3NZb1paUnZZdGpiUzBvYUNHdldhQ1ptcklV?=
	=?utf-8?B?YXlxK2dadjB5RXlIRHkzRW52VjVxZUtHME1TTEpScXo1MDg0NGV2R1g2eDBJ?=
	=?utf-8?B?V1RoV0MrbWtLZWFuQXpTUnVwRmZNSGpaS1B1d1BiL284SHJJSmhvSkYwTkZp?=
	=?utf-8?B?cHlyeFRObEZyU0ZIVm9oZ3BuUDJCL3hHNUMvYlBBRm9sK1FwQWhha2VkcTNz?=
	=?utf-8?B?QnY3UzNiSklRYmVpSDJla1hPbStHTUk1SE1tOWhvZjh0OXRnVTNwb3hYTHY2?=
	=?utf-8?B?ZWc1Z2tvSTB0Nis1ZFpNWjJSYmp3bG9VTFQzRHdSUGdVelUrbUpiczRuemJr?=
	=?utf-8?B?ZVJtVXJMb2JndmFjRnJUOUhQaDd0UGlKb2J5N2lUWnZvdGxWT21NZ0F4TGN4?=
	=?utf-8?B?ZXc3TklrdisxcUt2VzZrM2VSbXVLVjRqbzlLZHRTWGhpamdyM1NkMGozTG5r?=
	=?utf-8?B?UzhBTnQ4dGVKYXBQOEdXSXl6ekcvZ01kdzkwQlVRaXFROEFQc3VsTDd3d2xp?=
	=?utf-8?B?NUw1ek14TkxNN0RNcWo4UElqSW93Wm9DdXIxRWxZbTBJUkJGUHNLL0RBTlRD?=
	=?utf-8?B?U1hiUnJ6RGtMYlpjSEN3VStHcU9VekJEaVcvZTlidUhQRXZrb25NbmttWHQx?=
	=?utf-8?B?TC9uVVMrTnVxNy91THczSkhDcDZac005S1AwN1p3SHI0UkhVOFlmTmJyQklm?=
	=?utf-8?B?NGp3MHkrMGJWMDRmQ2d1Z1lBMlFvdDNKWTZWYXR6bDFWZkhFdndvYjVoTmM2?=
	=?utf-8?B?U0wvVkJ5MWZJVStDRGNtUW1rbjd2NVduNUR3eW95NE1rditTeE9SY1JUaHRy?=
	=?utf-8?B?ME45MWlRMTkyTkpQemdPTDArclZ5N3JBN21OTTNhQU1kdTUxaC96Y2xTd3hH?=
	=?utf-8?B?bE1ScGtFU2pqdVA4WWVUUT09?=
X-Microsoft-Antispam-Message-Info: dYWMQQ5gspH63jN6jnjWmbX6FNQSZAI7YRKIbobJ1lWYi/+8AVtJ/to8mb3mtyNRvXEFNmKkW7dBe9D1RcPLVlua/n8Nmh4ESphjVnInsV3FK/707oGkil25eiAytax9Yh4IeZAOJM9AGGyPmORNZWu62YgPPum8B4q357NZomvr+Ysv2rIuBZGmicvpwqkVIL4C+o1E2ssvmdcvYhe0KaL1MoAtvmqGJxMXehum35v2CThh6Y02DA+QMo5v75IOPFw27YmualATKnNlZD9pZdvOikjhCcb468MGNQdCcIJxoNp1T9sZwH5NjEIY+3sgeF5M1Ba+6AexTFcV2ktiKatWDG5rPVlqcla9i+TtLU4=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:3EIw6lMKDytOvByhbAamJLz37Ul+mOPp0W6BuqTuPgvItipaO6ca22tmO9IC+VlRvf3emE4BjX7UuazeUtL0kL3lHUI8oyVf5AlA9rZ3+PlLlGoDk7RuWh6zSzsBbXpG0gW4ZB3z1S07Wb0p0Lu4JcXuO4Dyl+4rdH0FKy9BkdSdP0PndadwDu6M6FNYhveRazgr90WK9Ooks1Kcfj/qCBneoYq7YEm/2BDPgxBA0CkoddozT0nLp8KFtUjzOpY79X7WfRLlgG3E/GT60QxHTVCShcaTlQlpG61SxxD28MyDqmQLxGLo13YgwKS5K4P8OaLkaso5DQSejpXhDERCHQ0crWxsraD5k4GCRR60Zv9oHz6c24WMhYQGnoEFfha949ceyklYfUIRiDiLbNjEWbvjRTLfTKNDsLH6t33GiKrAjfRkbjOnWexCJwXEMKGwrGlwBwzSD1DOaUDqJzGj+w==;
	5:iZZAo8pMAVRR0DeMc6Zin2GUIllsGag9ovbN7/hGTkoD7yCxgx/Fmh77MkHf+t1WPBeIRWrOlXmKLh2Z89+tpKrYy76wMhr5Ibpjsygslmde6dbtnauhWQXsm+VqbJggRg/+Tz/Eisc03wlODdb4iN48Etj9PpqeDxI/N94z970=;
	7:GTjmlq4+/ZpaFkvac/xGQTcTKh1ymGX7XCCdJXia/mhKSDkhhaFrcVEYS1Xqqpn7lsGWizF7ptAKHeQ8M31qPgH0qaNoDRtolvHC/a/0aWinGMROO4OAU3ZpW6VP3c2QGqKhsLqxYFchy2yVndjJmZsLCB2rOTH76lB/IchwPJpm3EJUIGcYzHHKwP+EqP0YA/N34JZMwEefLJrR/vR4DW+1Htxo8/FcMRc5WLzQZ+WAsjWkC0RWNxbMubfNUQhk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:40.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f889be-5c76-404f-9edc-08d5f0b310a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 2/9] fetch2/git: add tests to capture existing behavior wrt. naming of git shallow tarball
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
X-List-Received-Date: Mon, 23 Jul 2018 20:17:04 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mapping of the URLs to the local shallow tarballs is not obvious. For
easier understanding, we add this tests to explicit showing the mapping.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/tests/fetch.py | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5bce1bf8..83cc4f6c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -515,6 +515,55 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         self.assertTrue(path.endswith("/" + self.__mirror_dir))
 
 
+class GitShallowTarballNamingTest(FetcherTest):
+    def setUp(self):
+        super(GitShallowTarballNamingTest, self).setUp()
+        self.__recipe_url = "git://git.openembedded.org/bitbake"
+        self.__recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
+        self.__mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.__mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
+
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
+
+    def __setup_mirror_rewrite(self):
+        self.d.setVar("PREMIRRORS", self.__recipe_url + " " + self.__mirror_url + " \n")
+
+    @skipIfNoNetwork()
+    def test_that_the_tarball_is_named_after_recipe_url_when_no_mirroring_is_used(self):
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        dir = os.listdir(self.dldir)
+        self.assertIn(self.__recipe_tarball, dir)
+
+    @skipIfNoNetwork()
+    def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(self):
+        self.__setup_mirror_rewrite()
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        dir = os.listdir(self.dldir)
+        self.assertIn(self.__mirror_tarball, dir)
+
+    @skipIfNoNetwork()
+    def test_that_the_mirror_tarball_still_exists_when_mirroring_is_used_and_the_mirrored_tarball_already_exists(self):
+        self.__setup_mirror_rewrite()
+        fetcher = bb.fetch.Fetch([self.__mirror_url], self.d)
+        fetcher.download()
+        bb.utils.prunedir(self.dldir + '/git2')
+        bb.utils.prunedir(self.unpackdir)
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        dir = os.listdir(self.dldir)
+        self.assertIn(self.__mirror_tarball, dir)
+
+
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
         def touch(fn):
-- 
2.18.0


