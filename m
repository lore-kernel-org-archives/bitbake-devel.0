Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
	by mail.openembedded.org (Postfix) with ESMTP id E1C7074F4B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FBIPDIrY+EsBk2lwmQ1NHCy4Mi4Bpbknk9VJObjV7Ac=;
	b=sSjUhtkWNHIJMEylcuEHWF7PlCZFOpH9BAih9/fq9xcSsf7YZEHwcss28aekHxh8ZdVLE5+XfYrzMOKe6vucA57R5uoxdjSxmnnnKMGTBk2XRCKQYfGAWGWv6/rnilnfvrKPwkR/CmFP0VNy31F2Op6ry7QICr2IC+AOrlg/KTI=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:45 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:59 +0200
Message-Id: <20180723154259.9076-10-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eafe932-9932-4bf0-e0a9-08d5f0b3138f
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:2eRgpiFLmwn4X1wbbnQzwX2FwA5OoJf/RitMwVYX8suvWaQpA3rxKCuu0K4wfI3xkfP++K/MVmPSPc1AenJvkxI2cgBPY/JxDF8srGtz6TAsmhzJXQbXKgp94Yh7ym0U61fmLOnBBE2EKiBGrq/cYTVyii1d0YbncK6QBzzQfuPL+BlnjXwbxHI5MkEsTnUwrFs50/egRWqkHAom5Qy+Zkh7J1+qR5Eh/Eb6Xgvk8vcbuIaZjCwmKNhPktQjEJBn;
	25:QjV+Q0a+ls8UR5MeLpJdWn1tS7O1tqVEV7eDy4rjMoEPqfqrH19gYP1qesl0u1BTEUevOhLCl0eMlWDxQPY2QspFtsG3g14ARxmVfQLTgEXUfcpexyi559+nPtUH5uUCxYOimw5l80l2hhHfVXnyaASHUW15ES8vuiV/OJgkyO1F6v5+ZogLNvlPUdNt0W1v+0URxRjC2xsrAaqALXfxrXwJosgkb/OhTuKJrlJvSToVLCtIGOLoivZ4vm6Qi35tgabxoMrD2EJ6Uic9QzBuaDiq1nmsYr4gB5C+hzC3c01oIx9Tf1YK7MgrXOBw6C6assYgmPTPBvhK+VNbMpWDVw==;
	31:c/hv3Y79WrDaWrrW44k9a8aN8FU3Xbig24+DABq03N9ilZaEPZoJMVpinQPwwLLolnM+5LKklGTm9ZfV+GY//7dyjLaCECgv3gF1a9Nb+0XHQzBoKRyhjIr6EhXkjNdgrIxf2TmUqc4TEZrTuqQ7b5MiNTMtcMvSYyA1snYtxDaJ5vXJmpiBU0repKff9hpe9vr8d9TJ3wibFYftxsxgb2S2aZV+Sz06LciQaBh9ZhQ=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB382705DA1D39E9AF807500B08F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(166708455590820)(126837547833334)(33711482430040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:IlOrE/g3qO8Wdr3Y1/zaGNhrYZ58GitxLZSlBNUWO10Xkkj3caiQ4lZ4oJ/FV/bg/vSfgwwi4hY/ibWvgMD1xgSzew10j78Qcc5QKtmeCRWFCzHq8gzMGky5IaE754LzADtiG7mPq47saolhArCuahBwClKb+RuWw/xgevxbUDiG1I8+Oy4fE3idUyL0/GuowsbcGDJ9eaQfBsjGZhb4URqF3buHbXh69oNrdQ1SMPMlmz0UOr7Xpcur4P92QEaz7OHMAPsJ7MKo/evCidyIZKWJIABf3VbEt6nlQ/uZM80cCvahimLpKN2X9SCAT1NM97kAWyU1XHGSM9TqXY0P7L/9hUfz6Srg0FDW4lD1IbwELpZHz0kSvA2PpeNyOzjNB/6y8MHUFNX+gEO2qHwoGqTyPO7kZK/Vu/YBjK/ZEMM=
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(575784001)(81166006)(16526019)(186003)(11346002)(446003)(14444005)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOklKMGx6aGwza0Rxa1htMEdiNFMyczU4Mnkz?=
	=?utf-8?B?SE83ZVd6Y3duRk9FanZtSVJhb28vMU53N0JJUXZzZk5GdkRBSjRrSlM5Q085?=
	=?utf-8?B?VTA5bkJNS2JPL3dKRTF2VTZrV1YyWUNET2RmQmpZR3VRODJDZVZrMWtpYzlW?=
	=?utf-8?B?bGU1bFE1WUZDWGNnL3hhcWlvaHNtaDFuV1ozOWZtQTE0QWg1NmpRZU1NWjRo?=
	=?utf-8?B?VG9HRGRWQ2FBTXcwaEdjcVNGVWU4K3V1eHdsY0h3NmxjY1NVQVc1b1lxMERM?=
	=?utf-8?B?TTNXN3A5WVRQQjhJcXB2YTkvR2RqYXg2RDB5QzVTenUyVUh5WUdiZlVlMk1n?=
	=?utf-8?B?OUxpcHNyTDdqcFljQ251VU9UYmRqZ3FYeFVPa3REdTRYQWhENmMwQjAvNHZo?=
	=?utf-8?B?UFF4RnVnZnBsMWhVYlVaUzJHQlQzWjBheUNZL3ZLSkFWVUtHaFJmbVF4RTJt?=
	=?utf-8?B?dW5mY0tlclJVYmQ4L3gwTnhCanVGUW91MDgzeVVEK0dIeGV6UjNvbjdubTZ2?=
	=?utf-8?B?ek5SUHFXaXNLOGlLdE80bVozcEFld2oySXhaK2F0bitWdGYrOVljQ3ZVeFFo?=
	=?utf-8?B?MUtMb2pVbmU3T1ZSMEVWdlZGZWxNZFZLckpSZTkzQUJHaUZjM1BIL1JwbXBp?=
	=?utf-8?B?RnNWMGxOZUxqbHpxSzlybTRMYnYzZzNWeStBbXJzUTdoQzFHeVU1VmUvd3BB?=
	=?utf-8?B?ckFZaFlFQXNaY1lqUXF6R2xwT0JKa0hlTG56ZElWc3ZPSlNYY1dtK0VwNEJM?=
	=?utf-8?B?RVdTS3N6SG10RUc5VG5YSUpEWVZTWUh3VEd3T3FDUXQrQU91U24xbk5WNmJW?=
	=?utf-8?B?UllxcG5DcVFpSzVrMkhPU0lVVEFYZUdFWnR6MVdrTytmRlY4UkIyVHBNOWEv?=
	=?utf-8?B?U0dyMCtJR2xnWlZxRkQ2YktXVlJZTHQ0VFdWb0dLUUFJWjBHVzI4RDBudmFZ?=
	=?utf-8?B?MjRYdU1rdFppNHNIbXo5QlBTU1VZRjl4aCt0eFVTaEdZVkRKV1FUamJCZXBX?=
	=?utf-8?B?cm93UmtOdUZoUUYwWDllcGUyYUNXZDc1cWZLUXN3UWFvY2wyQlV3QmpXTnJM?=
	=?utf-8?B?OStvMERoRElXUGlSWEYva2ZLUU1haXNPU3pZWXdLRkpGR1NxN3dDZXdwU2p6?=
	=?utf-8?B?R1V2MWN3Q0Y0ejVmTnJXWHhtUG5DaXlHampLZG92UDU1QzVGc3g1SU9ZbHQx?=
	=?utf-8?B?TUpvMjcrOTNKMk1talkyVHBVbktEajMvYnluT25mWHU3R2hEZTJUSHJ6UldU?=
	=?utf-8?B?RWs2bkdoQnNqbVdmOG1IZ21xcXAzU3JVdmplY0I2VmVtQ050V2FMOWNFeTVZ?=
	=?utf-8?B?dzc5bGhtb1JGWmhwNFNReS9leE1DeE42Z0ozQzBFeThWT2ZSb0RSR1JVcE5H?=
	=?utf-8?B?OEt6Z0p1SkVjL0NEN25TWlEweEx4bjJBTmRLeEtYbXhhNER4ZjhZbC9jaVpp?=
	=?utf-8?B?WnUxVWhYZ3ZvY3kzTDNJdElmck5Jd1lGUDZIZk13VCtCZFRxWDE5RExZUUVW?=
	=?utf-8?B?R2tkL08vcTlJNmxTckdMcC9ONVZ6WWJrM1pxbzEwRC83MXhiNVhBSlh2TEdD?=
	=?utf-8?B?WG5SU2t0RzdTVDhzUlI2Y3lXeXdleWsyWDhBQjZFemFHbTNVTTJXWUtaSHU0?=
	=?utf-8?B?Z1k4YUw0RllMQWxMYmdkdFVtMUR6d3JkcFZXWnBrdUxQbXRLUGhxVUtyb2dk?=
	=?utf-8?B?QjY0a1I1UEdkWlUxeHN1L0hEcTZGaXdsbytwUkxlV2NETEFpWWFXY25xZE9X?=
	=?utf-8?Q?T2iNRNwoS+Yya4NPcHuigkqBZMT3J8Y87SK1E=3D?=
