Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D31BD77895
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 17:24:29 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.646.1769189068390899841
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 09:24:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dGoP+37X;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee2715254so13526825e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769189067; x=1769793867; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=dGoP+37XJZwz3C6Cxm26CcbRetap5ZuhWwZ4KE/RXIzMVgKCfxP4oZPJUqlkxrQXI9
         4gG6Y6VX8ygmxoSQ5q/GhhlxNNP5m7Wt/2qJkHyCF7S8EAYyI6pPCiDeIwGyiYm4rOH5
         OxEnRpNzi4ahosuCqUkDzI6FtQYyFhhaSC70s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189067; x=1769793867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=wuVd1LeTEcHLMMnWZUpMdYMN3qPBgCT44a+cB0Tcr4bUjfn+N81w9O2pAbFALjZWxP
         6+ZzHPceTd+k2jit5+Q1jOK/+6j+Qgsu6KhVak0xxrATCWdCms0nZyf21JCvZcLkARbx
         H5RzmDwiW4Ro1kpoZCHOiM2LgwU7Ck15TMTjsMUr+QOHhOO/GnoSaYgS9bnM/R1ho6ck
         myAfK+PaopHwBw9dRMbPXUdKcpdDDyHI/G/A8Qg/Au0EmV2cRISeBouXMK38BWnzERE8
         X6BvQEwdJIKTqqUew+Z2uWKFAc8/s1+AaGFEwMHJTlMQQlkcRwsXUaciqS/Mf06Y1WBE
         mSjA==
X-Gm-Message-State: AOJu0YzIKGQNSiQHu757LQiNkeDiwf1CKiUCZVbd3JkuTkPh9BDAhhQJ
	/4MhVESaAuO58jbJmdRL2+vDCtxnpDgSzBoDTRmTrVkoqvcC29oYwEUh6MjceegT+GZyLOCIlhy
	loWXoups=
X-Gm-Gg: AZuq6aL+VEg2kK5uUuz41Ppa1NSG36XYV+bcId25hNbrQcAKkatAblRjMoE1ULCNXj2
	OF2Qg6P2zwXpvAi3DtTGWNZP00veuVHrf5vLNG+BDiZjH4dzTlU4qFmZ+8c0miIBlWU+HqxVaTG
	PLpX7QJdYnKMrNx+BtlZBJCBd5k220Aq2Db9DHVC/qBuustQ0yIlRQjz000CQxexKTOv5uC1nYI
	mnF5TXXJ3MfGV+JFGTACl51OIggte7AlGZZS2HZeBFkd6lL+ArE812b6gTUdPraLDYWBi7Ek8Jz
	Fk98JQplcW+it3Sh4ismWIC4h4bnBrwOIWeOF4aYXHaI9H6W6oNV9NfB51CH3k2L7J8sheqlkz4
	UE2aqg0rhu95NtSLvwzBmfGd8pni3V6g6i4ZhcsZc7fVN7HiJGZxbVOOtaQWxcgsPCaNWsJW+tC
	RkUM9gXZ8hRwKz81mBfChWGf96y4Z+4eW1MuewkugZS6fXwgrwW47KXnswD+EGIJEtCXiO221y6
	UEtF0NX7evP94DKapjK
X-Received: by 2002:a05:600c:a00d:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-4804c947d28mr66289775e9.2.1769189066759;
        Fri, 23 Jan 2026 09:24:26 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm8664209f8f.22.2026.01.23.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:24:26 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v6 2/4] layers.schema.json: support 'uri'
Date: Fri, 23 Jan 2026 18:24:20 +0100
Message-ID: <20260123172422.3304682-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 17:24:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18865

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 1a0255435..f42606941 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,6 +46,10 @@
                                 "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                 "type": "string"
                             },
+                            "uri": {
+                                "description": "Specifies the git URI, can be used instead of the more elaborate 'remotes' property when there is only a single URI",
+                                "type": "string"
+                            },
                             "remotes": {
                                 "description": "The dict of git remotes to add to this repository",
                                 "type": "object",
-- 
2.51.0


