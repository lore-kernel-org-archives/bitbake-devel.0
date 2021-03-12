Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.9882.1615562919825513741
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Mar 2021 07:28:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hX1kupjw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id x16so2005245wrn.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Mar 2021 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sP51AdiVP4FrrxLaGyCRZ+4BTQGweHpreIrWUeYYPKo=;
        b=hX1kupjwfeA1YJmtdsU2kdBMp8qs8/0ijWX9DR8Cz3z5t/j2XiYs5I6yjdHTUkR3uV
         ObzqqTlzxBDk7TrUA/1nlPGlYmvBxNz3uZmGuRue3mke+sRbodf7xnoAelpxXD5ErtEo
         h/QZv4rrXqV8sai5cUJ5LIcXvYOYO+bJfTYlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sP51AdiVP4FrrxLaGyCRZ+4BTQGweHpreIrWUeYYPKo=;
        b=gcyBo6qMnD0OmYRbVfVCuX8ldNwQbOf91Ddg+6MnXDahHFSeksCO64qCFnwUO7DzSw
         BT7/AnIC2IEyRxcP2wev/QdgtqiiaW3rA4W86uFt93TLtlL86EkDSqfzDSnpQPB2/h5p
         4VHapdXfNoX1IwJM1JqdEu8EdkXo40ewSc3oTfu64CPElRC2KJoAfjEYqUn72vIwHob/
         dwnWs1lz+Qkcy/gpyfw1EPNRLqPlr5M4hp5zkanMw/ze2mPV487AYas2DKu6N/lDngNx
         NO0J+s+RfgseRkzKVO94cgMJL7GnqNoLNXuQmfXOdueuG8EgohDTQXY/078b5FfHA+HK
         Rl2A==
X-Gm-Message-State: AOAM532YNfLWjGAbUrZZkPEeP+9dCvKr57IO9ngxa8z5NsNDKDDjbdvo
	pQ+Tbwec9RHEj0ylnyS+4/oft7sa6EgJlg==
X-Google-Smtp-Source: ABdhPJwcQ7e8HsBKURWk+rgG0ZX0yjc3aYuH7fBvATUFIiY+vRUuwx34K10aS63NpkamtnrwBSK2ww==
X-Received: by 2002:adf:c101:: with SMTP id r1mr14769225wre.38.1615562918096;
        Fri, 12 Mar 2021 07:28:38 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7cc6:73c3:839f:86be])
        by smtp.gmail.com with ESMTPSA id i3sm8528620wra.66.2021.03.12.07.28.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:28:37 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/color: Fix event register to pass the datastore
Date: Fri, 12 Mar 2021 15:28:37 +0000
Message-Id: <20210312152837.2585667-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the "if d is None" to the event handling code meant some of
these tests stopped working. The reason is that len(d) was zero but
not equal to None.

Passing the data object to the register() function in the test
correctly registers the event handler and avoids the problem, it
just happened to work previously, incorrectly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/color.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/color.py b/lib/bb/tests/color.py
index bf03750c69..88dd278006 100644
--- a/lib/bb/tests/color.py
+++ b/lib/bb/tests/color.py
@@ -31,7 +31,7 @@ class ColorCodeTests(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
         self._progress_watcher = ProgressWatcher()
-        bb.event.register("bb.build.TaskProgress", self._progress_watcher.handle_event)
+        bb.event.register("bb.build.TaskProgress", self._progress_watcher.handle_event, data=self.d)
 
     def tearDown(self):
         bb.event.remove("bb.build.TaskProgress", None)
-- 
2.27.0

