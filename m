Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCEC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 23:33:07 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.869.1742340777149628501
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 16:32:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YPOf/Rrx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so5096665f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742340775; x=1742945575; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKs1pAY1xdroekTGWe+Lgjv93leC0qNej5JVGkiYY04=;
        b=YPOf/RrxgkMooUJmsjBbsGHdSjiycAAJE3yS3NCUN+MGcGOq4cep8+12y+x4ctcMAO
         eN/UcxDW+vEDbA6AgUF2PfahpRUmhuDDRe3qM16ZRx47D8FBKHBIVVYNzPD7hJPK7Yu7
         wB8B5mSWyNPqa0TKf406xdjRbspVWRqNjNr3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340775; x=1742945575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKs1pAY1xdroekTGWe+Lgjv93leC0qNej5JVGkiYY04=;
        b=ngVgZjxGeP2JEjead0KhzqIMWxqCLiN7RC/wqtrDOMJ+vEwUkgroNpOdQ4xtPJDwj0
         +DOgw+oKNN0IuTNAdqWDTlYynuTSU6aJcLJQWhSC3MXbBjIjGbPti99fk6dg/qcv9p0i
         BQ06w/HfH+7fT99BaxVOnEPV7i0oHMEmUSw//n8dq82r95rqrx7KkaGkVHIB2j9rpnJl
         jqgPSjJCtldn3+n38MJgqKhPW/BPnG4TQlnrDSv2ialjOm20v8swHJG6PAhDbMeQ508X
         1o2iVQLp04qlIrxFDnB0sVwWqWKezbNb2Iq+KPQUrbDh27B2yilxV2QepmQP5zFSWqK1
         Ho3w==
X-Gm-Message-State: AOJu0Yw1xs5vszo2MaMIeeJhFZEFbo6IOID7UbuRsbZ/mwb3h9gT63z+
	OvUk2UMC2qisfyCcEYtXObUFw9he4SauV4wO4ArOTeV6bBUwtR060KvauokszBatLkbibRp4Ao8
	5
X-Gm-Gg: ASbGncvk9ttWN9DLMxff7K2NCOR8/LisGV43SM9Xg3J+KA+RywfRjTQ0W082+pfQyhw
	QhH0QZB4JGJEm6n6XVO17RwWxjfe+gCQHzAUdBU/LeCDk6CRXzgG1U3Lxch8w6txmJm7s63qUc3
	JJHB1GONVfOTMhzH6DelVj2HYpLm1WLMWK9Zn3FyXhD4q2GtHxgxTeixS76HCKrkDsRXC4OWXNV
	y7+nD7l6kQfdnmJ/YKAh/Q9CaOVeMF1SvtsxJoYg52wpL7ZSjrNxucd0jaicPYchE9sB7EpivAW
	Vb5WnlxeHsCl4r9oeyqqBczTTA9EYZRAv1wEl0ep69yOwJm0SvOGWDDLQTOoAosF1M2ls6OwSg=
	=
X-Google-Smtp-Source: AGHT+IE/Nmcl1+65NqNlxy7FSEX+J2Kw7IyY5vrhijYYQ4YIWQhWPXv556PO9TZ6uU8obw4Pgywtxg==
X-Received: by 2002:a05:6000:1f82:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-399739b6759mr483195f8f.1.1742340774409;
        Tue, 18 Mar 2025 16:32:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:686c:8c32:99b8:c349])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm19068179f8f.27.2025.03.18.16.32.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:32:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch: Drop multiple branch/revision support for single git urls
Date: Tue, 18 Mar 2025 23:32:52 +0000
Message-ID: <20250318233252.573601-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 23:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17460

We used to use this for bare clones where a single git url could handle multiple
revisions (which implied multiple branches).

We don't use this any more and I doubt we'd want to go back to it. If we
remove it, we can simplfy the looping in the code which seems desireable.

This patch does change the warning for missing branch parameters to a
error. The message has hinted about that for long enough.

Some test cases are removed since they are no longer needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py |  44 ++++----
 lib/bb/fetch2/git.py      | 217 +++++++++++++++++---------------------
 lib/bb/fetch2/gitsm.py    |  51 +++++----
 lib/bb/fetch2/gomod.py    |   7 +-
 lib/bb/tests/fetch.py     | 122 +--------------------
 5 files changed, 149 insertions(+), 292 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cfbbce5288..0c238d9b66 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -806,8 +806,8 @@ def _get_srcrev(d, method_name='sortable_revision'):
         return "", revs
 
 
