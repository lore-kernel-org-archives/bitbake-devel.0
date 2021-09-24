Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.8874.1632493364891180718
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=IRdmUv6w;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id w14so9043888pfu.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3BcnRJlqbdPKSI4/ZU1BCX2RqLpwBcSS0Pw2BHn4KEQ=;
        b=IRdmUv6wXG/M2aStZZbp5t91f09aDIN96z8hHl/RSDH5C5YHsKD4c1N4DbfY4fg+2i
         JHaEhpLykSw87+BNaxHD9dc0aLIbgpYn8Hs5eznF8uf8O6fuMdpWPNCe9O9P3ApN7i1J
         X4FBeE1PBruox1KBXplvoenhDTMmbSy4In++3eAmnpJUOwEzWe9UIaLf3HRsrO8RApHt
         /7/A1FYA+sLZ9y3CyuEx1/CZ1eigsGWwEA/RNuBDR1EMJaOZOuBE8PZprYjrZxF7dYmI
         hl1oLW5amDWD/a+DKgCyukiYrnXifoJip4DO9C4GJ4ulVOjsKVDyV2mmbLHY2wbgb6ee
         6jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BcnRJlqbdPKSI4/ZU1BCX2RqLpwBcSS0Pw2BHn4KEQ=;
        b=aFd4+lLwH9gpjXsKzZu7qJLIB46VCavorLyrGIjegMeCB5gjg9nz9GPhFJGjqITBeI
         dGffTZeFNR3UwD1kPHGNzd+tNJFWu49Tby6hgqNKg1HtMmFVd3wgBTLZxefHQnPiUOQ0
         HVQSsgKEnJTz/tmqj7NmLvSWehmV+o0o8fWMOMETCR9fqq+QBWVJKN4qjFTvk3S5/UYY
         x0J2cH09ToJvxgN1wGT8dNpqqDzcrl770YCWURYPmiItbyV5rYFxWUtLgjUvOoUgallo
         KLzo/siVtWXiX/8MVktgQq7uOEctYQhh9DtNypFHkHFrd84Nhm3R7lqqK/E1nnTwCeZy
         cOqg==
X-Gm-Message-State: AOAM533otSvuJ3N9ATwPqeqAnNVbUTF7MZVCRqPSmzxJGhdUKLxE/jeS
	+dCF212IjkL2j5TgvkuRD6CWQklSyDQZ/AtWmEg=
X-Google-Smtp-Source: ABdhPJyLZ0k9hpDJ4eYKfJc/cEnhsnWFOi3zqP53wbcsHBePS6j8yDZdh2rBs9hlNMzx9YsmT6K0XQ==
X-Received: by 2002:a63:7d01:: with SMTP id y1mr4016659pgc.343.1632493363968;
        Fri, 24 Sep 2021 07:22:43 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:43 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 14/14] cookerdata: Show a readable error for invalid multiconfig name
Date: Fri, 24 Sep 2021 04:21:07 -1000
Message-Id: <52a9dfa54e2b1bdad9a0b94946c89f619a0323f8.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If a multiconfig starts with a digit, users would see pages of
errors as we use the multiconfig as a python function name prefix
and python functions cannot start with a digit. We could avoid doing
that but it is easier just to ask users to name multiconfigs not
starting with digits.

This tweak ensures the user sees an easier to understand error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f9cddaeef35b2ea0dadf717101ed896f6b857abd)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 26b9b0b4..32a8798f 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -297,6 +297,8 @@ class CookerDataBuilder(object):
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
+                if config[0].isdigit():
+                    bb.fatal("Multiconfig name '%s' is invalid as multiconfigs cannot start with a digit" % config)
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
-- 
2.25.1

