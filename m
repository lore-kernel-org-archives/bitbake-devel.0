Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
	by mail.openembedded.org (Postfix) with ESMTP id 9ACEC74F9D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7v+IFJYR869wYZslbtPOSwdgMgrJ+hXn86kKKFt48Sc=;
	b=aKTkTkKpnrhep51Vm296zQHoSpCdDnih3TJs3tLC/oRZzidDI6voWpXzpNm/ebVLa0HAObqD7zxO/qBsnPSETB3zwr8iDzrbSmWwNPuZDsH6COh31n/dFO4R6E4QUDj6cDtiSFhNEMe76XQscNMQRVoj7Cwl659aCgYoPDNJL4A=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:42 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:55 +0200
Message-Id: <20180723154259.9076-6-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8571321-5d92-4044-093d-08d5f0b311b3
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:8Jme7UHmbUno0rCFXHDp5rsEKRDuAELrPBCKA4TrmiDRj6Rz12exUuvGrcMimLL5VEUAznC3rnUf3Lh+T55Zyldo7TTU+pOp6X+Fute+2sKCRSfrV4Q+UxNTCEvEIjm2ybadE6qSCO1jSiXb70uD5Wp4L+GiSpm7atVh8gNqLHhMUHA1qpZjQ57ft1heLoVjbYOxVmptEJcDFcocPUO2IHlvKfFAKfIaQfpBK8CAuW9CB58siUfvW24PxGBb2gqJ;
	25:4YRQ7K5x5qEc9ZItfNg6rSFokmROY7Wj3d1wnFP8w+IKboo7ZnfqIzsLEB2NfVqdzlIzpG8UnKehD25BFkl6hOaa/ftpYWULcSZeoSvA5GkL+DFy0gEYRu+ZpTKuzapP97JHMbiK1b3+Iu2Z0D2RNfxKZ1Lz72LJK3S2V9MhgKAOdlykCYKHkPXT/Cy6V9jLQhHvo1tDRKd0F6ScjjEFbuccz+WtckOFNXKXjXlj/EV5j9KkVD7Uj93VRJIigJTTEb6r4GcNCKh756OQFiOUcA2bnPyS+LWbngxVseInWny1lWiucVqICqqzG4yyN7xU5VllL/dsA/wP/iYH/vVpBg==;
	31:Jiq2KvNNb9xxv3gPs1F10NudRPrEKKanYxz7MN0AMcYhL4+aGK/zrC3tcKuWSXvHvbb3US2xoS6ivUncbhwjIC2RGU2x6+A0H6SFmXsOFvOyTwR2W+BInEpCC5TY8Yj9VK7XBKhakLaaJHUmenCktWuR2FOg9KhR0meYgZtswpYgpgdt5aFLwnVp6X0xk7OPsadR2sG9fuLSYuFMmR9f8UVWsopYZB2KrpifW9CvBRw=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB38274D937B8406ABB9CCC6C78F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:az9QASr6LkwZP9G/eDZhsFBq/IZvgXMMY69CR7eIA6xD6UrvdXbZSqFZyKQV0Qn0xtrZRTYdq7SUJypxfLCRiZWY3vDwSL52sFNOMRR1UgBd9P+pdXtVArNcerfN3iWlo062Z5vHcW++YM3g36zb7BQ22aaxX/dGFZ10OWUypuOUAZzh/ezTtvTyzngEGfeUjMe7ydhAn1TorEeb1H902kao94wQt6zDoyo+vp0xu/JqTbSm7k0IixppY0R40H1RHEpZdtVL15mX1gJRFJg2JYx/DUixPoMokB77Pefauq4TDZkR5eRMZdj5Cxba5xrc4i9wr8RNXl3KYtmFqC5xfU94Kq5va7Z886eV4kuucsFSIBQaDdvih6iupTJ9eGUF
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(575784001)(81166006)(16526019)(186003)(11346002)(446003)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOjh3RGd2Nm5KWG5sQmsvMXpyR3NOOXdEN2dx?=
	=?utf-8?B?VjRacWlQZVVxMDMrYkNnUFFralE5UzlTaUNieEc4VklkSE5sY3hIaVRpS1Jz?=
	=?utf-8?B?dGlNWDNxL251ZHlYVGJmSEVXY1JTZjB0cjFWUkVnRGcwbzVqSkFBcU1hRjA5?=
	=?utf-8?B?WEk2RzJZd1h5RUxtdXNrQTUySUxzanBxOEJPdmthaVc0Q0ZuT3IrZG92NDNU?=
	=?utf-8?B?Vk05cnBNMUYrK3ppV2VBeDJDTHlxZVduNGRBSjJPeUdhNVBxbE1xa3Y3cTVE?=
	=?utf-8?B?RVdOMGp0M3FUcEFKbzViVXdqbVFSY0pCZjZ6V0VsTVZCeHRxRVBBQWxvT2U5?=
	=?utf-8?B?U2Z3RXRrVFJqNEZmSEw0akZwOFo4ZXczdmxDcmx5S0t2eko4VHVwWDJ6U3oz?=
	=?utf-8?B?RDcvV1Z1eThuOXBWV3VSZ0ptK3hsUVJsVE9aTEZMZDdRMVdqaU1LNXFyc0gw?=
	=?utf-8?B?TXZLakthSkV4bmVHTGxnV293S1hPZzNmM0U0Z3pqYWpEUTFDNThKKy9KNHFp?=
	=?utf-8?B?R2VwaUdKc2ZWb2xWN2s0elRjTVBPektaWXN4M2Nld1ZsMlpLZDJ4Rjh4M3N6?=
	=?utf-8?B?ZUttWWM1TmhzeHJHbGFmMXIyYnJ2QXIyMFRyZno0aU9IQWJVR1pFamJLc1cz?=
	=?utf-8?B?MW9kN0hNWjVIektzdmtFZWFKaHhGR3Z4aVZSUWFGWDNMU250T2dJOE1iaEkw?=
	=?utf-8?B?RTl3V3MySm1scExKNG5XUkNQL0toY1VVSmYrNm1nMlV6Z0R4MkVpTmQwb041?=
	=?utf-8?B?WGxGWEwrQ04rMWFWYkdaNUppKzlKQ0NIdEpGazFqTkMzQzd6cG5GZDA3SlEy?=
	=?utf-8?B?M1k2MWJWU0dHNTN1U096RG1DVkpwaUdFS3NpSUJ0UVlqVk9aNEZ2dVRqWVBG?=
	=?utf-8?B?VndQRXhLUWd3WGUvMGZqeVVQNVNnWkVBV0hyTVMzMC9NWU9NdmZCYk12NHdI?=
	=?utf-8?B?VkoxVEZYZ1NiS0Mrc0orZE1QNE02bDczcU9MSTRXbGdjaCtJR0NoWHJSTFIz?=
	=?utf-8?B?aGVWbVJkTHNsS0NMM1hOZGF2MkJ5azF5a1AyK1A2OEhQZ3pyZ0ZxNWRWWmtH?=
	=?utf-8?B?ZzB3MG1KWDlxMUQxbXFpNWdNWXNDc1BqSHhJSXJSWWE3cHNuMG1ta0pJZDQ2?=
	=?utf-8?B?Q0E4NFNzT1ZYWURBNTlHNFJMNzNpOHFaU3ByOGRzcDhKa2F3dnczNlErRDVy?=
	=?utf-8?B?VEFjc0JON3FLeVVrcXVrcFFGa1Baek9qaURYL0RyQ1hKNmhFMFRzN0hWY1hX?=
	=?utf-8?B?MXIya0hVWCtnKzlBbHRZNVNNVWF5T2RSV25CdXRlcXlyZ1F2aEhkOW5ITFJr?=
	=?utf-8?B?VTNHeUp1K2ZkV2FJSE95bU1FejNaMUkrSnljVUYyY1U1TEMrTllWMGxna0Vz?=
	=?utf-8?B?VTdxUHoyaGxLbzlCTDVrVzl1dm9wUzV2RUUyQU4wWHlSanJSYnlXQU1Ndm5V?=
	=?utf-8?B?YUVxbVBSZklQVUFVT25WNFRwNXE4ajFLVzFlQW51V0xzUFVQUlduVUx0c2Qz?=
	=?utf-8?B?NEtUSE5FNXFzekpWakYwMVRRZXlmdFFRc29mbGZEUGVkcFVmdWxEazNsYmdr?=
	=?utf-8?B?VkYxZUc2eURueGpMZGZQOGVYWUxUUWloMjBGSkhSSVE5b3pwL1ZYQThJT2hE?=
	=?utf-8?B?SVhkRjJMZXJzamtHaDBBdTh6M1JnTFZBM0dSTmhHS1Z1WTdjM3RkVUM0ckND?=
	=?utf-8?B?K08vZ0FScjkva2tEM0VkL0VpN0c5dzBDMm5DWGV2Wm4vZDdIUlY0V3lqUGRr?=
	=?utf-8?B?MEFseXdNak9WN0MvWlBFUT09?=
