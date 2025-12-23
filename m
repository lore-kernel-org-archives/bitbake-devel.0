Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DDE6F082
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 10:18:13 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98157.1766485088147837264
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Dec 2025 02:18:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=c7o+8+i8;
 spf=pass (domain: smile.fr, ip: 209.85.128.68, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so48783945e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766485086; x=1767089886; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtbCIQ3ZC+dM0PqspT29FgKVTSObuAISrT2YCdXsYgo=;
        b=c7o+8+i8OjJMSPQcU/fKULvJAwbqo9ZP039aPfNCAmMp4NhHgiV98NKrqNjCxX1bRg
         M1AbxybFRnbuT4wTvQUIhn0OI1CwK97KQ33Uq0r11KtbFFXDfTzjlliifqjtjVUwlF4x
         dhyQ0Vk71sD1tAYUpG9W8z2J1ezf94Gr1FJKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485086; x=1767089886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtbCIQ3ZC+dM0PqspT29FgKVTSObuAISrT2YCdXsYgo=;
        b=W+Ekin0V64zTh0+7nSfz/A3vyT3XzLd9YxrENga9JFkXnaEEBizE7zTywr4WnyVApm
         sRmxVKQJijmgxr9Z2crUsYNsPcei496qLyxt6aWnoCE3ehgKLPVtjJ+C923GJT2VFRNB
         4/XbQpEnuQHXt7pjwKv8EvmLKVf6hXX2AIeoypF7UJb8jI5qQkChEG2NQRI1vzCAbbyd
         oYKLmuvpsbTeHvZ5BCJ//F5l5vLXCToGtmgmgT1+9CeIVm7crTo8KuavdWQtWtbXXO3w
         iu8T467HzK9A0CLtjAQJeN3Wmeqch9QafgNoLSMZCXxTrIZJ6uzQM54wmDfonf7ksGXO
         7Gdw==
X-Gm-Message-State: AOJu0Yz0goJmkQJYTUf3n0sI5n7aD5blpNlsmZ+BzMgPNptqBtWJyT5h
	ovqotjGx6YX3lXZS9WT7CMWQI86iS5grtLjz5a5sKQCLi90Bhg+Y8BTYLicP/f7qx8dNpugJq4l
	iQJml8tntVg==
X-Gm-Gg: AY/fxX572OKIYUTvQpQ5LOWpIrzk3MzUk2aPjDqa0WxBcV4DQIEBcDk6oP4yR/v1CwZ
	rjBZs+uppnmUgf2pJgoog7LReU1DOGcS/5mxxfyrjRRUR8LkgpQWAfSNnRlery9Ti+OR+DazpHq
	9Q2Fgwq26/++3nHLWVfyvFjGUsS5rg/DtpFqwCQO3UfqSAB+cKGzex/EZSQHtxg8zyLEAZ8p4VN
	Wbx0fPiQGAtaMCWdinnCHcUYr7A/ol8cHdUI6X56vhwxBnmrbPSDJIahSgz0gucw77hNq7FKVCA
	5y/5KzFOQD9RffN+JVcM26U6NxGbQWwZJ+lnnbHg86a7IZ8gR8h3c0nAeMoKy4kDmOvytp8NMrL
	OcPd7estOPqRJeChHxQC0Fp3uQXKmuTu+W95RpbncdVLAZHkp+RN0j9KI82oVfkII41i+H6SWIt
	J0gkYRvrZs+YxJbmk=
X-Google-Smtp-Source: AGHT+IEo1klbgwyFiMm4n10FYMsb3BuyVnC6wFWbnEpFpxuyLhXU7veWqyNe0+EDSbItp4iJbOKjEg==
X-Received: by 2002:a05:600c:4e01:b0:477:9574:d641 with SMTP id 5b1f17b1804b1-47d1957f712mr147674695e9.22.1766485086498;
        Tue, 23 Dec 2025 02:18:06 -0800 (PST)
Received: from heaven ([2a01:e0a:25d:d2b0:4eb0:a6f9:d3f9:1686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm27428376f8f.38.2025.12.23.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:18:06 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v5 4/4] doc/bitbake-setup: document "uri" property
Date: Tue, 23 Dec 2025 11:17:56 +0100
Message-ID: <20251223101757.1057188-4-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
References: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 10:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18646

The property 'uri' is a simplification of the property 'remotes'. It is
used to provide only one URI.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../bitbake-user-manual-environment-setup.rst        | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..b3588f27d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -673,11 +673,7 @@ They contain the following sections:
          "sources": {
              "bitbake": {
                  "git-remote": {
-                     "remotes": {
-                         "origin": {
-                             "uri": "https://git.openembedded.org/bitbake"
-                         }
-                     },
+                     "uri": "https://git.openembedded.org/bitbake",
                      "branch": "master",
                      "rev": "master"
                  },
@@ -716,6 +712,12 @@ They contain the following sections:
       -  ``branch`` (**required**): the Git branch, used to check that the
          specified ``rev`` is indeed on that branch.
 
+      -  ``uri`` (*optional*): a URI that follows the git URI syntax. Can replace the
+         ``remotes`` structure if only one URI is provided. Despite this, ``uri`` and
+         ``remotes`` can still be used together.
+
+         See https://git-scm.com/docs/git-clone#_git_urls for more information.
+
    -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
       to under ``layers/``. This is useful for local development, where some layer
       or other component used in a build is managed separately, but should still be
-- 
2.51.0


