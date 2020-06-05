Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.2227.1591322017401714745
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=RUuhJs2q;
 spf=pass (domain: gmail.com, ip: 209.85.215.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id t7so4411589pgt.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfedIP0gZnnWqdQYsEMcBKru3i1ZTIHdA0ZDtf7XFoY=;
        b=RUuhJs2qF8J3PRC3e3YHtko/CRnK1HTy0CcGs28BZ4546iJW2VEAI0Zn3g0E3owL3o
         0ReePby8V+00W6dzOzQY95co6ntbkAOE4rp3UydpaYKm8Vxgy/piGV9O773Jeb4qhetO
         RGygOLIEGhgJ6t0fqv7BrTXZ3o6vw//TWcHm1s36N3JWbxUjYXr/Mags2ZH3Tk7WtLtz
         kSanXrPCl3k1vAZziori0c4TXe2/cB2adNuUbQkC09xMMltQnktoFxvFxRaKia6ltq3Q
         ZPz7xD8+DKxr4TPpi/wUmUcqbERDub+FtWV9BkRQvFIqLbWuLbguLyjpX8+tfdqpOH1T
         +jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfedIP0gZnnWqdQYsEMcBKru3i1ZTIHdA0ZDtf7XFoY=;
        b=dKQf8kU14OjQMs3JdeYSLexdzabJpHScVlhmbgZsaUyvSjrQdN258Zc6nJmczUPNt/
         9eQylJxgYmymz9VEAi1RRuMs9EOOYHWOmwHLRBx12eCXmU8D12RB9IokEwuqAyO+GePO
         GYRZzp5p/Mjv2MpaDHkSzvmtZH6VFMZN+XdXcN2Rgp92xerCO53VbtI57jQDzyKaGq2/
         mpWFYqo0b0FmgqEqbbRNhKdDfvYrQdJJaRtyws2yDVvL8h6tncDa0kKkH7KOcNWydcxI
         w4hLs0PWt54NA5IEiMMU2Q0ejmm9e7qFVb8Q6dlmkmY480nUt+c1Owvs6valeChxlTb7
         kXRw==
X-Gm-Message-State: AOAM532Pl4iGKwrNf69U11mjUNA8enWrcaIe5sgJDrtXZzRfNeXOzgsi
	DQU7FJU5et00IHR15/hH3qAHh779r9Q=
X-Google-Smtp-Source: ABdhPJwzC26iGOGCk++K7wDlkZxzasVo0T9gVtegkjj1+2XAPcr3otF/sfWRCtWfWgcaUnyy2YzwVg==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr7354960pfu.121.1591322016718;
        Thu, 04 Jun 2020 18:53:36 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:36 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 4/8] bitbake: lib: Add PrefixLoggerAdapter helper
Date: Thu,  4 Jun 2020 20:53:21 -0500
Message-Id: <20200605015325.35395-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a helper logger adapter to add a prefix to all log messages. This
is useful to distinguish log messages between multiple instances of a
object.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index cd53603a47..4e2f97b234 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -104,6 +104,14 @@ logger.setLevel(logging.DEBUG - 2)
 
 mainlogger = logging.getLogger("BitBake.Main")
 
+class PrefixLoggerAdapter(logging.LoggerAdapter):
+    def __init__(self, prefix, logger):
+        super().__init__(logger, {})
+        self.__msg_prefix = prefix
+
+    def process(self, msg, kwargs):
+        return "%s%s" %(self.__msg_prefix, msg), kwargs
+
 # This has to be imported after the setLoggerClass, as the import of bb.msg
 # can result in construction of the various loggers.
 import bb.msg
-- 
2.26.2

