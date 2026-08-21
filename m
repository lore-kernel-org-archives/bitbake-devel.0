Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3198C5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:07:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18.1787332023222710329
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=BiKq8QBV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.48.60, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYkgDrGhAOmK1SAsNc+Ge5Zi1/PbeueI16IPpjCiNpNADcZuX2cualblrkMwV5Wm5isQzBtna+sl4CQicwDjIhBlhvVn4bDYpcYsEJRBplwfuO5f44tBCF/jZID/bUEoQ3HFm1eGajjxC7VZYHE7i3hhM7u93/cjyzJK95yXKAA10DWSPmEPUKFzBvdaX2L6a3nzqJRw09GqhDFuJRDoGavyIr7yRlel4rl4LEsAhWvMppjXAFna/53d/bgIOdRqoVfQSnG19LuaGSsdmzPEuqC7ugKN+bHefEFL7sdO5KBGSNfyYLLpf6+20DclSvH/hdUx7nxKIF4EF66FcsnNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4lcocISYT3Ev7HZ/WQRNBuAUFeAYUbDWglGJecdzsg=;
 b=amXIKJakpnWKIqOOL6oLyZG4mpjaIPYjb6XuEaRQj+8GWsj3nR74PSFuBIW4CBedo1CBYhxwRLGklxTxIGqG2DLbjIklQFcSzQr+LokhjoyHoPJiQzkmJTtxMoa+deUJwJ71RRJXf1ZIf+5OXy0z8VpYoiIWe3lpIkJ3Gz46/U3jgDt8a9kBVIhQFZgnwkhRZ9jTwxtpot9GwKORwsm+KzSM9xSS4pBnIxSm6MXPNzTcaO0wacyC5mlJ8v8GKil+nDVqKkUGSi4wEFnRK+HRatKrYDP2IXw5eWOlZJPQ2bF4jwVCoFadYBEKor+8OaAVbxlQbGn795SQJVEJxpFhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4lcocISYT3Ev7HZ/WQRNBuAUFeAYUbDWglGJecdzsg=;
 b=BiKq8QBV4XxfghhyvSUYov7XTbDRdIPblw3Y1gGE96eMtJjS6UVbTmzOMt53hx+Jjb0IcVT7RvbeZ2je8s1z/zKcdtprecJLDFNlCXMzWePl3owWLRf51ESd8hFsthFFmsML6UmWyq1GMZxE2bqlmP6GofL81se/27LO7ie9NFQZhj5HVC6VDCaRTLp/RZ0zuk6sPY7ZPjtUmGh9ijedXovCgSN72abJMIm9OPpkpQWFjW4HjNbEXvrcyvvjbWYCUb+NZP72mi0iXDXZjQQjPI5i85rnIdJ/xAhkCgrpBXFV+0IHQVQzHsxEYGnReGY3zgf3mfSasc6KUxFVnnv3bQ==
Received: from BN9PR03CA0606.namprd03.prod.outlook.com (2603:10b6:408:106::11)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 17:06:50 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::3e) by BN9PR03CA0606.outlook.office365.com
 (2603:10b6:408:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 17:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:06:50 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 21 Aug 2026 11:06:41 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/3] lib: use bb.fetch2, not bb.fetch
Date: Fri, 21 Aug 2026 13:06:23 -0400
Message-ID: <20260821170624.436725-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821170624.436725-1-chris.laplante@agilent.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 414b0f2c-7017-4a58-d0d7-08deffa69794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|3023799007|13003099007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	NpO488CKxsVBQZyEUxFC4qI3+Vmyg7o6/aX767giwf0klWC+02xjyW0Q28X43ip14f1SueAyriMRPeCtLbVO3XicVg9oVaC58s1i/T2gh2+LVHxl9hm/vLNLQU26BjEuYwXS9SwDwY2cUpovWNCad70P4wBTyhWmt3wTo9SRP7T+UCyPFszBv7qP0Su6qdE1XYM+CUj9BhW3m7ud8eaa6XASTopK7vsv9LzBr79qR7q3BIiF3pDvBDBEPHj6b6LZK3IRd8MYj43pFylSjJXKT3WKJ5mVbefbNCZHZOtx91igEL4yl//ye99sYlPo6PYhfCt3ksgpFfpBH4JNysOMd2Ku583GPY0WWYwGy5TZEVxWkKX+gHHfCJlyxfq4yIye0LSjRKixuJQSVI3LUqQ6D9ib0tm/BD1aQqiC9cz45laV8OFamD+iEnbEbBr6nvvnB7UYyjHrQEbpSeGePLKHhdVqcUVHmx2r9N1mndIc2gurJktK/M8PAbDujgO1cQBKg4WC09OAsxZLHcd7EsUScSzjpXo81mRnybUqcK0eKHJCZWG3AqQ3dLaKreUjRo2Kw2Npie8qsFTMOLfbVK0zab8ed+G02A08Dc66dqqc9QCJhaOd+JucSIgjrTov1sUIF/a0899NfcDuFiGjING05w==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(3023799007)(13003099007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	D50dUNHR63t0dpKHWma6+6tYRSr9CJmJHzlDi1iRlf8FEV0GaeRQ1lW8wa7afmhI+x45XCl4mTnEYh1CJXUW0d6TfNjO1UW5Y6XywL+TNrkHVai9cV3hnOLmTpHX0LcjdopQdLW8abN5TOdsM2HdBJSavpPLHRyljQo/wieZGcX7cGlkAtAybGF6eVvN7A8xPI2d9SFBhKEuctLuWavsktdVvtoqAji+39xCbC84axtKWFLZ1mRmag8HFt0/SdgXGU57NTcaBZfTpm/P9PsJs26dqa3pv9XIVqa3ejGZL5OvtZ4Na7rSaZ+hQ/Qc24zlNWQR3pM0PoM3Jndy3eyKWN8kUDyd2IHv96vjqxEGtja3gu6vE3THFsYqWp83LRtuGzQXZVOTHnJyw/HPO6dynus5XNGJq3DhiTWIqAE4hSLFsq8XsnBbl6co2NEZlfAp
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:06:50.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414b0f2c-7017-4a58-d0d7-08deffa69794
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20011

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/command.py         |   2 +-
 lib/bb/cooker.py          |   6 +-
 lib/bb/cookerdata.py      |   2 +-
 lib/bb/fetch2/gitannex.py |   8 +-
 lib/bb/fetch2/wget.py     |   6 +-
 lib/bb/tests/fetch.py     | 244 +++++++++++++++++++-------------------
 6 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1b16884fa..953d546a4 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -765,7 +765,7 @@ class CommandsAsync:
         """
         Parse the .bb files
         """
