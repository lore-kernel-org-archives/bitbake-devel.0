Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB965C46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 14:56:31 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.102531.1703688983276756116
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 06:56:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W63AxW3e;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: insu0.park@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so1903769b3a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688982; x=1704293782; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sw7MqqooJz7x83DOEeePDjlUF0JD/DRb0A5cPq7QvGE=;
        b=W63AxW3eghRFnfDXgwNS8YCENE2VeS7nafYePiRr18HP+oWuq5Tv7NmnPeJHFnxvwF
         CQU6qf97o7j49JWBorUSwB57vlxHBMq1sw8SYQIC1AScuGN7Yt2lJ+J7BajxTqo9OdU6
         a4ML4+cwJXwXxAl0p+RArRWqANvfvB9RWtnexnImLBCGkKGyVr4EnCptxlrKOIqyZ9js
         ZfyPuyL9I6U8LKcaMRw79u9AaVsW5V5BXggd0TKKqiwuo3InULl2Z0NR1VASXJ9vowT7
         u05OoRxV4u0/VahhLDos6v+Vr0sOgNwbi8Wlq63F+rD2Yr6/xN+bujAO1wBUP2e5iSRO
         7Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688982; x=1704293782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw7MqqooJz7x83DOEeePDjlUF0JD/DRb0A5cPq7QvGE=;
        b=thBGlOJ42RA5e+S5BYtbsJVWZhEYtMy4VOMKEUi5k70w9KZ6EO7p1D5utLsx+0KEsp
         VOBirNNjfu+eHcCJ25aENTRH1KtDf1tCOSI9pHhFofDgK5Xo+OKU4ZXBKwGNMyjp5q5R
         Gq/okRyXA8e9tyjxS9UYkO9lyph5aegakgWZ7xomYvMMIlTX3sQIib8K+C8NpWCrzy26
         OCfV0KoNj7mRyf/S3uSzPWTBOFscogkZm4s+rUeN7BO2E0oZlmLWtD3aKIX60KJRcrtb
         vz0inB8kv8Lz4B3GUp2AqqznBRFzu2pZdZNsLR9EtiLImcq6VrQcb0Mt1hwXwltaekoe
         6mVw==
X-Gm-Message-State: AOJu0Yxo8bNT6TNrzjiWoxKxfVIfvJ10KpQ/U9K5UgNqpw99/U0Zeehq
	fHgVjDehN+JsAAa4fVtvhT+O6wcXuuI=
X-Google-Smtp-Source: AGHT+IEgOsKvAjd7PpbIlvCZRwZtLHY3rnAGvus+gUBv85MgaBypBY1rQ4aiyQ33Cr1kX9JGSdx3Rg==
X-Received: by 2002:a05:6a00:93a6:b0:6d9:acc8:98da with SMTP id ka38-20020a056a0093a600b006d9acc898damr7167605pfb.2.1703688982642;
        Wed, 27 Dec 2023 06:56:22 -0800 (PST)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id fb27-20020a056a002d9b00b006d9bdc0f765sm4944491pfb.53.2023.12.27.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:56:22 -0800 (PST)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	steve@sakoman.com
Cc: Insu Park <insu0.park@gmail.com>
Subject: [dunfell][1.46][PATCH 0/1] Fix dependency handling bug of remove operator
Date: Wed, 27 Dec 2023 23:56:16 +0900
Message-Id: <20231227145617.8940-1-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 14:56:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15707

This commit has merged on Sep 19 on the master branch. (b90520eedb1dbc7f6a3928d089fe74fafb864eb5)
I think this bug should also be fixed on the LTS branches, kirkstone and dunfell.
This bug is not that common within the meta layers under the Yocto projects, but could be a problem in production domains.
I cherry-picked it by myself because it requires to resolve conflicts for each branch.
Please see the details on the previous post: https://lists.openembedded.org/g/bitbake-devel/message/15082

Insu Park (1):
  data: Add missing dependency handling of remove operator

 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.25.1


