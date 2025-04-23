Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB067C369D8
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:47 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web11.11597.1745421943467318387
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=ei2A/iqJ;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421946; x=1776957946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rtlPtw53Ioy5i9o05upUCtZcVjmQW3zTrL1WqLX4MKo=;
  b=ei2A/iqJoAc/uci+X/bB2ExSXaNWoDd26c+ubxgV1PCyp+SAYq0vM51c
   6Fm9etCl6kWWoIbwb3qMz82Ly78zUYbiH/bRZhbCyvSZYMynkKLt1ifOR
   E+o449+A0gexifUA8QrNojhn8STLEe9D1c+WPZKXXvqhFYsrkI/Rm3ZSe
   Q=;
X-CSE-ConnectionGUID: d3wDcS8PTgSeZ8vlVV+KMw==
X-CSE-MsgGUID: zyzGdGNxRwORToJZcDDyGw==
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:41 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw5.muc with ESMTP/TLS;
 23 Apr 2025 17:25:41 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 23 Apr 2025 17:25:42 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:41 +0200
X-CSE-ConnectionGUID: DUC/sY/RS7+XYR0z5JGN+Q==
X-CSE-MsgGUID: Q/g22zgvQ7eVGiIJgbcxwQ==
X-CSE-ConnectionGUID: pC75zUJ1TISpuNb1oDV/Jg==
X-CSE-MsgGUID: nq5IQ5/GTxiGkwsjINXgGA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 6/8] fetch2: Fix incorrect lfs parametrization for submodules
Date: Wed, 23 Apr 2025 17:18:59 +0200
Message-ID: <20250423151901.1300944-7-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423151901.1300944-1-philip.lorenz@bmw.de>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15a.europe.bmw.corp (2a03:1e80:a15:58f::1:68) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17548

The existing code would pass `True` or `False` to the git fetcher. As
the fetcher expects `lfs` to be set to `1` this always lead to LFS
fetching being disabled.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f514aedaf..aeeb3cf63 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -122,7 +122,7 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
-            url += ";lfs=%s" % self._need_lfs(ud)
+            url += ";lfs=%s" % "1" if self._need_lfs(ud) else "0"
             # Note that adding "user=" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git://
             # URL a password is not supported, one have to use one of the

