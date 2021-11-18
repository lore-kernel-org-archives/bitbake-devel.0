Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15AAC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 16:27:05 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.3929.1637252824912650964
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=eR+dWCV7;
 spf=pass (domain: gmail.com, ip: 209.85.167.46,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id k37so28892656lfv.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXdyQx38yNomNjVRJxP8bLLSc0ODKBH+VLPsW040YZw=;
        b=eR+dWCV7ODI6g4bcmPuthxyKHEoGQIw+AgBDsi+vfZuvzHvXBuT4mNzpXIikmkaNcH
         /SAtNqnlE7dU++3YJPgY2BV6TbiBxKozJqnlvgyUR9cNpUJBROundnH6V4AfpVZ0xdfD
         FJM4I9T43Fm4Ufn3OeSBXMhZfh25YJY9rOxM9+bHzL7GyR3DMrrMduO+fYO2VfULwrnO
         XH5df+jTD4tBZXqJIYxKN7afFxlEYudJ3yyBBQG3xqWQQRNI++txXxSySmFTnMN0hFcZ
         D3WaMBivic6enPXnxRmv/eof6edFcL6ZFDbqxbF8k05UECsu6Q5S4E6IxefzUH9d2nmN
         gl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXdyQx38yNomNjVRJxP8bLLSc0ODKBH+VLPsW040YZw=;
        b=CQtQDZWsrsAM9ERgtsKRqiCq06aNLxQgYgPMh/RPWx2MbE1twcdaPD5b10Q9U/Cf/I
         U0J0i2RHdZCZx5Wd1U5bZbjs02MmVWAK1g6J0NaeuGyYqFm4Y1kOF4efnIfW4SzR97w8
         tGFl6GYjbwEh8NxiejMP/mpfEZe7aZtcbVFLCjYx9OQLSVQBEbOJtudYOLX4m9cX4Xeu
         k/OVbwCBB4RSjmCCG4qyCR7r9Eoj57QGeVLgiyWvWCDAuzJBp5XushytdkNIUUAZ6/RB
         iE0Y3LNW+aty5ffAbI56vGZuZTcfgPMJ6pheEbVOhLG6mAltDH0Il7XVHdZzGTjoxgWU
         0/Xg==
X-Gm-Message-State: AOAM5332mQuTwLnQJpqVEhb/uV3QhDMr5FBeYKLP7jwyHaIDnNLnIPLO
	ZYaE/RUjupWbM/Nr3cJQj1KKw01uKLqzsVe+
X-Google-Smtp-Source: 
 ABdhPJzI4Bp507DWIgkQ6u0lVdQDFAi2NNY/pe9qwOrCQXYaqaMEKBOQN5s4PpgtDd86cKQhQcKTww==
X-Received: by 2002:a05:6512:ac1:: with SMTP id
 n1mr24825776lfu.639.1637252823297;
        Thu, 18 Nov 2021 08:27:03 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 p17sm37252lfs.292.2021.11.18.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:27:02 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.50][PATCH 3/4] bitbake: adjust parser error check for python 3.10
 compatibility
Date: Thu, 18 Nov 2021 17:26:22 +0100
Message-Id: <20211118162623.3117035-4-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118162623.3117035-1-jacob.kroon@gmail.com>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 16:27:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13071

From: Alexander Kanavin <alex.kanavin@gmail.com>

The change was introduced in
https://github.com/python/cpython/commit/a698d52c3975c80b45b139b2f08402ec514dce75

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8d3c6cbbe6ee734495713ae3b99c609527842506)
Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index aa9ac2c8..65857a9c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -403,7 +403,7 @@ class DataSmart(MutableMapping):
                     s = __expand_python_regexp__.sub(varparse.python_sub, s)
                 except SyntaxError as e:
                     # Likely unmatched brackets, just don't expand the expression
-                    if e.msg != "EOL while scanning string literal":
+                    if e.msg != "EOL while scanning string literal" and not e.msg.startswith("unterminated string literal"):
                         raise
                 if s == olds:
                     break