-    if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
-        autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].names[0])
+    if len(scms) == 1:
+        autoinc, rev = getattr(urldata[scms[0]].method, method_name)(urldata[scms[0]], d, urldata[scms[0]].name)
         revs.append(rev)
         if len(rev) > 10:
             rev = rev[:10]
@@ -828,13 +828,12 @@ def _get_srcrev(d, method_name='sortable_revision'):
     seenautoinc = False
     for scm in scms:
         ud = urldata[scm]
-        for name in ud.names:
-            autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
-            revs.append(rev)
-            seenautoinc = seenautoinc or autoinc
-            if len(rev) > 10:
-                rev = rev[:10]
-            name_to_rev[name] = rev
+        autoinc, rev = getattr(ud.method, method_name)(ud, d, ud.name)
+        revs.append(rev)
+        seenautoinc = seenautoinc or autoinc
+        if len(rev) > 10:
+            rev = rev[:10]
+        name_to_rev[ud.name] = rev
     # Replace names by revisions in the SRCREV_FORMAT string. The approach used
     # here can handle names being prefixes of other names and names appearing
     # as substrings in revisions (in which case the name should not be
@@ -1314,8 +1313,6 @@ class FetchData(object):
         self.localpath = None
         self.lockfile = None
         self.mirrortarballs = []
-        self.basename = None
-        self.basepath = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
         self.date = self.getSRCDate(d)
         self.url = url
@@ -1345,7 +1342,9 @@ class FetchData(object):
             setattr(self, "%s_name" % checksum_id, checksum_name)
             setattr(self, "%s_expected" % checksum_id, checksum_expected)
 
-        self.names = self.parm.get("name",'default').split(',')
+        self.name = self.parm.get("name",'default')
+        if "," in self.name:
+            raise ParameterError("The fetcher no longer supports multiple name parameters in a single url", self.url)
 
         self.method = None
         for m in methods:
@@ -1371,10 +1370,17 @@ class FetchData(object):
 
         self.ignore_checksums = False
 
+        if not self.localfile and self.needdonestamp:
+            if 'downloadfilename' in self.parm:
+                self.localfile = self.parm['downloadfilename']
+            else:
+                self.localfile = os.path.basename(self.path)
+            if not os.path.basename(self.localfile):
+                self.localfile = self.host + self.path.replace("/", ".")
+
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
             self.localpath = self.parm["localpath"]
-            self.basename = os.path.basename(self.localpath)
         elif self.localfile:
             self.localpath = self.method.localpath(self, d)
 
@@ -1388,8 +1394,8 @@ class FetchData(object):
             basepath = self.localpath
         elif self.localpath:
             basepath = dldir + os.sep + os.path.basename(self.localpath)
-        elif self.basepath or self.basename:
-            basepath = dldir + os.sep + (self.basepath or self.basename)
+        elif self.localfile:
+            basepath = dldir + os.sep + self.localfile
         else:
             bb.fatal("Can't determine lock path for url %s" % url)
 
@@ -1397,13 +1403,7 @@ class FetchData(object):
         self.lockfile = basepath + '.lock'
 
     def setup_revisions(self, d):
-        self.revisions = {}
-        for name in self.names:
-            self.revisions[name] = srcrev_internal_helper(self, d, name)
-
-        # add compatibility code for non name specified case
-        if len(self.names) == 1:
-            self.revision = self.revisions[self.names[0]]
+        self.revision = srcrev_internal_helper(self, d, self.name)
 
     def setup_localpath(self, d):
         if not self.localpath:
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 7fda9d2753..3a4ae6df45 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -9,15 +9,6 @@ Supported SRC_URI options are:
 - branch
    The git branch to retrieve from. The default is "master"
 
-   This option also supports multiple branch fetching, with branches
-   separated by commas.  In multiple branches case, the name option
-   must have the same number of names to match the branches, which is
-   used to specify the SRC_REV for the branch
-   e.g:
-   SRC_URI="git://some.host/somepath;branch=branchX,branchY;name=nameX,nameY"
-   SRCREV_nameX = "xxxxxxxxxxxxxxxxxxxx"
-   SRCREV_nameY = "YYYYYYYYYYYYYYYYYYYY"
-
 - tag
     The git tag to retrieve. The default is "master"
 