-        if bb.fetch.fetcher_compare_revisions(command.cooker.data):
+        if bb.fetch2.fetcher_compare_revisions(command.cooker.data):
             command.finishAsyncCommand(code=3D1)
         else:
             command.finishAsyncCommand()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0321478d3..94452027e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1310,7 +1310,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
         file associated with a recipe might have been modified by the user=
).
         """
         build.reset_cache()
-        bb.fetch._checksum_cache.mtime_cache.clear()
+        bb.fetch2._checksum_cache.mtime_cache.clear()
         siggen_cache =3D getattr(bb.parse.siggen, 'checksum_cache', None)
         if siggen_cache:
             bb.parse.siggen.checksum_cache.mtime_cache.clear()
@@ -2092,7 +2092,7 @@ class Parser(multiprocessing.Process):
         signal.signal(signal.SIGINT, self.catch_sig)
         bb.utils.set_process_name(multiprocessing.current_process().name)
         multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_sav=
e, exitpriority=3D1)
-        multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, e=
xitpriority=3D1)
+        multiprocessing.util.Finalize(None, bb.fetch2.fetcher_parse_save, =
exitpriority=3D1)
=20
         pending =3D []
         havejobs =3D True
@@ -2286,7 +2286,7 @@ class CookerParser(object):
         bb.codeparser.parser_cache_save()
         bb.codeparser.parser_cache_savemerge()
         bb.cache.SiggenRecipeInfo.reset()
-        bb.fetch.fetcher_parse_done()
+        bb.fetch2.fetcher_parse_done()
         if self.cooker.configuration.profile:
             profiles =3D []
             for i in self.process_names:
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 59f808c96..c5fcd71be 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -277,7 +277,7 @@ class CookerDataBuilder(object):
             self.data =3D self.parseConfigurationFiles(self.prefiles, self=
.postfiles)
=20
             servercontext =3D self.data.getVar("BB_WORKERCONTEXT", False) =
is None and not worker
-            bb.fetch.fetcher_init(self.data, servercontext)
+            bb.fetch2.fetcher_init(self.data, servercontext)
             bb.parse.init_parser(self.data)
=20
             bb.event.fire(bb.event.ConfigParsed(), self.data)
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index c378cc36d..faac23d58 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -29,7 +29,7 @@ class GitANNEX(Git):
             try:
                 runfetchcmd(ud.basecmd + ['rev-list', 'git-annex'], d, qui=
et=3DTrue, workdir=3Dwd)
                 return True
-            except bb.fetch.FetchError:
+            except bb.fetch2.FetchError:
                 pass
=20
         return False
@@ -37,7 +37,7 @@ class GitANNEX(Git):
     def update_annex(self, ud, d, wd):
         try:
             runfetchcmd(ud.basecmd + ['annex', 'get', '--all'], d, quiet=
=3DTrue, workdir=3Dwd)
-        except bb.fetch.FetchError:
+        except bb.fetch2.FetchError:
             return False
         runfetchcmd(['chmod', 'u+w', '-R', '%s/annex' % ud.clonedir], d, q=
uiet=3DTrue, workdir=3Dwd)
=20
@@ -55,7 +55,7 @@ class GitANNEX(Git):
=20
         try:
             runfetchcmd(ud.basecmd + ['annex', 'init'], d, workdir=3Ddest)
-        except bb.fetch.FetchError:
+        except bb.fetch2.FetchError:
             pass
=20
         if self.uses_annex(ud, d, dest):
@@ -67,7 +67,7 @@ class GitANNEX(Git):
=20
         try:
             runfetchcmd(ud.basecmd + ['annex' ,'init'], d, workdir=3Dud.de=
stdir)
-        except bb.fetch.FetchError:
+        except bb.fetch2.FetchError:
             pass
=20
         annex =3D self.uses_annex(ud, d, ud.destdir)
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 0d2b7f5c8..9cb021419 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -632,7 +632,7 @@ class Wget(FetchMethod):
         else:
             version_dir[1] =3D dirver
=20
-        dirs_uri =3D bb.fetch.encodeurl([ud.type, ud.host,
+        dirs_uri =3D bb.fetch2.encodeurl([ud.type, ud.host,
                 ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
         bb.debug(3, "DirURL: %s, %s" % (dirs_uri, package))
=20
@@ -658,7 +658,7 @@ class Wget(FetchMethod):
                     dirver_new =3D spfx + sver
                     path =3D ud.path.replace(dirver, dirver_new, True) \
                         .split(package)[0]
-                    uri =3D bb.fetch.encodeurl([ud.type, ud.host, path,
+                    uri =3D bb.fetch2.encodeurl([ud.type, ud.host, path,
                         ud.user, ud.pswd, {}])
=20
                     pupver =3D self._check_latest_version(uri,
@@ -765,7 +765,7 @@ class Wget(FetchMethod):
                     return (self._check_latest_version_by_dir(dirver,
                         package, package_regex, current_version, ud, d, fi=
lter_regex), '')
=20
-            uri =3D bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, u=
d.pswd, {}])
+            uri =3D bb.fetch2.encodeurl([ud.type, ud.host, path, ud.user, =
ud.pswd, {}])
         else:
             uri =3D regex_uri
=20
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f8..c0b2f155a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -518,28 +518,28 @@ class MirrorUriTest(FetcherTest):
     def test_urireplace(self):
         self.d.setVar("FILESPATH", ".")
         for k, v in self.replaceuris.items():
-            ud =3D bb.fetch.FetchData(k[0], self.d)
+            ud =3D bb.fetch2.FetchData(k[0], self.d)
             ud.setup_localpath(self.d)
             mirrors =3D bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]=
))
             newuris, uds =3D bb.fetch2.build_mirroruris(ud, mirrors, self.=
d)
             self.assertEqual([v] if v else [], newuris)
=20
     def test_urilist1(self):
-        fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.org/=
releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher =3D bb.fetch2.FetchData("http://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.ta=
r.gz', 'file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
=20
     def test_urilist2(self):
         # Catch https:// -> files:// bug
-        fetcher =3D bb.fetch.FetchData("https://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher =3D bb.fetch2.FetchData("https://downloads.yoctoproject.or=
g/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///someotherpath/downloads/bitbake-1=
.0.tar.gz'])
=20
     def test_urilistsvn(self):
         # Catch svn:// -> svn:// bug
-        fetcher =3D bb.fetch.FetchData("svn://svn.server1.com/isource/svnr=
oot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;r=
ev=3D2", self.d)
+        fetcher =3D bb.fetch2.FetchData("svn://svn.server1.com/isource/svn=
root/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;=
rev=3D2", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/rep=
oname/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D2'=
])
@@ -548,7 +548,7 @@ class MirrorUriTest(FetcherTest):
         # Test if mirror of a mirror works
         mirrorvar =3D self.mirrorvar + " http://.*/.* http://otherdownload=
s.yoctoproject.org/downloads/"
         mirrorvar =3D mirrorvar + " http://otherdownloads.yoctoproject.org=
/.* http://downloads2.yoctoproject.org/downloads/"
-        fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.org/=
releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher =3D bb.fetch2.FetchData("http://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(mirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.ta=
r.gz',
@@ -560,7 +560,7 @@ class MirrorUriTest(FetcherTest):
                    "https://.*/[^/]*    https://bbbb/B/B/B/"
=20
     def test_recursive(self):
-        fetcher =3D bb.fetch.FetchData("https://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher =3D bb.fetch2.FetchData("https://downloads.yoctoproject.or=
g/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.recmirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['http://aaaa/A/A/A/bitbake/bitbake-1.0.tar=
.gz',
@@ -584,7 +584,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
     @skipIfNoNetwork()
     def test_that_directory_is_named_after_recipe_url_when_no_mirroring_is=
_used(self):
         self.setup_mirror_rewrite()
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -594,7 +594,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
     @skipIfNoNetwork()
     def test_that_directory_exists_for_mirrored_url_and_recipe_url_when_mi=
rroring_is_used(self):
         self.setup_mirror_rewrite()
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -605,9 +605,9 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
     @skipIfNoNetwork()
     def test_that_recipe_directory_and_mirrored_directory_exists_when_mirr=
oring_is_used_and_the_mirrored_directory_already_exists(self):
         self.setup_mirror_rewrite()
-        fetcher =3D bb.fetch.Fetch([self.mirror_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.mirror_url], self.d)
         fetcher.download()
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -632,7 +632,7 @@ class TarballNamingTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_that_the_recipe_tarball_is_created_when_no_mirroring_is_used(=
self):
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -642,7 +642,7 @@ class TarballNamingTest(FetcherTest):
     @skipIfNoNetwork()
     def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(sel=
f):
         self.setup_mirror_rewrite()
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -667,7 +667,7 @@ class GitShallowTarballNamingTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_that_the_tarball_is_named_after_recipe_url_when_no_mirroring_=
is_used(self):
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -677,7 +677,7 @@ class GitShallowTarballNamingTest(FetcherTest):
     @skipIfNoNetwork()
     def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(sel=
f):
         self.setup_mirror_rewrite()
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -696,7 +696,7 @@ class CleanTarballTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_that_the_tarball_contents_does_not_leak_info(self):
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
=20
@@ -770,7 +770,7 @@ class FetcherLocalTest(FetcherTest):
         return package_name
=20
     def fetchUnpack(self, uris):
-        fetcher =3D bb.fetch.Fetch(uris, self.d)
+        fetcher =3D bb.fetch2.Fetch(uris, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         flst =3D []
@@ -783,7 +783,7 @@ class FetcherLocalTest(FetcherTest):
     def test_local_checksum_fails_no_file(self):
         self.d.setVar("SRC_URI", "file://404")
         with self.assertRaises(bb.BBHandledException):
-            bb.fetch.get_checksum_file_list(self.d)
+            bb.fetch2.get_checksum_file_list(self.d)
=20
     def test_local(self):
         tree =3D self.fetchUnpack(['file://a', 'file://dir/c'])
@@ -892,7 +892,7 @@ class FetcherLocalTest(FetcherTest):
         self.d.setVar("SRCREV", "AUTOINC")
         self.d.setVar("__BBSRCREV_SEEN", "1")
         url =3D "git://" + self.gitdir + ";branch=3Dmaster;protocol=3Dfile=
;" + suffix
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpack_rev =3D self.git(['rev-parse', 'HEAD'],
@@ -930,7 +930,7 @@ class FetcherNoNetworkTest(FetcherTest):
=20
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-=
file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/test=
-file.tar.gz"], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -945,7 +945,7 @@ class FetcherNoNetworkTest(FetcherTest):
=20
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-=
file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/test=
-file.tar.gz"], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz.done")))
=20
@@ -960,7 +960,7 @@ class FetcherNoNetworkTest(FetcherTest):
=20
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-=
file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/test=
-file.tar.gz"], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
         # the existing file should not exist or should have be moved to "b=
ad-checksum"
@@ -970,7 +970,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
         # ssh fetch does not support checksums
-        fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["ssh://invalid@invalid.yoctoproject.o=
rg/test-file.tar.gz"], self.d)
         # attempts to download with missing donestamp
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
@@ -983,7 +983,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
         # ssh fetch does not support checksums
-        fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["ssh://invalid@invalid.yoctoproject.o=
rg/test-file.tar.gz"], self.d)
         # attempts to download with missing donestamp
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
@@ -998,7 +998,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz")))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz.done")))
         # ssh fetch does not support checksums
-        fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["ssh://invalid@invalid.yoctoproject.o=
rg/test-file.tar.gz"], self.d)
         # should not fetch
         fetcher.download()
         # both files should still exist
@@ -1013,7 +1013,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz.done")))
         # ssh fetch does not support checksums
-        fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["ssh://invalid@invalid.yoctoproject.o=
rg/test-file.tar.gz"], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
         # both files should still exist
@@ -1023,12 +1023,12 @@ class FetcherNoNetworkTest(FetcherTest):
 class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch(self):
-        fetcher =3D bb.fetch.Fetch(["https://downloads.yoctoproject.org/re=
leases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/rel=
eases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["https://downloads.yoctoproject.org/r=
eleases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/re=
leases/bitbake/bitbake-1.1.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.1.tar.gz=
"), 57892)
         self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher =3D bb.fetch.Fetch(["https://downloads.yoctoproject.org/re=
leases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/rel=
eases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["https://downloads.yoctoproject.org/r=
eleases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/re=
leases/bitbake/bitbake-1.1.tar.gz"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/"))=
, 9)
@@ -1037,14 +1037,14 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch_mirror(self):
         self.d.setVar("MIRRORS", "http://.*/.* https://downloads.yoctoproj=
ect.org/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
     @skipIfNoNetwork()
     def test_fetch_mirror_of_mirror(self):
         self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoprojec=
t.org/ http://invalid2.yoctoproject.org/.* https://downloads.yoctoproject.o=
rg/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
@@ -1052,7 +1052,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_fetch_file_mirror_of_mirror(self):
         self.d.setVar("FILESPATH", ".")
         self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ file://=
/some1where/.* file://some2where/ file://some2where/.* https://downloads.yo=
ctoproject.org/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/bitbake-1.0.tar.gz"], self.d)
         os.mkdir(self.dldir + "/some2where")
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
@@ -1060,20 +1060,20 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch_premirror(self):
         self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctop=
roject.org/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
     @skipIfNoNetwork()
     def test_fetch_specify_downloadfilename(self):
-        fetcher =3D bb.fetch.Fetch(["https://downloads.yoctoproject.org/re=
leases/bitbake/bitbake-1.0.tar.gz;downloadfilename=3Dbitbake-v1.0.0.tar.gz"=
], self.d)
+        fetcher =3D bb.fetch2.Fetch(["https://downloads.yoctoproject.org/r=
eleases/bitbake/bitbake-1.0.tar.gz;downloadfilename=3Dbitbake-v1.0.0.tar.gz=
"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar=
.gz"), 57749)
=20
     @skipIfNoNetwork()
     def test_fetch_premirror_specify_downloadfilename_regex_uri(self):
         self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctop=
roject.org/releases/bitbake/")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/1.0.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/1.0.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
@@ -1081,7 +1081,7 @@ class FetcherNetworkTest(FetcherTest):
     # BZ13039
     def test_fetch_premirror_specify_downloadfilename_specific_uri(self):
         self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/relea=
ses/bitbake https://downloads.yoctoproject.org/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/1.0.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/1.0.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
@@ -1089,7 +1089,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_fetch_premirror_use_downloadfilename_to_fetch(self):
         # Ensure downloadfilename is used when fetching from premirror.
         self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctop=
roject.org/releases/bitbake")
-        fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.1.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], sel=
f.d)
+        fetcher =3D bb.fetch2.Fetch(["http://invalid.yoctoproject.org/rele=
ases/bitbake/bitbake-1.1.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], se=
lf.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
=20
@@ -1103,14 +1103,14 @@ class FetcherNetworkTest(FetcherTest):
=20
         self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
         self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5"=
)
-        fetcher =3D bb.fetch.Fetch([url1], self.d)
+        fetcher =3D bb.fetch2.Fetch([url1], self.d)
         fetcher.download()
         checkrevision(self, fetcher)
         # Wipe out the dldir clone and the unpacked source, turn off the n=
etwork and check mirror tarball works
         bb.utils.prunedir(self.dldir + "/git2/")
         bb.utils.prunedir(self.unpackdir)
         self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher =3D bb.fetch.Fetch([url2], self.d)
+        fetcher =3D bb.fetch2.Fetch([url2], self.d)
         fetcher.download()
         checkrevision(self, fetcher)
=20
@@ -1129,7 +1129,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_gitfetch_badsrcrev(self):
         # SRCREV is set but does not match rev=3D parameter
         url1 =3D url2 =3D "git://git.openembedded.org/bitbake;rev=3Ddead05=
b0b4ba0959fe0624d2a4885d7b70426da5;branch=3Dmaster;protocol=3Dhttps"
-        self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2=
)
+        self.assertRaises(bb.fetch2.FetchError, self.gitfetcher, url1, url=
2)
=20
     @skipIfNoNetwork()
     def test_gitfetch_usehead(self):
@@ -1138,7 +1138,7 @@ class FetcherNetworkTest(FetcherTest):
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
         url =3D "git://git.openembedded.org/bitbake;usehead=3D1;branch=3Dm=
aster;protocol=3Dhttps"
-        self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, u=
rl)
+        self.assertRaises(bb.fetch2.ParameterError, self.gitfetcher, url, =
url)
=20
     @skipIfNoNetwork()
     def test_gitfetch_usehead_withname(self):
@@ -1147,7 +1147,7 @@ class FetcherNetworkTest(FetcherTest):
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
         url =3D "git://git.openembedded.org/bitbake;usehead=3D1;name=3Dnew=
Name;branch=3Dmaster;protocol=3Dhttps"
-        self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, u=
rl)
+        self.assertRaises(bb.fetch2.ParameterError, self.gitfetcher, url, =
url)
=20
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_for_mirrored_url_when_previous_d=
ownloaded_by_the_recipe_url(self):
@@ -1178,7 +1178,7 @@ class FetcherNetworkTest(FetcherTest):
         url =3D "gitsm://git.yoctoproject.org/git-submodule-test;branch=3D=
ssh-gitsm-tests;rev=3D049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=3Dmas=
ter;protocol=3Dhttps"
         # Original URL (comment this if you have ssh access to git.yoctopr=
oject.org)
         url =3D "gitsm://git.yoctoproject.org/git-submodule-test;branch=3D=
master;rev=3D38e61644af90dccd73c03ed3acaed98c8dda9294;branch=3Dmaster;proto=
col=3Dhttps"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1203,13 +1203,13 @@ class FetcherNetworkTest(FetcherTest):
         dl_premirror =3D os.path.join(tempdir, "download-premirror")
         os.mkdir(dl_premirror)
         self.d.setVar("DL_DIR", dl_premirror)
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # now use the premirror in restricted network
         self.d.setVar("DL_DIR", self.dldir)
         self.d.setVar("PREMIRRORS", "gitsm://.*/.* gitsm://%s/git2/MIRRORN=
AME;protocol=3Dfile" % dl_premirror)
         self.d.setVar("BB_ALLOWED_NETWORKS", "*.some.domain")
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
=20
     @skipIfNoNetwork()
@@ -1217,7 +1217,7 @@ class FetcherNetworkTest(FetcherTest):
         # The following external repositories have show failures in fetch =
and unpack operations
         # We want to avoid regressions!
         url =3D "gitsm://github.com/bus1/dbus-broker;protocol=3Dhttps;rev=
=3Dfc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=3Dmain"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1233,7 +1233,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
         url =3D "gitsm://github.com/CLIUtils/CLI11;protocol=3Dhttps;rev=3D=
bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=3Dmain"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1248,12 +1248,12 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing sub=
module, or modules without needed commits """
         url =3D "gitsm://github.com/CLIUtils/CLI11;protocol=3Dhttps;rev=3D=
cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=3Dmain"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
=20
         # CLI11 that pulls in a newer nlohmann-json
         url =3D "gitsm://github.com/CLIUtils/CLI11;protocol=3Dhttps;rev=3D=
49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=3Dmain"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1267,7 +1267,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_aktualizr(self):
         url =3D "gitsm://github.com/advancedtelematic/aktualizr;branch=3Dm=
aster;protocol=3Dhttps;rev=3Dd00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1287,7 +1287,7 @@ class FetcherNetworkTest(FetcherTest):
=20
         # This repository also has submodules where the module (name), pat=
h and url do not align
         url =3D "gitsm://github.com/azure/iotedge.git;protocol=3Dhttps;rev=
=3Dd76e0316c6f324345d77c48a83ce836d09392699;branch=3Dmain"
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
@@ -1314,7 +1314,7 @@ class FetcherNetworkTest(FetcherTest):
         self.recipe_url =3D "gitsm://github.com/gflags/gflags.git;protocol=
=3Dhttps;branch=3Dmaster"
         self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1"=
)
         with Timeout(60):
-            fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+            fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
             with self.assertRaises(bb.fetch2.FetchError):
                 fetcher.download()
=20
@@ -1374,7 +1374,7 @@ class SVNTest(FetcherTest):
     def test_noexternal_svn(self):
         # Always match the rev count from setUp (currently rev 2)
         url =3D "svn://%s;module=3Dtrunk;protocol=3Dfile;rev=3D2" % self.r=
