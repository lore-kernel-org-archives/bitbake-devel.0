Return-Path: <raj.khem@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 4E96260234
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 16:57:22 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id f19so1719071pgk.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:user-agent:mime-version:content-transfer-encoding;
	bh=6jQ0TnvBqDxcBRz0jka9m+snQLW2FFJOBoXsUaLzwwU=;
	b=NCdluIjUkD/AOeKinyJJJRAtlWkhvP6eo6Y7oAY9AvGhBD1RoWjga9fJfRaFuWw9Ko
	j+y8EDK6keJWR8mwz55CHr7pnbloezevIgwjqOdDzRRMH2dzrMcsBIUWiZt618c/CejZ
	NPmG02QQfQEP8+hJ8S6ZvnO03up30tKMTzSTPaa2yrkLIKNm+AHruURIXedC/Oyx84rY
	Lr6H63v+gbYIvReefgaslgzAYf1Ofts6Kmw8Qj/Up+UL2lGRA3voERlJDGzARiFTyhVy
	t5xSrFu+pYmo2kmsmHeoUGE8ggxpk52UzMETmTfvPjL3aMUocelEzvo2Wd2xwVb8JuOI
	JTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:user-agent:mime-version
	:content-transfer-encoding;
	bh=6jQ0TnvBqDxcBRz0jka9m+snQLW2FFJOBoXsUaLzwwU=;
	b=A9YqABNoI1hDFV+L9m6PcvUCQjfJVvELVaJQZ3m7rc7/MavKlTao2gGGF3H8uQEBdl
	z2whsqnDZt77agLcxpnUQ0NFirKM/yiVuqWA4316GITEUq/fEYJzYgb/JOrCl4bR1j2k
	DYG0QhmC6C87533lr9ULbi0STIDuH5IIZ5vwcxGJLUX/DqoT/NXi1/XyQF5GQyBBdYHW
	hBDQ6dR82oaCafFe3qeLvAYjhRIuTcmMBuSjLaIihCUgMa4gQAF1vUTtpUwdkUqTKQvX
	Vf/Q1qsCRqfZWpcYg5BZXWezzfRLppe4AIBesR26bP5w2DJ9XLneLpWvK2MXKqShT4tj
	+z+Q==
X-Gm-Message-State: APjAAAU0vrJ/jZBi7IQsKx8v+DR4/XzjBECXdppSLnlfr3qofTjdnvok
	dZ0WprAnO5Edk0zfgQXHt9w=
X-Google-Smtp-Source: APXvYqxWCiBJvojFHAWWEtgcfs5g6WOT8Ms/Hlch5olVNIKr+N7PjuO+WhqiDN7rn2UMVP9QTiDEcA==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr4737037pgk.331.1573664242765; 
	Wed, 13 Nov 2019 08:57:22 -0800 (PST)
Received: from apollo ([2601:646:8500:1c20::30e8])
	by smtp.gmail.com with ESMTPSA id
	v15sm3246126pfe.44.2019.11.13.08.57.21
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 13 Nov 2019 08:57:22 -0800 (PST)
Message-ID: <83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
From: Khem Raj <raj.khem@gmail.com>
To: Adrian Bunk <bunk@stusta.de>, Wayne Li <waynli329@gmail.com>
Date: Wed, 13 Nov 2019 08:57:16 -0800
In-Reply-To: <20191113083317.GA7340@localhost>
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
Organization: HIMVIS LLC
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] No Package Provides /bin/awk
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
X-List-Received-Date: Wed, 13 Nov 2019 16:57:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
> On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
> > Dear Yocto Developers,
> > 
> > I'm trying to to build a Yocto kernel for a T4240 RDB.  When I run
> > "bitbake
> > fsl-image-full" to build the entire linux image, I get an error
> > that says
> > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no package
> > provides
> > /bin/awk".  Here's the entire error print that I see:
> > 
> > https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
> > 
> > Anyway I'm confused about this error because /bin/awk does
> > exist.  Like if
> > I run "/bin/awk" in the console I see help info come up describing
> > how to
> > use a program called "gawk".  Why can't bitbake find /bin/awk
> > then?  Or am
> > I misunderstanding what this error is trying to say?  I mean I'm
> > assuming
> > it's just not able to find /bin/awk but maybe the error means
> > something
> > else?  Or maybe /bin/awk is actually relative to some path?  Let me
> > know
> > your thoughts.
> 
> /bin/awk is missing on your target image that will run on the T4240
> RDB.
> 
> The smallest implementation is to enable CONFIG_AWK in your busybox
> config.
> 

import something like below patch into your kernel will help too

https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2

> > -Thanks!, Wayne Li
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 


