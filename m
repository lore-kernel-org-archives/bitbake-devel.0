Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61828C4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:28 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.12292.1664898925982367504
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=wl5VQwAP;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id
 o9-20020a17090a0a0900b0020ad4e758b3so2837314pjo.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=VgtIAAt3fhXpdYUi0bA5aXUJZ92leAc0liU2SOYUgaA=;
        b=wl5VQwAPdIe1V4tMazQ5PRVFKW2/719+oopsWAQVZ49x43NkDqwOp8S3Or824+JUWG
         1sJrx7FhefLxEfwuXOsXsbO9XL/M6Tyz4fPjLVxOtp9z1GeTQr0FvI+M/VKE6iomVV5Y
         T2WUjqvFpw790mTtR19V5IyfukQCQsVl0rQEJFvOJVkHlXJbiet31ZyfWUF2akGDwMK9
         +jr7Z80Z1yDcrS4xXURWP9Joqd/q1PEfhqFFCTOeKZ+lUyx9vPjqRpPqXsa5MPeNIfzS
         i4eElIO6gES3nTIeI4lJLEZ0gHYrHLlrqVN8Q8LYQAUjZ061bH8MG6MRsnP9GMjp8AUV
         jMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VgtIAAt3fhXpdYUi0bA5aXUJZ92leAc0liU2SOYUgaA=;
        b=TahJaxF7vV72H+O35AP2o5cPlE5Ynf9wczLKtSoW7D3Wch9ziNERR4fXvOWGQJlOaW
         XkWFvFYODULqI2keNteiVMHmZfJiA64ZWeYxlRu7wlyNzkxayLHw4xesBgey84go7wYm
         W2Gh4ujDcwVrXATbaiKkor93RamFbrlPWViLbaSDPkpAuPdWjt5F11TRPXx6Ubjb07mt
         UeG1cEyAtxAq45SNe8GZiw7W0AfF1MOxDtoeo4ue9zBR9NxuhzDY+aTaiCTfAXa7igd1
         WUPJvXkMbcIc0QoPp96IfG+N1mt81NZm75LQHfH2GfKx04NJfI4cKuupTQ6tJBigEgY0
         wdcg==
X-Gm-Message-State: ACrzQf0qFxQKROzsbhRY1faCWRteWIze7fdFSlCKJB7v79nQo8E3Omx/
	aiJBAcCCaU6r2JKn00+5oqYT0hqjrmciEMMs
X-Google-Smtp-Source: 
 AMsMyM7/kLaYXTw2j89j8nmKv7Hfl3pZ1H/BaciH4hxx4MBqDQfPu9fuyURhhmO4PCH979u0CVW56A==
X-Received: by 2002:a17:902:ec82:b0:178:1062:3031 with SMTP id
 x2-20020a170902ec8200b0017810623031mr27514776plg.89.1664898924859;
        Tue, 04 Oct 2022 08:55:24 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:24 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 5/8] bitbake: Add copyright headers
 where missing
