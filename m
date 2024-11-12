Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA919D597B7
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 23:06:30 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.100835.1731452789070642252
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Nov 2024 15:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Z7nqb9B2;
 spf=pass (domain: smile.fr, ip: 209.85.167.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da07b78dfso82959e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731452786; x=1732057586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl6PWBdg1RGkEp5az9MC7O2W35G0xw8LaXnxIcVvMSs=;
        b=Z7nqb9B2upszLVxcMJ3GpPvZWpWT3WnQk8y30itPAPJbbOnmkzZ8hb+sE/jD2Q2nXG
         1yiq+alkJIuwROOVdeghUc9GJM/Eo3HO5v+5B91l9ZvPGxUDmPThRutwfThJkSGTXUMt
         GTJpTsc1vc2RJrdr/HpUcLPgtSoslRGiXSCMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452786; x=1732057586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl6PWBdg1RGkEp5az9MC7O2W35G0xw8LaXnxIcVvMSs=;
        b=I7mqk3c/U/O8c4ek78L6uOFChgAI7AW2Oe+MQU1xcvV39QDkcwnb/qSu+iqWPL7grL
         JIlAppcFKnDhKDneW4VTwe3Y/aUpQfL+iXgAKKGj7fpTU+kAEDCFPW2R8oBqPp9ItB2d
         T/5fmFZJuhq6RkW6FczhMb2TehBenH4GetHJFroKcR0tZuKZImd4Hr9Yad+XbLx1qKQ+
         KB/Bq7756MIm3JdnPIljn9vCAYHxvdALGKrDQsZQWBzeIJssJ6nyQ4fw8irE9mRutJbD
         FHJJ1khuus7SGrB5bfew1eU+/IqCZkc/S/vw/zncYub1gkh0f5enRJdlADBAAQrx8dCO
         TBDQ==
X-Gm-Message-State: AOJu0YxAkihM0POlQkGgX4nUe9MpM1Iqsbb/x0Z2qANlOZkiYjmGQkKI
	hcJ/Tr8J4gqj7wRPzisVac8ELrgHHAWgcWx0Dts1yzmUEyEXtCxecsmy4lRkOojpw7wz1KbB/6N
	c
X-Google-Smtp-Source: AGHT+IEpyvA44JSUhPl9UuF4zuvGfbuWp8BPbbPeUJ78RdxVp6ipcTlot3ewzNOeKa9H24YidUb2tA==
X-Received: by 2002:a05:6512:3b27:b0:539:ea49:d163 with SMTP id 2adb3069b0e04-53d9fe8076bmr293132e87.21.1731452786469;
        Tue, 12 Nov 2024 15:06:26 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550c505sm2283635e9.33.2024.11.12.15.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:06:26 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 2/2] bitbake-getvar: use finalizeData tinfoil API to get identical result to "bitbake -e"
Date: Wed, 13 Nov 2024 00:05:59 +0100
Message-Id: <20241112230559.2035910-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112230559.2035910-1-yoann.congal@smile.fr>
References: <20241112230559.2035910-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 23:06:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16794

From: Yoann Congal <yoann.congal@smile.fr>

Fixes [YOCTO #15638]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-getvar | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 8901f99ae..bc0b989c8 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -45,6 +45,10 @@ if __name__ == "__main__":
             tinfoil.prepare(quiet=2, config_only=True)
             d = tinfoil.config_data
 
+        # Expand keys and run anonymous functions to get identical result to
+        # "bitbake -e"
+        d = tinfoil.finalizeData()
+
         value = None
         if args.flag:
             value = d.getVarFlag(args.variable, args.flag, expand=not args.unexpand)

