Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB765C4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 15:32:56 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.24957.1671463967662278162
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Dec 2022 07:32:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=LaWu9uYu;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id o6so9314532lfi.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQrOrk65BqGxWy1ywwIC6NrV14D6CGLB4LjFHdarXGE=;
        b=LaWu9uYu4Yfk1wB6J/sanQTysN8JGws8L6vx/2rqQiw/AQU8XkrkGXa3Ue2L2MsoFp
         Z+AkYzT77BkBwfdIHK6twcE5UEgwSJN/zFTOmwaOGDsr3QqztAByAF7FHvO67x80BAQK
         6ErMW3lQcppJO/TcB6GnFRMJhtr/BF7yZQTItLHmvdcMuQDUDARHPPfgy2gqSWTWqnbG
         PCrYauhqZAA7nUUTLCq0XtkqCcFAn65RCmZP6rMohc+ogr0slWj+Ucx2bXqnuI1pgrPU
         KH/YE80MC7Aci3VEe3Y+r0BTXeAenqUpBa5GMis7HkDdB7PauOfZv2H7yYRTTFwplyVy
         w0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQrOrk65BqGxWy1ywwIC6NrV14D6CGLB4LjFHdarXGE=;
        b=mDmcK6u8WUOsJjIolr1vwFIR7PC4NoYaD0mEuQUVf+lg2Vi0nAv4NIPs/gd2AmE0m4
         tMiOosFjbtY371sH6PumifuHCqsdnfCajTCgumPyohgIE3XnRXOxrov56K0tPj6KoHn6
         g3eLyma68xeNRxHyCLK7tSSnTOf5k5syKPIyM9PmKbomMurQfHLmgCL/GTL9tJHTd9oW
         vXlv8GMzTSulD6NwNHvr6mbme1S+51OnQpvN6fHjVEzj8MbK3NuN6afTDE8DykWyElxV
         njq59X7LcY0P5QY1aKgL226bSAeqNW7uyFzuIlYaz2IWgm21GU6uJM3pHYqGmO2+HVCM
         Dtjg==
X-Gm-Message-State: ANoB5pkV9EdVqSSmM05frWjB5fFyJ2dpzYNQ2lMa4xed//b4hiVobb3T
	zYJLrAgiSTMZ7i+3ZOiYgn2Ntps3aDp9ECU5FLY=
X-Google-Smtp-Source: AA0mqf6GIfAs6fUIeKJNP1bQAr+YwTWf1IBHmdrqBamRUjMT+KJ3Gb+GTLbqyMo0AtQISG8W9x6JW/m2AsBWvsVm350=
X-Received: by 2002:a05:6512:2616:b0:4b6:ec96:bb9e with SMTP id
 bt22-20020a056512261600b004b6ec96bb9emr1573009lfb.445.1671463965318; Mon, 19
 Dec 2022 07:32:45 -0800 (PST)
MIME-Version: 1.0
References: <a7e199839adbd9e003c04d1bd021f5f0d8f2cc3c.camel@mercedes-benz.com>
 <982d94511de46a7c9e7eed63c1c1cdc89d4ca816.camel@linuxfoundation.org>
 <b1673e9c84e6591180a8c61bff567f2b277db8bf.camel@mercedes-benz.com>
 <e0dae82564a29b196c726549b0ccdfb859f0b455.camel@linuxfoundation.org>
 <a3b91a24ffd214b3391bbe2fc27489d0787f2ba8.camel@mercedes-benz.com> <3aa88f6679bd48852ae6cde765eb840ccec648b6.camel@linuxfoundation.org>
In-Reply-To: <3aa88f6679bd48852ae6cde765eb840ccec648b6.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 19 Dec 2022 16:32:33 +0100
Message-ID: <CANNYZj8jp_KH87w_QM0fo45_LzroJWER+zNys6tvDRrUA1KxTA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] wget: Add CHECKMD_wget option
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: alp.oezmert@mercedes-benz.com, bitbake-devel@lists.openembedded.org, 
	changhyeok.bae@mercedes-benz.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 15:32:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14205

If the problem is in having to provide a magic corporate certificate,
we can adjust the existing urllib code so it can be supplied?

Alex

