Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB3C4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 15:02:56 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.24028.1671462172138330499
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Dec 2022 07:02:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=At58Cclw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f44.google.com with SMTP id j4so14136329lfk.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KH41Z1vAnlByW+F5+Y5cyPhAxQs3SlxUdyvacHtRyTI=;
        b=At58CclwzFDe/kmuPc+N4/iZErWrREpW5wW2X0RD8LNDOaeGJRUW+gJ2a83e2KgGTo
         FeFEKwg8TXlSpA05YgIDY+jvuGwvklecJrBVcCkhnMQD0+cb2xL5yz5S+zHkB3UAwlf2
         TZRi3C2LOxmF6NDwNLEqes7ioR634ODxh5vco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KH41Z1vAnlByW+F5+Y5cyPhAxQs3SlxUdyvacHtRyTI=;
        b=IE2YvLFZAKbAAArkYhryswzStbASM+lXaqh5xe8bgDuMXkL9/hgCcC+EV4vgdmUsme
         35Z5SbbHxZF3W3tIGAHmwGUrzekTS1qb9i1q1GA/g66JMPaNR6aFf/AXYYtBE6+048WF
         +NkBKv9RX2MGYtLhfy/Fx0cQbkdz5lwySJF1K8nCjoOo+SSDqwAngDpmL+vJbyayOYQ2
         W5z5hOzY55RAvi5qnz1J2LkphCo8LCFP+lWNeHxQgYwmZRkKM4XgME/2Vm4rVxRiKtOP
         Biu9VD/Ra/7Z4BRgporU18pqCC0lp4KuJd/Qnig59LtNFspiXI2OW/Yl2Pb+rz0CbJPX
         sotQ==
X-Gm-Message-State: ANoB5plfJ7ePqr/IStcC4Ef04WBoQR1+TrtGDDe+5QzvmV6HVeNnlzPQ
	GQI8bXdF5kKm6+ruz0GeQQx+5w==
X-Google-Smtp-Source: AA0mqf60/UcZ1QQHdX93wFqZL1GmQi08y+TctcVvTVAC93YCi2KjkKtExbMZc4AntltWhQvXQNCxPQ==
X-Received: by 2002:ac2:5a44:0:b0:4b5:6649:eb6c with SMTP id r4-20020ac25a44000000b004b56649eb6cmr16924218lfn.25.1671462170209;
        Mon, 19 Dec 2022 07:02:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac4f:7328:1210:6c79? ([2001:8b0:aba:5f3c:ac4f:7328:1210:6c79])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b002365cd93d05sm10295036wrs.102.2022.12.19.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:02:49 -0800 (PST)
Message-ID: <3aa88f6679bd48852ae6cde765eb840ccec648b6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] wget: Add CHECKMD_wget option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alp.oezmert@mercedes-benz.com, bitbake-devel@lists.openembedded.org
Cc: changhyeok.bae@mercedes-benz.com
Date: Mon, 19 Dec 2022 15:02:48 +0000
In-Reply-To: <a3b91a24ffd214b3391bbe2fc27489d0787f2ba8.camel@mercedes-benz.com>
References: 
	<a7e199839adbd9e003c04d1bd021f5f0d8f2cc3c.camel@mercedes-benz.com>
	 <982d94511de46a7c9e7eed63c1c1cdc89d4ca816.camel@linuxfoundation.org>
	 <b1673e9c84e6591180a8c61bff567f2b277db8bf.camel@mercedes-benz.com>
	 <e0dae82564a29b196c726549b0ccdfb859f0b455.camel@linuxfoundation.org>
	 <a3b91a24ffd214b3391bbe2fc27489d0787f2ba8.camel@mercedes-benz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 15:02:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14204

