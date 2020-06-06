Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.3631.1591413353206029125
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bBizQV2m;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id p20so12530063iop.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfedIP0gZnnWqdQYsEMcBKru3i1ZTIHdA0ZDtf7XFoY=;
        b=bBizQV2m2/7NZPPYgrx5WWkQx7nGAcGTNh9ZEeAQhdwnTQmlT+4XDPll4U72AitmVt
         aSNuooO1/1BRUrmCmJUANDy31WoUcI8mvAPHN5NJmhFUqvGTayNZu433mNPwNZJaLaP6
         OnOsjk2Ja4nF5QNd36S6AB4E3ZUScOh1uvdkhw8rG3A5hCzEW1sadlV+dks0eeK5xxpB
         fQ28X1U7qDjr3Y8c859eswfzXiXNRN/5Nu4KeMxo4qsHOEoJ/RBuYoo5GGxYDnT0vrv4
         /o+yejgOgQasG8X49lT/7CesIvWzy9S9MZaxQ5tLRm0Io6wXg8puIo34MnEkSuimDfOl
         vUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfedIP0gZnnWqdQYsEMcBKru3i1ZTIHdA0ZDtf7XFoY=;
        b=L8Fy/5zx5FFZc3J1zbqMwVbLYufzCZItrQfCm/XupEyXGTjKpsk16NVvdENLVKTwiT
         2r5ji77qdD7Vhh/FWCACWHyirfJjDa5YMQ5dXdO2+Tgk5rBiqH9VkHrC+Xs4CD0Bqx7g
         GwgwZqUxg+JL/rgfBhz/lFxNLCpEj3IjvU0XktfWL36VTZjiyil22fmcDNA9r6rUJsD1
         bqjZFPBe82kkcvSe3eDjFV0G/sXiW8DbymNYLn/Vd3z4d0qObqMOy+dZ9JCGEI8q3Apo
         BahB47eqwlKpeS1wGdZC24XZGtCxODZhvZk0avh2TsoOs2JnPZaiPY241vWll3WfD6rR
         O3Tw==
X-Gm-Message-State: AOAM532LKV0aaYgasXjTk9KbIx7d7ovVnwz9fumH0+aYSYXRO2uMXNSj
	dS8oj8aPiJpiuI/IE11QL6m1kFBM2io=
X-Google-Smtp-Source: ABdhPJzGPZdRGRxSVcrCgpiWBquFMawelKTK5Pm3sogivTSTe81FS1QmqkpvQ/Ets7rHIYiVGv3I5w==
X-Received: by 2002:a5d:8613:: with SMTP id f19mr11429643iol.173.1591413352465;
        Fri, 05 Jun 2020 20:15:52 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:51 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 4/8] bitbake: lib: Add PrefixLoggerAdapter helper
Date: Fri,  5 Jun 2020 22:15:32 -0500
Message-Id: <20200606031536.15956-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
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

