Return-Path: <mischief@offblast.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E878CCD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 20:40:04 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28743.1781815199635924806
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 13:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@offblast-org.20251104.gappssmtp.com header.s=20251104 header.b=EZlvd5Xd;
 spf=pass (domain: offblast.org, ip: 74.125.82.171, mailfrom: mischief@offblast.org)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c001b21feso775000eec.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=offblast-org.20251104.gappssmtp.com; s=20251104; t=1781815199; x=1782419999; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FB0ryiF48Aa3D4YY1K3M3jr6tPS0m2V49U9nYCUalPc=;
        b=EZlvd5Xdcm+Z94l9pwApjsjX2JSy5qkyMbOCcaqPVZ+0z0GH6gW8vlNlOkZ+IWA4mS
         9ScATPv/2GywxJdGHYCNif93WWAKczxD3j63qfTTa8fv7b+8gCXfVqmbHo+5D5y8qM16
         lxuyHYzjYZxvJRXsq0qnbiapK7KSIBrjGK+3L3ZcUcCcubpVWZZ+EhCl+3ciTt0sCdsB
         0+sOeGB1gFHap/oBdWouZmlPMdssA2lAG5v2Or+fsKORXLq0+B/NdOSzaj5aGwAP0v0h
         PFBX32ql4MALBdyyour5tNdASgQ0pBiAJ9/wQkQRlRMe47kHkd7qZBU3h9C05P53VB/F
         y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815199; x=1782419999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB0ryiF48Aa3D4YY1K3M3jr6tPS0m2V49U9nYCUalPc=;
        b=M0P5sCogoSuL+dJH08dKtmjiGC7TfFoFJYmz8evNhcjZ99rapSE5f1WPyGqYATsIo5
         58ncqAPnAItxuj1dn6Y1T4XT1wStxt0j2sSo7rpgaRkAqTUqrXXejud+hlkSjAQEvA3J
         4k/Qz/UADyQVtjH/2F/G7luG7zIBPvgKqQ/A43yrtLz2m3az4ZICxHTva8P3G2t0gvHM
         zZmSAuPRkktr8F94/pVBlBi7E8QeMQJXFOVUXhqPBV8JCz6hrSk2C4xQY3Dj246T7A/b
         65y+wAFKZYaiNDDJkSIus2BeAxlRy3jfUXCUcOhjq/QIlLJpAd0MmgHxvNfBY1Gy7Pls
         tJxg==
X-Gm-Message-State: AOJu0YwYMSm4piIhk5QjlXJGlckpEO6pVdgiPpfKg+Y6CKRczL6rMgmU
	7MCINtq94WfYRCCUohxOCX63jHFDEEjWN4VYUf/Il8eSrd781sz57612OF07xTgyfqg8JkTKaK2
	pyOVixg==
X-Gm-Gg: AfdE7clVXqY+NBwF0VYgx752R7yRylS0bBzIBkc3poMNcI6mNBUJ8myw+wt2Fyua0ll
	YUqVauVu4mHncqXSbYO66eIwGNZNpgtD3BbJYNM/E7p9hvxClhTJLmW3qlKvJgc2OyCYVSM6XJA
	cP+RaaMw/+iu19py6GJGmXL+ET7bE3BgBqO41JkVOj1GZUmYrvhnFfuuHtlEHvDPoYgxW8QvcXD
	crVM0II6v+jVgL31u/wuMQCw9GEsuRZ+Fo2e12bom9LowbkOBo95IL5SMaQ6OzhtDO/3yTVUnPg
	Cd/AOt/IphIrjzhtO8vOjS4qU8U/E/RHlqlyHhhd4u/D/BZx7Uiyr8oJNrdfONsNvq7n4VxxSTn
	oLWOVzpVzwBjcZTZFTSciYHZ6i8FmkaLCLtNjsptGIljfFFtJe+R8IU+C8Wn36On31oa6IK4up3
	i/GmlGNtQB7JqDxBry
X-Received: by 2002:a05:7300:80c4:b0:30b:e525:4702 with SMTP id 5a478bee46e88-30c0702f0c4mr820956eec.12.1781815198994;
        Thu, 18 Jun 2026 13:39:58 -0700 (PDT)
