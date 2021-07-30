Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.24083.1627652830400279557
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 06:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MlsfiJW+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id c16so11374354wrp.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9HBInaSkgYke8wgT5nCXNAko8YCXhP9NmN1mCbB+gYY=;
        b=MlsfiJW+mP7kUMfn2LX5o9qsjK83ic+iIc3XZC67ryCm50tcKCKG2hNG7Na/DIzFwY
         6tuDNEl4dq2DWwrQkLRPVCYl5pA8AxP12KKpGY3+GARenDBdLMYswzF8M+YAEqjkOX+J
         qb3oK3Jv9JuqQdS23EFBwLddiY14XrV+APxO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HBInaSkgYke8wgT5nCXNAko8YCXhP9NmN1mCbB+gYY=;
        b=jxox5AWJyoLZqtktO4xfb29b4e9c8m6c/KrwaHnTyZ9fQewAtajVLjRhU71Dqf5e5q
         tnTkYzA3lhOp58VbpOvPj0GOYOgJPTpmSLwyeg5iMXTQDfoP46zvmib+bh8g4fB789Nw
         TZYdG4hwl5S483nb4MhfREJAwTKjV7o22qPQOers0o5ASNc0mipoOf0KvU5I0hPeZ6cl
         F5abBCzXnvYXEFuELe50Q+iPHQjfBJ8Ng+g4aXqzImPUof8WjZLupGwfSn2bhjniP/b5
         5sD7W+g/vRA9arOX2hAPoJ1wK7zV3YRky5e61gGccZlGYYnh62GNNYRVgsmnwh4Yl88b
         ag4Q==
X-Gm-Message-State: AOAM5320Gk5/SxVotZXgFAcc5V8ZAmUEb2Su4ZnHdM3wR/ckfmqbmnnv
	vU4TGC13EVK6KkTVop6JD6hxVmsvvf8CoA==
X-Google-Smtp-Source: ABdhPJzolMXfa5VXi8zVjNw/PS5OKtlPlRZ7pZDBWzCtZ6/1qb/NsJCjb8A+0BB5Ohm/PVHM5rW2yg==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr3110493wrp.89.1627652828934;
        Fri, 30 Jul 2021 06:47:08 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id p3sm1965969wmp.25.2021.07.30.06.47.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:47:08 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] bitbake: Update to version 1.51.1
Date: Fri, 30 Jul 2021 14:47:06 +0100
Message-Id: <20210730134706.3360651-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f0ff2400fc..dc1873af69 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -26,7 +26,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
-__version__ = "1.51.0"
+__version__ = "1.51.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index a144bd609a..c1e30697b3 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "1.51.0"
+__version__ = "1.51.1"
 
 import sys
 if sys.version_info < (3, 5, 0):
-- 
2.30.2

