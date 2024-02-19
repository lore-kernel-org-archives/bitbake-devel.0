Return-Path: <andre.draszik@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8053EC54764
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 09:55:10 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.38341.1708336509059329293
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 01:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ZJ9inIkT;
 spf=pass (domain: linaro.org, ip: 209.85.208.46, mailfrom: andre.draszik@linaro.org)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so1456270a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708336507; x=1708941307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHxRjCBK/uR7HGwSQJcVv1v+JPepSpJd1dpfiJsPRbY=;
        b=ZJ9inIkTYw+/aH5he+JTuU0Wf0SdrLJtLolZNa69yC0F+c8UsQ/irLV0iVGZLgjE7I
         yeBNsr7fpghOIhTTkMQUoTHOEtp8V6JtnYRGiJYta5OKPHTa31ADJcbj4LGn+kBixxAh
         LYUaYQxya2M8gqfTGcguPyOmj+qDT/bM94XHQKIKBvujgojB3ulYQpJHmAOwiT2LdT2O
         xBzsZeHkJmNoyTMWPTZoj6H2EPmI3eXQ1gxqv4e6tKhxR2luLID5KxFjQf/uAED8IP3U
         o+Fshx6lJDy5wn9v97C46tG4z5dGgB+zRJlK4aTM9J+d1+bKG3l5DFG1am46hv14tJNN
         H8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336507; x=1708941307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHxRjCBK/uR7HGwSQJcVv1v+JPepSpJd1dpfiJsPRbY=;
        b=ASXle32epCJpDYU8S8U0eBw4Ykm+QhC5H6eueNCsCIj/CPbtWdBbv7vlxLk1ovzL3q
         I2XFj9t3V0vJdnLmmgNeaugOdjr4tYBontQmE9vAOxZeUkxwbce2NAIpm9jxuF3SA7z0
         C722l3iCgCS/pX/hzQD7kq7SxlBbyaUfZZfwiqMWies/wSsxGjWuXoxba+JF9dm7VJJM
         7zi1E3bGMc+IBD3o8NhW+FPrFvieKCtViEqhutBMaNtBVNM8Pwi1xayi3gR0VixSVsJS
         gqDXUpfXn92ibBLpo2GZ80MDhvZP6RHEH03thUMd59WryoUkchQSHADceYuwASTpX5GM
         I4VA==
X-Gm-Message-State: AOJu0YyP+9MjmqqEo2mIe8lPYZ6E1X9BqezTQc+PFBUNLTMryuuK1a4k
	LffTweNBgOCyyZUAALirfHYD8nYBOwYvEae6+YCcKLkhdxw9tDirFZpwIzCfZq9k01R5mPBawvW
	scSA=
X-Google-Smtp-Source: AGHT+IFawyHPTdgz+Jp1tAlylhLW4ZZImY04s6k4VVErckyv4clzr1VbhRE/b97rzReAL4v2NYgbnA==
X-Received: by 2002:a05:6402:5518:b0:561:ee53:504f with SMTP id fi24-20020a056402551800b00561ee53504fmr13903960edb.5.1708336507288;
        Mon, 19 Feb 2024 01:55:07 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b00563d03030e8sm2527526edm.55.2024.02.19.01.55.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:55:06 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][PATCH 1/3] fetch/git2: support git's safe.bareRepository
Date: Mon, 19 Feb 2024 09:52:12 +0000
Message-ID: <20240219095454.3211974-2-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219095454.3211974-1-andre.draszik@linaro.org>
References: <20240219095454.3211974-1-andre.draszik@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 09:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15936

When git is configured with safe.bareRepository=explicit [1], the
bitbake git fetcher fails miserably. LWN has an article about the
problem that this configuration option addresses and why it is useful
in [2].

It also seems that it is being rolled out in some environments as a
default for users.

In order to allow having this configuration turned on for a user's
environment in general, the fetcher has to be tought to use --git-dir=
for all relevent git operations.

The alternative, implemented here, is to forcibly turn off that option
for all git operations. In the future, we could look into converting
these to using the --git-dir= command line argument instead.

While at it, fix one open-coded invocation of git that wasn't using
ud.basecmd

Link: https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/config/safe.txt#n1 [1]
Link: https://lwn.net/Articles/892755/ [2]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 bitbake/lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0deeb5cee1f2..842f1c689697 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -258,7 +258,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat -c safe.bareRepository=all"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
@@ -514,7 +514,7 @@ class Git(FetchMethod):
 
             logger.info("Creating tarball of git repository")
             with create_atomic(ud.fullmirror) as tfile:
-                mtime = runfetchcmd("git log --all -1 --format=%cD", d,
+                mtime = runfetchcmd("{} log --all -1 --format=%cD".format(ud.basecmd), d,
                         quiet=True, workdir=ud.clonedir)
                 runfetchcmd("tar -czf %s --owner oe:0 --group oe:0 --mtime \"%s\" ."
                         % (tfile, mtime), d, workdir=ud.clonedir)
-- 
2.44.0.rc0.258.g7320e95886-goog


