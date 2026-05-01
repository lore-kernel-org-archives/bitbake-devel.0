Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41630CD3429
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:14:51 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10756.1777626884318034605
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:14:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=feB5cecH;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso20812685e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626882; x=1778231682; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPYOvIXYVVLcRB7cc8+Q6H0pGIMrwUSocsGb/HeRdXE=;
        b=feB5cecH1/u7/h/sAdYdJjEaYkuzK7qpZS7+auQVIXZ3ID77xRuPF+vvjselLvYoZF
         7FKr2AeiD4BN3OcRtVpRlcjIi/RLOa/l7k2dyHrTe0O1A3Y+Sw4QZdih7Yqz9D2FTzZ9
         43YW4E/hutAenfzHbi1L4/NwXSyRLZ1vzT/I+n891ZY60Fk7RbQb4IgiLlhyK6F9CrNf
         1wmAu1uwjFIpoeBNKWCMfogRfl9cfLTmlJQztMn0ny0Ez3eq1FnCX4nCmKaq1NT1fzvh
         /0MlwxhdoptGCXiFvG1rfaz66eCIgSj6kEUtxTAvLlTXw+8zHgP+tIQpbfZh/ZEBhtmA
         muDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626882; x=1778231682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPYOvIXYVVLcRB7cc8+Q6H0pGIMrwUSocsGb/HeRdXE=;
        b=U4f5jCa8ZgIA8sSzNhyzCokUzaAk4967tJsJbMiDoIKAyqKVC2AeRpieqMVhFhDPDT
         R468xjcWW+8rRt3pEKsvT8hYlbkaheRWllwIcyxqs7OKBxB4jVqjjtJO66QyEPJm8tKo
         gfkuCqDdV1azwlvMi2/cw5GH64mD7mjK2X+3slOqASZ+MENBGGpl23sYFRc+eiVEQKn/
         qRBM/L4vWdBn0E9SvFwgYhHrzyialiNzIjnRmwTM0j5ENh5XV2aHsCIaeerQ/nhUo1hr
         lxrjGJwc2DNvjweT1hER7C5gXmQ/F2QhWdCMjyjfdyhPD0PDSWsfmXdL7logL1xZddU1
         uD4Q==
X-Gm-Message-State: AOJu0YxiKcfYYux+lUrFlB0/VIxMAMtPdzm5BX2jGbrhGLipKaPCrwWY
	5oYCvJVQjqWgz2GpkpH66QSX7ait+XCyyxwYn8T8L8edOd+RR4x3M/mNuJ0H1UuGs0Y=
X-Gm-Gg: AeBDiesG4CdrriKwznGaC/KyL4j4IBdFaF4/vDjUxTG3ridqhkMrT0fzeOzLxo1WA+Q
	QMYtOOi7PHK0FdXjDajWbQoIsZGRX0H4tebSLfyqjh/trtFH5YRm5wSC9/U71FWkcKf2ABCuzHc
	nTuEKbBH2LbOma9fsYmk7Ruk9ONmOrUQT/2coB2UJiuVrXW+CXAA5WbiYhBeck7WrDRt848gs/F
	4ciJcwnDVT+1A7p81/+W0oUis9Vzz3/weeLSe7fi6MoJ00tHHmos4AvVCden8u4b3o7/DA6WioW
	V8CiSs4+jsRBKy2gAU8LLbEFLcUM4f6gKwWzzmOZNKmwnkOMT67Q70NxvJKby/X2c0TQ1WUHFbP
	lhKxKPG1dge6gQGpPPSfXfrA9Zr6J0368Tc4O402Q29Czvu3roYI5lvLxVCqthPwa78BjZABlZm
	rSw0nvEzVjrWEfZU+wu3X3jBRuaJYWxvlh31Hr6KSI9Z7Wgd2MHAuWob3v0i/jMJJk6ioEaeQOx
	4faJma6bVkyy24Io4Zp86NXiq8QoRsduKSVAdFYKsKy/alvaouxJLomPX2FKIk=
X-Received: by 2002:a05:600c:c058:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48a83d6f154mr79813585e9.9.1777626882376;
        Fri, 01 May 2026 02:14:42 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:6a5d:7450:e8b3:758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm12097955e9.2.2026.05.01.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:14:41 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v2 4/4] doc: bitbake-user-manual-metadata: move inline python examples to inherit section
Date: Fri,  1 May 2026 11:14:18 +0200
Message-ID: <20260501091418.76994-5-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501091418.76994-1-bijak.dawid@gmail.com>
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19429

The two inline Python examples,

  inherit_defer ${@'classname' if condition else ''}
  inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}

are presented as inherit_defer-specific techniques, but they work
with plain inherit too. Their placement under
inherit_defer suggests deferred evaluation is required, which is
not the case: the ${@...} expression is evaluated when the
inherit line is parsed in both forms.

Move the inline Python expression examples from the inherit_defer section
up to the inherit section, since they apply to both directives.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c7c3ff99..4b1aeedc1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -803,7 +803,17 @@ An advantage with the inherit directive as compared to both the
 :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
 directives is that you can inherit class files conditionally. You can
 accomplish this by using a variable expression after the ``inherit``
-statement.
+statement, as in::
+
+   inherit ${@'classname' if condition else ''}
+
+Or::
+
+   inherit ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
+
+In both cases, if the expression evaluates to an
+empty string, the statement does not trigger a syntax error because it
+becomes a no-op.
 
 For inheriting classes conditionally, using the :ref:`inherit_defer
 <ref-bitbake-user-manual-metadata-inherit-defer>` directive is advised as
@@ -840,19 +850,6 @@ defers the evaluation of ``${VARNAME}`` until the end of
 parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARNAME}``
 expands to ``myclass``, which is then inherited.
 
-Alternatively, you could use an inline Python expression in the
-following form::
-
-   inherit_defer ${@'classname' if condition else ''}
-
-Or::
-
-   inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
-
-In all cases, if the expression evaluates to an
-empty string, the statement does not trigger a syntax error because it
-becomes a no-op.
-
 See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
 ``inherit`` calls to ``inherit_defer``.
 
-- 
2.48.1


