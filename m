Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51AC369D9
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:38 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web10.3559.1745576309445575421
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=D776UNz5;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576311; x=1777112311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0jRWYKOpU/THuyRs8hJumOmCP40EsWRqNd5BOnPqtE=;
  b=D776UNz5vxE73t9C7bRBwZPA7EsYz6GYYPVrDJIW/HPr/M0DzEzi6JO3
   QNIlsJ5cj7B5+6u+uYWWktKXiWoMUtiktqecUyuc92UPAN/Qnb08l/YN0
   f4QlXDHl1+1gX/3t1W0+JHy4umo+Iw3rXzG0V4YLmeI+N7UyUj81Fu/Z0
   s=;
X-CSE-ConnectionGUID: mCnDBbWVSDeAF3d5As26gg==
X-CSE-MsgGUID: gSm9YY5IRtaATGdOS/RUNA==
Received: from 160.46.252.38.spf.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw2.muc with ESMTP/TLS;
 25 Apr 2025 12:18:27 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 25 Apr 2025 12:18:28 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: 5a+JEWnfQj+WRQwfqEuMZw==
X-CSE-MsgGUID: spZKqLGbQbGQUA4YSo7hZw==
X-CSE-ConnectionGUID: Hg02CYhbRZmV5Y3zw58A3Q==
X-CSE-MsgGUID: ojHEtf7DTm6vyw/jeLZKqQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 6/8] fetch2: Fix incorrect lfs parametrization for submodules
Date: Fri, 25 Apr 2025 12:11:53 +0200
Message-ID: <20250425101155.2905972-7-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP09F.europe.bmw.corp (2a03:1e80:a15:58f::1:2d) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 10:18:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17564

The existing code would pass `True` or `False` to the git fetcher. As
the fetcher expects `lfs` to be set to `1` this always lead to LFS
fetching being disabled.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
V1 -> V2: Fix invalid value being passed when LFS was disabled
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f514aedaf..c8bc54e6a 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -122,7 +122,7 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
-            url += ";lfs=%s" % self._need_lfs(ud)
+            url += ";lfs=%s" % ("1" if self._need_lfs(ud) else "0")
             # Note that adding "user=" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git://
             # URL a password is not supported, one have to use one of the

