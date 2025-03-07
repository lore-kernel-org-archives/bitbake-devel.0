Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99541C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 13:55:19 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.11470.1741355705029131927
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 05:55:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=lZg9q3D5;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3609605a91.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741355704; x=1741960504; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLXwYhqo7UMpagMu+O73c/oE62mOwy1Vn8DQXRT55zo=;
        b=lZg9q3D5dbDybjCxciU5pU0b6ahX/+QhF5DuCdNF5bvXQjhTmryrApb+cNIe7wYRLt
         SXKvT8i51XVS1HmhGyzMiIGTAzXT4JSSc/r7lZO7O+jntgPBdR59nnEF0uu90E7H6586
         /BvVm+BIe0fdcXDE2O2G7dqUSoiD4Fzz3/m3z1VAfKfDOCLfli2BJs4Gu/32FQqXGlzg
         3l8Biblme1bQE4wwTn3nluxWYWFTnzbBf+I6/mxppw8ddF8s6C5lYsuG16GU9KiueJW+
         NrLi8kOtemlZAFnEhqlK9Lk2JtXL2doWos82lT31Ghdiq+F2Ev434gKs1b+YoFOyN7sL
         VFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355704; x=1741960504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXwYhqo7UMpagMu+O73c/oE62mOwy1Vn8DQXRT55zo=;
        b=DdEENnyxUiZN78kes/+F9KI79S9KA4Y8SdtpY1k7khFbnpqRyBsD01qyUCMWLv1iV4
         /n0Rcsbsl4B6RoxWIwAe0PSiT9yVMLh85c01BkoQjkPLouE8JY2/qTKn2i5hkJFeng/Z
         vBDTFIZULIc1l/4S1PdCishxq6L4LoB0es78187ZXCElJFz9Y0/jQVFyt5X1JkzG3KBY
         ysBV670sf4ioOQsn4YFhuSOiK7v3x0L6NFZSQbgZ5xEfRhl53UzTTVyq8bCmIHsTkEqf
         62+m+3YXEAVxGqCoLZZCGUfopzDS4fywfoS9ehaNkIxbI6bYF7PrmhOV4iilw/1m3W0Z
         JXBw==
X-Gm-Message-State: AOJu0YzmDju1uGmKYeOIigC7TegNx0i1ow6c3Ys7J6E57NdpdhmDPT5X
	nDXM/8DrB4sEpAEDQqkvlb74oD96roBCwNzoHLQyDvnI5nFTcdkbSyWHEZ7gCjAW3geaEH41PQw
	z
X-Gm-Gg: ASbGncsJMjjKOkzkNQc6xN3d2wMm8zsSdYHumvIIILrdEyjNljzAeSQqgZt7rL0zl3e
	AxJLiFzbvh1bF5/YCtHq8qq5Z+tgm7/bmRHwGFSDh/YQwQuLr9JfTt/beWM2kT1WJypk1zzfFDc
	Ey1wnMqY5hy9wDmeqWajjTov9gQ6ldvVf2zLl3R/KWGZx8A5VUFjFwEeHWEhvp8U5krUKqOgcbS
	7HEYwZ3DFRHDocemTBheqoqN+CFF5RRcpIme8P8QOmjeJVm27NOwALp7XRAigTo7RQktL5D3HoO
	equt2yRQozJ3dJtpRAVbv/gMfLDgEimj4t3k
X-Google-Smtp-Source: AGHT+IHBCc2iW2stbho6/UKD6ndKJJieWgZOzgHfLp0KBllCTOSfbG5DhliDAqwWX0VB5r5hhz7p+Q==
X-Received: by 2002:a17:90b:3887:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2ff7cef99c2mr6485438a91.33.1741355704301;
        Fri, 07 Mar 2025 05:55:04 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:cfcd:40b4:f918:b895])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm5488032a91.10.2025.03.07.05.55.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:55:03 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 3/4] utils: Add signal blocking for lock_timeout
Date: Fri,  7 Mar 2025 05:54:53 -0800
Message-ID: <de552cf58fcbdea64b359a0fdcdf3673da3a780d.1741355508.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741355508.git.steve@sakoman.com>
References: <cover.1741355508.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 13:55:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17410

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We never want to exit whilst holding these locks as it deadlocks all python
threads. Add signal blocking around the lock critical part so a signal
shouldn't cause such an exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a097755c671e2b530dea6200a94b39fa9dca246c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 83e832c33..da026fe5b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1860,6 +1860,7 @@ def path_is_descendant(descendant, ancestor):
 @contextmanager
 def lock_timeout(lock):
     try:
+        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
         held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
@@ -1867,3 +1868,4 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
+        signal.pthread_sigmask(signal.SIG_SETMASK, s)
-- 
2.43.0


