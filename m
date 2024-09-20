Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA113C78837
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 12:43:29 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.17246.1726836038458831936
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Sep 2024 05:40:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M8uWp9qw;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: simon.eu@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d2daa2262so226672266b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Sep 2024 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836036; x=1727440836; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mepI1EvQ3lYlIWg7ce+7aoKTY3bWi7YPZEUKXVzpLw=;
        b=M8uWp9qw0ozoeo80oCiqUy/3dVdATvfdWOnJOYjxnxRlGbiBbIxUoaNjtL5lYtHZJ2
         z93BN+/KlnH6FGq3mnFfBxf1YXj/CihA4q2qvwfdIoJRk0JexwkJl0cWqsbBVAjSeUkU
         kvMi+4JotWRzLSP93+I4zBBxZ+pPuIn5RekbUggiovW8VKLskxhDzw8dHm580Uu+qeaW
         By5IuVgsEOw2ymk7c4ateK+89j/ZAUHUgfAcH4SuhANh0/8TROqGlE556YgdR6Y/90NA
         k5BJ1se8XAg0EgXvGFsdpidyQxV6lg+41WTLjNrfdxOUdb9BQ8LBMn5+CvsC+iu4A5ul
         ne4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836036; x=1727440836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mepI1EvQ3lYlIWg7ce+7aoKTY3bWi7YPZEUKXVzpLw=;
        b=aDDfsGNYp3f7q47PfzEjPbIU9czaJHT++GYOlWfRs+I1PmYc4IiMis7XzrcDgLklUK
         4AqZKA7l+avoaMgKFfDpWGU1OnY5WDHgCd1R6THJFsP7325EpiOYbQadp5Ld1wEty8of
         ygMDQWT+EoEZhZVZ43UsieSPHRUwWrDufhtQ5vbfyoL0sGQG5f4/4nKTCe9sfGg5Wkl2
         dKVRt6L6HkWBT11KSAoe8zUZFlCz0M8CG6X4YfM9bPTk694vOBFsuddbt2CaOnrSDVLr
         gkHEQrAKA56nyO6YfVvyIcgJEMoteSA6qytVkAfVdPceGo0eZJ+jR97dAL7cLxsAPA+l
         sNpA==
X-Gm-Message-State: AOJu0YzOVFOWyJHCHq5llHKFh+GXLUD87e5Tuue1kLoLI7JdnIH8376K
	8X4dc5cYEKcrGRHwGx7SG3chzYIEupSEtyELzC82dKmEVETEp/m7xORSTg==
X-Google-Smtp-Source: AGHT+IEvJ9lwpmwbQOLUavkkilLjZgGR+9oSVZIpPwbrK4I4hHMswfngUMHPw80H8v8wJCc1UgvmQw==
X-Received: by 2002:a17:907:f792:b0:a90:c411:24e0 with SMTP id a640c23a62f3a-a90d4ffe8e7mr238495966b.23.1726836036141;
        Fri, 20 Sep 2024 05:40:36 -0700 (PDT)
Received: from simon-T14-4TB.. ([46.140.188.244])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a90613303b4sm839002566b.213.2024.09.20.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:40:35 -0700 (PDT)
From: "Simon A. Eugster" <simon.eu@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	"Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH 1/1] bitbake: doc: suffix for BBFILE_PRIORITY
Date: Fri, 20 Sep 2024 14:40:20 +0200
Message-ID: <20240920124020.2894006-2-simon.eu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920124020.2894006-1-simon.eu@gmail.com>
References: <20240920124020.2894006-1-simon.eu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Sep 2024 12:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16576

Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 899e584f91..c203531f51 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -766,6 +766,10 @@ overview of their function and contents.
    :term:`BBFILE_PRIORITY`
       Assigns the priority for recipe files in each layer.
 
+      This variable is used in the ``conf/layer.conf`` file and must be
+      suffixed with a `_` followed by the name of the specific layer (e.g.
+      ``BBFILE_PRIORITY_emenlow``). Colon as separator is not supported.
+
       This variable is useful in situations where the same recipe appears
       in more than one layer. Setting this variable allows you to
       prioritize a layer against other layers that contain the same recipe
@@ -780,7 +784,7 @@ overview of their function and contents.
       higher precedence. For example, the value 6 has a higher precedence
       than the value 5. If not specified, the :term:`BBFILE_PRIORITY` variable
       is set based on layer dependencies (see the :term:`LAYERDEPENDS` variable
-      for more information. The default priority, if unspecified for a
+      for more information). The default priority, if unspecified for a
       layer with no dependencies, is the lowest defined priority + 1 (or 1
       if no priorities are defined).
 
-- 
2.43.0


