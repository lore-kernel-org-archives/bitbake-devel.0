Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by mail.openembedded.org (Postfix) with ESMTP id 7151E7ECE5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 00:57:24 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id r21so5235375qke.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lJHZtaU4BnpRWE6uBZ8t7fabRaO2UpwNBr//k1rRr7c=;
	b=jFHKKV9j1ncf44ClIwsChyUrcbnB9isKADrFqSj3ftExfVJd0dHtYANja9eiNFNJQM
	3MqDKUGLwWKCzfKtfye32QoIuZOOcUXZqOADRJ23FxDGs4JmbeNY+DhrO5+1pI9Hto1C
	97gHi50aG4wK5SvZ9wHGJRwGWcLtF9CMwRvDkQN0elyXBcvYhKp993IqQD6hezNWjtNy
	nrnQn/wBqyZ7mIEO0pUUmTlpWFkmPNJ26c+CE43XRP6JxS4pl/mA9Vj74NKfl2eSiFD0
	qv2Gl0Wf8Tkc6JmQboktCZWygI1c22Y1twrI1xJhA3G4ZREOeqVR3LTlhtg0y0o64Qgl
	qDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lJHZtaU4BnpRWE6uBZ8t7fabRaO2UpwNBr//k1rRr7c=;
	b=fIbRWgHaTYSV5JXR+1kXTH9GIua4iCoRe2vJ2TmJLSJpIJrOl7+eQZ/Wkvs6YxJu36
	XoLc06HKM2j/kfROY5RoPvvB9hFdDQowM/ArgLpv7V2TRO+l3Z0XFTeNiBiAv5fte/7D
	Q5JXp2dca/OQugea+F91zDcRLxQIJyPNkRaxdRn98iDRxClp8XsFjDw8kbX2rjQ+GxWM
	+mGiJaGXx20bB0R2CVsIudfoRxE777tYWBWpErijSFjZIm9S45QzoYs+/D/hP+ONMU14
	OsZc2AaDKlWaNYw2Yc4iSDrNy0KoAzIZ7fM+kgYba8tnFDAapOwAFXEJM+dWPs2cuP6x
	GHiQ==
X-Gm-Message-State: APjAAAXUccd2qCSM8IXjy/nbzVJmOvxJQQOfKaYLU1Qtu9LyRSQFotod
	IsPRaRdit7bKwgtRyXHVZnbAOOYOQ+QMIc8DjSk=
X-Google-Smtp-Source: APXvYqyME45hyu9DpqHkxx5jGyGwWSs8F05VpWm7mij7Lp0j4BG2d07zEhex2/E91Tzugl+yznKmQq5JCXKUcTva5zk=
X-Received: by 2002:a37:c81:: with SMTP id 123mr4274484qkm.474.1562893045094; 
	Thu, 11 Jul 2019 17:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
	<8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
	<e09869e803d875b3dfc9ba329dc261550bb25143.camel@linuxfoundation.org>
In-Reply-To: <e09869e803d875b3dfc9ba329dc261550bb25143.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 11 Jul 2019 17:57:11 -0700
Message-ID: <CAMKF1srFj=bqwA3V4JUFX-eLuDfPxjpgU8d55PG+CxbE4j=c2g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/26] runqueue changes
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
X-List-Received-Date: Fri, 12 Jul 2019 00:57:24 -0000
Content-Type: text/plain; charset="UTF-8"

Hi Richard

Good changes I believe. Can you push them to a temp branch on bitbake repo ?

On Thu, Jul 11, 2019 at 9:21 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2019-07-11 at 01:05 +0100, Richard Purdie wrote:
> > These changes set up the foundations so that we can work on two other
> > significant problems:
> >
> > a) reuse of sstate artefacts between multiconfig build tasks
>
> I have spent a long time thinking about this so now the codebase was
> ready it turned out not to be too hard to make it work. Patches aren't
> tested apart from with the unittest but I've posted them and we can
> take them from here.
>
> > b) adapting the task queue 'on the fly' if the output of a task
> > matches a previous output and hence we have sstate hash equivalency
> >
> > Solving these would be great for OE!
> >
> > I will follow up with more details on the future plans for the above
> > and this code soon.
>
> Adapting to new hashes "on the fly" is definitely going to be the
> harder challenge.
>
> This will involve the following steps:
>
> a) Knowing there are new unitask hashes available and propagating that
> information
>
> b) Figuring out which tasks should now have their sstate retested
>
> c) Test for sstate existence (if it doesn't exist, no point in going
> further)
>
> d) Ensure any normal tasks covered by the sstate task are not running,
> wait if any are
>
> e) Remove all those normal tasks from access by the normal task running
> code
>
> f) Enable those tasks in the scenequeue code
>
> We have no existing code which moves things "backward" in the state
> engine from normal task to scenequeue so this will be new ground, but
> should be feasible.
>
> I'm going to wait for the current patches to settle before I look into
> this any further though.
>
> Cheers,
>
> Richard
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

