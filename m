Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2055C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 20:44:49 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.65086.1699044281006905784
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 13:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JD0Pi8d6;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso33595321fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044279; x=1699649079; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHzXzw9XEtPcYK9PEvqvPLhTa/SaY6jFy73xhijGZPg=;
        b=JD0Pi8d60CllcI6YZ9yRxsrKd5dI9ObC8X9QOGtUWgraurJJ0/NliXyVHjj+QPLFBg
         iRraB2o9brndj9SLwla+UEQXYyo66TuCTUxcFLadXvfPhIzqgq8KsPgGSOMVgUTJJrG4
         Yt3q8LLXC50lcdQod5gXogniAGUF2Q12+VQUOHR1feKkAeoxbbx3IWvcGmt5tp1qUVzM
         XxuSC6Mqpj9Lwgm4XHSi50Dwp+zaMz5IgKnJqBG3Ui61NrQdVvC+Stcf600/7SFp6TUn
         mdwVrg5DXejvVfQtgfTq9dviFbJ+nzQJVFPqchn/8ITVIUyfzfI895NpUhupKs/rd6h2
         Rsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044279; x=1699649079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHzXzw9XEtPcYK9PEvqvPLhTa/SaY6jFy73xhijGZPg=;
        b=Nd5cFfMWk/8xKTYdCg1eJZIhIlhh8SwVTc+ChN9J4n9umZ2MzhCX4dvMUkIeeNfXWa
         bnZ3RROamOrTXeRcwnwnbbtOOAox1Tclh2PzzImRd1WEPwHNdnUBsj9SgJjNQKNcR7Z4
         dB43NVTm4U/sODT/EJTZuP1VTQipf3P4OqC4sy+ajaK4gmmSJrVf9wewPziyKnp2vfCe
         GQxF3kE7+VGMlKabjGS21IeATL9TwRiadQ3OneBqmq8oshurXtTOI1JreEgqr0R3BZhe
         9Gkl9lBwOBM8IdzPsS8B+pvMfE+vahgQiVeD8XPBVvlQ8eAdYK3KB8gmKilxAO5jcaJC
         YBPw==
X-Gm-Message-State: AOJu0YwcLgBW8tbKFbbEDnnReAlPIqfITqvjH/fWMeNKaFTmKto2WfzA
	NinS4IBswq6ybuZrAIcyRNlqQa34DPc=
X-Google-Smtp-Source: AGHT+IEOMvqX9kESdKV06ml8agd4geGmpra92v/WLI/gLWty5ho4ky9VDuwSlW49eGxDhqWk913wyg==
X-Received: by 2002:a2e:bc11:0:b0:2c0:122a:322b with SMTP id b17-20020a2ebc11000000b002c0122a322bmr22602011ljf.48.1699044278913;
        Fri, 03 Nov 2023 13:44:38 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0040772138bb7sm3685180wmb.2.2023.11.03.13.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:44:38 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 2/2] tinfoil: Do not fail when logging is disabled and full config is used
Date: Fri,  3 Nov 2023 21:44:25 +0100
Message-ID: <20231103204425.2011257-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103204425.2011257-1-martin.jansa@gmail.com>
References: <20231103204425.2011257-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 20:44:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15447

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

If Tinfoil is initialized with setup_logging = False and
Tinfoil.prepare() is called with config_only = False, then it fails
because self.localhandlers is only initialized when
setup_logging = True.

This is seen with, e.g., `bitbake-getvar -q -r busybox MACHINE`:

  Traceback (most recent call last):
    File ".../bitbake/bin/bitbake-getvar", line 41, in <module>
      tinfoil.prepare(quiet=2)
    File ".../bitbake/lib/bb/tinfoil.py", line 390, in prepare
      for handler in self.localhandlers:
  AttributeError: 'Tinfoil' object has no attribute 'localhandlers'.
  Did you mean: 'oldhandlers'?

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index e68a3b879..fa29b930c 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -324,11 +324,11 @@ class Tinfoil:
         self.recipes_parsed = False
         self.quiet = 0
         self.oldhandlers = self.logger.handlers[:]
+        self.localhandlers = []
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
             bb.msg.logger_create('BitBake', output)
-            self.localhandlers = []
             for handler in self.logger.handlers:
                 if handler not in self.oldhandlers:
                     self.localhandlers.append(handler)
-- 
2.42.0


