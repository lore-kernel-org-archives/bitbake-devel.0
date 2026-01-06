Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5DCE9D6F
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 16:17:41 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.93601.1767716256694026563
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 08:17:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=pWm/vfRu;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so934583f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767716254; x=1768321054; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LKS/79fNHVHJwCY7U9EHKZsyjeHtgZSaMKKVQIp9JI=;
        b=pWm/vfRu5/9lz0lux4mjtbTKmR/xvK5YCo7DYsxRTngd6RDOY7WfOqExZxu1xJY8vy
         idzrACs96/WSohtObUuo021ejK23kiFB470lcyv7OfvddgQ/lz0jCFC9N650i6Rl1oQ9
         BjVix8XnpJ54uCYkQ8+eWt7UULMQVt9XTO4Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716254; x=1768321054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LKS/79fNHVHJwCY7U9EHKZsyjeHtgZSaMKKVQIp9JI=;
        b=C++yFa5G99REelRt1KVny0Yk7AJPrni6nM4OYDEyzc8Bq50lXgAN60wrd5AYl3Mqbc
         PeLfNuogKLgVQH6e7i6kP32ZRQyGtq8ZWzaY6pe9KJMpaGXy/FGppUGZL55FEmxCnGxj
         9rBX8a4BV9ykNQevBA/Beu7iPMEXxJMupWMDPmGlGjzVyAODrQ8lvvtQ4HzmSnVQ9xF0
         0jkU03CLk5epNkXiPsD8qfNkE24sYlFsR7CZ2xKBaBNQ32k0ciAtaIZp101Yw1N/kAYP
         UBkBRlZYQmPTnCxJWcWnYnD6KJkCVfuXun8L8bqlNwzJkuyiF9UzHuHX9ID/rz9tJfM0
         iQUg==
X-Gm-Message-State: AOJu0YzGcoAj4zWbG7K6RxCvJWCT8Gz4ZxOxMjIkeatrrpnMLHJY7Lmd
	BZt0qEzS7nioB6GaOJvj+PmaMg3c4OuPABCNqn0dUJ/ZlnVOd/ESXQIC2wCmphdl9Igobnlsp0L
	vkkO/
X-Gm-Gg: AY/fxX4pw4c7DjPvP7j7LceavP7wgFzkAwLRS8iCVNHuzmU/idyKRzKmAHFhn8eg9g7
	1ZIZDjMVuv37jc0EBIgkobPedZRFlPgVr8M6DO/BiXrlCNkPDFPrpPs/wh1z8piTjgpcPEg936e
	IawQYikuzoNNRF/1EB/7dnVYfIbnAfeYlAvkvKxPipM+yAHxYFJkUKqiju04+8K3HzbFkfQW0ev
	q4R0aHlnprTw1HLU812BbT00epkUESygSIA/riaQRj6zpfPo+fYujthw53iA5nc/OY6uXg8Xs+D
	bz+V2Jlk5zM4ui/CCwbPpllh60DbrMtaRmrsL7Jvc8mg4R4DAu0Vo2JHVVKFcJO/tuA+mCZQkDU
	egaSInxbenzJYoxHNxjYElYt5BzN6viJU/Fx4MyPYxpNANW/B3pldxBKeh6tG+6iPcmKZVl0ORd
	VyS3N1rK2SAQNAUL8++pZOnw8/MQYzRPMCqKHYyeYcz9uvi2GQQc7WqkkviYp+yjn09D82HqM98
	MBv2PUvAmQRZHZL
X-Google-Smtp-Source: AGHT+IFlzn2zw/oyI1bum0nmVpGME7vFzNXFbuE5HgXTKCkeJue+Z6RYNetGY0OJZRdy34q7mHPApA==
X-Received: by 2002:a05:6000:2891:b0:430:f6bc:2f8b with SMTP id ffacd0b85a97d-432bc9fc52amr5163334f8f.45.1767716254342;
        Tue, 06 Jan 2026 08:17:34 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa0051b13b00a50722a9.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:51b1:3b00:a507:22a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm5186182f8f.15.2026.01.06.08.17.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:17:33 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 1/2] bitbake-layers: Also hide os.fork() deprecation warning
Date: Tue,  6 Jan 2026 17:16:56 +0100
Message-ID: <72fd48b2010b5fd5e4110295adf5f24822267804.1767715521.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1767715521.git.yoann.congal@smile.fr>
References: <cover.1767715521.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 16:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18704

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Import the deprecation warning hiding line from bitbake server/worker
code. Justification is still the same, we are being fairly careful here
and believe this code is safe.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8b02d65a6439b21d8bd5590dc0009f2cf29c1de8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-layers | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index c49a5f30e..37c196226 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -16,6 +16,7 @@ import sys
 import argparse
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 bindir = os.path.dirname(__file__)
 toolname = os.path.basename(__file__).split(".")[0]

