Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
 by mx.groups.io with SMTP id smtpd.web12.20117.1594734985805732543
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jul 2020 06:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stusta.de header.s=default header.b=pCTnTCyA;
 spf=pass (domain: stusta.mhn.de, ip: 141.84.69.5, mailfrom: srs0=yu6m=az=stusta.de=bunk@stusta.mhn.de)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4B5hrP2sZRz1n;
	Tue, 14 Jul 2020 15:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1594734982;
	bh=r7tzVtmC32fo2RtRJigOR0SlW4Z0mY2LbfDQtr6cLFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCTnTCyAd59CDwLdeXJqiIWa9myBPJ1MtLQMNj4Xdpq4bGbpZZU9oS1bzue4Dj71W
	 Bq4P40/MvTbikwmb10uW6CPH01OUX025xmFYv45abnGAJ3b9k+dhu3aAM41Qn7zT58
	 32SSf3hWC8WX3qjSz9kx8n7C4sj83H5Em38hg8rYXFonPNk6HcKixQ8OX9WWXYFp0O
	 EsuAW7yrDITk4xbYOw+iD52Kmr+9TrzTUJqBTAcM98Jx+HkLPpVLltDqy88SStHrND
	 6Xy4mm4Om2zi2NbB8W77YwMqWqMg04k6QFJ7+VCdRMT+5ZPeGCXqyM6wAoUWnYm1Ig
	 vQa5VNFVk8YffbNHBjC+ihVvhJGUTkdzG9mLnaV2oVp7vNR7v7RTQ+PNXTFXpYu6cU
	 QZbb5Pxp8vdiLhHsmevc+suLPAoUnTuS7mCq8i91QM3jscAYYc/BZ9WQw7HlgIq0kY
	 CguhC6vm+EdjIEbXDRO9ahBfbHRzkrEnnzxbF3U6IJ+WjzhIeMzHRZy5JdN2J4yPtH
	 S8NrYMLceMt748GMLbw+QBB8L1waWN+PlyQgsAZlPyakLIXteL4O9V76d480N3iNJH
	 YlwJcCEMtxbxJVTa2ZPbk/mtZ5UYLITc0zlhunSu9/jD8a5MZoIumfoFG+doQo7H8e
	 y7JR/XeV94kyCjEv1ZewbcLI=
Date: Tue, 14 Jul 2020 16:56:19 +0300
From: "Adrian Bunk" <bunk@stusta.de>
To: akuster <akuster808@gmail.com>
Cc: Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>,
	"yocto@yoctoproject.org" <yocto@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] Stable Warrior branch
Message-ID: <20200714135619.GF25970@localhost>
References: <03a353c4-80dd-e66c-3222-7850a98182f7@gmail.com>
MIME-Version: 1.0
In-Reply-To: <03a353c4-80dd-e66c-3222-7850a98182f7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jun 04, 2020 at 09:28:00PM -0700, akuster wrote:
> Hello,
> 
> The Warrior branch of Poky has had its last official dot release. It
> will be moving to Community support and EOL within 6 weeks if no one
> steps up.
> If someone is interested in taking on the responsibilities of
> maintaining the "Warrior" branch moving forward, please email this list.

I have an interest in keeping warrior branch alive in poky and meta-oe,
and I'll take this responsibility since noone else seems to be interested.

> Please look at the
> https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS for what will
> be expected.

I have some ideas, but not yet a fixed plan how I will set this up.

> regards,
> Armin

cu
Adrian
