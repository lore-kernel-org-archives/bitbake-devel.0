Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12016C28B2E
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 10:49:40 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.5915.1741690173049900995
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Mar 2025 03:49:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FOtx+EcZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso2781155e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 03:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741690171; x=1742294971; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CXy7GpDUnD42fxfBvyP05yFTLxwAbW0NiFioS4BTZQ=;
        b=FOtx+EcZe2poJz8n9SQZX7xY3zi6OUF6lUG8IkR0R/tuTzglPr24Ab1uAcMwcrGFm3
         HG94HL2ijVvvGUO8L0r0Y40B0z36mS9ojyCIr/XCovajNrWqPz51gH9viT288zDXGzdD
         CwRJ9S2z4I4a/jLrNOJFC2Fhc8LpUGL9QMW8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741690171; x=1742294971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CXy7GpDUnD42fxfBvyP05yFTLxwAbW0NiFioS4BTZQ=;
        b=sNg8kNbOdolfEhkdT2Udj6hIk2c2T5+Jr5/BnWkYGIYt7M0qFhUF5otAey07XBdObL
         iCWcqtrJim8yIXBwayC0GJmcSuzH3ZzjIrCUTbjFX7MU6TyUo8fLzLXNVj/CknEEr58c
         3g733KgrYR6zDlTNfaXeRl19PURipahrHVpANSSz2jHsPqdnlg6cZ0x4GdMBWz2X9GuG
         zw2u4fIEbJ7Hi3b99gPDeL2z3Eg00SKIW4Zjpi7zmqeRSfkkb/JQ015UVuygXQ4mhqW8
         RWOojmGksr+nXyrylF2TsA8fZbe4/gTH831WhdkrGojhGePmPfk1KpUt/Ix2Qlt4mh4C
         ZOzA==
X-Gm-Message-State: AOJu0YxA50syCXC5kR7it7vuwhSk/OrO0HoEaTDCkQZf3jkI/AfwHTH0
	1pEXvhlNQbyxqD/RaZnvWrxXqBo0PCgnmQYq0dnpWQPpDxFNRmPMDnCogH6sukHFP7TSEUK/SeL
	w
X-Gm-Gg: ASbGncsdOfWxkSaAztqvY1vV7Yg+9zHsX5YHzly6RdBnNM9k4DUXJF8f0+cb73oh1Pw
	fe7FKwpzodFwlkotuJJsTXcWGOT3JylJPexOxX522Gmwt7t31JtNTqmaEa/wtoBnwzOTpNhTZ7M
	8XoYopgEC+yqeSzcsO+9P5JsFT4J5KAM3HYWqZ4pKSi+2y8Jk6AXngiLZarUmwRddSNsrrEQEMH
	pqkRJrVuEHImY58XgWMxA5JupjnFGh6B46ksMR9to1pFJ6Zb4fDYPrlKG9nlIcQz2FPX3Z9uDGR
	2VcT/eVwtD44QnSagPXFr9E1pSaac99rYYs2qT7blGtY4yShOVdtoxmJWG0rWCby9znwJAuq4o3
	T2FIxeno=
X-Google-Smtp-Source: AGHT+IFzXrzsJFPIUJCVLVdj8rwvMOFLl2mcLlRWhkiHmbi69x8G9/3C83Vl1068qHkeAXiNqinBhQ==
X-Received: by 2002:a05:600c:511b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43cf61e702fmr80063385e9.2.1741690171040;
        Tue, 11 Mar 2025 03:49:31 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:98ce:619b:b74:b8c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce9f2d081sm114838905e9.21.2025.03.11.03.49.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:49:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-server/worker: Hide os.fork() deprecation warning
Date: Tue, 11 Mar 2025 10:49:28 +0000
Message-ID: <20250311104928.2980203-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 10:49:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17428

We're fairly careful in bitbake about how we handle fork() calls and believe our code
to be safe. The upstream deprecation warning is problematic as it can appear in log
output as a WARNING, breaking tests. It also tends to alarm users.

Hide the warning for now to avoids the test failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-server | 1 +
 bin/bitbake-worker | 1 +
 2 files changed, 2 insertions(+)

diff --git a/bin/bitbake-server b/bin/bitbake-server
index e367ec2c12..a559109e3f 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -9,6 +9,7 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 88217182fb..35fa1ab62b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -9,6 +9,7 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 from bb import fetch2
 import logging

