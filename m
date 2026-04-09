Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED79F364CD
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 22:49:56 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.144468.1775774987345873842
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Apr 2026 15:49:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=lLY6+OIW;
 spf=pass (domain: smile.fr, ip: 209.85.128.68, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso14813505e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Apr 2026 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775774985; x=1776379785; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCp7X+zzQKRrS0uXJz2ZYALmnKMQGKhPbB8DtuX+/PY=;
        b=lLY6+OIWxmG83En2gfxXzQhd93v/qAeVaUCk6WXPKiYDfoqoKH7NoEUUI5zioDgnzm
         gvEobY2ch3JNhqCIE9vRnFUyGJ8pd+mhdT5rL54NR4N8XBHTKF1Xf0weF7ZiDs/HiDgm
         XUAKNjF9Qy6XgMj6RpxnFla8yl2dxX7IzaJ7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774985; x=1776379785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCp7X+zzQKRrS0uXJz2ZYALmnKMQGKhPbB8DtuX+/PY=;
        b=ZtCfwrnOq+IpplkXiusP6mcOgCqOKqDMxhDS+Sw9pYkNPzvIq90N7SuehgjCQVnNXH
         PdFFNtbXnKd46mfsAST+M0vpRrsFLPdVNQiP9rPtDM6Iupj77k5QnJwQflWiqQH3YdXl
         bJ6HN7OJnTEr3oyMT0/umhpudnschtN6bYj1Vc6JJgyztyPPItlzmZLUUI8id7qPmF7G
         kB4j3gTxSPlCJMLx982utDDKanyDtWN1nYNYo4oKoNR6K5aduY7U6Ro+RSJIpyhD6mX2
         yMEzsRdYR6mOKTfUDLi+MXS2Z++mII695+cBfnblBtWMVVxtEQC9Y6oEQ9BSYjZ4aCXF
         ug3A==
X-Gm-Message-State: AOJu0YwCFIUjZ17fqkV8X3AyCqnwBSSQucx12skrkNXg+81vv8NNwryQ
	0tiDClRa7TBjXnw6uhWTJniK+ssclAeLXjP67N070as50+xINpydV6QJ+AzqQfilROncQc4AH9n
	3cRGE/2doCGiX
X-Gm-Gg: AeBDieuQEPicaBUhQS0Qw8rJ8fPEt/SN6ZaFSmEioRyAuzwP4nYK+3YjQLBpWmPmUEC
	dnEI+HUmEjJ3pvWvu/c69dAIXCm88l46zCRNsRCYu0LQRTb3kUcoxDrAUZzkwNOWYrQ9C/enfB6
	xD0LaUpw3WJ2BKz9C+AzYcpphsTQGvPyStAYjs7Mgua8ioubPa+cFlIVw6nCE/Xa+Qqa2g6tGWP
	nkWsr8SJmZX2TU1mVIcf+6qgG39v553cp8mYp5JQm8y5lBQN6w5+hQ/NBK1KMeShoxuSUsPehYQ
	Jvg/yEDpwGbioZXoX0IyK7dlfJDeXXBFBXBNGHEyyVnhr4mapS4J99Gpu4GYit9YjxEhU6RgoLF
	7O4V1b4GvU+YZspG4BeTUZsF0kB1oHQ7R1EfotQ/knyHa4/h/GfQ7w9KU7z5QUyplAApSVrxHqt
	7cP1ectt8eRfVf96a2b4skoACj9q3Tnkmqn9/E71EzepjLLfspjczS+PwF+JI4OOYCc8AUWeX9a
	IMckPRUNhzLyJPEhGcwmYyNNsjw
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr6240215e9.21.1775774985409;
        Thu, 09 Apr 2026 15:49:45 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00af4acfc73fc9518a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:af4a:cfc7:3fc9:518a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d6839981sm4234305e9.21.2026.04.09.15.49.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:49:44 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Fri, 10 Apr 2026 00:49:28 +0200
Message-ID: <cover.1775774593.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Apr 2026 22:49:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19357

This is a patch added last-minute to handle the shutdown of the git
protocol on YP/OE git repos.
Given the cherry-pick nature of the patch and the kirkstone release
build to do quickly, I plan to send this for merge quickly.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3631
(Build was impacted by a known and fixed AB-INT, I backported the fix)

The following changes since commit 8e2d1f8de055549b2101614d85454fcd1d0f94b2:

  test/fetch: Switch u-boot based test to use our own mirror (2025-07-22 15:09:57 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

for you to fetch changes up to 7fd0197fd5fedd23cc885b5e7e816d86a392fdf9:

  tests/fetch: Avoid using git protocol in tests (2026-04-09 13:28:26 +0200)

----------------------------------------------------------------

Richard Purdie (1):
  tests/fetch: Avoid using git protocol in tests

 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


