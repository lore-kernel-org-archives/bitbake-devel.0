Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB551CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 13:44:58 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17375.1762868693232875223
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 05:44:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fHqQJYug;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: alex.kiernan@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59469969bfeso2387013e87.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868691; x=1763473491; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUuVjx6Jg1gqPQl0zGo73rBJXhfkCSeRQabO1BNLArY=;
        b=fHqQJYug/9Mbi9Ppy6ksUvMi7/Pg6qVG63kmukPPWOdZ4VObNdccTSGzA2F6aiqxLC
         FLz/u2GhQXjSukjL0a1dewjvodH6x9BLawQorlK26QF+t8NZ+syYsnFR4WzT5ADM80rr
         9OHHks3OkKvmwJu9lhYet14t/Ko50zZ44tOFLNxLkX5E51EOMzuXbKbdfK3AjwRH9T3p
         JUD4hUziWOuMMMW7NgW6iKlUz1NnWryYjmVAmDTUzwjcY7gc68peQAHlnefenPtYVEfz
         7Hqgp5FHdG19dAjmdvI+LCzrTvJpaBKEuJDdRu0UVsokb3EX337kDd4OFRTTW4Uu++2e
         iNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868691; x=1763473491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUuVjx6Jg1gqPQl0zGo73rBJXhfkCSeRQabO1BNLArY=;
        b=LWRPcCMkBzktyCSm6hVXu23p5He1DDWrllIcjavpGVkit2gH1UPtxMVG7tew//kZcs
         bUWpO1zViYwoy/m/VQHyrgqnUqqVQgOaY5LEQHoIw+k9i3asPSuzwOVSh01yp491AT35
         YliKZmix02sM3oBUQyEbM9nchOzgnLrO80YCDmSy6sXSiuFSzxFPR88p5Fuy1vA/RbGs
         3c1MWLT6+ld4+5ha3gAbo9zc9bB107yFKWfEwNXrEpk8giWWICCZVr8bBxMdjnsl5xRZ
         5HTUmnCEyG49f8uF0GsNl0bKZb/2acrR5Tsuf1iWcsuF84Sy5r17O6FWTVNcn/EearXB
         b3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUB58mKTkgdO5odh+VL5gN/XxUoBeY5XnNSsf1o1d9OjBYPTt3FPGBRNqVNsHGEiJW0VmmZFW8kMVlBTyaJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YxshpmASK0Mmy1FuZD5QqL+nqnAhJd1T0EnIsDxwvX7fDU0UUy9
	ewxZkpxq7yPDLNha2HQOCMUb8M6Dpdflaf4mVuME+Ext0nOeaCmGEHScDgN4r8+3iwNyjMc4woh
	gtqTZtHyFYm5PLKEfswDwhCUKqQOsrns=
X-Gm-Gg: ASbGncuDYvcRyx2qPdq0bgkOjBzDgWz0EXE65Nw7h5D2sxGp12J9xVluug4D8GAOrUq
	FSJE0bbIzKuc68qCsi1FfdlFow41NCQMk4opK+Emt7h0nyGCJX3lH6a5uOjR+GsO2ENmgmEeXRh
	i4tS2worDxZCQXGNh6pVkt6fN+CHO6xpc1GwHRPyMjYTUbmL/F0h1lAlaeyiy2tMcCkTA1Gl4x1
	A+pvv3FJtKWnRYdczZb2TtHBO3x0/12hGkctVzc51EdTEEUYIu+B4mmVCKyI79g+1ZA3Q==
X-Google-Smtp-Source: AGHT+IGxJq8Tb0OMDUogwy8YQYyo7ovI/02XFo6ESb2wqEpx0VFJaEKvAiE3YHFCIout/7Ogul/V3vafEtpDZmL3BB0=
X-Received: by 2002:a05:6512:3a8e:b0:592:f6ea:24fe with SMTP id
 2adb3069b0e04-5945f1b79d7mr3659837e87.40.1762868690910; Tue, 11 Nov 2025
 05:44:50 -0800 (PST)
MIME-Version: 1.0
References: <29595a8ed6b004a981a82b14abf8e60592b14777.camel@linuxfoundation.org>
In-Reply-To: <29595a8ed6b004a981a82b14abf8e60592b14777.camel@linuxfoundation.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Tue, 11 Nov 2025 13:44:39 +0000
X-Gm-Features: AWmQ_blYzfNZf9pTMKvxtHPi0Wy9ysmOSNXNGKSAhHtv-doBdoLh4RlbKcg3bxk
Message-ID: <CAO5Uq5SnV4d1ygktpOqkvXk6iCcjhJ9Wh97iM9av8qXK2C048g@mail.gmail.com>
Subject: Re: [bitbake-devel] YP 5.3 Release readiness - not there yet
To: richard.purdie@linuxfoundation.org
Cc: openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 13:44:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18321

On Tue, Nov 11, 2025 at 12:07=E2=80=AFPM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> Having gone through trying to use bitbake-setup again, I'm sad to say
> that this isn't ready yet.
>
> The basic structure is there and is good but it has significant rough
> edges that cause usability problems and putting this in front of new or
> existing users is going to do the project reputation harm.
>
> I don't mind rough edges, but not when they're at the level they're
> currently at.
>
> I appreciate saying this instantly puts the pressure on me to say
> why/where it has issues and how to fix them. I will try and provide
> some thoughts on that but I am pretty burnt out at this point and not
> at my best. It is frustrating that I'm the one having to say this and
> that in saying it, I just make things worse for myself but it is what
> needs to be done.
>
> I had hoped more eyes, working through the docs and so on would let us
> get through this but as yet, that hasn't happened. I don't think we can
> release until we're in a better state.

I started swapping over local builds to bitbake-setup this week, for a
basic qemu core-image-base it was impressively straightforward.

But I've immediately run into things where I know how to do them in
the old world, but not the right way to do them in the new[1] and
failing to find answers in the docs, which isn't to say the answers
aren't there, I've just not found them.

If there's things I could usefully help with documenting/testing, I've
got time on my hands as my current contract is on hold...

[1] how do I add a layer which hasn't been migrated to bitbake-setup
was the first I hit

--=20
Alex Kiernan

