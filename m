Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id 2B9AA78A09;
	Tue, 17 Jul 2018 13:44:41 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id p4-v6so1865243itf.2;
	Tue, 17 Jul 2018 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=w45jwih7LSvwqGYmXtTASA1keYt8hiZLaocI9mhdxM8=;
	b=lW99gvxe6/YoIcye50Dxxq7GOfFdW/1tbOlcGJ5Z5hmkKpW0OVeoWv3Usg07woSRjk
	Z9EPAmjjWhspGmKoIhv66EO78Qv2ps4NJAUr/U7f0lrVtnas8teZc3DHaHi8f6kTX0lj
	RlDApiQdXPM4yFF+wO2MR3wbFKfuHAeEUOi14NQGXlutago/gCnLYle9NpeN+2nCNOtn
	kKfch8IegQQXjFJfol/oobzv6RrjGEW63i2XSXGPOay/EHduuEzy2LnpXrpjFObzt5hc
	FzNVS6GYxnNhnnerpHIMOcvB5Wwyt0Qtz/caEFnuW7WXRNLmx3U4BCX5ehT9Imc3DcTZ
	L4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=w45jwih7LSvwqGYmXtTASA1keYt8hiZLaocI9mhdxM8=;
	b=FHkiTwnl9EcvYuR0MRhNpVED6JxA4UDa+YsDqSEJpv3pdYoFgdR+vq9C+veqC0B1h5
	zCAEAJdQK3Yk1okxkiLzbyKQmPAIjmH8I5kNo0UTruFnPJMyXer43mN55EPGb8/g4cil
	K1Zg2r8jLLiZWYEpnTLvNuUtVM11gMACt5VmNNHy04mDLoyKiGUuE1ukvW7nMoBwnqlV
	7Eve+KM5g5QBTFs//bbx8Ce5zzAFVpGv3i2XWvTk047ctjOhpCyfi+mJ6j9xlr7zKISA
	iNa5TaIZy88XNqRNAapsh+XB2+mZTZlC7z+sBFDzV+cXpwlUeNVD7NZlHjBVBI/ztV3N
	zWUg==
X-Gm-Message-State: AOUpUlGuQTZULWSDUWlCRx+0yPQHesBVPg+YqD1CuxRwKJ362BcaOMrT
	dVb7URY5tJd5oTBzA8qfm90=
X-Google-Smtp-Source: AAOMgpcfrJtLKPjPMMj63p3PyvioyKc0COrWpHeRoIQnqsJg0iQ78x6TOJh1xV6pyiAtA4/I4i5kWA==
X-Received: by 2002:a02:952a:: with SMTP id
	y39-v6mr1567279jah.60.1531835082086; 
	Tue, 17 Jul 2018 06:44:42 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	69-v6sm471889itk.3.2018.07.17.06.44.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 17 Jul 2018 06:44:41 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <69eb1757755a0700789c6d8bb78e8c2a8ea68a0a.camel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Tue, 17 Jul 2018 08:44:40 -0500
In-Reply-To: <c90e84ccea269649256438f026bf97cfeb794800.camel@linuxfoundation.org>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180716203728.23078-9-JPEWhacker@gmail.com>
	<c90e84ccea269649256438f026bf97cfeb794800.camel@linuxfoundation.org>
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Subject: Re: [RFC 8/9] hashserver: Add initial reference server
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 17 Jul 2018 13:44:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-07-17 at 13:11 +0100, Richard Purdie wrote:
> On Mon, 2018-07-16 at 15:37 -0500, Joshua Watt wrote:
> > Adds an initial reference implementation of the hash server.
> > 
> > NOTE: This is my first dive into HTTP & REST technologies. Feedback
> > is
> > appreciated. Also, I don't think it will be necessary for this
> > reference
> > implementation to live in bitbake, and it can be moved to it's own
> > independent project if necessary?
> > 
> > Also, this server has some concurrency issues that I haven't
> > tracked
> > down and will occasionally fail to record a new POST'd task with an
> > error indicating the database is locked. Based on some reading, I
> > believe this is because the server is using a sqlite backend, and
> > it
> > would go away with a more production worthy backend. Anyway, it is
> > good
> > enough for some preliminary testing.
> > 
> > Starting the server is simple and only requires pipenv to be
> > installed:
> > 
> >  $ pipenv shell
> >  $ ./app.py
> 
> I need to spend some time digesting this series but this patch did
> make
> me a little sad.
> 
> I'm hoping we can make the hash equivalence server something people
> use
> easily and perhaps part of bitbake. The dependencies you've used in
> this code mean it has a significantly higher "barrier to use" than
> most
> of our other code though :(

Ah, I didn't realize there was desire to have it actually be part of
bitbake... That would change the strategy considerably.

I think that is a worth while discussion to have. I obviously wasn't
thinking the server would be part of bitbake, I was more thinking it
would probably be an independent project (I even have a name picked out
already ;), so I'm curious what thoughts there are on the advantages
and disadvantages of doing that.

> On the one hand I can understand people wanting to use dependencies
> and
> new technology. On the other, keeping things simple also has
> advantages.

Sure. Pipenv makes it pretty easy to pull in a lot of shiny modules
that you don't necessarily need, and I may have gone a little
overboard. I do have some justification for *most* of the things I
brought in besides just "it looked cool". We can dig into them deeper.

However, pipenv (or python virtual environments) are designed to amke
these types of decisions easier, so I think that the discussion about
what dependencies we do or don't want should probably start there (i.e.
do we allow pipenv or not?). Basically, it's much easier to pull in the
dependencies you need (and even fix versions for production use) with
pipenv. This of course doesn't mean you can be careless about what you
pull in, but it makes you a lot more independent from the host setup.

> 
> Even the minimum python version is potentially problematic, we don't
> even have working recipes for python 3.6!

Oh right! Pipenv defaults to the version of Python you have installed.
I'm pretty sure you can relax the restriction to just "python 3", but I
forgot to do so before I pushed the patch.

> 
> I appreciate its a reference and means we can test the rest of the
> code
>  so its good but we may need a different implementation of this
> ultimately.

I think perhaps my use of the term "reference implementation" was too
strong. "Example implementation for testing", or "toy implementation"
might be more inline with my intention. 


Thanks,
Joshua Watt

> 
> 
> Cheers,
> 
> Richard
> 

