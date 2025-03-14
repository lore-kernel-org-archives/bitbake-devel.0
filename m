Return-Path: <patrik.nordvall95@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F0C28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 11:26:54 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.11975.1741951609532695970
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Mar 2025 04:26:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RZ23mP3o;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: patrik.nordvall95@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30762598511so20606331fa.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741951607; x=1742556407; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCH3IgTp5JX4bp3o7eafq+kE98W9kC2LexejChYoiew=;
        b=RZ23mP3olONYYxo9/qg/OZulfosYhvrJBjoVJYYxlzUDHpo7UjZPwO8ZqfWwmvNA9U
         E/nWeqn4ktn/FEjfByaTVCD0KyfV3aG7wDcTa2qhVEVHIIiPU7U4IbKUZpXPPMzaGNeu
         FsGrsLbaFaGLXmVHZyLxQvkJEcT5okkMSJVs7xl4jMnYzgcFT5qloQrfVQ7dbBDre3ef
         mjPb/aGDGrI2PPijx5y0050Jm8XwNSBaPaVFQ0hYeW4jsOfHU0pAoNI5g24dGFDjl3uR
         qm+X/AvdZaM952kJpLwBSuJdQaT40xWkXGtqpw4IHAx8S/ByrSlOT+UA7+OxaFBHAll+
         5s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951607; x=1742556407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCH3IgTp5JX4bp3o7eafq+kE98W9kC2LexejChYoiew=;
        b=mQXoZBK93G87R0CxD5kZ3YUG9NdUk8ZwJQyVGptWPy6+homc/LSrsEdhHAXOHDGxWv
         ApQuNiVmTG0EH8NCA2s7ahZ3p4z5tOrhb8w1B9DquGp9qYYHl9/OwxlS+q9neZI7exPX
         QB/vtgo7cNuKq2d6EbvFsbI6bNhEpVsdv7zrR+UAwozbHImmsFySF64Yk28IEJadrmLq
         b8nZrYWMkZ20Qragze2j+sXZ7K6lG+tRS55bDaVKUkALgdlePvJ5E3P+1ymWrIgXsaQ5
         76PRyKPL4px2RWAiK2A+GoCvAtCqCJSbKsjl1XY5G/FzPvUukXTJ3PbIDa4lTRmhYhJe
         c74w==
X-Gm-Message-State: AOJu0YxaaZ7c8/C1DBCeEOENygx15C7iGHp4m2Mn8waUqGuoxCb35ncC
	WOOrw6vtSXco7Jk1inDQlly6ePbnTu5zqE9aTgD2aRuiHW11FsN6FJ3dW7t5
X-Gm-Gg: ASbGncsAtO4XbA94DGM7zzRxuWwpClsJoda65dzxMZmEuZbtBmmKH2Z95Z+cJs5m0FH
	S+mDRmItIMsaak6YDje7Xtp+CzJnRavfCOECFQHsjfKzCWd5IJ7RYwzIraFgeYiUyeX9eh1vnci
	4lUAhLzhfw0xVbe6qdv07J6dJDkqAPgCzdmZIEHMgn8SzCrLnmQusuPQ55YqXHsYbNRoQpBh7tO
	N5b+ibH2NCxQ7+X7JHRJX+98lv+zYON1B0aLjQtVrzFX8xPCTaDyhv6wFYUeTQ88MLdCZfQcMoZ
	JypzIXcHwVrdcFXWP1DffFkMYr47qxN1GvBGKwnd0T+7S+us2v2/PmjFqYUnbWzB6oIVkaUaFAV
	31+PaxdJyRqGqL+vRmNaTNY4=
X-Google-Smtp-Source: AGHT+IF7YV7HTecl4mvOntGdRHClLh41ZXSFkF2kIQrNdDVYCU5FzEH8BOaiIR/4PooKGtfKUnZ1yg==
X-Received: by 2002:a05:651c:1549:b0:308:f4cc:9519 with SMTP id 38308e7fff4ca-30c4a74e104mr8071181fa.5.1741951606751;
        Fri, 14 Mar 2025 04:26:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-3-54.A240.priv.bahnhof.se. [155.4.3.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea489sm5257861fa.42.2025.03.14.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:26:46 -0700 (PDT)
From: Patrik Nordvall <patrik.nordvall95@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Patrik Nordvall <patrik.nordvall95@gmail.com>
Subject: [PATCH v2] fetch2/git: Restore escape quoting for the git url when used
Date: Fri, 14 Mar 2025 12:25:59 +0100
Message-ID: <20250314112559.3039730-1-patrik.nordvall95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b0f7694992b86e8035175a0bbb0e2de731dd1b94.camel@linuxfoundation.org>
References: <b0f7694992b86e8035175a0bbb0e2de731dd1b94.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 11:26:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17446

This fixes a bug where escapes in the url path would not be properly
restored for the git commands in the git fetcher. For example, a
space which is encoded as '%20' was not properly encoded before the
clone command.

e.g.

SRC_URI="git://git.openembedded.org/bitbake%20example/bitbake;protocol=https"

resulted in
git clone 'https://git.openembedded.org/bitbake example/bitbake'

instead of
git clone 'https://git.openembedded.org/bitbake%20example/bitbake'

Signed-off-by: Patrik Nordvall <patrik.nordvall95@gmail.com>
---
 lib/bb/fetch2/git.py  | 3 ++-
 lib/bb/tests/fetch.py | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5b678827e..aaf571eb6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -81,6 +81,7 @@ import shlex
 import shutil
 import subprocess
 import tempfile
+import urllib
 import bb
 import bb.progress
 from contextlib import contextmanager
@@ -828,7 +829,7 @@ class Git(FetchMethod):
             username = ud.user + '@'
         else:
             username = ""
-        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, urllib.parse.quote(ud.path))
 
     def _revision_key(self, ud, d, name):
         """
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 68b2dbba9..6ea7afc17 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2473,11 +2473,13 @@ class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
         "git://tfs-example.org:22/tfs/example%20path/example.git;branch=master" : {
             'url': 'git://tfs-example.org:22/tfs/example%20path/example.git;branch=master',
+            'repo_url': 'git://tfs-example.org:22/tfs/example%20path/example.git',
             'gitsrcname': 'tfs-example.org.22.tfs.example_path.example.git',
             'path': '/tfs/example path/example.git'
         },
         "git://tfs-example.org:22/tfs/example%20path/example%20repo.git;branch=master" : {
             'url': 'git://tfs-example.org:22/tfs/example%20path/example%20repo.git;branch=master',
+            'repo_url': 'git://tfs-example.org:22/tfs/example%20path/example%20repo.git',
             'gitsrcname': 'tfs-example.org.22.tfs.example_path.example_repo.git',
             'path': '/tfs/example path/example repo.git'
         }
@@ -2500,6 +2502,7 @@ class GitURLWithSpacesTest(FetcherTest):
             self.assertEqual(ud.lockfile, os.path.join(self.dldir, "git2", ref['gitsrcname'] + '.lock'))
             self.assertEqual(ud.clonedir, os.path.join(self.dldir, "git2", ref['gitsrcname']))
             self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "git2_" + ref['gitsrcname'] + '.tar.gz'))
+            self.assertEqual(ud.method._get_repo_url(ud), ref['repo_url'])
 
 class CrateTest(FetcherTest):
     @skipIfNoNetwork()
-- 
2.48.1


