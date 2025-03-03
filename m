Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B5C282D1
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:06:35 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.52728.1741007193516770762
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P6PPGaBG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so27430995e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741007191; x=1741611991; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtYodA6CvQqK9EoDc5hEniTM/frI4m5DZgomhF0lwiw=;
        b=P6PPGaBGNz+Q3GkQ9En0r8IIYbf1oIFLpIgdLo1PgU3iOVPRSHBXGm/CgJW0md8MiX
         Dmk6CECHgsu9U6McKcLUTkUmREgg1Yd82+G6CPfqrN2GTdZ8zv2McmVo6mOiKMt/Xk76
         7qQD7cFg+dh14ko8ZX7vTs0O/DQs7lP/ASRmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007191; x=1741611991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtYodA6CvQqK9EoDc5hEniTM/frI4m5DZgomhF0lwiw=;
        b=hmvG/I6FHUC0B1u0zvMVOLrwf0X2jMzRREz/nTQcEl+xIx5jssbCCu0gp0la0lwmUV
         /N6YXnh765z0t6tdpeLo5eyesRhMOCmSsyWPRexAx/IBpw308o2IkGHW53hxBIrcT/QS
         /c/8pw5l5YEY0/2bKs8iMrC4u1f9ldhJciz7M2pWvrXjnbtUyitLE80a9XypnxWPDV/h
         U07dc8yeuIBE2lSONGbAwcD+JE5s2KV4nR+K+l9e9mqOVpkHKYkrBJsMbLGJ0Xtc59jB
         L72fHMaqNy/IhPQVXkz7KYZHFd2cBP36qsxFbuuXOszRXYWsmJY3/Bl4v38c7XbGCGYQ
         ZSrg==
X-Gm-Message-State: AOJu0YyTkSnuHfElZgaDVMRsICefTXEl6+ygdb4X4DBoBHMgcKwM/wZ6
	JGffNqmbtT2xZeJt5oeRNxHyswCbOBYLyACvBYl+UC09AoQ6MfJKE3mvZW0f8SmdGSAY3CTkVA0
	i
X-Gm-Gg: ASbGncucWgKBw/NbUuA4e7Qxg/q6yFS9taVq9CK4Hi2FWqHFFnehJLrfrVL+0c0MZeH
	XxWfX+QPl4vvzX319DgWEr/Mr6JVAgmI4wOdveTA3eaHPYv4WQKyqlYC3k4jbVeculPXJqR4Zi1
	BpiuMWg1tnM3N2CkknupgkQuDxeuSkGpL9f+fd1+75OJBGPRK53CYmqjqVBIEfCD1QKr7qeGO51
	g6JaPo8gK/SXIa4EyMo1Pj1mQ86xN6zWe8z+2tRj8Ylmgwa2tAn9HCo1iH0GGQneXlyztP7Sroe
	TT2IJmxFjoVhILQQQEyYL2SjDE+iCA8tvNzuAJ4K5WN8f2fzGRfSZZkY85pW0cghT1i5olej
X-Google-Smtp-Source: AGHT+IHIjH3VfMjotlZnG1+MBBZA9bwzihZxkKPN08PYu9ZJtDIJtOx/ITYM/tSDdlywQXLAcZuGeg==
X-Received: by 2002:a05:600c:3549:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-43ba62901admr102135815e9.11.1741007191459;
        Mon, 03 Mar 2025 05:06:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c70:3037:60d2:90d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27af83sm160667145e9.30.2025.03.03.05.06.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:06:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] utils: Tweak lock_timeout logic
Date: Mon,  3 Mar 2025 13:06:26 +0000
Message-ID: <20250303130628.1656131-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
References: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:06:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17370

We should really try and take the lock in the try/finally block so that
in some rare cases such as badly timed interrupt/signal, we always release
the lock.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index da8c20fe95..992e200641 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1881,8 +1881,8 @@ def path_is_descendant(descendant, ancestor):
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
 @contextmanager
 def lock_timeout(lock):
-    held = lock.acquire(timeout=5*60)
     try:
+        held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)

