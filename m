Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5943C021BF
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 12:47:20 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.web10.4929.1740574039916977242
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 04:47:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=efd69IPV;
 spf=pass (domain: gmail.com, ip: 209.85.222.194, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7c2303a56d6so336937385a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740574039; x=1741178839; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82qdebcOINOuRFC+O6Q6VFG5ncpKspfN6SwXI+Zy8Js=;
        b=efd69IPV7TGTHaVKeB1KBlqLBWYlJJk9RrwoRn2elVkJDdMatZVDtTI32JPSWxMbKj
         DMkVwGvGn8HFu5rlpax+MGN/a6lM0i3CAjIO2y4LKUGy7jCrQlG/3uEELb6Tz6Nr7lFb
         jj2yGV6gAfOXCur0NtZLLqm+Ay1ROpcLYIl4i9V5gE+vTE1lL1SUytZxW257Ei9ZHc57
         kAOt5u6T3iZSf+ti0ghb3U6Zmw12UUrDN+NC9BRpXWsYm95YjBTf8XaHr178m3c5Mkda
         gKuO2Gm4qS8YYNJJYqlAvyd5EwmfEimEMH2HAcXwz3uTHx7tKOCGjfxZSH5BVk/F6n2B
         y3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574039; x=1741178839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82qdebcOINOuRFC+O6Q6VFG5ncpKspfN6SwXI+Zy8Js=;
        b=JqkcHoKlu431MifNXgkNjKnDl2dWFRrnMKNyTxm0dZ8c0L93gAFPZaJpWKUA5UThZs
         r3q4qQ1oXsMeJxNhneR99hJ/6vcBZswiifTph0wrq80J4teNLWJBJ2/qOiz8bVrBg/I5
         Q9tHMxQAHsRBAEHlXmAZuaoXdbKjT2l5XBmSdaqram1REIBAbVWAGISsSAmYNwRGrHxN
         2lnu0kJ+cKTahqrPHGKx+1tRXJUW1QabifFEOjdwzxZkFZabJVc3BOCEp2uoGj7ulDzR
         2HuZYXsoMHBYNF8b9Jk22m+uuIPgtZI4+HwLc4uZR7A6B/5QD1bQ+fUP8sy9SEGAo+l7
         R75g==
X-Gm-Message-State: AOJu0YzmSUaBurXjxRZTqP4nSBJqDfA2ebGHysbtJhMi7TNXybpH0/xY
	hR+ENPOsMWsX8ELLEmXL0KccUlzrbuUWYoqALvHtrDs384RqQJIKQ0EmFVIX
X-Gm-Gg: ASbGncvSDF7J0TG9vFLd4hKRq8rPoIugmkB5ZiFwreFwwKeFUWShjCy1M1khJedov0p
	N2BB2tZKHBFDaiEyHDKLl70P2QrQ7C065ZjuIudPB+TE/XvAsqiV707ZS9MKbNtB4Il3VCpghYK
	YEb9EfmyAeD1o752m2DejvzetuRPc5KSnx7adujzcBMDtaMBkHvWTg6pq6vM/47WmnZouQmLc24
	h0ZtdiCCWvMGjMtveSl7nL3k6Lm0EMTMJJRKUsrAN8QgPuLD7nFVfHvrx6vU5b+nwpYKY8EgsWK
	i0Q5EzJQTh1rdi2n3Mz3H11jx0hd7QIBDQsd5LmoaOb6kpMHfSRnvDLWMlwSLkukZfpO3QaFDR2
	R6jcXopKsDYYpDg4FsknOW3Y=
X-Google-Smtp-Source: AGHT+IFJnVNxQVa45ssRNqN7/feHRPvs3mwcHFKNlDIXkKHRk4UX3y6seFzhyyGewUTX71zUxmQOTA==
X-Received: by 2002:a05:620a:260b:b0:7c0:b1aa:ba49 with SMTP id af79cd13be357-7c0cf8eb137mr2993471085a.30.1740574038710;
        Wed, 26 Feb 2025 04:47:18 -0800 (PST)
Received: from d6f1eae97500.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c29a8eesm236960585a.21.2025.02.26.04.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:47:18 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: [PATCH v3 1/1] fetch2/npm: Adding npmrc support for private registry authentication
Date: Wed, 26 Feb 2025 12:47:20 +0000
Message-Id: <20250226124720.6462-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226124720.6462-1-eric.meyers@arthrex.com>
References: <20250226124720.6462-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 12:47:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17329

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
---
 lib/bb/fetch2/npm.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index c09f05044..7486049b8 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -107,6 +107,22 @@ class NpmEnvironment(object):
         """Run npm command in a controlled environment"""
         with tempfile.TemporaryDirectory() as tmpdir:
             d = bb.data.createCopy(self.d)
+
+            # If the user opts to use their own NPMRC file, then use it within the NPM environment
+            # (along with the user provided configs). Otherwise, leave it blank.
+            if d.getVar("BB_USE_HOME_NPMRC_FILE") == "1":
+                home_npmrc_file = os.path.join(os.environ.get("HOME"), ".npmrc")
+                tmp_npmrc_file = os.path.join(tmpdir, ".npmrc")
+                bb.warn("BB_USE_HOME_NPMRC_FILE flag is set - NPM fetcher will now use the .npmrc file in the HOME directory.")
+                if os.path.exists(home_npmrc_file):
+                    bb.utils.copyfile(home_npmrc_file, tmp_npmrc_file)
+                    # Still need to append the contents of the user config created in __init__
+                    with open(tmp_npmrc_file, 'a') as t:
+                        with open(self.user_config.name, 'r') as u:
+                            t.write(u.read())
+                            t.flush()
+                    self.user_config.name = tmp_npmrc_file
+
             d.setVar("PATH", d.getVar("PATH"))  # PATH might contain $HOME - evaluate it before patching
             d.setVar("HOME", tmpdir)
 

