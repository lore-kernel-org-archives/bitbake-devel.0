Return-Path: <andre.draszik@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD3C48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 13:25:41 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.41220.1708349140898594292
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 05:25:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=q3NYrkFZ;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: andre.draszik@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d066f8239so1969395f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349139; x=1708953939; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfe/++6PY7EKZ9z82iAxpGutbrZgwkkvjZLkqwad+KE=;
        b=q3NYrkFZOfT8a9Ko3cp1JobNTwHWbwNWbviRF3a2WQhIIoF0vph4nFynQWI+UXpXBt
         nCsbC0D6IBfe/t23jG81u06qUc8yj+T6BCNJ4upfy4lKFDwK6hi1JsWqgXKdlaUS117b
         JZmNZMkhjZcX/DQOTwkrnGbZqDlo7m2lkHg3CJ/MlojHULJsEKeAJjodMSpun1d1yETl
         NUy2Y8w8B8heqxu9uxdGXam4bFBocUdCkv2eehqZSulxZiczvwgSgojj0KaYXEIUwF9q
         JcYgKF0S16cCzTKyPa5/8ZGRzkpRRg+SpAp1XYu63WbRW4a0iOVibZKFGWPfk+GTh1mP
         6nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349139; x=1708953939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xfe/++6PY7EKZ9z82iAxpGutbrZgwkkvjZLkqwad+KE=;
        b=qwyyNpho5kVFMBkNDGIZO9RgvCV5DOAA/agTRWK5AC1061XVkBbY1+2bjRwFmuu/PJ
         NLaKhcwgEAYNFzrGldC3WFE/b0vAG8Om7oVM7m7Lj2KEKPbyIBZweFxUoATfy0crOSwS
         lTHI74owQqaW80UEzG3J31EqX4UVaiPw0x8mKwrAyhVMUPqbWMOfcdX2vLk0jZI136+s
         sFbWJStriuwfuxxWb0pZxVaPY/CF8KQjJiF7meHakX/rz7MRYSV5U71G6mgA29HYCdPV
         bKuSyctmAL2AbnNnm+LPMLUrUg7kK2S0q5xnGI6inorIVIOt8YppUi3IH2Go2VMqEbfi
         kB8A==
X-Forwarded-Encrypted: i=1; AJvYcCX9j7UtMBbAtO15yPzjP8H8O9ZMCl6O340BEEVN4AAybs5Lc6rVdagGpYk/VLl8WIA+C096pOaeed51Q6A16mPDmfuN2SQu7VY8Jbd2/MbWuTVz2SI=
X-Gm-Message-State: AOJu0YwEBEllTXoLGD/E/9iidDmbl37zNEyF2Rf8I+xNqQoCsP7YvQ96
	asXQ6slxi0C/tfhRw4O3vhILcYydP5ch8QgplEUHMIb088aZj3gpbTG2omgib9o=
X-Google-Smtp-Source: AGHT+IG+1X+e0ELh24xpicFWBxkRgPriQaexBCR/gRO1R2Pe5EI3UpN/bhsd7vLxsPlc71hPkN4h8g==
X-Received: by 2002:adf:f352:0:b0:33d:1145:8787 with SMTP id e18-20020adff352000000b0033d11458787mr7553978wrp.25.1708349139279;
        Mon, 19 Feb 2024 05:25:39 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id h7-20020a056000000700b0033ce214a97csm10346622wrx.17.2024.02.19.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:25:38 -0800 (PST)
Message-ID: <9bfd5d27a3cd662380a4a7340026ff2a4a744b40.camel@linaro.org>
Subject: Re: [bitbake-devel] [bitbake][PATCH 0/3] support git's
 safe.bareRepository=explicit
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 19 Feb 2024 13:25:37 +0000
In-Reply-To: <33c2021c9e0bad9fc287aa7af8070e1a9cdbc5e7.camel@linuxfoundation.org>
References: <20240219095454.3211974-1-andre.draszik@linaro.org>
	 <33c2021c9e0bad9fc287aa7af8070e1a9cdbc5e7.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 13:25:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15940

Hi Richard,

On Mon, 2024-02-19 at 12:08 +0000, Richard Purdie wrote:
> Thanks. I'm not thrilled to need to do this and we probably do need a
> better solution but a stop gap does help.

I had some issues with failing selftests when I converted to --git-dir=3D i=
nitially
instead of the patches here, so I went for this solution as a quicker alter=
native
for now.

> It may be an idea to file a bug so we don't forget we need to improve
> things?

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15405

Cheers,
Andre'