X-Microsoft-Antispam-Message-Info: wLTXH8AJs5WXfvfRIIfJBlVob2iI7kqLROwAs5k7igiajcmTgYapNx+qo42km/0QF7BRs7DTqgD9fZ2gS7y7wry1awFSp77B2EQOFsxaxkNGzaLUfcKFyCYk5RT1b2z63h9dbseeie4SESEYnsavnyndcuuTKDogRPYFnHoEZUpZXeVjTtkk7i7ihM11aoDTtg1cA0lVFSwD7rjJUbAOA2gPNYjZeoPMK0YCOjR3hupFL9EnD76Kxyu4MKuPYh+rtyS/4vKOyArrqpCCQj4XMLqDuqu6ReBJQsP12ojfVZeA7k0rIntlkSkLFaduMFqq57bt5MDa7R+YiZkJsC7sEA==
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:lHhjGS2hUsIir6eDtgzWQHz+mJ4OPyK0DEl3A+bxmJBGVmTvSmtZvrcuACLUPUW+Bf8a2UkpT0N9Zf6aRZGJIw0hGZdvIpWj7FFHwn/sszlmmrxdcI5YinIOLIYTcyVQO4mRTNSsreuJ3dVatj6JQDmWqBFFPMSH3YBO7hHSFOG7K7gGkBMnfLVU2NvkeV5vXVwmv2tRD2g0WIopOWI+ysmvU4Tm2qc7zQwyhbqxyGcYMznUp4qXY7AX8r4QAEWgN43LSGZitNSTcv/HAHQH70aIdEsayqGMdNRI3X4P0YyOAHD8WlHvKivwAOuoeS3zpY3J6PHwkDnOgT8L5EEqgEgqBGNIF2wfYt8v/hnwl/1Ql03I9FjQHCkaXqiqJQJxW/hbYHsH05gvfKi2yhqi4SUok06Hm/sbceQbl+ZYmiywRo8c9HPo5ioIIb3nIhlc0bORuBFiueg04HmVer5ngw==;
	5:lXJRG6gZQf3i2ATI0qO9xOYERl6qya9rK5l1zuiXewFvoJpNfsIf2UE5Ty89OKH8MlcVyDfrZakjdvHhhz5PS+kRcDThz8pJ8A+iTOeDBCdbq4OdfqD2zbkKl38WFGtafqGcusWyBZflZUuPKpdbiSLUZwqe5UL8fT30kNRGUH0=;
	7:CwMl1AqODOlHwv3XNpOb6QpDGMKM1N2oTe43LrZgLy8/JAfcwAVcT8LAv9lVlDOcLl4fZf+dxK/49z5p/MgcgaSxoJTxAnvzdoo9zRPWS5wry0HtGLM7OTkqbi5vs74EJff4H9waIIc2Y77y7USfO8sMj5tBc+WiXXQq1CYbBj2J0YjG1QUX2qkM3h/e8oHwKGtwqr5jksNHJeIr7HVGH1GOkiVnOG4viv6+s7PfKxtYTiJ8rEczmkZBLT+nL+WL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:42.7363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8571321-5d92-4044-093d-08d5f0b311b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 5/9] fetch2/git: throw error when no up to date sources were found during unpack
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
X-List-Received-Date: Mon, 23 Jul 2018 20:18:06 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check if the fullshallow tarball exists before unpacking it. If no
source to unpack is found, an error is thrown. The readability of the
logic to decide which source should be used is increased.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/git.py  |  6 ++++--
 lib/bb/tests/fetch.py | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 3364bbf9..13b9b9d8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -477,11 +477,13 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        if ud.shallow and not self.__has_up_to_date_clonedir(ud, d):