@@ -192,13 +183,10 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.nocheckout = 1
   
-        ud.unresolvedrev = {}
-        branches = ud.parm.get("branch", "").split(',')
-        if branches == [""] and not ud.nobranch:
-            bb.warn("URL: %s does not set any branch parameter. The future default branch used by tools and repositories is uncertain and we will therefore soon require this is set in all git urls." % ud.url)
-            branches = ["master"]
-        if len(branches) != len(ud.names):
-            raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
+        ud.unresolvedrev = ""
+        ud.branch = ud.parm.get("branch", "")
+        if not ud.branch and not ud.nobranch:
+            raise bb.fetch2.ParameterError("The url does not set any branch parameter or set nobranch=1.", ud.url)
 
         ud.noshared = d.getVar("BB_GIT_NOSHARED") == "1"
 
@@ -227,32 +215,27 @@ class Git(FetchMethod):
 
         revs_default = d.getVar("BB_GIT_SHALLOW_REVS")
         ud.shallow_revs = []
-        ud.branches = {}
-        for pos, name in enumerate(ud.names):
-            branch = branches[pos]
-            ud.branches[name] = branch
-            ud.unresolvedrev[name] = branch
-
-            shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH_%s" % name)
-            if shallow_depth is not None:
-                try:
-                    shallow_depth = int(shallow_depth or 0)
-                except ValueError:
-                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
-                else:
-                    if shallow_depth < 0:
-                        raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
-                    ud.shallow_depths[name] = shallow_depth
-
-            revs = d.getVar("BB_GIT_SHALLOW_REVS_%s" % name)
-            if revs is not None:
-                ud.shallow_revs.extend(revs.split())
-            elif revs_default is not None:
-                ud.shallow_revs.extend(revs_default.split())
-
-        if (ud.shallow and
-                not ud.shallow_revs and
-                all(ud.shallow_depths[n] == 0 for n in ud.names)):
+
+        ud.unresolvedrev = ud.branch
+
+        shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH_%s" % ud.name)
+        if shallow_depth is not None:
+            try:
+                shallow_depth = int(shallow_depth or 0)
+            except ValueError:
+                raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (ud.name, shallow_depth))
+            else:
+                if shallow_depth < 0:
+                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (ud.name, shallow_depth))
+                ud.shallow_depths[ud.name] = shallow_depth
+
+        revs = d.getVar("BB_GIT_SHALLOW_REVS_%s" % ud.name)
+        if revs is not None:
+            ud.shallow_revs.extend(revs.split())
+        elif revs_default is not None:
+            ud.shallow_revs.extend(revs_default.split())
+
+        if ud.shallow and not ud.shallow_revs and ud.shallow_depths[ud.name] == 0:
             # Shallow disabled for this URL
             ud.shallow = False
 
@@ -261,8 +244,7 @@ class Git(FetchMethod):
             # rev of this repository. This will get resolved into a revision
             # later. If an actual revision happens to have also been provided
             # then this setting will be overridden.
-            for name in ud.names:
-                ud.unresolvedrev[name] = 'HEAD'
+            ud.unresolvedrev = 'HEAD'
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all -c clone.defaultRemoteName=origin"
 
@@ -272,16 +254,11 @@ class Git(FetchMethod):
 
         ud.setup_revisions(d)
 
-        for name in ud.names:
-            # Ensure any revision that doesn't look like a SHA-1 is translated into one
-            if not sha1_re.match(ud.revisions[name] or ''):
-                if ud.revisions[name]:
-                    ud.unresolvedrev[name] = ud.revisions[name]
-                ud.revisions[name] = self.latest_revision(ud, d, name)
-
-        if 'tag' in ud.parm:
-            if len(ud.revisions) != 1:
-                raise bb.fetch2.ParameterError("Git fetcher support for multiple tagged revisions not implemented", ud.url)
+        # Ensure any revision that doesn't look like a SHA-1 is translated into one
+        if not sha1_re.match(ud.revision or ''):
+            if ud.revision:
+                ud.unresolvedrev = ud.revision
+            ud.revision = self.latest_revision(ud, d, ud.name)
 
         gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
         if gitsrcname.startswith('.'):
