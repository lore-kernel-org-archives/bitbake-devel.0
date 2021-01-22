Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
 by mx.groups.io with SMTP id smtpd.web11.11808.1611334530603140265
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jan 2021 08:55:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@garmin.com header.s=pps1 header.b=K68V0Q1+;
 spf=permerror, err=parse error for token &{10 18 _spf4.garmin.com}: limit exceeded (domain: garmin.com, ip: 205.220.177.212, mailfrom: matt.hoosier@garmin.com)
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MGnxWm005908
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jan 2021 10:55:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=Eby+jVxQfUYO9P1l48xsAdgQvNxA9hKMuFXHb+tUQ3o=;
 b=K68V0Q1+EYwnyzVIDH0zWf2Pbv9EQEoDl2z8GJvCp7uFHdGEcF2/R+Km4/vEECsQ5VmJ
 BMHn2kxHBf2vpYxxgTNkdVoh7RpHZNA4rQb911NErVDqLyk2SWZy6RjvoAng4N2XFCyU
 7sGUFjbVxXzkvim/g/JJYA6eDvTtOqnAlukWE8DDplP2qkNGv+73bAqDIfPkd0BYWXSG
 u2+p6Lrnu4ZZ4Y33t14rn0yYqH+Hmp3GxW50LljHJJN358Bn7qZhGwb8Mu9tyq3lB7kL
 /iYTbKXeFPbnG8bSmayJ7DQ3apKxK7BGyp2VdZJaXAq9S5mnhkauAnWuB8nBowrqcgYG dA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by mx0a-000eb902.pphosted.com with ESMTP id 3668q8vd1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jan 2021 10:55:29 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyOj1/PPmvKYPcQc04SXGuapRqUuNllHVRPMVClhBdp6f1bc9xsGxmC7dZwc5yg4zDOfWWxud2f6dcyDGFtlQhra3UQyIVXgq0nT6xodCKu3kkjrt4JliAuJJQ7Y30ih3bj9cyecrGMHD6rJvcpgZbwa2dlECoVXrE2WqDaccUfu+3jc/fOjzs6PS3Ws8QHHg7efJNusOQmNaXI2kdT89MmJcHlGKxsio5xaRCS9L9PtDUkM07YNRS2KT+z3ri5Ve2Ls8QobhgXdulMXHgz72st8E0kLsXVnTzwsWrd6su+a/emO67dxa0fhUvZQhmCwSp/9hOZBn6G1L0AUnHKRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eby+jVxQfUYO9P1l48xsAdgQvNxA9hKMuFXHb+tUQ3o=;
 b=b7K9q7Ts4FPi7dDT30KDoxDEuG4CLs0jaxE/Arwyq1bhK86bymj1YkWkHYU6jdMEemLSkvlk9yjsgxl2ttRJmF8Ma7JQry6xplug68X56ia0gh9K/i9QHykJUGKSD5wTQge1CVQoQvqwD59pwo+m/WvDR8H0ZJPZnGvtkCmNF3ENx9D6zL473OLsFBmDhUr6ewY9J/CXSHRelPz01O44seEoKRK1GPGfZDDIUUyZAGeOeagtwVZznNXfPt2Q9aD6/U0RxdZtG1srtMQq2a34Rr8gKwcOkuER16dXSmC0C5munEfi7U4Vy0QUwZnGLf8l9OQeKGI3l9i9XSwu4z4eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eby+jVxQfUYO9P1l48xsAdgQvNxA9hKMuFXHb+tUQ3o=;
 b=wRERX6j/e4/XyCxrO7iAQUrShRcbU0AAzuU2De06Z+EfHyH6TbwvlG2DRn4N79pLmPj+bh4azX0Blacc5pvHohNuOqR2C2VDtw5fxL0+9V1zhDCmHV5ZstsmhhJSP9lXrgtei4SjqKQcQU1/haxD87mNhnDg9+lvVrHHjft2SSWrXcgvGOIPzNRwOI95lcSVAs38BlF7Dvjp7e9qdjP1/kBFqNhaxWB+xXpkHNJYzazzNChRH41tIq1971MVmP7wo36+N/p+Sh/SBEwjcZZLuhtBwIFv7zjiaFa+vLTNfUaw6GCDesqrBXKf/S5+qQw2eVJy6EOnYepZqXjC8JwKTA==
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by CY4PR04MB0839.namprd04.prod.outlook.com (2603:10b6:903:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 16:55:25 +0000
Received: from BN7NAM10FT006.eop-nam10.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::df) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Fri, 22 Jan 2021 16:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN7NAM10FT006.mail.protection.outlook.com (10.13.157.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 16:55:24 +0000
Received: from OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2106.2; Fri, 22 Jan 2021 10:54:30 -0600
Received: from OLA-JP0QR33.garmin.com (10.5.84.15) by
 OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 10:55:23 -0600
From: "Matt Hoosier" <matt.hoosier@garmin.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Matt Hoosier <matt.hoosier@garmin.com>
Subject: [PATCH v2] bitbake: fetch/git: download LFS content too during do_fetch
Date: Fri, 22 Jan 2021 10:55:13 -0600
Message-ID: <20210122165513.30406-1-matt.hoosier@garmin.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119205934.24174-1-matt.hoosier@garmin.com>
References: <20210119205934.24174-1-matt.hoosier@garmin.com>
MIME-Version: 1.0
X-ClientProxiedBy: OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) To
 OLAWPA-EXMB8.ad.garmin.com (10.5.144.18)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59091b79-d7b3-4d65-b8f1-08d8bef6835c
