Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4ECCD1AB
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 23:15:25 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.5850.1760742918787996491
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 16:15:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=WTii7lyA;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426ff694c1fso1699599f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760742917; x=1761347717; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7uemrUEuq7Rt9HkT5uxygryWpuO8MVUihJvYvbZAw=;
        b=WTii7lyALkOLICGYXC5FbaInGtsXn51J+GtLp2pyhPrghsG/7eR/vdFyByorfW3NWh
         pV3opZ+jyNg2lWDDkt5U3RdUWEGRY7A2XfsVe85y0uGPk7sdLvctLDaRyPt+gWaJSkoY
         aqzkYzJK09WS6RZWdH9njDNfpmLvMlAHeDKmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742917; x=1761347717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb7uemrUEuq7Rt9HkT5uxygryWpuO8MVUihJvYvbZAw=;
        b=dsR3AtsUZ1Wfi9iW2+WjXjTr5wlF6qj8Z2hzluN+d/xX4aSlmze5Gsa8rpoND9mM8q
         culTtexk9w76Vj86d6NJY0JiBmLnVPQ2i4W1IUkUQ4hBFfl/LyjVonB/E05zczlqDFOL
         iaNMNqwnVIEfleNh+K2Mo8SuIwYfFkoqsDL6DaEco0wSifduvYIOeZllEtupkbet76Ju
         tkH86x76lR/Q9oiFEKM2QTzzZmg+kBfYCvr6Xs5dnk5JznBgE9qM+el3N1X8HrY2rq1X
         UYXGpfqx38fuwg7SlQd7tS/TJgZHAkois9yr0ZbCDz4lrD45i04Tc8MuT/78kGfP8yNM
         993g==
X-Gm-Message-State: AOJu0YwQup0FjFu2Xk9kJP5oueFi2I6KyvVMBJjH+Igvl/9mzfzOzwAk
	O3dXP1SAYe/xr9E48DsBGckolVJRu1sGLMvqacJ6v83uQZ9s1TxArfXTqrge9GZ+kolTrNidC0K
	Z0nAsfXs=
X-Gm-Gg: ASbGncsTxS8SYmyMTOIQBjup/N+Wjab9SH/+3BGWwUvOa622ilzG3gTx81oRbSE5u+I
	U0ep4zC74xkW+zOXyRuYApp0sMcSPFiCF5YLdtjmvVtqFTYiImVNMBNeWoeuijbjtEFQTMaNK0y
	YUAqtklnrTG6uzp43vbe2K9KnKpyS2EetcmnWcBM8uSIyk9Ry13sLwRNF4SKpAar72A8Dr9Bqji
	bHfRZEAQeae9OZN1OtrR7CfsmQlGqCtEupM31cWyB2dbEghBbXqop+NI3NM7vE4kyWiI5XaH3RC
	M9MzBqgwAMBFT21xEn5UsCKjgDAtzb4zQ5qv+Rx1yt90sdCDGIFFVrX2JoTdbY/KnNLHC4qIRGv
	s7L6XG7rWXaHu/BpVle9i8w1+Bet/mJbpUEub941rqvjNaLDtosiRzGosw65bqJGbQre5AtJDjG
	6KgeujaqL/910bOVuR+SWv+gADJnw6rdAkxNITJBbpBiQriPEPvurEG/NRLxOwMsQ+MhmV5vLFq
	5sAvv9kQKk72sQoB5n5QpE=
X-Google-Smtp-Source: AGHT+IGQd0eQ5Lk2JzmYg4V8vLZH3e9AxlUWogd5ere5GStLFuRKJKRSbqLYYxhyPJMeBNjDJUjdqw==
X-Received: by 2002:a05:6000:3101:b0:426:d4f0:fc13 with SMTP id ffacd0b85a97d-42704db9ed9mr3930839f8f.50.1760742916970;
        Fri, 17 Oct 2025 16:15:16 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm1638330f8f.19.2025.10.17.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:15:16 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH 5/5] lib/bb/tests/setup.py: validate JSON schema during tests
Date: Sat, 18 Oct 2025 01:14:44 +0200
Message-Id: <20251017231444.374436-6-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017231444.374436-1-yoann.congal@smile.fr>
References: <20251017231444.374436-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 23:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18191

From: Yoann Congal <yoann.congal@smile.fr>

This enable testing the validation code as well as the schema itself.
But, it adds the validation dependency ("jsonschema") to bitbake-selftest.

RFC: I know adding non-stdlib dependencies is not-trivial so this patch
can be skipped.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index e320cdf56..3469bcc94 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -294,7 +294,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                                }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
-                out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
+                out = self.runbbsetup("--validate init --non-interactive {} {}".format(v['cmdline'], c))
                 buildpath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
                 with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
                     config_upstream = json.load(f)

