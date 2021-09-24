Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web12.8906.1632493342443256912
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=wwtxTqIn;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id t4so6636370plo.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bh89hzfdTkm9CaSYw91trBjCzKYVTcWViLpORIlnb4s=;
        b=wwtxTqInktTs1ZVBAlGUmvbcMjQev4w09bVfF9YC3ybAfWAPPdJwgBZ8z5EE/a78G5
         DmLAjzfmgre7R0ctM3xRkoW0yQHVF4oUEF/ErspgcGPbxGSNri4AFcotCq6ezeiSNk/w
         zOfqdGO8SyKiVqZmvcgw2XEc2eGeG7FQLuK6tx4tzpj1xEQwBET0k7GDwEA//WiIkB+c
         uPBhxLmDF5NRQF/OGYM0STynq73yUaw3ssi6DTzHxxmAQY/0nzJPIk06NhO7U0A1Qamf
         sXroda/E0cWzY8vzp/yZHcS1kHW+ZufDH7a5VZEzVU0CjQiDye4Bj0LLsuDLQjHV/Omy
         zIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bh89hzfdTkm9CaSYw91trBjCzKYVTcWViLpORIlnb4s=;
        b=3gRQYcfzNBYEUsh0QuaW5CRHb0qMuKik7XUD7INyj4WQSt4M0jxza/JGjau+la9pAX
         FcxSn0tfHc6G0ZPAsAUEIP5SdeFclzay8pLNE3v5BN9CIC/abSY/fSeQ5waaWHYMeKx7
         RqotbT7e407q5iulJ7HhJLRmse4CXMac35bA6Atk9Xwj56m60x88u5d0IvKW714l7rix
         wz35hEKVVzz0+AEtrHTG0u7cOSzIvM/mRPwXDVkrf18MgEfxPJS3NuXAZZ4Qme5MZQDB
         BbeRVqHc2uKV1atKc91ylJJ01qX0YR5x7e9CXudeCGBSAg+kcM5nNXZHVA6lRDjFID+h
         eAEg==
X-Gm-Message-State: AOAM5323efcW673N876cYylR8sNldYvJzi44p6e1JFh4Fgb88h1v0wIJ
	H8qK8yhu8I1aJiDzCgukGr/ZWvkZsF1z0JziCe0=
X-Google-Smtp-Source: ABdhPJwkCfxO+TnqfzIHGOoGTE/AQxapql2Cwi89jmXg3I9r17A1uNFtzw5ldvLeHbwm1hylw+Y+SA==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr2592107pjb.206.1632493341436;
        Fri, 24 Sep 2021 07:22:21 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:20 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 03/14] ui/taskexp: Fix to work with empty build directories
Date: Fri, 24 Sep 2021 04:20:56 -1000
Message-Id: <741837b7ceec45a098425954ebb4533f816b8549.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If run on an empty build directory, taskexp wasn't working as it didn't
send the current environment to the server. This means HOSTTOOLS in oe-core
couldn't be built and gave an error. Add the missing updateToServer call in.

[YOCTO #14408]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 06a0bbe746f879ae539223e7fdb6f07d55d13719)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/taskexp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 81392977..c00eaf66 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -197,6 +197,7 @@ def main(server, eventHandler, params):
     gtkgui.start()
 
     try:
+        params.updateToServer(server, os.environ.copy())
         params.updateFromServer(server)
         cmdline = params.parseActions()
         if not cmdline:
-- 
2.25.1

