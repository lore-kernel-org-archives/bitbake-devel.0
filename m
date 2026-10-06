Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF4ECA5FFC
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 22:50:21 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1442.1791327021070417157
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Oct 2026 15:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VFpsOCQ8;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso12490645e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1791327019; x=1791931819; darn=lists.openembedded.org;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QjpyDhDPAQcaAnF4bpasE/Xk/ITkf5a2XdHCZWmqOO8=;
        b=VFpsOCQ8y6lCrV3N0y/eJKYGdgsk/A1Cnn+hopfXLTrh92Fni4aC1fv8kkKrEyJbCN
         JkxhxTUKQUTdKdcxkVlX7bb/Zdcja4lp3D4rf5+92Qcd51sBWD9TXVt0CelFr/HCozJX
         k2ZhVRF3FT5p+ctda6PGaDkClfR7cBk2dqDy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327019; x=1791931819;
        h=in-reply-to:references:from:subject:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjpyDhDPAQcaAnF4bpasE/Xk/ITkf5a2XdHCZWmqOO8=;
        b=MsHUHYsmEsUZYReSpq7esUU387/0b2FhrYYMZjMylHcX/oTRKH8zJlMGYkcIFuBPHH
         nPBZ6TkBGsVzlYsp3uEINrHpJfnwVu3uTjqMyKxxo1+fO5y80US3rWecUrQTFdTyqu93
         QiSsL95adp3OzCUN5JllosSM97olXdTWKhw0he94v6KWNjvpLwtu2KEt8Xkifm0Jbfbq
         Ui6o9bm64yLMDBX4mbbQKjcJH6+f5rAQCEWOdMI0T3P+DZ/pW9Mo/PS2ZjLCrtksQjrd
         ZQQPQ/sewE5iPdFTzLzO8spRJH8RtVAcKHBZZIBCvOz3Epa1rYFjNda/oUtplqEFqSBB
         URbg==
X-Forwarded-Encrypted: i=1; AKwUvBypIgBo82OvVC+2/VrBm61OOg6EDs5UEA7OPzaNcDqeAQuX06VbeniyqFK8sPrxAW614pGmhHbh81/m7G9W@lists.openembedded.org
X-Gm-Message-State: AFq9FYL0zsWeIJEzNTEC6IZXfuddon6XTW/O5fXpQevHv8/iOI7cNW/E
	k54FdXcfxcHCFG+bx1q/loTrcEs+Ay6qcSbzZItQJQ3WQOgMyVHNYKNyDZMJw4HMjy4=
X-Gm-Gg: AYBFou333ek7w74vktECriiLomZm5lhjDdeL/5qDAEsdXoqwJGzisnqNYRB+P11BRLy
	4YiTt+o2Xx0MwQdbS+FW826CwglFbzAARvOBD7PJ1XdNlF7s0quDBqrSqpVEoutrT6NrMqhg3+i
	QLaLZ7kbgBDxdNaDfh0N0vh/u8ZbbFBYMY2M57DJNh6ic/IUxf6y7CFVkCkvkuFRLmocdZ+FUgc
	RBH0uZG403bJKQ+Oeglx0dVL7jWGjAgTL3hth8xsouuyvycU5FzF2QWXH5MeBdmV/6lPxd0wWk7
	IPEloxi/9K8GdcgoLOe/SwFmucIxAO4fcV+blx2D4p0vRmIRnXpysCOJ9lEq6zw9Xv552vWM8tN
	iBQ/bETh7frfgstGYqrm1CzyR9Apzf3zkPuBjzjMjNxJdzbQClX7bEvJTRd/WAenNaXWvr42tZv
	VVfiIQaUEE0Ej6MhoxUV3Vo13jaC8XgBpN5KHDh8HqUkyfK8NQvyoL+ulBV0cy6y7TvN3uLBcUE
	kwez4DG0DPGB5wpiMlwEN3PocK6TTJizCc3UOsnAgInqkeLbuAwT3ORabX0IA==
X-Received: by 2002:adf:e186:0:b0:48b:1b6:3df8 with SMTP id ffacd0b85a97d-48c7288e4bemr1160193f8f.35.1791327019221;
        Tue, 06 Oct 2026 15:50:19 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b37csm1944487f8f.9.2026.10.06.15.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 15:50:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 00:50:18 +0200
Message-Id: <DLY4FJIPDYDE.1E2VH902D858L@smile.fr>
Cc: <richard.purdie@linuxfoundation.org>, <jose.quaresma@oss.qualcomm.com>
To: <ricardo.salveti@oss.qualcomm.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: don't rely on wget
 --continue in the corrupt partial test
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org> <20261006213334.3360919-1-ricardo.salveti@oss.qualcomm.com>
In-Reply-To: <20261006213334.3360919-1-ricardo.salveti@oss.qualcomm.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 22:50:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20302

On Tue Oct 6, 2026 at 11:33 PM CEST, Ricardo Salveti via lists.openembedded=
.org wrote:
> test_wget_corrupt_partial_download expected wget --continue to leave an
> existing .tmp file as large as the remote one alone when the server
> ignores Range, which is what GNU wget 1.21.4 does. wget2 2.1.0 rewrites
> the file instead, so the fetch succeeds, and wget2 2.2.1 (Fedora 45)
> appends the whole download to it, so the bad file ends up under another
> checksum than the one the test looks for. Don't run wget for that first
> fetch, so the fetcher sees the partial download as it was left,
> whichever wget is in use.
>
> Tested with wget 1.21.4, wget2 2.1.0 and wget2 2.2.1 (Fedora 45). The
> test still fails without the fetcher fix.
>
> Fixes: 37b9c56ae3b2 ("fetch/wget: rename the partial download on checksum=
 mismatch")
> Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---
>  lib/bb/tests/fetch.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hello,

Do you think this could be a fix for
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16153 ?
(previous patch definitely sound related)

Thanks!
--=20
Yoann Congal
Smile ECS


