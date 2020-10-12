Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.678.1602515296214936036
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2020 08:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=OybeGtIW;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id w21so5977268plq.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2020 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Y/Rp6UtquiyznC4OrRTchZ5Xo3a76p6n26GAqTWTPmo=;
        b=OybeGtIWtQhdyH6l9/oNJQCm9P1ANyGJV1RegG37wBfOMw1MzMafmZra3mWqaqO5jI
         rLrtv36cVeEkDoUbCACQQbr3s6iNLZl92ztI3N0b1AcLl29F4JIcLIU+DySaVd2DPg3y
         dX9C7JZRC5IQkvzGyUxEveoFQ1/iYrn2LWe4WWv4kg96zbEV6F9l6FkyEexohy0m3Y5t
         dELl5g3dFs4Ktz6Q1mSVhXRH/0jyRyN/Gxd8uM8rVAi5Vt7Nc93LqkzpV+zBfa2Kihxf
         AHTVoBCdVhN2ovVD6DCzC+8K0QXUiOPPhvq0pCzUcBqSmZTfPmC8onsQdhQChw8+ihbM
         SQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Y/Rp6UtquiyznC4OrRTchZ5Xo3a76p6n26GAqTWTPmo=;
        b=InrK5gVqCqADR28pgAtLmtJT8a7/8gL3CsBhQupYACugMsN447SsiuSBpsxXY1HSeJ
         2YvhAu1foO5Rv1sJY5eEseySaRNTcJKXQOsSBP2KJeXn/NhEl4q5aan1L4VyyCdCnW+Z
         2/ixnfUKnLyQGsBRW5cJnyihWUjYFOH2p4Cw+B9ZJWcU0Va/S4FSB6TZV7x3ytq2kwP+
         Rp8wKqsOVsMo4yFH93Dz4bzLcqwMLEp3IzL9sD1pMZvsNhPRhQ1sCjB2VAnS5LO+PbRk
         yB+8I+QHWd2QO83DRb5y1QnHP6pxuJjWHSs5xBlfdTaV0h9QGC92eZycGXB61YBqoBOK
         uRDA==
X-Gm-Message-State: AOAM530xS0y7bHw6GQ2XS1hUFIv7j+9ZqA684hy3dQzPMeIsJ+QCKxq6
	ppfj8ENwFizMELElUHSeWU63vcuq37HYyMP3
X-Google-Smtp-Source: ABdhPJy3nfqdDsxIGrog9FQo6zGDH/UTfOah4sOz9TOIZQzMB9GVKNyFhMzqPImkhjtV1883okwgIA==
X-Received: by 2002:a17:902:d213:b029:d4:d273:d40a with SMTP id t19-20020a170902d213b02900d4d273d40amr9004921ply.76.1602515295054;
        Mon, 12 Oct 2020 08:08:15 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id f9sm24009246pjq.26.2020.10.12.08.08.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:08:14 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] bitbake: fetch/git: add support for SRC_URI containing spaces in url
Date: Mon, 12 Oct 2020 05:07:52 -1000
Message-Id: <0a8a13131b2d520a405877cb9d39f3eae7d6882a.1602515077.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602515077.git.steve@sakoman.com>
References: <cover.1602515077.git.steve@sakoman.com>

From: Charlie Davies <charles.davies@whitetree.xyz>

Microsoft's TFS VCS system allows for spaces in a git repository url.
An example of a valid url is:

ssh://tfs-my-company.org:22/tfs/My Projects/FooBar

This commit adds support for such urls by implementing two changes.
Firstly, when bitbake makes a git command line call the url is
surrounded by quotes so that the url, regardless of spaces, is
treated as one argument. Secondly, additional parsing of various
filepath variables, which are based off of the url, are now
completed with any spaces in the url replaced with underscores.

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit eb38b6f0935763f7ba19e5618f376fcae1dac41a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2ce9395f..dcecff5d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -236,7 +236,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
@@ -342,7 +342,7 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd = "LANG=C %s clone --bare --mirror \"%s\" %s --progress" % (ud.basecmd, repourl, ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -354,8 +354,8 @@ class Git(FetchMethod):
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
-            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
+            runfetchcmd("%s remote add --mirror=fetch origin \"%s\"" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
+            fetch_cmd = "LANG=C %s fetch -f --progress \"%s\" refs/*:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -501,7 +501,7 @@ class Git(FetchMethod):
             raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(source_error), ud.url)
 
         repourl = self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
+        runfetchcmd("%s remote set-url origin \"%s\"" % (ud.basecmd, repourl), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
@@ -613,7 +613,7 @@ class Git(FetchMethod):
         d.setVar('_BB_GIT_IN_LSREMOTE', '1')
         try:
             repourl = self._get_repo_url(ud)
-            cmd = "%s ls-remote %s %s" % \
+            cmd = "%s ls-remote \"%s\" %s" % \
                 (ud.basecmd, repourl, search)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
-- 
2.17.1

