Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F793C5B549
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 18:02:55 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.23533.1749060167467730324
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 11:02:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hZh2Ticw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604e745b6fbso61718a12.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749060165; x=1749664965; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YIdDlqjOUkuCpX29EjvYllRotkOaH5ZLSvJ63ef/uo=;
        b=hZh2TicwGuCMfwTLvc93XGbYA7zrKEMMFZ1cfI9Nc9NDgKsyN9r8PAUH2VDFGB1MxB
         0xGHbC4TB74ojEgdpqH4k6tMi9ZgDOd49pdQLRvBR//ADzKknp7y2aKu9rEwIEOOx/f3
         /LQrKLOHdJYCWbO6kXT2VRTmEV8MgLYyvWV4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749060165; x=1749664965;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YIdDlqjOUkuCpX29EjvYllRotkOaH5ZLSvJ63ef/uo=;
        b=IAwDTpofVnueVsawX9Qj806vx9bfJVNIJBXiO/1VVQD4qpuNueJP5aH7oL0qdh2whZ
         yZdcZvreDQ+R1LdYpSZWU0qZZatVRIClgZMLJK9MEuuk2MtlsWDANmUpCxyulSdLlZOZ
         1PSqY2QDPh/ymUuYbVchbXFBqXB+yJ4APpNHo7B4sB2mxnsHVZtub4qAq0aqElWYIdNB
         QQGpzTRiKDKNwP+Wit4odrhp8LXi0wwTfdbPx5iQWiQcdVR5WFy9NzuDP1wPD2qb65LX
         T1HPau6+PBVr6IoD5FoAbPxNiIX7AO+T52z28Qo7xDB83bg35kZzvNf7Z4kaLcUwqcFl
         lTxA==
X-Gm-Message-State: AOJu0YzxUSEW0SgQkBiw7oybOR2EMTSIW4hv4qC2kBL4GMFTCB+dN4O/
	dOYgr1GG9AdC5GM//MmDw5r+2fBlFLrW7RH/J7qngzr/4w2va25dppDHQBipCKhRMVjOxYOzsfV
	fiUzjslc=
X-Gm-Gg: ASbGncu2SRMoJaT8c+dQ/OWtLXROuOTOIHl0dsZ1JdLGN55w9Y+G+yVB4S5w0nDLNqq
	LT95ewQPY3DMrbFQZHkgmA7HoCIWj58CxR0pmyxiNlSphCyv/buOjGOUiH0NQULBl45ngBMSgpX
	VBaOl004QVC+IHvyBaUhc0AWwM6YFL7tmVcoedek6iJ0ak7mMqHhYhAypt4eTZz6mifn6L6V01E
	LxUkn7emlbSnxH+lfl260grWBANQ1tW9Uc4BUOLOnkKe3lkZRhGnG23sPXF1SLwnWIeZgbLQX38
	0EekjO93wuusgNo883UT4vq3561cl7KiusGwvFoiLVAbehxhzn35U9DNVCP9zu3cmu1ki3mdJco
	GWScbvNN4MX9MSLi+dg6iKSPLbzRs21hofhy/6BeF
X-Google-Smtp-Source: AGHT+IFm31LlaDxWZNOTmGKMRxjj7GfD6x/Sl6K6iyHGE4l+Ux54F7NbWAkRGjMt4hurmB2X+6G7jw==
X-Received: by 2002:a05:6402:5c9:b0:5fc:9979:78f7 with SMTP id 4fb4d7f45d1cf-606f0b66b7bmr3141773a12.14.1749060164355;
        Wed, 04 Jun 2025 11:02:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:204c:fb2e:c462:29df? ([2001:8b0:aba:5f3c:204c:fb2e:c462:29df])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60567169d14sm8972144a12.74.2025.06.04.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:02:43 -0700 (PDT)
Message-ID: <0944f7e3d239cad26fec3d2eb49f0a2342a73c50.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Parsing speed/efficiency, native class
 extensions and the expand cache
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 04 Jun 2025 19:02:42 +0100
In-Reply-To: <1845E4E00D65053D.10841@lists.openembedded.org>
References: <1845E4E00D65053D.10841@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 18:02:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17683

On Wed, 2025-06-04 at 17:47 +0100, Richard Purdie via
lists.openembedded.org wrote:
> Going back in time, Joshua and I discussed the idea of a [filter]
> function being applied to variables to try and avoid this kind of
> problem. Given how horrible the above is, I think it may be time to
> look at that again...

I did managed to find the discussion I'm referring to:

https://lists.openembedded.org/g/openembedded-architecture/message/1054
https://lists.openembedded.org/g/openembedded-architecture/message/1061

Cheers,

Richard

