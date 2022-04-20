Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1082C54EC5
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.7668.1650460934218327873
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RBXULpw8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id c10so2275704wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a0rYC266jhSdp9QOkdvRKMi0i0dQpgYSAKIXPIH98hA=;
        b=RBXULpw8vqJIIUgoCSNW4PGmODP6y/a+CoS6/FkKPJumlSvKnxj+0Baew2dDFDW4Cs
         qziLWXLkKA7sHTOoRy89UY/ClEt+2zR4gSbNaZlfC4ldCAQjH8Zi4t+bUcrODWfSFczg
         vH6I4YLYf39oh//Ssk+tlLGoz8tgKELbkfsuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0rYC266jhSdp9QOkdvRKMi0i0dQpgYSAKIXPIH98hA=;
        b=zlLhdmru4g9REHQkxNSFcELUAKvlRZthW3kF0gBidur9cHU4W13kX4fpW+obTGatEw
         MtHt2IkM9Q9MdKY7GjKzWnrE5CF5+BfvJax9RiMjM5UOj6puh+lB5OAEHun9c9MqJtnE
         6tsI6KWX/bM+tB8jDvHmzdRN4fwwsRv86lAtYcEDXdgF4C2bk6BNaE/bN69WlH7ppW0l
         ZqSWX8Vf0ybP0M59muNg8HNLxfkcR2ojZaYewIX4ehRHPF/xPgdLrvrzY1JwAtUOT7mF
         GTTAK6SEOmKDhHDkckbJTjWJvhus6bFBfabuLjXM033SN7ptXmpCyaKvovxmyqoM4Rmi
         ObKQ==
X-Gm-Message-State: AOAM531Bkmt632do3IuvkscAohYFmhkKaB31enuNycskS930jRWNazLE
	a69iD/matn8OxtAI+UhyUgAPMHah6Q1/IQ==
X-Google-Smtp-Source: 
 ABdhPJyqyl5lsgwUWXRlA/Al+P0bbxz7ivp7AJI/gtZUpIgmlf49vBfSyzzNnEKhSFYojkGaDfEOMA==
X-Received: by 2002:a05:6000:18c9:b0:203:fb67:debe with SMTP id
 w9-20020a05600018c900b00203fb67debemr15542642wrq.494.1650460932198;
        Wed, 20 Apr 2022 06:22:12 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 04/11] msg: Drop unused local variable
Date: Wed, 20 Apr 2022 14:21:58 +0100
Message-Id: <20220420132205.2530591-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13646

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/msg.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index c95a874beb..93575d89c4 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -133,7 +133,6 @@ class LogFilterShowOnce(logging.Filter):
         self.seen_errors = set()
 
     def filter(self, record):
-        msg = record.msg
         if record.levelno == bb.msg.BBLogFormatter.WARNONCE:
             if record.msg in self.seen_warnings:
                 return False
-- 
2.32.0


