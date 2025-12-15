Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64393D5B172
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 10:33:14 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45579.1765794790958399885
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 02:33:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VTU66pya;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc3056afso1185556f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765794789; x=1766399589; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pDTLoyAuxv7tabgJuNtxPmm8pbht4+bTuOH3XMaYu8=;
        b=VTU66pya4EL14yROrG+RYoSK9lGMY6AD3B4C3jkThKJSHY0GODrF2lLr9gjF/XAfA0
         9/PAFfZbiUftLyhBS0UgSfAgDUQpW3pgZX7yIja1Bqoq69drbERNFZvDPyFQV4mnzc4G
         XSYaKCeTJOnysq5ZN+lU8xAFChQ0RGVRIUPK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765794789; x=1766399589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pDTLoyAuxv7tabgJuNtxPmm8pbht4+bTuOH3XMaYu8=;
        b=kShTYzaYXw0mMyPFJdyJjefTSnNMISfULh6IeIwYb+D1+I1+uqhyHNGq1TUXVph5vq
         eXGt71prSV4PwlFcu+7one7q4Nlgt2A/DAnXk0wH2O+/Iuemd5r/EAQz+CyKn0kN+bgK
         SHcrl5fUHteOXxYs1rx+aKK8rJ8jB42iAe2pIngjrOeFSVdTNfT02l6C3JZk6Zd85ixW
         +CyLG32cox6q2i/3I8rGOEl0LCOPpmb07lsQzIBnHLQ4bP31aktpIS8HBvNLwelumOzd
         7z/dou5KhtU18hjolYALbQ0e+mM2DijWTfv+lRrakEhFl3+TshvPI59kTnBCboOYArJ9
         98SA==
X-Gm-Message-State: AOJu0YwcX3zVMQZgMcZh0TD7OxyFk0tC14z2eOtN/b40pZ9vow3MQpLL
	YZMoGxnfsKH68qjlvbo8w5haQWJd17tcRzwI7vivuGhXoemtNXYWZqbn2O3uyNgqvsZUUkKbw2I
	1ThzX1ig=
X-Gm-Gg: AY/fxX7jCm7fSfoF7ri1Ff1AJ9t3XpFJNKEQb9zW4VfD5we/x+huDnPQ4DJ67e2EHk4
	nRBzGiVFhDei/WGa2mROpenFYxJB9lHmOohf9ymD0uWm9ZBxh8u6JdLfhJJGdMdaFQ+Oo64aItx
	9zqNjOK30xeM3XXA3iR0sBQiKDDiRbFG+Py1Jg/nljyfcPgxfOGXnIK46eSlx8u0cJKRnuFbvmo
	QnVengEeTcWOHHc6J6Iyfrt1Mazg19G9WFw+KcW+6I4vWU1rwyWarQfPYqi9s5sEIi6mKXY0fk2
	RDCWNh7ykmOHfs79qhDEThAfpRUTXxl3ADpNvSfNpVFgeHVd+kPB+LeJe/iGuB0LhEnkJ6R5ufW
	t2t+wHs7kdgJHDpO5fkHREnWVMJ+UYVlVbF1arfw5nlCSh+aBs1HLBJA4cEygOrsxze6PKRM2jK
	jG0DYJFawuWt8jMvJ8a6Jhdtofc4UWog7ZnuwwmoHf9k1M0uLyT3alOZae9nnNBGAXZjQwNoWy0
	+HnQe9sMOkUX/a1ZZo=
X-Google-Smtp-Source: AGHT+IEew2QT3pxKePSa2wIf6GCm9Xg39jH6f1KmaN2327XJT+e57fnQ3tCNxKuj4I5lb+/WfihueA==
X-Received: by 2002:a05:6000:611:b0:42b:5448:7b1a with SMTP id ffacd0b85a97d-42fb44ed6c2mr12270094f8f.39.1765794789281;
        Mon, 15 Dec 2025 02:33:09 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85d1esm28676257f8f.26.2025.12.15.02.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:33:09 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v2 2/3] layers.schema.json: support 'uri'
Date: Mon, 15 Dec 2025 11:32:55 +0100
Message-ID: <20251215103256.902711-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215103256.902711-1-corentin.guillevic@smile.fr>
References: <20251215103256.902711-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 10:33:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18585

The property 'uri', which is a shortcut for 'remotes/origin/uri', is now
supported under 'git-remote'.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 setup-schema/layers.schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 144ea6d9f..8fef1efe6 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -46,6 +46,10 @@
                                         "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
                                         "type": "string"
                                     },
+                                    "uri": {
+                                        "description": "Shorcut for the URI",
+                                        "type": "string"
+                                    },
                                     "remotes": {
                                         "description": "The dict of git remotes to add to this repository",
                                         "type": "object",
-- 
2.51.0


