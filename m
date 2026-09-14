Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FEC88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 05:59:16 +0000 (UTC)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13382.1789362146863214825
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Sep 2026 22:02:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kjvMwHY0;
 spf=pass (domain: gmail.com, ip: 74.125.227.141, mailfrom: zhangqiang.zq307@gmail.com)
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1328853a91.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Sep 2026 22:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789362146; x=1789966946; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=kjvMwHY09IZvyZB0Znabac6d6wA/hN6Dxae6ubgcnzuA6J1sEBE/NCoNtGOHxIUJMn
         af3jVNVqR4VXOwUnI/Ys42T/cF4v9TgcdzcVSPqvtSk9QcYwBI+V6SoQDo6fZr4dRR29
         nOeEUk/A+K5UimbIKj831t+NklYjAgMHEAUFQvdQbporEhGi5tJran/oTceBGn+vgs2H
         FzzcwBvICiRHvqGdjr7jXoCQP4jNvgBoH+WQmnnFCmMgNb+5Ki8DCHKdP+tc7n0Lm/xx
         TuYgXbe1EJjucqt5mwTP0m3YL6voHjgFaSC0IfuoE7pq5kQbUiUF2jfpdEpCIv7MFsR8
         ztBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789362146; x=1789966946;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BG5Ca5hLuzYMf0n94rBk8fU3BzYQcZZ8sUgFkKXyTKc=;
        b=I49oYDAQY6bn6VU2S2zPcHiVq8+hu5WWF1iD+MVQfkrkTyuDHmdgGl5rOXgicGMi6p
         CPwOkGi+C1NrmNudFTacPD/4TLAZQxABCOEA/HN9cu1/pkfJJRaMGQ3AYr63h9ZWnK9b
         F53ybYxh4eCxiPsoRIjMeyHjsxXx/SUkz8yJvjjRX5VEhl/4xg4jnFfK93QhcQPD6Bkc
         cgWQm1KF6NWVvc8WjTYGcVs+HR/PocY44OD6xVIVk7w9JPkxPYy6/f1OenuVB7eY6I2z
         VEKDtNjzK0kptWKns6jRIeWVcqVj2hPImMXuRfsTolBYNT4BkQBtFEuRrKHm4onhSDHh
         phtA==
X-Gm-Message-State: AFuF++kPysWjRTtUF/O9TSzvFaVCF5IcMF+fetN+zd9rU5vY8gY6E1Sz
	SIwx3fKeSDosI33ha/yKUbf51ouPP+j1Du491EV45bxpdYGXblW5OegDdaXSGQ==
X-Gm-Gg: AYBFou2emkW/LjtQdvt25n9P5ve8mlPkOu5deCzi1XBc9ueOv/QVdhufta+WIAY7Lx5
	65Pv2nRreI/KlRahRbIUNkpxANCAIpJBd4nDTCMNHbF7DPOG3FB7qzI1q2vB2t2+3xZarJp5W0F
	9foDa6XfKEvzPLJLb6sopE9Ydb8mwD1YQy4MFY19fpNKd+FWnI3fDr2DkcspqjhcFbMG8ACV+av
	oP0DXcIF8lzLeF4QecbqVv0XzVk53nTCXBk5dDygvTSsXgfteSLifVLWSKqRRFqPymqefsuWfpH
	CbkBt0m1cEopOL/cQbm+KYfKQVYS/Fkup0DlehfRcVi2IiYKOGagPq4g+Ifengh/PEleNRd78pV
	c1sCqznEVhWLzLGhLZjdWf4Y1sbbVrkQA7W/LU7tBTQ8F7KxpjtLIUYrHnN9bguiHQc6KNCxL9C
	1PFu/llTAF9nVlCgoipJ1VkTPjGUhTfl5gr0dBvMk4a6ECKPlgfxc6DJ4wWi4J/zj7JJq+cSrrj
	aC0GSSh6E1uLgWnEPgWvA==
X-Received: by 2002:a17:90a:d60f:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-39debf93ddamr2204934a91.7.1789362146084;
        Sun, 13 Sep 2026 22:02:26 -0700 (PDT)
Received: from PC-203689.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db996bde4sm12714197a91.7.2026.09.13.22.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:02:25 -0700 (PDT)
From: zhangqiang.zq307@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?=E5=BC=A0=E5=BC=BA?= <zhangqiang.zq307@gmail.com>
Subject: [PATCH] fetch: Add log_errors parameter to Fetch.download()
Date: Mon, 14 Sep 2026 13:02:09 +0800
Message-Id: <20260914050209.1442350-1-zhangqiang.zq307@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 05:59:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20191

From: 张强 <zhangqiang.zq307@gmail.com>

Fetching an sstate object from a mirror can fail transiently and is
recoverable when the caller falls back to running the real task.
The unconditional logger.error() in download() makes bitbake exit
non-zero even though every task ends up succeeding, as bitbake counts
any ERROR message towards its exit code.

Add a log_errors parameter so such callers can request the first
fetch failure to be logged at WARNING instead of ERROR. The default
(True) keeps the current behaviour for all existing callers.

Signed-off-by: 张强 <zhangqiang.zq307@gmail.com>
---
 lib/bb/fetch/__init__.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..0c3a4a7d4 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1884,9 +1884,12 @@ class Fetch(object):
 
         return local
 
-    def download(self, urls=None):
+    def download(self, urls=None, log_errors=True):
         """
         Fetch all urls
+
+        log_errors=False logs the first fetch failure at WARNING instead of
+        ERROR, for callers that treat a fetch failure as recoverable.
         """
         if not urls:
             urls = self.urls
@@ -1957,7 +1960,10 @@ class Fetch(object):
 
                 if not done or not m.done(ud, d):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        if log_errors:
+                            logger.error(str(firsterr))
+                        else:
+                            logger.warning(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 m.update_donestamp(ud, d)
-- 
2.25.1


