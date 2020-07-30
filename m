Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
 by mx.groups.io with SMTP id smtpd.web12.11329.1596124178145396051
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 08:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stusta.de header.s=default header.b=XQIIVdz3;
 spf=pass (domain: stusta.mhn.de, ip: 141.84.69.5, mailfrom: srs0=xatc=bj=stusta.de=bunk@stusta.mhn.de)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4BHZbd2mkXz4H;
	Thu, 30 Jul 2020 17:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1596124175;
	bh=/6R5I+xdmYFs8ss62IRD2sX8nwgfjlWpSgJcP7lfjnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQIIVdz3omaGG9bZL/deZfg4N1ZkPV/VM4vfb81WMmQ3/YVxiLcOZJIiiQtDtLZBL
	 G0vnjzGEFBdVNdhSXh/+JWvdgFz2G0tpdJ5JbYDZ39ljKHjMdOPw7/jAlEr0mWIFNJ
	 zLjyvUYpFg1c7G14AWc9/AK1LTajf2NaG75MAgU25Ea45HtqsRz/1eHHO4CAnj+EJl
	 2fzdwMc0vd9xma4HBnQolN0XcJQWrTLfo9Qx5lzRPQ8oaG/magPtvdtSvwDJOlW7iK
	 U9tvCXE4nAtaNRFJXHrZdUAvtt8iQ/2wPHfnhjQ+YuTz4o4seGcne+FOX/BdUOac0q
	 O3lnbtT0CseqRXfFC14lxBNO4MXseOT0UDUpXPxwDpXrGB+inT4NVhFZ7PawiH6aOZ
	 F3sTRmOgSpGhdeq7guCMS/D1bixqUVCmP8XV9oS7Y65ryJF6RqUDiJHx2zRdYkru6Y
	 7xcbOuimjoTav/esoWFXz9BuHB8dmBGVgkw6LsGkp/5f6RDfP73oI/QMREU+WxgppJ
	 rDPH3mCktuGWIPXkBy0zwXBlhw8fBvyoEnwvBgC36sGyMZxezTAQFOD05n/XG/JKZU
	 1B57cChR21fXU1EM7+5b0LuF31HjiogEmIeoSIhiFPOEOSvWi8PAAum3ZW5oEIT+sM
	 ouPnDMujwdnZO1TxOPf36vl8=
Date: Thu, 30 Jul 2020 18:49:31 +0300
From: "Adrian Bunk" <bunk@stusta.de>
To: akuster808 <akuster808@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>,
	"yocto@yoctoproject.org" <yocto@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [yocto] Stable Warrior branch
Message-ID: <20200730154931.GE1260@localhost>
References: <03a353c4-80dd-e66c-3222-7850a98182f7@gmail.com>
 <20200714135619.GF25970@localhost>
 <cca863dd41cf837cfaa89484c010578e5ac0809b.camel@linuxfoundation.org>
 <e6743da0-b2d2-14bf-2d1c-7e6f50ba8e1b@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e6743da0-b2d2-14bf-2d1c-7e6f50ba8e1b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jul 27, 2020 at 07:36:49AM -0700, akuster808 wrote:
> Adrian,

Hi Armin,

> On 7/21/20 1:53 AM, Richard Purdie wrote:
> > On Tue, 2020-07-14 at 16:56 +0300, Adrian Bunk wrote:
> >> On Thu, Jun 04, 2020 at 09:28:00PM -0700, akuster wrote:
> >>> Hello,
> >>>
> >>> The Warrior branch of Poky has had its last official dot release.
> >>> It
> >>> will be moving to Community support and EOL within 6 weeks if no
> >>> one
> >>> steps up.
> >>> If someone is interested in taking on the responsibilities of
> >>> maintaining the "Warrior" branch moving forward, please email this
> >>> list.
> >> I have an interest in keeping warrior branch alive in poky and meta-
> >> oe,
> >> and I'll take this responsibility since noone else seems to be
> >> interested.
> 
> Are you still interested?

yes.

> -armin

cu
Adrian