Date: Tue,  4 Oct 2022 05:54:56 -1000
Message-Id: 
 <e591325b2bd901c381003deb96a7b32a7148e93e.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14020

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Where copyright headers were not present, add them to make things
clear.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1aa338a216350a2751fff52f866039343e9ac013)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-prserv               | 2 ++
 bin/bitbake-worker               | 2 ++
 bin/git-make-shallow             | 2 ++
 lib/bb/COW.py                    | 2 ++
 lib/bb/asyncrpc/__init__.py      | 2 ++
 lib/bb/asyncrpc/client.py        | 2 ++
 lib/bb/asyncrpc/serv.py          | 2 ++
 lib/bb/codeparser.py             | 2 ++
 lib/bb/compress/_pipecompress.py | 2 ++
 lib/bb/compress/lz4.py           | 2 ++
 lib/bb/compress/zstd.py          | 2 ++
 lib/bb/daemonize.py              | 2 ++
 lib/bb/exceptions.py             | 2 ++
 lib/bb/fetch2/osc.py             | 2 ++
 lib/bb/process.py                | 2 ++
 lib/bb/siggen.py                 | 2 ++
 lib/bb/tests/compression.py      | 2 ++
 lib/bb/tests/cooker.py           | 2 ++
 lib/bblayers/__init__.py         | 2 ++
 lib/bblayers/action.py           | 2 ++
 lib/bblayers/common.py           | 2 ++
 lib/bblayers/layerindex.py       | 2 ++
 lib/bblayers/query.py            | 2 ++
 lib/prserv/__init__.py           | 2 ++
 lib/prserv/client.py             | 2 ++
 lib/prserv/db.py                 | 2 ++
 lib/prserv/serv.py               | 2 ++
 lib/toaster/manage.py            | 2 ++
 28 files changed, 56 insertions(+)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 323df66d..5be42f3c 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -1,5 +1,7 @@
 #!/usr/bin/env python3
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 9d850ec7..2f3e9f72 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -1,5 +1,7 @@
 #!/usr/bin/env python3
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/bin/git-make-shallow b/bin/git-make-shallow
index 1d00fbf1..d0532c5a 100755
--- a/bin/git-make-shallow
+++ b/bin/git-make-shallow
@@ -1,5 +1,7 @@
 #!/usr/bin/env python3
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 23c22b65..76bc08a3 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2006 Tim Ansell
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Please Note:
 # Be careful when using mutable types (ie Dict and Lists) - operations involving these are SLOW.
 # Assign a file to __warn__ to get warnings about slow operations.
diff --git a/lib/bb/asyncrpc/__init__.py b/lib/bb/asyncrpc/__init__.py
index c2f2b3c0..9a85e996 100644
--- a/lib/bb/asyncrpc/__init__.py
+++ b/lib/bb/asyncrpc/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 34960197..881434d2 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index b4cffff2..e14df18e 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 3b3c3b41..9d66d3ae 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/compress/_pipecompress.py b/lib/bb/compress/_pipecompress.py
index 5de17a82..4a403d62 100644
--- a/lib/bb/compress/_pipecompress.py
+++ b/lib/bb/compress/_pipecompress.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Helper library to implement streaming compression and decompression using an
diff --git a/lib/bb/compress/lz4.py b/lib/bb/compress/lz4.py
index 0f6bc51a..88b09893 100644
--- a/lib/bb/compress/lz4.py
+++ b/lib/bb/compress/lz4.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/compress/zstd.py b/lib/bb/compress/zstd.py
index 50c42133..cdbbe9d6 100644
--- a/lib/bb/compress/zstd.py
+++ b/lib/bb/compress/zstd.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 4957bfd4..76894044 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index ecbad599..801db9c8 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index eb0f82c8..bf4c2f05 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 """
diff --git a/lib/bb/process.py b/lib/bb/process.py
index be2c15a1..4c7b6d39 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index bd6fc204..9a20fc8e 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/tests/compression.py b/lib/bb/tests/compression.py
index d3ddf67f..95af3f96 100644
--- a/lib/bb/tests/compression.py
+++ b/lib/bb/tests/compression.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index c82d4b7b..9e524ae3 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -1,6 +1,8 @@
 #
 # BitBake Tests for cooker.py
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/__init__.py b/lib/bblayers/__init__.py
index 4e7c09da..78efd297 100644
--- a/lib/bblayers/__init__.py
+++ b/lib/bblayers/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 6723e2c6..454c2514 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index 6c76ef35..f7b9cee3 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 79365162..0ac8fd2e 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 525d4f0d..9142ec44 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 9961040b..38ced818 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index a3f19dda..69ab7a4a 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 2710d4a2..b4bda707 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 0a20b927..c686b206 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/toaster/manage.py b/lib/toaster/manage.py
index ae32619d..f8de49c2 100755
--- a/lib/toaster/manage.py
+++ b/lib/toaster/manage.py
@@ -1,5 +1,7 @@
 #!/usr/bin/env python3
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-- 
2.25.1