epo_url.replace('file://', '')
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         os.chdir(os.path.dirname(self.unpackdir))
         fetcher.unpack(self.unpackdir)
@@ -1388,7 +1388,7 @@ class SVNTest(FetcherTest):
     def test_external_svn(self):
         # Always match the rev count from setUp (currently rev 2)
         url =3D "svn://%s;module=3Dtrunk;protocol=3Dfile;externals=3Dallow=
ed;rev=3D2" % self.repo_url.replace('file://', '')
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch2.Fetch([url], self.d)
         fetcher.download()
         os.chdir(os.path.dirname(self.unpackdir))
         fetcher.unpack(self.unpackdir)
@@ -1403,43 +1403,43 @@ class TrustedNetworksTest(FetcherTest):
         # Ensure trusted_network returns False when the host IS in the lis=
t.
         url =3D "git://Someserver.org/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org someserver.org s=
erver2.org server3.org")
-        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        self.assertTrue(bb.fetch2.trusted_network(self.d, url))
=20
     def test_wild_trusted_network(self):
         # Ensure trusted_network returns true when the *.host IS in the li=
st.
         url =3D "git://Someserver.org/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org=
 server2.org server3.org")
-        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        self.assertTrue(bb.fetch2.trusted_network(self.d, url))
=20
     def test_prefix_wild_trusted_network(self):
         # Ensure trusted_network returns true when the prefix matches *.ho=
