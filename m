Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E374D729FA
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 18:54:46 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.120898.1732906482034545798
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 10:54:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EiSsxBOE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43494a20379so19957595e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732906480; x=1733511280; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pHxAeXqvNTTpOyIAUs5KEXSm2R7+J012D/kVmlhKrAY=;
        b=EiSsxBOEujTTSTyk67D3zQd2PhQBGxmOTDVK8T+Iz82lk6lOrow7GLjY4nqFNlIFzw
         XxzyUu46Sz0E48QhsJx+LmqdMCYNLjXIuwU0C/zprWaBrO8Ee88B1nyhDGm4UllY2wbH
         tRAWwLtACBv4z5JCaZoxAclGy/s/GzXAsrjrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906480; x=1733511280;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHxAeXqvNTTpOyIAUs5KEXSm2R7+J012D/kVmlhKrAY=;
        b=PEy23Vgp0tX7sLuwKz8W0nNF4GlX0qDOY2mAhFMmNevOZ5nGdCeseDUdirINF7aMkX
         8r0vMuVxFivQFsXHFEeR3X8weA3jHrpPPKG5CtRifa9ce8OGLKIbemgAHsKxsq2W6N3y
         OaWJcQV3nAX9EWbN+uv+j8RZYYx62PshR792J6tYQmXpO7OvOkq4jKcof0TANEZ5wFI9
         oyQvVO4cBGnr3OcZCjJFGrsTO9wEEI/z3Y6p5pOLVNVp37A7SvdY5Jabpzimec/aq6zf
         GafUg8yeGmDWV35Q7A50LEQrynOJLCIv6+a7vGDiaZpy9HdtUVH0JSE34JjiOH07+dPM
         /MgQ==
X-Gm-Message-State: AOJu0Yx+iaS0sl9FcpNrjY1F7dR9Bk3bgHmfEwyEcgyT+ZZ7tEIvISxF
	Si/WysTHjV6qN0YDUYDzIvVvjLsRjR/IFMMhJOzsp+oNMBUiETUisHs2apWd01A=
X-Gm-Gg: ASbGncs8GgQmtdVQ203ZaeROV5BjW3QQ+LZ2F2b3mvDbdfb4bfbCAkWw8WkoZxpP/jw
	Lr5vxm+T0pIdAaR8BPztzBcL/jaNkXnnMXoRyWz5N+uFuxN6Vx3Sa30wrfdxvleEaPOWJydUQOK
	8vHLELwHSPTM1d7WkuwKh+I7hb99O+jozQHNDbDhNYGLvIfbFq6e8hHGMrEnWzx1ZcMhj999nk1
	I83IrkjTA6d6aec4WHgjXnKTYqrcRSVd/WZuWrqqbQPeNrA/pB6oxKkASiB+K5riMas90RpbhKV
	GGLJBuYg63zRytOx+48d/+I2Br+j++6RSNIZZVw=
X-Google-Smtp-Source: AGHT+IEtQT8sXrfWXxeLEdMx9Ckz6gx4Ownh/zzWb0QDjc1kY+V7cxjmA507HViyvvLnxE7BOQo0pQ==
X-Received: by 2002:a05:6000:68b:b0:385:df19:cbf with SMTP id ffacd0b85a97d-385df190dd7mr4287528f8f.28.1732906479923;
        Fri, 29 Nov 2024 10:54:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f? ([2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36855sm5155868f8f.36.2024.11.29.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:54:38 -0800 (PST)
Message-ID: <ae9a07452b8df67f44ead3a83d177e57cf4034c0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix performance of
 multiconfigs with large overlap
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Nov 2024 18:54:36 +0000
In-Reply-To: <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com>
References: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
	 <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 18:54:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16851

On Fri, 2024-11-29 at 14:12 +0100, Alexander Kanavin wrote:
> I noticed that particularly 'bitbake core-image-ptest-all' tends to
> sit for significant amount of time without spawning tasks. I
> cherry-picked this patch and it doesn't seem to be helping :(

Try:

https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&id=3D6522505769ce=
a6bf96739469e64ec3a0a99be2b4

since the issue there appears to be a different performance bottleneck.

Cheers,

Richard