X-Microsoft-Antispam-Message-Info: FNKU4htXdb5gztSlsm2QZI8ZADiCKaW+CyyRxbdWVD3YqsMz7egiKkszT9rIIaEAAhGMvvtnxcEixgHbx06/01pYt32vk7zmJlatlW0ijpZjFYIJiFpMZlqkpiC/p+WXqNKmxVIerjJiG0diOehvL1HfB3LVYmsfiEWvgzaNoaePSJaT97cyjL3A+UL7hVYrnodCXItsvraRjsvzUWIlRvzidJDy5/geJz4KrHvS/4sexbgGxExQ7A0uSRky7LH63c5cZbY9uUZXbvZYq3IKnEXFkNhzs1EDOnmwj4RCS/l8uYp3wh9oL0ae51+YCjldn0g9y6eDkmg2otRR8Yaqo+WpQVXHS1Xdh/wP6FxWd0M=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:UE49C5Nhaq0s31zL3Zxfza/QMz2KRH/eb+L0f67rEDmB+KZBRkkjvUeF/fOy80Z5fbFX2sm/9Vuz1RgshwqIjodGEMi3gaWBPUs1oUW0YDrPohUNorGbCNR3ZsJb5pCz67VbID7S/+Vs21V2GcGFeNuBK1NxOgKSp6mmp/Vozc+TrVri3OpZ/QtMj7gYjZQuswHJseQzlR0nBYPevR7Zxi2H4I3czCuJnR4sU2BfOAy6+722aMRVG4PktnRYGJm/piOtdtPp//vkDhoj79WyhKdTtLafi1pSqF9xggbqPYJcXWfYjr0mJFhfRK3IHW0o6PJ42HyZFWUtDjZMk9uRjHmgs6A22h5tR9Ua0kNXxPeTZDdipY//RFqYm8McZhts9kQedx/DL4E61d1REXQXlMrKkkzyPf0i/3qbc/kIqvVCnKela75KFQ0PJAvZYwIH1Sa17dYYdstKCUrOM1Gajg==;
	5:KzNEZjljQD7ak7gtZdiGdbFS5w0U17VNf37v+EuMhOAn+MYkCYEZ5n70zQnslEI7eUgJlQGWNHwPf8/yCfZMjQzaQh6MaoZJChvpJD7w9I5AsrjOs4NEDCvTO/jUQZ1LwOUAbaP2ANca/i8Suf2xf9rCwxQUHtTtnVeBaFAE5Fk=;
	7:diPYiaKXpgoPQ6t7Uk2372o/SjyeBBW3B+MMX03/xcBfnirqEkho5UIv41W1zEFuXsbsiT7lD05tIPuzOmhPtYRwT5Mc3Pi87JQJTDLuiaIGLPF4VRO5ErBsft+hrxrtE2zPX51S0421wKIe8k4x0nLBd3KKBviXnLBdDWzn/64/kSvmuJyCv5YyjCqrIQEkEiSEuQuSoR7YcLPrqm847YiAdGTUVdtF/6jhV8u4kES96ZbzTmwBgE25LpLrulH4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:45.8614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eafe932-9932-4bf0-e0a9-08d5f0b3138f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 9/9] fetch2/git: name the shallow tarball according to the url specified in the recipe rather than the mirrored url
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
X-List-Received-Date: Mon, 23 Jul 2018 20:18:05 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unpacking a git shallow tarball does not work when using mirror rewrite
rules that alter the path of the remote url. With this patch we always
use to remote url from the recipe to generate the local shallow tarball
name.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/git.py  |  7 +++++--
 lib/bb/tests/fetch.py | 26 ++++++++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f9e31d2b..c1fec614 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -79,7 +79,7 @@ import subprocess
 import tempfile
 import bb
 import bb.progress
