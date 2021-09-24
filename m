Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.8872.1632493356901871662
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=YJPmIH9H;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id 145so8993423pfz.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CMRvhHsWJ+IAVa0ezO5Z8K1OlT3I7D9HksMK7N9TqJY=;
        b=YJPmIH9HVje8Mpe0dM6EpHaV00ig1p2I0dTAy0iWPFmA9L/XiTrZ6BoGOh/KpmUvUT
         lLlsBEIaRSDAgbpQcRFmAPgMyYG3fAQx9sE/vIOi1GC4GEtoQHxnub2y8TxcDalsHD7b
         e5cgHg2o0hgKjyRoIQJfMs6TPIDnQGIc/6UtaOtTJUV6bFoZ1iOYgP2P1/JvxoFZtZSK
         td5YNtHQFJvcXbLzMEQdDje9ogBUQRD/JSFodP72y2BSttIPL6cdsqRfnf/uAR3hUyji
         gJScuVNsUzs67JN0BQtgc9eT/aQ740rhGonf9Tx6k9LDdXSUdZkqnqtexzmUEufZ8Fgy
         Hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMRvhHsWJ+IAVa0ezO5Z8K1OlT3I7D9HksMK7N9TqJY=;
        b=ZQGu/Fw0RWCuRb3vLLHZKWHPTZ4+11BG7fOItDX0rA4aQnzgn91KvE1acb88/1wd9L
         KbxwDUgVyyD9iwnwriSTF2aqb2k21SbJ5sb20bU6VK31FFTaEKSjEcNcWzoSHThTsw3R
         v6pgiuDPIRTH/mIEq3mGfXX+OAlHI7ZVfNyXqGJTlkXXgZkTsRyRO9TBbvJXqANmQ8JG
         2J+PMqQ8J16v9Fy9mvmxlYGfrOsSDRx3mggNHqVfRlJ+fJG750lBWcqA7K7ldl8EUu2q
         4pn80VYdTRChlVi0MbQMb4FDDUl+0zw5BblgW8p/c1L+5DaYjehsOedV5u+CJaufohJ9
         S4rw==
X-Gm-Message-State: AOAM531WbP2CR1nmjZKf8QeexipT+Wf2Hl3cJxz1bMNdtDXX5AAzRIQv
	OPcaeJmOlEtOPk4Z/hVmXjvp5aETWjuBIYghf7k=
X-Google-Smtp-Source: ABdhPJyBLz5S6c1ucC4LkZUm4xCCoZkjjZyo9NNwXmjVjV//qlDXWh9f6Um693a6ydVh/tFyjhSeWg==
X-Received: by 2002:a63:b34a:: with SMTP id x10mr3963223pgt.473.1632493355894;
        Fri, 24 Sep 2021 07:22:35 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:35 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 10/14] data_smart: Improve error display for handled exceptions
Date: Fri, 24 Sep 2021 04:21:03 -1000
Message-Id: <83271ee9604094c703f291b003a5df3d458e9adc.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
(cherry picked from commit 551d4c0576a0a0c3406000029df9238b312f2263)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data_smart.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 61b37cf3..68770832 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -411,6 +411,8 @@ class DataSmart(MutableMapping):
                 raise
             except bb.parse.SkipRecipe:
                 raise
+            except bb.BBHandledException:
+                raise
             except Exception as exc:
                 tb = sys.exc_info()[2]
                 raise ExpansionError(varname, s, exc).with_traceback(tb) from exc
-- 
2.25.1

