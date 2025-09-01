Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71857CA1000
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.52235.1756735127802716406
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F0uXLb9h;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b042cc3953cso119943966b.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735126; x=1757339926; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VsXliYwYcT3sgAjyKE0heVKtRXmDppGmlM6vylsstw=;
        b=F0uXLb9hJhcqCROTTslulpXsROh2p/xLrSyWe6F/FWaQ+tDa5NnWHoh4Rd9w2oyvNt
         MT23mIrgRT/2vUGnmVjbeOy5oNZ8CLptTJZptu/546SJNhNMKvRpTpdRowF3McEOkEE/
         gzCEV8kPCS9LfQcW7HsIgaZG+BLIbc9FYMZqty/o91gnsp4GLAgG/tnJxaYUBPp75Iz9
         h8tnU+jCxKpUZ5bR2TXJQhR7GR1resyETrUSAQbZ+N/bVBesS2pXe2Arp/iF24GkWR3s
         e0o+9b96GFcLjcQhTSsGBGAUr95Oj+0/q/Bb/PVDAksT3QQXEinyVnKh4zZud8vsHSVk
         zEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735126; x=1757339926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VsXliYwYcT3sgAjyKE0heVKtRXmDppGmlM6vylsstw=;
        b=MMwMtM2jB6Vd4s8g5pjcsTxpD6Qczf9FqQZ2IawO1Ozirjv+fImkkDnUK3asVGumue
         JBnSL4041fHRkTIYl/8HQWm+l+LyOKK1vlBcCFEgN6VX7eL6HSD+bs0j4mqwinwejwvq
         dwXf/l43IHI2oR30PepCigYJg9ILjc2i29PAhXjqYVWVpN0Yaek1aHg8zN9iW05HPnwh
         HMN/H/ZKvZdU2EzJOf4MeObmZ8QTSRyCf2N8LbYRXNmfuBU3jY6qPXpjQOWcu09JoLui
         pG1xBMwc2K9nJfQH81b+qTZdTBeydgGx5kHm8KOaAZFLZJGOPozNPvq86WzqeUkB6Cae
         6ZmQ==
X-Gm-Message-State: AOJu0YxQEooMu2CRZAUCvLvWds+1VCiVMRtUm5HDamoQOqw/ZSuM/OeS
	F/FBhhURpha7PJZL4ObiwI4GWYm5KOnbgQHIfi6QtrSU80mHxATVjWnufiUf0A==
X-Gm-Gg: ASbGnct7HW0bSGGPgFvla5yRt6AlWs6iTIjaDRrZ0OUospX05ICcfovzazDgg7XmlRX
	qXfTv5dKqlbY8ex7hj1Y7uhAs34m48z8u6vIEj8W2J+3K5OpsNobphaXiOMhU0fszUDkSyBgy4Y
	skOBPqfCsAvPjnt6V3zZK1NEONq70vAbMgqzH/jZKt/c6T+9SQWeIMFiUnqgWWTijg5fVhknEO2
	+qGlLmgV0TteoH8ZDQiWqLkjRqIRXFXmG5adsStmgH+G48ktrXGOvLopJHbkefwR/cVxhZ+b3Zt
	73AGTVKXLFRuqwuW3R+j1dGuUfRv6R90WjvoYwSKtZubkmuIuPIYRZbG8DOgLVvTWnXNd8jUcIB
	gcfCadlvZ0KZTfs/xb+TPaM0/SKxCuPackcVre0InZzAtZZzkGu9PBKsktieRWxN84NQJYrKnl6
	atzt7yRN29Cvy3NwTPT1FM641+YfczPTyLESROS9fYw9SO7DIl1KQHrtw6CGPGprtrujHv
X-Google-Smtp-Source: AGHT+IHEJkbP/nAs2VP1jn74NBYP03nfT2BKtTqqQrktxH5/YP2o7RWVUwvrFxEipKOpWiz8i4cncw==
X-Received: by 2002:a17:907:3f12:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b01d8a708d7mr852544566b.17.1756735126145;
        Mon, 01 Sep 2025 06:58:46 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:45 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Gyorgy Sarvari <skandigraun@gmail.com>
Subject: [PATCH 5/6] bitbake-setup: fix non-interactive init instructions
Date: Mon,  1 Sep 2025 15:58:35 +0200
Message-Id: <20250901135836.2927686-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17917

From: Gyorgy Sarvari <skandigraun@gmail.com>

The --non-interactive option is position-sensitive, it needs to stand
after the "init" command, otherwise argparser complains:

bitbake-setup: error: unrecognized arguments: --non-interactive

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 9c2922b59..7382dc8d2 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -368,7 +368,7 @@ def init_config(settings, args, d):
 
     source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
     upstream_config = obtain_config(settings, args, source_overrides, d)
-    print("\nRun 'bitbake-setup --non-interactive init {}' to select this configuration non-interactively.\n".format(upstream_config['non-interactive-cmdline-options']))
+    print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(upstream_config['non-interactive-cmdline-options']))
 
     builddir = os.path.join(os.path.abspath(args.top_dir), upstream_config['non-interactive-cmdline-options'].replace(" ","-").replace("/","_"))
     if os.path.exists(builddir):
-- 
2.39.5