-from   bb.fetch2 import FetchMethod
+from   bb.fetch2 import FetchMethod, decodeurl
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
@@ -259,7 +259,10 @@ class Git(FetchMethod):
         ud.fullmirror = os.path.join(dl_dir, mirrortarball)
         ud.mirrortarballs = [mirrortarball]
         if ud.shallow:
-            tarballname = gitsrcname
+            _, original_host, original_path, _, _, _ = decodeurl(d.expand(original_url))
+            tarballname = self.__build_git_source_name(original_host, original_path, ud.rebaseable, ud.names,
+                                                       ud.revisions)
+
             if ud.bareclone:
                 tarballname = "%s_bare" % tarballname
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index fedc3b73..6b7df874 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -522,7 +522,6 @@ class GitShallowTarballNamingTest(FetcherTest):
         self.__recipe_url = "git://git.openembedded.org/bitbake"
         self.__recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
         self.__mirror_url = "git://github.com/openembedded/bitbake.git"
-        self.__mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
@@ -532,7 +531,7 @@ class GitShallowTarballNamingTest(FetcherTest):
         self.d.setVar("PREMIRRORS", self.__recipe_url + " " + self.__mirror_url + " \n")
 
     @skipIfNoNetwork()
-    def test_that_the_tarball_is_named_after_recipe_url_when_no_mirroring_is_used(self):
+    def test_that_the_recipe_tarball_is_created_when_no_mirroring_is_used(self):
         fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
 
         fetcher.download()