X-MS-TrafficTypeDiagnostic: CY4PR04MB0839:
X-Microsoft-Antispam-PRVS: 
	<CY4PR04MB0839E51C1663DE76114EF4F4ECA09@CY4PR04MB0839.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pPVyUsFLnrmIUXStVcIzOJEoSivV22zrEavTD7LToS1PlsaGnR7GdxOEXUKNwYwljITdx21HoseNqwnEabojhrTisHk38rP/Isl5YGlSe58LH+0Pj8pBCjOus0r0A4MDp9R6aKcHBSpWZ1Bzaw+SEGEfs3dj3RBe4XPReGKvIacZg9oljlfw49OcOHocK031JZu6gEtwK9hFL8brPrDbXWTqTIHZbZDVuiFTO/PcejghTNRezGJCczFOMag2JMABkX7ASg12qQcWMbKDehap8t17XSvPaRTl75FxAp/i+8hmL8NZ95GlnO3UsnIo5CIW29y6MMYzVUuAMxKFX94hekM4+Z3+8zdsevIuMV0GzPn9cQ8oX+vk3gUN7OYcLD+Vr61GJuax8pLA3+5+8x/Z4POqpZ+9FbsMjj8S8Mhz7p5VDp9YIeV7Bcc9AoIF0Bp7KOnXZ8H/bg0qKwdl32I2pQ0X4p4rt1xSZJuBJH/7qlSyqCig6hN/pM8zwBIAqZedK+9hyCRw61oxChM+pxaCbIkKM4Z8maBzvvWtuW+6zXoEqmbwVK2205Vs6w4UPUt83nWSdGCh+tTEIf/58gMSXxnvkGtHbASIVt9nQOIdiFmXA2sFanlnZ0NhNSw2421I
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(46966006)(316002)(6916009)(7636003)(82310400003)(86362001)(82740400003)(356005)(4326008)(107886003)(6666004)(478600001)(1076003)(2906002)(70206006)(336012)(186003)(7696005)(8676002)(44832011)(426003)(8936002)(26005)(47076005)(70586007)(34070700002)(2616005)(36756003)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 16:55:24.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59091b79-d7b3-4d65-b8f1-08d8bef6835c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN7NAM10FT006.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0839
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_13:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=788 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220090
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Insert an explicit pass to fetch all blobs needed by Git LFS, during the
fetch() function. This avoids the default behavior of Git LFS to wait
until 'git checkout' to begin downloading the blobs pointed to by LFS records.
Network access is not allowed at that point in the recipe's lifecycle.

