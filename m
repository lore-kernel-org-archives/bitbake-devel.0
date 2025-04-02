Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F8C3601A
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 14:01:11 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.9196.1743602466495275341
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Apr 2025 07:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VOeSuz61;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso64391135e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743602464; x=1744207264; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJp/7Z9Sdz4xJhlWh6JPh38aSpZv5Fkp1w2Me1IS1gs=;
        b=VOeSuz61vDYUk0881T4iePpNrEeY+TpBNshuNGruIGdYaPTWphJFPJ21SUjIeENDfV
         7zTdPFo2skAM55E3CxA2Sd8Fgu+U7DzlqBRZmu/6r52ngUH5JyneESZUa5KBpRdj0ppo
         MNSlkqFoMQpf3QjFnKrZTgpF+AHmTHlBTe2nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743602464; x=1744207264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJp/7Z9Sdz4xJhlWh6JPh38aSpZv5Fkp1w2Me1IS1gs=;
        b=vqgfQZi8ZGh6L9QTvLs+tjAavDrAFXbSeznBQqpnUF2hd/L95+nfbPEGVAhnUBwr8F
         Lb+T5e59lZQcS3sVwr91LzEvTM04wH2fHch3nJQiA/8EwCLrwBOUOqAp0Jt2VyDYi5D4
         3oAHvZbHmK7W28kER9/vJvZP25b37YcYXZviWPr+Pgn00mjrcka1DLmyhvqJzaWP/6xE
         uvirpcM7erjAgvDY7V05WY/cavBQ7zuEHzqw60hxMB+/ZeJbdBYnCDOYfbZuRaBiiNBq
         YMVPo1lPoWbgi7fGmQOOU/xtEeWl3DN1gwq+MijoMsy2r9V1mjlg7X3PXIi6/Nr78rae
         PeoQ==
X-Gm-Message-State: AOJu0YyMxqBAPnVtRLfO2g9t1L1SsxVqmdUNl2nXkO90NlIq+fmJfBgX
	1ta+GscyPJ73lyIWhXG1tdESJHr/Z4rvk6XkkYOv5sasWTnzSQoNgPDqMOTxmcxuS3B5X+rBVeU
	N
X-Gm-Gg: ASbGncv2oB6l6/W3eF41aNrbjU3pD2WPzJGtAu/LXOvfYS3ogxzuuG4IOYD17wW9B2J
	vL9Jw9Bt70NsB/OcOk0/QhEQvrkdYbB3YDysrVyToY0mvnSaOW44SuLCNvM0YJ0jGuQb7J9cUTa
	Rebx0I7efIAKVLvBOq9wu4mWE9PnFywiS7i+Fb/oa8zo/NUaH9FTLcoAeQvHmIznvi4GHEsgvXp
	w5bxNKF92yagXa677iJb/FRTq/ooFfoj4JVCvgVgahTHzkcVLyXFcEuLrOxWZ7uslpr5Euuzb+2
	tOq4KIgBZyAuUDls55CjTB7UqhtlsAFlptdorVjU4P1rJzbsKDPtIupPXRY3TDFMWAtfLKC18A=
	=
X-Google-Smtp-Source: AGHT+IE+OeqQcMD0k47z6cU0Jop3z3/Q7r2BEqLejXupibZaYuMf3ZqDaNMqMcoMFrLGFEaaNmalRA==
X-Received: by 2002:a05:600c:34c1:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43dabe240cemr186643875e9.0.1743602462557;
        Wed, 02 Apr 2025 07:01:02 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:24b8:b374:749c:8558])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b663617sm17211387f8f.34.2025.04.02.07.01.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:01:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Handle srcrevs for annotated tags in tag check
Date: Wed,  2 Apr 2025 15:01:00 +0100
Message-ID: <20250402140100.2407773-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 14:01:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17509

If SRCREV points at an annotated tag, the comparision code can fail
as the resolved tag might not be the same sha.

Handle this by also resolving the SRCREV. We only need to do this if
they don't match in the first place for a minor performance win.

Also add a test for this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py  | 7 ++++++-
 lib/bb/tests/fetch.py | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 3a4ae6df45..5f4ec6128c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -730,7 +730,12 @@ class Git(FetchMethod):
             output = runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.parm['tag']), d, workdir=destdir)
             output = output.strip()
             if output != ud.revision:
-                raise bb.fetch2.FetchError("The revision the git tag '%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'], output, ud.revision), ud.url)
+                # It is possible ud.revision is the revision on an annotated tag which won't match the output of rev-list
+                # If it resolves to the same thing there isn't a problem.
+                output2 = runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.revision), d, workdir=destdir)
+                output2 = output2.strip()
+                if output != output2:
+                    raise bb.fetch2.FetchError("The revision the git tag '%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'], output, ud.revision), ud.url)
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8de6862482..196d93c414 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3139,6 +3139,13 @@ class GitTagVerificationTests(FetcherTest):
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
+    def test_annotated_tag_rev_match(self):
+        # Test a url with rev= and tag= set works
+        # rev is the annotated tag revision in this case
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=6d363159e4b7dc566fc40d069b2615e61774a7d8;tag=2.8.7"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
     @skipIfNoNetwork()
     def test_tag_rev_match2(self):
         # Test a url with SRCREV and tag= set works