st.
         url =3D "git://git.Someserver.org/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org=
 server2.org server3.org")
-        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        self.assertTrue(bb.fetch2.trusted_network(self.d, url))
=20
     def test_two_prefix_wild_trusted_network(self):
         # Ensure trusted_network returns true when the prefix matches *.ho=
st.
         url =3D "git://something.git.Someserver.org/foo;rev=3D1;branch=3Dm=
aster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org=
 server2.org server3.org")
-        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        self.assertTrue(bb.fetch2.trusted_network(self.d, url))
=20
     def test_port_trusted_network(self):
         # Ensure trusted_network returns True, even if the url specifies a=
 port.
         url =3D "git://someserver.org:8080/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "someserver.org")
-        self.assertTrue(bb.fetch.trusted_network(self.d, url))
+        self.assertTrue(bb.fetch2.trusted_network(self.d, url))
=20
     def test_untrusted_network(self):
         # Ensure trusted_network returns False when the host is NOT in the=
 list.
         url =3D "git://someserver.org/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org serv=
er3.org")
-        self.assertFalse(bb.fetch.trusted_network(self.d, url))
+        self.assertFalse(bb.fetch2.trusted_network(self.d, url))
=20
     def test_wild_untrusted_network(self):
         # Ensure trusted_network returns False when the host is NOT in the=
 list.
         url =3D "git://*.someserver.org/foo;rev=3D1;branch=3Dmaster"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org serv=
