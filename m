Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA8D63926
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 10:43:23 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.10636.1732099395534283992
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 02:43:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CMrfKeIY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431616c23b5so4225655e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732099393; x=1732704193; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFjawrZ+0rAq2dpwc9WTbPK9LGUc0qJVuZjJ5vLaFu8=;
        b=CMrfKeIY7sNRL5lqG8LleyyvhY3+ecATbvNAvpcA2nnl3SsHlLjKYlzdJnV7mVs4U5
         UVt+GSF/ImS1m78c5zOFRKBTluiFPenIwU3zITucooP/BaXDAAb+NOwW6GhnF7Z6VMgO
         SeaAqOPGrZFiQX+JpdETmJOQjhiW00pRNIUpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099393; x=1732704193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFjawrZ+0rAq2dpwc9WTbPK9LGUc0qJVuZjJ5vLaFu8=;
        b=NRulGE8H2HnSsKV/++90Mw8vpyEuru3WUwF3YtMfjxB5dq7032YpVd5aWHFehEE+SP
         TGkH441+1RXni1FMcJHMz/WaucjiXq/KI0pNEVggYgqDWwb53kYjf9ZRwIsaSAStpN0J
         NFxdC9IIDllcxXByZQRBR+prM/NxN0HVbBh3c8cCXeL0aX9MFAkACmxppElnNULZnfdH
         wJPmwXXchF3whzD0rZ0H9x/he8kNWSgCU60rnrkkBIGOWESvApFPtqvQImF/+EeNR32b
         cK1hIWMgJSGcQnIIwpAq8mPoEu/aeU52udYgfzY0tZn1r/NVEOXqeBrSuzvba0huj+hf
         kYiQ==
X-Gm-Message-State: AOJu0Yyd8hY7GZjVFfR9duLbd148XceGP641qkW8V7OCpQpHtNClY+Wb
	15YKkxq5rMhhh5EP4JbtzRhtJ+jAQrdJF4jzSU4MvglfeLymkQg2RRHsVIqlUZbYshwI/HcJvG/
	/x2Q=
X-Google-Smtp-Source: AGHT+IHzvr7cpBpk/Jh1b9nkRJZ+Ro2dWc6bOzIxTHVkDYqyzV3ZW22zGrV8kKQVGRTNDMdqSBfIRA==
X-Received: by 2002:a7b:ca4d:0:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-432f57a97b9mr52538675e9.5.1732099393373;
        Wed, 20 Nov 2024 02:43:13 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6fe0:5119:2eb:57b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm1720673f8f.47.2024.11.20.02.43.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:43:12 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] bitbake-worker: Improve bytearray truncation performance
Date: Wed, 20 Nov 2024 10:43:10 +0000
Message-ID: <20241120104311.2365179-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 10:43:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16816

If there are large amounts of data being transferred to the cooker
from the worker, recreating the bytearray becomes inefficient as it
happens for every pipesize block of data, defaulting to 64kb.

Instead we can use the deletion API for bytearrays to make this more
efficient and avoid the object recreation.

We noticed this with a strace ptest image taking days to complete the
build after having 6GB of data in the testimage log. Whilst there are
other issues there, making this code more efficient doesn't hurt.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index e8073f2ac3..a8a9660c5f 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -105,7 +105,7 @@ def worker_flush(worker_queue):
                 if not worker_queue.empty():
                     worker_queue_int.extend(worker_queue.get())
                 written = os.write(worker_pipe, worker_queue_int)
-                worker_queue_int = worker_queue_int[written:]
+                del worker_queue_int[0:written]
             except (IOError, OSError) as e:
                 if e.errno != errno.EAGAIN and e.errno != errno.EPIPE:
                     raise

