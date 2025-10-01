Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354BCCAC5BB
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 09:38:21 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.12988.1759311500496312444
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Oct 2025 02:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E9DfDs64;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7322da8so1362790266b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759311499; x=1759916299; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fi4frf7WOPu6i9asR8GKxuzkgALjfRTIILfJNGEXa4=;
        b=E9DfDs64OV0vLxRMrcReqI37cJpHafPsU6VWBpQGxGcxsYt99CqcpaqAF+SCqRIuh3
         Tml7PdAH40VAdOobs0leJhtoC6f6b64u6D1TSJ02ir5dmTCumUkP2+hVLiNYBkBVCsAe
         Uij/Dwfa6IgVWfEYnycTkCRsgLCeuEJckSWhK3b2Y+58O9qyOJy84PIs6VVlHxvY/dcX
         h3JMOFCoqmZTXHXxMGim7gWoon+5OAFC/llWKCez8yd5Rt9gt8auv+hQUdX49/6l6Rbf
         TBthhD0M0vtKYcDsTjWfVwYNlfgBCeoe7U/v3wfhe/igB4I7FsSnB0eAkgAY8psU7TAo
         0ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311499; x=1759916299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fi4frf7WOPu6i9asR8GKxuzkgALjfRTIILfJNGEXa4=;
        b=tml4uf9svK20G2lMBPNbPUWyqnUze/vWk5gF7p0eHnznlRZSiuKoJoriaj+zPXEFOY
         UqzOwxsg/azFfBEv9iM7fXAxsagOYVFnSD54XyMxHiE6mKSrNb048MH1937zVV55OUZ+
         FhqhTCkhsWn63uIvoiZBuwKOcvYnLbU9HzgZ0lXUA1K4qYpoiMDRZIlJLc5kRVkXUdMq
         ChvTsRihdxfI9gFfEEtPkpXjhJIPsfS3DgIMJRmRCbV2IbuYl6GdCOB2NGtfySSThsmd
         AiiON2XsEl9wedRGVbswpPluHvzGw3pWY74fACyZhZDAWdyj9SCIJUzfZ8Z74W3AHWXO
         M5cg==
X-Gm-Message-State: AOJu0YwrF0UtXaaRADzZGMqJo+xzGZxMpKAlg8ApM5mNVDbrDN0kbrFk
	jkLjU3XgglwIkmI1irvZ2Y3DykjFUavdaol1+VijrKoHUvIuI5saiuRvfxTxCzWH
X-Gm-Gg: ASbGnctOIXf55KgCEX4yHtK5WsfOwh+T86lJy1xGAxsbWfSFCk9sC7XVnz63+1+DrYy
	bBse6qzf6Nqqpw21pLzW4XOH4D5JTfn2mjRkFXjXRivk+Su8X3H4nsQXv1AtV7zEZRxL3yEDAIn
	Da5uUuh95duS278OpUtKukOEUDSiBKl83SamATQpwZHeF+CoXFgMsB2POGzyi2xf7D5lKEYV38j
	ALAmWISQPbovb+psTGeLHiUXvMXQaq3YAhxZCi2T3X/B0B7/rsNGyjJx4sg6xlSVb3iZbdUw0pN
	7KXct80ddJ4CKAv5ynAV+cYRa+PGjIgwRvDoBwgapoBcyKhXuQgUPykR+VkPPLZrs4aKOJRlDj9
	BMsvHUBQ9NRiUuAcOuHoGVObtZ2HxGxY/rGkr2zmYnSSHl47GwvMsE6iHdgYE60A+R/k=
X-Google-Smtp-Source: AGHT+IHpU6VzbNZCTKOKyCSTdcic5Fc+BIfYtoIfkgqaGpxLhRlcb/qO75dE2AFb3aUAPGht+HE56w==
X-Received: by 2002:a17:907:968d:b0:b3c:a190:b86 with SMTP id a640c23a62f3a-b46e5a4b2f0mr387982466b.25.1759311498604;
        Wed, 01 Oct 2025 02:38:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:455a:eb73:1c4e:8642])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3a79fdbcb4sm906996566b.85.2025.10.01.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:38:18 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: improve INHERIT
Date: Wed,  1 Oct 2025 11:37:43 +0200
Message-ID: <20251001093743.26710-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 09:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18110

Current wording makes it difficult to understand what
exactly is done with INHERIT-ed anonymous functions and
when.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..9d0cbd71d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1200,8 +1200,8 @@ overview of their function and contents.
 
    :term:`INHERIT`
       Causes the named class or classes to be inherited globally. Anonymous
-      functions in the class or classes are not executed for the base
-      configuration and in each individual recipe. The OpenEmbedded build
+      functions in the class or classes are executed either for the base
+      configuration, or in each individual parsed recipe. The OpenEmbedded build
       system ignores changes to :term:`INHERIT` in individual recipes.
 
       For more information on :term:`INHERIT`, see the

