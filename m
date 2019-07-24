Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id BB95F7ECF9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 08:11:10 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id v15so40914518wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=WSeQOyWQ8wlskq1jNXqQdVHuGS38DNxLslFct92imf0=;
	b=gkMaLKdjRGtV/Uzn0ABfzlPnd31Th5MYQO9WHOo/lKdyRutinWKezft56J4Mka1SNE
	xA6z6OudnLYX1OcunGZbFsG+2PoVSzhWlmhtrmc1SOtsxnw5U2h7O67jnaN5EeJXcLGW
	B6Jm+qUI+UYi2UH80miTe9W7VnoHr0qs9jZdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=WSeQOyWQ8wlskq1jNXqQdVHuGS38DNxLslFct92imf0=;
	b=FTQ/LUlo/jVrD8avSImYB4MN1uxS5u52YQ3aENj/Eq/z849GwWAF5kkT7ObrmEWmW7
	vEvd9okO5B0C3FK/+FUVlzcoZbQymcysjR7IWaxbZrLSdp2Fb0hh5rlgSHPKr5K9nvS6
	Tg0KaXVEztQw3GRkDqvw+phuPNHkemU07/t8ca2zcKwPfN4r7EaptIVI0DCkyl8hifoz
	haaI9RbumPfFUz3ih5RtVo94xw2CdwrKI6CBnuEyp7wRTX0z2Nw6XzvXOKnoV2ZAhms7
	53E+ykNLPlDuoRjPk7m2S1gzhDqFIOTFVfsJ0i0tgooYDgCGZVkJxaPF/kHDWwtmNaVX
	jqYA==
X-Gm-Message-State: APjAAAXx0r1TJ+hP87j86kaU/NxRU8eLpygN+vJmaOAYIExbOB+AVrki
	tAYxz65kg3oMaM9NzP/EWlG09Oq17Yg=
X-Google-Smtp-Source: APXvYqwl/hng5L9OGBKEVWj/vSZG8L3zvtnHi173p/upj1j6tXrspq4g/RPC9+cfdVSKXnFqR6xzjA==
X-Received: by 2002:a1c:acc8:: with SMTP id
	v191mr75257927wme.177.1563955871375; 
	Wed, 24 Jul 2019 01:11:11 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	m7sm36398589wrx.65.2019.07.24.01.11.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 24 Jul 2019 01:11:10 -0700 (PDT)
Message-ID: <1e930c00f2f1ef60bda5c7d25d2850d438f3345a.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, Mike Crowe <mac@mcrowe.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 24 Jul 2019 09:11:09 +0100
In-Reply-To: <00066477-9727-3081-a300-e030ef733333@windriver.com>
References: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
	<20190723160909.wdj7fwboiy65kfet@mcrowe.com>
	<00066477-9727-3081-a300-e030ef733333@windriver.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH] data/siggen: Switch md5 -> sha256
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
X-List-Received-Date: Wed, 24 Jul 2019 08:11:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-07-23 at 11:59 -0500, Mark Hatle wrote:
> On 7/23/19 11:09 AM, Mike Crowe wrote:
> > On Monday 17 December 2018 at 17:16:45 +0000, Richard Purdie wrote:
> > > Similarly to the codeparser change, change to sha256 hashes due
> > > to worries
> > > over collisions. The main impact of this change is slightly
> > > slower parsing
> > > time as well as longer sstate file names.
> > > 
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> > > >
> > 
> > This change has given us several sstate cache filenames that exceed
> > the 255
> > character limit of ext4. :(
> 
> I wonder if another approach might be easier.  Instead use change the
> filename
> to be:
> 
> sstate:<sstate_version>:<hash>:recipe:version:...:task.<type>
> 
> (<type> such as .tgz.signifo)
> 
> If the filename becomes too long, simply truncate the middle section)
> preserving:
> 
> sstate:<state_version>:<hash> and <type>
> 
> So the same truncation when matching, and it should be safe.  The
> recipe,
> version ... task bit is nice to have for a human reader, but I don't
> think it's
> actually needed by the system itself.
> 
> This should avoid any collisions and keep the maximum information
> that will fit
> in the filename(s).

In some ways regardless of what we do, we need to abstract it so that
we have one function generating the filenames.

So yes, think we need a patch which abstracts the filename generation.
It needs to be able to truncate elements of the constructed name other
than the hash. I do prefer truncating the other elements than changing
the hash.

Cheers,

Richard


