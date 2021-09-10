Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9765.1631284042124962483
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d3wbzzGG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id q26so2903173wrc.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BB1LFIm85gdL5vCD7e7pWW36ukpe+OUIbGmPDxhQ1j0=;
        b=d3wbzzGGViTfrKFqy7FAQKO3dW5QXoRPD8rXQfXl9lAs//rJYTVYO64DguZcKH1UTZ
         gNXdvUDabfxIgATbNQaTbKfPHmGwZ+iI0m2XPe2DRWYCZGzkk98y5oB9BHcKFq8kblaa
         AKiBY4h142Fhv8lUjDHubPbhS91hxxdqqg6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BB1LFIm85gdL5vCD7e7pWW36ukpe+OUIbGmPDxhQ1j0=;
        b=AZ+EOb1ot7Q8CAJ0fvwpX3Hq+RIxzO3Ej9aQqZW6fY+bGV0h3PwKh0CQ+ad+WRmUBc
         rmiqiuKoUqxz0p3nx8+geRQjZtXHZ+kx9SpGSfrdI8MMgl+5ht10RRaWPeWLgUKW/ebe
         PBy9FApxVKHwJCJKReRgsaApbsaXG7zRUJsjEVt38qwSZH/WmVoOyjAPy49VCvlXER+f
         PodyNpuj1NGJZJfg1Q36r0Lj4ih8Md8ub9dMv4zgi/167ojsNHk1LE9pN9SKPLttxFH1
         4rjux83l8SjpTXyZvs4TLK5dLCkMRU88dMu9WMXyToKLrVGkguO1BLG6Ta+Y84k12pKF
         S8TQ==
X-Gm-Message-State: AOAM531qFD0dW/VYpZdq0SfCO1kxsPLzMJNnGNc9jBXvm2+lHffW6k1e
	jzM7rirawQH0uzPWZfPbvA8xhrnHtayuCYHp
X-Google-Smtp-Source: ABdhPJytmcUOOH7R/SmqszT9tFu5g2svGTjhyQIYYdn6wWI2L4XXIWVL6Pwckt7tzpObDkbuiWbKYw==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr9942342wrn.365.1631284040243;
        Fri, 10 Sep 2021 07:27:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id y1sm4737586wmq.43.2021.09.10.07.27.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:27:19 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Improve missing core layer error message
Date: Fri, 10 Sep 2021 15:27:18 +0100
Message-Id: <20210910142719.1257009-1-richard.purdie@linuxfoundation.org>
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

