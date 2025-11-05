Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ACCCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 14:46:57 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11204.1762354014887826404
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 06:46:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=zhvBq3v/;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1666189b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1762354014; x=1762958814; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJbbG65S9mW3cSFpJvcaqZDgOXlEvIcs1kWSLFxy1ag=;
        b=zhvBq3v/4++siKhALZkTjDCAWMnE2epFJzgG/zckgL98Dyvbg6Jf5sU654MGzZzhji
         /AJdCUNOO7ItJfv5DuoU8qXASv1Ds9+HFVcfXd4NaWvpyCC9U6CkY2ng9Tyj/SNzAGrR
         +DENO3S8+w3imOBQMh10vZHCJ9I460TqFdULa3+EfLFZtgHxBkD1r8Pry+4iPXciI2ko
         nqgBvLR7APiu9iqjWB7n+niUAJI/ED7RSpOyCHhiqHo25z1Sw1eIiKh7QHZZ+4AqGlgc
         zr+0PEwimE3cPMRQfezuUGZKyLl/5OjzE+sgeDFBM4hWmz+Z3yEL6KtoxMq0rzK/1oea
         uQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354014; x=1762958814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJbbG65S9mW3cSFpJvcaqZDgOXlEvIcs1kWSLFxy1ag=;
        b=C1vlkC3w6EIjDj13XaUrU3U1QrwGNBWagSOYLKyH+TwmZ/1/lEXG2hKIt1rbwlCvYn
         NGrWJjfPoRQa8k02U2kzwcOOygHRyJzKdUwEmF0EGdzWHjSnhHAYcab0/Hvqe7WSHxfW
         FuNY+Z+3TXdBmYPgHkkOPSaD1oljq+QYtRLpJWem/ESIYlzsMPh/lLW6C3nYvun5DUnq
         B9+tBSDJdVr3gGUEcX6/S5hqjzFT3V2emd2rb8MVMvOoKLpr/XodZE1Z34Tch8yfgTta
         jFkeqqnK6BVoqxIWcbcBXNzqWKvShMCJqoIrtAtAOJFS9lAbyaxDPEAgSHRTlp9fdCxa
         Sasw==
X-Gm-Message-State: AOJu0YzzrdKvXOZ4f2SsZGNUflBwqfCvB3JsV7xzuj+jDuk7JqFuCGq4
	oR9u7S/ah5CSkAI0gdeKKGy6bjzlVFUk9l2v+p/tCJ1Gv1vwzGOVboM1KjvFN0m7MYtnsOwWjaT
	1kSQGp70=
X-Gm-Gg: ASbGncvMqqZYSzn7rPs9ln70P19cQRIz22Tos+KEmf87oamrRagDdgLGwm+e0zbumDi
	bTWZPQ+1hLiQoapB/zS1muni00esWraAz+mzvnvvEl10+s/9oKk1URPI6RsZbaplwbJGhpxubVE
	zQfMdI8DizfW/onpRio+hQyPodipGZwMtLEt/QSS8uuILhzvs9HIAbeta52XhyY7+EjTmWMzL/g
	oEVUWGk0d+KRdruhGPkvtlGcpaOW6bGj4jE7MFfsJ43PIqXujz2PfKBGPfEGcaaR3kPe84LffJ/
	889u8TJF9ENXFvtyPZCnZ28alXxu45ZpKHZrdfbnzOAHaA5t4lbcRmd6lXkKbbrXzGSq8lh4bDa
	PgSPQ5BLUJ2YN6xdbNpRO/8ghUnu4q3G5mvoSOUpVPE6zouY0w9RDY+DgWima26Xfxis=
X-Google-Smtp-Source: AGHT+IGa0vHMOmj/MGnpAINjN5S6M0kSEyTMzTJi/DjR1+6BdyVKdKaMNk6Ltz/1kSWOD4T6vNvY+g==
X-Received: by 2002:a05:6a00:80f:b0:7ab:5d1b:2d12 with SMTP id d2e1a72fcca58-7ae1cc5f685mr4166228b3a.8.1762354013816;
        Wed, 05 Nov 2025 06:46:53 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:56d2:561d:76c2:db7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3921584sm6589449b3a.25.2025.11.05.06.46.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:46:53 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Patch review
Date: Wed,  5 Nov 2025 06:46:47 -0800
Message-ID: <cover.1762353905.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 14:46:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18263

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Thursday, November 6

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2676

The following changes since commit 1c9ec1ffde75809de34c10d3ec2b40d84d258cb4:

  bitbake: Bump version to 2.8.1 (2025-09-17 23:22:33 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

Philippe-Alexandre Mathieu (1):
  fetch2/wget: Keep query parameters in URL during checkstatus

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/wget.py     | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


