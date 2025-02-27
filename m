Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FEC19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 22:34:44 +0000 (UTC)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web11.2933.1740695678477476326
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 14:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IAzTKVNy;
 spf=pass (domain: gmail.com, ip: 209.85.160.195, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-474bc1aaf52so2352261cf.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695677; x=1741300477; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnKYtbATbfOAcgvhozhf7UzGzfPqLOzCG7ZYBHEEETE=;
        b=IAzTKVNyjoOvdrc4dBfjRgzyill+CpmEwTQmx71YG2rU9jz49aSLDGpDmn5SokMLm2
         snlKDBV8I6Pr/Jg9iudLfuhAACpY22gwLt1zMp5T29YFfPvhg/89YzaXNKjN4/WWpfYS
         CfhUefovB/ZsekZNPl8lTpmGWKlkAVofxrn1LlwcRcQAjcSGaMDLVpvIpbbfefVNOzRC
         1R7koLjvmwDJbPIvWu0LaPGcF4aJwDtMtDYEYyDTAjbquX1NG3Z9QXRdJWGarzt5dKW6
         q6DsB7F4vLKgm0jcmRUQRQ/v3RdYKxRDj4234Kw+BY0ParHMa60JFXOPSV696RfyyIju
         pqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695677; x=1741300477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnKYtbATbfOAcgvhozhf7UzGzfPqLOzCG7ZYBHEEETE=;
        b=tNlshvlIbYcklWQRGiBnq21SE9Bp8Y2JkoJccGaCanHWMkY4VTOPFIUuZjiLEtyUuD
         nTpVmzbuvWmszdJjd3ScDSVE9gyU6jxQ+YrH4UMu07UNHO+BmoXvcA+rzVqEIJws5SnF
         6+S+ViOMGp4P+iz7e9L6ScY6gX3ppgtfddv/07PJgLZ3SAUcxdqlRP6x0DJAl2keOBDQ
         n27PCUkb3xiIz8WQJ+bmJ9qO+si54RshHxKp3QfoO2QNrjzXYXa6bzSZ5R7bI6QLJezx
         YlUl0dLU5UFX662Yk0YGpUSlu+AXDwyIwS8RbxGuVf4B8gdBk1uiuESyhT9XhYYOiDCm
         hslg==
X-Gm-Message-State: AOJu0Yzcqby9r8a1hhhR7VkhjAGDN4l/W9ufno9QF8rU+jB9UAocEK9N
	S4JIsXHvYhIaSYkWqpNfZEjM/PSVbBVI6iWU/CCpgKweFHNp96ZyKgecFId9
X-Gm-Gg: ASbGncvAjM5bZj8iMdBlg/LE61h7gK/HFj9vXvYd+K7D1h/v8gvQ+vitJ5OVnX8/3ib
	XiRB1UsijITm3SeH4m1rnqNBhVHnIs8rzvpzphM7cz4cd3nHzfdXkcBL4uYKuEV7j7c5StUnd4d
	AC9Oh1cS8XBnyCa/FCtNRniiQS1mKnSB+jdqxdqDO0owlT+DPNG4B0vBThk+Ad0DhPkjEbKU866
	Ejf/LCUmRNr4YlZVWYyYUHVte+LhutbypbBn7Hyu0GhvxX9YhEmmd7JPDMgMtpRiXdfMkM6k99F
	MLs0Qp+uQtRto61noHKs+5ym0gsH1QaHIKgez0kt9mYBgSo4MVrl3x5M5cWfjPNylLAWtWyS+Bo
	6R5YE2ZHPS3byEPZ+UdwD
X-Google-Smtp-Source: AGHT+IHvldsPERCGiYYa7JACsIK1VdsSdozJDazrR6wP9A9VJmLxfEMzCveyAR1+Pwpvst2WjPRUyw==
X-Received: by 2002:a05:622a:1a19:b0:471:837f:d5bf with SMTP id d75a77b69052e-474bc0885f8mr11087601cf.12.1740695677312;
        Thu, 27 Feb 2025 14:34:37 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721c0a64sm16763341cf.42.2025.02.27.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:34:37 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: [PATCH v4 1/2] fetch2/npm: Adding npmrc support for private registry authentication
Date: Thu, 27 Feb 2025 16:34:35 -0600
Message-Id: <20250227223436.28224-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227223436.28224-1-eric.meyers@arthrex.com>
References: <20250227223436.28224-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 22:34:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17353

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
---
 lib/bb/fetch2/npm.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index c09f05044..2c7ed5340 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -91,6 +91,12 @@ class NpmEnvironment(object):
         self.d = d
 
         self.user_config = tempfile.NamedTemporaryFile(mode="w", buffering=1)
+
+        hn = self._home_npmrc(d)
+        if hn is not None:
+            with open(hn, 'r') as hnf:
+                self.user_config.write(hnf.read())
+
         for key, value in configs:
             self.user_config.write("%s=%s\n" % (key, value))
 
@@ -103,6 +109,21 @@ class NpmEnvironment(object):
         if self.user_config:
             self.user_config.close()
 
+    def _home_npmrc(self, d):
+        """Function to return user's HOME .npmrc file (or None if it doesn't exist)"""
+        home_npmrc_file = None
+        if d.getVar("BB_USE_HOME_NPMRC") == "1":
+            home_npmrc_file = os.path.join(os.environ.get("HOME"), ".npmrc")
+            if not os.path.exists(home_npmrc_file):
+                home_npmrc_file = None
+                bb.warn("BB_USE_HOME_NPMRC flag is set, but NO valid .npmrc was detected - "\
+                        "check that a valid .npmrc file exists in your HOME directory.")
+            else:
+                bb.warn("BB_USE_HOME_NPMRC flag is set and valid .npmrc detected - "\
+                        "npm fetcher will now use the .npmrc file in the HOME directory.")
+
+        return home_npmrc_file
+
     def run(self, cmd, args=None, configs=None, workdir=None):
         """Run npm command in a controlled environment"""
         with tempfile.TemporaryDirectory() as tmpdir:

