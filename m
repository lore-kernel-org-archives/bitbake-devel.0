Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC898CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:36:44 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.12481.1759919799056408783
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 03:36:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mXnHfgsv;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: adam.blank.g@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4da7a3d0402so11114701cf.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759919798; x=1760524598; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOaBwk+Ve3D3bgcnSPr9tgBJTtJYOecp/t2l9uriAv0=;
        b=mXnHfgsvbgdnQhsqEbPgCPQefTUB5abU/ZX/mkSJ08x5IOdVSt/vTV93AeHVb1oT6T
         t/J73VvCQcBZ+goyOVyTmhyN+xPpqbe47sBFMAYzWZ8r+hThVmYEyO6fDbUsXiGPfDOP
         cAVJm6B97rsVDAsT4K2gdS1dbrMtu0HEmtRvEMwpQfPihHOf5cL4C/0tuc9xnSM5UiL3
         Z+ahYSW9R4hc65LF0hbbbZ3j73b2lEjelOH/BZcb5GdkgKss9pTB4DsWfyw56gv8HCiR
         GAV0vAjQCCWZqMAP9UyW7QqcRG6ytntbjgALKHFTB/3OS4C1zGwO6XJhsKl7aOqTl+yW
         Kmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759919798; x=1760524598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOaBwk+Ve3D3bgcnSPr9tgBJTtJYOecp/t2l9uriAv0=;
        b=kTcEHtTPDhjXdXJWmKnnyEUuSNdQJheVtIcXQ0ZvA9ldZvMvWh6D1D6V7qAPk7CRan
         CQ3ETNK1d7SiZqZehM0dZAZgJBvOtJTfXqQFtPHpM/+KPL+qQ/xkOz0KMRNTkxZZOA9m
         Jw4P18rXD8OGbfCc9Ke5xSIZ7J+dX4vubzgHxBw7279oAEbQpyMJmJYmc+ak1SWc5Jkk
         cLCtNQMmsWtTKG9IDsBEhvX4Zq+tB1HIhQRa2wrAU3BJCW1SAKQ/UpgfF5i7CpZBtUbh
         hwzpUJxGAfoyW/oIuAOJcIohgaWSDsvdKkMo4CFoRL7wbqIf/jabxtuft4LNsccEErZV
         vl2g==
X-Gm-Message-State: AOJu0Yw5EUuqLkAVVaPQFajwq1a8JBv5Kk3MPTIrkX1wnvGRo5vYps29
	8fdm1u7j/n4k6/QoBq2S8ItPjp6VEx3LUPYatXECL92+5xjr75lU2Q+4PJ3sKQ==
X-Gm-Gg: ASbGncsXJMcAZt42WG1MNQAPJrIHrwBkDYXl4MK9K6U4Kz0dNTmLpBaCVYhRmn30O4Q
	muZfswRdrQs/H28IkCybAAfWYIjXsuNP2NOy+XidQwVZ1hiLUn3+05LNpanG8ZvMFewuv0IycaZ
	HvVoWeS37fGcuFFyY5W9Ccgwnn5YU3BSOnMsUiFZWkWTk0A4Eog/uXkZIHHAY98SfeSF5odQV1d
	aNCaVQIe7a7938NNYAIiOB8EejVU+1WuqA7ZCIEK7JXuOHG6/yBPI2YdoIt5YBgR3uFUo/pNAyi
	cikZbkp89+kQZWbYeUAn2XhFle+Q2vxQAo3c45JweJhruNKTGTuNODZg4hAwR9Y9dhTSBlKIt3F
	9Rd96zX4aOWzmk3oLagxngwb0wO30zSdE2dnZKVnkfX2V8qgbDSdrGMvD/v1w17+JIA==
X-Google-Smtp-Source: AGHT+IGtQj9/d+viqtWYjvpuMaZ6zbl/OH5XlLY8J9OG+pptrfsrAQX1Jg/VeuhYOeGY2Od7jALJNg==
X-Received: by 2002:a05:622a:59c6:b0:4b2:8ac5:2591 with SMTP id d75a77b69052e-4e6eb05286cmr40682861cf.36.1759919797997;
        Wed, 08 Oct 2025 03:36:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:89f8:c3c0:f68b:736])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a4448desm160769521cf.9.2025.10.08.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:36:37 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v4] doc/bitbake-user-manual-ref-variables: improve INHERIT
Date: Wed,  8 Oct 2025 12:36:18 +0200
Message-ID: <20251008103618.40626-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 10:36:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18143

Current wording makes it difficult to understand what
exactly is done with INHERIT-ed anonymous functions and
when.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Added reference to Parsing The Base Configuration Metadata
- Emphasised how disjoint the cases are
Changes in v3:
- Regenerate the patch previously corrupted by Emacs
Changes in v4:
- Remove the reference to OpenEmbedded
- Conform to the standards

---
 .../bitbake-user-manual-ref-variables.rst          | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..73aa38163 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1200,9 +1200,17 @@ overview of their function and contents.

    :term:`INHERIT`
       Causes the named class or classes to be inherited globally. Anonymous
-      functions in the class or classes are not executed for the base
-      configuration and in each individual recipe. The OpenEmbedded build
-      system ignores changes to :term:`INHERIT` in individual recipes.
+      functions in the class or classes are executed in two disjoint situations:
+
+      -  When only the
+         :ref:`base configuration <bitbake-user-manual/bitbake-user-manual-execution:parsing the base configuration metadata>`
+         is parsed. For example as a result of the following BitBake invocation::
+
+            $ bitbake -e
+
+      -  When recipes are parsed - then for each parsed recipe.
+
+      Bitbake ignores changes to :term:`INHERIT` in individual recipes.

       For more information on :term:`INHERIT`, see the
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` configuration directive`"

