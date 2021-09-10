Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.9549.1631282863432050189
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZSl40BF2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id t18so2868636wrb.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ai42KmwpMX6hNriequg+haSMKsMwmHM9DJKjfMw0m1s=;
        b=ZSl40BF2UK4dw+zyPEswuPaYPzs48M+RVaEph9uKRmT6CSM8O1bcrQxUFsSYRsscMA
         xZKc54o+BBoFicQti+8YIHIROdmsChuO9rBnXDzZhOIFCfWfSXuB1WG/Vxsr01/ywBQK
         ndaV2QilGdLAG72mV5Pv+a0qQ/rE3LasPAIDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ai42KmwpMX6hNriequg+haSMKsMwmHM9DJKjfMw0m1s=;
        b=s0ETFDC3Gyzfpk1ItCY0DzFHz5jTpBndpNdXD8V8l8/sQlKL6UmkFoNlTe7jmyGdJs
         98O4uvBwv6KCrgkyNrtZvFHJn9BCo1oXjAKIzLDLNpSzaUg0zzrwD7FA5Tu0CYfWpnl9
         e1LOtTv5VTan1pjqARVgd0hUKkhCGnMfoCcOPe/dDCLak80OZlCXZ1hy/LkR9Fd192nr
         1TMmfyRBnKKDdHKPRUf2mxg6tY010wy5Tui7KbxIcmabayzOzZ4fjfol0or4+tFkB365
         Wc9jUDS+0VNb7NkIClaVH18rzDbbS8lnD79J8ZKxpxcWPZSpys4ro1xu8zZqaAmdbMV5
         oZNg==
X-Gm-Message-State: AOAM532gb9/T5HycSh7b8kzZqX2tjvSrXvpUVWirwOA6ArjrVImD7tuV
	DWhBy2LVLOrw9iiClo7GI3KkAv8DckWiDgbV
X-Google-Smtp-Source: ABdhPJwO0gv7yiT1Vo4L2Kr38shogqgNwecolwcfHro7+5giPpSNIn/bDCP2HajHfjtkna3cCPKvQQ==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr10281975wro.109.1631282861902;
        Fri, 10 Sep 2021 07:07:41 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id l10sm5292231wrg.50.2021.09.10.07.07.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:07:41 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] data_smart: Improve error display for handled exceptions
Date: Fri, 10 Sep 2021 15:07:39 +0100
Message-Id: <20210910140740.1256597-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need tracebacks for BBHandledException. Reduces confusing output like:

ERROR: /meta/recipes-core/images/core-image-tiny-initramfs.bb: Circular task dependencies as do_image_complete depends itself via the chain do_image_complete -> do_packageswu -> do_image_qa -> do_image -> do_image_cpio
ERROR: ExpansionError during parsing /meta/recipes-core/images/core-image-tiny-initramfs.bb
Traceback (most recent call last):
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image_qa', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1050, in follow_chain(task='do_image_cpio', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
                     if task in deps:
    >                    follow_chain(othertask, endtask, chain)
             chain.pop()
  File "/bitbake/lib/bb/build.py", line 1038, in follow_chain(task='do_image_complete', endtask='do_build', chain=['do_image_complete', 'do_packageswu', 'do_image_qa', 'do_image', 'do_image_cpio']):
             if task in chain:
    >            bb.fatal("Circular task dependencies as %s depends itself via the chain %s?!" % (task, " -> ".join(chain)))
             chain.append(task)
  File "/bitbake/lib/bb/__init__.py", line 165, in fatal:
         mainlogger.critical(''.join(args), extra=kwargs)
    >    raise BBHandledException()

to the real error:

ERROR: /media/build1/poky/meta/recipes-core/images/core-image-tiny-initramfs.bb: Circular task dependencies as do_image_complete depends itself via the chain do_image_complete -> do_packageswu -> do_image_qa -> do_image -> do_image_cpio

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 515d195fe8..e4afac64b2 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -418,6 +418,8 @@ class DataSmart(MutableMapping):
                 raise
             except bb.parse.SkipRecipe:
                 raise
+            except bb.BBHandledException:
+                raise
             except Exception as exc:
                 tb = sys.exc_info()[2]
                 raise ExpansionError(varname, s, exc).with_traceback(tb) from exc
-- 
2.32.0