[YOCTO #14191]

Signed-off-by: Matt Hoosier <matt.hoosier@garmin.com>
---
 bitbake/lib/bb/fetch2/git.py  | 44 ++++++++++++++++++++++++++++++++---
 bitbake/lib/bb/tests/fetch.py | 28 +++++++++++++++-------
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index df9538a60d..e3ba80a3f5 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -384,6 +384,35 @@ class Git(FetchMethod):
             if missing_rev:
                 raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
 
+        if self._contains_lfs(ud, d, ud.clonedir) and self._need_lfs(ud):
+            # Unpack temporary working copy, use it to run 'git checkout' to force pre-fetching
+            # of all LFS blobs needed at the the srcrev.
+            #
+            # It would be nice to just do this inline here by running 'git-lfs fetch'
+            # on the bare clonedir, but that operation requires a working copy on some
+            # releases of Git LFS.
+            tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
+            try:
+                # Do the checkout. This implicitly involves a Git LFS fetch.
+                self.unpack(ud, tmpdir, d)
+
+                # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
+                # the bare clonedir.
+                #
+                # As this procedure is invoked repeatedly on incremental fetches as
+                # a recipe's SRCREV is bumped throughout its lifetime, this will
+                # result in a gradual accumulation of LFS blobs in <ud.clonedir>/lfs
+                # corresponding to all the blobs reachable from the different revs
+                # fetched across time.
+                #
+                # Only do this if the unpack resulted in a .git/lfs directory being
+                # created; this only happens if at least one blob needed to be
+                # downloaded.
+                if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs")):
+                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/git/.git" % tmpdir)
+            finally:
+                bb.utils.remove(tmpdir, recurse=True)
+
     def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
@@ -479,7 +508,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        need_lfs = ud.parm.get("lfs", "1") == "1"
+        need_lfs = self._need_lfs(ud)
 
         if not need_lfs:
             ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
@@ -568,6 +597,9 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _need_lfs(self, ud):
+        return ud.parm.get("lfs", "1") == "1"
+
     def _contains_lfs(self, ud, d, wd):
         """
         Check if the repository has 'lfs' (large file) content
@@ -578,8 +610,14 @@ class Git(FetchMethod):
         else:
             branchname = "master"
 
-        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
-            ud.basecmd, ud.branches[ud.names[0]])
+        # The bare clonedir doesn't use the remote names; it has the branch immediately.
+        if wd == ud.clonedir:
+            refname = ud.branches[ud.names[0]]
+        else:
+            refname = "origin/%s" % ud.branches[ud.names[0]]
+
+        cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
+            ud.basecmd, refname)
 
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 1452d76151..031ebb7171 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2089,13 +2089,14 @@ class GitLfsTest(FetcherTest):
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
 
-    def fetch(self, uri=None):
+    def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
         uri = uris[0]
         d = self.d
 
         fetcher = bb.fetch2.Fetch(uris, d)
-        fetcher.download()
+        if download:
+            fetcher.download()
         ud = fetcher.ud[uri]
         return fetcher, ud
 
@@ -2105,16 +2106,21 @@ class GitLfsTest(FetcherTest):
         uri = 'git://%s;protocol=file;subdir=${S};lfs=1' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
-        fetcher, ud = self.fetch()
+        # Careful: suppress initial attempt at downloading until
+        # we know whether git-lfs is installed.
+        fetcher, ud = self.fetch(uri=None, download=False)
         self.assertIsNotNone(ud.method._find_git_lfs)
 
-        # If git-lfs can be found, the unpack should be successful
-        ud.method._find_git_lfs = lambda d: True
-        shutil.rmtree(self.gitdir, ignore_errors=True)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+        # If git-lfs can be found, the unpack should be successful. Only
+        # attempt this with the real live copy of git-lfs installed.
+        if ud.method._find_git_lfs(self.d):
+            fetcher.download()
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
 
         # If git-lfs cannot be found, the unpack should throw an error
         with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
             ud.method._find_git_lfs = lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
@@ -2125,10 +2131,16 @@ class GitLfsTest(FetcherTest):
         uri = 'git://%s;protocol=file;subdir=${S};lfs=0' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
+        # In contrast to test_lfs_enabled(), allow the implicit download
+        # done by self.fetch() to occur here. The point of this test case
+        # is to verify that the fetcher can survive even if the source
+        # repository has Git LFS usage configured.
         fetcher, ud = self.fetch()
         self.assertIsNotNone(ud.method._find_git_lfs)
 
-        # If git-lfs can be found, the unpack should be successful
+        # If git-lfs can be found, the unpack should be successful. A
+        # live copy of git-lfs is not required for this case, so
+        # unconditionally forge its presence.
         ud.method._find_git_lfs = lambda d: True
         shutil.rmtree(self.gitdir, ignore_errors=True)
         fetcher.unpack(self.d.getVar('WORKDIR'))
-- 
2.30.0

