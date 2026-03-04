Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8425EF8FEC
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 14:26:03 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19292.1772634361166755683
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Mar 2026 06:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=X1L1Lv7B;
 spf=pass (domain: baylibre.com, ip: 209.85.219.42, mailfrom: tgamblin@baylibre.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a07f66f4eso28616386d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772634359; x=1773239159; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/dcqTyrI7Xj+6MKZl6IXErxObEPCgyq8VbyBKzYpt4=;
        b=X1L1Lv7B3RjBi2nHQtIIg+f6FUcd32XxVCLokzymHq3l0yVsivUveWrDlVhjrwLM8Q
         xvVc6r8jTuH2rzPazNcBfNyeenr+eNWETnerOQ1zrIZYw9mEJkj7H+yp+L8lckT+LE2R
         40x0VUkpoRqpBUop7XGVPKywOWgcWEopGI0Cy7ymsEfDjolf84NE3BwwggSrCZNXNBTJ
         dBs3vrEsjsOKHLreoS0P92loLZFt3Ez8Ht/xeOR56S3hRsMcTcwNDxiz418UQtBje/QH
         TisRBUOK2XrjQ0kZUvsRXvcV8nXw0LbLQoOpehObBqttrIwrjEsqEdama2Ezy58UNTJk
         NmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634359; x=1773239159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/dcqTyrI7Xj+6MKZl6IXErxObEPCgyq8VbyBKzYpt4=;
        b=i0xC7MVS2fROKFLGkCY7og1LYjVymVWPaN6yDj6rsqDTtQUi37u6z5f842oaEL4Gud
         0k7D3ugZb1uycdg9ljoimR5XHLIcTtBUjLsvenmJ1U3LV55PhonhRohjVJxDzYmgEiGD
         /1ITEkMH0MeXlMzUnJBb5uxEwH1FNOcgoIj7ni2QA54mSQeVn1kp//30fezTVfCVJQkm
         OBUnPo5uzWk4NVr48I0geYMInIkfQpfdKvm03BTsboQsjREG8r97GOcVtTXS+6F7j0XL
         Stv+/srlCvNN6+HL2q35P6PbUpL6pJRNqQUwoWa27+auQ4eiy3tQE0Uopswqse+JMIMz
         kIgQ==
X-Gm-Message-State: AOJu0YwPp/lQcQthEkDHa1h4kOPvZysHlIDt/T1FIzJlHf/v5EnC8UEL
	w30EZeyCNtBlI+Uvdi4kRp/Q+qqy111sf/3CWvGf078+mAWDOUhEJA7Pbv7GU2SBhzzWd6oE5OU
	T+gAUFG8=
X-Gm-Gg: ATEYQzxclA9FZ0m3f2YU2bPA59JyIZ2TSCOZ8jFB/IsNJy5sSG2hdk/xpfEExsAXUeQ
	yB4HbxQHlQbO8crwkhoizw86CzuF/vtPSN6neKxWg9EWd/I21jg8cj1F4L+984ZNGpNwR2rR8mj
	T6EpfRooMkyU4llNgPMV12dydiKLSQVLCx9ZgRGaQlZV+chtzQAyJ5dkAHQZENR2lDJrlslzIPj
	yabwN/nhLncR0uFlDCuwqnh4snFtBK0iwbYoiX+gmmMeSAB7S8coJPI56E3B2UGrZQ8iWTAzOCV
	fJDKYihVM0BwBhkOFhLSuNabVdUbeQZEe+N9Qs2Bm4y1tnHWfpw4JtB9RwW7RP34hcvwYMBvcUP
	Waz4EFixQU9FWQXWzF8+E5XZJckukfF1uzBKgW6xxl3BnuILzIllGvRUSj7lQudQaeeWhYqEzTA
	1yCiDmYBWBBJAYFA75C36bB/rFe+0=
X-Received: by 2002:a05:6214:2423:b0:89a:18bc:2b27 with SMTP id 6a1803df08f44-89a19d39d01mr24293926d6.65.1772634359215;
        Wed, 04 Mar 2026 06:25:59 -0800 (PST)
Received: from localhost ([2001:1970:3847:e000:e8bd:ca0f:c232:9f10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736bffsm1608072385a.50.2026.03.04.06.25.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:25:58 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH v2] runqueue.py: make sure we use bb multiprocessing
Date: Wed,  4 Mar 2026 09:25:55 -0500
Message-ID: <20260304142556.3346042-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19105

Otherwise, we see errors like:

|ERROR: An uncaught exception occurred in runqueue
|Traceback (most recent call last):
|  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1663, in execute_runqueue
|    return self._execute_runqueue()
|           ~~~~~~~~~~~~~~~~~~~~~~^^
|  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1607, in _execute_runqueue
|    retval = self.dump_signatures(dumpsigs)
|  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1718, in dump_signatures
|    p.start()
|    ~~~~~~~^^
|  File "/usr/lib64/python3.14/multiprocessing/process.py", line 121, in start
|    self._popen = self._Popen(self)
|                  ~~~~~~~~~~~^^^^^^
|  File "/usr/lib64/python3.14/multiprocessing/context.py", line 224, in _Popen
|    return _default_context.get_context().Process._Popen(process_obj)
|           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
|  File "/usr/lib64/python3.14/multiprocessing/context.py", line 300, in _Popen
|    return Popen(process_obj)
|  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line 35, in __init__
|    super().__init__(process_obj)
|    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
|  File "/usr/lib64/python3.14/multiprocessing/popen_fork.py", line 20, in __init__
|    self._launch(process_obj)
|    ~~~~~~~~~~~~^^^^^^^^^^^^^
|  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line 47, in _launch
|    reduction.dump(process_obj, buf)
|    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
|  File "/usr/lib64/python3.14/multiprocessing/reduction.py", line 60, in dump
|    ForkingPickler(file, protocol).dump(obj)
|    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
|_pickle.PicklingError: Can't pickle local object <function CoreRecipeInfo.init_cacheData.<locals>.<lambda> at 0x7f7925667d70>
|when serializing tuple item 0
|when serializing collections.defaultdict reconstructor arguments
|when serializing collections.defaultdict object
|when serializing dict item 'rundeps'
|when serializing bb.cache.CacheData state
|when serializing bb.cache.CacheData object
|when serializing dict item ''
|when serializing dict item 'recipecaches'
|when serializing bb.cooker.BBCooker state
|when serializing bb.cooker.BBCooker object
|when serializing dict item 'cooker'
|when serializing bb.runqueue.RunQueue state
|when serializing bb.runqueue.RunQueue object
|when serializing tuple item 0
|when serializing method reconstructor arguments
|when serializing method object
|when serializing dict item '_target'
|when serializing multiprocessing.context.Process state
|when serializing multiprocessing.context.Process object

Fixes: [YOCTO #16184]

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v2 removes an unnecessary import from the bb module.

 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a880a0d54..239fa770e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -23,11 +23,12 @@ from bb import msg, event
 from bb import monitordisk
 import subprocess
 import pickle
-from multiprocessing import Process
 import shlex
 import pprint
 import time
 
+Process = bb.multiprocessing.Process
+
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
 hashequiv_logger = logging.getLogger("BitBake.RunQueue.HashEquiv")
-- 
2.53.0