+        if self.__has_up_to_date_clonedir(ud, d):
+            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+        elif ud.shallow and os.path.exists(ud.fullshallow):
             bb.utils.mkdirhier(destdir)
             runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
         else:
-            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            bb.fatal("no up to date source found")
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 83cc4f6c..fedc3b73 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -28,6 +28,7 @@ import os
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
+from bb.tests.logrecord import LogRecord, logContains
 
 def skipIfNoNetwork():
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
@@ -1678,3 +1679,29 @@ class GitShallowTest(FetcherTest):
         self.assertNotEqual(orig_revs, revs)
         self.assertRefs(['master', 'origin/master'])
         self.assertRevCount(orig_revs - 1758)
+
+    def test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist(self):
+        self.add_empty_file('a')
+        fetcher, ud = self.fetch()
+        bb.utils.remove(self.gitdir, recurse=True)
+        bb.utils.remove(self.dldir, recurse=True)
+
+        with LogRecord() as logs:
+            with self.assertRaises(Exception) as context:
+                fetcher.unpack(self.d.getVar('WORKDIR'))
+
+            self.assertTrue(logContains("no up to date source found", logs))
+
+    @skipIfNoNetwork()
+    def test_that_unpack_does_work_when_using_git_shallow_tarball_and_mirror_rewrite_rules(self):
+        self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0')
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
+        self.d.setVar('PREMIRRORS', 'git://git.yoctoproject.org/.* git://git.yoctoproject.org/git/PATH;protocol=https \n')
+
+        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        dir = os.listdir(self.unpackdir + "/git/")
+        self.assertIn("fstests.doap", dir)
-- 
2.18.0


