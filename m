Return-Path: <mischief@offblast.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A9CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:09:37 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16163.1781777371761144078
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 03:09:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@offblast-org.20251104.gappssmtp.com header.s=20251104 header.b=CNfwjIyz;
 spf=pass (domain: offblast.org, ip: 74.125.82.46, mailfrom: mischief@offblast.org)
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13986d61b4fso899591c88.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=offblast-org.20251104.gappssmtp.com; s=20251104; t=1781777371; x=1782382171; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21MhppHC58E5R7eRWZaY8bWY8d/IhyNnDHho4iDZmiw=;
        b=CNfwjIyzkR65oo4sCjPCzW3/p5BJ0xsAnZktu5c2soUK4RSd9gqyqC0DkmGdTfjEmz
         xDjoE+kHxBcMmm/8B4VaQDoMwRuzapJTUtIFR4LvvCLYwg/ohnL4SbLdkUUnHgFxQioU
         WQcYnEu++2S5XLITCmKu33Uv83Ut5iKbDK3+3mvghA1mcPyiW4oGeurqlBnku3EztYTh
         KDxIxPwqpeZnffX0hVCMFED2YJNZmxz72yQ85L6GESKH11I3vaZnR3iAkZh9zndbQfvM
         QpW6WcpRjnNw3lQILzmScj02PRskTRnIKOSK2wurCmSL8Y3gN/Ib4eET1f0k113OiSSU
         ukzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777371; x=1782382171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21MhppHC58E5R7eRWZaY8bWY8d/IhyNnDHho4iDZmiw=;
        b=Z9QO1GFwFa/NX8UDrBQlqUSagyRV8znj4CyTtNDMrx4gtHZ7TZuM9dqD1KTAcmQYJU
         7SYoIm/BdXB0QTg+FxteAJOOeXwks+m4SxnZyWvJXO+6I0EgrMuhqPddk1kTcCTBnahD
         1lAlJvZ16bx/lGUVt2hhkt7kUfaFxEdLrsC0hWZ4jlvcUTVUCpUdy04pmJPGh4jklO6L
         aG+qZb5yRnTpcqFHGyZR8WHFntzzxfE6WdRQyniW+LQnLlf4YkeSaMQdNFh5X284ZX9l
         skIpUev1hWAJoKykj01+tKTD9lMEvhF0wSVVE+yE6J7Sw3F1cW0GhV8+i5Z6FNJ6UwkA
         Vt3A==
X-Gm-Message-State: AOJu0YwT6d6AW0NuTxOebQi2i5kmNqT+ipP6KhOeUyotZdH6K6tIoaFO
	lEXdIxXerSk1ifOttUNJ3D26bke6qzi0fkAPVXEMqwrLPrPJPv6/8gQYH/HromXVhg==
X-Gm-Gg: Acq92OHKMwxpzeNFXJW3zjSBgTMiXvIwJmSynjiIn0f+7999H4owk2doLYtnfDLKs54
	CKBVKzPJA8C439e2hWGaQ5PrJN/oaG9okAediYxMXJewReFPocwxd0/sReuwaQmWI8/pH6FQfYV
	kP/Nu5TA0vxYwdMQQcB9qWS7WZKl3ax9b8Z/3p2afGkjPvEoCtS7A+P4s4JX5+uQIMqOx9gqzx6
	HV5v1obIZVMY8dfBvxXS3ynEhuUVUPm2U39hq4x4l4lrFlV2qruulVB8naP2KghMCMom30HhOdw
	zR2li96FML/QEVB+Q4UWPCHctEwMYtkwRdYZCFozCYll1AXeJ91vPktYdQ80/7NbApGe4vW7qFb
	jiay8uTUYhy+nANHFhNjDm7LnTFrtP/IWHBbsGS08FKCceXFsS0L+B0541tU26hVNpSyevpMUqF
	9xfsp9vXfWp2Sx0L5C
X-Received: by 2002:a05:7022:386:b0:139:89ad:8de6 with SMTP id a92af1059eb24-13997c5c054mr1630531c88.35.1781777370814;
        Thu, 18 Jun 2026 03:09:30 -0700 (PDT)
Received: from fugu.offblast.org ([136.25.5.185])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1384b8fbde7sm18177489c88.2.2026.06.18.03.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:09:30 -0700 (PDT)
Received: from beast (<unknown> [192.168.0.12])
	by fugu.offblast.org (OpenSMTPD) with SMTP id c3d35029;
	Thu, 18 Jun 2026 03:09:29 -0700 (PDT)
Received: (nullmailer pid 231457 invoked by uid 1000);
	Thu, 18 Jun 2026 10:09:29 -0000
From: Nick Owens <mischief@offblast.org>
To: bitbake-devel@lists.openembedded.org
Cc: mischief@offblast.org
Subject: [PATCH] fetch2: accept sha256 revisions
Date: Thu, 18 Jun 2026 03:09:04 -0700
Message-ID: <20260618100903.231245-2-mischief@offblast.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 10:09:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19733

regexes in fetch2's git support currently don't allow for fetching git
repos with the sha256 object format.

to allow fetching sha256 git repos, adjust the regular expression and
fix all of the references.

tested on my gitea server with a sha256 repo

fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=16322

Signed-off-by: Nick Owens <mischief@offblast.org>
---
 lib/bb/fetch2/git.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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


