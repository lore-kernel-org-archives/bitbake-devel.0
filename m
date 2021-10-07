Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683BC433FE
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 12:55:34 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.11215.1633611333737043438
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 05:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CwIQIsie;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id e12so18811999wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZRWNx5xymwApEURGHScpfT86oVlO1G9VWYaHjjg0J/4=;
        b=CwIQIsie0Hb1waxTKc3+hw18obGP+BbYDlpFP7YXuMIYWiFDR/UTWuTZCJhY85LPh8
         +37RjpCtj5hg4F+2I4fwr4+4/AWGD+UATWM6bGJpmN5WKoGQ3oEUNZUym4/aCWNbCvzY
         7bp8J5ODNi2/GsMs/bnexeciy8yW2YOTK4hSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRWNx5xymwApEURGHScpfT86oVlO1G9VWYaHjjg0J/4=;
        b=qZyZep+6Q/ZzKnDiYG/ydpAP8NM52hECYmhbnOYbc60dm4pZ0AiskZiGFbUvjNC+Cx
         8SWvAe2mOLUlyUom/aKDyBV1dxdH9ABgGyQ3UgHqT4VJWHNcbT2gfUHwM3RXS+dvWcfW
         bK0c8hAPLNYTaBq5j4C6taz/HsYcN9d/20EgDlF7TBQjLof/HFuET8PRMIF9EsFIuGd5
         QAyLmLbWNswPzI/uqtBquce44qfZuJ7ts5o+qxFa4FN8W7Nkv18GdGpgtQRSqZeHcon9
         QDrrD3tY/pXMikT2YP8nQ4dGuckHZxB4yMhrLaQmoPrY0dhJriJnybhI4MoVEJQG+pA5
         95+g==
X-Gm-Message-State: AOAM5308oBWZ7+jHVvVBOKoYkCfbi5a7i4Nl/co9iEtKgvfF4oJDiz3Y
	tvmh1AoE8bTmd/U2YbTvDNo7+LJTQkrLDg==
X-Google-Smtp-Source: 
 ABdhPJzg9IDOGga9WFIefoZRKcvyLStcXeJoJK7MKkLWAMoAWUKLx6uDbGFDiV2aFOeYmQgLsj5jFw==
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr4394819wmj.129.1633611331744;
        Thu, 07 Oct 2021 05:55:31 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4ef0:3e29:718c:a98a])
        by smtp.gmail.com with ESMTPSA id
 c185sm8759653wma.8.2021.10.07.05.55.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:55:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-worker: Handle pseudo shutdown in Ctrl+C case
Date: Thu,  7 Oct 2021 13:55:30 +0100
Message-Id: <20211007125530.2414480-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007125530.2414480-1-richard.purdie@linuxfoundation.org>
References: <20211007125530.2414480-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 12:55:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12740

If the build is interrupted, handle the shutdown of pseudo even in this
case to avoid data corruption inside docker containers.

[YOCTO #14555]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 115bc1d091..6a12e1fed2 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -287,10 +287,12 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
             try:
                 if dry_run:
                     return 0
-                ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
-                if fakeroot:
-                    fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
-                    subprocess.run(fakerootcmd + ['-S'], check=True, stdout=subprocess.PIPE)
+                try:
+                    ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                finally:
+                    if fakeroot:
+                        fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
+                        subprocess.run(fakerootcmd + ['-S'], check=True, stdout=subprocess.PIPE)
                 return ret
             except:
                 os._exit(1)
-- 
2.32.0


