Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.12673.1606840022369392994
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:27:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JyduEQR7;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: ernstp@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 142so3871667ljj.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGEmpeIy5EBbhmG2/+wy0mSiMkwHjFUTVHgrecPWM5I=;
        b=JyduEQR7JDFGXK+iEbhip4ju4tS6CtP/N/BIl8lvaATeYGeknf/3nJQD3rM5t6w6XZ
         aiHYXhFrCKM2LJoJXDfIVCB3TuDIyHJ9Jr2JfwU9qwmSa7DllNqU7UlA3RComNxgBLMu
         V4ZXcY+Paxn9HwWL/hmzuZh87etlV2tK0+zKDaBoBwFqpxJ1yRIIDF2BculJsOV5+fCu
         zJnOcvkv61cqYvkDokkX6qa76RVv0R32YYdPHp8AHUZMN3r0ZNrx2wCcEzsBl/zI1hQY
         FC9mR7IPIc5Z/FeQEPsowjl8e+iFidmDwycf3pelfceayfVikwOhZTmWm47LdrZo1QT6
         QdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGEmpeIy5EBbhmG2/+wy0mSiMkwHjFUTVHgrecPWM5I=;
        b=EdwAffsZ3NTT7269HF/Gb/IXgJFkean/WQItT3UPClOsMggANkgkUEIDovVTGvIgU0
         IwPffTI9+RX2s0527Yju306wbEVcfjEv3gY/5hhdKpF5QDpmYrYdEQ9HExLJUS2kC2V1
         zDNyzvrogGy+t3ZICdVkiIkGxZH9+PP2e7JWLndeUUZSjMfKEM7oHUDyLqU5zONfw7u3
         ulq5M//P4tuB83x3CR0gbVfnm6gYfUjgjkwyi4LVJDaSmU4mwbt0gWRqN87vJ+wwdlpG
         rAC+NlhCBOAtgAFuRksowuMF5xrK/qTYKD8DBaQtOvlzG+iUL0QKy8PcPxyQpKu5iSfr
         W4iw==
X-Gm-Message-State: AOAM531b9JgjaVYIpnruKYuSciLhL4NqCUvIe58DL4anAu8Fs+0qxQHt
	RZiDXk5cLlenpAugy1r6fISUgsQekh8=
X-Google-Smtp-Source: ABdhPJxqMae2LhVz9CAEStB+mNGDPSAJxOM63uAIvV10nib4IXyV8/yxsi+3eUtMQXhgrEIrxfJ+iw==
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr1741025ljk.102.1606840020299;
        Tue, 01 Dec 2020 08:27:00 -0800 (PST)
Return-Path: <ernstp@gmail.com>
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se. [83.254.138.119])
        by smtp.gmail.com with ESMTPSA id j131sm248746lfd.209.2020.12.01.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:26:59 -0800 (PST)
From: ernstp@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell 1/5] python3: split python target configuration into own class
Date: Tue,  1 Dec 2020 17:26:23 +0100
Message-Id: <20201201162627.47760-1-ernstp@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was
problematic as it was leaking into host python environment, which
was causing tracebacks depending on host distro and action
(typically anything involving importing sysconfig module).

The new class sets the variable only in specific tasks where it is needed,
and should be inherited explicitly:
- use python3native to run scripts with native python
- use python3targetconfig to run scripts with native python
if those scripts need to access target config data (such
as correct installation directories). This also adds a dependency
on target python, so should be used carefully to avoid lengthening builds.

(From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)
---
 meta/classes/python3native.bbclass       |  2 --
 meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 meta/classes/python3targetconfig.bbclass

diff --git a/meta/classes/python3native.bbclass b/meta/classes/python3native.bbclass
index d98fb4c758..2e3a88c126 100644
--- a/meta/classes/python3native.bbclass
+++ b/meta/classes/python3native.bbclass
@@ -17,8 +17,6 @@ export STAGING_LIBDIR
 export PYTHON_LIBRARY="${STAGING_LIBDIR}/lib${PYTHON_DIR}${PYTHON_ABI}.so"
 export PYTHON_INCLUDE_DIR="${STAGING_INCDIR}/${PYTHON_DIR}${PYTHON_ABI}"
 
-export _PYTHON_SYSCONFIGDATA_NAME="_sysconfigdata"
-
 # suppress host user's site-packages dirs.
 export PYTHONNOUSERSITE = "1"
 
diff --git a/meta/classes/python3targetconfig.bbclass b/meta/classes/python3targetconfig.bbclass
new file mode 100644
index 0000000000..640d0c97b6
--- /dev/null
+++ b/meta/classes/python3targetconfig.bbclass
@@ -0,0 +1,15 @@
+inherit python3native
+
+DEPENDS_append = " python3"
+
+do_configure_prepend() {
+        export _PYTHON_SYSCONFIGDATA_NAME="_sysconfigdata"
+}
+
+do_compile_prepend() {
+        export _PYTHON_SYSCONFIGDATA_NAME="_sysconfigdata"
+}
+
+do_install_prepend() {
+        export _PYTHON_SYSCONFIGDATA_NAME="_sysconfigdata"
+}
-- 
2.29.2

