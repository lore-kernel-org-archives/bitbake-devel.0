Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E97DD3EE70
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 14:56:09 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39237.1769093760350015450
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 06:56:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h20khBd6;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: michalwsieron@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1394765a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769093758; x=1769698558; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9+LBuKSlno7CYXfnHEa+sMueQYd46TI4vpKx1WDzWg=;
        b=h20khBd6jfXa8hYrRhaPxqxYJchZhj2UgcD5tdMGh30ofISu4xCLkijZA391L5mI5t
         kykWF2XwcwxBfLrSEr7fv7n891G98U8jUYoBGl+BU4iuP31m2KqSUSA7oxvFvFZz1klB
         o2iIIhyor2yiHj/JeP6dBRcZxToRg5i5W4Q/5t2hCVWkXg0sggMpNBp5ylxcq2gs+2SQ
         7wlx5OJrpYGKlRbxSlHq9LikmX+IVvVz0eOc+jE4k4cMjdCH5f+fGWQRGRI9Gs47Tfpg
         x7C+HqKguPo5YaMnmGU14xU/oqtqYswkpAx1lB7VsDnFTDJzvOo2TvpQLcjqTRe0+k7K
         XUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093758; x=1769698558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9+LBuKSlno7CYXfnHEa+sMueQYd46TI4vpKx1WDzWg=;
        b=QHrncy1fMEJmxf0vtmkmsr4/0CSlOB9/wVdE+17lZhpzRgiRtA0epGtCK3LoTUC9Eu
         ais8GZ9XA1sGnCUCpVWRJUFTF6CMXct9MGj2ZjTsqFzhx6aIgmjfIMWIEa1XshCq2kkY
         XYO+ckKgJ1ZMHdM1HxYoCRlE8ocVQREt4MZVkXQz5VQrDlKwjW8HiN9xeY6FmRg69ShG
         /Gxj6qOVvEpan6bzeysaQ4bkaZzOoJXaJbEITTvqh4CD4D0Fz73fXz0hzb7nVyl8dMXa
         S+BnoMMSlxEIulIQtz18hLkJKgnHZ8YQZRG57X2QkphwY+/4foji2pND5jM94U/aI1J7
         t3Aw==
X-Gm-Message-State: AOJu0Yw3k9zLnUytyrKgEXPnB+RVQHOQQo+TXg3sjjZcb2aCmfcCJ8pF
	lJUPi1nsqhZFqkgV9kPv2gseEHAGRld458iL/z/6QwATlcFfisem99YTPnMLNw==
X-Gm-Gg: AZuq6aKdo258OloEc84RgXSeIlBsdj5lUKt9QoqIQiKGhX46VSi4eIbim1BqvrvP6KL
	wA7zlMHZsScriUoV4E7b55w/+g7FfBMmDl83Hf0M40KcCDKJzKwXG4q0J8eytuCvePl3GhBzOM5
	EjpsgAERzzLjUE7wQ8jErGFH57y3sLmDVgHy7pUJfYlw56lbPhASQ4J7YlEhTWCHKLa9Utxp5Zg
	7RlnHbD6sIjh+MqW3vP0CAv2CE7Wry4oC1WCBHrhDlfXrT8oswQbtfo0jYdxQJ1bS59rUvC+1q7
	09368riUEgOkND5RG0Et8NbCmobYtF+qlbQ1EIiSPX8Mr7TeJ5uH7eWGM8DVPVzWlhb7yKFQvWy
	CJDbxijwagQl/7zaejSGfSf6YuV7LmL0pN3qNR+GZ1iOpGmfeAzoyyfVLxPjY/ZprKQFyVAFcl+
	R/ueHzstyn9ygg1oeNle011K9EqmUqZts=
X-Received: by 2002:a17:907:743:b0:b86:f988:a0c4 with SMTP id a640c23a62f3a-b879300d79dmr1808496566b.38.1769093758222;
        Thu, 22 Jan 2026 06:55:58 -0800 (PST)
Received: from elitebook.emea.nsn-net.net ([31.0.93.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b884db9ca98sm36551466b.19.2026.01.22.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:55:57 -0800 (PST)
From: Michal Sieron <michalwsieron@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michalwsieron@gmail.com>
Subject: [PATCH] fetch2/git: Unpack tarball when clone needs git-lfs update
Date: Thu, 22 Jan 2026 15:55:33 +0100
Message-ID: <20260122145533.86635-1-michalwsieron@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 14:56:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18847

Comment at the beginning of the download method says:
> A current clone is preferred to either tarball, a shallow tarball is
> preferred to an out of date clone, and a missing clone will use
> either tarball.
But when doing unpack, a clone will be used even when it is missing
git-lfs objects.

It is possible for a clone to not have git-lfs objects in place while
still having git objects there. Fetch won't do anything about it if
there exists a tarball for requested revision. Because current unpack
method doesn't consider git-lfs data when deciding whether to clone
or untar, this results in unpack failing with git-lfs smudge error.

Signed-off-by: Michal Sieron <michalwsieron@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fcdb19df..9e95d8c4c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -693,7 +693,7 @@ class Git(FetchMethod):
         source_found = False
         source_error = []
 
-        clonedir_is_up_to_date = not self.clonedir_need_update(ud, d)
+        clonedir_is_up_to_date = not (self.lfs_need_update(ud, d) or self.clonedir_need_update(ud, d))
         if clonedir_is_up_to_date:
             runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
             source_found = True
-- 
2.43.0


