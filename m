Return-Path: <ross.burton@intel.com>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
	[209.85.192.44])
	by mail.openembedded.org (Postfix) with ESMTP id 56F8360DDF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 19:54:00 +0000 (UTC)
Received: by mail-qg0-f44.google.com with SMTP id a108so2401qge.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 12:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=OmyiNbklrPu6YZI5maSHPI9Nw+WywCtfuSRKheTEOTE=;
	b=ASAab+MkdZY7NGbe+3kFF5F/MbAM7g4vL1/bg5s95aNy41E2mhuo5m6Ftc17AOGfvg
	2nGib98WcylBOydxI/ItxbGSca3hq3Cj1wVOHQ+ySqg5WhLV6McgIMaCa9olTk3MwGjP
	ULHQNtZCXaF4I7CjIorNe070Vllpt1STLetRR9ZXy3Q/ffVojt82Zsqe00A0c7PpNDLH
	j0CEx8Rf3ShYyrYz8iccyWWjvGiAtjfqO0xUc6i4fC5yE6RQq6I3GR/rwEiuzlweg56Z
	AxHrmYXA3/ZOC9xHFPQL+3RDChMOSZEaWWZulWz2zBum8G6QH97vZbiWqLK3bfciXB75
	FUbA==
X-Gm-Message-State: ALoCoQmUDzT5nn/fjI8Ah3d3M/QD4c/9hDvy5lYasNoQtcjps0hqYWzZnNdfo1TU8N0IA1Mh5dlE
X-Received: by 10.224.22.147 with SMTP id n19mr4916236qab.93.1394654041554;
	Wed, 12 Mar 2014 12:54:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.48.79 with HTTP; Wed, 12 Mar 2014 12:53:41 -0700 (PDT)
In-Reply-To: <CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
	<CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
	<CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 12 Mar 2014 19:53:41 +0000
Message-ID: <CAJTo0LbSX9118q9A3BkqxuHRokqby+E_70g7_7CM0uzWsY_fuw@mail.gmail.com>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] toaster: fix timezone detection
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
X-List-Received-Date: Wed, 12 Mar 2014 19:54:01 -0000
Content-Type: text/plain; charset=UTF-8

On 12 March 2014 18:49, Damian, Alexandru <alexandru.damian@intel.com> wrote:
> This is a Debian-ism :(
>
> Does toaster show you improper times, or refuses to start ?

I've never tried Toaster, but I'm in GMT so I wouldn't be able to tell :)

It may be a Debianism but TZ isn't set at all so that's equally
unreliable.  I wonder what time.tznames is actually doing.

/etc/localtime was originally a Debianism but is also the canonical
file that systemd handles, so it's got a much wider install base now.
The similar file that Fedora has used to be /etc/sysconfig/clock.

http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/trusty/jana/trusty/view/head:/libjana-ecal/jana-ecal-utils.c#L113
is the first hit for some code I was involved in some time ago that
tried to work everywhere.  It's probably bitrotted quite dramatically
though...

Ross

