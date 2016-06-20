Return-Path: <twoerner@gmail.com>
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
	[209.85.220.172])
	by mail.openembedded.org (Postfix) with ESMTP id D4EBD73186;
	Mon, 20 Jun 2016 02:46:27 +0000 (UTC)
Received: by mail-qk0-f172.google.com with SMTP id c73so145878189qkg.2;
	Sun, 19 Jun 2016 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=C11KbfCGPwXoI1YCeKRPowQgIxP3F2Ge+w3W/jq1qnU=;
	b=UfJf8pbZokD/Nyq4Rkvd0esrhYhYMDbG+iaUg3ElOsW3ic7O/lkMWq7QTvsD/htgi5
	j3hDlgCGEx+CLxaaeA1oxqZVMl/WNadbgggu27UmaXhLzICcKt4oIJLZnlVIR+4OEgsM
	0Ooe4Qdelvc1OKm++ZQYy2ax8bDvESVyMAYI/cZL3ie5M9jmx3ug6+tUhoGEqLRNuWAR
	SGV+Avtk1eYhw1RiZGNHrfqOyljP5pr7FA/fis1XNS/OOYawNNc9jJECRHR6GpJMggYu
	SQXfTrSi77LPDKtu+uX26xtQXz8rA6uKXgO/w072UKE6PmrWMJ+wC6crtNmxEGij6t1t
	KSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=C11KbfCGPwXoI1YCeKRPowQgIxP3F2Ge+w3W/jq1qnU=;
	b=k+SlM5PctzNl5nRs/+Hi3NUnKVg950GMFD6PpR9IDK0kN3K9NbmlRjnTNmR0u9VxE6
	ybYJXqslQth5SnGeZKGlWwVIA3O7jaeVgH6OEcBHb1mNelKEdRxrzQwCsG2wRqKk4Pmh
	vhLaphuacaIl4pJTZNmVhvNwpNMK8mO2fD55GwJQRguusBRaxfwaiIVlUfseCmf4gqng
	NOnqyaTS4TuZWepq8WBWjiBstC43O2qtrt5eol+F6m8seOhzSnvbTrTv4MwfSrf1YJ8z
	vZcyrXVL6zR9cCSkydA8njY2WOv3RD0QWrEZLmJDViLU85MKlZoiZZ8Bllr11rrAHdhg
	Vf5g==
X-Gm-Message-State: ALyK8tJnht98iutU1r15uh8KV3mdFuklbToPKeRKoVOYMzoHSkrOjgvZjaWcUi6ZLqBwqA==
X-Received: by 10.55.217.148 with SMTP id q20mr18747442qkl.62.1466390788009;
	Sun, 19 Jun 2016 19:46:28 -0700 (PDT)
Received: from openSUSE-i7.site (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by smtp.gmail.com with ESMTPSA id
	d64sm19564119qkg.35.2016.06.19.19.46.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 Jun 2016 19:46:27 -0700 (PDT)
Date: Sun, 19 Jun 2016 22:46:47 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Message-ID: <20160620024647.GA29701@openSUSE-i7.site>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1465575223.13979.188.camel@linuxfoundation.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Multi-configuration builds
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
X-List-Received-Date: Mon, 20 Jun 2016 02:46:28 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
> > On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
> > > A few people have asked about multi-machine builds.
> > 
> > Do you envision each config also pointing to individual bblayer
> > configurations
> > too? I.e. if I'm building for 3 different MACHINEs, with 3 different
> > configs
> > (local.conf?), then there would also be 3 different bblayers.conf's?
> 
> 
> No, there is one local.conf and one bblayers.conf file and then three
> different multiconfig files, each one of which sets a different
> MACHINE.
> 
> Would people really want to support different bblayer files? That would
> complicate things quite a lot :/.

Personally I have a common "Downloads" directory (this is probably quite normal).

Then, I have a common "layers" directory in which I checkout every layer of
which I'm aware. I also have a script that I run manually from time to time to
keep each layer up to date (although it's capable of running any general git
command on each git repository it finds one level beneath it):
	https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh

I then create separate directories for each platform for which I'm interested
in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of those
directories I have separate local.conf, bblayers.conf, sstate-cache, and tmp
directories.

I know most will disagree with this arrangement (especially the separate
sstate-cache directories) but it's a system that has evolved over time, each
decision was made based on experience, and it works great for me!

It's been my experience that having too many layers in a build slows down the
initial parsing stage noticeably and too often layers don't play well with
each other. Also *many* build issues after an update can be fixed by blowing
away tmp *and* sstate and starting over. Often, building for a particular
board requires particular tweaks to local.conf (whether to enable a vendor
license or to enable specific hardware/features) which don't apply to other
boards and builds.

I'm happy with the speed of my builds, and I have enough disk space to
maintain the multiple sstates/tmps/etc. *Most* of my builds are
core-image-full-cmdline-type builds and I can crank one of those out from
scratch in 20 minutes (assuming the majority of sources have already been
downloaded). Although I do sometimes need chromium (which takes an hour on its
own) and I used to do qt (which is also quite painful). So I can understand
how sstate might be more useful to others, but for me, not so much.

