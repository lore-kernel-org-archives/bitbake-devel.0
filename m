Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2019C77B73
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 19:45:28 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.3847.1685562321527203318
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 May 2023 12:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=ryrIskkg;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6af6ec6d73bso91937a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 May 2023 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685562320; x=1688154320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rgmf4hD9gkc8dqiARW9PYSuG6ZhpliSokZvUMRaB5s=;
        b=ryrIskkgL664bRz2NT6rCDf6XQ34lm4TvrIveI5RXyJ7G3YrZtXi9VVfQ/nG1ZFbaS
         GY+GMv/AEQkH3r32XiV2b454+wlYeYotdZldFLVnK0cYO8u2JFixQf0p61bZB30XyX3x
         BzYW4sB0ZlOBpv65ZcYJUv6sgBF29NlDUGl4XY/mCaFBGhnQS3VenWJo++mQbRrHaG6H
         LWAqv4a9h0hYyHuAEZo5QsVaC672QkRu7C0XVCppztFRuqbdW92SAcG7TIedofzsQqo8
         PDkRrZ6CYsNLq6/FfJQIU3oRmotXP09psJIec2nn+6FezSRqacwkj508+3rtaMkX7+PG
         AtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562320; x=1688154320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rgmf4hD9gkc8dqiARW9PYSuG6ZhpliSokZvUMRaB5s=;
        b=WjeoqQBkAnaaJOtLUp/k7a4apwZKxE/IquI1IM4NCY+11zaFxAdJzsZC7IOKyHkCq5
         uAv3JjGQoDO/nm9+VlbLrplFaMOjUGjv8caixS5OFZ86Ppb/wMKDXCykhoaVIgWGozCx
         Q5UiADgUsC5IEMnlRXegW+LazWEIBzfqlqkIq1UsA9Z+U3+F+s5uZLDSQG+gVV89UCb1
         v+nGTo6xIb83+YkzZYuqEUP9x8mAjct5Prwei6E5Z4D+86yMGu3pcQFne9sC5H/hhzBk
         31wPYhck64S8EBMBgTH2ra8yaT5A635N4dHC7I9QD4WtiImN6zQZAIJpdj2d6lADGoKy
         nUCQ==
X-Gm-Message-State: AC+VfDx0uLV+P5XQFePtm+/kCA2n+cQTl3vlbmY/tmQAhGF3K4Q4/xKA
	u0LsgOvfZMa8d7d9Su1QxjZV3S4eK3A=
X-Google-Smtp-Source: ACHHUZ74LKgPRMkui2xQWx1QJYwFbfdoAse84URyLWtxKHjvK+VhVUPsw2y3vpiOht+TO3SfbdtW9w==
X-Received: by 2002:a05:6808:238d:b0:399:b7c3:66fb with SMTP id bp13-20020a056808238d00b00399b7c366fbmr4150170oib.58.1685562320067;
        Wed, 31 May 2023 12:45:20 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id s125-20020acadb83000000b003982a8a1e3fsm914164oig.51.2023.05.31.12.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:45:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] server: Fix crash when checking lock file
Date: Wed, 31 May 2023 14:45:15 -0500
Message-Id: <20230531194515.3769828-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 May 2023 19:45:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14823

Fixes a crash when the server process attempts to check the PID of the
lock file that resulted because an integer (os.getpid()) was attempting
to be concatenated to a string

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index db417c84280..7616ef53c89 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -375,7 +375,7 @@ class ProcessServer():
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
                 if not lock:
                     newlockcontents = get_lock_contents(lockfile)
-                    if not newlockcontents[0].startswith([os.getpid() + "\n", os.getpid() + " "]):
+                    if not newlockcontents[0].startswith([f"{os.getpid()}\n", f"{os.getpid()} "]):
                         # A new server was started, the lockfile contents changed, we can exit
                         serverlog("Lockfile now contains different contents, exiting: " + str(newlockcontents))
                         return
-- 
2.33.0


