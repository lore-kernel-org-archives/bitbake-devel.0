Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4CCCA472
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.52700.1759150599173280629
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yg/t5KPc;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso8731068a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150597; x=1759755397; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/+KkXj+dTvYxpn2pz9NNtOP6iLajjLfsm5Kk4HCxXg=;
        b=Yg/t5KPcs6zvWKz7/yjY4oQVZbZJdtFIwSL6PwNHaBVzFglZrZtMiuurwjPIQg5kY+
         YXU+r0agU7fAXMImD5D1gIMH1O7xlu0AASbca4afn76iP0LFSkC1Dr2mffXuIYUDqJQV
         KmS3GdL5fkyDvKwvsLEy/KDPTDgIhUVJO58XRT3Mz/c6HaSq1VKUC3xY1AZ3/4CqHuCl
         ciUOVMNO7lOyRA8PRWUlWOjODh4/6RUh8+gh7ajwFtneYHBWH0rO/tn4Mrsvv2YsOGGM
         MtbC9eZzbjje/aR3OWbLOaIPNlQNkhPkBcNhul6SogseiYCEiVmud1/x34hMG9naftha
         x43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150597; x=1759755397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/+KkXj+dTvYxpn2pz9NNtOP6iLajjLfsm5Kk4HCxXg=;
        b=KeUWS4tRoFLlp9DnhZFFjVJmCL8hZQMbUcr5ZXZpx+TOcwuTsrKS8h6L2f6g4fAXz3
         6OhEGRYVRTfiln/yYeZOtEoYQiK2mg8py+zh7CZQOCgrUvDsroLDf4U2GQnu521ll3Hv
         XWunTm50GX2KWFgqiUBeR2ZBnQAyaWaY9RQpp2e0HwRiYwPlwvCB3EJL6kE3KSIElcnq
         ZwiV1uxXP4jEEGD+ASFbH/BkNp4Lodia5VFHgYRFA1BtJ72pz1x/kXxFxnnxz3rdqNRf
         PgM2pBcgqymNltsjKr88JGP1YvGvTPfAmRIw03dskFBtBz+KPf150hZAzs4YJFiWgwqw
         vmSQ==
X-Gm-Message-State: AOJu0YzOGLLqwTytpHNSLCkGdShD1d8yRW2DYhNBUrqvfZaOut2PyFEJ
	4xBbKnvh1WGuMLHR0MHPpKzYuVnHt8zskWA8HyYz2qKxb0TGej1/tn0GKL6Rmg==
X-Gm-Gg: ASbGnctBSkAuNbTgwM1iN89vrvTO8PLe5IbWntA/fNDKb7j1oLwes4K8y5LJ0uHWLbA
	T2uD4s4IXlrSNO2Z2LKSQEWSkIinIAbksLw9pdmIAIx7NkjXIBQLGx8FEb9F0a2OxvG/ARg52B7
	DAQX4dfR2HmnzfPpyxn7lDuFgnIHcyjyXOfNoWGm0KQIslR1lqKV09oNIu+oUTMgUbNNv88/vAJ
	J7yPdx7sD4PUKraHHZeeNJj36BUo3q9CuNBsiGhNF9wx+kQjgM75Tmp7cxk2wpchxBkEcXgPmuT
	a9TtUIfYZhV/iYh5B9JEHcz3t/g7WAH7En3UfyEt6O1sDqw5QGvA6sEF3HlId87zkmX1/Ory2Nc
	jkHN5+BPdcbI7P/UUSLh1lw+0o9BXmZeJxGtXNPKTcPbPN9Ul1WKD8uSVe2nxljdgqDGhUh/s3l
	pte4LcEoF13KP1d0ehDoyxS4FQm7RDn416z23csmdWPJqsvB2lHMAxUeawQE7IFnSGz19U
X-Google-Smtp-Source: AGHT+IFOQY01HC5a0dxf5KJ5eHwCtGSickIdM1lPGOZI/26i+XriEvJP+dsiYIcWgIW76SSE89Q5Sg==
X-Received: by 2002:a05:6402:42ce:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-6349fa81093mr16911305a12.19.1759150597481;
        Mon, 29 Sep 2025 05:56:37 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:37 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 08/10] bitbake-setup: Improve the already initialized test
Date: Mon, 29 Sep 2025 14:56:14 +0200
Message-Id: <20250929125616.1751116-8-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18107

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the directory already exists but hasn't been setup, the current test
can fail so improve it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7067cbd4f..ce5cd5e65 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -393,7 +393,7 @@ def init_config(settings, args, d):
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
     builddir = os.path.join(os.path.abspath(args.top_dir), args.build_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
-    if os.path.exists(builddir):
+    if os.path.exists(os.path.join(builddir, "layers")):
         print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
         return
 
@@ -404,7 +404,7 @@ def init_config(settings, args, d):
             exit()
         print()
 
-    os.makedirs(builddir)
+    os.makedirs(builddir, exist_ok=True)
 
     confdir = os.path.join(builddir, "config")
     layerdir = os.path.join(builddir, "layers")
-- 
2.39.5


