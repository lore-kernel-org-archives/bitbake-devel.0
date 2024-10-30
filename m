Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0597DD6B6B3
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.19870.1730306980462962808
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=U05z9uRn;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso66124a12.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306980; x=1730911780; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spYgx/nuIPeVluSg5lt7APvinCEOfzqxwQ9QBBreY+c=;
        b=U05z9uRnKx3V5y59fbJkYjUhVykjUn2n1vUVa2kNncVPRxV+fzblU/QrYp1USBogRB
         OI2McdGvDhZHKf/0mbYaSG3T6zbGnEl2E4W7Li8uT+tL/sOT9EfI61RwsvKDTvDjGjJq
         7/BKCad40LBC1rgdwB4WXlBhNec5eFziyNRhqVtZvXVDHr+j8sOqwBY4dJ1O/qVVHgur
         OAdF0E9UHIcWE1r+PbhwL4YyfKaj+wotDC2dwbVAnEweaJUg6SDUmQmTP7Lz2EcHGnvq
         Ydw06EnD6zCz2vJJtvfCA8+F4W/9FZjKlkL65bW+WPweUepMB94ueFE2UjFOY+xuwxJ9
         MhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306980; x=1730911780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spYgx/nuIPeVluSg5lt7APvinCEOfzqxwQ9QBBreY+c=;
        b=kMxh0pv0hGiQM5Oc5JzerVnmFBrccqkggCoWrWvQvvgNfpXWu2dcgKHj/NrJ2yeXB5
         Ilo2MVlJG/W43FqYjlGYdXrzIXGtcfdDhNDyIuudrwV6bPlLrp343Dzg8TZR6O7SfH+X
         Q/0rSrgCs/O5W4ZgcCMKCd3vzRJzqNgpvE9fPxIYtS2cZFzzF1+5t5TUyhgxVWMjF/fp
         AYdYRPFaDJUIxQL2kEmdR6SVQX3YrB/qf7FgMIW5PU8CucZFHDy+fF9iYzjcQ8hPF1/t
         eSBRQYxxzZrsuQ8vChSMglnWr1eDHIF7WQirzUUeMVW8NCVuMoftDv6ev5rXtnYRKy9O
         PFqA==
X-Gm-Message-State: AOJu0Yx6K0s7XYQcR5jbl5XYxJnwJjyZG0u2gABxNnYv0vzc9cQ5hy3a
	7TS4Aq5pZ14t6T6Z3yLTkYLnKaueZfh6E0fgVqNbSwQPoLCjFRiPyCKkU1R/0L+7B9r6q5BOc/Z
	C
X-Google-Smtp-Source: AGHT+IGADYGP+9f0aD67CknC4gTOrsqCXmHwzZzEyd6l052HTYtULbemLzDZts1Xb82LKsTzFSbZWQ==
X-Received: by 2002:a05:6a20:4391:b0:1d9:11d0:1215 with SMTP id adf61e73a8af0-1db91d86c59mr38866637.13.1730306979606;
        Wed, 30 Oct 2024 09:49:39 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:39 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/5] gitsm: Remove downloads/tmpdir when failed
Date: Wed, 30 Oct 2024 09:49:26 -0700
Message-Id: <c71a003c93cf690c9812e822ac4e557146a567a9.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730306845.git.steve@sakoman.com>
References: <cover.1730306845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16752

From: Robert Yang <liezhi.yang@windriver.com>

The tmpdir such as downloads/tmplp3cnemv won't be removed without this fix.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2ba8d3214759142afc11f0a88d80eb30a8bcde3a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0699645fb..488e99cde 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -144,9 +144,11 @@ class GitSM(Git):
         # unpacked temporarily so that we can examine the .gitmodules file
         if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
             tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, subfunc, d)
-            shutil.rmtree(tmpdir)
+            try:
+                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+                self.process_submodules(ud, tmpdir, subfunc, d)
+            finally:
+                shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, subfunc, d)
 
-- 
2.34.1


