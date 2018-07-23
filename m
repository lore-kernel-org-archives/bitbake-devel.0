Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 19131 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 23 Jul 2018 21:17:35 UTC
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
	by mail.openembedded.org (Postfix) with ESMTP id A0BEB74F09
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 21:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jIGyMOTwOpcCx/EBZiFPYhtXm0AcNCDVPjvwX9sSSZg=;
	b=i/B2t9ZRJ7THtYy3JSR/5G+X+4SJNmi7DM6PPknx+m4B3Ria3QtoY6y0/OGsTyR0rPIKg3wKtiiJYcwF/qxp5yi/ZOrIbP6C121hmm5AsTPBOmr1lU3J0lZr2kpXUtmDbwPlQNoik3GpDLuDbM8ZCwwQXoAhi3pK8VGVfueVviE=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:39 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:51 +0200
Message-Id: <20180723154259.9076-2-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfff1438-7ad2-436f-3054-08d5f0b30ff5
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:wLB/566Zo2iNXNvST5he54Izz5MG/uaVFvSohAsn8z/YfbhXboa1M/O/RWyOHBpIFiAR44O9hwwamCRnvVnhgnoneatQAcYEGQn7EFMSFOtovuqRoqp7ayZZAfwk5KJUQtN7zpFGxqhvnNPVqckc3/k69yu8kfkh59uGuM321WURmOC1m0SFKr9uU2csXlx8a6h/ymh1FAJxqgIbbh7t2WoMK8hlzRK9WOVb7kiSGJVBQBxjSsoPl7Uv67eA2d7Y;
	25:+7CFu1spD6mmdxa83B4LWPw0GXoFvC+kh9FSf6o5EJrolh3j49u4YWsPATrON10e8CeFgHhtrtn2a6sXWTBcFF/2UoH0m1NucmXs/fWpDmS//I/JScgW4r4JUu6ZG+amS5GRi2EIFuQIuJyB0n2ZAeb6lVzdPCZGp0PlkjA9WNoeAyHfX1rB8tPraWDlNyKyo5QW4YNfed5pPYJCY3eWju4tL/E9I9gZ7N/EJfs1lU1XCXVifXIK3PoyDky7zGK010lRxoAa1vnE9OK5VJu/oxK3FHAQefPxenoBHkVKXCO8b99tzpez4cfSZxOJkItzDMmGpEAspkuNmLoVproRqQ==;
	31:Ipdz2f8GbF76eWH/rz2lLtVub6Kibv3azCUZz+hDybWdChcQJNMgT2Ez4SXPBLya8gffdMzJv82lsUNxlnaoLSjGe6nj8D/ZQSi+3+i8OWKA7H2hJkQXtxm3bqP2TQXepX/jeDq94rWKaaPnlqLYLuc4ZiFyfM8f10E2fdEwufjGO0RELwn8hzkOHb/oToTcXdu/RshkmbaO0XogSGbfkhgD+qlp3DodJGBXZTYNNcQ=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827823A97C4232400DEE4B98F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(166708455590820)(126837547833334)(33711482430040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:f0zlIei/YBfd2wASnCjiDkgrWeH1OBTNnF9kBzHDVYlh2gtLaMu2R678GZ55UdsPS4qG01BTX/NrX9dY42YAHvCQqppqKBVM2AipYIIjW+bKzRgSxuZQtyY36nY9AdX6QxH+0PZaUVluu+nPaYgxMvxLWqsL5i422kel8xtcaFzTGOSs/SheGoQnj3f4XYDRCQEbQSeam8uJTPT3SKTjxzeS8de/lUTYwCW4ABL+2gmkacmUy93lUcWruZmq9eX0LmzHrUc5TwcPMkEz8xi0pQYB94RLYvUo5Ku7SlAPhfyuuEcwYS69u8nmhX7bmfDGYBrPKuc8P0XgNjh9kTUncg5sWYlYn5sK6jT57l2f2NL/05x0rEHZ8W8wYd17v7FkdyT6l/eGW2w9OWoE97BhnUIKtH6YN0bTJFWmqb4IqJo=
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(575784001)(81166006)(16526019)(186003)(11346002)(446003)(6306002)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOmwyMFE5cUZyTVdYdExRRDJWZS9MZ2dPUmk4?=
	=?utf-8?B?QWZPRkdzMjh3TUZsVmh2d09nMVNlaEkrTWtRRE93dU15UmlTZ1NoZkxaNGhC?=
	=?utf-8?B?WktFVWtHVE5nU3BTTGUrZmx2R1VOODZjSFhXSFZBTlJkbXV0eW50aTk1UFBo?=
	=?utf-8?B?TURaT0Z0Q2lnMk4xVUhHSXdRTHVVUFF0bEltZml2T2FUN2VNeW1iV3ozNE1k?=
	=?utf-8?B?djBQMTY3L1pENlNoaFU5MGZqV0d1VWlPOU5Md1NHNnZiUGZXOW5SNmczd3N1?=
	=?utf-8?B?c3M1VVk0S1ZHdVpxU3pjVGhqVVF4bWUwZkYxNlFmOWhtMGhyNWlwd3gyREo2?=
	=?utf-8?B?L3VBemcrakNTamJXMTVmNnp2eTVMTDdTZWlHWkZqSkZHNjdrdnRibVZ4Zkdp?=
	=?utf-8?B?aG9kcTRJOVlIMVpmOGVXOHlDMHVBMTJoWjkwRHVjQzdzZ0lteHBFSGs1WTls?=
	=?utf-8?B?b2FUckpSVFNGZzNXWXN6ZzhyZXVmYytmZVVJS1RwZHpkc1dLbFUxL1UrYXdF?=
	=?utf-8?B?NExjRE9mK0RhTzlJTWV3U0wxZHRTbDl3NGdhRGpTVG9vNTFSME5BMklTaTNC?=
	=?utf-8?B?TFVpNEp2Mmpka3h1Rm5rd1E3WXBKNFA5U3l4Uzg2QjJkbFVLdXd6YjNkNDhl?=
	=?utf-8?B?b0MybWVGbnRvLzc3Umk1OWdxeTZiMWhhSWVkcDc2VzVvd1ZGRG93K3ZlYXcr?=
	=?utf-8?B?dUhMY3BVejFrNGVTRHR0QUxzMlBXNXVrU3FyKzFxcEViUnV3LzNlcmFlTXN1?=
	=?utf-8?B?L2hPd25YUkE1dVlQRkF5L1dSS3hYazZ4amdKbzlUMnZ5d0lpT2FwSnZJZmlS?=
	=?utf-8?B?ek04RjJmVEwxR1pRdGhZWXRBUnRuNUMrTVFHa0xBWkFUUVBESWxDbXJybFc0?=
	=?utf-8?B?NmttNkMzbDJKdzArenZSWk1jRkVmZVJWeEF6L1Y4UVNwZUFCcDZac2dDUHBt?=
	=?utf-8?B?dTFnRy9jeHoxcWlZZWVIUnJoTXBwM09RcG9QK29nWVNwWjBtU2NsaWtLc0dI?=
	=?utf-8?B?Q1JJSUIyb0gwaGp2TGlEejQ5ZGhtT1RtdE4rTm02c2k3ZjdTWXp0blp2TVlL?=
	=?utf-8?B?NVNIeFF1TXNZNVp3S0x1TXptM2VDN3o2bHNINVFvOVM3aXhsQXRLT21rUCt2?=
	=?utf-8?B?NUh3UlRkZjV4MThCNXFsRW1UTzRPaVcwS0NEc0NqTW5kQU8rdDNiVWhjOTU3?=
	=?utf-8?B?ZE0xOFd0cHIzbUsxcUFmdDdIOUdqblJ4U0RKM3lxaHBOV3Y5d2RjSUZKK1RQ?=
	=?utf-8?B?K0dISlBEM3FnWFdYN3VGdXhLNnU3QUtERjNDMVR4ZHFyb1lkNUxzci8wdGs1?=
	=?utf-8?B?dEhwR3hWdFBvVWJ5UWNlT3huT2pYemFvRXlNUkMrQnVpa0xyckxsa2o0VDhX?=
	=?utf-8?B?VlEvWm0xT2ZLbERNeUwzQU55dmY4K09BeVRhVGJEMVF3NzZqMmpxTTlLVWk1?=
	=?utf-8?B?TWkzd1FxQjdGbHhXSU5RSzVERktybmdUYU5vbVRQVDdlMkVWcnQ5SENUM0dY?=
	=?utf-8?B?UjZBMGd0RC81VlUvQVRUbVlFcWU0MUMxclhDak5XK29OQlVOU2tRVkxDb1pk?=
	=?utf-8?B?RnJTUDcwSVQ5UVQ2R2tCYWRBOWhZTG1mZ09ER2ozSnVCdTlXbmlZZXlJUHZM?=
	=?utf-8?B?MEdhTHFwTHdGMkJyYkhYVEQzT0FZMDBTNFhOd3ZXcHhxSVo2YmFwbWNraVlQ?=
	=?utf-8?B?TEZibzFxRFpRZzVPNEhtMEkwYUI5TUFwSDlEdXlMWm1jWHB5Z1V0ajAvcmpm?=
	=?utf-8?Q?uJRULaV5Qjx7017/OYxtDK2ieNU2ZVAP0pLC0=3D?=
X-Microsoft-Antispam-Message-Info: gK5oB9f4iL7KjzIHFedemfxbSj4/LCtiFM2UBNqQH6bxN/O3s2vZWAr6iRoQM7VwPbkdPfNQxo+VgJmYdC+g70jHodaITPwQZhPcSd7rDEtIj/V1cclDGaNxsMk2uGDMe0gdSoZmXTA/gXb8c1ya4ywavv/IRwBaRSrkKO4LgAWW3DviW8HekMPWA4tn50kUZFrdkHnR3ItPv4QhUQ5ojWSwlDWxVekdB4qmTgNWPfgW+0k/2jzy9jW4lYnl1VIns9yEAINAx6aGOJqQY9YL0igke4fmdklvQ0q7JZKcWMVkPv2jvefhaSjSxKCBQ4P7wAkmeA/+CycGnZyZfaxKYDfXj6zRYtwGsqiHMngoj+8=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:gyjkp+L3Wn40rtVv7vjp8IUFOhgsISotuoMGLDEgKAu8GBDxQub0wK/pCwp3Db7NfhHb6cpqJPer5gXOH+IY1068b45LvI+9DVqvcgVUue27AejtnF9ayox5mlVW/ctvkoxFEvdTkplcfrwiTmFl176klY6H0yw2DSCtKY3k/ouwvK+cFSRSk1lc57G50hTCGe3y0i0ciGlO0iarQy21s2jxD1tiI5zJsFRuRFLzEGdCoTxJK6sw5XAx+i0oG3SukU0Fm8O4YWXZZimpARacyTef6oORtSnYYZmmUqUE9PtvtJnkc6hR9wJ7f4y/6zR41zozV+nnAMwXhX5azSxTS+W8++ate4sAq+xV05ItAN46w9e0j8PJp5ukdl4KDUZ9eFkDt8Pb177Ed3uBw9MmapQRHJNvj8a7dmzB4GBHfOex7bQxnzO/DFJM1RkeVUbqDr+vbZ+9T6p5tEokkFA7Fw==;
	5:m1yju0GaxXFFktQFtaEmNN/9SO1Ohc5HLKwLApzBhg93yg/TDUR4gyP/sw+6yybVX8ro0SStM3JbIeheGCzboX0AQcFH/E6eGeuRScsUAy52Rw5VruIO1MD0LExzdKdiva3B/L8lLUZdf4RPUMZDtTgaeFfCu2w9tFR0tHG0C+Y=;
	7:GMrlvMkIK/3Zdm77dVuEhPNE3kud2u23nJlPmqKZZt5i6k4uFazegsHzYtszm0ul9greYewdV3szsl0U5U52/2SuMO9qbC3NZC4No7gtIluq0XRxE3qBm1ZtMafK1uwiHP+CM46z1lF5ukxefF/8YkxfvpFDYI2r3rvAZV8gNDB8L2LgfAtKTn5PvURCcs4BV8U4GFKG1DuEFPA1g8mqFDscQE4M2UpcwJ/Pg7/Ij2rDldmKygv5IeypJPSnpvHt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:39.8144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff1438-7ad2-436f-3054-08d5f0b30ff5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 1/9] fetch2/git: add tests to verify naming of download directories
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
X-List-Received-Date: Mon, 23 Jul 2018 21:17:36 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mapping of the URLs to the local directory is not obvious. For easier
understanding, we add this tests to explicit showing the mapping.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/tests/fetch.py | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4af0ac55..5bce1bf8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -463,6 +463,58 @@ class MirrorUriTest(FetcherTest):
                                 'https://BBBB/B/B/B/bitbake/bitbake-1.0.tar.gz',
                                 'http://AAAA/A/A/A/B/B/bitbake/bitbake-1.0.tar.gz'])
 
