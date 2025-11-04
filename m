Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F070BCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 16:00:33 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21361.1762272026100510928
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 08:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=t8Z3CT7I;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so2892195e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 08:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762272024; x=1762876824; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TbuJGypBl5cFNd3C3f+nLVrBDFFxGTeCLs5paykV/vo=;
        b=t8Z3CT7IWJgsu63tcLQsa/X5UH0kehzpvOV9LrUR22RPheJJtV9cS+LiCfUw6ZSKOo
         BKoiBYm98qyBhI67idpIyHhxepj8d6EIZjisfhyjf9NXrF+aUUgyxc6D7CXfDbKhAx1h
         Y5UG4W11yQAu1g/72o+OB7LaXjZheOL60nkvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272024; x=1762876824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbuJGypBl5cFNd3C3f+nLVrBDFFxGTeCLs5paykV/vo=;
        b=KmpVMPG5TLpA/lTsYOGRuvoICOorpp9vLZ9rJaK+1+z73kH9hSa7WyxLwy/5F0MsM4
         FZhzJrtCkUsLqCW8jLQ1Rmu+mAsx0eT0Tq5P8VJMWAhyNKVEjOJsYDwc1kqsY2Sm7X8G
         2oBCEybs4A7n1jt5e8L7VYcncZlxE0WPwO2c8Ho1qv7IXpthhC/iofbMqt0ESvxl9Iw3
         sgb5AAlekr6MgAIoaX+A0UtZGlq5yLis76SICPsJXmlv5NFtx7D5G639E1P2QrIpJJpU
         37LnPRAVpH1vvmwsJ3AHIDbbK5XZdrxeY+FwM/cXIWaq5ce60r7GPe3MWsRl01ciIWnY
         Qzpg==
X-Gm-Message-State: AOJu0Yw8W6AXHSqKzv/keoXUQ8cz4Yx80SdqxNl1SIHlDiwBAHUM9x8c
	ATK4Q/W1dobA8OuUFtWoB9Yzhe30RiaJz/ajaGp8q1MtNgOgVjG+BmZ9WmS7g0jAavcAxf6jHK2
	2PFf/9wg=
X-Gm-Gg: ASbGnctB5OnFhAi5ORzRkziepTLLId3kXpM5I6nIqkMcoQwT6cr89vgGoNNeuxsEc8T
	NSpRcaAtuKJ5Z8cwZN4BDobmjL442/wpKPoc2Xk95MX4cvKNT+ekmm8DmEPMVMQwbJxEOdek+KQ
	q9BtmspX0EOn2vXKcTkAXFn7J6/dEIWRve6uEkdi6rEDbPQWLEmTqMqBICjCp36WVK1oyIq429g
	o6FnSMePBo5gL2R48WGt88yj5/MQzc8aiBQdO9dCMl5scsg9Vm1ZewxrmTrwyT//zKRIXuvqanX
	OU/IKkAemXOpGQfs73Kvbpy8Cd3TvUFeBBnW6V1P9Zh/7ZWpZRY7/lE8ofcUGvuHV+s00vInykK
	DwU0fvMyLCsQEQMHT7RsbsFCOWiPuLqwduzlu3ScdnvZ0Mc54E9ilB7IIXGDp8cLRMUni3Lxb0u
	kzKZoHOdzKsNoYhhwISHO6OXs7L9PBUO9ek2N8auRdjtBla2Xf3p75jJYuTk7RBt9xTQrLVijIb
	43RsOWOUg==
X-Google-Smtp-Source: AGHT+IFyW4iKkC9zMHFWEffFe6UD3qreKjrqR4NTuxDs+sFEwpkqHSSejcDEFR1WuOmF3YyJVyU+wQ==
X-Received: by 2002:a05:600c:4e52:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4773089e478mr159200795e9.23.1762272023885;
        Tue, 04 Nov 2025 08:00:23 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (2a02-8440-b50d-0f43-38d8-9244-c256-bef1.rev.sfr.net. [2a02:8440:b50d:f43:38d8:9244:c256:bef1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47756273df8sm38755825e9.10.2025.11.04.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:00:23 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2] bitbake-setup: make "path" optional
Date: Tue,  4 Nov 2025 16:59:57 +0100
Message-Id: <20251104155957.2345340-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 16:00:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18254

From: Yoann Congal <yoann.congal@smile.fr>

Layer names and path are often redundant. Allow users to omit the path
key when it is equal to the layer name by using the layer name as a
default value for its path.

For example, from poky-master.conf.json:
  "bitbake": {
    ...
    "path": "bitbake"
  },
  "openembedded-core": {
    ...
    "path": "openembedded-core"
  },
  "meta-yocto": {
    ...
    "path": "meta-yocto"
  },
  "yocto-docs": {
    ...
    "path": "yocto-docs"
  }

Remove redundant "path" keys from default-registry and tests.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
Note: Now that all "path" keys are removed (because they were all redundant),
we need to ensure the "path" code path is tested by adding a test for
it.

v1->v2:
* Also make "path" optional in are_layers_changed()
---
 bin/bitbake-setup                                    |  4 ++--
 .../configurations/oe-nodistro.conf.json             |  9 +++------
 .../configurations/poky-master.conf.json             | 12 ++++--------
 lib/bb/tests/setup.py                                |  3 +--
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3cd67805f..5a06394e8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -81,7 +81,7 @@ def checkout_layers(layers, layerdir, d):
     print("Fetching layer/tool repositories into {}".format(layerdir))
     for r_name in layers:
         r_data = layers[r_name]
-        repodir = r_data["path"]
+        repodir = r_data.get("path", r_name)
         repodirs.append(repodir)
 
         r_remote = r_data['git-remote']
@@ -489,7 +489,7 @@ def are_layers_changed(layers, layerdir, d):
     changed = False
     for r_name in layers:
         r_data = layers[r_name]
-        repodir = r_data["path"]
+        repodir = r_data.get("path", r_name)
 
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 7619738b1..9cd11a218 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -10,8 +10,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "bitbake"
+            }
         },
         "openembedded-core": {
             "git-remote": {
@@ -22,8 +21,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "openembedded-core"
+            }
         },
         "yocto-docs": {
             "git-remote": {
@@ -34,8 +32,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "yocto-docs"
+            }
         }
     },
     "bitbake-setup": {
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 60531ba02..9b63ea5f0 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -10,8 +10,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "bitbake"
+            }
         },
         "openembedded-core": {
             "git-remote": {
@@ -22,8 +21,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "openembedded-core"
+            }
         },
         "meta-yocto": {
             "git-remote": {
@@ -34,8 +32,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "meta-yocto"
+            }
         },
         "yocto-docs": {
             "git-remote": {
@@ -46,8 +43,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "yocto-docs"
+            }
         }
     },
     "bitbake-setup": {
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index a17b8ac46..933470f78 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -100,8 +100,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 },
                 "branch": "%s",
                 "rev": "%s"
-            },
-            "path": "test-repo"
+            }
         }
     },
     "description": "Test configuration",

