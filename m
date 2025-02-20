Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF0C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 22:22:19 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.9890.1740090135593118530
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 14:22:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FXZQWgzW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43937cf2131so10330025e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740090133; x=1740694933; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClVdXPyc7MszqSwLVFvELwAtOAoheI4AG4fc+pfDTic=;
        b=FXZQWgzWnjF/a9QYW/S/kxsuXptHvWyGKbUasROhmc+hiPCR36w5XMmRtq28OGXsmz
         GlJ1TNxP1c1DV1KjMVRR501HF4jbBmJNy0LCOH6woaDb9ihRErNhJ9K1+7lpXR6QkEh0
         +vh1iUlKOjhyo4/zM56FpL8DboK2Avq+Dnozg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090133; x=1740694933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClVdXPyc7MszqSwLVFvELwAtOAoheI4AG4fc+pfDTic=;
        b=RrV2R7yxL2BYqEK1OVjlMWGw5RsObaD2E4vi0JGyDz8keJj/UY48LOJ/IHBkYuH2Mb
         8V/zV3ZVs07AW9Pf6Tw1FCNIc/+0XINRlsiGJiRY5rH+Ld9zw8Lzs3YesyHEcrA5g6hP
         2U2s366YGUNX53BucHjHvA3doxiS3Rir7AQ5VOusDxmLIya8jx99+mFoBx6KcKkLAssn
         4h4KyMPrwqWx2TNXZYMq0gSNU785TMRdujRDcb14tF/AU5n3kZrP9fUKpkj3lhUgsmcY
         Vu957jdvguQk9nP2Bjc/Q0OmDGCH6RBf7SFCNFM173aVwKz0I+FPPoypVor8Td1D/Fj5
         upZA==
X-Gm-Message-State: AOJu0YyVZ/s0CrR0HetZaeTyyY1cY1c3mk1slUtfp+LYZZYxTvqavZxV
	6l05Oznwl2J9V+Hg8PDEZ0VRBd5a7yrnzauMfeWeN8LvsTmsrglnPud1MKWlaBjuNSZY0mAoADL
	X
X-Gm-Gg: ASbGncuWyZMERFFpHbVl52TSxxjVzls+QvILlZThFlfCbDOGNKE7i5NABSJ7CFe02Cw
	aJtevslCBaMMn5hyCYCfGfvbl2bYtzH8HQ06dFc2BhTGreSsEEXpIv2IOD1ed6Bu7V4r/C27urP
	x5LZzkl8tv99zIFQxkc7+Wz5YSJ71sg6EaWD+OQY5pdrwahFTDdFPXqIPLhYZqWCb0G1z8iqVaI
	5D6WYaLFW7jrWcQ5PbZpmdFex5mgl0ClrtEM+FFni7RJfGCS8e5IhAEwI0+88pxVDBcKkLWWcV8
	3wMxqdBxER8iipPw4gYcaZ6XpQjlSgO4F1N2afkEzqls
X-Google-Smtp-Source: AGHT+IEeeyew361lxzM7CjK7/4ttO/64W+G1FRoy5LnvN+P6BdgtJDXqsguAk5zykIa0hbAPX0u0Tw==
X-Received: by 2002:a05:600c:511e:b0:439:88bb:d017 with SMTP id 5b1f17b1804b1-439ae1d96e4mr7894065e9.6.1740090133652;
        Thu, 20 Feb 2025 14:22:13 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:419f:979f:5cd3:2260])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm134776995e9.4.2025.02.20.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:22:12 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Julian Haller <julian.haller@philips.com>
Subject: [PATCH] fetch2: Fix BB_FETCH_PREMIRRORONLY network disabling
Date: Thu, 20 Feb 2025 22:22:10 +0000
Message-ID: <20250220222210.1752352-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 22:22:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17269

When using BB_FETCH_PREMIRRORONLY we write to the datastore to disable the network.
This change needs to be undo when handling later urls, so operate on a copy of the
datastore to allow this.

Reported by Julian Haller <julian.haller@philips.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index de1ab07827..bf00c5ecb8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1840,25 +1840,28 @@ class Fetch(object):
                             logger.debug(str(e))
                             done = False
 
+                d = self.d
                 if premirroronly:
-                    self.d.setVar("BB_NO_NETWORK", "1")
+                    # Only disable the network in a copy
+                    d = bb.data.createCopy(self.d)
+                    d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
                 verified_stamp = False
                 if done:
-                    verified_stamp = m.verify_donestamp(ud, self.d)
-                if not done and (not verified_stamp or m.need_update(ud, self.d)):
+                    verified_stamp = m.verify_donestamp(ud, d)
+                if not done and (not verified_stamp or m.need_update(ud, d)):
                     try:
-                        if not trusted_network(self.d, ud.url):
+                        if not trusted_network(d, ud.url):
                             raise UntrustedUrl(ud.url)
                         logger.debug("Trying Upstream")
-                        m.download(ud, self.d)
+                        m.download(ud, d)
                         if hasattr(m, "build_mirror_data"):
-                            m.build_mirror_data(ud, self.d)
+                            m.build_mirror_data(ud, d)
                         done = True
                         # early checksum verify, so that if checksum mismatched,
                         # fetcher still have chance to fetch from mirror
-                        m.update_donestamp(ud, self.d)
+                        m.update_donestamp(ud, d)
 
                     except bb.fetch2.NetworkAccess:
                         raise
@@ -1877,17 +1880,17 @@ class Fetch(object):
                         firsterr = e
                         # Remove any incomplete fetch
                         if not verified_stamp and m.cleanup_upon_failure():
-                            m.clean(ud, self.d)
+                            m.clean(ud, d)
                         logger.debug("Trying MIRRORS")
-                        mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
-                        done = m.try_mirrors(self, ud, self.d, mirrors)
+                        mirrors = mirror_from_string(d.getVar('MIRRORS'))
+                        done = m.try_mirrors(self, ud, d, mirrors)
 
-                if not done or not m.done(ud, self.d):
+                if not done or not m.done(ud, d):
                     if firsterr:
                         logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
-                m.update_donestamp(ud, self.d)
+                m.update_donestamp(ud, d)
 
             except IOError as e:
                 if e.errno in [errno.ESTALE]:

