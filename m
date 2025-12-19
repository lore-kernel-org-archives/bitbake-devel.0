Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F50D767F5
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:43:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15102.1766144592591244609
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:43:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nKiK31Xd;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso11812515e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144591; x=1766749391; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=nKiK31XdAK2j1Tcx6zZk+W3vz8g+PVNSQPscEOU+KmlriV41saRNL7F5SZcXHtX3e2
         oJkhxGL6h/nAqrzzcdC3rF9XW3Dk5P643H6sVcjm34LmupUYUIWoa7MIEsopW4zyPVsJ
         cQqXX6SOi8B2mkqNdyRXzN7ndeyfHaxjs1DVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144591; x=1766749391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jehs/+SvFYY5GvjC7H6J/zAgN0xaZG98RwtnE+BfuXo=;
        b=Tw/JFa2JMR4d+BNuFLmFYBhpkMi0WN8JTD+VIzQ1HtD3suol2HkFwinWNNGa9zebTr
         iJzUeSN27/HF20R3teVWaFtayR+hf9NZX/r17LkKToECDNb2IsW7gDNz1eCU2akWfs60
         GWw0y0cRnPOsVzCT3nxTzsMijfyeyJmyk7lXmpYjfj7HEGSaYYmb0pS45X77oBR+Anzm
         a8fMbJa8vsVbtpP49XNCWWGxf+0rXZOfImKcGpcsBqbRYncA4G8Rm6rdBxFtVBZi+pCi
         zqHUHr/BnxGZgvvsUQH2WcaeS+RKBRYYSFJYy+ddRhJVpulVRrSGEPBZmWtyXV8If8N5
         naHw==
X-Gm-Message-State: AOJu0Ywo5pcKim8lxGwFYYE0hL3otvsr/10twu017887ALCoge6NIgq9
	P3Dh0TSUx9H3jVa8bcCwRi9dt9QR5gUlmQ7BTaF5mUDP9CRDxa8etL2hYskVh3gOgov5o9viRzz
	0vK282eE=
X-Gm-Gg: AY/fxX6SWYvpB1pu0fMZmNIOfEHqZ+YHK4Tl80nqyU4eERPVRjlFGx6B3Ru9UhrmZT2
	DnqKRJ3gnJ4OvOBCz8mPTgKt1lTOOlIQJ2mUletksT9hM0QOs2VQbmHa1ttBAoV4w4M40LuTtIF
	deL3JqDgKuij/7ZTHT8NrzHO+/7v3bjPvYl1uQgjcjdr2z8MSmXQ4WWLMIkUtL+y1fOuvtX8YD4
	ettSeN638jcEgBbYdVpCncJ2/rnZl0tXCsTKopTh4tl0BHIq4uoZLFXZkeRpzqIaMDKpK9uwr65
	LW2raiVqPyZGz42fMXOvrsXTUrDQ6Zso/AdGklPpiQVJhWlg4TluSBhuKHGH18WRlPzvRnrki+y
	0JyhyszoHwEpkXxGVbfXiHjxVZODD6j353IpOaMrCMwnzMZkG8zwGPBQOwLzlXzY8uC0IoZYX1q
	WE1F9z58ev4WRNb/ASzTXybNUyW1vPJtfZ4+LxITX+sVyIICu6mATttsQvsYwzMYq01c09/S30v
	lasbSlElRbeaLCyy9k=
X-Google-Smtp-Source: AGHT+IHelD1OSY+WKPC/D5PsZkwmo14e+lX8FT4dOE/pmWVXjAr7pgEH8Gylhx0YGiVxYumc8/bryQ==
X-Received: by 2002:a05:600c:1ca4:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-47d1953da4dmr25947805e9.12.1766144591040;
        Fri, 19 Dec 2025 03:43:11 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a9687dsm35724665e9.3.2025.12.19.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:43:10 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 2/4] layers.schema.json: support 'uri'
Date: Fri, 19 Dec 2025 12:42:56 +0100
Message-ID: <20251219114258.1574787-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
References: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:43:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18617

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


