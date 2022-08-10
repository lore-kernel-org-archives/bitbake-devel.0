Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA3C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 20:01:46 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.3037.1660161703438708939
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 13:01:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=elN60tI/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id v3so19028146wrp.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=dZGfeqaKsebUP3DDNpH8yzncGKD/HsNE2q2KVuVxlzk=;
        b=elN60tI/sQ7ubaAYrjsKtf6ea0Mclqi7QPS5duGSmSoqL7RRCHG1RI/DPvSBuebn2s
         V1pfjGA3JFRCHeGUPOtM966P87MoHei7ZqpBte2o8xzpNUmp2Cq7G/f7UKSDo26kkEa+
         LPEdFDJll2JPbVivcDrQGDBnW3baD1WH6RRsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=dZGfeqaKsebUP3DDNpH8yzncGKD/HsNE2q2KVuVxlzk=;
        b=MWirK2PNCMo4ybWaAtkds5fcBtrPav1PKpNnV97xmbX5bdS/eE2QwLrHNkWQN75b/a
         SDjWLcsU4H0ol1+hlJDqJBc4Tcs0v1yKUeux+UA6LczNw3cehimGA5ad7tWnfpv1fo6E
         ngV9A9c7AtTWG85cDrf3R/KsCZent8UDS45TVqHCtI8B4i7nwl/qMatCqg5VBndpheyk
         /L/Lou2vjt5ppQJFKF4W7VItxXl3SeZ/5wK9uToHIbPvMmqfPJvJ9vcAj/+GVqn61NA0
         aOALUGwj3/ncTz6t1oKWV9uLvXrPL4TkCVIJkfTPA5Or9/HIansJ6EYWFIsYDbWB+V2+
         a1ng==
X-Gm-Message-State: ACgBeo0nFzR/8qv45vWTrfxRXarxDFUq1v/K2i3qbjlO2gYiX3O3ZBfg
	1f1QDObg/b9YTxLMHClATFpEfCbZub5XqA==
X-Google-Smtp-Source: 
 AA6agR7PFl46oIsBoMHcHpoSOhXXpTh2Pp002BYCrHTmhl40h9jxt3d56BCp2ejBExHj+MPvCTCNuw==
X-Received: by 2002:a5d:6c6f:0:b0:222:cdb9:f002 with SMTP id
 r15-20020a5d6c6f000000b00222cdb9f002mr9967267wrz.198.1660161701477;
        Wed, 10 Aug 2022 13:01:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bdb5:cbd6:cc51:991])
        by smtp.gmail.com with ESMTPSA id
 d13-20020adfe88d000000b0021e13efa17esm17193949wrm.70.2022.08.10.13.01.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 13:01:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Add copyright headers where missing
Date: Wed, 10 Aug 2022 21:01:40 +0100
Message-Id: <20220810200140.487098-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 20:01:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13891

Where copyright headers were not present, add them to make things
clear.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
index 323df66dd0..5be42f3ce5 100755
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
index 9d850ec77c..2f3e9f72f9 100755
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
index 1d00fbf183..d0532c5ab8 100755
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
index 23c22b65ef..76bc08a3ea 100644
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
index c2f2b3c00b..9a85e9965b 100644
--- a/lib/bb/asyncrpc/__init__.py
+++ b/lib/bb/asyncrpc/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 34960197d1..881434d2e9 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 585bc121da..5cf45f908a 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 3b3c3b41ff..9d66d3ae41 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/compress/_pipecompress.py b/lib/bb/compress/_pipecompress.py
index 5de17a82e2..4a403d62cf 100644
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
index 0f6bc51a5b..88b0989322 100644
--- a/lib/bb/compress/lz4.py
+++ b/lib/bb/compress/lz4.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/compress/zstd.py b/lib/bb/compress/zstd.py
index 50c42133fb..cdbbe9d60f 100644
--- a/lib/bb/compress/zstd.py
+++ b/lib/bb/compress/zstd.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 4957bfd4b8..7689404436 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index ecbad59970..801db9c82f 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 86f8ddf47b..495ac8a30a 100644
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
index be2c15a188..4c7b6d39df 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index bb80343a97..07bb529452 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/tests/compression.py b/lib/bb/tests/compression.py
index d3ddf67f1c..95af3f96d7 100644
--- a/lib/bb/tests/compression.py
+++ b/lib/bb/tests/compression.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index c82d4b7b81..9e524ae345 100644
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
index 4e7c09da04..78efd29750 100644
--- a/lib/bblayers/__init__.py
+++ b/lib/bblayers/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 6723e2c605..454c251410 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index 6c76ef3505..f7b9cee371 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 7936516209..0ac8fd2ec7 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 525d4f0d47..9142ec4474 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 9961040b58..38ced818ad 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index a3f19ddafc..69ab7a4ac9 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 2710d4a225..b4bda7078c 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 0a20b927c7..c686b2065c 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,4 +1,6 @@
 #
+# Copyright BitBake Contributors
+#
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
diff --git a/lib/toaster/manage.py b/lib/toaster/manage.py
index ae32619d12..f8de49c264 100755
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
2.34.1


