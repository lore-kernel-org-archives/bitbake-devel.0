Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF2C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 23:35:57 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.915.1742340951214485251
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 16:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WBelOIJF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso28500305e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742340949; x=1742945749; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3G633G6uqKeQblayK+1/HRVP9peqAjTt734Spsz53Js=;
        b=WBelOIJFtECiBgGhYBkfTTFGOqR3D7rLD9K3LBk3TwZd6zWFDUbNOi5EXX/p999xbO
         9ochKh23ExqEWL/AhtNuvUU7HzbbnU2QoY5X4R9qoRZOV09jgKB0xOOFl9ao/Sw1t7AB
         GJqU2YsLPxGIdohFgZwoBsIcPZuKTvkKaNqn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340949; x=1742945749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G633G6uqKeQblayK+1/HRVP9peqAjTt734Spsz53Js=;
        b=dBZB0QdwSrKOZGA8Hb1kX3EYnvXNQUCMLnaEzWlAuRvYuI7+2qWFAMBfM1yadzjDn4
         I//+jAIWEoiWDashQ6ZyPviCWXpbcS0SftPZfpGOXsRNRQ93bnrsgzZLnQBkcyZMCvfE
         Z03FEtUamrwGx+lIV6WLuqWYvHLu+FrZmHpRicx6WVxXmdk6l2L4dkFTqKmgRwirVzos
         aYQHym6+HZPbEWp2jKlr5aOtVoLD790IoJoNu6sAD+dSoKbDAk7UwDaJlustOqPAPyiz
         /nf61Ua76BuWv2Lh0CGhS40fN56xbMiNJ/omNGciDq3vPgmM925SyRbqG/2AbS5mQYsr
         1qew==
X-Gm-Message-State: AOJu0YyPW1jOp/Ke1K6MI9MmsiNRVx6VVnNWkjsItkTeMd/PjJ4Xz/ML
	cw2Qgz1PDTlj8t7ys55NQ5we0Ge4mQ19YLWBuDK0hiCX4XPa0KoxGopvfXWQea4fEL/ZHqOLmLY
	N
X-Gm-Gg: ASbGnctmIZZdDUsL1pW4aRwKbDsYWW6hV7ymJY8Dlwg+C/NybVuvzeQRdAUbbHye0qw
	B1LLA0Gq+veMK6ssLauR7sPAI4TT9l83iUJoPEVzt3e4fxEgSF8N0paT6h0bP9BBHdex084z9xl
	E6CJ/ohy8psWU9zA1ehmneMIuWMTxcABWfJSjMRxh8oSvLHBX5qWNgikvEAjky2RBjHRMJRS6N1
	D4PORSgUcoW31i87nmxyjG3U6fVaL3WU6JcyfVdRsQzIldIJ1hMld1itJx0cfVsYNX73UEl3f9I
	HPEVlWHa717lZ4UBYv6dIJzQ6CAHD1pgAfmrA6vMAIb/rCm14M8W2bByDRhYQ/X3QJyNjQEP3Q=
	=
X-Google-Smtp-Source: AGHT+IEI5KCqf72X59e3WPehx1IscRxqgpnOQ1+lTuUWaPFvB9MA/4gKJZnHaGmTOLQ4f5NAgR6tdQ==
X-Received: by 2002:a05:600c:4503:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43d437c330fmr3818775e9.15.1742340949267;
        Tue, 18 Mar 2025 16:35:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:686c:8c32:99b8:c349])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c258bsm18969677f8f.24.2025.03.18.16.35.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:35:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] tests/fetch: Fix typo in npm test
Date: Tue, 18 Mar 2025 23:35:46 +0000
Message-ID: <20250318233546.574124-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
References: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 23:35:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17463

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 77c0b99eea..305789167c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2821,7 +2821,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
         url = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=latest']
-        fetcher = bb.fetch.Fetch(urls, self.d)
+        fetcher = bb.fetch.Fetch(url, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir = os.path.join(self.unpackdir, 'npm')

