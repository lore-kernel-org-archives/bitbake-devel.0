Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
 by mx.groups.io with SMTP id smtpd.web11.1871.1592375376503315317
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2020 23:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bNYYx8cI;
 spf=pass (domain: gmail.com, ip: 209.85.208.193, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f193.google.com with SMTP id 9so1435031ljv.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2020 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVSS/MTdRQhTdOjMgNbzY8pxeY3p8WDPaXWJisCKfvY=;
        b=bNYYx8cIuY8wDKZ/UnRG0jDp9GDkc4PQsFHsF6ExueMyWa5mQLyUhhavtPPLlkfK1J
         /5SG68MqYKR2yf2b0tg7W4LqgBQzZjHXvN2NLW7xy7e/L01q8X2VnTJpZHp2nOVZtLb4
         ffirGUTtrUWXkCMmnzpMbD/v9tu58UOOmdvQqBFoVBI+Hly7ZCKme+sbf/+nI9d8/aPa
         iq+jRggnnjHDs2MftH1VEeUSrOwE3e66AExyum5Nw86OvZvOKBLgMxbC8Cw6SmVFHGZe
         tbOoRja91DEz65wCvMHGTy5u6ptLyTUrCrcJ7nOiYiGqBX2AKTAL5KJWmiBszggwYb+b
         7DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVSS/MTdRQhTdOjMgNbzY8pxeY3p8WDPaXWJisCKfvY=;
        b=U5FFw7GbfIrkdj8Jvgu5GBdYc2aEL1MqaSxFmFoMtKVQO/Ih+sWsi+tKN2aBP1MeBt
         bfGDxBriS5nvonKYFLesUu6+wwVySO3JHAqE80GIzHL3prEXTnnvjypl94VqZ3YT0la9
         KBlKXvtKd689HSY7zd7k8J46DvJAzyVy6PajcrmHt5WC3/0TJK+QlR3VKyv+D/Mbm8C/
         4l7PkECaikkNqOPEkMlVcyKk7mz/aX1A2yMHD0sK2iJQxGVsJPu+g4OhJhnGSOilp6C8
         e9vmN+nwfQG5uns2gxtRHaOqtNj0C0wLa94nCsqXPGnCoX4AfRa5ZMOtzJlU19YYjx7y
         DcAQ==
X-Gm-Message-State: AOAM5339V+gLB4ZbZOey6zPh8klMNDAmBhYteGlip7YEQi2W4sOp3XJd
	QR9n7pMys+825wjfDfLJgn3PQmPn
X-Google-Smtp-Source: ABdhPJz0kETdVi2qal4iZTuPNCm7vn0fSoKgw7hj0hbAJlcncQGBhOvU40DXk4+h6Nk60OrQa2jDmA==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr3369429ljd.309.1592375374533;
        Tue, 16 Jun 2020 23:29:34 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id k11sm4817220lji.4.2020.06.16.23.29.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:29:33 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-user-manual: Remove TERM from BB_HASHBASE_WHITELIST example
Date: Wed, 17 Jun 2020 08:29:22 +0200
Message-Id: <20200617062922.251379-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TERM is no longer included in OE-Core's default
BB_HASHBASE_WHITELIST, so remove it.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index e4251dff..04c5a26b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -765,7 +765,7 @@
             the concept:
             <literallayout class='monospaced'>
      BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH DL_DIR \
-         SSTATE_DIR THISDIR FILESEXTRAPATHS FILE_DIRNAME HOME LOGNAME SHELL TERM \
+         SSTATE_DIR THISDIR FILESEXTRAPATHS FILE_DIRNAME HOME LOGNAME SHELL \
          USER FILESPATH STAGING_DIR_HOST STAGING_DIR_TARGET COREBASE PRSERV_HOST \
          PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN PARALLEL_MAKE \
          CCACHE_DIR EXTERNAL_TOOLCHAIN CCACHE CCACHE_DISABLE LICENSE_PATH SDKPKGSUFFIX"
