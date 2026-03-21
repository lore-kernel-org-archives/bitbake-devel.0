Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD9109447F
	for <webhook@archiver.kernel.org>; Sat, 21 Mar 2026 13:39:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11074.1774100369406455389
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Mar 2026 06:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=KuF/Xhwx;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso20152385e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Mar 2026 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1774100368; x=1774705168; darn=lists.openembedded.org;
        h=from:subject:to:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXuNJBDDvnm/44/RUrQKlHt/Rhlumh/nULrg/Jhqfvg=;
        b=KuF/Xhwx7RILdknC/cy+VgQiJIXEDNqgysdyaI2hf3K7vwlXtMZIlyfppyLl/x9sqe
         XolVuuKi7QaXrB2rtxV/l8MkR1bR4zmwZtL0Oo3CrNl+pDTIAWRXUa7BuoPhDjd8Aad8
         +rN2CpDP9a6TElmlYFPJPG1k4s5s9cw5YPsiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774100368; x=1774705168;
        h=from:subject:to:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXuNJBDDvnm/44/RUrQKlHt/Rhlumh/nULrg/Jhqfvg=;
        b=RP4AjKCECS7LZ6lanYGC+6NhMB4vhmRd9vM/WmngIpMzUsr+alxt7pYtsFzx8kWYBK
         6Mm6/bUbiVtLqAXwqQDvZ27AVHo/5JPHE/CsMPWv1o1BVfH9WwiZacd3hp55SUL9acAg
         iwzmGEQEmkL+ZAeRqkycXwYuTbo8qt9ziT0GA2HohZ5mtHLQpx8r0WJEt4gl1qCb9xOC
         hr3ZfnN/YKxmxZCZM+PnsAClZ+eG67R6A47qVDjID6paFmSjo286eKNsIgyqWa8mRJlr
         PrXFA1ioBGnDzGVNiEEiJjjgRXYbnlgyqLGCGW4r8vQVCaJAPKxfBoYTs84OiZVRNAsB
         u/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCdBQFFMVPtAD9aS0eQ0SJPFFykqITRqX17qVfvnBVx+oz2AdHcTiu9lPfqojaNdmnpUaVk+aLYB7OV5NY@lists.openembedded.org
X-Gm-Message-State: AOJu0YyC6hVJrkjD45YsAdahHsEPfBPu3vMgzPm6tfWviGxlUIY+o4ST
	yTm00+C1iyCAvqN9vklHmngdYpJhjMddPDHCstHsFWNa39ucUvpstHCNM5huB+Vfwg0=
X-Gm-Gg: ATEYQzwV2Wg4xYZcuRd81gR4tzyKxqoBGiSPA2x4livqwf51tjspsK3ycUkc22ttXA0
	VuzNWFauLDnwuY3stZLkc5umZtFlRW0xd9ZelCxQfxeN/VeL7mTtxViiSz4IxHmEm6YPqRQnBZT
	su0MzdUBhk7NgfPTMt3DWgYjVQFAtEHIJHANqnUAmBRSUwnroZBh6114AVC+M75R3rWTAOJh50i
	G7u0lglrwwujfQmm/jxyajEJZ2p40u1QgVKbuD1a5gG1OeIqU1mTDx3VE7mTQFdIOhN9fAH2uA6
	s4062QkZ0cYnac01b+/yKamLhN7daWZ0twQalIzsmPbgUwZzALYKS3Qi9XJSkpuovculPuUayk0
	/RlI3GgA6NirP/Ly8k3p9Icase/s9xY3ODijbQsTz1lw9DkJeAN2+yL7mfZ76Ahob8Dj9argYQD
	SJudmPmbz0AblvxUOsnUcTuWC5WcXO6VK/Y9rBjHhOSHcw0brVbmIiSLdUT9QGDUtgDF1cu4a+r
	TFvq1ei3nh2dA==
X-Received: by 2002:a05:600c:c083:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486fedf9be6mr70648075e9.10.1774100367635;
        Sat, 21 Mar 2026 06:39:27 -0700 (PDT)
Received: from localhost (2a02-8440-250c-8030-6c94-8350-19c4-1d82.rev.sfr.net. [2a02:8440:250c:8030:6c94:8350:19c4:1d82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870504f2e4sm10470155e9.18.2026.03.21.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 06:39:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 14:39:24 +0100
Message-Id: <DH8I3C005I7I.EAFAABGT2FJL@smile.fr>
To: "Yocto ML" <yocto@lists.yoctoproject.org>, "OE-core ML"
 <openembedded-core@lists.openembedded.org>, "bitbake ML"
 <bitbake-devel@lists.openembedded.org>
Subject: End of kirkstone LTS support
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Mar 2026 13:39:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19196

Hello everyone,

As you may have noticed, the end-of-life date of kirkstone (2.0 for
bitbake) is near.
The last release of kirkstone will be the 4.0.35 and will be built in
the week of the 6th of april 2026 for a release on the 22nd (the date
shifted a bit).

If you have patches that you want to see merged in this last version,
please send them before the end of march so we get enough time for
review and testing.

Best regards,
--=20
Yoann Congal
Smile ECS

