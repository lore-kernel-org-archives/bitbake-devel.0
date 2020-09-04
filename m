Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.88.1599231334227706924
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FqDb8Kq0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id c19so7688689wmd.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i06STBl4bnXXHCj4y0n8LFSU7PaM6w9jmZzuM4ljRmc=;
        b=FqDb8Kq0G7x8icqoZJMyj8GHsQq+/5iHe3D/CaU1IzSPZ5PcLIVeJYJF1TabiMgEwl
         3rt441BY1C80rG8y2FFhdwhzbDufravkLbH2+idrGN65NldVDGZsKOYUicOdn3EeIJO5
         5GAHpUWF3VfD7DINJPtEXaWwJLRcGxPFhENpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i06STBl4bnXXHCj4y0n8LFSU7PaM6w9jmZzuM4ljRmc=;
        b=nB5tK38xMf3eC6qfJL6KGaJQ1x6jjfU7RrWFFZOEGl9FkitR1xryfxFC5ws+t22SPa
         HV2zx28BH7aKNWaWrVupFsjeNpl/EUXSw/R0wOnzEkvUINGWtO1krHEoF/oWrOR2/0Mb
         SwJ1X5SEOSq+1ohm3bQ7hrIII4FoV9Q1DpJbfCXAgxwdr2KG9doBZRvv7muhfWeLTXFv
         7Ktiih4C6dHc3tXToQID6JC7ZPvv6ISKsOa3jP8Cq7QdBggyxxmdoJP1laaXlAsIklVm
         1wRLghu2Jp2mJp4h3Oo6/2Ws/qlckev5qTt7clguu+xfaOU/7D5tUHG0D++tgZipgPKW
         RolQ==
X-Gm-Message-State: AOAM532jYhM7tapE3Yb5VzDO6Gd2fXV5jRtJ234yz2eLZ3JUuQi2dWVz
	/XV2OAba/YImCHiULk5J1Mn2q+6QiJEH5w==
X-Google-Smtp-Source: ABdhPJxWHdCbZxA4cUi4+IUmkAYwTGG9vetJKq7pv5Rf8si7273gvKY1S7fDgijcvzK3d97CDLHpVw==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr7621786wmb.57.1599231330739;
        Fri, 04 Sep 2020 07:55:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id z11sm11684050wru.88.2020.09.04.07.55.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:55:30 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Ensure parser replacement calls parser final_cleanup
Date: Fri,  4 Sep 2020 15:55:28 +0100
Message-Id: <20200904145529.1817812-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This could potentialy account for some of the missing thread cleanup
we're seeing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index beb72958af..ac64b0e1bc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1563,6 +1563,7 @@ class BBCooker:
         if self.state in (state.shutdown, state.forceshutdown, state.error):
             if hasattr(self.parser, 'shutdown'):
                 self.parser.shutdown(clean=False, force = True)
+                self.parser.final_cleanup()
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-- 
2.25.1

