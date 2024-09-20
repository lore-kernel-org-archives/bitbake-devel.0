Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75DC78834
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 12:43:29 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.17243.1726836032732375300
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Sep 2024 05:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hNMW0yFE;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: simon.eu@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9018103214so257665766b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Sep 2024 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836031; x=1727440831; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qzw2hbuTGeOj7nSGn/XFEg5FMN7Dxv3FCmUYti29Bs=;
        b=hNMW0yFEn6JlIOa5FSahLJWHwJfoM9HnGr+iW/0JO+H0NPh7gJgy1m9ihVmO1ZmYTa
         zPp7MZR2Jh/PEUGIl1Z4OmYTc8sDg2a32jCqkxg3cgQio9yr/IP0ALy+W+hlG+fTUwnU
         tk7FvXYOTdJTh6sPUQsrFNNCeWdogZ6o/1E4Nwh/eqJmzH/UmFpaL2GRqfpREvqMH6QW
         +TaY/hff1+TqwVP0r7rRXfE57e4h7XTShJg9I5DDxKNtgABB8veYcNeDnQHnPA5peLPE
         fUouRgX4zBPFczn7N8gOxDJxHP16TvjdNemY2XG/1OSX7aGMVe+XCwW0rNHrG7utWy9a
         vlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836031; x=1727440831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qzw2hbuTGeOj7nSGn/XFEg5FMN7Dxv3FCmUYti29Bs=;
        b=poFKqRLoTSvdAdVOqoGmQyDc/ehZFyIH0OmQyvSqS2tIZLo15npl854CSTG3DDbaky
         OLzzpa+PK4uJ2u2ZIi9nyVQH4pG04rLtv09QOe7tRZ0d6glS+LtUzb82f1e0rxqsFQnm
         +iiPGxTjq8VxNwSJ4Td2mzsfDaaQVXEdN+cNDql9FnEwtWIkkNMiCT8Rtsw5S53ZLnES
         o6r6wl2UtdCCHZMhWgY6WeXkYsIbPL80s78g84/3LQg1ZnzAFH3Rq6hTjtYxOi8kjEeE
         7QDJ+XmvWNQpPChPXpCV4WL3mQ0Cq/Hwm+ZhjfKT3VHnyJTgXUPdYQ+B6MDohU44pGMQ
         8Jpw==
X-Gm-Message-State: AOJu0YzuUaItGW4v7JSCzusqYQcGux7FdmTdfk75z6yyPxqIYcWex4oX
	kV1YdgyS7Wl3Ig/qTQGmOJ0povieQ2X8Du5+7vDc/T7KDnRebkaZV06uig==
X-Google-Smtp-Source: AGHT+IEtNy1GqA3PM/N1DQdrUHyTgo9DZZCd8HEj+3+CwGs04KcaRQyZCmOnAgcf6lBvsT/2EZmKQQ==
X-Received: by 2002:a17:907:96a7:b0:a77:cbe5:413f with SMTP id a640c23a62f3a-a90d56726bamr227953566b.4.1726836030517;
        Fri, 20 Sep 2024 05:40:30 -0700 (PDT)
Received: from simon-T14-4TB.. ([46.140.188.244])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a90613303b4sm839002566b.213.2024.09.20.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:40:29 -0700 (PDT)
From: "Simon A. Eugster" <simon.eu@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	"Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH 0/1] Clarify that _ and not : is used for suffixing the variable name.
Date: Fri, 20 Sep 2024 14:40:19 +0200
Message-ID: <20240920124020.2894006-1-simon.eu@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Sep 2024 12:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16575


Simon A. Eugster (1):
  bitbake: doc: suffix for BBFILE_PRIORITY

 .../bitbake-user-manual-ref-variables.rst                   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0


