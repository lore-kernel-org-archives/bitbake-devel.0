Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99072EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 09:31:08 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.3613.1689067867303556817
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jul 2023 02:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=YRWaKl1N;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-307d20548adso5517467f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jul 2023 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689067866; x=1691659866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dccPJ4qJGBWeLo1/rtUyrGTG2EExYATyAGKh81KI+78=;
        b=YRWaKl1Nrjy8WbodFZ7R3gYvE8Q3v22FXIly7qrqvfeIBzt55nopZnTsfLNF6kpy9y
         u+i/RyNS00ql06qQ0exidnXatEkHdP4hXB1W6lcf/BEPYT3DwLOU8JAt4NIDXKOt8dCX
         mdaO0G5CRcwbaOvR5+ykwFrGqZvsYdrGI43cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067866; x=1691659866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dccPJ4qJGBWeLo1/rtUyrGTG2EExYATyAGKh81KI+78=;
        b=F/5dV2w7jgxiyGD7Mgw6IgZJoOCuOrJ2HjYmqnmMY8w/rJkjM9DK5c8cAgR9J+I/cD
         aDoo6KMs7RnkzwnUjf4Uwqq9b4o+74JoE5VRr3PEFQY3d0pA8PvtROxSxqF4Yr22rhHy
         bajdh+1tFhY/Ad77BTsNt6JUjXokXssVyfAi8p+FPHVgEWpFKbvCekX8L7hmANXTYHAn
         wRJLjfpvFC2pZvMi6cpjJtxCH0ZxbCa1h5BzxXU3pZca4m8/ocuipAYgK34ZTVskIunz
         FSibtAE3fo5PhgIzfdj9da8znaHdzz2i+aj568GWPAparhfMrje8dSVO81B/HJl4Lqs3
         1AMg==
X-Gm-Message-State: ABy/qLbn0UPQKiBD2U2ibUVsKAcg+xYA6McctGM5L1/ngz9TW7MsY+mo
	0lCcIB3yE+bFfK2TZ79cdHSIRg==
X-Google-Smtp-Source: APBJJlFjBH27xIsoZxJcXtk61sMc52JtLLZdJ+/xgLLvjhL0A3B8KaVWJIl4qVo0s1gwsa08paZj5Q==
X-Received: by 2002:a5d:528e:0:b0:30f:ca58:a00d with SMTP id c14-20020a5d528e000000b0030fca58a00dmr12413855wrv.45.1689067865586;
        Tue, 11 Jul 2023 02:31:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:645b:1bfa:e637:558b? ([2001:8b0:aba:5f3c:645b:1bfa:e637:558b])
        by smtp.gmail.com with ESMTPSA id a23-20020a5d4577000000b0030ae53550f5sm1737331wrc.51.2023.07.11.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:31:05 -0700 (PDT)
Message-ID: <b403142b02535550765de6bb0d206919ad28dc4b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: randy.macleod@windriver.com, Qi.Chen@windriver.com
Cc: "Randy MacLeod via lists.openembedded.org"
 <randy.macleod=windriver.com@lists.openembedded.org>, 
 bitbake-devel@lists.openembedded.org, Ola x Nilsson <ola.x.nilsson@axis.com>
Date: Tue, 11 Jul 2023 10:31:04 +0100
In-Reply-To: <ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com>
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
	 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
	 <jwqilcg4ydl.fsf@axis.com> <1766B1E87F43AC01.3462@lists.openembedded.org>
	 <ace2ae20-d99c-b73c-d63a-890cae5d5a25@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jul 2023 09:31:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14880

On Mon, 2023-07-10 at 19:22 -0400, Randy MacLeod via lists.openembedded.org=
 wrote:
> =C2=A0
> This change was merged back in April, despite my comments above.

No, it did not.

The change in this thread was posted in May and we decided not to merge
it based upon your feedback.

There was a different change posted in April:

https://git.yoctoproject.org/poky/commit/bitbake/lib?id=3Dba94f9a3b1960cc0f=
dc831c20a9d2f8ad289f307

which did merge.

Whether it should have done, I don't know but I would like to be clear
about what happened!

Cheers,

Richard



