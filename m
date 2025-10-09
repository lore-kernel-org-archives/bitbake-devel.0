Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85060CCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 17:19:58 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.6205.1760030395807158559
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 10:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gRAW52nj;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so12073186d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030395; x=1760635195; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7NlsusxosIP0DmypiMUupyqnnxB71BdhoWJwUv7Kyw=;
        b=gRAW52njVgj1N1i1Y/O85f25haa+ZRBivuQnZLbjnHNW6y4HnTyVyuXnlp/My+iNJi
         /VsU6QE7vf3E+gdOzRYEGE8T+deWkBSeV0viP578nhEkY8LWsM1vKKqy9lzXFEkf31Rb
         vW2EeB7ypmtFWKdbTujLCYJTJ1fHOFFzbXo0lblWSHpM44Zuh8gV7naxtisAALqCNzzb
         hrzmUegDZcL01QUlDozvC8ppWTuFmGuergUf2Y0PEKigk9FogaAjOJXxGjvgmavQ6Un1
         R8tdjRrnXRA7WQowmcHU5x3ImtWD8TJc/upXo5mkDh+8sKCfZq7ezn/jjX1pSyQaCscJ
         59mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030395; x=1760635195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7NlsusxosIP0DmypiMUupyqnnxB71BdhoWJwUv7Kyw=;
        b=Ef4sscp4M9ZTtZKVfbnQjopWP4amALi5GFmSR+IlP71TZ8KwXTOA+r+47r3uEuMrh+
         YI/XzLAQO08u+9AIh5URJigZS4rbTc8mP2uV4VFjlJNB7Bjbi9JQ+s/p4vgQljVI5BQF
         lsvPr0OJBFGQDjext6wc4mChvkjA3w9TEHK4dbHNmTYIIA1+RW2iIVibepBsKCVfHq9J
         PqFQfUpEfqGQla3yY1I+nqvIzfy0GakjGfMFfchiRn6rMvcDVhCgFsOzORlibB5nZk6r
         6uFZ25a8ZEdSUlfPG1UjjBBmaInsHbfaygdrMQ5JjHcG1XlQFHe1A0lIAuH90bZt23F3
         RZ+w==
X-Gm-Message-State: AOJu0YwBKCfdioik75j0KgO8fcZj4rA50GN5WLvVAlqqU5dWm7jhDOSS
	IQVHpTEYM8soYtiFAgwj6bTvJROAXCLImGsJ7d+rbZAF5CA10uB0LlMlugdxUAvkVVtf58x2BUn
	8a/hW9OKcT3w/Sd5qFjVLnDrhk4EbOFqoUg==
X-Gm-Gg: ASbGncv6CZo+FSlVNsWeEK3yoAFRG2EWZ7augMquPI+i6PUpHKvFT4tRtQlGwKbPtSt
	1GYOdqgWKM1kla0AumOf6Zi6kPcUh/BqbNQn5PPMQ1oP5+uiyj80hrs/B/fxm76TNubu1r90evs
	DpGZzayTia7UFVfqI/Wx4TCiuPPcGndVE47aLeNGWD0QlR6gb7evQrLiaWxOPaTVbYjx9k4Ny+o
	cYhJRkjYtDLmKL9gnUv09kEmlc6qpWgnA9wS9LjP7WrtJBqbAekkZggJuF1tHDRkRm6NbYJ7nNe
	z1Tz6kUBTCdwp3b/DO7hm39sieNL
X-Google-Smtp-Source: AGHT+IEqU+s1T1ACyb3+neaFZJKVz12dzwQ70qGpSGUWZO3amc5Xa3rpvOGBzNPORxzgIGewJ9v8jBC9JLgRZjujXFU=
X-Received: by 2002:ad4:5f4b:0:b0:820:a83:eaec with SMTP id
 6a1803df08f44-87b2efb961amr110783146d6.35.1760030394686; Thu, 09 Oct 2025
 10:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251009160717.2527351-1-yoann.congal@smile.fr>
 <CANNYZj-NPGrWypiuh8hU-BB+fM5pVsTh=4ZPOJt6seu-AKN=Cg@mail.gmail.com> <CAMSfU+5=K4oe1P8udCcJG728Nv1VtiCzFmOJzRL5DKi885GFNA@mail.gmail.com>
In-Reply-To: <CAMSfU+5=K4oe1P8udCcJG728Nv1VtiCzFmOJzRL5DKi885GFNA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 9 Oct 2025 19:19:43 +0200
X-Gm-Features: AS18NWDmMPWq3y-G8qqKhfiwanIi7dYfw04U4X8BjF9rVWdrgCqbAFUxc6ruKOE
Message-ID: <CANNYZj_aaEUzAOZboOzbWcmZ0X21dQvJMPc3G17xEp00-Y0MPA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] ast: Better variable history for
 builtin fragments
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 17:19:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18155

On Thu, 9 Oct 2025 at 19:12, Yoann Congal <yoann.congal@smile.fr> wrote:
>> and if users end up setting the same built-in fragments multiple times
>> some other way, that's a misconfiguration on their part.
>
>
> Should we think about displaying a warning in this case (multiple values for the same fragment) ?

I think so, yes.

Alex

