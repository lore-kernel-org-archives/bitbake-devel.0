Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A2C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 14:52:25 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.46682.1710773544371229467
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 07:52:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HAqUBXtd;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so5298242a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710773543; x=1711378343; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDCYF90KVoqXPvTIKFvnTKNsFVpxr7IHQ/QyYiD6xic=;
        b=HAqUBXtd927noxgss2qGxj82YG9ycnRu1C/KEt5yizsWr0wSsyaGBIQJ3EtXDtLK6r
         2nGU3jYNMnYSJtRaJNyHw/diJjeVO0G+hW5nKOjE19UF7XI24ds0WIoJPgS3TOeiWmbd
         fqBc6s9ULAtKxgS3fNZyQZ7N3Zz5rCbya7izaz+INeV0TzOYw8+yVhqSdJrbK6VsRiLg
         teQyKnDFNuogBjZyiEeSuNSRRkYGN5pSeId6hlD4ZDDzog2HVVwQL+iFOP+1k22Xe+6Q
         Emo1Ud5FAQMtpsckJp5DWS45MXxzXTgOxQwYuFeAQc/uSjnn992txHYnrKCilzcpCQ8+
         lExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710773543; x=1711378343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDCYF90KVoqXPvTIKFvnTKNsFVpxr7IHQ/QyYiD6xic=;
        b=mxbuoMoaUfLVlQE4xISOBHXMujXX2A0rpu0WsNnzbaLBNi1LJTG8zc0B6GZvcjqzRA
         Fi+w3hy2eDTzB0uYCCGmRCgcV/5+cddLYMd3aUyBqxDxKTaU9uV+RUFyUnNrwVHg6ymQ
         QFYxRLxAoGSAwm10t6PfihAeCBBB3fst0SC4KTd5p7Ej0FHUVaA5Aqq/OUKfa1fXq1Dn
         EbvM2latLDjwuMNtCnoPPgM1K5H3tL3Aa6RyOkob8ZmosHJAHUFc6bhHvdowxydOKe9a
         3Wf4AwDIBgIzmtsiC1EBaLGm+MEOGPovpx5x6gm5ViqRte2s4PXdK9PYJOO39XlhyGII
         qTwA==
X-Gm-Message-State: AOJu0YyAnSUVBDYdSCFm6v8iVjrmfd8F26wLT1v8azwEsx+knlB+ubNk
	ccjJvE9P6IkowpNVU8lhAZuNLFo3uunHu4GCjvzGEBhcjg0aLIMgJbEZuioB
X-Google-Smtp-Source: AGHT+IGk8mGpnL6TU55XgE3+h9Vu2GW2M5a8AwrM8kdD+KJuep0azmmqLLPEU9tTQIPGZ2exB9Gsdg==
X-Received: by 2002:a05:6402:548e:b0:568:1444:a828 with SMTP id fg14-20020a056402548e00b005681444a828mr8092585edb.37.1710773542359;
        Mon, 18 Mar 2024 07:52:22 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7db99000000b00568d67e50c3sm1516703edt.89.2024.03.18.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:52:22 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake: improve descriptions of '-S printdiff'
Date: Mon, 18 Mar 2024 15:52:18 +0100
Message-Id: <20240318145218.1192363-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 14:52:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16002

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual/bitbake-user-manual-execution.rst  | 7 ++++---
 bitbake/lib/bb/main.py                                     | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 4fa3ca4b54f..d58fbb32ea0 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -586,10 +586,11 @@ or possibly those defined in the metadata/signature handler itself. The
 simplest parameter to pass is "none", which causes a set of signature
 information to be written out into ``STAMPS_DIR`` corresponding to the
 targets specified. The other currently available parameter is
-"printdiff", which causes BitBake to try to establish the closest
+"printdiff", which causes BitBake to try to establish the most recent
 signature match it can (e.g. in the sstate cache) and then run
-``bitbake-diffsigs`` over the matches to determine the stamps and delta
-where these two stamp trees diverge.
+compare the matched signatures to determine the stamps and delta
+where these two stamp trees diverge. This can be used to determine why
+tasks need to be re-run in situations where that is not expected.
 
 .. note::
 
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 92d8dc02931..bca8ebfa090 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -217,7 +217,9 @@ def create_bitbake_parser():
                              "execution. The SIGNATURE_HANDLER parameter is passed to the "
                              "handler. Two common values are none and printdiff but the handler "
                              "may define more/less. none means only dump the signature, printdiff"
-                             " means compare the dumped signature with the cached one.")
+                             " means recursively compare the dumped signature with the most recent"
+                             " one in a local build or sstate cache (can be used to find out why tasks re-run"
+                             " when that is not expected)")
 
     exec_group.add_argument("--revisions-changed", action="store_true",
                         help="Set the exit code depending on whether upstream floating "
-- 
2.39.2


