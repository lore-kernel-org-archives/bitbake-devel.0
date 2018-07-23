Return-Path: <urs.fassler@bbv.ch>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0078.outbound.protection.outlook.com [104.47.2.78])
	by mail.openembedded.org (Postfix) with ESMTP id A19F574FF6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fnCzE95HT2Lhb7IoClgbpE3Txphet38aEa4DhCnRNeg=;
	b=BGR/mswKApVLT6YyIdOHlcnR2eZPZJ2qUs/KGRjYeMJY99mvWx30NSLzyUS9Hap2lijkJCHJB96CTWXajkFZTqPNzgDqzEpbUSyKTFHCyBHsf+RKXvI/ERoJmrDtk+K1+y2oSyL2//Bn+NIoum0kyouSfmO6T4gJ9O/6+j1i9NI=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:45 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:58 +0200
Message-Id: <20180723154259.9076-9-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d7c79a4-adc2-418a-a954-08d5f0b31337
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:KP1BjPEAFhaFIfER/6/+wBFgMzT0dUo1/jj3lDfs1+Y2wubjuZl3ns7ZFJ9WS2LWBFZor4mlWQ5wkbjUvKRjrDylx+NVCd5eh9bq9Fn4uFjBpe8sW4yvfLBF8iqbu5fSx4ovp5sFpybGMk+++hQ/jvB6ltEOh8wXr1d+CP+7V899Zamt5z5oHDITOkv1U739FlEcpbNyJhqlK5g72cwKYUq8QS2p6SH51Eg9p51rt25+aBQYp/c8iukNh8a2CfsG;
	25:wq+SpPuMx/ZzvKG2/T8nmfSw+0dbZjJe/pcQl5NxYyEvd5l03d02U51R+6qxvdpHJGban5H9mAi8IbG5cW6FLl95oeySq0tRRo4xPEASwNbR9XdhFuQz2KpFp2xS+4T6jWI/Fpwt/ZjqY7mVXN69U92OVEJUf6cgkeNMY82rPKp+CrRxQZC6P0nB2FY3S90YVGO8RYrqZ1yMgfzi/DgKGDnyhPXSJg+t2sbfbDkH3OjR1DdVnKnB/8dlwyT1/GMs5O2xQ5vBBsVIMoqt8eX+rCWxYxOQUxsr/XDPFtrpHqsEdZsFW4QByBvbLfxSQNyTvbjmudbp+yqNvNyJf7C5Hg==;
	31:jnHkMeRx5Rf6X+/Tkmi1O2zzL7NaITemTmKxbEWEapLGQ+vxY+9wc2HIWnq17V89apkMlD0nYOWTN1AWD+yunjdHjuLTeEwcZS1furnUJ/Br3k7bk8j7JjIN7HP+Ws5fdKyCnbRT4Mq0T/1gTt7LVUVyGPG0KPtHaO19Ha2rDof2yDUV8zGNFUNDw7MnIBb00igp1TpPqq3dAbI59xbYQmxMTKTu7usZGSKNPZrUYAs=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB382739E31330C476F63495B08F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(788757137089)(126837547833334)(33711482430040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:dH/9DFFPpdFs3TgFwQ3qKbPzrWovTu+Uv4brCViWlu9HAgcjR+zP9EPIThjW76Jlz3ed0VEoD+R8AfUxMGlGoJ3jjuA6d/EQiluI7Uii3ngHJfjR+s/FQx/Y39tnCASBOXLw/drj9kS98GxzjOSAVq192U7UZf+9TU0FHyOfqGgGil5CJAPZml45pXo3G0CGDKLDS+ILtILFEJGr0tuOekvU9e9RbGarzQIolyYzRbF47jLFE0Mcp3vTqvfTmKX0JQ/s4SW1sppDP5//XppUlNE2h/OXcUe+CMzRnSpoaidqDpj6oJeGSHe1+SR0r8G+fXtzxkFW29Yc9jlrDXzBusUoRZUEctJFmLQB+IX5XtuluHe+3bhIG7Fb2S4q8+QQsCN9BV1TUi3QQRKvljMjvO6ABMlZCio5gX1071pHXdg=
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(81166006)(16526019)(186003)(11346002)(446003)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOkIxN0NWejg4YVdkczFuVXdKTXJuTWVOZ2x6?=
	=?utf-8?B?MWttVjF6WnJaWHRFOThlV3pFQ3lWbkN5UFV6WXFLeC9sRWF1S21GU3hyOTRp?=
	=?utf-8?B?REcrUDRoanZvdG11OUVQM09IMlN3eHZ4WXh0WDRCVUtDYTh3TUlVZTdjaG9z?=
	=?utf-8?B?NnZQckgyUFdOSTBhY0F1bDdHcW90TXdWQ1Z6Zzc4M2k1aGk4RE5vQVRnK25i?=
	=?utf-8?B?RVZGMjJDdzM3dG5JMzVicTBQb1A1bVZjSzZVYzlqZ2tmYjZoMlhhVTdGMVA4?=
	=?utf-8?B?ZVMxckxmbmVCN0NKNjJyRFRNT2I0VUE0MWtEVUlCYml0KzRuN2hLWVowbkcy?=
	=?utf-8?B?T2U0VTRpbWtiRytManJuT3U5RC9JelBISEcvMlJoc0xFeUN4MTlWMXc1RHJS?=
	=?utf-8?B?a1NLRW40eDFKdTRiOGo0RTV5d2pGYmYrKzltc1JYR3Q5L1NweWpMTVpVNEpN?=
	=?utf-8?B?aURNZzcrVVhzU24xYTZxbHNsQzZoR1Fjc21IZk9QUEFRa0NodmpBbnE4aURw?=
	=?utf-8?B?YzhSQ2YvcDczeEZjSkZZR2xoa0M2cWF3Q3ZLSjM2dG9NRDl4VDNxTHZhQmRs?=
	=?utf-8?B?OWNNejdTOGxTUk8vNitiVWYzU0hoNWd6d0J3OU1ScXdKeVBmTzBxZ3BWbE5Z?=
	=?utf-8?B?Q2lJVUNCMTRUMUlUK0JxeWk3NHJ4YUFkM2dkakozcC9MS2ZwSTJJYUpTUERF?=
	=?utf-8?B?QW5PR1pTYkMvcTRzaVFhakV0RXZSem1hZWp2N1BzQkVQb1dHUHVBVkduZTFr?=
	=?utf-8?B?bUlubGo0Z2RmdCtwZXovRGVhUmRjbEhjb29Ydi9WSktCZ3Z0dkRBMHJFK2Ew?=
	=?utf-8?B?K1c2RnNDeGhGV3IzeXJ6VXozYjhIaVlWb01UeHdzZGFLT1ZzRUcvdkd1NHo2?=
	=?utf-8?B?QWVsY1pnTjd3bGVrTjF3NHdLY0tKbDNQZXh1MURxZVQvbWcxbjFORFJkOGRp?=
	=?utf-8?B?K050VzBBUWRWbnJqT0FmajBlK1FlSnFQSUE4NTVCT2FJeTRMdW4rSnRieDYz?=
	=?utf-8?B?a3JiYU05bzhRSEk1SUUzMm1DMmpOUG0yVVN3cnVabWs2allFazV0Q2w3KzND?=
	=?utf-8?B?cDdPQ1lVZlVxYmxYRm84N0wvK1E3Q0NqZ0FwOWo1cU8vbHBhSmNIUVdFbXI4?=
	=?utf-8?B?M0h1emExTDhLSjZVblhoVk1CSWsyNzJxWkRFTm51a0VRRnJnbmIwNzl5NWkw?=
	=?utf-8?B?cmtuRFZFR0s4b1QxZWRsS3gvbDBsc3RsMkRHam5tdjZ2Q1Z2cGFZRlpkY1Vz?=
	=?utf-8?B?RTNkWTU3WmpkYVZmZ1YzVndMU0Y5WU51dFBuY1pNUW80WFVGWnhEUXplUWQz?=
	=?utf-8?B?Q1BXKzBuVkdUNmdEUnJNVE92QzAzeTZuRFpGaW1iS3orNnZ4NVhIOFZMNmsr?=
	=?utf-8?B?a2VpU1NwRVZ1M2NvVEQxSzZWbFNKK2ZENlo2MEhzVUVCUzFpVG0yWGh4V3pS?=
	=?utf-8?B?Q3loSkx1MUExOURQRCtNWnRKMGpmZTRQaVVhdUMxOGEwbllKb1c1QXZGUUhX?=
	=?utf-8?B?TDc5TU1RYkJGMk1iRkVhWXFCWUxxU01ZQVN4QTc0V1VzVjFYTHc2eVR6RmFx?=
	=?utf-8?B?R1lJSjJxWm9peC9jbkR3V29aSlk3QkxhQjVQUEw4ZHV2SHRZa1dqUFpxRWRP?=
	=?utf-8?B?aEhqbnhXQmVlUVFpWUxna0d6RXBWVXJxd3dLOGo2VUthL0JONUlHRG5pNk5S?=
	=?utf-8?Q?2opGx0MQbEXjTw1sg2GQakIiPZig7/4EG9B/RZk?=
X-Microsoft-Antispam-Message-Info: 7aCZ/gx47VdZXgQ89qkddaBpV3X1tEwwQusYrWgpG68cQeeg2VwNphUEDXso9WADXgppKkqn56pOX5GzyG+/wkFJ5k+H/BahhhJOUNY7caxOMgzjSABT/f4LQGbzCZkHAPk5EE1OmYNPnS1mmED8ppkwokT4a3z5vXDm7LfDUFwucILumFegS9Ie+aIuCaciI/j5LNxUi7wxqTq+59RQQyTItQII1iim0LY7HwKQBdQjdErTstBOK1xiCbCPxZqGxMSqxBXr2KWNds7Dh0jMTHQgbErQTR8X9q8VZm0+tejNp3qkj4aPIzcKp/FhwjTy1JQw0nWLfVg2weXZvXdapzVL79RZ5r/geraW9Zz6gYU=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:SYvdRIfmAJJZwEbUVXuAYzkkceg7g/Qb4SDQRvktq2bH5GWKZjQNO2sJQ+HARQx83O1xr7JnP3/9Z7Ub2t6MFIoh3x/d0WHmk0znHyJfhVLuADetztKgzT5oBcLsgiEZxwFX6T8AVbah6YiwXYY7tq3re9tKowYXnX+KA3eWY+8QYP7hiQjZfJUr7Eepe8WR7XJxI/DJzNpcQWyvUWWBYFVx5sT5uB+3A4zpd2TF/fcPMvdDLyZM4PqLye7E880hQLY/r9CssiMCYo18uo94beAL1Nt6qepZy4+QFqui1wsRDbuquPo9mJ9UurW//NlnFHrrhib+u+CNBZ9q9B0T0pjPkb6cS1DPIeGYYe5S6PusinPT3blCVT44IN3esU0LI+ega/k3K3jcvpXiB01f2i1sswE22Atvbj9amd9nm7r1X8UbCOFtYxSLiSiWuIgRIiiP4hY9d+v03ZUAd0iNog==;
	5:kjv8WbNXL7YO+1X9lTQXN/TbjaBnHCi/VYw/T7slkiZ62AnaRH2KV8B4KOlHD6iIr9+o61cEuVJ+vsX+IQwxfp426//KKkWl6HZQ5cP+dYopv0TlcEuwPcs0NxmDuMiR0tsbU0KZh3vEK5g+ng6F9aKmFlNTRvA12nv0z5AEUhM=;
	7:2DtSgbaZFAr2+RQLNPsj1pivC2oFDge1Q7FJ+H7shV2oQKJkiW8Wp1YINHFSDQsyRzSpynRPGrKRFaq69Tk4mx+K0ivG/BLr1JFpFqa4GQDHcl+MM0w7kY1a9/V4SIUrUWgK0dnD4HPSMgQNbBeNw8vF19ZJWYSYjoSo+cainPVl/FKtzH4TUFcntcTq/GS6lazsdyODHR9TWy7/J5O3+H7Ewhvv6vVKXlukrhsQDXgT9t8PB2Qv3HUOsW4ynLsF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:45.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7c79a4-adc2-418a-a954-08d5f0b31337
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 8/9] fetch2/git: move generation of git source name into own method
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
X-List-Received-Date: Mon, 23 Jul 2018 17:18:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/git.py | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 7f7951f7..f9e31d2b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -248,17 +248,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
-        if gitsrcname.startswith('.'):
-            gitsrcname = gitsrcname[1:]
-
-        # for rebaseable git repo, it is necessary to keep mirror tar ball
-        # per revision, so that even the revision disappears from the
-        # upstream repo in the future, the mirror will remain intact and still
-        # contains the revision
-        if ud.rebaseable:
-            for name in ud.names:
-                gitsrcname = gitsrcname + '_' + ud.revisions[name]
+        gitsrcname = self.__build_git_source_name(ud.host, ud.path, ud.rebaseable, ud.names, ud.revisions)
 
         dl_dir = d.getVar("DL_DIR")
         gitdir = d.getVar("GITDIR") or (dl_dir + "/git2")
@@ -295,6 +285,22 @@ class Git(FetchMethod):
             ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
             ud.mirrortarballs.insert(0, ud.shallowtarball)
 
+    @staticmethod
+    def __build_git_source_name(host, path, rebaseable, names, revisions):
+        gitsrcname = '%s%s' % (host.replace(':', '.'), path.replace('/', '.').replace('*', '.'))
+        if gitsrcname.startswith('.'):
+            gitsrcname = gitsrcname[1:]
+
+        # for rebaseable git repo, it is necessary to keep mirror tar ball
+        # per revision, so that even the revision disappears from the
+        # upstream repo in the future, the mirror will remain intact and still
+        # contains the revision
+        if rebaseable:
+            for name in names:
+                gitsrcname = gitsrcname + '_' + revisions[name]
+
+        return gitsrcname
+
     def localpath(self, ud, d):
         return ud.clonedir
 
-- 
2.18.0


