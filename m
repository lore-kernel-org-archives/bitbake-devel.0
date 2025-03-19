Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A903C35FFC
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 15:19:42 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.10465.1742397578638271894
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 08:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=fWNYO+Sg;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso136893685ad.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1742397578; x=1743002378; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzADSQ5RI8hDNstkN9IxO0up6vMaoXPq1WWsnJ7l2mU=;
        b=fWNYO+SgeoRWFh8doEzhTDzGlS3hDSYZSGbVAPnEvEmCB4Vj1eJY84pt/btkME4Eke
         kzlQVDRBsvltHQbZQvVwKc9kbBn2Jy6BfOJOAxQ0q6CnEjhsWIqvBNx0qCD8qIIL5pXM
         Xx1to8JSx+yRlNU9T0AtyJcwLo3g3M35bQ9UZ5+M49gaQ8OEoZ/MZdl0PU0iqqWIzdUl
         z929bNm3JMEguDGiUp+YLZOe4n/prgbTjK49T/Uc5k0QT3Pyt1Ql7oceuTW418tKe97e
         luiq3jX9jK3NrEZWhmzoXOBhLGOlxCVYcOckcWWI9S7g26BfeTpwQ5JGo7Gr8BaQycl1
         zM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397578; x=1743002378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzADSQ5RI8hDNstkN9IxO0up6vMaoXPq1WWsnJ7l2mU=;
        b=YpOYUvOVaSYXxjmLpXPLFe2N44m5ywWGHhOka3vjTtTnitdEuW2x+Gh5XJRlUMEq/v
         aE65Hr3DfGPT9ckHGHMqCOLyQaIjazcUgFpAeVlTPw7ImTNnlhQq0qDqPfxfIWP8rK81
         Sal7ojW8SWyHq9skTPUTVh9GbKFKsOfEU62BOBUQjZS11SqW0FdnFeldCZBnhf0bWm57
         yakppBpofa0793uR7cZx1qxCVAP96Gk7MChXFO6N8v+/OBfCfip0wuZDTfQKkije8ydS
         V3aYNVK/bWyI5eiLnBIyXgWIaxW5lbJe3G6665diSQ1H2hajT3dwL7SaFAz08MPhcnDA
         ZXAw==
X-Gm-Message-State: AOJu0YxCdDNVs+EwDxK+7IiuvuKc3xSyKxVcI631lsT2NafpGasS3uRr
	nyU8I8xWtwGNh6lrRsch3Lmnh5fQL50E9zA3jAVoqCI+5YDi8/UUupavMs+Wz0MNOvyiSTnUIWu
	m
X-Gm-Gg: ASbGncvlxGI6C+KYqhXPrdUeZ0MMBzPtn9bPPkG+shoS0GueuJu4vEv3lhPvlj6KeWc
	bNavVAp4pCB8OjaP9jLw25cKJr+GCYN+TfwBt5jKq4M39akE8gEfx2J1UW+fZhuj8zVVkrmJ7Sr
	Dt90XCN0cYxtECDHENZ712ayr3QP/+UHJtXNe9/+TCZeV2QVqbz10jw6ECfgUoDKCXPVUkY4LgV
	NjK/W+8ZM3hi5uXzEUExt8wmGyXisTE6kERq8VWI7L00JIymEGpJQkwPsqmya1EJwcG+Nd+6jf/
	RXEzAb4QQ/2elY0RPUkZoAS/PDszfiJYXe60MHovjbdCbtk=
X-Google-Smtp-Source: AGHT+IErJ1pGIMQewt/N0TM9PzZxwXb3LfQO6Up0SPAYu7KXkoUTtr4SbNZhcdXNYDcdaJVrn/XnIA==
X-Received: by 2002:a05:6a21:6003:b0:1f5:57d0:7014 with SMTP id adf61e73a8af0-1fbebc86502mr5342673637.25.1742397577641;
        Wed, 19 Mar 2025 08:19:37 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5e34:462b:e2f0:5898])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511e5sm12110023b3a.67.2025.03.19.08.19.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:19:37 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH] bitbake: cache: bump cache version
Date: Wed, 19 Mar 2025 08:19:32 -0700
Message-ID: <f968fabffd5ce2cc1c6b59d7141cd789d83acd1d.1742397485.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742397485.git.steve@sakoman.com>
References: <cover.1742397485.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 15:19:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17471

Version bump is needed after "siggen.py: Improve taskhash reproducibility"
otherwise there will be taskhash mismatch errors

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 92e9a3ced..26304661c 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -27,7 +27,7 @@ import re
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "154"
+__cache_version__ = "155"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
-- 
2.43.0


