Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C9CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 13:30:48 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.215011.1697549441248395874
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 06:30:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HOCJrGIL;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9b6559cbd74so995282566b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697549440; x=1698154240; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4N952tMkz49UQMfa1e4TSew4EIDblDRqIwe2qTANhcU=;
        b=HOCJrGILWKZkqpgEUKJpw6y8dcCR95h24iqrhVX+F+0q1PjPhGAju3Tl7IxwWGuuYe
         M9Fmngs41jvunYR5kkORNkoBMQggyeECn5wunWVxBtUAsW011nDGJ4y8qOVLWQPVFfuF
         DJL3ykwjN7mEFfUFgBkyYKh/Hk6UjJPMbr+XfQuts9ZczFOnYqcWnfYqOglKjxnFmtxN
         jueCg4ILRaIoaj1Zr2VyTpJ20eHFieRBpUtG+i1KMV2gjiC3MSqCbw7CX8VuUnB6RLDu
         iyexe91QtqLTZDcEr+yArfYloGJ0FUDPVKkn/5Cra27HkuqMgP72jfsX1mKQT8QGCJtl
         Bx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549440; x=1698154240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N952tMkz49UQMfa1e4TSew4EIDblDRqIwe2qTANhcU=;
        b=h0YZjr7pukQ/XDnxxeul3m4VHCYh6dKJZy1g6nVo/3tqjlpoQfqWD6pMQBniTnGG78
         J4rZdaL7N03vOqfwjcN2x78VVPKGrQKy6bNAbrat2YIXiDjQmnkAxC4yq2BC/yhCaESy
         fh8qHsFOAvBBIQgPcotbRe588yzTNolAm3nwRBJrR8YR7XcSjEqihzSuan8nmnEv9nA/
         BYxDKTp1HReVCPmh/WXENb45Jr49N+bIm0LdujKWKpanZdv3MhGZ+gbHLcjOCAEROpQq
         f/WXCWusk+OsrPkyfXsul/FhEXn/6fYNrnhLj92AjLJFJbcgMSi72MF8+MINL10Uk5Ba
         NJaA==
X-Gm-Message-State: AOJu0YwRwxmOApNB1rSCEH512OUIJEohVWZ77a0vFLAeXghHqxDnu2jo
	zY9mV09UFr/05Thmz6h3PS9Mo+NW4M4=
X-Google-Smtp-Source: AGHT+IGxD5cjecU486Gr2ylA+KlORpr7UrfljnnFpD++8/1q3ZYGpp5tuupCi4psvzYtqr7mZ8zmFg==
X-Received: by 2002:a17:907:a08:b0:9bd:ff07:a58a with SMTP id bb8-20020a1709070a0800b009bdff07a58amr1666702ejc.53.1697549439317;
        Tue, 17 Oct 2023 06:30:39 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b009929ab17be0sm1271043ejb.162.2023.10.17.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:30:38 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] runqueue.py: clarify that 'closest' signature means 'most recent' (and not closest in its content)
Date: Tue, 17 Oct 2023 15:30:29 +0200
Message-Id: <20231017133029.146956-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 13:30:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15251

This is printed by 'bitbake -S printdiff' and more accurately reflects what
the code does.

Most of the time the most recent item should be what the user wants to see when debugging sstate
misses, but there could also be printdiff-all (print differences with all
matching sstate objects), or printdiff-N (N most recent, and not just the latest).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 56147c50a8a..28b9667c47c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1769,7 +1769,7 @@ class RunQueue:
                 latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
                 prevh = __find_sha256__.search(latestmatch).group(0)
                 output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
-                bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
+                bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, most recent matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
 
 
 class RunQueueExecute:
-- 
2.39.2


