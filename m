Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2964CE77180
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 13:46:25 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.11273.1733924782576067531
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 05:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cE57jYh5;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361c705434so5188435e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 05:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733924781; x=1734529581; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBSkf2UIxqgNgJmNP0a0nu9CpEZXAd41aM9ZiN72+p8=;
        b=cE57jYh5aSV4pmTrYuiELzumrbj/uww4BmGtf0i8ylY0w5sBZ2pX0DByowAsuVFKMi
         HHORa6hEfnrRJrbaMwi73rLHm6wilBM3dZYJoBA3KJZVchSwrNJmpY2HdRCJ+2s20vM6
         d+JaX92heH0Zzk6ml6WrZZT1IU6Vs/eVkdWhHqy+dkRQ4AvJcsVhrYLeEV1WNIiDpg/B
         UMFV5C9oHRTc0mOrumiNTlbC98DTNTz7kdrEAKvuawjlf9XPhMbapwHve+hdmVkt0+oZ
         rb2/Tomxv2+vUPUMRLoeEhRV7KYERx0GcwkOyNgwDuxb7cwvQqkV4brbrhsWt2nkNmIW
         gfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924781; x=1734529581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBSkf2UIxqgNgJmNP0a0nu9CpEZXAd41aM9ZiN72+p8=;
        b=GTJuGxsiYaH3NZwoUwnTnt0iqzSiWJHzPaOG1XbzAuVofRzdMd8YWxOkUfqve4EssK
         27na12aCc/+1J/KzZyS1jogsLCahT2L64FQXN4GFfKYtI+coZjiaXX6k5aLRlR1fjQZN
         u95MUxV01zbvv0WbImZME8ddl/PWPA0SvTO182WrHvV3rPEzR4Vqd4GCgI0oKSpuQzBt
         498mK9m2Df5RZiA4PFOr0IRNVdvBSZdwuW5UVbOGN/H/bo+7QkZdYItkj6R1x6Jh2Rhy
         ALafkQWQ95pym2fdoRb4N4x/UR3FNq9NeY6s+vHxSPq8/PO6uCVp/8NgKDKajrVwaDWQ
         N6xQ==
X-Gm-Message-State: AOJu0Yw4fGwWdSO1b56SMoM0hdq1OUURmP1nHuC7Np13S8NJfVt+CFdY
	Nylk+ZGN1IsHFv5/ceTMwSsZvncYGyWciIyhxZWAyr78DP1EtF97bDY2VQ==
X-Gm-Gg: ASbGncsQnmdt6WakkFhae2xM7T+YxPbfSNCdeh83+S6B7Tsx4GDp2DN5IPW77KLxpvp
	DfofNmMH8zJY+CFqhIk85OBriONMgWXfSJaDbsW1bTyXcSj2zjSMwVdHvTEZSj9Ru6iEkEQ4hOB
	0H1WFC1MhhMYgIFJJydyR4cDsUJDMAC/ROeA0HKwPq/vTTkpcr1zeTTIUKevnqHWdxizMBw5qk1
	T4Y9WvPtD7jU8Udfl3Zq2hD9jSEggDyTrpPBpRt4ZZHzrHKix5O537wYrSzAMxCTPgUV/qfNaeG
	5DtOxj5xFOf++Go=
X-Google-Smtp-Source: AGHT+IHDkVzh47/M2L71OVtd56NbLnviYogDP8TrdmLFPnxotjA2RQMm4z0HoxeLcUx3FGNMjKQm/Q==
X-Received: by 2002:a05:600c:5248:b0:434:fbda:1f36 with SMTP id 5b1f17b1804b1-4361c3f4ffemr19469335e9.20.1733924780686;
        Wed, 11 Dec 2024 05:46:20 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ff0e90esm11411035e9.13.2024.12.11.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:46:20 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-user-manual-metadata: add a section about 'addfragments`
Date: Wed, 11 Dec 2024 14:46:15 +0100
Message-Id: <20241211134615.2685951-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211134615.2685951-1-alex.kanavin@gmail.com>
References: <20241211134615.2685951-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 13:46:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16908

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-metadata.rst          | 48 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 40a0c6f02d9..75930fef829 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -754,7 +754,9 @@ share the task.
 This section presents the mechanisms BitBake provides to allow you to
 share functionality between recipes. Specifically, the mechanisms
 include ``include``, ``inherit``, :term:`INHERIT`, and ``require``
-directives.
+directives. There is also a higher-level abstraction called
+``configuration fragments`` that is enabled with ``addfragments``
+directive.
 
 Locating Include and Class Files
 --------------------------------
@@ -962,6 +964,50 @@ the ``autotools`` and ``pkgconfig`` classes::
 
    INHERIT += "autotools pkgconfig"
 
+``addfragments`` Directive
+--------------------------
+
+This directive allows fine-tuning local configurations with configuration
+snippets contained in layers in a structured, controlled way. Typically it would
+go into ``bitbake.conf``, for example::
+
+   addfragments conf/fragments OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS
+
+``addfragments`` takes three parameters:
+
+-  path prefix for fragment files inside the layer file tree that bitbake
+uses to construct full paths to the fragment files
+
+-  name of variable that holds the list of enabled fragments in an
+active build
+
+-  name of variable that contains a list of variable names containing
+fragment-specific metadata (such as descriptions)
+
+This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
+variable like this::
+
+   OE_FRAGMENTS = "core/domain/somefragment core/someotherfragment anotherlayer/anotherdomain/anotherfragment"
+
+Fragment names listed in this variable must be prefixed by the layer name
+where a fragment file is located, defined by :term:`BBFILE_COLLECTIONS` in ``layer.conf``.
+
+The implementation then expands this list into
+:ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
+directives with full paths to respective layers::
+
+   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
+   require /path/to/core-layer/conf/fragments/someotherfragment.conf
+   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
+
+The variable containing a list of fragment metadata variables could look like this::
+
+   OE_FRAGMENTS_METADATA_VARS = "BB_CONF_FRAGMENT_SUMMARY BB_CONF_FRAGMENT_DESCRIPTION"
+
+The implementation will add a flag containing the fragment name to each of those variables
+when parsing fragments, so that the variables are namespaced by fragment name, and do not override
+each other when several fragments are enabled.
+
 Functions
 =========
 
-- 
2.39.5


