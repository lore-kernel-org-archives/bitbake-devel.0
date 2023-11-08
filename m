Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E8C4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:05:00 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.105598.1699481091656886023
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:04:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dPxLlZ9M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.182, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c6ef6c1ec2so1644161fa.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699481089; x=1700085889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5myFE2BHi/i/GOtPfkkQ5Fw61TmxnhldC85HpjMku8=;
        b=dPxLlZ9M57vVc0v9Jg5ApypPAlZgmCgzJFdgRBjMhhQpzvJKxRSkzJamr15OHwIlNo
         dsWxldAjMbowQ7qp9GX37mbC/ok/3QvfEf9VWExroB+RQX+r/FZkRX/ZKetOQLtkYxhy
         e53wz+BJ+XmEl24hI9e0k13RZTXtE+HVb+0L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699481089; x=1700085889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5myFE2BHi/i/GOtPfkkQ5Fw61TmxnhldC85HpjMku8=;
        b=sKjpTnoBF/SRDgX+zMvC49SYpIhGXY7H6ERaxX4N9DaQgRTRjIxfuc7LGLeBKdJ/2m
         7E64tTyCEBq/3z2wFhGX0/aFSPLNUyQWqFftCApqsce+KPFLvNgaaJlVaFX++UUhURJH
         6aiFL+PydBrA53xGQVZzSbUbEkvL+lhMcnT8VJ3gwotp2WizJa8Buf5UYgOsNDSGDmBo
         /Oz96I/k9T1HvZfqi/6Xjhs5/qZ3RP1VNB7LLYbLx7pGSoAzo0pkxJmatmLdyWm6aI2b
         vpfkhS2pLacHQcrfvmqEJIm8ZKC7L3SJxOW8H3ostEG7t/sj2GcqJj/+zaI38HciXBh/
         iwiA==
X-Gm-Message-State: AOJu0YxBLrxqZ7pIZt4LJ2sdwtZMLz9UJQTNeXxDAd49VvUbyub2xl8S
	Uob+MOzIbeyhWv20VAkTKoJErszV3blmmdwAGFA=
X-Google-Smtp-Source: AGHT+IHhbZdU65VdNKg+yXq1JgGvSGErHLndTqLrMuh5i4CGUoeHGfSU3coM7jE2bfHYj5AC167Ojw==
X-Received: by 2002:a2e:8348:0:b0:2bc:b54b:c03f with SMTP id l8-20020a2e8348000000b002bcb54bc03fmr2632994ljh.5.1699481089364;
        Wed, 08 Nov 2023 14:04:49 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7d6a:4777:87ed:703e])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b003233b554e6esm5853531wrv.85.2023.11.08.14.04.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:04:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Fix errors when using -S printdiff
Date: Wed,  8 Nov 2023 22:04:47 +0000
Message-Id: <20231108220447.1557586-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108220447.1557586-1-richard.purdie@linuxfoundation.org>
References: <20231108220447.1557586-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:05:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15451

When running printdiff, messages like:

"Can't find a task we're supposed to have written out?"

might be shown. This happens when hashequivalence is enabled and is due
to the use of "hash" when "unihash" should be used (which defaults back
to hash). Changing this fixed various errors oe-selftest highlighted.

Also print the task ID when erroring about a missing task as it aids
debugging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 074edd0763..475c3c5052 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1767,14 +1767,14 @@ class RunQueue:
         for tid in invalidtasks:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
             pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-            h = self.rqdata.runtaskentries[tid].hash
+            h = self.rqdata.runtaskentries[tid].unihash
             matches = bb.siggen.find_siginfo(pn, taskname, [], self.cooker.databuilder.mcdata[mc])
             match = None
             for m in matches:
                 if h in m:
                     match = m
             if match is None:
-                bb.fatal("Can't find a task we're supposed to have written out? (hash: %s)?" % h)
+                bb.fatal("Can't find a task we're supposed to have written out? (hash: %s tid: %s)?" % (h, tid))
             matches = {k : v for k, v in iter(matches.items()) if h not in k}
             if matches:
                 latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
-- 
2.39.2


