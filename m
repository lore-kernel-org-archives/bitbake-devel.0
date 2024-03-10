Return-Path: <technophil98@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F65FC54791
	for <webhook@archiver.kernel.org>; Sun, 10 Mar 2024 03:33:20 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.27640.1710041598992378925
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Mar 2024 19:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lkDR7VNy;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: technophil98@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a0ba5098bso25731391cf.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 Mar 2024 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710041597; x=1710646397; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdFRJAlUKOSAtXtLX14S0Mtk8VfosTV/BW2gAdEwGXo=;
        b=lkDR7VNyuaCuFTwlKwBv9mkxji8tqYAjnJHtFZ7+NizLXROW/ZdQ8PMwng6BkMEc/y
         xKqrlHya4iQ+El3xJm7aH6Mn1Xk/Th/TAYaD4Q9n0gp8HG5VbpZ+rpQzKX7YkcWjd57J
         fexZOKRTj+QpXNvPo/68u5mLV+PuOWqR7l3hrlNtzzRlGi++L8QKdMRgaulnJnNI1K8Z
         yrZD7oPCbJnHwhOEvbpn9jICRUqeRlEzmo7YN43VZW0+J3VEIJwNmrFHddcMu2O7//+Y
         UeMlSWi27nkwxj/fZWrrzMbVaaiXJxi9e8YZYm5Jv2dywEil02utl2oSQyn/XzRl5hnx
         BETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710041597; x=1710646397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdFRJAlUKOSAtXtLX14S0Mtk8VfosTV/BW2gAdEwGXo=;
        b=VlDYVMXktHCE3bcXUuDCmTGyAJO6Zvldzi4QC+SwGXvyNgW8O06KtW/rVjwlYU0UYE
         40D4CG3I9FxsGaYi+bYzLVIWCpRoXZVzj8o+x49SwSULkNqUnrD2QZqjOjmtvVyWbKkE
         AmBQ9zpN3rx6VEbgobzv7tak7HDHb0ejTq2yoatzH8MMC0Gm0oM8Pq++q6dYPovxm0lx
         mD4JyxQDnFBpJIQ12TR+lk9HefY4UzLQilUVvfFqfSuWUhXXBFGp9sXRxo6evN7XIHXy
         FsUeKNCSz8BJaTs8vPyQMHnv+dCK7/8gUzCkwHGbyey8Vg/3Lhju27M4cUX7Dl67AizN
         u+2A==
X-Gm-Message-State: AOJu0YyLGeHyMhgzLU3smyqXodRD0sfzjv+ucW++80EOJlFyE5IRQIfF
	7zuqCdSi5i2NA8w+SeN2/ybIbFKY0BmLxut/hD06rmGCBAXo+3pZzkNeavhROwk=
X-Google-Smtp-Source: AGHT+IEgMkd49NFxrY1xHJLlqVse/KqJGdwEPaDltGfkgJEGsl98aYvR7+sNOgVEc972UAOAYFH1WQ==
X-Received: by 2002:a05:622a:ce:b0:42f:2170:4967 with SMTP id p14-20020a05622a00ce00b0042f21704967mr4288440qtw.30.1710041597062;
        Sat, 09 Mar 2024 19:33:17 -0800 (PST)
Received: from obacon-Precision-3640-Tower.GENETEC.COM ([68.67.62.2])
        by smtp.gmail.com with ESMTPSA id f1-20020ac87f01000000b0042f37ebfbf2sm1294983qtk.5.2024.03.09.19.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 19:33:16 -0800 (PST)
From: Philippe Rivest <technophil98@gmail.com>
X-Google-Original-From: Philippe Rivest <privest@genetec.com>
To: bitbake-devel@lists.openembedded.org
Cc: Philippe Rivest <technophil98@gmail.com>,
	Philippe Rivest <privest@genetec.com>
Subject: [PATCH] bitbake: fetch2/git: Escape parentheses in git src name
Date: Sat,  9 Mar 2024 22:33:14 -0500
Message-Id: <20240310033314.110796-1-privest@genetec.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Mar 2024 03:33:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15996

From: Philippe Rivest <technophil98@gmail.com>

FIXES [YOCTO #15404]

When using git fetcher on a repo with parentheses in its URL, the
invocation of the git clone command will fail. The clone directory
is not quoted thus the shell will return an error and won't execute
the command.

(Bitbake rev: b5624ee5643d881afa004571a096a189ab5389b5)

Cc: Philippe Rivest <privest@genetec.com>

Signed-off-by: Philippe Rivest <technophil98@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b9dc576d47..6170da7fa6 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -277,7 +277,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_'))
+        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
-- 
2.40.0