On Mon, 2022-12-19 at 14:57 +0000, alp.oezmert@mercedes-benz.com wrote:
> Hi all!
>=20
> On Mon, 2022-12-19 at 14:26 +0000, Richard Purdie wrote:
> > [**EXTERNAL E-MAIL**]
> >=20
> > On Mon, 2022-12-19 at 13:44 +0000, alp.oezmert@mercedes-benz.com
> > wrote:
> > > On Mon, 2022-12-19 at 10:58 +0000, Richard Purdie wrote:
> > > > On Mon, 2022-12-19 at 08:55 +0000, alp.oezmert via
> > > > lists.openembedded.org wrote:
> > > > > `CHECKCMD_wget` defines a command that the wget fetcher module
> > > > > will
> > > > > execute
> > > > > instead of the built-in HTTP client when checking if URLs
> > > > > exist.
> > > >=20
> > > > This says what the patch does, but not why. I can read the patch
> > > > and
> > > > see what the code change is but I can't know why we need to so
> > > > this
> > > > information is much more important for the commit message.
> > > >=20
> > > > >  This
> > > > > allows to completely match the behavior of the wget fetcher
> > > > > including proxy
> > > > > and authentication.
> > > >=20
> > > > We're changing the behaviour of the wget fetcher to match the
> > > > wget
> > > > fetcher? This doesn't make any sense.
> > >=20
> > > The proposed change adds an option to change behavior of wget
> > > fetcher module `fetch2/wget.py` during checking step
> > > (`Wget.checkstatus` function) so it can match the fetching behavior
> > > that uses `.wgetrc` .
> >=20
> > The *key* piece of information here is wgetrc. At least I can now
> > understand your issue, that kind of information should be mentioned
> > in
> > the commit message.
> >=20
> > > > > By default, this option is empty, and wget fetcher behavior is
> > > > > not
> > > > > changed.
> > > >=20
> > > > Why do we need this? Why can't the HTTP client be used?
> > >=20
> > > During downloading, the `wget` command is used and this includes
> > > the
> > > configuration in .wgetrc. During the checking that precedes
> > > downloading, the built-in HTTP-client is used but it doesn't
> > > support
> > > all configurations of `wget`, for example authentication with
> > > client
> > > certificates or proxy settings.
> >=20
> > bitbake and this code will handle settings for http_proxy in the
> > environment for example. You are correct that the checkstatus option
> > isn't going to work for all (or any) settings in wgetrc though.
> >=20
> > The problem is you just added some code which means we have to
> > document
> > that:
> >=20
> > "If you use a wgetrc file, you must set CHECKCMD_wget in order for
> > checkstatus to work correctly for your SRC_URI".
> >=20
> > Clearly it doesn't make sense to have the user need to set such a
> > variable in order to make checkstatus work. As such this patch is
> > therefore not the right solution.
> >=20
> > > > What this appears to do is add two different code paths meaning
> > > > we
> > > > need
> > > > to double our testing. I really don't want to do that.
> > >=20
> > > The change contains two new test cases that pass:
> > >=20
> > > ```
> > > ./bin/bitbake-selftest -k test_wget_checkstatus_external -v
> > > [...]
> > > test_wget_checkstatus_external_auto
> > > (bb.tests.fetch.FetchCheckStatusTest) ... ok
> > > test_wget_checkstatus_external_wget
> > > (bb.tests.fetch.FetchCheckStatusTest) ... ok
> > >=20
> > > -----------------------------------------------------------------
> > > -----
> > > Ran 2 tests in 13.510s
> > >=20
> > > OK
> > > ```
> >=20
> > I'm not convinced this is a very good test.
> >=20
> > a) Whilst you test the new variable works, you don't test whether our
> > other tests work with/without the variable set. Can someone set this
> > and have all our other functionality still working? If so, why
> > shouldn't we drop all that other urllib code?
>=20
> I am indeed wondering the following:
>=20
> - Was the intention by the urllib code to gain execution speed by
> connection pooling?

It was one of them, yes. In particular, the sstate existence checks are
done with this fetcher code and we need to make several hundred of
those at once in a timely fashion to give a reasonable user experience.

> - Are the advantages of the above worth the different behavior between
> `Wget.checkstatus` and `Wget.download` as the latter uses the `wget`
> command?

Yes, the advantages were significant.

> A design decision to drop all `urllib` code for the sake of uniform
> interface and unix composability would make sense to me, but this is
> just my point of view.

Much as I also like a simple life, we do need the performance that code
offers and I suspect much of the userbase would not want it removed.

Cheers,

Richard





