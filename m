Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F9C43602
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 12:00:47 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6541.1783512038890641792
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 05:00:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LkIFuT03;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46ed4f66256so515672f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Jul 2026 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783512037; x=1784116837; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4SvZ65bC0priVQv5eAscEk4fzuV2sxPV+gbGB6V4RQ=;
        b=LkIFuT03brYPVRELh8pB3nVKpHvi2sXV4FQTsyiGRUFxdhiWKCjEM8psSJ8SgNLBFm
         HcP0u8xP4Y95uH/U5dCtf/8pGIh7H8G5GQTbXd7hu/uDH3LybJzvm2PyMXPYGaH3Vnf6
         Knz+jLFdEbUHeRLNo6sf3iG7w4pGD9yqOHtW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783512037; x=1784116837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4SvZ65bC0priVQv5eAscEk4fzuV2sxPV+gbGB6V4RQ=;
        b=h2OhuG44YFXP+OFlhN7XrCbQnLSteovCPF3L/ETpE9NnTgWB784ePGGnOQejjxpoyj
         j3xXnTypJcs5ypMDr4q8q6ZRMyEAV5PAsg2+d0EqKzVp8IDi1WIflrr3GK6t8pwxKH2v
         usrHLrqyVTe2vI3Y56WbX/OtKCfZ2/B1l+bRVjSuwCsDy7FOFR238+Szq4UR+FshwwkY
         74Okyq3U0JEUj7LU8ZnPaykKJDKXGcdJyCc2hlOwqXH4oRfy8Tj6B7eypeFVE4+gMeix
         aQ9t0+YQcI9Pgj+r/9x6pD0dChzJb7mzFYgHUl2pvTilnv6IfJ6JuqMJ6Hbt2OJFFEUD
         L7Aw==
X-Gm-Message-State: AOJu0YyXC3SsAmPsDX3wS65f5uXmYiZZVrPfQKceey0YudeOdj8ZDgup
	xp89Sb7xpZXFe9r7ikKWcfEgXwqg2J+gbZSACBdUNdf68Lg3PWce7vkFTqQqw0cPmMzahvA27Xb
	0jJvmBqs=
X-Gm-Gg: AfdE7cnVd7JvAmUH7t1JiLmn5j8Q/pXEJGlKxiBxfkLLfaW43gq0IPSVa44EF5N6tWl
	0INcSIPZC0p6B12J4axp24oucC8UaS5nQfqYAc3/7EV6iBehljpy8IYBBHKePWc1U1jCN6fI0iT
	EeBbY4O83pj3lorQ1zKhPnlhREiRweYoLIdzRMnJ/4aGqZv56UsvCiRoW1kFKM/LsEvTMTDDh0W
	F0q4dbZbylfOTbf/tWfpL+F4mnD7KfOOok+xjDE6sUUFwWvOYcGDer944GrjG8mGxWfNRJWgz+0
	PsvQcUArrJ2znKBtGhWpk02EIvuOROmE1YKdGso6VnvVSyjyJfFYEq+VVAp5eyHE4fYmySQlhnp
	n/x2UZ/XO1rXVfzLmKtDaJg1ORg6Jl6xyUoiwScC2agMFxoqwfimLmFuSi6vUC7Py+QGFNrF77t
	lrtRKbuZkKmPq2pgEDsfARRKlhtOkJUdSzsSDhzgFIMA==
X-Received: by 2002:a05:6000:1841:b0:475:f0d1:eb66 with SMTP id ffacd0b85a97d-47df07c1423mr2648312f8f.51.1783512036546;
        Wed, 08 Jul 2026 05:00:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b60a:b356:19ef:1131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43760525f8f.2.2026.07.08.05.00.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:00:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Add NFS EEXISTS/isdir failure workaround
Date: Wed,  8 Jul 2026 13:00:35 +0100
Message-ID: <20260708120035.3530343-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jul 2026 12:00:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19821

We're seeing cases where we see tracebacks when creating directories in
SSTATE_DIR on an NFS server. The issue is that we see EEXISTS being returned
but isdir() is False, likely when multiple clients try and create the same
directory at the same time.

This is likely a relatively well known issue with NFS's attribute cache.
There is also a way to clear the attribute cache, which is to call
opendir() on the parent directory. That is what this workaround does. In
the rare case we're about to fail, try that using os.listdir() and
see if it helps. Testing showed that it would "fix" several cases
where we'd have had failures otherwise.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1347c29d020..8b8d381faa5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -944,8 +944,20 @@ def mkdirhier(directory):
     try:
         os.makedirs(directory)
     except OSError as e:
-        if e.errno != errno.EEXIST or not os.path.isdir(directory):
+        if e.errno != errno.EEXIST:
             raise e
+        if os.path.isdir(directory):
+            return
+        # We can end up here if there is a race between two mkdirs on an NFS mount,
+        # which happens more often with sstate that you'd think. The server returns
+        # EEXIST but the local attribute cache is out of date. It can be refreshed with
+        # an opendir call, so try that (via listdir) and check the directory again
+        # before we really fail.
+        os.listdir(os.path.dirname(directory))
+        if os.path.isdir(directory):
+            return
+        bb.warn("mkdir: %s is not a directory?")
+        raise e
 
 def movefile(src, dest, newmtime = None, sstat = None):
     """Moves a file from ``src`` to ``dest``, preserving all permissions and