er3.org")
-        self.assertFalse(bb.fetch.trusted_network(self.d, url))
+        self.assertFalse(bb.fetch2.trusted_network(self.d, url))
=20
 class URLHandle(unittest.TestCase):
     # Quote password as per RFC3986
@@ -1462,12 +1462,12 @@ class URLHandle(unittest.TestCase):
=20
     def test_decodeurl(self):
         for k, v in self.decodedata.items():
-            result =3D bb.fetch.decodeurl(k)
+            result =3D bb.fetch2.decodeurl(k)
             self.assertEqual(result, v)
=20
     def test_encodeurl(self):
         for k, v in self.datatable.items():
-            result =3D bb.fetch.encodeurl(v)
+            result =3D bb.fetch2.encodeurl(v)
             if result.startswith("file:"):
                 result =3D urllib.parse.unquote(result)
             self.assertEqual(result, k)
@@ -2278,7 +2278,7 @@ class GitShallowTest(FetcherTest):
         premirror =3D os.path.join(self.tempdir, "premirror")
         os.mkdir(premirror)
         d.setVar("DL_DIR", premirror)
-        fetcher =3D bb.fetch.Fetch([url], d)
+        fetcher =3D bb.fetch2.Fetch([url], d)
         fetcher.download()
=20
         # set PREMIRRORS
@@ -2286,7 +2286,7 @@ class GitShallowTest(FetcherTest):
=20
         # set DL_DIR back and use the same url multiple times to fetch
         d.setVar("DL_DIR", self.dldir)
