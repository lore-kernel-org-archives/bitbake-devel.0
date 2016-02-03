Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5334177339;
	Wed,  3 Feb 2016 16:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13GcCcf025597; Wed, 3 Feb 2016 16:38:12 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mO9XCQuDd-60; Wed,  3 Feb 2016 16:38:12 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13GcAlq025594
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Feb 2016 16:38:11 GMT
Message-ID: <1454517490.27087.199.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Wed, 03 Feb 2016 16:38:10 +0000
In-Reply-To: <CABcZANkuuQRW7ab_ai=KpoL2030H__kyFszZpkvgkxurmu63_w@mail.gmail.com>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
	<20160203150638.GB2567@jama>
	<1454516552.27087.197.camel@linuxfoundation.org>
	<CABcZANkuuQRW7ab_ai=KpoL2030H__kyFszZpkvgkxurmu63_w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio.salvador@ossystems.com.br>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 16:38:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-02-03 at 09:29 -0700, Christopher Larson wrote:
> >  The actual getVar syntax on the other handy is more than cosmetic,
> > people don't understand what this "True" they keep adding means, or
> > why
> > they need it. You tend to know when you don't want expansion on the
> > other hand. So a cleaner syntax which does what the user most
> > likely
> > needs is more than cosmetic.
> I'd agree with that, passing booleans as arguments sucks all around,
> since it loses context. *If* someone is going to do it, it's best to
> pass it with the argument name in keyword form in the caller, and
> obviously we don't want to do that here.
> 
> That said, I'm rather inclined toward thinking about alternative
> DataSmart APIs in general, in the long term. For example, it's a
> MutableMapping, so it acts dict-like, so we should be able to use
> .get() and get an expanded value, and then the case would line up
> with PEP8 (CamelCase for functions is frowned upon). I.e. we could
> have get() and get_unexpanded().

I'm just thinking out loud here, I think the above is worth seriously
considering. One big advantage "getVar" has is that its pretty unique
and the python parsing code therefore doesn't get a lot of false
positives with function names. "get" on the other hand, I can see being
a nightmare.

Cheers,

Richard


