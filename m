Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F289C3ABAD
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web10.13165.1745914683459549615
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=CIrCAxKB;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914684; x=1777450684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0jRWYKOpU/THuyRs8hJumOmCP40EsWRqNd5BOnPqtE=;
  b=CIrCAxKBwdM4Dv6r4L9hgih5fDSs2YiKL32Dapp9yRRxZABnoa1sa+nc
   hZcPogd6PkQxoAPVgef5BUtFMfeAJF+AzpfhqaylAOf7lz2PRlw7+GURP
   XAmXH/0ZCipX5hU8LiOaX/H0Tz2IGR2bEHPZFSE0jVQI2766nkXnAIPVS
   k=;
X-CSE-ConnectionGUID: J3Herv3aQBOlJq+WY/Y6Ng==
X-CSE-MsgGUID: yIxEu45xT7OL58PW78x9Bw==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:59 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 29 Apr 2025 10:17:58 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:58 +0200
X-CSE-ConnectionGUID: PGmc/tVZSQm3HiPANj4C6w==
X-CSE-MsgGUID: uWBd12Q2QRSag32aG0SKGQ==
X-CSE-ConnectionGUID: JYpH1IKwRzyVHOloPYv8oQ==
X-CSE-MsgGUID: N7l2ShYERGmPtBE1pD1KXQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 6/8] fetch2: Fix incorrect lfs parametrization for submodules
Date: Tue, 29 Apr 2025 10:11:22 +0200
Message-ID: <20250429081124.3695505-7-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429081124.3695505-1-philip.lorenz@bmw.de>
References: <20250429081124.3695505-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09b.europe.bmw.corp (2a03:1e80:a15:58f::203f) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17588

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

