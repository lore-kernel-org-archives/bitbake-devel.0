Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD42C53219
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28917.1784928506720973698
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fxm/mJhL;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee37dc91f5so494630a34.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928506; x=1785533306; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7dPMeFbRtTh/kwy0v7vISQWTQs14M0pwHEAB3cL9XY=;
        b=fxm/mJhLnqi3Fn+dlb0jsUJiDGYbslQ3BS4n4qZm2kwxiBocJCFOyBySXe58R3Nwik
         1c96PrEvyFHg4X8gxtY3YNY5LzqRFWV1xK/UrasReTH4Qp9PE/OIPj2h6bOpVvSqmv6+
         JSG2UDETHCAfzxck6pibi6Vd8gZNxqtE9b8Nal6C84fG+6Ge2icBmJl0Cm1ANeNBbIlV
         zdBF+sLNcTC0TxyxZa4uFzISFzIcl6WAVbGtDA8XCJOlys/oB8kcEI1a/QFBC9QwQnPZ
         omj8zA1KjOWcY7vFK+ERpFx8MjmMJYoe4OX2t4wAUT7QgbP5HmPN8dKFhT/1xVqHDP/2
         54Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928506; x=1785533306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7dPMeFbRtTh/kwy0v7vISQWTQs14M0pwHEAB3cL9XY=;
        b=tJusFGDYwnK7bZ9CJfB0j9Y1PgvyKBrrMTZRHoauPT1L62x0ogD7m5Ak/BtIYrpd6m
         1NgDeKB/PGuVml8LNc1I7taLwR50o6hSDSoLlIVRFVZP0Fv5hKzW1WNlwJg5/7aV4zGG
         bcqEcPC2SlUuUjDbsTxANPPvXHV1EPZljZWGmTnfhrr0G9qqLsLwUX83p0HOqXxXdV4W
         X7/xSkpfsv7ThEGmvOb97+649zaRvavNzykqOzg5KG22p0LU7r3EE+yus9uGrMza5Trq
         qH6nDNC7DdCYjQp8o3z/g/q7HXsRzkwIlK1KilpoWqQzW2lOb+RCfaqSP0AAqLq3dhTJ
         LRIg==
X-Gm-Message-State: AOJu0YyEutYeHDVXnhicKH+PHYIrqwFkcPSZCPqwtXhCn6Me9L/bd2jX
	CCjzQU1CvaWkDzTUPoKhVbluyORISkC9e5m1LWoO3RdNaujD4i/AoDx90qJ7QQ==
X-Gm-Gg: AR+sD12kZlIBvSTJ/oDQwKdIHC0l8fs5+GkrRWSgWCCe/3kL4hmLIVoVy5nG7PpH0NN
	+4Z6pXQDGv6rwX63Qnn9j+5dJ/zK8QgCtVnw40ctfsreaiYjBRdtn0XjnBaH5eVulO0SYFFZbPd
	2DdIOQ2Bz2iJeIgYnjEGaXP6hLaFOyE2NlMTpVQbAyjmmDXjE5EXFmK1gMkfplJfztphBKDnpgU
	CzKRgSdoZ3RL4KQOINsambUkvu+OAxvlqtIc+uiKrP7vSLqajGTJLQqJns2fNKO+NxHyei4m5DU
	2gN43okg23fqi0gYike+MExtrcNM/QHRmYjvXXBCL+tNUKBDOoW6bTsq7BDHE2tJfc7t+11Odse
	oBKD0flItCBQK3501qSe6JY5MTOM/KThOcm7QWKT+OO+1bXbbNYey8a0HGbOIDoQyAGHEJSwVgH
	E=
X-Received: by 2002:a05:6820:f026:b0:6aa:f7ac:faf3 with SMTP id 006d021491bc7-6aaff95a51emr26086eaf.19.1784928505807;
        Fri, 24 Jul 2026 14:28:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:25 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/6] hashserv: Pipeline Upstream Queries
Date: Fri, 24 Jul 2026 15:25:08 -0600
Message-ID: <20260724212822.1165552-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19850

Adds a true asynchronous streaming API to the hash equivalence clients,
then uses that streaming API to pipeline requests to an upstream server.
This means that when a server wants to defer a request to an upstream,
it no longer has to wait for a complete round-trip API call. Instead, it
can use the faster streaming API to send the requests, and continue
processing other requests while a response inbound.

Joshua Watt (6):
  hashserv: client: Add asynchronous streaming API
  hashserv: server: Fix formatting
  hashserv: server: Add queued streaming API
  hashserv: server: Use streaming and queue API for upstream unihash
    queries
  hashserv: server: Use streaming and queue API for upstream exist
    queries
  hashserv: tests: Add test for upstream pipelining

 bin/bitbake-hashclient |   2 +-
 lib/hashserv/client.py | 306 ++++++++++++++++++++++++++++++++---------
 lib/hashserv/server.py | 191 +++++++++++++++++++------
 lib/hashserv/tests.py  | 105 +++++++++++++-
 4 files changed, 492 insertions(+), 112 deletions(-)

-- 
2.54.0


