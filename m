Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE65EEDA6AE
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:57:10 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23462.1772557021095222727
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Mar 2026 08:57:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=fqVKGc/m;
 spf=pass (domain: baylibre.com, ip: 209.85.219.47, mailfrom: tgamblin@baylibre.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso13610586d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Mar 2026 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772557019; x=1773161819; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VS6i0nHQS13VvYPlVMIEnxkXAIwf15cfZX/KxqYYIlE=;
        b=fqVKGc/ml31Cf6nVMUhyQgeSDcjyoNHA7EMOW3y4v3Bn7RJ8mLcT9ZkdzY9WX09dIe
         XgFem8LZBNwpfhRHK5oFU15owLeEritFflnXKyPc+tc6QnFF/mHwhFcvnsJaZKXsNQBj
         Ia/LZ1MtR4Liy5sgR9mtDHROGBdsAnDD1ifK+KLVY61TrAxBXGeMVWGsEPya8S3ZKTWc
         zbJ0d0r5A0GrMSlw+OKUTDG9aZeDrJ1TkrYyDzC70/aviV6SHPMLW8ofvrWxVSgFuHom
         NfvViOmc5MxzsuIr5qgzhZhmr9FZSWD5H7RY/nHIfh4+KITvZA1CO1PNfCY6q2Smd0OY
         BiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557019; x=1773161819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS6i0nHQS13VvYPlVMIEnxkXAIwf15cfZX/KxqYYIlE=;
        b=vJP8rGQagWRTTHjENtlVv+Ft+gWnFl7FId1YYijmeFaUzOzxlh9iN6zTw3QtxnRxVI
         fEkBPaKY6S2rQ8v9RId/b+aUUdNomOseMPhwkLpKrQ5SiYPRtwVTVb0/VMroqy/lz/Y/
         ffk631rcPNSxcFoibHLO5QodtE7avdXH4wm9dLxHdDpmF2yASGfIgQPcZbWfhd70biFn
         9ScKwlQhxbQXYAMfoUHKi+Ent6qseyj6/VEpW81rcnQdb/vNmsP1ExapXgoP91Nk6jEn
         aWOtnz1t3Kfjor8Z1F4XckhyBwt6sxy1M/N3vVgy4ARe36y2H4ciy7aW1KbuITU3J4An
         r2tA==
X-Gm-Message-State: AOJu0YyhgQ4yBlu8zSgVOrC4J49r3+WmbPEFjAxNehZOCQhsmRX036Wf
	zFPRiGTYW3FNkt11eQnBciZ0s4N++6QX+ATlvtJGjTlYLvPAufGbtpRMzYNXlS1JzKQqBT2JtPG
	tB0+XOKk=
X-Gm-Gg: ATEYQzyNxoLQYLZxzFYPiuX4CqcHNFcfkMQen2H/gW8vuRi2f+nSoXNcT/q6Uy2e6BY
	3+MmJ/PdzN74fpV9pCIRl4Ggbc8O4Fjn8yGBhOKm9UYlVL2GvztYSrgTwfIKdx31r97DECRElSD
	APFN/SfeIre4zx4Xv2yLYj/ZKzrRuDsmxRp3F1ewwZ6zHJTbY58IfPRFg2MYowmO6odoDXddP3j
	zxC8ZqnHEJdo2CVyyIASj0RQGZdBsjBwEsBqjFwbX02C78PaCB/068lL59d+LcsZJaSEEU0U31v
	+qMrp2oBEhANhXpFyHcmJiCr+5gXFy0n62oDlcFAQSR5wK0YQFE4DXCm/gfkehd0uuri0M/pGGG
	44Bkh+2ISwkqsBwDOsW55Uc6lc2HRLnHtV2n5htHfXCh1iib6NENC1H73fLr9JMyaPHIkbjDdGb
	eqjZ+O+GvkO4v69ZliZV6mGkziEok=
X-Received: by 2002:a0c:bf0e:0:b0:899:ed40:464d with SMTP id 6a1803df08f44-899ed404a51mr111580116d6.29.1772557019120;
        Tue, 03 Mar 2026 08:56:59 -0800 (PST)
Received: from localhost ([2001:1970:3847:e000:e8bd:ca0f:c232:9f10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a056b7b7csm40927776d6.20.2026.03.03.08.56.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:56:58 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] runqueue.py: make sure we use bb multiprocessing
Date: Tue,  3 Mar 2026 11:56:57 -0500
Message-ID: <20260303165657.1803606-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Mar 2026 16:57:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19102

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
 lib/bb/runqueue.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a880a0d54..27da5efaa 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -21,13 +21,15 @@ import re
 import bb
 from bb import msg, event
 from bb import monitordisk
+from bb import multiprocessing
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


