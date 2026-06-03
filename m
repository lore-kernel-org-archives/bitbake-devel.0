Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE99CD6E56
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:48 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17308.1780483724051804088
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b9yXoBT2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4814149f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483722; x=1781088522; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yN8PP+PwPUFHtfdql7jqiWpY1fTj4PKNEPJoWzQGI+o=;
        b=b9yXoBT23HmKguwJ0egdc16GPVfGkC1x06S3e78C4GDs30bOj6VKBn+vttprovnvEq
         h7E4VpLwcJcLlyh7aKJpWjNgle6sYDbOxkm/DqXodETLorW++0WI21kTNHPQAzhyLppX
         xhKlVbR6ILSJ+FhbplyVHbly9SVCgX1ne/aHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483722; x=1781088522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN8PP+PwPUFHtfdql7jqiWpY1fTj4PKNEPJoWzQGI+o=;
        b=iglpti49I0KQxCTV0NgqY43AQGmS8xmainzRubeTW02vgg9qXGrWMDSmyzdFROL4fg
         cz/GHM4Xf0TD5f/3UzN2UQtSH/VloejRDEb51P1YmzfvtsixQO/5vN/mJ4JzbtQC0YZ7
         H7oTwXnV5kTzbjBOXpSUnZYMLyyHuHgRkH4tJRm2tIhPMe/wtEBPfHdYJAEt4PusQ3yk
         d/xcaqIp0andso/g+iai5qlWOTUbPuv2k7SledBZtmLgGh/8LhRedTPRte94i6TjmbB5
         //oMd9utYUDd2XeQR5/zg1GwQ6/7y7qAmT5vlxvLvzOzZWGc2Sg7wHo/UnZZHnfDuXek
         BV1Q==
X-Gm-Message-State: AOJu0YytoFHR2BEIkWdcLbKUNgTZ2uLzrhL0yhBgaxOLWwCGPdNsJ3Jt
	JJhj7AyEnD4vJCd506NgpiLJ1JuTN+whEqra7k9M/w1srs8vNslmAWh9Sx8DX2TJH7pTWZCN/tR
	ltom0
X-Gm-Gg: Acq92OGR3FypS1ftt2MPkKvm1j1SzNqdfcVN1mGESTVpKkmrvPBWnue8gFT33wYBU73
	gDsb4zKbAn3kChqkrDvkzqkTlpdW0DaQMn7sTgSIAQqrsy1E+oGRn3OyZcwFw/J500a+oxNa+lH
	r31d5lta6L57NfxJIDVKk6xN47K5peQLPIm40fAovPOYSDptE/6dLgoiouv9UCSkKwM0PfqcgYR
	p25WKsb9NfWKbi5LpTUpJQevfDQcvmxtRX+BioB3a/ynsiS89zRsdNteKaVCfbLqPqWGAomeEBW
	BIQTyN/eli6wvDCNTR1mbyYvOYPYw0cB/NbjxgvMimhN6ishiwLg+Rp+i3EbBZmGeHEEYIsvcZh
	qn1QqrnqsL5Lba+bqan4udh8Ek/dhockc44rfzk4fV2HilcVWRG2JJhCWTI7jkZdTvWKIsN6HQ0
	HyBZGGd6uSgt4Qmzz1huCaDrsf7rsRf2gPVa/YLYlTh+wov9m4kpjvEBicxYdj3A==
X-Received: by 2002:a05:6000:60a:b0:45e:f4f7:7cad with SMTP id ffacd0b85a97d-46021980b94mr3785972f8f.39.1780483722155;
        Wed, 03 Jun 2026 03:48:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/8] fetch2: Allow runfetchcmd to handle lists of command arguments
Date: Wed,  3 Jun 2026 11:48:33 +0100
Message-ID: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19594

We want to be able to pass lists of arguments into process.run(), to
do this we need a way of avoding shell=True. Add such a codepath if
the cmd is a list (not a string).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4234c62d0c8..e3b8f5787b1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -979,7 +979,10 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None, extra
     error_message = ""
 
     try:
-        (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir, env=env)
+        if isinstance(cmd, str):
+            (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir, env=env)
+        else:
+            (output, errors) = bb.process.run(cmd, log=log, stderr=subprocess.PIPE, cwd=workdir, env=env)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s not found" % (e.command)