@@ -292,8 +269,7 @@ class Git(FetchMethod):
         # upstream repo in the future, the mirror will remain intact and still
         # contain the revision
         if ud.rebaseable:
-            for name in ud.names:
-                gitsrcname = gitsrcname + '_' + ud.revisions[name]
+            gitsrcname = gitsrcname + '_' + ud.revision
 
         dl_dir = d.getVar("DL_DIR")
         gitdir = d.getVar("GITDIR") or (dl_dir + "/git2")
@@ -311,15 +287,14 @@ class Git(FetchMethod):
             if ud.shallow_revs:
                 tarballname = "%s_%s" % (tarballname, "_".join(sorted(ud.shallow_revs)))
 
-            for name, revision in sorted(ud.revisions.items()):
-                tarballname = "%s_%s" % (tarballname, ud.revisions[name][:7])
-                depth = ud.shallow_depths[name]
-                if depth:
-                    tarballname = "%s-%s" % (tarballname, depth)
+            tarballname = "%s_%s" % (tarballname, ud.revision[:7])
+            depth = ud.shallow_depths[ud.name]
+            if depth:
+                tarballname = "%s-%s" % (tarballname, depth)
 
             shallow_refs = []
             if not ud.nobranch:
-                shallow_refs.extend(ud.branches.values())
+                shallow_refs.append(ud.branch)
             if ud.shallow_extra_refs:
                 shallow_refs.extend(r.replace('refs/heads/', '').replace('*', 'ALL') for r in ud.shallow_extra_refs)
             if shallow_refs:
@@ -344,18 +319,16 @@ class Git(FetchMethod):
             return True
         if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need_shallow_revs(ud, d):
             return True
-        for name in ud.names:
-            if not self._contains_ref(ud, d, name, ud.clonedir):
-                return True
+        if not self._contains_ref(ud, d, ud.name, ud.clonedir):
+            return True
         return False
 
     def lfs_need_update(self, ud, d):
         if self.clonedir_need_update(ud, d):
             return True
 
-        for name in ud.names:
-            if not self._lfs_objects_downloaded(ud, d, name, ud.clonedir):
-                return True
+        if not self._lfs_objects_downloaded(ud, d, ud.name, ud.clonedir):
+            return True
         return False
 
     def clonedir_need_shallow_revs(self, ud, d):
@@ -497,9 +470,8 @@ class Git(FetchMethod):
                 if exc.errno != errno.ENOENT:
                     raise
 
-        for name in ud.names:
-            if not self._contains_ref(ud, d, name, ud.clonedir):
-                raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
+        if not self._contains_ref(ud, d, ud.name, ud.clonedir):
+            raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revision, ud.branch))
 
         if ud.shallow and ud.write_shallow_tarballs:
             missing_rev = self.clonedir_need_shallow_revs(ud, d)
@@ -627,45 +599,44 @@ class Git(FetchMethod):
         for revision in ud.shallow_revs:
             shallow_exclude += " --shallow-exclude=%s" % revision
 
-        for name in ud.names:
-            revision = ud.revisions[name]
-            depth = ud.shallow_depths[name]
+        revision = ud.revision
+        depth = ud.shallow_depths[ud.name]
 
-            # The --depth and --shallow-exclude can't be used together
-            if depth and shallow_exclude:
-                raise bb.fetch2.FetchError("BB_GIT_SHALLOW_REVS is set, but BB_GIT_SHALLOW_DEPTH is not 0.")
+        # The --depth and --shallow-exclude can't be used together
+        if depth and shallow_exclude:
+            raise bb.fetch2.FetchError("BB_GIT_SHALLOW_REVS is set, but BB_GIT_SHALLOW_DEPTH is not 0.")
 
-            # For nobranch, we need a ref, otherwise the commits will be
-            # removed, and for non-nobranch, we truncate the branch to our
-            # srcrev, to avoid keeping unnecessary history beyond that.
-            branch = ud.branches[name]
-            if ud.nobranch:
-                ref = "refs/shallow/%s" % name
-            elif ud.bareclone:
-                ref = "refs/heads/%s" % branch
-            else:
-                ref = "refs/remotes/origin/%s" % branch
+        # For nobranch, we need a ref, otherwise the commits will be
+        # removed, and for non-nobranch, we truncate the branch to our
+        # srcrev, to avoid keeping unnecessary history beyond that.
+        branch = ud.branch
+        if ud.nobranch:
+            ref = "refs/shallow/%s" % ud.name
+        elif ud.bareclone:
+            ref = "refs/heads/%s" % branch
+        else:
+            ref = "refs/remotes/origin/%s" % branch
 