Received: from fugu.offblast.org ([136.25.5.185])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-30c06d5c0adsm505632eec.27.2026.06.18.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:39:58 -0700 (PDT)
Received: from beast (<unknown> [192.168.0.12])
	by fugu.offblast.org (OpenSMTPD) with SMTP id c4333d9b;
	Thu, 18 Jun 2026 13:39:57 -0700 (PDT)
Received: (nullmailer pid 1048605 invoked by uid 1000);
	Thu, 18 Jun 2026 20:39:57 -0000
From: Nick Owens <mischief@offblast.org>
To: bitbake-devel@lists.openembedded.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Nick Owens <mischief@offblast.org>
Subject: [PATCH v2] fetch2: accept sha256 revisions
Date: Thu, 18 Jun 2026 13:39:19 -0700
Message-ID: <20260618203918.1048412-2-mischief@offblast.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 20:40:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19745

regexes in fetch2's git support currently don't allow for fetching git
repos with the sha256 object format.

to allow fetching sha256 git repos, adjust the regular expression and
fix all of the references.

tested on my gitea server with a sha256 repo

fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=16322

Signed-off-by: Nick Owens <mischief@offblast.org>
---
 bin/bitbake-setup    |  4 ++--
 lib/bb/fetch2/git.py | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2829e753e..c1963c55c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -886,14 +886,14 @@ def get_diff(file1, file2):
 
 def are_layers_changed(layers, layerdir, d):
     def _is_git_remote_changed(r_remote, repodir):
-        from bb.fetch2.git import sha1_re
+        from bb.fetch2.git import git_hash_re
 
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
 
         rev_parse_result = bb.process.run(['git', '-C', os.path.join(layerdir, repodir), "rev-parse", "HEAD"])
         local_revision = rev_parse_result[0].strip()
-        if sha1_re.match(rev):
+        if git_hash_re.match(rev):
             if rev != local_revision:
                 logger.info('Layer repository checked out into {} is at revision {} but should be at {}'.format(os.path.join(layerdir, repodir),local_revision, rev))
                 return True
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index cd045a3a9..0fbd85441 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -82,7 +82,7 @@ from   bb.fetch2 import logger
 from   bb.fetch2 import trusted_network
 
 
-sha1_re = re.compile(r'^[0-9a-f]{40}$')
+git_hash_re = re.compile(r'^[0-9a-f]{40,64}$')
 slash_re = re.compile(r"/+")
 
 class GitProgressHandler(bb.progress.LineFilterProgressHandler):
@@ -257,8 +257,8 @@ class Git(FetchMethod):
 
         ud.setup_revisions(d)
 
-        # Ensure any revision that doesn't look like a SHA-1 is translated into one
-        if not sha1_re.match(ud.revision or ''):
+        # Ensure any revision that doesn't look like a git hash (SHA-1 or SHA-256) is resolved
+        if not git_hash_re.match(ud.revision or ''):
             if ud.revision:
                 ud.unresolvedrev = ud.revision
             ud.revision = self.latest_revision(ud, d, ud.name)
@@ -752,7 +752,7 @@ class Git(FetchMethod):
 
         # If there is a tag parameter in the url and we also have a fixed srcrev, check the tag
         # matches the revision
-        if 'tag' in ud.parm and sha1_re.match(ud.revision):
+        if 'tag' in ud.parm and git_hash_re.match(ud.revision):
             output = runfetchcmd(ud.basecmd + ['rev-list', '-n', '1', ud.parm['tag']], d, workdir=destdir, extraenv=extraenv)
             output = output.strip()
             if output != ud.revision:
@@ -976,7 +976,7 @@ class Git(FetchMethod):
             bb.note("Could not list remote: %s" % str(e))
             return pupver
 
-        rev_tag_re = re.compile(r"([0-9a-f]{40})\s+refs/tags/(.*)")
+        rev_tag_re = re.compile(r"([0-9a-f]{40,64})\s+refs/tags/(.*)")
         pver_re = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or r"(?P<pver>([0-9][\.|_]?)+)")
         nonrel_re = re.compile(r"(alpha|beta|rc|final)+")
 
-- 
2.52.0


