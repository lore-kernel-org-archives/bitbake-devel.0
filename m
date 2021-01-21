Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.5370.1611226022128228186
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Jan 2021 02:47:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Qjso2e4B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id i63so1025507wma.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TezxjJLeOEg29RslDM8deT3HToJrIwFmzCmDf8IZqZU=;
        b=Qjso2e4BfsmW90njRC4FO0L6Bs73V16nc8cBic+5DMU3dRPOQUs9syDLqBIMPGmIb0
         6jhHbQtczWUBqSz7zZfrGTuHb9uphu1o2ozCLavObB3bnmVLeiWX7DOvVHS7nBehKydD
         nWmiGIM2j8V5+YjDEBJXSlrO5ieVVApuZ5HvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TezxjJLeOEg29RslDM8deT3HToJrIwFmzCmDf8IZqZU=;
        b=P87QNSERg80czElo31aTcd7bX6/Yp5lNEWN8fu0Wyx/+N7GEmQ7KjugXQxRvC4viBZ
         J+tuLJTk4J/iZ1AeToOdv6beri50tLo9NWFoxXtk9Ql/duMJxvQtgIRnSdOHf9ra6DK0
         hk2exurpnrrUpY8LBURhBCW9wPcAs0utLIsKGPKCb19Z9wsq5yLoQfXrGcBMNWD0khj/
         BziNxsxI0kZqTwfL/C6lmuJ2YF2BZorCaCP/op9Ehok+9MWjl1EegKeBHlAv12RZbuuC
         Gcut0TOvzC6AZMamXLT/dmp70sMewr6Nik8PSCJlMxcn7dAVVRvDHc+XHRUuxDu1/Dbu
         I+Hw==
X-Gm-Message-State: AOAM530fZkEitb2zUVhVOJiF3mUORjyzfrRtjlNQ+Uilbi32w+kBCFNp
	8xfxESajt5bju5YOdafRDD1w520iDXouSA==
X-Google-Smtp-Source: ABdhPJx4nRpUDjzX9+1tvapvc8YNzFz0JEJ9lJK6pcNv5dBeVohE2X9pBDvRCPgQNkwdCecY2KSk0w==
X-Received: by 2002:a1c:149:: with SMTP id 70mr8430423wmb.165.1611226020468;
        Thu, 21 Jan 2021 02:47:00 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:45f8:776c:2038:dccc])
        by smtp.gmail.com with ESMTPSA id g187sm8050293wmf.1.2021.01.21.02.46.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 02:47:00 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/perforce: Fix localfile to include ud.module
Date: Thu, 21 Jan 2021 10:46:59 +0000
Message-Id: <20210121104659.1070834-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Katu Txakur, the output depends on the module path
set so this needs to be accounted for in localfile.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/perforce.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 6f3c95b6ce..da6d337461 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -119,6 +119,7 @@ class Perforce(FetchMethod):
         cleanedpath = ud.path.replace('/...', '').replace('/', '.')
         cleanedhost = ud.host.replace(':', '.')
 
+        cleanedmodule = ""
         # Merge the path and module into the final depot location
         if ud.module:
             if ud.module.find('/') == 0:
@@ -133,7 +134,7 @@ class Perforce(FetchMethod):
 
         ud.setup_revisions(d)
 
-        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, ud.revision))
+        ud.localfile = d.expand('%s_%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, cleandedmodule, ud.revision))
 
     def _buildp4command(self, ud, d, command, depot_filename=None):
         """
-- 
2.27.0

