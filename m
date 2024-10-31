Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D260EE6897C
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 12:00:36 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.10579.1730376026608671944
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Oct 2024 05:00:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HwvTj8qK;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43155afca99so12047015e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376025; x=1730980825; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg1fNblzp1IyU/x0rt5IqjKd/QPxYJyl6K1Q2CMiOQk=;
        b=HwvTj8qK055riDXNcmsnVQJtARWzKF8BwL9oW8j6g/7fksbIJtrUHUja6Hd5JJ/e9w
         jIrEhz9Qk8JCTt64AodG5hFp33nKw4GI1KHK0gLPB9egUWMBEYFKO9roWuP8BcyxZNzS
         /8jr2lh2zyRnXND8QQ2s4wUVKELxC3oE5OQfueMZBvxenpEFU1bN1OZM/Oq7RecWdBnA
         tUe0gO7RlhO41Jr/rUEdkxNVrtByW7FerpQj9OpOGQxS1HE5JyDrDeKniSVI+cowVYCg
         4Bpfu0lcOfzzBrAbNV/embkLyQ8CAHSiYYT/z5oOn4PBMHKuLNyC0JJvglXtYayOtpK+
         dQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376025; x=1730980825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg1fNblzp1IyU/x0rt5IqjKd/QPxYJyl6K1Q2CMiOQk=;
        b=MuHftYvlYB/k2XJIN9u8YldhPlU1PEe1xn2Ct8BvvCNSLfeMdzr/CLfxHhyFNAtWRH
         449Ndv3Kxx4LRmRdq5wLOjfGi7jQwtiH8Tzs+Al6zvfgiAKXKmaZqeaq7wc5ilOK9QvC
         dRqCm6znKm3wCb9y7k9uAD0chf9N6YzE1D25BQ9AfrEG5T5bCNP3GSC0LUF8338E4vlx
         Ry3jg9w/Cd3ZIguVlfO0ZE8FQTAW5qEUi70sZ1lxH0mXjJ1DrbQviH1PySfiBmcH0ZEn
         9ZyDIPGrDNvYprBhjJG0dnPRltCaoomCRN8MujQPjvgodhW1mUDj3lLjIzeDAihR5U+u
         nY6A==
X-Gm-Message-State: AOJu0YyBRfj4T8P+DsQFc2sBb6EdK0eIND9PwlYR1wWsWWUq6uTTvavd
	2cst1mKq2TXn+n6J+F6HcqDeHLvz2ZAEygXj/4dvVXRpuFlsKGga22PFhcBc
X-Google-Smtp-Source: AGHT+IGgMi+jWkwxbf7s9xO/wSmf3WYy9oFXs3kn3NVyzYOpBI1PEVBy797QxlfGx3D6Lrr6b4rsDg==
X-Received: by 2002:a05:6000:184b:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381c12bef57mr1672390f8f.9.1730376024529;
        Thu, 31 Oct 2024 05:00:24 -0700 (PDT)
Received: from fio.lan (bl15-243-112.dsl.telepac.pt. [188.80.243.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm1933078f8f.96.2024.10.31.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:00:23 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake][PATCH 2/2] bitbake: cooker: the hashserv client ping is not suitable
Date: Thu, 31 Oct 2024 12:00:15 +0000
Message-ID: <20241031120015.3651707-2-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031120015.3651707-1-jose.quaresma@foundries.io>
References: <20241031120015.3651707-1-jose.quaresma@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 12:00:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16762

The ping function of the asyncrpc client doesn't work as it should
to test the connection to the server and if the server doesn't exist
or is not reachable we have a fatal error in bitbake.

| Timeout while waiting for a reply from the bitbake server (60s at 11:52:15.476236)

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 bitbake/lib/bb/cooker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2e80986640..2fcf4dc144 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -315,8 +315,7 @@ class BBCooker:
                 upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
                 if upstream:
                     try:
-                        with hashserv.create_client(upstream) as client:
-                            client.ping()
+                        hashserv.create_client(upstream)
                     except (ConnectionError, ImportError) as e:
                         bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
                                  % (upstream, repr(e)))
-- 
2.47.0


