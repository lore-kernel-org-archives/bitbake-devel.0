Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 7181 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 23 Jul 2018 18:15:29 UTC
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-ve1eur01on0047.outbound.protection.outlook.com [104.47.1.47])
	by mail.openembedded.org (Postfix) with ESMTP id 9F039744DA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OWO6ABAnsiDZ4Ti5D15snZ0yJ/XzIINTSaQXmp+Z80M=;
	b=ka8luEXvQbzmlF+T7ax2xd8wm71OBTrFn9O4v1XjZkh5wfFIbINYj//1jpfBjSmAIxG4r0Qmc3+CNp4xY6vCTCOu7zpsWnRXQrM39gdBBMNyN44oIPH0sBfn4NtyBOibUd6BdUOKMC8Wn++DyYwDmDQtejC2uc343MrIbWFM5V4=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:41 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:53 +0200
Message-Id: <20180723154259.9076-4-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 578a20b5-3158-47de-ea49-08d5f0b310f1
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:t7U14TKNz6cldDIGalwGqIaNozEnFs9UNfylgiqtJ0nGuAFNPSkeXVBYCZFbH0hk1e/h4crXy+jTKOgZG0Rd1FU+6xsXDWU3azQPX3mvw+Mv8tKC8a5a8gF09Sx+QL1HsQHkWs9RmhkVw17//LIbMKVhr0az6MvIjg+oYp7lsXiApHcWiPzfNqi4yVg4bbQ5EEpZ/87RMCEWNeKu8ePps9So4DDOH57Bln/az11vb/mFW9U3VL1LOcuSAfsH2D0r;
	25:6bIngyQDteqLvQyk79Gnl86h3XM6by/OHBFA8MsUMfTxTpvvg3BzkXJjKRWVpjyxwb9OHN/OojrLEMQERFYjPfNkBwzFNa0Un2mklv+V2oTxhm2/AY8Ync8bEX3JasqDPQ+zndoiEdxgWi2NV4q5n+zIoAl5zn2NlZuMp2XCFmk1s5VdMMsOvRkJVVZyMzLI4cI9Vdv3Lo6JlKXgpuHgW40ACFAM/PGjsLGLpqt6Hp32Kdgi430qQ5eeeaGAlMM62yV830W7pvoXL+wzYf6xDNuu9Y+Tdr7BR5r6bkoLEvW7lE012gzFc6Jru0ayft0QdTEblCx3OcqQ/8SJRwO/sw==;
	31:SBnKgnRqpM2w97sYNar/GPArCnwuQLzRIeM1cG6jA8TwE3o7IVbvEcHeAXgPQXwWYvpBlq0SwjB7nTeOB+yBaAkjKnBN5wiG7iUZUeWE5OCTRB6iKk/H2rdQZrHGKbzKdUPIVgHNsP5SFjD5a4QPU2FDqjHTL9XhgG40Jd7AwxgwXjPUj8uxuilUFCp7HIZEo3+PwdiRQptnfajaUDueP53sIuQBXrzlieOitxmAS2w=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827649B3CD9B48F02E2B58C8F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181554191321653)(126837547833334)(33711482430040); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:ayxe+DmrJJVp/BR2XeB9emgsEf6MvX13mi3BlxA1E3WoquQzqKq796Uj01p79FwHabA3fm2btdEc/KJk3RhSXe7wjLhuKkfI51hK4aRvQn3YSvCVGJCC8KYqq8BfCqbNLlqcKHp4slziUiOFvVkC7medQpN1dHypWCL4+t8r4rDDAGtaaSHarm4lzjbU6eBxysxOk6rQiz4EdYYhBAlq6+gtrExKtcd9LCoVLvL4J40Vb+AyUdIK44drtGqNilRcO7lxXc3ih0NMvRXBt+brZG45Eh/eziNIrD84ZG6HevNx96SYjCYe/HXhH8609cTnKf0NMxtvwo9mTsyD1CUdkqQfgedWQKVtswjdq3SPziQXWl1MWrDVasUwfY/RWW0a
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(54906003)(2870700001)(52116002)(81156014)(23676004)(7736002)(81166006)(16526019)(186003)(11346002)(446003)(14444005)(26005)(76176011)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOmpsZVR5ZmViZDNWTndaTzZ3ZFc5c2hYcDha?=
	=?utf-8?B?SlQwblBFZnRlN1hkd0tudXo0TGNTWHdVc3VKcDhsWWtPcnlFbjlkcHRMRUov?=
	=?utf-8?B?NW5VbFltNEhrdVd5R0ZQRWRuM3hCeThpUEI5YjBJSEJGNy9WZVhlZG5WZGJZ?=
	=?utf-8?B?UlZ3UVVhWlp3THZNdStXVGx1ZXp6L2d1cDFaU0R1aFlIQnVQNDFwUWJIMkh6?=
	=?utf-8?B?SStRTE5pNHpnaStqYWQvTjlXbjdrODdCLzFTRlpvaHZNUWppUzVFS0dJaUdF?=
	=?utf-8?B?VUx6eCtpU0pVRkRhaTRCbGVSa1BYMHI1TG56T0FoNHBpUXk4YTNMK1EwL3VE?=
	=?utf-8?B?UWJSMXZDb1ZsZkN4RVkzR0w0Mkh6M0JuRkdqTzZzVWhsQ2NsU3pabGVya1Qw?=
	=?utf-8?B?QW1leERoS3FxdFA1SlhobjA4UXNJa0JiVURmdFM4bEFVdTZIUW1ZNXdndUlN?=
	=?utf-8?B?T3NObWs4UGQybmpQUG5UcmpRZFRjMTY3U0M0bUt6NlU1OUxBSUR5VUxRaGJ2?=
	=?utf-8?B?VjIyckFEeVUzZldmTmJaWnpvM0NlMzZKMzdMYk9KL2FGeXpwQ0JTdTdTTmRG?=
	=?utf-8?B?N3YxMHQxWkhVczg4cjNXQXpReXluZm1wV2tVd1RRaG1zNTF6WFFEREFobGpa?=
	=?utf-8?B?akhLdWlaTEJjb3l5ZVkycytQT0N3d0F0c2VuNEVJSUtwTEFUeUVWWTA5NFB6?=
	=?utf-8?B?NFdpUjVQY2JJeUV2d1lmMUliZ0F5R0FzYVd6ODlxNTFJUEJUTm85L2dqaXh5?=
	=?utf-8?B?TWk0QnAyRHVtV3RaaTJ5NjFYTGdkTTAxS2l1VllLNFpyWXRvenpKcDlWZ2xN?=
	=?utf-8?B?WjN6TWo1M0pTalNyNzQzSnhtenVxVVhQK0tlZVZIWDJqKzljQXJPZWRjVHRx?=
	=?utf-8?B?OTR5QnI2OHE4WkRaY29zZDlYWWtQR3UyaHZ4MEpWRWNBYzJMU0kxZVdBMWJa?=
	=?utf-8?B?NllnN21pMEU4OXhkL1dwMnlXSXEzS2JOMkNFM0FXUVIwU01GUzVjUVIxWWRj?=
	=?utf-8?B?anNRNnFOc3Rkb2VFQVRwRWx2U3I0cXQ4aTFjRjNUbDR4em5XQzlmN3JIY296?=
	=?utf-8?B?NEhlQ0dKdUtibXBoaXdxR2FsellKZHNlZnN2dzNoYlBLUUZ4OWUvMU10UDhi?=
	=?utf-8?B?cm51ZHRtQXVjaFlHVE1yM3U3ZlVzaERPbVVKY1J2clVJMXAyckg5SWVCaWdG?=
	=?utf-8?B?OW4wQTN0OXhkNlB1VDRLVlcyMmo2cjdlVnRnY2VMdUtjU1hqbGVqd0NxZ3Ru?=
	=?utf-8?B?Sy9XUk1pL29xQnE5U2Q5ckpPU2NML0VMNThwOVdXSlN2WWFuRnA2cjRCdnUw?=
	=?utf-8?B?cjYyS0RwSUR0dm8waXZlNHh3cmVOb0ZHNlI1RUdQcG9yZFlpM21EYjlqZkFN?=
	=?utf-8?B?MWlzMGI3WWpZS2JhN2h5RjhoTmc1QkFXcTluRDdXU0kzRlFlbnNoRXlVcDhQ?=
	=?utf-8?B?dTFIeENzWEVXaTV0d1pwVVhBOEVCbktCcXNRdXdxckR2cGM4WWo2U1czbGYr?=
	=?utf-8?B?cUQ2SlhDWGhSOVRnamhucGdxaFI5OG12bzREYjFkL0pFd243N1kyREZjYXlh?=
	=?utf-8?B?ZG5neTdLaFpKSm5uU1JTNUVqclV2UUpGcHFMWEdieUlOR0VWdURESGdoMXBS?=
	=?utf-8?B?aFVCd25XV3RoTnhZeURlZ25GMzQyQ2tDR1JyekpjYXBKdnAvVlpFRDlvS2x5?=
	=?utf-8?B?SDNtY3h6cW5HaHZJYkNLK1NKRXhrZXcwNTY0cDJsQWNJaDB2ZXRhaWpqYXov?=
	=?utf-8?B?a2dvR0dZSHlGNEduWGpPZz09?=
