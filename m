Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DF7C577043;
	Wed,  3 Feb 2016 16:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13GMZpF024543; Wed, 3 Feb 2016 16:22:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WNitvrphG3kH; Wed,  3 Feb 2016 16:22:35 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13GMWRb024539
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Feb 2016 16:22:33 GMT
Message-ID: <1454516552.27087.197.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 03 Feb 2016 16:22:32 +0000
In-Reply-To: <20160203150638.GB2567@jama>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
	<20160203150638.GB2567@jama>
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
X-List-Received-Date: Wed, 03 Feb 2016 16:22:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-02-03 at 16:06 +0100, Martin Jansa wrote:
> On Wed, Feb 03, 2016 at 11:22:36AM +0000, Richard Purdie wrote:
> > On Wed, 2016-02-03 at 08:11 -0200, Otavio Salvador wrote:
> > > I am in favor of making it mandatory but I fail to see what we
> > > gain 
> > > in making it expand by default in future.
> > 
> > Less ugly syntax, in 99.9% of usages, you would want expand=True
> > and
> > getVar("X") is neater than getVar("X", True).
> 
> Consistent indentation is also neater than mixing tabs and spaces,
> but
> you were refusing to take such cosmetic change and now you're
> proposing
> neater getVar syntax which is (in some cases silently) breaking
> existing
> metadata and make backporting changes more difficult?
> 
> I'm not opposing the change, just don't understand why the same
> arguments work here and not for indentation.

If we go through the full transition, its possible something might
silently break, if they skip the release where we require a value. We
haven't reached that point yet and I'm honestly not sure how long we
should wait, I'm open to suggestions. The aim is to minimise any silent
failures though.

I'd also add that in many cases, it likely won't break at all, it might
potentially fix something. If there are concerns about this, there are
extra things we could consider such as requiring layers to mark they've
been validated for the change. That adds extra complexity, I'm less
sure about whether we need to do that.

As for your other point, whitespace in shell functions doesn't seem to
cause real world usability issues in that most people can read a tab
indented or space indented function equally well. OE-Core is pretty
consistent about what it uses and always has been, you personally just
don't like the particular choice made and meta-oe deciding to do
something else, contra to the TSC doesn't exactly help consistency. You
could argue meta-oe is more of the problem here.

The actual getVar syntax on the other handy is more than cosmetic,
people don't understand what this "True" they keep adding means, or why
they need it. You tend to know when you don't want expansion on the
other hand. So a cleaner syntax which does what the user most likely
needs is more than cosmetic.

Cheers,

Richard


