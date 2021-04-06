Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web11.1737.1617726892355224768
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 09:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:35466 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lTofC-00E01T-GU; Tue, 06 Apr 2021 12:34:51 -0400
Date: Tue, 6 Apr 2021 12:34:47 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] still confused about valid wildcarding for bbappend files
In-Reply-To: <4d45946c-442a-53eb-53e9-b480a2b83112@kernel.crashing.org>
Message-ID: <5166362-3350-5421-72c5-3eea3ca947fe@crashcourse.ca>
References: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca> <4d45946c-442a-53eb-53e9-b480a2b83112@kernel.crashing.org>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: multipart/mixed; boundary="8323328-2046377102-1617726890=:39961"

--8323328-2046377102-1617726890=:39961
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 6 Apr 2021, Mark Hatle wrote:

> On 4/4/21 2:51 PM, Robert P. J. Day wrote:
> >
> > from current bitbake manual:
> >
> > https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-intro.html?highlight=wildcard#append-files
> >
> > "The use of the ” % ” character is limited in that it only works
> > directly in front of the .bbappend portion of the append file’s name.
> > You cannot use the wildcard character in any other location of the
> > name."
>
> The filename is broken up into: name_version.bbappend I believe the
> intention is that only "version" can contain wild cards.

  that was my understanding all this time.

> >   that *appears* to suggest that you can have one (and exactly
> > one) "%" before the ".bbappend" suffix. so how does that
> > explanation cover examples in some of the OE layers like:
> >
> >   meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
> >   meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend
>
> "%" is a wildcard for the _version_ only.
>
> It is my understanding it can be used in any part of the version
> string, but can NOT be used in the name.  The above example shows it
> being used in the linux- recipe name.  So perhaps that has changed.

  agreed, that example is a bit of a surprise.

> The later example (gtk+3) it's being used in the versioning, but looks
> unnecessary as it's just patching all of the version elements anyway.

  perhaps, unless by adding the periods, it's saying that the version
number must contain *at least* three components (since the final "%"
will always suck up whatever remains). but that's just a guess, and
probably wildly wrong.

> The general case is:
>
> recipe_1.0.3.bb
>
> recipe_%.bbappend - match all versions
>
> recipe_1.%.bbappend - match all 1.x versions
>
> recipe_1.0.%.bbappend - match all 1.0.x versions
>
> Any other usage might work, but I doubt has been seriously tested.
> (And the key isn't that the '%' be right before the bbappend!  It
> just happens to be there.)

  that's pretty much the way i'd always thought of it, but perhaps
we've been mistaken all this time. :-)

rday

--8323328-2046377102-1617726890=:39961--