X-Microsoft-Antispam-Message-Info: W/aH3oyoQ8/Cl5ymgEPi5OsEC2UiP9dh/lUc3q5klHzPoG/9frJs4l1nXZyf/paSIQEsZBOmkpOJNB0TZQrTiObHoDBhJwDW4MN+DbGfqzF9kTJWPuuc+6/GFjB83i4M/ZBOL9TjZ3I2CHjXYHSP03Z7HomCv+3VALN+caO+IMhmtcQ549QtMjHbrCePeSoVVV07UtG5WwvFODJwoNlE8y5NflJlsv2xIV0CcOwxcEa89IoXuXYHkYdaSkgvPQeaw6GiXLItfS2phzkas1pymX9ZYMUxs/zmTQVzs9EMxfZ9D717uWXUcLTPZCfXuupKwTTwfzoEYUOku56jHhOfL5/z1/V3eQ2sumSSEzGnr9A=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:GGOJOF2xPZJT7v9chHZ2zGifsOJHL4QRI4AxHomkW1W5nZuQSlphSsz2NglZ7VPg+mV7xcajUxkRdbzNOD8ZfxVa31HA70YceyMhXwYL3gZHhyzq49beu8usDKmebf1U/5KKpwux+nOkLFFHdYoJWwVXbuHFibiFtuYogHEEPpPwTwGAi3pAJRn+ySGD0Fe9iRGRuonGgMszydEd1rUzJ6IxTxDkFMmkRoQq18FqoeQbfcpIy1/cDGJOnt6G9ZPh9/GVC8YSQpEfUQl+4IJpVLO9LDsnt9Hi+vsiuInBCBOnsZgNXrxpb4yDrSWraBfS1CmXT7h/0VmIHKVfMBo4p8Q32v8ozydNpXiQNu2BVrThPkF2vakY9MbKfuowKxHJQftGNXYNWR7+hdxa4z7wQX/Apt7YJoK6uG2/FQOtEjFHK6fcKs1MF+24B36+NLs4FdrntDMyTxdqgBpHPaoycg==;
	5:+W/AA1Vg82y71dww4otYFhKNWeONHsdtCKS8w3PFyan8M2gTK3BvByweKeg3c96IEeyUHu8i7T7M33Q1SJOa2osL+NPFdXk3i0x2+j/HBOeky4pGLMfSaUoFtVYWWGKrUZbGaiWvGyx5WBhkVfsWbBFtTcUY0sYlNyehHlh88vQ=;
	7:rejTk5X14fGk2n6EaoeUZpX/sTJrVLGZS6pr/9L7gKCNoUGL4FyTcpojfbx+IObRe8N1x1+RQ06Uc+bXhVnRmDBpXffnnk/dVABk/KSGo6gxKKkvVby8tSvTsPijIp8m5uJLmgPNrMwvyKjATX2QTb+rzFEuEUBWaIKPx6AlZoFghA67EbXbXxaIzVvT8+MmbFCWayID23hljMTIw7SikPYiwTwnAGSyM5t4UU7HdNfUQerUMH0jwiAuMGtx4oAv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:41.4707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578a20b5-3158-47de-ea49-08d5f0b310f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 3/9] fetch2/git: only use relevant checks for shallow tarball unpack
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
X-List-Received-Date: Mon, 23 Jul 2018 18:15:30 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some checks in need_update do not make sense in the unpack step. The
relevant checks for the unpack check are extracted into
__has_up_to_date_clonedir which is used in the unpack step.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/git.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 612aac43..3364bbf9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -299,17 +299,22 @@ class Git(FetchMethod):
         return ud.clonedir
 
     def need_update(self, ud, d):
-        if not os.path.exists(ud.clonedir):
+        if not self.__has_up_to_date_clonedir(ud, d):
             return True
-        for name in ud.names:
-            if not self._contains_ref(ud, d, name, ud.clonedir):
-                return True
         if ud.shallow and ud.write_shallow_tarballs and not os.path.exists(ud.fullshallow):
             return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
         return False
 
+    def __has_up_to_date_clonedir(self, ud, d):
+        if not os.path.exists(ud.clonedir):
+            return False
+        for name in ud.names:
+            if not self._contains_ref(ud, d, name, ud.clonedir):
+                return False
+        return True
+
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
@@ -472,7 +477,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        if ud.shallow and self.need_update(ud, d):
+        if ud.shallow and not self.__has_up_to_date_clonedir(ud, d):
             bb.utils.mkdirhier(destdir)
             runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
         else:
-- 
2.18.0


