Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF96EF8FEE
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 14:26:04 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19295.1772634362709885171
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Mar 2026 06:26:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=I+CyiECF;
 spf=pass (domain: baylibre.com, ip: 209.85.219.53, mailfrom: tgamblin@baylibre.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899fa7d0780so34282866d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772634361; x=1773239161; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx1ZzFVBRA7FVcWlaot1GDP3l07yUC3efpw+DD9grbA=;
        b=I+CyiECFcGgqmbQ7J/SRvnPExb1nZMuOznm7MWbX/SxFWi+MUZXRMYB2ynQySEFxh6
         EJk5QGqIJBoBwBxrgad1pB5UcDNfIUjcqcNhwZiHALCzVfNYNLwInyUxOW8XmNVdF/YW
         OVsgoq3YG/ZWpiUk814pjLKELIN/lSlYgC9yLFNAVVp3P00bxWyJFQkBBBypoS0Qwc0v
         MV1Tet4uOtHUHkTSi5bmml26IwX324VMVgtD98dqQZrNNzDYOrxubW3uqn7m3yTV0AGq
         HHGcLzNnkNqn4SP8aSqv32CgUc7ixD7NzKFiCy5i0xpWv0mLsSdj7n5gskgBCTObiEEU
         NMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634361; x=1773239161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fx1ZzFVBRA7FVcWlaot1GDP3l07yUC3efpw+DD9grbA=;
        b=fyHsYDyZmNtzfj1N6zs3T41HYKSA9BJJi6qwUsy3Kez2iCRU6oADlmHIMM/yrSRIDv
         Svr4VtT7PCSYH8aGvbUKD0K6T1RTWlQWsjbUn9kmO3wveF+LJFyvXxme4Lg7Js5mNJCv
         H5i8j10+BhGev3iV4ik7c1c6JsRDh74d4WfQlcnkh0kbxKnFKWpcqHNPyg1UrHc7PaPG
         h0prm5+cO8IZxBXZtwBNTvFVa+dS/RQeQhvo4x14bYqLZjL3hrOsJosSSdoKDm2sG/A1
         J766kLOjCfxJLpevZ8CBDMuDP5kuWNzPD2rzbYQk0+6eBNqziHTtLaS6X6/9fPyZmYMS
         rf2g==
X-Gm-Message-State: AOJu0Yw9Wd+0YQDfJpWyMlr/W85nY6d1hhwvVepxZSe/uqF/lYimJ03i
	MUF4bArVBUert3/VCP0K+4tkSmTZk2OTv1OQQTf0JkcgQF3E/OnzH/BM9Eyh7NFkfafirgFLxj6
	xNz34DfQ=
X-Gm-Gg: ATEYQzwnNfZLQp8oUEcVMa9Cg4rDchrt+lEKINl6YGKoBu+/h1WY2lFg5w5q4w3fSL3
	QhByz1tg3s+9WFuFHIPbWG+kHf08AA2ZUSkDW1yFGDqjD9EZnTZK/Wj8doPNbPm7Wv0kH21mj7t
	JnjrOk8rjdO0iUR19O4u74z8rVn/+o13B+qQE27Tch6faucBE8zpdHblE7eEP3h2JPkqtQi0VSa
	rHeyTZVh26e7FL2spx3MLXMtkkOQJg3gFGOpuaeDWm6CUMa/VSEAnw1EJdMG5wjwIKTbVBDEhuv
	vl9vgjgdQeIZbaKhJo8NUQaFhxkAm9Nr7fHUbiGQVl1S9BBdhZIZulZe3RUieX0n9y4wgo2t5cT
	81ryIiyKXUew3+Wd5IGJ3nO1wgLmeKNOvJ5w9LhOOqOgGNPBOs9WqWFsBvmJmtqyN1W+/dkQVWr
	L/BGsL2y5ab4CDoCCG2ntfb+wbsN8=
X-Received: by 2002:a05:6214:d4b:b0:899:fea9:ccff with SMTP id 6a1803df08f44-89a19d09608mr30710906d6.55.1772634360951;
        Wed, 04 Mar 2026 06:26:00 -0800 (PST)
Received: from localhost ([2001:1970:3847:e000:e8bd:ca0f:c232:9f10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a1fcb781fsm4305566d6.23.2026.03.04.06.26.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:26:00 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue.py: make sure we use bb multiprocessing
Date: Wed,  4 Mar 2026 09:25:56 -0500
Message-ID: <20260304142556.3346042-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304142556.3346042-1-tgamblin@baylibre.com>
References: <20260304142556.3346042-1-tgamblin@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 14:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19106

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


