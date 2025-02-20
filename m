Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E66C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 15:36:13 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web10.52386.1740065766825271201
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 07:36:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eGEkdM2D;
 spf=pass (domain: gmail.com, ip: 209.85.166.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855a5aa9360so74466439f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740065765; x=1740670565; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOgo2m1Wf8e1NtowTull1bwN91H7W13X6oADiGUOH3g=;
        b=eGEkdM2D/jsdWaOSR5Qv+V5ylFWmlbne60k2SHos9uyhYHbo4uX88rUaWzaGJYDcV/
         eZAxd1nuCtq+On2DvQDPE5Cl9VJ/u9M2hfZq8l1e1Cevs/Xy8kzwiUnlZlI+CCXgmxAN
         EbAS8H7X1FJzmCbceuiJ+PJVYcsZa676CHrX5bD0RICF78Yvg+qDI33iytM/h27OqJwC
         o45gWlzqyb3lJLMhtn7trnGaB9w/34epDt1HnsmY9NlcCfJDQeeDesZptWz6UEOPzAXr
         rjMEGzUkXX11PsIZJjCoRwkD8951MgIsJO0kEEP6t8xURwQNj4mPg+1UIJJxXSqgXgWR
         DPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065765; x=1740670565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOgo2m1Wf8e1NtowTull1bwN91H7W13X6oADiGUOH3g=;
        b=YuaLDd1+tNKW7NU3+yRQkEeHddqyuOMihJnQVDHlDCIZw4TgqY6BlzVkk+8L9HOoKp
         LrKsaY0W2pQ9IQGIoN2RQcbeEpM/UnyDKAmb34U6BozWtdV8ybfkDZR42nlCSTY9r8MA
         yqP8BEeRAbn2WWxfsSzaYh78B6WlwSWewjilKejE1CbhWQnr2PbN5xIn06CoBJXdSJS3
         FiVzU99EMZeaRQJuRKcovbV4wV/Gilv48ARRsMpvkKTzLv+a65GZ94Oue/9g9nRKEU0Q
         XZzzDl/f2esUnNicw6xvFkN4gJmt/9Loct3kUKrgSHFuTSAb+Rrjq7ANTb1Q4t403B89
         GiWA==
X-Gm-Message-State: AOJu0YxC3XCmyBaG8Okv/H5WqW50lgkV30vb95g/kVAsN2GfvoT8eMIX
	I9tJEmM0AkvvSL7lcK7jg77+35CdG6Pqbnp+gG5+Ydfqxwe3IGLYtl55EZKx
X-Gm-Gg: ASbGncuVhn1ddXW0SuG5pyi1/q+G9Ig7WLjNxwtv2nrtAXic0a0dQjQaHu8AicKuhFL
	YrsIXnNNBPcuS+oB4D0Bw8RZ7JgY3QPvETcXLpFphhc7euXnJwEGFPjj3NEnL1Fq/R8irhgijQ0
	QiK6/eEcavT04OeoJjHHJFLqVVkwZC/cOzaRZVlHrJ1cAqxd30mnVc3XS4oKhC6dzfnJLFyWgqy
	UuClLDzoZjNIjQnoz103H3swv9TeiPcXeDFoO6Xc369Fpo+NHXRZBFCFJxLC3yRqCfELetMf08y
	yF5P3TxEIP+WEw==
X-Google-Smtp-Source: AGHT+IHLpu3qT+mmWt6iJMJ0xVREbS8vgsg+2ltzaz2SH9E//b8d+tN31qnV8yAF/Iyp8E6lgXbJmw==
X-Received: by 2002:a05:6e02:12c8:b0:3cf:b626:66c2 with SMTP id e9e14a558f8ab-3d280921393mr204102075ab.19.1740065764576;
        Thu, 20 Feb 2025 07:36:04 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::db07])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9c444dsm34356475ab.30.2025.02.20.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:36:02 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joerg Schmidt <joerg.schmidt@garmin.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][master,scarthgap,styhead][PATCH] bitbake: query: Fix using "removeprefix" string method
Date: Thu, 20 Feb 2025 08:35:59 -0700
Message-ID: <20250220153559.3752931-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17257

From: Joerg Schmidt <joerg.schmidt@garmin.com>

The minimum Python version required for Yocto 5.0 is 3.8 which causes
failure in poky/bitbake/lib/bblayers/query.py when listing layers by
using command "bitbake-layers show-recipes -f --bare --mc MC" for the
given multiconfig MC.
The reason for that failure is the use of "removeprefix" string method
which got introduced in Python 3.9.
This patch replaces the "removeprefix" method with an equivalent
solution supported by Python 3.8.

Signed-off-by: Joerg Schmidt <joerg.schmidt@garmin.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bblayers/query.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index eb7cb465b4e..9b2e081cfd4 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -145,7 +145,8 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         skiplist = list(self.tinfoil.cooker.skiplist_by_mc[mc].keys())
 
         if mc:
-            skiplist = [s.removeprefix(f'mc:{mc}:') for s in skiplist]
+            mcspec = f'mc:{mc}:'
+            skiplist = [s[len(mcspec):] if s.startswith(mcspec) else s for s in skiplist]
 
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
-- 
2.47.1


