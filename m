Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF3EFF8844
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 21:02:35 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32755.1777064548140921797
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Apr 2026 14:02:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=RQEMzk76;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d734223e4so5683142f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777064546; x=1777669346; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5mkfX5qyQ9/Bu4pIuSfN9gNPThYa22SsqLJccA1eAA=;
        b=RQEMzk76ikep17SyiS8SK5nIkNwb3V6dFFpRjT57tX9a99rg4Z9+sHXx8pZqohNgln
         HCn8B0XkeSez7ETqesQPVFEaDfTeLktgZZR6Yequ1bhSJ7WSCdbkFxFwHUGoOidQFz/B
         0+rIns38b/sOTkLY7vNkkTBq4e9RLeKMMftCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064546; x=1777669346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R5mkfX5qyQ9/Bu4pIuSfN9gNPThYa22SsqLJccA1eAA=;
        b=ZydLWszKX19BnK3bOz8W6WSTSpzmy3kN12pireItpNr57LTCTUpDfT2ORkP/IyxJif
         dvjc7A0CvutWAUecad+93HTjsUft4p+PNH3DkR0ccNY9io0owEUroMf/2EXTG0zDj7rs
         RL4MsTC3l+y5OSXy+GZ80k8/61JIscDNy3VyEFzXL7YJp8Oks8g15lKNsxUGBUUwSEFH
         2lntXP55pb8eRnsxrg3VnC0RkfHx8Fm+lszcOTLkUsHiAqyFjqCIquLzmbQyPByLwdGx
         DYh6jf3QxSg2pkM7+JCz4ZJKl1rdvUNkrDsax2uhw+yy1DBU2CXOCvyYbSpfdIgohWtW
         oPFA==
X-Gm-Message-State: AOJu0Yy567gogNvWNtTm47z4EgtopyE/BAQC/Aszubzj5/D+QYpvZoPm
	Bbh6XqGbFHMmDkEiIsUq3Rof5czgRxQS0YPaokM4UEAvjdgAOHGrdiORzCQHNsmBu9VPd+a30uI
	Qy/F5DxNmNQ==
X-Gm-Gg: AeBDies76nK3HdclyHiYOHokmvbiY+Tmnk/cG18dxJsBVaBonOz4pAE7LjjusQRXGTD
	NIY2eDVsBY17u4x6E+YeArBGtSYJGKsV7a9LDUfN2fuqwD1kJ0LI/TOFA/I5ntlrpVZl/ZuDqhi
	xsz43zWQd8B/RS4Dk+af+8DkaK9DT8guPjrV88jrf5is6Il6HC1fDR9w+SCRh7msI9iWP28v40g
	BPUGZFcZzPI6yC/VRxNhaHOhUmHrht7vrMY/YL/QRu/BO0rJL7CyzPquJtUMluqdI2qioCYhueF
	O8VuAaoVQXacihkrIEDvEtEsO7sasFw7kY5R9U9OmpIzzJqCZ8SrA3ijSqlM4hizizYCuGfh3hS
	KydjsqDlo88JqHmHjmyQR+KkhpQb7sb7vlEOiKnZTsu3M179ikFwK0g+I166OxpSdAHlh9wCw+I
	Iz61bhP5cYLcnnn2THCkoUNCB4mZuLLAIDAMdD7QMC2Jz8X+n/xyROoYEvvuCocpgs/5TFFTxfD
	jQFyJrYIkSgUXH1AN9i3YrE6JK8ZHBl806PpzTOZzMlqSp5
X-Received: by 2002:a05:6000:228a:b0:43d:779e:afa8 with SMTP id ffacd0b85a97d-43fe407a7e5mr54358638f8f.16.1777064546300;
        Fri, 24 Apr 2026 14:02:26 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm58146548f8f.22.2026.04.24.14.02.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:02:25 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] runqueue.py: make sure we use bb multiprocessing
Date: Fri, 24 Apr 2026 23:02:19 +0200
Message-ID: <c118575bc4f278bc857c532089e1c66ae81234f8.1777064424.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777064423.git.yoann.congal@smile.fr>
References: <cover.1777064423.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 21:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19391

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
index db68f97e6..5dc6fc047 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -22,11 +22,12 @@ from bb import msg, event
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