@@ -541,17 +540,17 @@ class GitShallowTarballNamingTest(FetcherTest):
         self.assertIn(self.__recipe_tarball, dir)
 
     @skipIfNoNetwork()
-    def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(self):
+    def test_that_the_recipe_tarball_is_created_when_mirroring_is_used(self):
         self.__setup_mirror_rewrite()
         fetcher = bb.fetch.Fetch([self.__recipe_url], self.d)
 
         fetcher.download()
 
         dir = os.listdir(self.dldir)
-        self.assertIn(self.__mirror_tarball, dir)
+        self.assertIn(self.__recipe_tarball, dir)
 
     @skipIfNoNetwork()
-    def test_that_the_mirror_tarball_still_exists_when_mirroring_is_used_and_the_mirrored_tarball_already_exists(self):
+    def test_that_the_recipe_tarball_is_created_when_mirroring_is_used_and_the_mirrored_tarball_already_exists(self):
         self.__setup_mirror_rewrite()
         fetcher = bb.fetch.Fetch([self.__mirror_url], self.d)
         fetcher.download()
@@ -562,7 +561,7 @@ class GitShallowTarballNamingTest(FetcherTest):
         fetcher.download()
 
         dir = os.listdir(self.dldir)
-        self.assertIn(self.__mirror_tarball, dir)
+        self.assertIn(self.__recipe_tarball, dir)
 
 
 class FetcherLocalTest(FetcherTest):
@@ -1705,3 +1704,18 @@ class GitShallowTest(FetcherTest):
 
         dir = os.listdir(self.unpackdir + "/git/")
         self.assertIn("fstests.doap", dir)
+
+    @skipIfNoNetwork()
+    def test_that_unpack_uses_the_git_shallow_tarball_when_using_mirror_rewrite_rules_and_the_git_clone_does_not_exist(self):
+        self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0')
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
+        self.d.setVar('PREMIRRORS', 'git://git.yoctoproject.org/.* git://git.yoctoproject.org/git/PATH;protocol=https \n')
+        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests"], self.d)
+        fetcher.download()
+        bb.utils.remove(self.dldir + '/git2', recurse=True)
+
+        fetcher.unpack(self.unpackdir)
+
+        dir = os.listdir(self.unpackdir + "/git/")
+        self.assertIn("fstests.doap", dir)
-- 
2.18.0


