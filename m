Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614CAC41513
	for <webhook@archiver.kernel.org>; Thu, 11 Jul 2024 16:56:38 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.1296.1720716988742060786
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jul 2024 09:56:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c85VoiZ1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367a081d1cdso544141f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jul 2024 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720716987; x=1721321787; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sAB2zzcbE6WGcyZr726ll6Abyi93Ott2UDt5T+mBJA=;
        b=c85VoiZ1u2t0PGfrkRE6Su9Hn4//nsY4Yq1jj2xUw5XhJ37/CbGmDo1GihM+SEPhzC
         UMuSLxsaKd1nl4mvv0l5nrcWHUz+AUmmqBVrxDex7B6Xrf3BxbYtsfl2VrDjheMWO2CX
         1qfUeIQPWu7FXqqEeJ7vKVjncbkgOL1E/Li3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716987; x=1721321787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2sAB2zzcbE6WGcyZr726ll6Abyi93Ott2UDt5T+mBJA=;
        b=pf00tFcEYX6v4M5bZZUn5rvcjvn5zUJu2XSaXbsdFrmfOD7vfC16/VvPMGoK/AW9z6
         oDwtsPjex09i/iWl7s1c5XCe8ae3C1m0KTA6UW6v1aQVtvhOFd05WLIOOMrffZNE7S7C
         U8V6HmYIqhKncIDVvDvSAHslJkNzT4st5yEZo41dUcEtld7AJbDnVIbcEqD3RqTaVgKL
         IS0tioF0oBGITo16HG0k73iFdW/daO3klMcmOV/NdPUUq7zdyx5RYvPTPo5clZCXTL2p
         dAlvaukw7Vvz7mO+gPhZqd8FGfWWlM1kN/u8aPQYb0nVNIMNW9o6VZVgVf2NeYH13pmo
         Gi1g==
X-Forwarded-Encrypted: i=1; AJvYcCU9lv+l9z7BTPhUjSXmPy6JpATsP0E6aCoxxZpaf9ZtC0NCPXaoUano5V4Tmba3pr0x1E7vDrjII+92FAyHS/gsJLkKnO1P1+vPXpGmKlGEYJl4Rw8=
X-Gm-Message-State: AOJu0Yz5yh4JAYhxlwYARv0AvxITLAii3n+ubG+Bc6uWwFrWo+PilW/R
	ZBugNGbhiAzi5kc7tqCNjV5SlPoWEEWfL9w0Qkk0sWVzgIeEfc0WSAiKjd4a/Uu7fO/IGOHRtX2
	r
X-Google-Smtp-Source: AGHT+IF/Y9jj0w0AhtA7KHXuGGkr/F2aCYbx5g7soQMNIdWE4UXt0XMmP2ShGhiQSjV7oWyTIIsSQA==
X-Received: by 2002:a5d:4c8c:0:b0:367:9627:d971 with SMTP id ffacd0b85a97d-367ceae1e86mr5553559f8f.71.1720716987189;
        Thu, 11 Jul 2024 09:56:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b76e:27af:5a94:dcb6? ([2001:8b0:aba:5f3c:b76e:27af:5a94:dcb6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e02esm8209507f8f.3.2024.07.11.09.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:56:26 -0700 (PDT)
Message-ID: <8742f7224c95a44d647fd0eb921e99d511c1ced3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable
 network when unprivileged userns is restricted
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: changqing.li@windriver.com, bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2024 17:56:26 +0100
In-Reply-To: <f5f8592c-bd73-4869-a07d-67f2834dac8c@windriver.com>
References: <20240708081034.1474312-1-changqing.li@windriver.com>
	 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
	 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
	 <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
	 <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
	 <ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org>
	 <17E0BC4E4EBC9777.21385@lists.openembedded.org>
	 <f5f8592c-bd73-4869-a07d-67f2834dac8c@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jul 2024 16:56:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16416

On Thu, 2024-07-11 at 09:39 +0800, Changqing Li via
lists.openembedded.org wrote:
> The request is rejected as following comments:
> =C2=A0
> Unfortunately, as John has stated in this comment:
> =C2=A0
> https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2063976/commen
> ts/3
> =C2=A0We are not able to ship a profile for bitbake running in a writable
> location of an unprivileged user because it could be used to bypass
> the restriction.
> =C2=A0

Sad but I can see why.

In that case we should put a sanity check into sanity.bbclass to detect
the permissions issue and point the user at docs on how to make things
work if the issue is present.

Cheers,

Richard

