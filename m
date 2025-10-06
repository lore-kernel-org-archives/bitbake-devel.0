Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C01CAC5B8
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 16:19:01 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.488.1759767535943007538
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 09:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U8AFDZsy;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6394b4ff908so7815809a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767534; x=1760372334; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiYGGbNfSF/PljJVmxuGZex3MuG+FCHMM/mKxWLtPDs=;
        b=U8AFDZsyNEUJ9tTBhoRYR0o/9ZLVvQmElPW1KvcM5JL+xXF609xkvs/HwWWywOc83u
         s1ix0ooOak1gaFm6F2TTaGI/ZLszWSpEEfwzKGQ6ZnIGNH2LMgKHrp2b+97mhUP9bl2t
         /FFUqYErvBl+1WbuatDlVvpYZp2UhgTb86OZZebp6fjOiFQV4brvEmESJaYr/GKGAz9G
         vLRR2bAwhDZ938zCAFKnYLDWqkPENOsrfw5YVZW1oCDTOiq2GXYeKV75ZNrWPz5V9fL0
         r9t0LDaLodojonAi96kQU8mBcm2jZdovqSAZTnOfV/vnEDCGbp8xJ7eyW7k/oC/V5pg3
         HBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767534; x=1760372334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiYGGbNfSF/PljJVmxuGZex3MuG+FCHMM/mKxWLtPDs=;
        b=immBifBGp5nH3Wiq7SgUZXMJqJavT4hA2MRcd6ihzqNSobvybsdx9n1BC7CthL6Yfe
         n8MGiZCxBYcc/IL/CeEHPcvWYzZmh8q+uJ6WlcP95+QptsR0ADSvjcoiRhevEuoaerv6
         tUS9LzN3lqmmSQqOVTLJbxmex7GaJJ4yjPufmGzjz/sABH1M+TfYCUrJDbhzgmnHL3id
         10L+0Upr2FXDntvdkKX3dMs2wkbe90qT3kF5WU4VrKAkoVfib2kzeCVuyYQEGrYpMqJ/
         lIL5Djcro341h/NYkqubYqfIzTK+FnJukK4YrtTpJrhdpaYJiB7WRZtRAqrEEvjp44H/
         Fbug==
X-Gm-Message-State: AOJu0Yxdj+YumqvXK7l/Ha/LH3q0YJJdbdJ3YfM9QXJEKyjifZWU3bjC
	aknCrsI/+RUrMvAVeuq3rqjaSX6oXdQ0Mqzizs6JQi39AQQhYiJhpNJaXZKJpmiD
X-Gm-Gg: ASbGnctqv07vRvpbbCp9iBFOA6IiheZFpochGB+ld/wPZ52Mh1AgG9/0fBVGV+o3ZBO
	rr8XWbih+RqBbUAOJcBcIDIptTLXjYqUNAJQSMKVJBNTKuevakBhVAQ1zk22zgJAAH46c55pgJT
	JsbGcOnqHbhlCMBXkIUlcz0JTpCI1EIQ0XOwt8hlmUSOHFzH3tNRapVQjnC6Y6WY1F0/DnxETyA
	43OqQbmumwASRxD4lcCXuKf22N/T0NkBrbvwvj2rv6rqTrJWuRt6HSGGrlmY0BBBaiEGNujq/Fc
	wg9MQ/1sufBXtDeEkLdfuatIpRmSPTey/GBIE7asfdTqsZbD+RN3+4KGc5RrU6+xIenlbcYHhgG
	MXTvBtPAHhhVeJXP8wvvJhY8GUYH7d0L/rMPdiXzB3JdgUXGv5/f7su7LJvp8q6uvvkc=
X-Google-Smtp-Source: AGHT+IG/Ob9VO1PiJH/fUdnG4R15jME3umQA8U10kdB5aVbwEQpokAbdEA0iIqhVa3E/bsnA2THklg==
X-Received: by 2002:a17:907:3ea1:b0:b0f:4ae:c83 with SMTP id a640c23a62f3a-b49c4498ba6mr1729492866b.63.1759767533911;
        Mon, 06 Oct 2025 09:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:4791:3e0b:c633:c170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e75dcasm1170159066b.34.2025.10.06.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:18:53 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2] doc/bitbake-user-manual-ref-variables: improve INHERIT
Date: Mon,  6 Oct 2025 18:18:49 +0200
Message-ID: <20251006161849.37351-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 16:19:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18139

Current wording makes it difficult to understand what
exactly is done with INHERIT-ed anonymous functions and
when.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Added reference to Parsing The Base Configuration Metadata
- Emphasised how disjoint the cases are

---
 .../bitbake-user-manual-ref-variables.rst         | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..06d48dd47 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1200,6 +1200,15 @@ overview of their function and contents.

    :term:`INHERIT`
       Causes the named class or classes to be inherited globally. Anonymous
-      functions in the class or classes are not executed for the base
-      configuration and in each individual recipe. The OpenEmbedded build
-      system ignores changes to :term:`INHERIT` in individual recipes.
+      functions in the class or classes are executed in two disjoint situations:
+
+      - When only the
+	:ref:`base configuration <bitbake-user-manual/bitbake-user-manual-execution:parsing the base configuration metadata>`
+	is parsed as a result of the following BitBake invocation::
+
+	  $ bitbake -e
+
+      - When recipes are parsed - then for each parsed recipe.
+
+      The OpenEmbedded build system ignores changes to :term:`INHERIT`
+      in individual recipes.

       For more information on :term:`INHERIT`, see the
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` configuration directive`"

