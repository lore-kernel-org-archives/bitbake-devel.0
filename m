Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E54C43334
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 12:27:53 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web09.17260.1655382469787621283
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 05:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PjDdy2/u;
 spf=pass (domain: gmail.com, ip: 209.85.218.47,
 mailfrom: alex.kiernan@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id fu3so2475398ejc.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVGG2/69kXhEMScT0L8/pmo0HykJ4eLLuzeE/w0RS38=;
        b=PjDdy2/u2xR3Ca1Y0heW1MYe3ngRBNqFciOqtnHrzXmpkYCGOkqZc32nh2iMX0/7kN
         dp0lCq+qpOEJ65/b5NfL5CO/r1g2CCP8w9A3mnNcA/NPkrILILL/QTvK0Y2NZ+Fi+aIF
         nXbHbTirOxDV39MnJCR4AdTWkPQMMZ3zpoVZKbi5ChYU4jmxSrBKgdXM/WKUo78+OzeY
         FSNkJABCRzdzjKMgofujeIeTLe5tU7vY+oopb3TvIdtlxhr29AVNx8luwCgfVLCRWNlD
         BpYMsbUFYyZSgfFAle5ybf1/GhvUf6FnIqxR37bJpbPuBh5hnqmBRSSzC5ksT4eTmj4k
         gWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVGG2/69kXhEMScT0L8/pmo0HykJ4eLLuzeE/w0RS38=;
        b=IZaPTH9RelgZXEy2S51WUm0ay0KESWfRdbRT75tHeZGWi0tv4FeYblAwezwR109359
         lZ7uxoI23JYi+sbFi0Pc9LgWu+tmn8A/gPE6iUHV5a48/nPPnG1noI/uEYVPM4qOUrLB
         DhwsqeV7xFbWUy+DlbWgaSJdDiJ6rM3j3kzmkhOuYMoiJjKceRH/pSd5Clh2Ysrf3Urc
         OQgKGScHu3dv1jFMAiY6c+1gaSL6JOvzbpWMX5olukvLKgkuxS9WILD1XLll5D4RZ55i
         ZUg6/YyZgAcCXAgxmguyWIlImEuU5KzdRxV0SB6HSosCA/OsNZNxh6+GPREhB8hFpmLi
         2jKQ==
X-Gm-Message-State: AJIora+aR4ob/CHEI57JAULpTVoLgAbT+q0y0gQOuU+i5GaofTJ0wuLa
	XNRtmF8XjKf/R725bQzAhc9emOP0bJZeLGNxrwM=
X-Google-Smtp-Source: 
 AGRyM1vGVN7s45ZmXRzOQP7FhvWg+oKARMOniesZvgBA6fFU9FMFVwPtWIrYSyCdWPpZ3Ty3CCm/88PxSOmSWTB0GIU=
X-Received: by 2002:a17:906:8454:b0:711:c970:227a with SMTP id
 e20-20020a170906845400b00711c970227amr4310711ejy.4.1655382468197; Thu, 16 Jun
 2022 05:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220609070631.23346-1-alex.kiernan@gmail.com>
 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
 <16F6ED45D7C68CA7.32696@lists.openembedded.org>
In-Reply-To: <16F6ED45D7C68CA7.32696@lists.openembedded.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Thu, 16 Jun 2022 13:27:36 +0100
Message-ID: 
 <CAO5Uq5SxhRhpRGyD4PoXm3b2Edtzy=tgGWkRFpjKRikFgsW+mg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Pass flags through variable
 rename
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org,
	Otavio Salvador <otavio.salvador@ossystems.com.br>,
 Alex Kiernan <alexk@zuma.ai>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 12:27:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13767

I've been thinking around this, I guess the bit I really want to work
is for flags to survive through variable renames, rather than
overrides, but the two use cases do tend to collide as we often have
overrides with variable expansion, which is then renaming...

Just realised I c&p my example from our vendor branch which is still
on _ based overrides rather than : based ones, but both seem to work
for me.

On Thu, Jun 9, 2022 at 11:33 AM Alex Kiernan via
lists.openembedded.org <alex.kiernan=gmail.com@lists.openembedded.org>
wrote:
>
> Not that I've found, but I'd really like to use it... I've a layer for
> s6-rc (https://skarnet.org/software/s6-rc/) and defining the
> configuration using this syntax works really well:
>
> S6_RC_SERVICE_${BPN} ?= "longrun"
> S6_RC_SERVICE_${BPN}[producer-for] ?= "${BPN}-log"
> S6_RC_SERVICE_${BPN}-log ?= "longrun"
> S6_RC_SERVICE_${BPN}-log[consumer-for] ?= "${BPN}"
> S6_RC_SERVICE_${BPN}-log[notification-fd] ?= "3"
> S6_RC_SERVICE_${BPN}-log[pipeline-name] ?= "${BPN}-pipeline"
> S6_RC_SERVICE_${BPN}-log[run] ?= "${@ d.getVar('s6_rc_log') }"
>
> Is the kind of thing I'd like to work.
>
> On Thu, Jun 9, 2022 at 10:58 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > On Thu, 2022-06-09 at 08:06 +0100, Alex Kiernan wrote:
> > > During variable expansion, the flags are not passed through but are
> > > discarded which makes constructs such as:
> > >
> > >   ALTERNATIVE_TARGET:${PN}-foo[name] = "value"
> >
> > This is a tricky one. I don't think we've ever supported overrides and
> > flags combined? Is this in use in metadata?
> >
> > Cheers,
> >
> > Richard
>
>
>
> --
> Alex Kiernan
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13747): https://lists.openembedded.org/g/bitbake-devel/message/13747
> Mute This Topic: https://lists.openembedded.org/mt/91640731/3618097
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kiernan@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
Alex Kiernan