On Mon, 19 Dec 2022 at 16:02, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Mon, 2022-12-19 at 14:57 +0000, alp.oezmert@mercedes-benz.com wrote:
> > Hi all!
> >
> > On Mon, 2022-12-19 at 14:26 +0000, Richard Purdie wrote:
> > > [**EXTERNAL E-MAIL**]
> > >
> > > On Mon, 2022-12-19 at 13:44 +0000, alp.oezmert@mercedes-benz.com
> > > wrote:
> > > > On Mon, 2022-12-19 at 10:58 +0000, Richard Purdie wrote:
> > > > > On Mon, 2022-12-19 at 08:55 +0000, alp.oezmert via
> > > > > lists.openembedded.org wrote:
> > > > > > `CHECKCMD_wget` defines a command that the wget fetcher module
> > > > > > will
> > > > > > execute
> > > > > > instead of the built-in HTTP client when checking if URLs
> > > > > > exist.
> > > > >
> > > > > This says what the patch does, but not why. I can read the patch
> > > > > and
> > > > > see what the code change is but I can't know why we need to so
> > > > > this
> > > > > information is much more important for the commit message.
> > > > >
> > > > > >  This
> > > > > > allows to completely match the behavior of the wget fetcher
> > > > > > including proxy
> > > > > > and authentication.
> > > > >
> > > > > We're changing the behaviour of the wget fetcher to match the
> > > > > wget
> > > > > fetcher? This doesn't make any sense.
> > > >
> > > > The proposed change adds an option to change behavior of wget
> > > > fetcher module `fetch2/wget.py` during checking step
> > > > (`Wget.checkstatus` function) so it can match the fetching behavior
> > > > that uses `.wgetrc` .
> > >
> > > The *key* piece of information here is wgetrc. At least I can now
> > > understand your issue, that kind of information should be mentioned
> > > in
> > > the commit message.
> > >
> > > > > > By default, this option is empty, and wget fetcher behavior is
> > > > > > not
> > > > > > changed.
> > > > >
> > > > > Why do we need this? Why can't the HTTP client be used?
> > > >
> > > > During downloading, the `wget` command is used and this includes
> > > > the
> > > > configuration in .wgetrc. During the checking that precedes
> > > > downloading, the built-in HTTP-client is used but it doesn't
> > > > support
> > > > all configurations of `wget`, for example authentication with
> > > > client
> > > > certificates or proxy settings.
> > >
> > > bitbake and this code will handle settings for http_proxy in the
> > > environment for example. You are correct that the checkstatus option
> > > isn't going to work for all (or any) settings in wgetrc though.
> > >
> > > The problem is you just added some code which means we have to
> > > document
> > > that:
> > >
> > > "If you use a wgetrc file, you must set CHECKCMD_wget in order for
> > > checkstatus to work correctly for your SRC_URI".
> > >
> > > Clearly it doesn't make sense to have the user need to set such a
> > > variable in order to make checkstatus work. As such this patch is
> > > therefore not the right solution.
> > >
> > > > > What this appears to do is add two different code paths meaning
> > > > > we
> > > > > need
> > > > > to double our testing. I really don't want to do that.
> > > >
> > > > The change contains two new test cases that pass:
> > > >
> > > > ```
> > > > ./bin/bitbake-selftest -k test_wget_checkstatus_external -v
> > > > [...]
> > > > test_wget_checkstatus_external_auto
> > > > (bb.tests.fetch.FetchCheckStatusTest) ... ok
> > > > test_wget_checkstatus_external_wget
> > > > (bb.tests.fetch.FetchCheckStatusTest) ... ok
> > > >
> > > > -----------------------------------------------------------------
> > > > -----
> > > > Ran 2 tests in 13.510s
> > > >
> > > > OK
> > > > ```
> > >
> > > I'm not convinced this is a very good test.
> > >
> > > a) Whilst you test the new variable works, you don't test whether our
> > > other tests work with/without the variable set. Can someone set this
> > > and have all our other functionality still working? If so, why
> > > shouldn't we drop all that other urllib code?
> >
> > I am indeed wondering the following:
> >
> > - Was the intention by the urllib code to gain execution speed by
> > connection pooling?
>
> It was one of them, yes. In particular, the sstate existence checks are
> done with this fetcher code and we need to make several hundred of
> those at once in a timely fashion to give a reasonable user experience.
>
> > - Are the advantages of the above worth the different behavior between
> > `Wget.checkstatus` and `Wget.download` as the latter uses the `wget`
> > command?
>
> Yes, the advantages were significant.
>
> > A design decision to drop all `urllib` code for the sake of uniform
> > interface and unix composability would make sense to me, but this is
> > just my point of view.
>
> Much as I also like a simple life, we do need the performance that code
> offers and I suspect much of the userbase would not want it removed.
>
> Cheers,
>
> Richard
>
>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14204): https://lists.openembedded.org/g/bitbake-devel/message/14204
> Mute This Topic: https://lists.openembedded.org/mt/95761427/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

