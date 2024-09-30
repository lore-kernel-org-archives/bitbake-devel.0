Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F4CE8346
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 13:19:01 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.54131.1727702331932537898
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 06:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P7heLe4z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so53934655e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727702330; x=1728307130; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXZ/NN6TPBVEUQ1MCZxl2MnXVGq2F40S3OJYuvnixCg=;
        b=P7heLe4zT7qECXCVypqL2gGQVjE6NpeX7u+sAOnhYdEuOhe7UhYHc5n/208tkzHG2q
         GXSnmmDB7bJyUOt0/WvXM8cM4cTKZSt/6pdSidTZQfqYzkNjC5ZReue6Rbj+GfT0oYVU
         rRt96t14BQCx8Dc3AW5fXSkiST+CuIfmtfo6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702330; x=1728307130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXZ/NN6TPBVEUQ1MCZxl2MnXVGq2F40S3OJYuvnixCg=;
        b=t51pxfuzIGl6b1ewCbOSM885ABPKOYBPYksz3I5cX1cx7EwcdQ1sYE2puuSrVrhCh8
         HO1hwcruGKKOjmo1efDU5FBBnb4F9QpoW3N8NA34NzvlTKztVdnItB5Rdp8iYF0Nakx1
         J1+Z9r22RnSyl/ZWgCV5SzQ4nSVlEBunXI4p1ZAiyTGeJt/MMZZvUz2tTx7ihahZuIJi
         ZWLZihyUUwU9BZ5kJ4RX5wl3AZs4B80DtesXmKTSAmgKZZIQ6a0SYZRk7rrdcYyJXLxW
         ZJnXWO8icssiWquSAFkwjaObwBnu0aSf+41n/3iJCh3jJbNla5teRLtLM5M72Pttno5Q
         HUdQ==
X-Gm-Message-State: AOJu0YxSnIrhqM6ZRNGsD51k232K40nf5/g1oN5ezvH9mhPgUDVz/qa4
	P4GzgXsmrV0dVsv8BuCx0Pyo0pP0Jlp57r+3RzgaY6HalEVoRcnCt4nd6OiupDbqOxWHQ0G9IMo
	z
X-Google-Smtp-Source: AGHT+IFbvLhY1R9YD0vLwSiUTvS9cAhxCXKvZheZBh0TUAZne+A/vHJoqni2YTWekQcd9Cl6hKrs9A==
X-Received: by 2002:a05:600c:4751:b0:42c:de34:34d8 with SMTP id 5b1f17b1804b1-42f5849771fmr116916655e9.27.1727702329930;
        Mon, 30 Sep 2024 06:18:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffb11sm150891055e9.21.2024.09.30.06.18.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:18:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Use quote from shlex, not pipes
Date: Mon, 30 Sep 2024 14:18:48 +0100
Message-ID: <20240930131848.2419329-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 13:19:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16620

The pipes module is removed in python 3.13. It was already using the
quote function from shlex so use that directly instead.

The module already imports shlex too so it is an easy substitution.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6a1f47a32e..5b678827ed 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -952,9 +952,8 @@ class Git(FetchMethod):
             commits = None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_file):
-                from pipes import quote
                 commits = bb.fetch2.runfetchcmd(
-                        "git rev-list %s -- | wc -l" % quote(rev),
+                        "git rev-list %s -- | wc -l" % shlex.quote(rev),
                         d, quiet=True).strip().lstrip('0')
                 if commits:
                     open(rev_file, "w").write("%d\n" % int(commits))