-            fetch_cmd = "%s fetch origin %s" % (ud.basecmd, revision)
-            if depth:
-                fetch_cmd += " --depth %s" % depth
+        fetch_cmd = "%s fetch origin %s" % (ud.basecmd, revision)
+        if depth:
+            fetch_cmd += " --depth %s" % depth
 
-            if shallow_exclude:
-                fetch_cmd += shallow_exclude
+        if shallow_exclude:
+            fetch_cmd += shallow_exclude
 
-            # Advertise the revision for lower version git such as 2.25.1:
-            # error: Server does not allow request for unadvertised object.
-            # The ud.clonedir is a local temporary dir, will be removed when
-            # fetch is done, so we can do anything on it.
-            adv_cmd = 'git branch -f advertise-%s %s' % (revision, revision)
-            if ud.shallow_skip_fast:
-                runfetchcmd(adv_cmd, d, workdir=ud.clonedir)
+        # Advertise the revision for lower version git such as 2.25.1:
+        # error: Server does not allow request for unadvertised object.
+        # The ud.clonedir is a local temporary dir, will be removed when
+        # fetch is done, so we can do anything on it.
+        adv_cmd = 'git branch -f advertise-%s %s' % (revision, revision)
+        if ud.shallow_skip_fast:
+            runfetchcmd(adv_cmd, d, workdir=ud.clonedir)
 
-            runfetchcmd(fetch_cmd, d, workdir=dest)
-            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
-            # Fetch Git LFS data for fast shallow clones
-            if not ud.shallow_skip_fast:
-                self.lfs_fetch(ud, d, dest, ud.revisions[ud.names[0]])
+        runfetchcmd(fetch_cmd, d, workdir=dest)
+        runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+        # Fetch Git LFS data for fast shallow clones
+        if not ud.shallow_skip_fast:
+            self.lfs_fetch(ud, d, dest, ud.revision)
 
         # Apply extra ref wildcards
         all_refs_remote = runfetchcmd("%s ls-remote origin 'refs/*'" % ud.basecmd, \
@@ -774,17 +745,17 @@ class Git(FetchMethod):
 
         if not ud.nocheckout:
             if subpath:
-                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d,
+                runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revision, readpathspec), d,
                             workdir=destdir)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
             elif not ud.nobranch:
-                branchname =  ud.branches[ud.names[0]]
+                branchname =  ud.branch
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
-                            ud.revisions[ud.names[0]]), d, workdir=destdir)
+                            ud.revision), d, workdir=destdir)
                 runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
                             branchname), d, workdir=destdir)
             else:
-                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
+                runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
 
         return True
 
@@ -815,10 +786,10 @@ class Git(FetchMethod):
         cmd = ""
         if ud.nobranch:
             cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (
-                ud.basecmd, ud.revisions[name])
+                ud.basecmd, ud.revision)
         else:
             cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
-                ud.basecmd, ud.revisions[name], ud.branches[name])
+                ud.basecmd, ud.revision, ud.branch)
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
         except bb.fetch2.FetchError:
@@ -839,7 +810,7 @@ class Git(FetchMethod):
         # existence.
         # [1] https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md#intercepting-git
         cmd = "%s lfs ls-files -l %s" \
-                % (ud.basecmd, ud.revisions[name])
+                % (ud.basecmd, ud.revision)
         output = runfetchcmd(cmd, d, quiet=True, workdir=wd).rstrip()
         # Do not do any further matching if no objects are managed by LFS
         if not output:
@@ -866,12 +837,12 @@ class Git(FetchMethod):
 
         if ud.nobranch:
             # If no branch is specified, use the current git commit
-            refname = self._build_revision(ud, d, ud.names[0])
+            refname = self._build_revision(ud, d, ud.name)
         elif wd == ud.clonedir:
             # The bare clonedir doesn't use the remote names; it has the branch immediately.
-            refname = ud.branches[ud.names[0]]
+            refname = ud.branch
         else:
-            refname = "origin/%s" % ud.branches[ud.names[0]]
+            refname = "origin/%s" % ud.branch
 
         cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
             ud.basecmd, refname)
@@ -910,7 +881,7 @@ class Git(FetchMethod):
         Return a unique key for the url
         """
         # Collapse adjacent slashes
-        return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev[name]
+        return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev
 
     def _lsremote(self, ud, d, search):
         """
@@ -943,26 +914,26 @@ class Git(FetchMethod):
         Compute the HEAD revision for the url
         """
         if not d.getVar("__BBSRCREV_SEEN"):
-            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev[name], ud.host+ud.path))
+            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev, ud.host+ud.path))
 
         # Ensure we mark as not cached
         bb.fetch2.mark_recipe_nocache(d)
 
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
-        if ud.unresolvedrev[name][:5] == "refs/" or ud.usehead:
-            head = ud.unresolvedrev[name]
-            tag = ud.unresolvedrev[name]
+        if ud.unresolvedrev[:5] == "refs/" or ud.usehead:
+            head = ud.unresolvedrev
+            tag = ud.unresolvedrev
         else:
-            head = "refs/heads/%s" % ud.unresolvedrev[name]
-            tag = "refs/tags/%s" % ud.unresolvedrev[name]
+            head = "refs/heads/%s" % ud.unresolvedrev
+            tag = "refs/tags/%s" % ud.unresolvedrev
         for s in [head, tag + "^{}", tag]:
             for l in output.strip().split('\n'):
                 sha1, ref = l.split()
                 if s == ref:
                     return sha1
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
-            (ud.unresolvedrev[name], ud.host+ud.path))
+            (ud.unresolvedrev, ud.host+ud.path))
 
     def latest_versionstring(self, ud, d):
         """
@@ -1013,7 +984,7 @@ class Git(FetchMethod):
         return pupver
 
     def _build_revision(self, ud, d, name):
