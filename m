Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D3D2C122
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 15:06:32 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.20386.1730819192233493185
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 07:06:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PVuop7Qv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso49434115e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730819190; x=1731423990; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp+phccFsRHMIypM6YOUtM/zZ6jgRYNQ8W3zT4UxQWQ=;
        b=PVuop7QvJoIw/CiSmr3UciInYSXWDmSq1/KVSXLmVoADVPqsEoeRoh1T/jCcpzSzr+
         fArT/52xYoXQ9smuzVhFTa1AF9HcX3kJpJgHm1zg6SdZYIr022woThp/KKx5LmHbzv6y
         sQVs6GHlzJUf+wWDL8jTOdtCihDhBw1E3Ty8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819190; x=1731423990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp+phccFsRHMIypM6YOUtM/zZ6jgRYNQ8W3zT4UxQWQ=;
        b=Ke/qlZOyhsAxq89HxMa3ZBFepZsSqIfyNcGokGJkSrNTMbMzSvhuAJX7Uidb3TICL8
         sEbzcwdsvsgcX/6frLh+n2QPEbV3DBpsTk+nzyoppTT1ItF0XTEiZUezUvMaGyfMuRPe
         f9FcS+M+CfYDQokQWRp0KQ+MHbG5wFH7YMjKe4mphKs7vS6htpcRXlHhybgvoIsbeybO
         oT2Wukgi5xIGQrAMvkG5KIWhzQpD8oc7brbbWHJ0E635RTIniX6imEaUIirqHxb817zg
         hksie590JQhfhCj9Y43GFmHbZXc+P7OkZ+O48ELEgGAPJbg5zgjw9gE1nHwTIo11jQZL
         zNyg==
X-Gm-Message-State: AOJu0YwOIRhYqQ0d56fsqu2MJQceccdjIewV7+dBfpKtQ4fXMTGeeA4x
	KVywkW+svMKQWcUZHb1pE1OhOgsCfamT0FENayah4VsTJns7i8WHtVgrE3Tr0vvmSPelFob+OOU
	8huA=
X-Google-Smtp-Source: AGHT+IGH7+LJ43RDI+3NByHin8nQWK7re0z1iZNdLiKda4I22ulGRMK1owxXGFsZbpl6t/X4LeX+HA==
X-Received: by 2002:a5d:6d8e:0:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-381c7a4c7d7mr13931447f8f.19.1730819190414;
        Tue, 05 Nov 2024 07:06:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7614:7622:3cf4:a240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm16656323f8f.7.2024.11.05.07.06.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:06:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] server/process: Decrease idle/main loop frequency
Date: Tue,  5 Nov 2024 15:06:28 +0000
Message-ID: <20241105150628.2827698-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105150628.2827698-1-richard.purdie@linuxfoundation.org>
References: <20241105150628.2827698-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 15:06:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16776

The idle and main loops have socket select calls to know when to execute.
This means we can increase the normal timeout frequency since this is
just a fall back and have some small efficiency gains.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b627ae0ab6..4b35be62cd 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -329,7 +329,7 @@ class ProcessServer():
                 bb.error("Idle thread terminated, main thread exiting too")
                 self.quit = True
 
-            nextsleep = 0.1
+            nextsleep = 1.0
             if self.xmlrpc:
                 nextsleep = self.xmlrpc.get_timeout(nextsleep)
             try:
@@ -439,7 +439,7 @@ class ProcessServer():
                 self.idle_cond.notify_all()
 
         while not self.quit:
-            nextsleep = 0.1
+            nextsleep = 1.0
             fds = []
 
             with bb.utils.lock_timeout(self._idlefuncsLock):

