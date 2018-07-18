Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
	[209.85.214.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5DDE678883;
	Wed, 18 Jul 2018 13:53:11 +0000 (UTC)
Received: by mail-it0-f65.google.com with SMTP id 72-v6so4229162itw.3;
	Wed, 18 Jul 2018 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=jpdjHX2FzzZ3gJPd/X/f7qOrDAyu/XhLQH4IyyjvnRY=;
	b=n/VGjmCVA5429kDWObr0rfq8gHKP05nW9YeQXk1fNuXIQ7jWWoxpKHkXH9yC6A91Hc
	8tONCY0CtP4fZ3GRQshc7sWJC1reBy19pr1ey8RHQCgLM2hCGxJEwVsXSRy2YTilD0Di
	3YDW8EIuT/u9ir2hYXnDlinK9ilpBdqlj9/hPE7+o9FGOXXupl8qeu4K5/8GZywsD11Y
	zQbAYEwXP3KgtLE/00K+6DzC2QYtdtAmgOkYj9tpMffxLt7DNSMZiW3MavpaatmWCLkT
	gBWBLqDC0XyQ7340zT2ZHh1fAX59fT5DCAHMG36R2FNgv61LpQsvQEVABzHbBpyVxNy3
	iKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jpdjHX2FzzZ3gJPd/X/f7qOrDAyu/XhLQH4IyyjvnRY=;
	b=iAWgY9szjjrgNzQWWZxoZpj1p1Z2agb0MjGrCQ/5zv+3kwo1l9XvW0AsoTf4HgLHyp
	j4dxL2RlvW18VyJ2YOWiQgLSSRYBCgoiaGTSdNlQ6wlf/knBro3NXUyx6qslp8NG3E/f
	dz4hA5n/2nZnBU/73viMDz3TvV6wTA5FRqeP+VhssHnpwYnKEknN45V7yPTkE5ydMlaD
	i2hoAsvUewXVmfr0TcLVrnoldm9T64NqdMJzv4G3goOHhpFZ14vhjfJsYtkz8u8VbsPO
	7w4z6qNSIHW+W7bYYfQraYDloyT1C7MeDa1toEfwCd+c6+mKoH3I1uAO6EkUQzaEPE2X
	J6yA==
X-Gm-Message-State: AOUpUlF0ktvzuSmfouEga7BVghPZKhEyhjssnYNB/cJxd4xxqE7wiTG8
	m3tZ4wGNyFSc7LCz11I5RIE=
X-Google-Smtp-Source: AAOMgpdbOhXjUf5Aie4fUXADgQo2mNUyaVo3oWC5VSlZFv5aL3roXDKiFsvEEtHmNvuIgNlSf3WSRw==
X-Received: by 2002:a02:8b57:: with SMTP id
	w23-v6mr5305019jak.73.1531921992302; 
	Wed, 18 Jul 2018 06:53:12 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	x76-v6sm1491937itb.17.2018.07.18.06.53.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 18 Jul 2018 06:53:11 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <4bc3d13a7652fbce838d519eb8dfa827e78e8e6d.camel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Wed, 18 Jul 2018 08:53:11 -0500
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
X-List-Received-Date: Wed, 18 Jul 2018 13:53:11 -0000
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
> 
> On the one hand I can understand people wanting to use dependencies
> and
> new technology. On the other, keeping things simple also has
> advantages.
> 
> Even the minimum python version is potentially problematic, we don't
> even have working recipes for python 3.6!
> 
> I appreciate its a reference and means we can test the rest of the
> code
>  so its good but we may need a different implementation of this
> ultimately.

I had a look around, and I think it should be quite feasible to
implement a reference server using only the standard Python libraries
(e.g. SimpleHTTPServer). The actual API that the server is *required*
to implement is very small (a single endpoint of "/v1/equivalent" with
GET and POST methods). It will probably have a number of limitations
(scalability, authentication, security, etc.) but for something to get
started or for automated testing purposes, I think it will be
sufficient.

I'll probably wait a few days at least before I loop back around to
look at that, so I'd like to leave this discussion open, e.g. Do we
want a simpler reference implementation?

> 
> Cheers,
> 
> Richard
> 

