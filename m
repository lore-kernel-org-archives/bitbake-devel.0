Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333C3C61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 14:35:44 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2170.1787927736163534113
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 07:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T6OErrXD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49800c6a846so10623995e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787927734; x=1788532534; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDkf52DHIsfFIaWOy0HhxNVGkRBqiWNHx6qK1QtJGEY=;
        b=T6OErrXDOyl0ukshPdvv6WlU6kob1FFz5KgY+nt1Hwm1W76pFgMyXKgh/paPpAeEYI
         QLCgeZ/LACUK3NHoDEy/q3uV+Dvlx3n2tdIzenW9q0fZWPi9/dN3VHQK/8wPTMkV0Wtd
         bCC2/5bDZEnTnMcFPajKjdfNXIfEo4z5tIa5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927734; x=1788532534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vDkf52DHIsfFIaWOy0HhxNVGkRBqiWNHx6qK1QtJGEY=;
        b=AgOIPIpFdWeOR9O7uFo+9DQx+4msO+Ffknk6zerEIvq5iK76jyn/+HzxsFtJPQpo9B
         RxkGfA3jVBX83icgb92jtatpKy1D/3o18gznDbfHudWHe3xiIq6PfYJYc4ZYtHWVxPOs
         GHZS3r4s8yftvvES+vVIdUZLdsuAW9HHZVtkT24gHX5mJc3D4JLFMflmKCMi+BDX9a8Y
         CXPXwQwAApssIbu+8RCX3x25i6BwiQbuU0g9XvxwKJ/mGD8T2oqzLpzSJfJ+W4sIE4xS
         7WB+Nmp06mTAf0i1jTDRCt7ONvov4R2A6hhhF5f+13RMpPU18RGbmXY7+QQXF7Duz1Qb
         zHqw==
X-Gm-Message-State: AFuF++lE1n0iHOX/OYJihd2lnGuh+f3PRTL+tpGCmd4jqKZLjXz8ha77
	C+t3eB+02nU0oc+EsG5Ty3FDq0gqrBSWSXmkTw4XiYjFGa/7rjdNXMubNS2hm5rgb140Qg0Jky+
	nDmiczZQ=
X-Gm-Gg: AR+sD11YaEIE9qmktZGrmtZY9gcOSDtFEHZWE81v8+ijc3WqB/jDig7StVj6wNf9/mU
	tkZ+Xns4atNTdkxJCz+gPGLSHgPwoWK3iuV7dhc1+5Tmf4hGwdgJsdIGn8/dKYpw60MLWO7fn2S
	weQvPmb+quwaBo3Z5FW7PXPlrwceA+1prtvCXJNLMAI6X1Rse6V5CJZy5sdj865pACEt9nVylNn
	B4CIDSHjrUoFER95cFfzhBcOZ4b6jaKB8i6WsfWiW2BDVo5i5aMrLrS25MYgZV3IrwUzgBCGn7Z
	kFD8Sq4ceqhs6bOFss7zn3efbRrNCL+VFZbR6mHr94ZiWGCUX4SHUTt/45fEKW0UaGThOkjSzC3
	zLV7hUNnkfzTlPIxcA32KqQ2f8+Yh8uQ/IhLDgi30YIsGaKoRYG3EKhvwXrRx3pBHUbCyS6Gm1e
	s99FovPOpdvRDOAhdkXGxsF7fF20yWiOK8T+isD+DYt6voBEL5VZieI75x8TvxqnIOKPi01smsL
	hzdVFlubb5G4npuhx0=
X-Received: by 2002:a05:600c:4fc5:b0:49b:72e4:6223 with SMTP id 5b1f17b1804b1-49b91c2bcddmr91623635e9.7.1787927734179;
        Fri, 28 Aug 2026 07:35:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c3f1:c7b4:8368:83c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm137542065e9.15.2026.08.28.07.35.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:35:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bin/toaster: Remove accidentally added version string
Date: Fri, 28 Aug 2026 15:35:32 +0100
Message-ID: <20260828143532.1532565-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:35:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20102

This was supposed to only be in python files, and this one is a shell script.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/toaster | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 51bad203da1..16a64bab60e 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -7,8 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 
-__version__ = "2.19.0"
-
 HELP="
 Usage 1: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
     Optional arguments:

