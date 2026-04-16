Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D0F88084
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 06:56:44 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7711.1776322601415274869
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Apr 2026 23:56:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=SA0dZke+;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d73352cf2so3804440f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776322599; x=1776927399; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3ybz3ru6dDjpQIG/kx4gXAjA+6IOk+cPP6jKKJR2Kk=;
        b=SA0dZke+aqzAPRE78GuQ7GIITnlXi16X2DBg2aul3FrzBj1iT3xoxhAjjFq/RGVHTZ
         X7bNZyx/Li25BdaH6waKthkzmbm/VsEu+L9me/sOJLitskmn+HsuftjctGyMvViYeRs0
         MWuW7SLkkOBYjjYTQqPQHcM8cGYG0iYKBA82I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322599; x=1776927399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k3ybz3ru6dDjpQIG/kx4gXAjA+6IOk+cPP6jKKJR2Kk=;
        b=P/R0xCtZL4nqzibdV3VV+eqGi/C92resFbLoWo0cRW/v7CL81fhH8My570xC2DGlfR
         bSpZ/HTf9NADOJGYiWEcTHHYhepx9x4YIqnWK7e1HyzPO6yr4qaPCils/2L5A8zqOCt/
         BcOSV7vjGyrvX5Nf6lZbFqfOkGWO4piajh1+yolnE5my7b3lShxN00p81sP1sYlvsFmB
         U6XI7iQPHEb/6wrtuXUyeRGsHG4MZfdSnjceFGUIKhwUPDUkWtFyH0dKARDy9s4UmTVX
         xnvCHXdfCXOqe8OxKbpl9dmSVy8l90x1McZt8tgvUtpL2GbnNF0lAKfr5UUuxOXxdCWo
         gTEA==
X-Gm-Message-State: AOJu0YxsaN7WdQLZu/k3FickVXn3Cf+1ahhCjDO4TbDYlAY4HHoX0aNF
	LsHAnvLmOiQAo2Wd/k4zKC2fC4Tb4rp47fN/2CIy+DWkFuihPSKzIsUtMBSUef9yDyZFMka6ihb
	UUEzVCbIvaQ==
X-Gm-Gg: AeBDievauyOEh5aoFQ5/w0+aSLU2VWlY7Obusq1lyF1cePr9Jl5JVUzw7p+aGqrfp/5
	SptyMRYEoow71sVy1ffxxwUz36G/S+1VgDhg3OFv5vebnjE2T2YEGl0bOE7FS95dk379dhMJJ2a
	ZsF7s9LZeQmrAbOGuGJhjW8pkUI+pfCGN2VB3zd5NQJkf9/azJ/NwIdJL85k/09I9fBcLOWiqDn
	BnPTopxK0wrKpaVfeylVYMlbDAEwkRpik+EWpCd2ZmDCrWOtFMiLNeBtbYJrp43fR0yGZWQpuel
	gVhom4MJlnSxRDYkThkiT660AMZFUviymDCT9AXjGjm/exIjn74S/IM5KCOVeNQeQs5bi3vuLPh
	OtLtYoXEYI4ymAaWU3KPaaHCJgVtb+axMLCARv3waXe6moGQs8FYYw/Af9lVEH8f59NP2v6gV0J
	QSgFF2AMd7NOBYb4sliYq/WNermghfxXWCw6e2f4y43vHbW4gi26ye0wQTZ5u8xqBHmXUGxRKpP
	txqKAFvPSBwn6nfG012PfL8i75kKyr6DaYzFQ==
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id ffacd0b85a97d-43d73dead51mr24852169f8f.26.1776322599443;
        Wed, 15 Apr 2026 23:56:39 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e0091sm9838195f8f.25.2026.04.15.23.56.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:56:39 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 2/2] runqueue.py: make sure we use bb multiprocessing
Date: Thu, 16 Apr 2026 08:56:32 +0200
Message-ID: <713fbbdb9ecc195ceb2216a2345e0d79dbee2135.1776322491.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776322491.git.yoann.congal@smile.fr>
References: <cover.1776322491.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2026 06:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19369

From: Trevor Gamblin <tgamblin@baylibre.com>

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 35866d55908009df429870b28cda0d2266074b48)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
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

