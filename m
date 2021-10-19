Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC92C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:36 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.15454.1634673995763757154
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=hX4eA+B/;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id b14so4702176plg.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7zYgb8btKVounBc9CaAUOBE65GRByYstVjoIScqnpVU=;
        b=hX4eA+B/jcVaujMGVSbiS5iuu8z+NXChI2ETWTM5stvotJWkpPtVr4n0w7ASrUysB7
         xAFR3J8OpBEl3MFVJjdsRjrT/oa56bod/I/aXBHRqb7qNkb4x4HdfY0CY+lCpvtLjjH5
         cGzkr+KKSwrLz219ow9W0eXxXQCOMOy+oFWQfBGkqz3BM635da7XPAuH3wlHOxdTHLvP
         tttsmXUABoUheBXIHJlXx1v/F1xUuIuNnyDirqF5AaRIE3CL3K9/VG8GOcGYhJLbDnEi
         /DeH1DuvNvgaqk3ZVmhASprIc56T+r4u/Fu3yga7wp9vLpwKVugNsNrVm/5JqNPlJ9IM
         vxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zYgb8btKVounBc9CaAUOBE65GRByYstVjoIScqnpVU=;
        b=5TOPjZNY89MffNgsBh7CAIKE34hbpFa/UxkiMs4rV2xRcVY8I/3qttjxySeUCE17Bi
         bHwKGsI+ow/hVnMn6Vea3avMGw0FzHOqFtDxaPU9KCvuG2djRWFDLjiTN/4F3G3vHuVn
         eA/apZMsMSpBNBfLc7HKkO7bs5qfWKekQWnsYZ8MLUMuqU/7JrP0MmP06iXNklmhgtFI
         yKHm7cGYmHO6GNgzvxXsDiFrIwLZcvryJGZRwRU7veDcXOD/2kI5EXPQrFc87BChrzug
         1uciKV3N3V1odPqCo4xxVkzJQFcF3Hn3kZ8GAKWkAp1e1Uwt+cfoabq1hbMxR0FpXb72
         5asg==
X-Gm-Message-State: AOAM53188mMD1+wfail4eNEsDtniS3oJjgzE2+3H/V2ejMr5k35FkmkN
	1yy2/vBoNJ/IUfF1vTZXsQAPf3EmD8omPTza59I=
X-Google-Smtp-Source: 
 ABdhPJyiaaVEwQmtLZnybmbGFO2epERSfznInQzlbNQxJLC3ifUGU609cf9qHs8LPoLofG2rUpjuJw==
X-Received: by 2002:a17:902:b696:b0:13a:7871:55f5 with SMTP id
 c22-20020a170902b69600b0013a787155f5mr35326634pls.60.1634673994864;
        Tue, 19 Oct 2021 13:06:34 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/8] bitbake: fix regexp deprecation
 warnings
Date: Tue, 19 Oct 2021 10:06:11 -1000
Message-Id: 
 <f0c9f2edb175ef6f85704be3e94828293a7f314b.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12805

From: Alexander Kanavin <alex.kanavin@gmail.com>

See here for details:
https://docs.python.org/3/library/re.html

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 660e6ad4abb77c6f3c1d48bd64777dd76c05d7e2)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bblayers/query.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index fb6f550e..652a3acc 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -433,10 +433,10 @@ NOTE: .bbappend files can impact the dependencies.
                     line = fnfile.readline()
 
         # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
-        conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
-        inc_re = re.compile(".*\.inc$")
+        conf_re = re.compile(r".*/conf/machine/[^\/]*\.conf$")
+        inc_re = re.compile(r".*\.inc$")
         # The "inherit xxx" in .bbclass
-        bbclass_re = re.compile(".*\.bbclass$")
+        bbclass_re = re.compile(r".*\.bbclass$")
         for layerdir in self.bblayers:
             layername = self.get_layer_name(layerdir)
             for dirpath, dirnames, filenames in os.walk(layerdir):
-- 
2.25.1