-        fetcher2 =3D bb.fetch.Fetch([url, url], d)
+        fetcher2 =3D bb.fetch2.Fetch([url, url], d)
         fetcher2.download()
=20
     def test_shallow_invalid_depth(self):
@@ -2830,7 +2830,7 @@ class GitURLWithSpacesTest(FetcherTest):
=20
         for test_git_url, ref in self.test_git_urls.items():
=20
-            fetcher =3D bb.fetch.Fetch([test_git_url], self.d)
+            fetcher =3D bb.fetch2.Fetch([test_git_url], self.d)
             ud =3D fetcher.ud[fetcher.urls[0]]
=20
             self.assertEqual(ud.url, ref['url'])
@@ -3016,7 +3016,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3033,7 +3033,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3054,7 +3054,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3074,7 +3074,7 @@ class NPMTest(FetcherTest):
         # while the fetcher object exists, which it does when we rename th=
e
         # download directory to "mirror" above. Thus we need a new fetcher=
 to go
         # with the now empty download directory.
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3086,7 +3086,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3109,7 +3109,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3137,7 +3137,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223'
                 ';destsuffix=3Dfoo/bar;downloadfilename=3Dfoo-bar.tgz']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'f=
oo-bar.tgz')))
         fetcher.unpack(self.unpackdir)
@@ -3150,7 +3150,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         self.d.setVar('BB_NO_NETWORK', '1')
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -3161,7 +3161,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -3177,7 +3177,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir =3D os.path.join(self.unpackdir, 'npm')
@@ -3187,7 +3187,7 @@ class NPMTest(FetcherTest):
     def test_npm_version_latest_rejected(self):
         url =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest']
         with self.assertRaises(bb.fetch2.ParameterError):
-            bb.fetch.Fetch(url, self.d)
+            bb.fetch2.Fetch(url, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
@@ -3195,7 +3195,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0'
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
@@ -3205,7 +3205,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0'
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
@@ -3214,7 +3214,7 @@ class NPMTest(FetcherTest):
     def test_npm_version_invalid(self):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid']
         with self.assertRaises(bb.fetch2.ParameterError):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher =3D bb.fetch2.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
@@ -3237,7 +3237,7 @@ class NPMTest(FetcherTest):
         checksum_name, hexsum =3D npm_integrity(integrity)
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example'
                 ';version=3D1.0.0;%s=3D%s' % (checksum_name, hexsum)]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3248,7 +3248,7 @@ class NPMTest(FetcherTest):
         """A wrong sha512sum param in SRC_URI causes the fetch to fail."""
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example'
                 ';version=3D1.0.0;sha512sum=3Ddeadbeef00']
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
@@ -3268,28 +3268,28 @@ class NPMTest(FetcherTest):
             else:
                 self.d.setVar('BB_STRICT_CHECKSUM', strict)
             with self.assertRaises(bb.fetch2.MissingParameterError):
-                bb.fetch.Fetch(urls, self.d)
+                bb.fetch2.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
         urls =3D ['npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MalformedUrl):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher =3D bb.fetch2.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
         urls =3D ['npm://registry.npmjs.org;version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher =3D bb.fetch2.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher =3D bb.fetch2.Fetch(urls, self.d)
=20
     def create_shrinkwrap_file(self, data):
         import json
@@ -3325,7 +3325,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
@@ -3345,7 +3345,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
=20
@@ -3367,12 +3367,12 @@ class NPMTest(FetcherTest):
             }
         })
         # Fetch with dev disabled
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2', '=
content-type-1.0.4.tgz')))
         # Fetch with dev enabled
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';dev=3D1'], sel=
f.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile + ';dev=3D1'], se=
lf.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
@@ -3388,7 +3388,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';destsuffix=3Df=
oo/bar'], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile + ';destsuffix=3D=
foo/bar'], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo',=
 'bar', 'node_modules', 'array-flatten', 'package.json')))
@@ -3404,7 +3404,7 @@ class NPMTest(FetcherTest):
             }
         })
         self.d.setVar('BB_NO_NETWORK', '1')
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -3412,7 +3412,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_no_network_with_tarball(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea295=
5d2'], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npm://registry.npmjs.org;package=3Da=
rray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea29=
55d2'], self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -3426,7 +3426,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
@@ -3443,12 +3443,12 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
         # Fetch again with npm
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea295=
5d2'], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npm://registry.npmjs.org;package=3Da=
rray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea29=
55d2'], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm',=
 'package.json')))
@@ -3465,7 +3465,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
         # Fetch correctly to get a tarball
