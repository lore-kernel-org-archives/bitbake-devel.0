Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D9CCD18E
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 17:47:52 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.23345.1760291270501778433
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 10:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R398z2Um;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-41174604d88so1532160f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291269; x=1760896069; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKIp9CN5M0tlAZ1XyKY84oNG4druI+nMIU9thc5s1D4=;
        b=R398z2Umj6UnRBxtWSYk3Dfut+kqHYghTdlsEmvpHCkZTRGNIw4lJVqX+c6VSbubik
         ShUwwhf7K8s41uQluFRgmJPsaTrZn2os7HxxxMDjnsY9PFt+LDzF0SqVn+AE0d9CMDvl
         o2G/SJOjp3Mayeb/rIDEJuFpCdUfBhB24qsJ2r3lK73wlgh09QvZO7A8HmK20RR2zoCQ
         nG2h0Hqi3SJUbOA9GccV44PlPejg2015aH3rVc8rDguXk9oFreiabb0Axc6zJuj1HN5a
         6Z6gPvwG/9/UaWUIqNBRRwr4rhtJ5MzeoYoRRXlG/Ta7iCfwfZqQOe24oE0Z5MXOzmve
         Gc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291269; x=1760896069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKIp9CN5M0tlAZ1XyKY84oNG4druI+nMIU9thc5s1D4=;
        b=Nu6jtUImthz2InAQccarn5wmRX7KzhQ7aCf+nNRzFg7oLf/PwXSQcowAdK0UFnZuvL
         RHecQW2fr/kXQW8rLIIzIKfWrBANQJ3I7hi/sI9MDBHOX1DESOJGqUtDl4vw1Tn7Dpib
         S9L/LAUEbjqYC+gHcN6HCZOD5jaMD02r+U6Q5TPRF+Y3zBMW8NwoyKgJ6jBxiG/V7tr0
         flu9e0twVKZRmAQDJDll4rINQVvcxoik+mT7ZQZf3SX18Iw9XT+1xtuJrfImZqRDKd54
         WRUJLLsHpvlr+8qo9ZoWXj56MCt491q4QIDfSLSk0sjosG/A7q8rM8ekL2eAsnBKMeCw
         fgFQ==
X-Gm-Message-State: AOJu0YwX3/TPoID0PbNdYx2a1IRsShsFvKpUBvv0zBCAct+DsisKSLS6
	fPiMnutif5Cms4a0clkCp2VuYxchl2P8FYXEWxrh6rf1t2k9CVJwUWUilxVDgA==
X-Gm-Gg: ASbGnctDGBr7e5Q5SZGXnmrJCTb9PaUQ1dG0A1UKn1S9R90X3QvnxZ5H4wWKR4/XHZm
	D0rguOaHeRGy0q/VMul3T0mHEZ/whuDUbcD/rSXcu+GAkICvT6YGgSWpZanOh+osGuGUGqVJlKu
	eBDyPoW2+EPU+UgYSUhn4DEl8TZ8ov9Yrc9927jlOrRvGs1TUFjPjkTKHUTGq0MMfQYOIR6x1UP
	UHlQ+Ptv2CzKX/pvos0BwsHq59GEa8QIb9nPOnbtP78BCubXYhE8GZkK6AgNGKK9gMo74dp8huI
	6B3kjRfaKRB1GqIDDZc9o2EDquXkAdy89rHj3T4R/3P/7q0EXoIEoZ3W/blsvoLhdJ3FKn4l/kb
	Rf9PF17aWVmRdJELbQYI9BzdxU2/q+1x37rKKASaNYtT4C+ISs9Np2ThRrwAHnK58p/ujxl8+rb
	N0jALFbPUqTiuQmVi5ERGEJwQdfdB242yxtcOcDuPPa1GlIIqmF6CTFkjONO0T0WoRDI9EU9rmU
	yHnTpMkzrQRvQ0=
X-Google-Smtp-Source: AGHT+IHmT2NcmxWWIkgo9o+2RbqSIEcksG3Y6myLZKjG2uC4nmEYE3KKaqDNU+wxEcnxmzkhPOSShA==
X-Received: by 2002:a05:6000:1887:b0:3eb:8395:e2e0 with SMTP id ffacd0b85a97d-4266e8de16amr11387157f8f.51.1760291268808;
        Sun, 12 Oct 2025 10:47:48 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm14170160f8f.17.2025.10.12.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:47:48 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 2/5] bitbake-setup: init: suggest removing a partially initialized top-dir
Date: Sun, 12 Oct 2025 19:47:24 +0200
Message-Id: <20251012174727.4191604-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251012174727.4191604-1-alex.kanavin@gmail.com>
References: <20251012174727.4191604-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 17:47:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18176

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

In cases where the first call to 'init' failed or was aborted before
creating the 'build/init-build-env' has been created, a user can get
stuck: a second call to init aborts, suggesting 'status' or 'update'
but these to refuse because the --build-dir is not valid.

Guide the user by adding a suggestion to start over from scratch.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index f24d39481..cb10b41d4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -443,7 +443,7 @@ def init_config(top_dir, settings, args, d):
 
     builddir = os.path.join(os.path.abspath(top_dir), args.build_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
     if os.path.exists(os.path.join(builddir, "layers")):
-        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
+        print(f"Build already initialized in:\n    {builddir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize a build in this directory, remove it, and run 'bitbake-setup init' again.")
         return
 
     print("Initializing a build in\n    {}".format(builddir))
-- 
2.39.5


