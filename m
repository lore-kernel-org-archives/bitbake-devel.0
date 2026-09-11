Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBDCC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 22:18:22 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50928.1789165092640360076
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 15:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=P7mWoMQA;
 spf=pass (domain: smile.fr, ip: 74.125.225.76, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so180721f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789165091; x=1789769891; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=loeJ5fVOWhUbPJHW+NFKkRMe/jUZcegdPqWwrAB0h+s=;
        b=P7mWoMQAHl/AEnApHaS4xT7umqWqzL/jljmSwaJDXflg4zQGhB/0Rvm4k3axdiTdHZ
         tQdovyzY0acznxH0mqAkYy4ddQiL5kzjhswCyPy0w7362ea8Cd2gECobiK+VtPhHMc3h
         2ngQxwOsPq1aWrspp8JMOgvG89U1ZOi9CFMxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165091; x=1789769891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=loeJ5fVOWhUbPJHW+NFKkRMe/jUZcegdPqWwrAB0h+s=;
        b=rpeOjjjulQmavJ/pafgA/ciiFA8WvUmoCBXzns9451O3ibI4/tV6D3ImZxr8G7UMIF
         utSNkoI2hY9Q95e72wDxoycLZv24h7gDKtaPsi1d9A6+c3PJrR3oy0qCr2bdB05uWmtT
         V+c04p/TynMDhXSq5Dlz/t3XfWbrazBxgPw7oFcWPiFGsebXZGUl9wDsp9+QUU+Dw8lK
         aun/siNoRRtn6dQGxnXlVg93ckBt2+TTj/gALULTYO/huYOeo0H8P+Aempv24RF88JRo
         2B6vGzOllfmAz72+4ufvw/8Wak7SMmBfkrACBOuYLcW9RG2QG15lHwRoWxKc8tCX6XdR
         Uyvw==
X-Gm-Message-State: AFuF++lH+eKvhlNdbEBvRAxS0Ln09G2X0N+t6/ucd2SKQun8XEceyMR+
	SkeOGn50oY8aSzfKrF4MtcABZqFhNel6UQ6stgXXC+R8N4dDTQZ77qo8n1SLU3Xxw4PYgjODtkR
	NTkOKNuI=
X-Gm-Gg: AYBFou2FFJiD4OGFP4tsk1eafSE30v/74nOkNcLAAcBVkEmod8INXA/LZXq9RBDnToe
	vUQ7Y/qeDLzyeXNj0uMS6XtHL9yoI2+s3d5aIONuLMgUF5JMf6sHD2+S5ER26XV3x4Aa0eF+3ln
	UOUTs4B0TfrBBmMsC2IgFdsttBVxof+VPoQp+noqTAwuOjkbQ/efH6L2b68fQt+eRyCiUHH5bYQ
	H+V0JBOUGSYsjL2JEYYtF9BsP87kpTG9HGg+Y/dchEHf4qWSLKaAB5z+92eFCrGeQCMmhgsE7dl
	WKu8Nn9m9Yzli+X2TG8QwE56lroIG1FlGVSo9b1T1z47hE0cKxWhwdBRJbtAn+0nPZ8GYNB/4Tg
	EISFL3R0zT0PAVEJE6vRTyKbdJZoReB/qolutkyu1+1CATs1Xkcti/aQA5U4W9Tnd4vVu6jiOJ8
	lC6JpaGedfvzIeNgo9WeRPhT8Wm5aUFYzBqJoi2OhPV9XgfnL3HjsoQn+ml3Km7aDQGnRBqrTvT
	1HJKkVHq86AHx6WsCs3MWx8epgg6rZdZfdJL6X4n2wwoOfoFrEXjgiyzSe38ptU0kfEZUYCt1mj
	MxtWm94oLQ==
X-Received: by 2002:a05:600c:a0b:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49e618863bcmr130283265e9.4.1789165090724;
        Fri, 11 Sep 2026 15:18:10 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm78235165e9.0.2026.09.11.15.18.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:18:10 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] tests/fetch: Swap github grpc repo for our own small test repo
Date: Sat, 12 Sep 2026 00:18:05 +0200
Message-ID: <24b0e0bf27183cfb5ca61984c4d8f4b02242b9f6.1789165002.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789165002.git.yoann.congal@smile.fr>
References: <cover.1789165002.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 22:18:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20186

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The grpc repo is 1GB in size and makes a poor choice of test repo. With github
rate limiting, it is proving probematic.

Swap if for our own gitsm test repo which is smaller but can serve the purposes
of the test.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a64b3157d74f883002318cc46c70bfa1c3609110)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a658b89a8..3ed98593d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1193,7 +1193,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_restricted_network_premirrors(self):
         # this test is to ensure that premirrors will be tried in restricted network
         # that is, BB_ALLOWED_NETWORKS does not contain the domain the url uses
-        url = "gitsm://github.com/grpc/grpc.git;protocol=https;name=grpc;branch=v1.60.x;rev=0ef13a7555dbaadd4633399242524129eef5e231"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         # create a download directory to be used as premirror later
         tempdir = tempfile.mkdtemp(prefix="bitbake-fetch-")
         dl_premirror = os.path.join(tempdir, "download-premirror")

