Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6CC282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 12:29:00 +0000 (UTC)
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
 by mx.groups.io with SMTP id smtpd.web10.7566.1741696135916220227
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Mar 2025 05:28:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=heycj2gh;
 spf=pass (domain: gmail.com, ip: 209.85.160.196, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-474f0c1e1c6so62514891cf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696135; x=1742300935; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OusRWq5jcQDeiAvkp0hw7ujVTicskQVTa+/EUf4ulmc=;
        b=heycj2ghjCb5fSt6xuGJKH5M19whE5bKa7fddWZKwl8FoKsVCCJ2xXPFNzk69e3HbR
         5SOrtHFD9BPTklIjMaBBemLbuaTdTOzkKmthKI/awvkzMLXSXzLAdxve8mDMZA3ecaBA
         lFg4vq11pl0K3qqkmrLSzzM2A7dKrR5fYh/Q4QWYaxP68Fo0N9d5RgbfhKPKz/mqUX6V
         CYzVnSPm9S/bNYlsGQ4CPZBOhm7Ws2CSIZ059YrolTNsunPvu9dC8wG6IjkDm3sU0LrJ
         XQm8z3MnG9YvIBJvcgXNIYFeV30HwYgzkrXp5ciGBxB19CjKDhoHU9uYw1s5ymSfkSoH
         PBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696135; x=1742300935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OusRWq5jcQDeiAvkp0hw7ujVTicskQVTa+/EUf4ulmc=;
        b=NpsONIu8TK6ecZb5uEn7fLM6rE1Ja+hfn8+L8iRmjU6i9DWaWXBC7A2ocymWEedCND
         IbcZaR/d775NFKj+DtS1oIXoL8wvMcRuNoLXlnuMCF92fH9KI9g7ol2humtyv2XM5kLq
         5+rYFuEiOmHuvxQ26ykds5X6X3ttrkVVGOuQPmh0l+FwmdNjIQUrS3V61qxA/czdhCXl
         DYwgowP/YCT526xKcjXexzvG3eetdSHHHjgDJnRaWJHJt3b5EjuqPuWm0t8MMEl4N5tW
         eY/az3BpVaW9sE8Xzhe6RqHpploQgvvHPNbZRC0yOLtpyk8obyooBBZk2r5mCaZGOrMu
         Gekw==
X-Gm-Message-State: AOJu0YwDpteMEXHs9q1hceEPRt8i/lfYOi4OGq9gYtwMV8Z3YJ2THG14
	XHKhovUkgsPmb2Rb/lMM0GJlqqlEF7vQWZdnlqzW0J4mbFsZ/dgqNjsnKZVp
X-Gm-Gg: ASbGncvvyua4ZHiE20WvJZpWj6hhHy9qA5uO3r5l0g805z1AEo4RLtpjFBEiFtw0fjH
	InruS9PU9uBB2XC8VMdgsG1/kYmATIeBS8U7mPlNvnhCroABeJhcGhgUy3aZ7b1xViOUgiaODf9
	/MkAKgCQJVcWNhB9BxOEta1aSCEHdzi5h1I/Y0PzXn4Foeqq/NDEcGbgSeKeW9+2X0uLDV0Tljm
	db+RWUIJ8hYRE1Iap588JrMsvR+5+CEaWS3PZ3Z0n8Mj1+9IpCcft7KgyVYcvMDmdZfRTJ7iuYn
	BCwdgiJBcz/djC6/Bf7E/tfqZ5kmf/TNLjtlo3JQcQ+GP59YSj0sW1qdiy8Y0jR2Ka87kWKm7VW
	GkGtKHIA1DFYhePByMA5hPPKVSIKS+gnjMqRz7npHDg==
X-Google-Smtp-Source: AGHT+IFEvQ7T78L6G6sRjBttoOpbdTl99ND30twW5HHsi5z3p1Xjl15HS+ueF77cXm5JZeNl2oN4Ow==
X-Received: by 2002:ac8:5a4d:0:b0:476:87f6:3cdf with SMTP id d75a77b69052e-47687f63dc2mr111547581cf.41.1741696134810;
        Tue, 11 Mar 2025 05:28:54 -0700 (PDT)
Received: from 6543eb6661e0.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476905e344esm23876391cf.46.2025.03.11.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:28:54 -0700 (PDT)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers15310@gmail.com>,
	Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>
Subject: [bitbake][styhead][2.10][PATCH v1 1/2] fetch2/npm: Adding npmrc support for private registry authentication
Date: Tue, 11 Mar 2025 12:29:00 +0000
Message-Id: <20250311122901.13820-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311122901.13820-1-eric.meyers@arthrex.com>
References: <20250311122901.13820-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 12:29:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17430

From: Eric Meyers <eric.meyers15310@gmail.com>

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
---
 lib/bb/fetch2/npm.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ac76d64cd..38f460e5b 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -91,6 +91,12 @@ class NpmEnvironment(object):
         self.d = d
 
         self.user_config = tempfile.NamedTemporaryFile(mode="w", buffering=1)
+
+        hn = self._home_npmrc(d)
+        if hn is not None:
+            with open(hn, 'r') as hnf:
+                self.user_config.write(hnf.read())
+
         for key, value in configs:
             self.user_config.write("%s=%s\n" % (key, value))
 
@@ -103,6 +109,15 @@ class NpmEnvironment(object):
         if self.user_config:
             self.user_config.close()
 
+    def _home_npmrc(self, d):
+        """Function to return user's HOME .npmrc file (or None if it doesn't exist)"""
+        home_npmrc_file = os.path.join(os.environ.get("HOME"), ".npmrc")
+        if d.getVar("BB_USE_HOME_NPMRC") == "1" and os.path.exists(home_npmrc_file):
+            bb.warn(f"BB_USE_HOME_NPMRC flag set and valid .npmrc detected - "\
+                    f"npm fetcher will use {home_npmrc_file}")
+            return home_npmrc_file
+        return None
+
     def run(self, cmd, args=None, configs=None, workdir=None):
         """Run npm command in a controlled environment"""
         with tempfile.TemporaryDirectory() as tmpdir:

