Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.9839.1631283604450027673
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cC74974t;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id g16so2888195wrb.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BB1LFIm85gdL5vCD7e7pWW36ukpe+OUIbGmPDxhQ1j0=;
        b=cC74974trPTV1x5meL50dFC8OsmOCdeIzrFd+0BlapGE3F+NQ0PeOqpJIME9+9dU9m
         JDGZs2jSQRP+zUoXz7TfSuia4x751q2oyjYNinpLM1wXvFRUZlrHo3WP/aJ0tgNDeyKv
         jVAOrgmJjLNIGUYT2se9Ybj+s27evoGLX2NP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BB1LFIm85gdL5vCD7e7pWW36ukpe+OUIbGmPDxhQ1j0=;
        b=O8V66C3uqdIFIBy0bImJZZKNBBRpvuXwUe9iFoltKEWvAnUz7693yv2oxhho5UKjHF
         kD7GwWiZTfQX6U/7ch/4bwkFsT/RUENCE37EDlH6zuGGh5ajuyNMIae2hLRsXqISKM6a
         qjhDiTlQ0hpMKJtD5HxWD8cN+NIqO/DbY+lqOy1n9b/v6Z2YWwZeA/esKRKpP3bJF3Ne
         uECGHfBmJdgzQ+l4JTVHuMwmXXZlTRsKg6huKLg+gw694/vRGcLIgsib2NYHdxf5ffou
         JgMBDJ6qM7jO3W5CcU8WF3j1oYrhYlhgoNVOqTqAqcEx947D4lLNxbgnXtXGb4ySQfzK
         7Jng==
X-Gm-Message-State: AOAM530BIdXan96kBtxnXw2mrSWSd5QrQLMIbhvYMj7M037pxIa2Z2rM
	DfTG6DR3rkPqj2XxejamVVZr1brYSCloiHBQ
X-Google-Smtp-Source: ABdhPJyutmXZJteNGZAay8eo+7E5KjXZ9ctH44fvioNUpSKmceR7J280Wwm85NlcmtyN8Qq6PqNgrQ==
X-Received: by 2002:a5d:4566:: with SMTP id a6mr10141413wrc.38.1631283602624;
        Fri, 10 Sep 2021 07:20:02 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id 4sm3978281wmv.42.2021.09.10.07.20.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:20:02 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Improve missing core layer error message
Date: Fri, 10 Sep 2021 15:20:01 +0100
Message-Id: <20210910142001.1256843-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the core layer is missing from bblayers.conf, the message the user sees is
hard to understand. Improve it.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1c1e008c6b..e54858cf02 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -396,6 +396,8 @@ class CookerDataBuilder(object):
                 if c in collections_tmp:
                     bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
                 compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
+                if compat and not layerseries:
+                    bb.fatal("No core layer found to work with layer '%s'. Missing entry in bblayers.conf?" % c)
                 if compat and not (compat & layerseries):
                     bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
                               % (c, " ".join(layerseries), " ".join(compat)))
-- 
2.32.0