@@ -3478,7 +3478,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         localpath =3D os.path.join(self.dldir, 'npm2', 'array-flatten-1.1.=
1.tgz')
         self.assertTrue(os.path.exists(localpath))
@@ -3496,7 +3496,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_premirrors(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea295=
5d2'], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npm://registry.npmjs.org;package=3Da=
rray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea29=
55d2'], self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3517,7 +3517,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
=20
@@ -3525,7 +3525,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_mirrors(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea295=
5d2'], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npm://registry.npmjs.org;package=3Da=
rray-flatten;version=3D1.1.1;sha1sum=3D9a5f699051b1e7073328f2a008968b64ea29=
55d2'], self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3545,7 +3545,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
=20
@@ -3566,7 +3566,7 @@ class NPMTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch2.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2', '=
content-type-1.0.4.tgz')))
@@ -3580,7 +3580,7 @@ class GitSharedTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_shared_unpack(self):
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3591,7 +3591,7 @@ class GitSharedTest(FetcherTest):
     def test_noshared_unpack(self):
         self.d.setVar('BB_GIT_NOSHARED', '1')
         self.unpackdir +=3D '_noshared'
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3603,14 +3603,14 @@ class GitTagVerificationTests(FetcherTest):
     @skipIfNoNetwork()
     def test_tag_rev_match(self):
         # Test a url with rev=3D and tag=3D set works
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.12.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca675=
7;tag=3D2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
     def test_annotated_tag_rev_match(self):
         # Test a url with rev=3D and tag=3D set works
         # rev is the annotated tag revision in this case
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3Dfa30183549bd09f33fd4eebf56771ca5393526a6=
;tag=3D2.12.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3Dfa30183549bd09f33fd4eebf56771ca5393526a=
6;tag=3D2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -3618,7 +3618,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match2(self):
         # Test a url with SRCREV and tag=3D set works
         self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757'=
)
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;tag=3D2.12.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;tag=3D2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -3626,7 +3626,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match3(self):
         # Test a url with SRCREV, rev=3D and tag=3D set works
         self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757'=
)
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.12.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca675=
7;tag=3D2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -3635,14 +3635,14 @@ class GitTagVerificationTests(FetcherTest):
         # Test a url with SRCREV and rev=3D mismatching errors
         self.d.setVar('SRCREV', 'bade540fc31a1c26839efd2c7785a751ce24ebfb'=
)
         with self.assertRaises(bb.fetch2.FetchError):
-            fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbak=
e;branch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca=
6757;tag=3D2.12.0"], self.d)
+            fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitba=
ke;branch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82c=
a6757;tag=3D2.12.0"], self.d)
=20
     @skipIfNoNetwork()
     def test_tag_rev_match5(self):
         # Test a url with SRCREV, rev=3D and tag=3D set works when using s=
hallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757'=
)
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.12.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca675=
7;tag=3D2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -3650,7 +3650,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match6(self):
         # Test a url with SRCREV, rev=3D and a mismatched tag=3D when usin=
g shallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.8.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca675=
7;tag=3D2.8.0"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)
@@ -3659,7 +3659,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match7(self):
         # Test a url with SRCREV, rev=3D and a mismatched tag=3D
         self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757'=
)
-        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.8.0"], self.d)
+        fetcher =3D bb.fetch2.Fetch(["git://git.openembedded.org/bitbake;b=
ranch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca675=
7;tag=3D2.8.0"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)
@@ -3711,17 +3711,17 @@ class FetchPremirroronlyLocalTest(FetcherTest):
     def test_mirror_multiple_fetches(self):
         self.make_git_repo()
         self.d.setVar("SRCREV", self.git_new_commit())
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         ## New commit in premirror. it's not in the download_dir
         self.d.setVar("SRCREV", self.git_new_commit())
-        fetcher2 =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher2 =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher2.download()
         fetcher2.unpack(self.unpackdir)
         ## New commit in premirror. it's not in the download_dir
         self.d.setVar("SRCREV", self.git_new_commit())
-        fetcher3 =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher3 =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher3.download()
         fetcher3.unpack(self.unpackdir)
=20
@@ -3729,20 +3729,20 @@ class FetchPremirroronlyLocalTest(FetcherTest):
     def test_mirror_commit_nonexistent(self):
         self.make_git_repo()
         self.d.setVar("SRCREV", "0"*40)
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
     def test_mirror_commit_exists(self):
         self.make_git_repo()
         self.d.setVar("SRCREV", self.git_new_commit())
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
     def test_mirror_tarball_nonexistent(self):
         self.d.setVar("SRCREV", "0"*40)
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -3775,7 +3775,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.make_git_repo()
         ## Upstream commit is in the mirror
         self.d.setVar("SRCREV", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f"=
)
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher.download()
=20
     @skipIfNoNetwork()
@@ -3783,7 +3783,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.make_git_repo()
         ## Upstream commit not in the mirror
         self.d.setVar("SRCREV", "49d65d53c2bf558ae6e9185af0f3af7b79d255ec"=
)
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -3811,7 +3811,7 @@ class FetchPremirroronlyMercurialTest(FetcherTest):
         Ask bitbake to download repo and prepare mirror tarball for us
         """
         self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher.download()
         mirrorfile =3D os.path.join(self.d.getVar("DL_DIR"), self.mirrorna=
me)
         self.assertTrue(os.path.exists(mirrorfile), "Mirror tarball {} has=
 not been created".format(mirrorfile))
@@ -3827,7 +3827,7 @@ class FetchPremirroronlyMercurialTest(FetcherTest):
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".fo=
rmat(self.mirrordir) + " \n")
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         fetcher.download()
=20
 class FetchPremirroronlyBrokenTarball(FetcherTest):
@@ -3848,7 +3848,7 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
=20
     def test_mirror_broken_download(self):
         self.d.setVar("SRCREV", "0"*40)
-        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher =3D bb.fetch2.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.FetchError), self.assertLogs() as=
 logs:
             fetcher.download()
         output =3D "".join(logs.output)
--=20
2.43.0


