Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44728C021B0
	for <webhook@archiver.kernel.org>; Sat, 14 Sep 2024 20:14:30 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.102597.1726344863216090544
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Sep 2024 13:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EGpB+wI5;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so382744666b.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Sep 2024 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726344861; x=1726949661; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmez/S0K+oxaAE7xbt01oJxLGM4kqYQa+LT2xWSAy84=;
        b=EGpB+wI5dSKPE6Ejj9jTm3NMuB8Nhg6VtXNcGLd0FgjrtrE0/fCPEtIhbTmiqaTlOo
         3zBkBmm9FI/UgOIlSL4L4OOvS8T94JUCE7pA+g7DQLuHlxTpoVGejWkfQTzjbQNz6Fqe
         EYHZeJgHd+Ao+MkqE/7zKur3O+TRSeNLP9iABAh+vWxZkn7DXzHfKJQLIE67kxw40JM4
         K9Xo2CD5ZtmrK0fB2lqziJC1udHCjnxDW8J+u2XOUred56WZsLI8Ztr24CkH+F+eAoYm
         hCoNSXJ9fgNpP98DXkXc6Cf132hG/7Sx0DaXc9nCTZmxhHp17K+vrpMX9WJGqrtkaGim
         1Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726344861; x=1726949661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmez/S0K+oxaAE7xbt01oJxLGM4kqYQa+LT2xWSAy84=;
        b=o/t6VLG99mvKFtV8lbqJeF6vSiEIBhh38U7WiG133BusVDqoXjVizQilmTm+rNm2bw
         BpNNJKm6tivgEeC5niaAv9O7hW3tfQ1at2UYf8dn8mVtlt6dwDjZlF/iNHgD168DLp6A
         94ahMtmq5B20kVNqXWd+7INpu5SS0lWSTBOKJq+LqxxjjDnCcOJiI9iYjq2Mnfbz9Ph0
         wzF2NN8H9k9aO8JMilUyEzrMAAgwK+TgyJAPOM7LsLITL2jTjwirJDb2aozZZmZbQrgu
         zMDUIDU4tMAE94Dl3S+er+DIRYIpfTVRRk4O6wht8iHupSuhNbwlSaAjf+Y0Pm+ecGLZ
         UlUA==
X-Gm-Message-State: AOJu0Yym1jSZWdC+zjWwSewlGI+TwK1lgjLrHvldbEBY7iOzCuMAcCyI
	tPsOV+XQHxcfXV6PSDyMYpMCN/HqIadUIbFKLJbLse8Zr80etOCM2m3ngQ==
X-Google-Smtp-Source: AGHT+IGOHbm3/s4z9BUlNtTpGpcJpxyhilHEGBE5Z54Ve5kJ5N8U6zjzJFIjxQNhJhCok1UtkEw5cA==
X-Received: by 2002:a17:907:6d25:b0:a8d:6910:d0dc with SMTP id a640c23a62f3a-a9029667178mr1043957766b.53.1726344860581;
        Sat, 14 Sep 2024 13:14:20 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331912sm115056266b.224.2024.09.14.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 13:14:19 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] Revert "fetch2/gitsm: use configparser to parse .gitmodules"
Date: Sat, 14 Sep 2024 22:14:17 +0200
Message-ID: <20240914201417.22497-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 14 Sep 2024 20:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16561

This reverts commit a4f42e396e2942fde94b8b4944487c1c45f7a295.

Unfortunately configparser is a bit more strict and fails to parse e.g.:
https://github.com/espressif/esp-idf/blob/e104dd7f27d2e73ab0e9b614dd7b9295099069bf/.gitmodules

[submodule "components/bt/controller/lib_esp32"]
	path = components/bt/controller/lib_esp32
        url = ../../espressif/esp32-bt-lib.git

The url is using 8 spaces while path 1 tab causing:
Exception: configparser.NoOptionError: No option 'url' in section: 'submodule "components/bt/controller/lib_esp32"'

It was fixed in:
https://github.com/espressif/esp-idf/commit/62ca8e2fb478a1cdc0e47003025265cd0d840395#diff-fe7afb5c9c916e521401d3fcfb4277d5071798c3baf83baf11d6071742823584

but mcuboot is using a bit older esp-idf revision in:
https://github.com/ATmobica/mcuboot/blame/main/.gitmodules

and mcuboot is then used as submodule in:
https://github.com/project-chip/connectedhomeip/blob/master/.gitmodules

so it might take a while for the fix to be propagated everywhere.

Not sure how common these issues are, but configparser parses
"url = ../../espressif/esp32-bt-lib.git" as 2nd line of "path"
value (because it's indented differently) while git submodule
and old gitsm implementation parses it as separate path and
url keys.

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f193ae3c9..f7f3af721 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -47,20 +47,18 @@ class GitSM(Git):
         subrevision = {}
 
         def parse_gitmodules(gitmodules):
-            """
-            Parse .gitmodules and return a dictionary of submodule paths to dictionaries with path and url members.
-            """
-            import configparser
-            cp = configparser.ConfigParser()
-            cp.read_string(gitmodules)
-
             modules = {}
-            for section in [s for s in cp.sections() if s.startswith("submodule ")]:
-                module = section.split('"')[1]
-                modules[module] = {
-                    'path': cp.get(section, 'path'),
-                    'url': cp.get(section, 'url')
-                }
+            module = ""
+            for line in gitmodules.splitlines():
+                if line.startswith('[submodule'):
+                    module = line.split('"')[1]
+                    modules[module] = {}
+                elif module and line.strip().startswith('path'):
+                    path = line.split('=')[1].strip()
+                    modules[module]['path'] = path
+                elif module and line.strip().startswith('url'):
+                    url = line.split('=')[1].strip()
+                    modules[module]['url'] = url
             return modules
 
         # Collect the defined submodules, and their attributes
-- 
2.46.0