+
+class GitDownloadDirectoryNamingTest(FetcherTest):
+    def setUp(self):
+        super(GitDownloadDirectoryNamingTest, self).setUp()
+        self.__recipe_url = "git://git.openembedded.org/bitbake"
+        self.__recipe_dir = "git.openembedded.org.bitbake"
+        self.__mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.__mirror_dir = "github.com.openembedded.bitbake.git"
+
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
+        self.d.setVar("PREMIRRORS", self.__recipe_url + " " + self.__mirror_url + " \n")
+
+    @skipIfNoNetwork()
+    def test_that_directory_is_named_after_recipe_url_when_no_mirroring_is_used(self):
+        fetcher = bb.fetch.Fetch([self.__mirror_url], self.d)
+
+        fetcher.download()
+
+        dir = os.listdir(self.dldir + "/git2")
+        self.assertIn(self.__mirror_dir, dir)
+
+    @skipIfNoNetwork()
+    def test_that_directory_exists_for_mirrored_url_and_recipe_url_when_mirroring_is_used(self):
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        dir = os.listdir(self.dldir + "/git2")
+        self.assertIn(self.__mirror_dir, dir)
+        self.assertIn(self.__recipe_dir, dir)
+
+    @skipIfNoNetwork()
+    def test_that_recipe_directory_is_link_to_mirrored_directory_when_mirroring_is_used(self):
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        path = os.readlink(self.dldir + "/git2/" + self.__recipe_dir)
+        self.assertTrue(path.endswith("/" + self.__mirror_dir))
+
+    @skipIfNoNetwork()
+    def test_that_recipe_directory_is_link_to_mirrored_directory_when_mirroring_is_used_and_the_mirrored_directory_already_exists(self):
+        fetcher = bb.fetch.Fetch([self.__mirror_url], self.d)
+        fetcher.download()
+        fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
+
+        fetcher.download()
+
+        path = os.readlink(self.dldir + "/git2/" + self.__recipe_dir)
+        self.assertTrue(path.endswith("/" + self.__mirror_dir))
+
+
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
         def touch(fn):
-- 
2.18.0


