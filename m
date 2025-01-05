Return-Path: <nick.owens@eero.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B5E77188
	for <webhook@archiver.kernel.org>; Sun,  5 Jan 2025 02:19:30 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.31754.1736043566015122410
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Jan 2025 18:19:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@eero.com header.s=google header.b=bTbEKidD;
 spf=pass (domain: eero.com, ip: 209.85.214.178, mailfrom: nick.owens@eero.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso175820935ad.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 04 Jan 2025 18:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google; t=1736043565; x=1736648365; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OX/ma/XfpcFUFkTp/ZHsTWFbbIJcYuuOdiAUQTbXRxo=;
        b=bTbEKidD48JcDQgx+dGt3VoDijx+WiBrymOXOK8LnhEM12P/86CQNzajmDyvOmU16B
         lyuI1CG+YyxwMCG4bF2gB8S5Mp7S3x5yR/wje2wQYYUtwKrE6GNyhsSN4xUy5M1vvGYf
         /SnngA6QmnL0R+ai8axKWM9wEjIPYcZod5Qt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736043565; x=1736648365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OX/ma/XfpcFUFkTp/ZHsTWFbbIJcYuuOdiAUQTbXRxo=;
        b=IL8CtA8q/6Q11Kib3iTzLDI7Q2GfBeYF38FUQCswNYXyBAuGcGFk+b/RMXnVnUAEPd
         UinHN7xOuREz9+P1Ztlpyv3mDF/8ihehkRF9axEQCZCsYghYxzpa0SioAEKcXLeI+Ew4
         KNURm97RCDpAgFr/bd5WFFBWumLrABi88+OCoCdFuu84z45QELyo3NQaoYoe9+UT3B6K
         wnb9jwFPX3XvwVmS7EmwO429Q/Xs61M+kycIKPaEIH6IKM0CB3g+L9wLpIDZx9uBqOeD
         ZV9ejNRwigf4iCPmUxe8Wp8/dN3CDZrxTZU9NnMVeoYiQZrctsnUl3YPzsw4MNfadbaa
         42Eg==
X-Gm-Message-State: AOJu0YwxL4HSbOBxs+fPGy5d74vvFSslUmSuKpoAFDFeXEvNdiu2lTsa
	FCxTV/1vvLfwLhbBRHDaSOux68rEWJ0xpOGHdo5DcpRxR+A0fInYcwsTLAg8fxHqqwhOTQ5DaSm
	4
X-Gm-Gg: ASbGncu8rjHfXlRqqAeInqPvGETKKkn6VdoUYS/QASy9vvDxl95zaV7AG1k/hrNxA/M
	Gx8+v+EUf6mFjNv8uqed8yYJhW+j5pbJeHbBkl2/bHCmmWpgL+lQtFb/48qO7XVK/Sx3TAN5S/u
	8DDcZB+onMMOorLHs5aCDLFR/IlM8lBPp6Kpo8bJwyq9PHShG5bTduaY7d5ILXrfVRa2quUkGuQ
	iTjdKjipD/gqd65W7FDx71hpkOvqUSSAqq/9fWcIGVU3rXg8P/6dyGB1mldb/2K9qvxPl/F/IPZ
	++O13bQ+fCw=
X-Google-Smtp-Source: AGHT+IHDnF7CnRpW799tni15v+xasQVgwMUAkTmWgH0C8F1gcJG6ghbgIuPtEt+X3pKJMP/aatJOOg==
X-Received: by 2002:a05:6a20:2d21:b0:1e0:bf98:42dc with SMTP id adf61e73a8af0-1e5e07f98d0mr84480803637.28.1736043564540;
        Sat, 04 Jan 2025 18:19:24 -0800 (PST)
Received: from ubc8fb08c436a5b.ant.amazon.com ([12.76.39.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e35d4becsm22313250a12.79.2025.01.04.18.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 18:19:24 -0800 (PST)
From: Nick Owens <nick.owens@eero.com>
To: bitbake-devel@lists.openembedded.org
Cc: Nick Owens <nick.owens@eero.com>
Subject: [PATCH] git-make-shallow: use stdin mode
Date: Sat,  4 Jan 2025 18:18:49 -0800
Message-Id: <20250105021848.3048010-1-nick.owens@eero.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 05 Jan 2025 02:19:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16963

when there are many refs to delete, using xargs to exec git can take a very long
time. make this faster by only running git update-ref with stdin mode.

for a repo with over 34000 git tags this makes git-make-shallow finish
in 2 seconds instead of 3 minutes for me.

Signed-off-by: Nick Owens <nick.owens@eero.com>
---
 bin/git-make-shallow | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/git-make-shallow b/bin/git-make-shallow
index 9de557c10..8ad704fae 100755
--- a/bin/git-make-shallow
+++ b/bin/git-make-shallow
@@ -115,8 +115,8 @@ def filter_refs(refs):
     all_refs = get_all_refs()
     to_remove = set(all_refs) - set(refs)
     if to_remove:
-        check_output(['xargs', '-0', '-n', '1'] + git_cmd + ['update-ref', '-d', '--no-deref'],
-                     input=''.join(l + '\0' for l in to_remove))
+        check_output(git_cmd + ['update-ref', '--no-deref', '--stdin', '-z'],
+                     input=''.join('delete ' + l + '\0\0' for l in to_remove) + 'commit\0')
 
 
 def follow_history_intersections(revisions, refs):
-- 
2.34.1


