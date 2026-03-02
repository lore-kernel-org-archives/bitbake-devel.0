Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F043DEA4E22
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 15:15:15 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.162725.1772464508143501806
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Mar 2026 07:15:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BpNFtsry;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: pmi183@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so55057915e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464506; x=1773069306; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqkpnYGPXRvPRnz5M6R1ABxvj9wcvhB0NR3YCrR1yss=;
        b=BpNFtsry7n1I0XetQUW2q1GSyjkR/uJtDmLLLLIuU6CycTZexco8LBg86e8fhWCdHI
         1bH9pX9t4V9pTtiRYmRUOdNBI2oiNcosXSHqijQvbkzOK1ce9cChsVBqBYQ6tEpsFt2p
         hZ26OSPYKDqRx/Ou7QkFpvfc3mcAkhSk086Ikl55VvdRwxCXwwBs1VsbzN682EB69Gtf
         pyiipZXaHrhTapnnmsin3R0ekvG83lVk4YlKUPnR7PGKlXKiTeq9NaIgtYOvSC6a8SuO
         xW2mPTMADabRFok6kHt0xPYaknrh/tgqNFBPBXMhcrP5GyFET6gO54aHYjC6C6BNFjKh
         w7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464506; x=1773069306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqkpnYGPXRvPRnz5M6R1ABxvj9wcvhB0NR3YCrR1yss=;
        b=WEwOrlpWs/ouJ88sGezgccVKF802ITMITjBQF1hAVy3jHvSXETLcda8pPoMuMISMpf
         rSJj8FhfFZEpWEURubqnoTTYTFtrylUZPAdZyNE3gK6rI2JaJvYsYRHoTvydilS1uzFO
         /YD6PsF0DF6MTIjQ+6om9cYa8wLDTccaIZbJvhHofuYATOUE2pDOppEvCPw1oVO9ppMd
         XeP2oqbYH7e1Lp3mK22s7Rscign1SHscw+HkcqZ9FEpGwQoLM5z5DG7Dg4FMuyl7CRoL
         q/d0JsVXQc5AZjR/JLnIMOMpQxvaPak532u8Qk5PcfE7i971VZUM75v8IGIyawfMMXyb
         8nMw==
X-Gm-Message-State: AOJu0Yw/Q2OsI87kJljybl2DdQKusKPYjtFbYzb34a/6ZCfrMPub8X+6
	vu6dNKYJk+JOAADZW+cUR+9iL+Dbg1eGw9q7r84jY5NzNlNddeUYzRiMze5mmBaI
X-Gm-Gg: ATEYQzwBzvKd9oO5HVRX8vs38Y8fuYGgvaRkHj7w6L7M1GfBMA/WGppZGig1T6dKGzO
	NSUQgk4tHrxNJ5kmNWbj9gi3SVsRwrlkDac1JemeKxHzW3pL0b9L6wNZE9Ar5n9ZbbWZnf0cjr9
	8dKF62LOApPut/zHS2kV5/fUhH6DwbShgJoY+QrE1ws424buQ/9BnAUzv8wi6fFVXtDKERPCe4Q
	BK2TSNqX6PxxbfxRi1LHSQ+zQXX0cnelSWJwW4ukZktaeahV4JBC8Uw9hOupI5SDvrI+drzPsbl
	283/wnmW6KbFFvaD7SNIIXKmv9GwGEpH+1eP1KvIM6kwg8781v1hQiaDj0JgUs+G6qic/6MhHZb
	AQf63H7ev2zdY4+5oLTueEnJB5bdMtMF++UUnYCb2vtWdy53W4NNlUTAfh4XlqjB9LaaXhUEjfB
	mvJNewlLuwozcKLVZ2QDdhzsqhgC1kiNS4Fcyou6D4N0vPThDNSg==
X-Received: by 2002:a05:600c:828c:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-483c9c24748mr227828905e9.35.1772464506185;
        Mon, 02 Mar 2026 07:15:06 -0800 (PST)
Received: from pedro-P1-Gen-8.. ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm427352525e9.14.2026.03.02.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:15:04 -0800 (PST)
From: Pedro Ferreira <pmi183@gmail.com>
X-Google-Original-From: Pedro Ferreira <pedro.ms.ferreira@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: pmi183@gmail.com,
	Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
Subject: [PATCH] fetch2: avoid reuse download filenames
Date: Mon,  2 Mar 2026 15:14:43 +0000
Message-ID: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 15:15:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19097

When fetch task runs and while running checksum validation
detects that for a source file the checksum mismatches,
instead of aborting, its allowing to move aside and download again.
This might allow users to taint the source files instead of acting
as a safe mechanism to fix some issue occurred on the download stage.

Signed-off-by: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
---
 lib/bb/fetch2/__init__.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dcf7adc26..b8d8957b0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -716,13 +716,10 @@ def verify_donestamp(ud, d, origud=None):
                 p.dump(checksums)
         return True
     except ChecksumError as e:
-        # Checksums failed to verify, trigger re-download and remove the
-        # incorrect stamp file.
-        logger.warning("Checksum mismatch for local file %s\n"
-                       "Cleaning and trying again." % ud.localpath)
-        if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
-        bb.utils.remove(ud.donestamp)
+        # If there is a checksum mismatch, it is likely because the file
+        # is being tainted or some corruption is occurring when downloading.
+        # Download cache should be cleaned up before trying again.
+        bb.fatal("Checksum mismatch for local file %s\n" % ud.localpath)
     return False
 
 
-- 
2.43.0


