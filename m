Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00B4C27C54
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:11 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.22950.1717511287760044612
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jun 2024 07:28:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cUUzaPWa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42155e7084cso133155e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717511286; x=1718116086; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLW355yoEJzF60+PYNejnUdrPxpupUaotjsBd9TeMkA=;
        b=cUUzaPWahzX4yD+oaS6iacn7HjSCwoslfrxGvrTn+ggxneOJ9sXA6cCGAbY/frPzFx
         M4Vo05DzYo/t5c3SrhKGspjoeBGWNgTtk0HpR5W3QSVeDjxPqX6G9QiLIWYF6hoZPLe8
         HFuDKO7bhqXxe1g1JaqiBwhxOLBtRKUw98WLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511286; x=1718116086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLW355yoEJzF60+PYNejnUdrPxpupUaotjsBd9TeMkA=;
        b=cVW234OvsjEgW2RNPTg8CepAAaSA4BZJtxkZj4Fs5xxjKoeGEEgBgd/aU+oSU0G9jI
         PjlGHLCkdo21UwqnusaetbCjm56woVAB5gDb465osHBuaf35KvOvbgAUL6K4qWTbsai2
         XGT6CnMYG7Wbyp/f1O0nLIku1g2uxpNbKUhg2qilJaWowvzOWhUvYCm7uRYxpa4Jid0z
         o8AIfdTm725VvztuosdcpVjqlH7lJL20e5EvmV4X9z4zJhZHiHR48ZO6LA/giFe20wco
         4apSY+nJeyNPuRK+L1ekhUnULchCRoE3tHCReIxFjyOTd998t9EollJC+PRmJh+0YnMg
         goZQ==
X-Gm-Message-State: AOJu0YyOf5hTPYtFvuu2sm29CccYePuset3sQRNiobRPS/QXFtHczsU6
	ei8eaWfMwHMJJGMMnesznvKhiGdUZd2rhGTNxJBsihHV0XT2Sxqbo6jCoc8WWMlfeNZc9wkwglg
	H
X-Google-Smtp-Source: AGHT+IGuF0+B+Si4dRqknU/ADLY7JqKqQ7ghqEjQqhseSjYFv3vDq63RtLMYCm3IJxzD29AwKnhPCA==
X-Received: by 2002:a05:600c:4503:b0:421:48ad:60b3 with SMTP id 5b1f17b1804b1-42148ad6427mr26809065e9.34.1717511286074;
        Tue, 04 Jun 2024 07:28:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9a5c:ae3c:1b90:53c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42135c9dc18sm122043595e9.1.2024.06.04.07.28.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:28:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Avoid save_unitaskhashes
Date: Tue,  4 Jun 2024 15:28:03 +0100
Message-Id: <20240604142803.3658144-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
References: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 14:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16317

The save comes with an IO overhead which can slow down the rehash loop in bitbake
a lot. We only needed to do this when recipes were doing unihash cache copying. Now
they aren't doing that, drop this IO pain point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 93079a9776..3462ed4457 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2550,9 +2550,6 @@ class RunQueueExecute:
                     self.rqdata.runtaskentries[hashtid].unihash = unihash
                     bb.parse.siggen.set_unihash(hashtid, unihash)
                     toprocess.add(hashtid)
-                if torehash:
-                    # Need to save after set_unihash above
-                    bb.parse.siggen.save_unitaskhashes()
 
         # Work out all tasks which depend upon these
         total = set()

