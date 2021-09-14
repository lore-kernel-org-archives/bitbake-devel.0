Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.8635.1631619668444596972
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Sep 2021 04:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dqj9dwXJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id u15so13627709wru.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Sep 2021 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0a9S2mA8Q7C/4Oqxeb7a6SmKmo+EU0gHbBFZxDEoh0=;
        b=dqj9dwXJNlBGGnqWsxrfTcAaMcOFlVPn1VeLJdEp+TrbdajwwqIb41d0GNYp45riu8
         HLnZbnnXYNp0usFdb/4SJUhkGkKnSxYd1EM0iGSlUrBTOugZsn3P8zCkwknSkrQZrTnJ
         Ak0WVwFdFhRvx1ScN+0KSsaQ+4zPvuYLKxxbiyxFQ6JBYL2bky0fQg2W4wgR7/TTOqe3
         LsfSLoVmwlzyvaSMX/XNGUScypJ3H0Us+tNx5l2PsmqxtqOqT3ehgEmQA2KnIcm6MwG0
         7/TdCbzQ6qHknREwuQAubUbsuKtRk93XrzlO4x8VR6IvdV3DZCl3DgfzDmFW+5DEOBN2
         8Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r0a9S2mA8Q7C/4Oqxeb7a6SmKmo+EU0gHbBFZxDEoh0=;
        b=fUk9QX1GtZjnK8yY+EIQSRJxyzFEDCUogYsPm5eK5jBxlPlutBx1KrUG7uGN5iQOpN
         DCtqnuB817rLlY/L9a4zKvXGvLuixdAuW2ekJZGoiOp9FXdXKWKxrhV2j9oL+P4t2R9y
         l1V5V+ksRNPTpk9OTtC/m68sCfRgGe8/4Wo2XbPgRuhtHjMMwfWb0CMXZw7/Id0CK4IM
         UrwdQz+KH3ALFuPG9dbZUJByNFSgUilFb9UL7hbrI/giKkbpEQSAsUVJkAItwhLchQTt
         qlplJDBxbBT9ZbGMVEK/S7bIcQVpmLu82EwjaGR661ztTbU4riSB8Bk8FC0d5tcZZDhh
         GXjg==
X-Gm-Message-State: AOAM532nKunwQC69ymrl7vW+pHiIj7ZqgZA5qGkBGhAkMfQn3Ww/1mjl
	Ua03CtRZZeIzC+AO7eCxbWxiAO1gDMA=
X-Google-Smtp-Source: ABdhPJxLV8wJSdPMYtWxqOlybNQnQuBpU548OQbF+6+Yebbur+Z73jSXihj50afKQWyTA4yCNT+R/g==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr18521918wrv.112.1631619666907;
        Tue, 14 Sep 2021 04:41:06 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a3sm10046107wrt.28.2021.09.14.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 04:41:06 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] bitbake.conf: fix vars_from_file() call
Date: Tue, 14 Sep 2021 13:41:03 +0200
Message-Id: <20210914114103.15591-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference to this function was dropped from BBHandler.py in:
https://git.openembedded.org/bitbake/commit/?id=aaa5292ef96ea27f505bc5c5a4b1eb4f497ed061

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 conf/bitbake.conf                                         | 6 +++---
 doc/bitbake-user-manual/bitbake-user-manual-execution.rst | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-hello.rst     | 2 +-
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index b3d5fab2..baf0a76f 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -31,10 +31,10 @@ OVERRIDES = "local:${MACHINE}:${TARGET_OS}:${TARGET_ARCH}"
 P = "${PN}-${PV}"
 PERSISTENT_DIR = "${TMPDIR}/cache"
 PF = "${PN}-${PV}-${PR}"
-PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
-PR = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[2] or 'r0'}"
+PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+PR = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[2] or 'r0'}"
 PROVIDES = ""
-PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
+PV = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
 S = "${WORKDIR}/${P}"
 SRC_URI = "file://${FILE}"
 STAMP = "${TMPDIR}/stamps/${PF}"
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 6153f36a..a4b1efbe 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -208,8 +208,8 @@ metadata. For example, in ``bitbake.conf`` the recipe name and version
 are used to set the variables :term:`PN` and
 :term:`PV`::
 
-   PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
-   PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
+   PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+   PV = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
 
 In this example, a recipe called "something_1.2.3.bb" would set
 :term:`PN` to "something" and :term:`PV` to "1.2.3".
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index c5a4ce60..83a415d9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -216,7 +216,7 @@ Following is the complete "Hello World" example.
     use some editor to create the ``bitbake.conf`` so that it contains
     the following::
 
-       PN  = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+       PN  = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
 
        TMPDIR  = "${TOPDIR}/tmp"
        CACHE   = "${TMPDIR}/cache"
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ff60381f..119720d5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -413,8 +413,8 @@ variables from BitBake's internal data dictionary, ``d``. The following
 lines select the values of a package name and its version number,
 respectively::
 
-   PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
-   PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
+   PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
+   PV = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
 
 .. note::
 
-- 
2.32.0

