Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B8CC4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 14:27:06 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.23245.1671460017540510799
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Dec 2022 06:26:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YYjQG8Fg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id bg10so6542867wmb.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jOYqQDo6HSWik44O6CJW8X0IIJH6mXNZnMNnmwdMm0o=;
        b=YYjQG8FgpdaW/zea4t7EIo3GBBOq9xTyR9rlaoDeNXbqhTQFXGdsMThdlDfwJEfVTp
         /e7vToAokfBjeNZg8gq/MTHNhSZAZFYO6NhvJpVkorX3ojHLS8h6UU64QSrzRH524j5t
         rJiXabZ6rWLtkB0iL4uAF8ktsCH2+stE5zaL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOYqQDo6HSWik44O6CJW8X0IIJH6mXNZnMNnmwdMm0o=;
        b=6g1V0DKFAXWMVoV4FMvcTU6BsEm4Y8OhVq4zIKXZPdedlnNYGfXELFI6R3mn2eIAqF
         sbgFmX9I7ubw3A89AF4yZ+yA8rLlCrXPcJkpKODYZHEtpsPfqyxAhWLkgOzEF3fS/hbE
         zbEGNp8IcBVQBCq91252oCQtxxLcP7YirQYrajWxGWPYUwbNzsAIlGNPSoaDaEt1TGVe
         nB9c+N7UMuz92j1wNfT0mimY0BMzvj3Q8RWJsSryFdBv9tUpM4EVYQ8rGiK0r+1fPo4e
         gpa4d5e5MR5ByXkjxGsHo6JmPEvfFTBNp95DPQ6LOC20AT5WwPE2SbPSP3jsw8Usxgvn
         NuZA==
X-Gm-Message-State: ANoB5pk5LIPVYvdZd+UkIghbeupvkBtJVJCClugjIBr97z/eICC65hcr
	Ocn6rhVOKlBo6tBZARQYOQ/eOOeAGcyYfIAL
X-Google-Smtp-Source: AA0mqf4ukNPIiQhrRDF4ZZZW92AXzAmoYWeRhdmfDP9RkiTmWkZWPnztjb+/TS3CYtNEIl71MgMXTw==
X-Received: by 2002:a05:600c:654e:b0:3d0:6a57:66a5 with SMTP id dn14-20020a05600c654e00b003d06a5766a5mr32801998wmb.0.1671460016000;
        Mon, 19 Dec 2022 06:26:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac4f:7328:1210:6c79? ([2001:8b0:aba:5f3c:ac4f:7328:1210:6c79])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b003c6f1732f65sm22158065wmq.38.2022.12.19.06.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 06:26:55 -0800 (PST)
Message-ID: <e0dae82564a29b196c726549b0ccdfb859f0b455.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] wget: Add CHECKMD_wget option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alp.oezmert@mercedes-benz.com, bitbake-devel@lists.openembedded.org
Cc: changhyeok.bae@mercedes-benz.com
Date: Mon, 19 Dec 2022 14:26:53 +0000
In-Reply-To: <b1673e9c84e6591180a8c61bff567f2b277db8bf.camel@mercedes-benz.com>
References: 
	<a7e199839adbd9e003c04d1bd021f5f0d8f2cc3c.camel@mercedes-benz.com>
	 <982d94511de46a7c9e7eed63c1c1cdc89d4ca816.camel@linuxfoundation.org>
	 <b1673e9c84e6591180a8c61bff567f2b277db8bf.camel@mercedes-benz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Dec 2022 14:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14202

On Mon, 2022-12-19 at 13:44 +0000, alp.oezmert@mercedes-benz.com wrote:
> On Mon, 2022-12-19 at 10:58 +0000, Richard Purdie wrote:
> >=20
> > On Mon, 2022-12-19 at 08:55 +0000, alp.oezmert via
> > lists.openembedded.org wrote:
> > > `CHECKCMD_wget` defines a command that the wget fetcher module will
> > > execute
> > > instead of the built-in HTTP client when checking if URLs exist.
> >=20
> > This says what the patch does, but not why. I can read the patch and
> > see what the code change is but I can't know why we need to so this
> > information is much more important for the commit message.
> >=20
> > >  This
> > > allows to completely match the behavior of the wget fetcher
> > > including proxy
> > > and authentication.
> >=20
> > We're changing the behaviour of the wget fetcher to match the wget
> > fetcher? This doesn't make any sense.
>=20
> The proposed change adds an option to change behavior of wget
> fetcher module `fetch2/wget.py` during checking step
> (`Wget.checkstatus` function) so it can match the fetching behavior
> that uses `.wgetrc` .

The *key* piece of information here is wgetrc. At least I can now
understand your issue, that kind of information should be mentioned in
the commit message.

> > > By default, this option is empty, and wget fetcher behavior is not
> > > changed.
> >=20
> > Why do we need this? Why can't the HTTP client be used?
>=20
> During downloading, the `wget` command is used and this includes the
> configuration in .wgetrc. During the checking that precedes
> downloading, the built-in HTTP-client is used but it doesn't support
> all configurations of `wget`, for example authentication with client
> certificates or proxy settings.

bitbake and this code will handle settings for http_proxy in the
environment for example. You are correct that the checkstatus option
isn't going to work for all (or any) settings in wgetrc though.

The problem is you just added some code which means we have to document
that:

"If you use a wgetrc file, you must set CHECKCMD_wget in order for
checkstatus to work correctly for your SRC_URI".

Clearly it doesn't make sense to have the user need to set such a
variable in order to make checkstatus work. As such this patch is
therefore not the right solution.

> > What this appears to do is add two different code paths meaning we
> > need
> > to double our testing. I really don't want to do that.
>=20
> The change contains two new test cases that pass:
>=20
> ```
> ./bin/bitbake-selftest -k test_wget_checkstatus_external -v
> [...]
> test_wget_checkstatus_external_auto
> (bb.tests.fetch.FetchCheckStatusTest) ... ok
> test_wget_checkstatus_external_wget
> (bb.tests.fetch.FetchCheckStatusTest) ... ok
>=20
> ----------------------------------------------------------------------
> Ran 2 tests in 13.510s
>=20
> OK
> ```

I'm not convinced this is a very good test.

a) Whilst you test the new variable works, you don't test whether our
other tests work with/without the variable set. Can someone set this
and have all our other functionality still working? If so, why
shouldn't we drop all that other urllib code?

b) The test also doesn't touch on wgetrc at all which is the original
problem, so we're likely to continue to break that in future.

> > Can't the inbuilt http client code be fixed to work with whatever
> > auth/proxy issue I'm guessing you're running into?
>=20
> As far as I can tell, not on the short term.

I suspect we'll need to look into that as the patch as proposed isn't
appropriate.

>=20
> > Cheers,
> >=20
> > Richard
>=20
> Let me know if you would like to have changes to the commit message.

The commit message is wrong and would need to be fixed but this needs
more than that to make it acceptable to merge as I do not like having
duplicate overlapping code paths with partial functionality each.

Cheers,

Richard


