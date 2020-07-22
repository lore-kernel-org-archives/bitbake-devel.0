Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.28283.1595449579883803122
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jul 2020 13:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GsVzueVq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id f2so3105477wrp.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jul 2020 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZMy8Em2MMu8cT+YT/0UQK+7rrEqLlHwSwXHYVId/QQQ=;
        b=GsVzueVqJK2pX3dQOfkelTjTAVzHRUh6La+15T1cNIw6Bj2aaa1QdDxtubTLkbO5P7
         vKy0WIAZG35YxjkVCataD+Qz3yshjtFHqb9YIca27WlBNh149xENHcTNOPLQFgisNLvA
         SN4kig6m3VIUZ0O7U05E1w0h1qUpiu4CuCeSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMy8Em2MMu8cT+YT/0UQK+7rrEqLlHwSwXHYVId/QQQ=;
        b=fVqImZjeQB7p1HZgp4vNDrIFWlUoOfc19t0OOxf/zpS0vDvZ0/a6R69qtBg/fygbPn
         HzmAqdZgpAFZdR8JZhQPRDnETUYsAlXkf6glaPfGKds1EYTeAt0S8DmA827Qyr52WIQ8
         /HkjHax0FVxUSYII9gGOLDJ0W28rXCKj7yl5PSuY1sNQpSf7vMyJfTlHkkEPlGO1J+nu
         DofQuGvEDwER/qwn1M+G/zTmqQXc3oBnREOXl1M44Bg/qy1DyP/u+Y+5ple0OaCap+2L
         yLNIGGYx/zZCPmTjjYhjLIWw4gPEK5k1j6SznqeOpfaMHjXN22ema/qpZIxgZSDeIKbV
         FolQ==
X-Gm-Message-State: AOAM53335vgzyf4gz2bDP7Tv1nkecXo42b3a9ukDYyIGw48q0uSQ5vlo
	LuDtDhVnGUhDy2VjuK3cjoAORIS0ovvciQ==
X-Google-Smtp-Source: ABdhPJzfwRdo4mOJ11IfpCeZ1+1MVtrzD0arHDOtz0HN/grbbez2PrGXzQ9q/d/XGXVwS/7g3JGqjw==
X-Received: by 2002:adf:9307:: with SMTP id 7mr1044542wro.414.1595449578158;
        Wed, 22 Jul 2020 13:26:18 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (f.a.5.c.a.d.d.d.3.0.d.d.c.1.8.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:981c:dd03:ddda:c5af])
        by smtp.gmail.com with ESMTPSA id w14sm1087744wrt.55.2020.07.22.13.26.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:26:17 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Handle multiconfig name mappings correctly
Date: Wed, 22 Jul 2020 21:26:15 +0100
Message-Id: <20200722202615.164870-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722202615.164870-1-richard.purdie@linuxfoundation.org>
References: <20200722202615.164870-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bitbake mc:arm:bash mc:arm:busybox"
works but
"bitbake multiconfig:arm:bash multiconfig:arm:busybox"
does not. The reason is the list is modified whilst iterating.
Don't do that.

[YOCTO #13607]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 19ddc1d3ba..f6abc63487 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1614,7 +1614,7 @@ class BBCooker:
             raise NothingToBuild
 
         ignore = (self.data.getVar("ASSUME_PROVIDED") or "").split()
-        for pkg in pkgs_to_build:
+        for pkg in pkgs_to_build.copy():
             if pkg in ignore:
                 parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
             if pkg.startswith("multiconfig:"):
-- 
2.25.1

