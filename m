Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A57CFA742
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 13:45:08 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.11706.1728135904062699508
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Oct 2024 06:45:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=pJopUML5;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.173, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so478717a12.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728135903; x=1728740703; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/VvMUnrpLzefVY0jP966Q2lBB8psSFaxQ7klS6H9VU=;
        b=pJopUML57uXtDV+q0aS1Cx8hxNepIib79CIrtRAqxfAk/YdZxGxiSsdRAkj7ZVNF2r
         90kBypgYyyw1Sr9NZjVvZMp79VcIIL2Xb4oxdinqDMxvi1qPvYbjwKJ4atKdGYWZrW0+
         za+h0LLgXy3u5pWzcLzP0tTaRgaH6Sz52p8S3orNvdIpyx8k3+IhdblNC8pLSWQbkLHv
         s65DoAtT76xAgdQcKioyl5NLRoYPggbq118OzHZzq5KJ6oTlrcAlUMhVyZdWaHxMYXiP
         QUJYNGX6ESpbQtU5DLCwOlaeLQOUA5wDHSCxmjpS4conhNEewsD8X33S4odpzIiBr5rl
         DkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135903; x=1728740703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/VvMUnrpLzefVY0jP966Q2lBB8psSFaxQ7klS6H9VU=;
        b=v/Y+TesVTiTTx3IeMFlAjVW52g8GR683HZ9a+kkpjGc+9zJfIXFsJP2cb1+0g6UNb0
         z/a96GryEixgYOkJKt/yDBau3awRi8Qjo5UZ0pOA1dn14pPOmmKwBI/24KduSJQdqbHl
         9gvCJK8Tmm0YVdDmV4C49VzzW8OOIo6iywJrXiBBiMFvqIjfH8Br5I+WnYsLXB5d7QzG
         X9y5UjEUx+keeBGxC612swbcqd00kUJmjfWXUmL7sGE/mWb8p1+1IMyQq2iaMAvY/+zI
         yvnW2ihzEHAYxxtYdcpSaoVyypXptDrqmWamQ+GJHtyBy2WJw2byzD6/W+YSa3+J53yO
         /22A==
X-Gm-Message-State: AOJu0Yyk8X/SPqhqX9Q+3r66qHmcjIaqi4VQEPRuuWyU9oSV9lsDWj0j
	KwdRM2cXZ7Hy0f6eJrJV7wvAEyenUWzJ+/zx1fSRTLAafDjb+cE/JJtQdjlJC4I9nYpzqxs49Q0
	U2DU=
X-Google-Smtp-Source: AGHT+IG5i6BhS7LPrD8sGPXs4G3HDIfE1tc5vcgJo3i1Qaaca5eswrGeFfARXnsBZ5umb3zNFK6kWg==
X-Received: by 2002:a17:90a:b805:b0:2d8:7804:b3a with SMTP id 98e67ed59e1d1-2e1e631ef6emr6974022a91.26.1728135903299;
        Sat, 05 Oct 2024 06:45:03 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm1831617a91.44.2024.10.05.06.45.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:45:03 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/4] fetch/wget: Move files into place atomically
Date: Sat,  5 Oct 2024 06:44:50 -0700
Message-Id: <aaf9c1b8673f5b181255a08eee4e9a342863e896.1728135724.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728135724.git.steve@sakoman.com>
References: <cover.1728135724.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 13:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16643

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cd7cce4cf4be5c742d29671169354fe84220b47a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 9bcb0d4b7..708f3a42e 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -109,10 +109,9 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        if 'downloadfilename' in ud.parm:
-            localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
-            bb.utils.mkdirhier(os.path.dirname(localpath))
-            fetchcmd += " -O %s" % shlex.quote(localpath)
+        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile) + ".tmp"
+        bb.utils.mkdirhier(os.path.dirname(localpath))
+        fetchcmd += " -O %s" % shlex.quote(localpath)
 
         if ud.user and ud.pswd:
             fetchcmd += " --auth-no-challenge"
@@ -136,6 +135,10 @@ class Wget(FetchMethod):
 
         self._runwget(ud, d, fetchcmd, False)
 
+        # Remove the ".tmp" and move the file into position atomically
+        # Our lock prevents multiple writers but mirroring code may grab incomplete files
+        os.rename(localpath, localpath[:-4])
+
         # Sanity check since wget can pretend it succeed when it didn't
         # Also, this used to happen if sourceforge sent us to the mirror page
         if not os.path.exists(ud.localpath):
-- 
2.34.1


