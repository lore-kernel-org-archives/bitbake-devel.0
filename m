Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE2C433EF
	for <webhook@archiver.kernel.org>; Mon, 11 Oct 2021 09:59:01 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.9862.1633946339525152199
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TfUhOrP/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id y3so21203241wrl.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Jilbu2tsUwdHvVnNCqaOgE3DBBGL2hZGK0P5DAjgTRg=;
        b=TfUhOrP/pK/r3G2k+vMnlCgEag3zjDzLWDhQHufvfK1zOjV9OOigPGdv8ElQwDrloP
         3+QUdARwRifRFr+d9s5dK7SBxB/F0vBwk1W88E7D1kZ2xOdVC1uE43n2T4w3q7VqqtuI
         njuX4kWcl1oKd+pPlNyptZAxKjKo1jYUXjSM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jilbu2tsUwdHvVnNCqaOgE3DBBGL2hZGK0P5DAjgTRg=;
        b=s6YiOSUfdJY3A14MUdnr7W9GmJR8CBzT4nvidPy5TkmwCJCmmlgL3A5diHkF8/JyIx
         6q6SMQUTwDf1iFW8QEUwkr2exVjNfDx+QxLD8Uqy5SSxkoS0RHqJASS1YjsNTYxj7iYz
         TdrZ13WkO2nx3UYIoyJl92lATnla6PxYhcbf3/ftSMbY8H4b3V8hih93zI0w7DLuC4PV
         d3wU3+wIm3sJP40effA3uoVOImKI+JRTn9JWuqLy/AdSeLSYTLLMVGzn8WfSUZIrGMEY
         GfWR0f70wHy+fjc6ZBtXVOUgWr2P9verp8piCE6EHy9y6fhxCyzmVpEGpWVaowWhVLFA
         pSwQ==
X-Gm-Message-State: AOAM530KQQRFFrjmEkPEa5YP4ZAS36eAW8U5dLlXEX+KhwtsgURZK2NZ
	Guy35g/2dxHUy5M4Gs3HNyi4N0BJ0jDKzw==
X-Google-Smtp-Source: 
 ABdhPJypbp5oggNL43bgwOnWHPgrTj6gozspCh2kNDQfLSXddL+1iViO7DEKNOAa3Wr0tx2/8WN+Wg==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr23085619wrc.257.1633946337977;
        Mon, 11 Oct 2021 02:58:57 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:86d0:36d0:28d3:a79a])
        by smtp.gmail.com with ESMTPSA id
 k22sm7533057wrd.59.2021.10.11.02.58.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:58:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] hashserv: Improve behaviour for better determinism/sstate
 reuse
Date: Mon, 11 Oct 2021 10:58:55 +0100
Message-Id: <20211011095855.2720493-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
References: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Oct 2021 09:59:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12762

We have a choice of policy with hashequivalence - whether to reduce
sstate duplication in the sstate feed to a minimum or have maximal
sstate reuse from the user's perspective.

The challenge is that non-matching outhashes are generated due to
determinism issues, or due to differences in host gcc version,
architecture and so on and the question is how to reconcile then.

The approach before this patch is that any new match is added and
matches can update. This has the side effect that a queried value
from the server can change due to the replacement and you may not
always get the same value from the server. With the client side
caching bitbake has, this can be suboptimal and when using the
autobuilder sstate feed, it results in poor artefact reuse.

This patch switches to the other possible behaviour, once a hash is
assigned, it doesn't change. This means some sstate artefacts may be
duplicated but dependency chains aren't invalidated which I suspect
may give better overall performance.

Update the tests to match the new behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/server.py |  2 +-
 lib/hashserv/tests.py  | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index ef8227d430..d40a2ab8f8 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -413,7 +413,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     # A matching output hash was found. Set our taskhash to the
                     # same unihash since they are equivalent
                     unihash = row['unihash']
-                    resolve = Resolve.REPLACE
+                    resolve = Resolve.IGNORE
                 else:
                     # No matching output hash was found. This is probably the
                     # first outhash to be added.
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index efaf3bdf42..f6b85aed85 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -392,15 +392,14 @@ class HashEquivalenceCommonTests(object):
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash3, unihash2)
         self.assertEqual(result['unihash'], unihash2)
 
-        # Report Task 2. This is equivalent to Task 1, so will pick up the
-        # unihash from that task
+        # Report Task 2. This is equivalent to Task 1 but there is already a mapping for
+        # taskhash2 so it will report unihash2
         result = self.client.report_unihash(taskhash2, self.METHOD, outhash1, unihash2)
-        self.assertEqual(result['unihash'], unihash1)
+        self.assertEqual(result['unihash'], unihash2)
 
-        # The originally reported unihash for Task 3 should have been updated
-        # with the second report to use the new unihash from Task 1 (because is
-        # shares a taskhash with Task 2)
-        self.assertClientGetHash(self.client, taskhash2, unihash1)
+        # The originally reported unihash for Task 3 should be unchanged even if it
+        # shares a taskhash with Task 2
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.32.0