-        return ud.revisions[name]
+        return ud.revision
 
     def gitpkgv_revision(self, ud, d, name):
         """
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 1c58230eac..f514aedaf1 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -62,36 +62,35 @@ class GitSM(Git):
             return modules
 
         # Collect the defined submodules, and their attributes
-        for name in ud.names:
+        try:
+            gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revision), d, quiet=True, workdir=workdir)
+        except:
+            # No submodules to update
+            gitmodules = ""
+
+        for m, md in parse_gitmodules(gitmodules).items():
             try:
-                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revision, md['path']), d, quiet=True, workdir=workdir)
             except:
-                # No submodules to update
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
+
+            if not module_hash:
+                logger.debug("submodule %s is defined, but is not initialized in the repository. Skipping", m)
                 continue
 
-            for m, md in parse_gitmodules(gitmodules).items():
-                try:
-                    module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=workdir)
-                except:
-                    # If the command fails, we don't have a valid file to check.  If it doesn't
-                    # fail -- it still might be a failure, see next check...
-                    module_hash = ""
-
-                if not module_hash:
-                    logger.debug("submodule %s is defined, but is not initialized in the repository. Skipping", m)
-                    continue
-
-                submodules.append(m)
-                paths[m] = md['path']
-                revision[m] = ud.revisions[name]
-                uris[m] = md['url']
-                subrevision[m] = module_hash.split()[2]
-
-                # Convert relative to absolute uri based on parent uri
-                if  uris[m].startswith('..') or uris[m].startswith('./'):
-                    newud = copy.copy(ud)
-                    newud.path = os.path.normpath(os.path.join(newud.path, uris[m]))
-                    uris[m] = Git._get_repo_url(self, newud)
+            submodules.append(m)
+            paths[m] = md['path']
+            revision[m] = ud.revision
+            uris[m] = md['url']
+            subrevision[m] = module_hash.split()[2]
+
+            # Convert relative to absolute uri based on parent uri
+            if  uris[m].startswith('..') or uris[m].startswith('./'):
+                newud = copy.copy(ud)
+                newud.path = os.path.normpath(os.path.join(newud.path, uris[m]))
+                uris[m] = Git._get_repo_url(self, newud)
 
         for module in submodules:
             # Translate the module url into a SRC_URI
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 6c999e8ba0..03f649bc2f 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -190,15 +190,14 @@ class GoModGit(Git):
                 ud.path = ''
         if 'protocol' not in ud.parm:
             ud.parm['protocol'] = 'https'
-        name = f"{module}@{ud.parm['version']}"
-        ud.names = [name]
-        srcrev = d.getVar('SRCREV_' + name)
+        ud.name = f"{module}@{ud.parm['version']}"
+        srcrev = d.getVar('SRCREV_' + ud.name)
         if srcrev:
             if 'srcrev' not in ud.parm:
                 ud.parm['srcrev'] = srcrev
         else:
             if 'srcrev' in ud.parm:
-                d.setVar('SRCREV_' + name, ud.parm['srcrev'])
+                d.setVar('SRCREV_' + ud.name, ud.parm['srcrev'])
         if 'branch' not in ud.parm:
             ud.parm['nobranch'] = '1'
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 305789167c..486c10cd08 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1086,12 +1086,6 @@ class FetcherNetworkTest(FetcherTest):
         url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master;protocol=https"
         self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
 
-    @skipIfNoNetwork()
-    def test_gitfetch_tagandrev(self):
-        # SRCREV is set but does not match rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5;protocol=https"
-        self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
-
     @skipIfNoNetwork()
     def test_gitfetch_usehead(self):
         # Since self.gitfetcher() sets SRCREV we expect this to override
@@ -2066,60 +2060,6 @@ class GitShallowTest(FetcherTest):
             assert './.git/annex/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
             assert os.path.exists(os.path.join(self.gitdir, 'c'))
 
-    def test_shallow_multi_one_uri(self):
-        # Create initial git repo
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.git('checkout -b a_branch', cwd=self.srcdir)
-        self.add_empty_file('c')
-        self.git('tag v0.0 HEAD', cwd=self.srcdir)
-        self.add_empty_file('d')
-        self.git('checkout master', cwd=self.srcdir)
-        self.add_empty_file('e')
-        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
-        self.add_empty_file('f')
-        self.assertRevCount(7, cwd=self.srcdir)
-
-        uri = self.d.getVar('SRC_URI').split()[0]
-        uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
-
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
-        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
-        self.d.setVar('SRCREV_master', '${AUTOREV}')
-        self.d.setVar('SRCREV_a_branch', '${AUTOREV}')
-
-        self.fetch_shallow(uri)
-
-        self.assertRevCount(4)
-        self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
-
-    def test_shallow_multi_one_uri_depths(self):
-        # Create initial git repo
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.git('checkout -b a_branch', cwd=self.srcdir)
-        self.add_empty_file('c')
-        self.add_empty_file('d')
-        self.git('checkout master', cwd=self.srcdir)
-        self.add_empty_file('e')
-        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
-        self.add_empty_file('f')
-        self.assertRevCount(7, cwd=self.srcdir)
-
-        uri = self.d.getVar('SRC_URI').split()[0]
-        uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
-
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH_master', '3')
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH_a_branch', '1')
-        self.d.setVar('SRCREV_master', '${AUTOREV}')
-        self.d.setVar('SRCREV_a_branch', '${AUTOREV}')
-
-        self.fetch_shallow(uri)
-
-        self.assertRevCount(4, ['--all'])
-        self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
-
     def test_shallow_clone_preferred_over_shallow(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
@@ -3319,58 +3259,6 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
 
-    def test_mirror_tarball_multiple_branches(self):
-        """
-        test if PREMIRRORS can handle multiple name/branches correctly
-        both branches have required revisions
-        """
-        self.make_git_repo()
-        branch1rev = self.git_new_branch("testbranch1")
-        branch2rev = self.git_new_branch("testbranch2")
-        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1,testbranch2;protocol=https;name=branch1,branch2"
-        self.d.setVar("SRCREV_branch1", branch1rev)
-        self.d.setVar("SRCREV_branch2", branch2rev)
-        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
-        self.assertTrue(os.path.exists(self.mirrorfile), "Mirror file doesn't exist")
-        fetcher.download()
-        fetcher.unpack(os.path.join(self.tempdir, "unpacked"))
-        unpacked = os.path.join(self.tempdir, "unpacked", "git", self.testfilename)
-        self.assertTrue(os.path.exists(unpacked), "Repo has not been unpackaged properly!")
-        with open(unpacked, 'r') as f:
-            content = f.read()
-            ## We expect to see testbranch1 in the file, not master, not testbranch2
-            self.assertTrue(content.find("testbranch1") != -1, "Wrong branch has been checked out!")
-
-    def test_mirror_tarball_multiple_branches_nobranch(self):
-        """
-        test if PREMIRRORS can handle multiple name/branches correctly
-        Unbalanced name/branches raises ParameterError
-        """
-        self.make_git_repo()
-        branch1rev = self.git_new_branch("testbranch1")
-        branch2rev = self.git_new_branch("testbranch2")
-        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1;protocol=https;name=branch1,branch2"
-        self.d.setVar("SRCREV_branch1", branch1rev)
-        self.d.setVar("SRCREV_branch2", branch2rev)
-        with self.assertRaises(bb.fetch2.ParameterError):
-            fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
-
-    def test_mirror_tarball_multiple_branches_norev(self):
-        """
-        test if PREMIRRORS can handle multiple name/branches correctly
-        one of the branches specifies non existing SRCREV
-        """
-        self.make_git_repo()
-        branch1rev = self.git_new_branch("testbranch1")
-        branch2rev = self.git_new_branch("testbranch2")
-        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1,testbranch2;protocol=https;name=branch1,branch2"
-        self.d.setVar("SRCREV_branch1", branch1rev)
-        self.d.setVar("SRCREV_branch2", "0"*40)
-        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
-        self.assertTrue(os.path.exists(self.mirrorfile), "Mirror file doesn't exist")
-        with self.assertRaises(bb.fetch2.NetworkAccess):
-            fetcher.download()
-
 
 class FetchPremirroronlyNetworkTest(FetcherTest):
 
@@ -3577,7 +3465,7 @@ class GoModGitTest(FetcherTest):
         ud = fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'go.googlesource.com')
         self.assertEqual(ud.path, '/net')
-        self.assertEqual(ud.names, ['golang.org/x/net@v0.9.0'])
+        self.assertEqual(ud.name, 'golang.org/x/net@v0.9.0')
         self.assertEqual(self.d.getVar('SRCREV_golang.org/x/net@v0.9.0'), '694cff8668bac64e0864b552bffc280cd27f21b1')
 
         fetcher.download()
@@ -3603,7 +3491,7 @@ class GoModGitTest(FetcherTest):
         self.assertEqual(ud.host, 'github.com')
         self.assertEqual(ud.path, '/Azure/azure-sdk-for-go')
         self.assertEqual(ud.parm['subpath'], 'sdk/storage/azblob')
-        self.assertEqual(ud.names, ['github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0'])
+        self.assertEqual(ud.name, 'github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0')
         self.assertEqual(self.d.getVar('SRCREV_github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0'), 'ec928e0ed34db682b3f783d3739d1c538142e0c3')
 
         fetcher.download()
@@ -3627,7 +3515,7 @@ class GoModGitTest(FetcherTest):
         ud = fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'gopkg.in')
         self.assertEqual(ud.path, '/ini.v1')
-        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
+        self.assertEqual(ud.name, 'gopkg.in/ini.v1@v1.67.0')
         self.assertEqual(ud.parm['srcrev'], 'b2f570e5b5b844226bbefe6fb521d891f529a951')
 
         fetcher.download()
@@ -3649,7 +3537,7 @@ class GoModGitTest(FetcherTest):
         ud = fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'gopkg.in')
         self.assertEqual(ud.path, '/ini.v1')
-        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
+        self.assertEqual(ud.name, 'gopkg.in/ini.v1@v1.67.0')
         self.assertEqual(self.d.getVar('SRCREV_gopkg.in/ini.v1@v1.67.0'), 'b2f570e5b5b844226bbefe6fb521d891f529a951')
 
         fetcher.download()
@@ -3672,7 +3560,7 @@ class GoModGitTest(FetcherTest):
         ud = fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'github.com')
         self.assertEqual(ud.path, '/census-instrumentation/opencensus-go')
-        self.assertEqual(ud.names, ['go.opencensus.io@v0.24.0'])
+        self.assertEqual(ud.name, 'go.opencensus.io@v0.24.0')
         self.assertEqual(self.d.getVar('SRCREV_go.opencensus.io@v0.24.0'), 'b1a01ee95db0e690d91d7193d037447816fae4c5')
 
         fetcher.download()

