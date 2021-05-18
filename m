Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.6563.1621332957065578201
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 03:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=egyM2iuC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id z17so9547636wrq.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 May 2021 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=boZ+5MLY2/rAYach0CPcnHZfGrj+fA9/FCLewLWlhbw=;
        b=egyM2iuCJeVsX18QR8UNpOf28ulLkJlEVU2WH7l+ZY1uEZJWuGhEhQ0Qzhps3vWR2f
         KunZCmifnPTHcJCS6bwEk58qe35Wvlb1TI5uyFHmcC+r53AjsSUu/86WmdSo5knPjLdN
         14pgMLeE59yDEVmQ7C+DYwCu4Ip7DlHCfKjok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=boZ+5MLY2/rAYach0CPcnHZfGrj+fA9/FCLewLWlhbw=;
        b=W1hK5a5YSMIekmVoFu1h6+/H8IDAtO3DviZS10x9kD4SFQ1ZVesWYLXorPiJ7SNxGg
         NJZTjRbbD1TnVx4N+MmNQ7Lf+R8kNYVzQslbXTWuMgCceSmNKauyu/7EetVu+UC51G/f
         xZgapSvhDkevi3CTFgenCYhoY+8eBjDGyBA3pFYVhqqrkfnrLKmaGXDfhCal4af/dXVl
         EkgVK6Qwk5YuUahqJk/Z2KQmOi7BLIZxdJQnajoZ6EgkZ4M6PXItB797dKzipXgQqIcw
         QVBrT4wO/ORtbHThImOnNY/raMiHpGqPnk6/xkufdOowb0ijGX2zF5kdMqOHodiCE9tP
         qo+g==
X-Gm-Message-State: AOAM5310tje4dX8QAfdDnOP4ets3W0d/841ZBMui3YmIb9D/BKlFS3TI
	xnabSSZwkA2cT2H7Yy+BG41lQQ==
X-Google-Smtp-Source: ABdhPJxhNw0dv75ol8+N00AB/Rs9Le3yw87ScAokLwABLOJ48UhZ14fTmphh79GOzlZasAUD5+xN3w==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr5818105wrr.116.1621332955509;
        Tue, 18 May 2021 03:15:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:c468:ba30:74bf:a356? ([2001:8b0:aba:5f3c:c468:ba30:74bf:a356])
        by smtp.gmail.com with ESMTPSA id k6sm2097547wmi.42.2021.05.18.03.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:15:54 -0700 (PDT)
Message-ID: <fe1b786526dde755e75fcaac941dfaea4b10ce05.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 May 2021 11:15:52 +0100
In-Reply-To: <a1696027-fdc3-e705-b4be-871840d14940@windriver.com>
References: <20210514060443.33335-1-mingli.yu@windriver.com>
	 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
	 <a1696027-fdc3-e705-b4be-871840d14940@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-05-14 at 15:36 +0800, Yu, Mingli wrote:
> 
> On 5/14/21 2:16 PM, Richard Purdie wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Fri, 2021-05-14 at 14:04 +0800, Yu, Mingli wrote:
> > > From: Mingli Yu <mingli.yu@windriver.com>
> > > 
> > > Make sure the uri added as expected in some scenarioes such as
> > > with below setting:
> > > 
> > > PREMIRRORS_append = ".*://.*/.* git:///net/SharedImage/downloads/git2/MIRRORNAME;protocol=file"
> > > 
> > > Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> > > ---
> > >   lib/bb/fetch2/__init__.py | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index cf0201c4..6701654b 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> > >       uri_replace_decoded = list(decodeurl(uri_replace))
> > >       logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
> > >       result_decoded = ['', '', '', '', '', {}]
> > > +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
> > > +        uri_find_decoded[0] = uri_replace_decoded[0]
> > >       for loc, i in enumerate(uri_find_decoded):
> > >           result_decoded[loc] = uri_decoded[loc]
> > >           regexp = i
> > 
> > I've not thought too much about the fix itself but for these kinds of changes
> > we do ask that the tests be updated too in lib/bb/tests/ (run with bitbake-selftest).
> 
> Hi RP,
> 
> I think the current testcase(lib/bb/tests/fetch.py) is enough if this 
> patch doesn't introduce regression issue(run with bitbake-selftest).
> 
> BTW, the patch solves the problem which I stated in the comments.

I understand that. My point is the test suite passes now and doesn't test the issue
you're reporting. If we trust the test suite to be complete, your patch isn't needed
and the code all works.

Obviously the test suite is not complete and needs something adding to it for the
issue you're reporting.

Cheers,

Richard



