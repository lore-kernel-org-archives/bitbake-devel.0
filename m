Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D0C282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:01:48 +0000 (UTC)
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
 by mx.groups.io with SMTP id smtpd.web11.14765.1740747698824769488
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 05:01:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PNuNGS7j;
 spf=pass (domain: gmail.com, ip: 209.85.219.65, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6e41e17645dso21373906d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740747697; x=1741352497; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsQNB/yENN8fk3FCx6TxLKUCIf8IDUQNN2GpMXlWb/Q=;
        b=PNuNGS7jRbWXp/kL6dsX8aCRc0ehGCFNZ54uLTykwSMnYgGtceH6UVv32o+6XBf8+p
         yrlmHJeGst11CdLOKBf/UfKj451KDcDXE1nBYSK9YvKkRiIlmPcAJ64FjsdMnwT9b9BI
         LO7OuTJXUQcgUYZNynHJj15FashTKa7Pt1TcY7jG4vzISie4e9TUedWOg5n4PuuZ2TbF
         B1smwAsOSpE88n4v3UQ94YJFbVY/q1ipVOfs2QFxlejCqFVPUQ4rB8+sAttZ3eEbEGNA
         270Nb06vKMPKon1+ps7YWWb1wc7VPzaV+noy+/F5VXvRmBAgMsJim/U7mfRAuYfS/c5u
         U8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747697; x=1741352497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsQNB/yENN8fk3FCx6TxLKUCIf8IDUQNN2GpMXlWb/Q=;
        b=VjLRBRxgCdwpvHYpt2RLsMSOKG3YvRsnuaYOR/eTUxESESwwsF0Ku+WV6sw2F1v2+9
         +onyb65uaa0kjGIzPkRou0LHYn071sc2MahhmZhZtkcH5Jrm780c2iF7m9Y2zUEc75k0
         M3KHrppMtCmb4SbQvlm4PUyrFi2dvYN3cgq1lPYihZUFqlXyrdi0dXZ0DI6OxNxLsQ2W
         C4zUOBQAq8mtjDnh9eG3o6YGqqLdfN4dfd//gEGbuUJD4gUT7lWwAwQ9T3IJm+jSN1c5
         /75dXV5kx6KPNwPvIST7c7Qmwmx8KqM4dkFa+wzxSESAHBTVE3usLZFyk0j+Z8j66Fnj
         7wTA==
X-Gm-Message-State: AOJu0Yyqxv8vQ17wRVLYvpgGDQLcukcNbe13+6t1O+9+UuXpm6/7zRlg
	Sns7Nlo1B0T9zVpeQZXjjwOuABjhAUnqp2n3D5UY2xyu5RMpOUGMafcAOaPH
X-Gm-Gg: ASbGncsMeDIEDwSaXNhVunYJCwQJV9xd/4TG5tNXJTg0jHMsr1k76H2d6fU3K+ZI/23
	eYcfYwdjtKjJebqAKwPooXzkEYXFt3iFPaDnqD7OZc+piOQvbP7oEEuQMMOKSUGENbMPm7jvMsR
	lSSpuPWc5g1vUabG3rUED/N1wuNAGR2hed/tKqzOlvJk9/kHRzaRJHe/T7lI0kSGnqMEI5Khakr
	WgJ2VAEfd7ReDLH7h6J4Iv/ctdevkn718RRHl+K9oeRqdu+foY4+96Hwc0IU2AHbKOY1NrULwcm
	lrtvWclRHjImsZllsCDohfetQM8YFR22TImdLYaKszXijOLjUGRHpp/IbpddN8hDBCqVIMFezhV
	UimpYDTHgwDSck2zO/dNm
X-Google-Smtp-Source: AGHT+IHDl+0CHEAlpv4ozirXgQpUEUluFuvC9TdGjupSBIo/PbaCw0PnjaOMgr947RXgTLaKcpq3gg==
X-Received: by 2002:a05:6214:2462:b0:6e6:69d8:6c16 with SMTP id 6a1803df08f44-6e8a0d6d8f5mr54364216d6.35.1740747697470;
        Fri, 28 Feb 2025 05:01:37 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da32esm21749406d6.110.2025.02.28.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:01:36 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: [PATCH v5 1/2] fetch2/npm: Adding npmrc support for private registry authentication
Date: Fri, 28 Feb 2025 07:01:36 -0600
Message-Id: <20250228130137.400-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228130137.400-1-eric.meyers@arthrex.com>
References: <20250228130137.400-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 13:01:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17359

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
---
 lib/bb/fetch2/npm.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index c09f05044..e469d6676 100644
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

