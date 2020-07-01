Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
 by mx.groups.io with SMTP id smtpd.web12.1108.1593620868204986147
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jul 2020 09:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=aMCVLW4n;
 spf=pass (domain: gmail.com, ip: 209.85.160.196, mailfrom: dakhouya@gmail.com)
Received: by mail-qt1-f196.google.com with SMTP id g13so18877575qtv.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2020 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjK/OUlkiPS4lObpmLmTqI+AsJSL4M6/wBAIALS90nQ=;
        b=aMCVLW4nnuDuvsx8VsWXdaacurws7VDj1r6zhjOf/bcjY+U1iIQymPAkNGPnJZBKFX
         uqozZvZ1yVn+mlgdjyRsCR/W0HXH8JiDE9n5ZfNwNIv+IcOU2vGjCSHI3hatDMjiCkN0
         zflJyyT7uMGmBQ1FKWPcKYbqxaZkQpwsRG2XYCPAX4lEEWyYQHwpDkJosj0KJJy1qDur
         lwXsI/ULRQEejwkWmMHXFVS7qHUz3bBwdORmXjekn9hOzEjefl1Cbun3M3FYbxh/jxGO
         rESGdgxVKGIdRmnsCn1U2Yxii60oGFjkDDoJoYIpaPlQKDW3tCSvTX+scT4ENqXW7dml
         VXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjK/OUlkiPS4lObpmLmTqI+AsJSL4M6/wBAIALS90nQ=;
        b=PyLp9vo6rkcIB+t3ZcZvAWtCHWzL/r4BUy/Rbvd3NBVcpXb5Bh6OCCvQ2XizSTpCPz
         VpS1A7QGRi8yYAWt0ahNCxLe9Uq170V7fyPqFIHXixZ/aLe+1HJ2FeIzPSD0XlPaXiaF
         r8cUD02a+YgeF7u7cEyi2suVGeIeROKbMiiJ+/FI2aS7xr8yhNx7f+Klw2l4OsrmDj3i
         DOxCcUHcNa+Ie+rdYPZQ6EggGcwrGUcroFZa2IOXA5zbYrzbwr4PkOyFV4ZepQvsbRYz
         Fm2nvZ8kLiA6O/o8cmTEgvKJNzqxmflYaAHsR7T2AliQ3wnxq+Xn1PPSgYecNoE8Ssj9
         UdTw==
X-Gm-Message-State: AOAM533h99PT2C3Gl6gsd87oeHoi/QMEcJUM1HtKrSpg7zIQsS7kc7ip
	D0Zu8XC9KNoA2qyzYDO32THFRjoZ3fw=
X-Google-Smtp-Source: ABdhPJxeeeIT+vjqVEuwFE2tEjiERSiKlIAU3En+1TxZpfiIoFX6U/XPcE0fqgY5yEURKKuJ85hFaQ==
X-Received: by 2002:ac8:4e8d:: with SMTP id 13mr27217144qtp.169.1593620866829;
        Wed, 01 Jul 2020 09:27:46 -0700 (PDT)
Return-Path: <dakhouya@gmail.com>
Received: from dkhouya-ThinkPad-P53s.effenco.com (modemcable219.197-59-74.mc.videotron.ca. [74.59.197.219])
        by smtp.gmail.com with ESMTPSA id c7sm6065142qtp.19.2020.07.01.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:27:46 -0700 (PDT)
From: "David Khouya" <dakhouya@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: David Khouya <dakhouya@gmail.com>
Subject: [bitbake][PATCH] lib/ui/taskexp: Validate gi import
Date: Wed,  1 Jul 2020 12:27:40 -0400
Message-Id: <20200701162740.258157-1-dakhouya@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running bitbake -g -u taskexp without having gi python module or
and invalid gtk version, bitbake fails with a stack trace.

In case of import or version error, bitbake should exit with an error
message instead of a stack trace.

Signed-off-by: David Khouya <dakhouya@gmail.com>
---
 lib/bb/ui/taskexp.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 8fff2442..336d197d 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -8,9 +8,15 @@
 #
 
 import sys
-import gi
-gi.require_version('Gtk', '3.0')
-from gi.repository import Gtk, Gdk, GObject
+
+try:
+    import gi
+    gi.require_version('Gtk', '3.0')
+except ValueError:
+    sys.exit("FATAL: Gtk version needs to be 3.0")
+except ImportError:
+    sys.exit("FATAL: Gtk ui could not load the required gi python module")
+
 import threading
 from xmlrpc import client
 import bb
-- 
2.25.1

