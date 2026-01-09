Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF04D1A61E
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:20:18 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9817.1767964808674647659
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:20:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JOB8Isgt;
 spf=pass (domain: gmail.com, ip: 209.85.128.66, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so32028825e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964807; x=1768569607; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHwj1MYlmFXdhER1JtffzSMeZjAz69yHCY9L82g67wo=;
        b=JOB8Isgtx7MFPJkJN4L2pu4liZT2Nfh8JF5huaVGpjW2MaEJlFSD0sqzJYZb6CTaoy
         9C2d4hgPjwOjKK0QfizVefaEQTjAVsoIFOX2whtaW3Vp3qU+0yVOGEgUdLoJygXQ/OMj
         JJhKniKYJ1RECgE4M8XdZlcqJS3nmLCVlLd3jqgZZtG6Av7ofXwZ2551sDwofZB4+sVx
         mOLbZYwV+Iz5iVt0bUGigR7cvwXjExLVARIWzszg0hXhtECe3GkM/RatEgy5bDxQdQHB
         A0G9weSZ+sOnX7PIRKXghvEGZA4hLjzqMvEntcakIe7/r0d0nZN2DxkhzR0duZgVNkCX
         /WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964807; x=1768569607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHwj1MYlmFXdhER1JtffzSMeZjAz69yHCY9L82g67wo=;
        b=cOlwURDyYpy+6TqP2IU9WBoiKKFrivj6GDnC1qUJhSb8WkPqtjxZQpJfWQ/F6b0QW0
         FBhcYDH72wbYIcemMKGJdYMybJgPYS4admVBZaQyjpDOwodam4gAyB9q0gDhdsL5l5Kb
         pknS8TcJIJ98J2dQtPMReTR1MHsW+9GIujAXZ18CORm+CXe8ZsbsWrrjN1DDTMAcwJ6B
         Z0AZF5djgWGNFRf+BAwZ302JHhoLD40CBa2bLS6b/t/6zns8gW8k79PAvSeYpMPzfRzZ
         LAmouAVISe8D95RrK9zvTgXKQRpqv4EHoICcpuL2UUQCPdsx7DriJIxUaySrjeSzv4Dt
         GBVw==
X-Gm-Message-State: AOJu0Yx7KXglCMOto29iV9myxZuIKxOejYCL0wMxjaL9XyqE90HESw/h
	KISODFudZqNVq+/OjMfiJ9B5+0HhgkgrbVwJpa8H/P+pH9qSTdxJxkGzqJ3lq3Io
X-Gm-Gg: AY/fxX5lCuhTvSn2oKgBSEcw5ypPIDB+nS2vKwFqxDo8uIUy8oK/Ds/U3bYEtT8YeYM
	OSX6Hm2mP4IBpYdfv6Gx2CR+l8Gt5rEaRip0AFOYZ5Ojpum7iBAyHRnVw5WOIP9t29PklART4GE
	+6HuVA1Il29zWdmrozpKRa6AhlxIbZ3hRxDCGGgHUQ+Ql0VrjOPa3TCBS/pDIhNgf7/A4E/EG0T
	I9WpB9Lqc6P8GgwmBAMYWVh93zzy79xONF3/ggL5AsEmJi7gkD4bqCNOIe6XcqHPYKM5PwGDw3Y
	ECt5F110JfgSK4e3MMJi7sV7cJAlURWX01gS68Y6jBlRg1xNuBupvhINUnKK6fscrTXu7pImFSU
	BBL0B5Ei73eynJ46RzhuugieGEJHShStl2d/kNz6FDL98sX2Co0X5VWJh3YyVfOIb20XB+/pf2W
	qEOkNMT/SKpJWBw2X5CL13c3YxWgjhaS+j6h8G4oZwwEFdYPM=
X-Google-Smtp-Source: AGHT+IGY4s053tgDg/sdDA+MUMsEq7zYH55Zh6lJePQLo7LzyY0MeJULTphXyNCptfU/VBq8XcdoQQ==
X-Received: by 2002:a05:600c:5306:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47d84b0a992mr88172725e9.6.1767964806843;
        Fri, 09 Jan 2026 05:20:06 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm202291505e9.5.2026.01.09.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:20:06 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/5] doc: document fixed revisions override in bitbake-setup manual
Date: Fri,  9 Jan 2026 14:19:56 +0100
Message-ID: <20260109132000.2372791-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:20:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18723

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-environment-setup.rst | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..fcffab812 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -938,3 +938,51 @@ Here is an example file that overrides the branch of the BitBake repository to
 -  The ``sources`` section contains the same options as the ``sources`` option
    of a :term:`Generic Configuration` file. See the
    :ref:`ref-bbsetup-section-config-reference` section for more information.
+
+.. _ref-bbsetup-fixed-revisions:
+
+Fixed source revisions
+======================
+
+:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
+Bitbake-setup will make sure the actual revision will match the tag or branch when performing
+initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
+file.
+
+This file is named ``sources-fixed-revisions.json`` and is available in ``layers/``
+under the :term:`Setup` directory (as well as under ``config/`` for backwards compatibility).
+It can be used to keep record of what was checked out when using configurations that do not
+specify exact revisions.
+
+Also, as it is an override file, it can be combined with the original configurations
+to initialize a setup in a reproducible way that guarantees an exact, never-changing
+set of revisions, by using the ``--source-overrides`` option of the
+:ref:`ref-bbsetup-command-init` command.
+
+For example if the original configuration had specified only a master branch
+for a source::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "master"
+     }
+
+
+the override will contain the exact revisions::
+
+     "bitbake": {
+         "git-remote": {
+             "remotes": {
+                 "origin": {
+                     "uri": "https://git.openembedded.org/bitbake"
+                 }
+             },
+             "branch": "master",
+             "rev": "720df1a53452983c1c832f624490e255cf389204"
+     }
-- 
2.47.3


