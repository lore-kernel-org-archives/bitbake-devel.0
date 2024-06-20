Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CFC2BA18
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 12:44:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.46726.1718887486150610099
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jun 2024 05:44:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=69015a4fb2=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K6KETC014889;
	Thu, 20 Jun 2024 12:44:43 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yujb71n6p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jun 2024 12:44:43 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 05:44:42 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 05:44:42 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <andre.draszik@linaro.org>, <kergoth@gmail.com>
Subject: [PATCH 1/2] fetch2/git: Use git shallow fetch to implement clone_shallow_local()
Date: Thu, 20 Jun 2024 05:44:40 -0700
Message-ID: <1e000140158acbe763722161b17ff30267696d33.1718886475.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718886475.git.liezhi.yang@windriver.com>
References: <cover.1718886475.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ndtl1boiHeiGoN_5G5mGd4bcTp7wXLvj
X-Proofpoint-ORIG-GUID: ndtl1boiHeiGoN_5G5mGd4bcTp7wXLvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406200091
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jun 2024 12:44:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16367

From: Robert Yang <liezhi.yang@windriver.com>

This patch can make the following settings much more faster:
BB_GIT_SHALLOW = "1"
BB_GENERATE_MIRROR_TARBALLS = "1"

* The previous implementation was:
  - Make a full clone for the repo from local ud.clonedir
  - Use git-make-shallow to remove unneeded revs

  It was very slow for recipes which have a lot of SRC_URIs, for example
  vulkan-samples and docker-compose, the docker-compose can't be done after 5
  hours.

  $ bitbake vulkan-samples -cfetch
  Before: 12 minutes
  Now: 2 minutes

  $ bitbake docker-compose -cfetch
  Before: More than 300 minutes
  Now: 15 minutes

* The patch uses git shallow fetch to fetch the repo from local
  ud.clonedir:
  - For BB_GIT_SHALLOW_DEPTH: git fetch --depth <depth> rev
  - For BB_GIT_SHALLOW_REVS: git fetch --shallow-exclude=<revs> rev

  Then the git repo will be shallow, and git-make-shallow is not needed any
  more.

  And git shallow fetch will download less commits than before since it doesn't
  need "rev^" to parse the dependencies, the previous code always need 'rev^'.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 71 +++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index c7ff769fdf..d7583f0c3a 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -551,18 +551,31 @@ class Git(FetchMethod):
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def clone_shallow_local(self, ud, dest, d):
-        """Clone the repo and make it shallow.
+        """
+        Shallow fetch from ud.clonedir (${DL_DIR}/git2/<gitrepo> by default):
+        - For BB_GIT_SHALLOW_DEPTH: git fetch --depth <depth> rev
+        - For BB_GIT_SHALLOW_REVS: git fetch --shallow-exclude=<revs> rev
+        """
+
+        bb.utils.mkdirhier(dest)
+        init_cmd = "%s init -q" % ud.basecmd
+        if ud.bareclone:
+            init_cmd += " --bare"
+        runfetchcmd(init_cmd, d, workdir=dest)
+        runfetchcmd("%s remote add origin %s" % (ud.basecmd, ud.clonedir), d, workdir=dest)
 
-        The upstream url of the new clone isn't set at this time, as it'll be
-        set correctly when unpacked."""
-        runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, dest), d)
+        # Check the histories which should be excluded
+        shallow_exclude = ''
+        for revision in ud.shallow_revs:
+            shallow_exclude += " --shallow-exclude=%s" % revision
 
-        to_parse, shallow_branches = [], []
         for name in ud.names:
             revision = ud.revisions[name]
             depth = ud.shallow_depths[name]
-            if depth:
-                to_parse.append('%s~%d^{}' % (revision, depth - 1))
+
+            # The --depth and --shallow-exclude can't be used together
+            if depth and shallow_exclude:
+                raise bb.fetch2.FetchError("BB_GIT_SHALLOW_REVS is set, but BB_GIT_SHALLOW_DEPTH is not 0.")
 
             # For nobranch, we need a ref, otherwise the commits will be
             # removed, and for non-nobranch, we truncate the branch to our
@@ -575,36 +588,42 @@ class Git(FetchMethod):
             else:
                 ref = "refs/remotes/origin/%s" % branch
 
-            shallow_branches.append(ref)
-            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+            fetch_cmd = "%s fetch origin %s" % (ud.basecmd, revision)
+            if depth:
+                fetch_cmd += " --depth %s" % depth
 
-        # Map srcrev+depths to revisions
-        parsed_depths = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join(to_parse)), d, workdir=dest)
+            if shallow_exclude:
+                fetch_cmd += shallow_exclude
 
-        # Resolve specified revisions
-        parsed_revs = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join('"%s^{}"' % r for r in ud.shallow_revs)), d, workdir=dest)
-        shallow_revisions = parsed_depths.splitlines() + parsed_revs.splitlines()
+            runfetchcmd(fetch_cmd, d, workdir=dest)
+            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
 
         # Apply extra ref wildcards
-        all_refs = runfetchcmd('%s for-each-ref "--format=%%(refname)"' % ud.basecmd,
-                               d, workdir=dest).splitlines()
+        all_refs_remote = runfetchcmd("%s ls-remote origin 'refs/*'" % ud.basecmd, \
+                                        d, workdir=dest).splitlines()
+        all_refs = []
+        for line in all_refs_remote:
+            all_refs.append(line.split()[-1])
+        extra_refs = []
         for r in ud.shallow_extra_refs:
             if not ud.bareclone:
                 r = r.replace('refs/heads/', 'refs/remotes/origin/')
 
             if '*' in r:
                 matches = filter(lambda a: fnmatch.fnmatchcase(a, r), all_refs)
-                shallow_branches.extend(matches)
+                extra_refs.extend(matches)
             else:
-                shallow_branches.append(r)
-
-        # Make the repository shallow
-        shallow_cmd = [self.make_shallow_path, '-s']
-        for b in shallow_branches:
-            shallow_cmd.append('-r')
-            shallow_cmd.append(b)
-        shallow_cmd.extend(shallow_revisions)
-        runfetchcmd(subprocess.list2cmdline(shallow_cmd), d, workdir=dest)
+                extra_refs.append(r)
+
+        for ref in extra_refs:
+            ref_fetch = os.path.basename(ref)
+            runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_fetch), d, workdir=dest)
+            revision = runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, workdir=dest)
+            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+
+        # The url is local ud.clonedir, set it to upstream one
+        repourl = self._get_repo_url(ud)
+        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=dest)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
-- 
2.45.1


