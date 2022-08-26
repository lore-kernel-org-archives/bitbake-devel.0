Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29320ECAAD4
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 13:10:56 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web09.36858.1661519448659354237
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 06:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=HT15L2zE;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5237a95137=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27QCcMJp003157
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 06:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=tQl0/KtN9TIjVIhd4lKDmksRysxA3pFyO/3vtXDYAmg=;
 b=HT15L2zEtFDpzkeGvRMcj8Oh96Ta9uMyuniPVlmAtzs42o5ZRXhCtljUoym7ZTdApJlw
 ytluhCsRtG3DsUFeo5DBYOQwSwMlgdeXlR/A5SQn8Q1fMRGNcF9KV4Pwb4SEZYZs4Luf
 5Rt7Bwylyw2fj3SQERL3SPQfyPQN8v8BNR1KrCSzj5kHhHXRGS8N3YAml8jJxTxkYjMs
 7XU3tN3dq2RaU58x9eQr0xqrCUuFrool5BX9YIftDD7RoRG0KuFG2YeRSmP8xZSdiL3h
 3ihuMyrjJNwV6sZJ6XTmvupRx92PuIHiwORemhMjFNGIYee1uuTlp5TbzWn6J0dCIeLe Sg==
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com
 [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j53rvarqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 06:10:48 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 26 Aug 2022 06:10:47 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Fri, 26 Aug 2022 06:10:47 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [RFC][PATCH V2] bitbake: fetch2/git: Use git fetch to shallow clone
 revisions
Date: Fri, 26 Aug 2022 06:10:47 -0700
Message-ID: <20220826131047.51373-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -JF1R8I0rfrZBjxv5oQ62ZG6TVmhEa5a
X-Proofpoint-GUID: -JF1R8I0rfrZBjxv5oQ62ZG6TVmhEa5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260056
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 13:10:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13939

* V2
  Fixed typos in commit message

The "git clone --depth" only works for refs, doesn't support revisions, but
"git fetch --depth" supports revisions, so use it to do the shallow clone, the
idea is from "git clone --recurse-submodules --shallow-submodules".

The workflow is (Only enabled when BB_GIT_SHALLOW = "1"):
$ git init --bare <clonedir>
$ git remote add origin <url>
$ git fetch origin --depth <depth> revision
$ git branch <branchname> FETCH_HEAD
$ git tag v<branchname> FETCH_HEAD

Here is the testing data based on poky, the testing server has a very good
network bandwidth:

Add 'BB_GIT_SHALLOW = "1"' conf/local.conf
$ rm -fr tmp downloads # Fresh download for each build
$ time bitbake world --runall=fetch
$ du -sh downloads/git2/

       Full        Shallow      Saved
--------------------------------------
Time:  15m59s       2m31s       84% (13m28s)
Size:  12G          1.2G        90% (10.8G)

* The Size is for downloads/git2/, the tarballs are not counted.

We can see that it saves a lot of download time and disk space, for example:

linux-yocto: 2.8G -> 228M
llvm: 2.5G -> 171M
cryptography: 1.5G -> 35M

And "$ bitbake world" works well.

This a RFC patch, please feel free to give you comments.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 83 ++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 4534bd75800..57bb61d5ee1 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -244,6 +244,7 @@ class Git(FetchMethod):
                 ud.unresolvedrev[name] = 'HEAD'
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
+        ud.basecmd = "LANG=C %s" % ud.basecmd
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
@@ -344,6 +345,49 @@ class Git(FetchMethod):
             return False
         return True
 
+    def shallow_clone_by_fetch(self, ud, repourl, d):
+        """
+        Use "git fetch --depth <depth> revision" to implement shallow clone
+        since git can't clone a revision, a better solution should be:
+        "git fetch --depth <depth> revision:<branchname>" but it doesn't work
+        when revision is a tag, e.g.:
+        error: cannot update ref 'refs/heads/master': trying to write
+                non-commit object <revision> to branch 'refs/heads/master'
+        """
+
+        import datetime
+
+        depth = ud.shallow_depths[ud.names[0]]
+        revision = ud.revisions[ud.names[0]]
+        branchname = ud.branches[ud.names[0]]
+        if not branchname:
+            branchname = "master"
+
+        # Rename branchname if it exists which can:
+        # - Avoid conflicts during update
+        # - Keep the revision on a branch so that "git submodule update --recursive"
+        #    can work since it requires the revision on a branch.
+        branch_path = os.path.join(ud.clonedir, 'refs/heads/%s' % branchname)
+        if os.path.exists(branch_path):
+            os.rename(branch_path, '%s.%s' % (branch_path, datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
+
+        init_cmd = "%s init --bare -q" % ud.basecmd
+        add_remote_cmd = "%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl))
+        fetch_cmd = "%s fetch --progress origin --depth %s %s" % (ud.basecmd, depth, revision)
+        # Create both branch and tag for the revision
+        branch_cmd = "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branchname)
+        tag_cmd = "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname)
+
+        if ud.proto.lower() != 'file':
+            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
+
+        if not os.path.exists(ud.clonedir):
+            bb.utils.mkdirhier(ud.clonedir)
+
+        progresshandler = GitProgressHandler(d)
+        for cmd in (init_cmd, add_remote_cmd, fetch_cmd, branch_cmd, tag_cmd):
+            runfetchcmd(cmd, d, log=progresshandler, workdir=ud.clonedir)
+
     def download(self, ud, d):
         """Fetch url"""
 
@@ -360,7 +404,7 @@ class Git(FetchMethod):
             else:
                 tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
-                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
+                fetch_cmd = "%s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
                 runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
@@ -369,27 +413,32 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
-            if ud.proto.lower() != 'file':
-                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
-            progresshandler = GitProgressHandler(d)
-            runfetchcmd(clone_cmd, d, log=progresshandler)
+            if ud.shallow:
+                self.shallow_clone_by_fetch(ud, repourl, d)
+            else:
+                clone_cmd = "%s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+                progresshandler = GitProgressHandler(d)
+                if ud.proto.lower() != 'file':
+                    bb.fetch2.check_network_access(d, clone_cmd, ud.url)
+                runfetchcmd(clone_cmd, d, log=progresshandler)
 
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
             output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
             if "origin" in output:
-              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
-
-            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
-            if ud.proto.lower() != 'file':
-                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
-            progresshandler = GitProgressHandler(d)
-            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
-            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
-            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
-            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
+                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
+            if ud.shallow:
+                self.shallow_clone_by_fetch(ud, repourl, d)
+            else:
+                runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
+                fetch_cmd = "%s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
+                if ud.proto.lower() != 'file':
+                    bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
+                progresshandler = GitProgressHandler(d)
+                runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
+                runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
+                runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
+                runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
             try:
                 os.unlink(ud.fullmirror)
             except OSError as exc:
-- 
2.35.1


