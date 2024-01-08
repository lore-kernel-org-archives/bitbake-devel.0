Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA307C4707B
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:27:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.7874.1704724043142299274
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 06:27:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a4CE2zr2;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e4c1e303dso76425e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704724041; x=1705328841; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlms+xdCk0r4ZYn7leuf+xCvcjntVQxtCTfi7w4wk30=;
        b=a4CE2zr29v+cudSLjjHpCOysGQS5RWDQKgGvqUoJ3R+2hxW4/+3ifog4hJ9ilgRrZp
         ka6F74wGXSZfzXW7UNSJn2eS0vCk1962Ae1x9qTKMKyz0YTe4iggjv+BH958+whxx+Xi
         YL7vYwdAhxS5xCpEN418FnAMyNgnQov+UZ+N01JKf+Mz62C0trkVYw/untD6dGJbV6Ft
         OBa1gq3cJxCbwuO2BNqDWhnaOWCRBR2eU8oowb/UPPzMQG+0626Jhu8zGFSY6SUpn3tr
         eBkw1RV6UDbBuLtBnhjcR82PleINa14nSMnSdDt8DDM/SMGenIFZdX/BGLER/3IylJ+J
         mI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724041; x=1705328841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlms+xdCk0r4ZYn7leuf+xCvcjntVQxtCTfi7w4wk30=;
        b=PieYnY+RjEUs8hHdihUGEmAy1TTrH1KiNZUeCScjedwLVUHHkILv8f+4bW4/5DEQYL
         Z7G6gh8QCuOVeGxqXsnd/a5IWzi5L7PQMLgA+N/npLJP5apCw+n9lVSHNbNurYw9LmfZ
         LtOpk5VEJXNG6ACzM1EIiavy2wuvLZTFPVUwe/xgWq22fP830Y256fEy0eSnhG44iHa+
         1qRr5VeTT6MDk+DpN3JTNeY/J87FcMJNZ6YRPwy462ZNPsaYnEIY0MYaOkDUJ+QD37rw
         4zbSQK8R7D7n7qxdiug1vNcX5kO2aA9znlD+Pmq3xwnfDwGYtse0cdsx5ocGpr9T+XNb
         MbAA==
X-Gm-Message-State: AOJu0YwE1eL8QhGDRwPS7bj2wGRUJOI2njiPAVVgqLf5SabH0iAsvZo8
	q0jxfAnUFX2mf/ztVQZlVBgvGM4ICOk=
X-Google-Smtp-Source: AGHT+IHwZLrJWIwrdwI/m5URbx+SHQbLSjGfqmBIK+PS30wlFTImHEWLpLgAvZc/RnsKaQuy3RQhjQ==
X-Received: by 2002:a05:600c:3ac6:b0:40e:4733:a932 with SMTP id d6-20020a05600c3ac600b0040e4733a932mr770992wms.88.1704724041330;
        Mon, 08 Jan 2024 06:27:21 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id b22-20020a05600c4e1600b0040e4abe5386sm945355wmq.21.2024.01.08.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:27:21 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/2] fetch/checkstatus(): do not print the URI twice in FetchError exception
Date: Mon,  8 Jan 2024 15:26:47 +0100
Message-Id: <20240108142648.2293370-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 14:27:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15750

Previously, there was duplicate clutter in the output, particularly if the
URI points to sstate cache items:

bb.fetch2.FetchError: Fetcher failure for URL: {uri}. URL {uri} doesn't work

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 22a2f80107c..677968a6a92 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1947,7 +1947,7 @@ class Fetch(object):
                     ret = m.try_mirrors(self, ud, self.d, mirrors, True)
 
             if not ret:
-                raise FetchError("URL %s doesn't work" % u, u)
+                raise FetchError("URL doesn't work", u)
 
     def unpack(self, root, urls=None):
         """
-- 
2.39.2


