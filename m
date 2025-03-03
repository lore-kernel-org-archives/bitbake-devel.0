Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DEC282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:06:35 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.52382.1741007192369065713
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XTawXsdy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390e88caa4dso1942263f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 05:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741007190; x=1741611990; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sA7VBBFD/Ovp/Lk+yD15NL/c2cbd5C90InQLdtyElZU=;
        b=XTawXsdyj8BIDuPchUB87ugJ2v2gkTlBKENT+bVLVCCDJy2tfy/pOJF5a4oqPdLu0Y
         MCjIVU3cn9X+yUvdDXpIGHu0veojdA+1hb31PDERCiOJOd99eD0U2Y/sqVR0FbdozD0/
         SR2QHpwv17t9rJj7U9h5oq2ckughhZp0VhVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007190; x=1741611990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA7VBBFD/Ovp/Lk+yD15NL/c2cbd5C90InQLdtyElZU=;
        b=qALJHu/fXiOC2VQnwj8EKIzNDEuynxthAWTKHCs8iv6qXWcUNxlt++qJSAlsuzjoO1
         NdhJzdbvCAieNBlthVfve1auu/VkVdoxvwsVCPUMzex14+NNCihlpE4Y1vA+h9Zh1hUI
         q8X3UANmaoJf4Ss6dPCL/VWJpTpI7F9PkpydsrDcyIXISX9K5HTFeJgm4ntxYR1n5oZM
         XPENPB9P1nv5r7VuYm5A5XbXUnvD1caQAEFX5fCN1D08sDENzuxr3NzYIB/RxS94QHX4
         9gF5E11u3zZ8JJHX9wHyJL70KfMhLp2mrvRivN7X/Xq1/hSDvsba96amFHjbwN52K2+/
         Qq6w==
X-Gm-Message-State: AOJu0YxsLc2hHVX5Od0IuHmFMdNygEwLBqri3kjeIlOhvuqxtbgvctQJ
	kHJ6KW92s3off/xZnwLaax6Bq+uOF0kKQpiW7ibOCpTsyH/K1XS0OrQGQpj0IxZtZzfq1UHt5f7
	x
X-Gm-Gg: ASbGncsw+8egXhxwyn2p6/gZIzF2ZkM5Avpgns/A0yhCywoHZCWzfHVeskqzm4vldhP
	3+fMc13ZdL7zKIKBid8HKx6mjbXQeMuwAmrVyo8BTjrMH7yKa6jKJvvHqlEKzmfGmi3wCf5Nw89
	+huoTtZBayAXenBihfvDbt2Mgcssgawhq7McPsccLg6eUKAj2+W+lh0M4LcH8/fH0r9affJVyms
	S2e6NkDCMG8AOrFInYYQaaSb0grRQI6Tdyn4H6gGH+QJj7vL58CkjglU2yydzeXqAn4poadMvsH
	T1hDBrflRAh+JXGtT7zYCWSKKKviq61f4k8b+lysnrAklpQ7iX3Gjgs/LoQxnMX/jRirb5bM
X-Google-Smtp-Source: AGHT+IGF/jWH6HNFqLaYLYzfyOGcZex1OrwUWH8LrzxHzGCSfQr489W/eEcFbWcZ/99E60trkJ/IXA==
X-Received: by 2002:a5d:5850:0:b0:38d:df83:7142 with SMTP id ffacd0b85a97d-390ec7ce1b1mr10135688f8f.22.1741007190275;
        Mon, 03 Mar 2025 05:06:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c70:3037:60d2:90d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27af83sm160667145e9.30.2025.03.03.05.06.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:06:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] utils: Print information about lock issue before exiting
Date: Mon,  3 Mar 2025 13:06:25 +0000
Message-ID: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:06:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17369

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3cb59d8078..da8c20fe95 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1884,6 +1884,7 @@ def lock_timeout(lock):
     held = lock.acquire(timeout=5*60)
     try:
         if not held:
+            bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)
         yield held
     finally:

