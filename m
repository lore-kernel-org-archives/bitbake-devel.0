Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F7C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:30 +0000 (UTC)
Received: from esa1.hc324-48.eu.iphmx.com (esa1.hc324-48.eu.iphmx.com [207.54.68.119])
 by mx.groups.io with SMTP id smtpd.web10.8249.1745592504859893308
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=oitMUCTd;
 spf=pass (domain: bmw.de, ip: 207.54.68.119, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592505; x=1777128505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0jRWYKOpU/THuyRs8hJumOmCP40EsWRqNd5BOnPqtE=;
  b=oitMUCTdcvHbYEA2u+3Eq9mlt/b04NhpBj8yjJiDRzOHkuvJijbNWqdM
   phQb3TFwjQrvjo3trMADAKLQY40q2hOrFfF3xrn+wjHoTWR+HSpoa9jwz
   Y3DixIcWVNOoDGnIbsxPZYfjVcqssrLo3MJDVRT8DRpzuhaTOzHAbTSrD
   0=;
X-CSE-ConnectionGUID: rp/RwIdKQQyCn6nlLoip1w==
X-CSE-MsgGUID: phV4NkcKRWeepKg4AlagNQ==
Received: from 160.46.252.35.spf.bmwgroup.com.bmwgroup.com (HELO esagw3.muc)
 ([160.46.252.35]) by esa1.hc324-48.eu.iphmx.com with ESMTP/TLS;
 25 Apr 2025 16:48:12 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw3.muc with ESMTP/TLS;
 25 Apr 2025 16:48:11 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 25 Apr 2025 16:48:08 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:07 +0200
X-CSE-ConnectionGUID: Aq5N0M1KSkG/Zv2pEVPvBQ==
X-CSE-MsgGUID: oAb1rx6TSbGNWv1GW/BI8A==
X-CSE-ConnectionGUID: 16/ymhAVQh27GJKowpetjg==
X-CSE-MsgGUID: HL/YJwWFRVafJRyYFPzAUw==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 6/8] fetch2: Fix incorrect lfs parametrization for submodules
Date: Fri, 25 Apr 2025 16:41:36 +0200
Message-ID: <20250425144138.4089681-7-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17576

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

