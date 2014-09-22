Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
	[209.85.216.45])
	by mail.openembedded.org (Postfix) with ESMTP id BD6E460703
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 16:18:42 +0000 (UTC)
Received: by mail-qa0-f45.google.com with SMTP id k15so341321qaq.18
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 09:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=Rzf2jXFUA8bGA19dGPJmUR4Sh6Zr/MD+U3m4dkv08ro=;
	b=lg6SyNbo3wEWGEYWPDbQC4UQzUuTpYKdWZo1Qi6lxOWnu1+Mvl5xoY/shvKhYp140O
	GgQ+37btCqZt16GS4ebJaNDsfv8tNpRad6j1PUNJtUSicvBPPBc/bBYQs8pT0Dds3mfV
	o89L1bIY6A3DESXMOU6uDPrb5VldyuQ+9HN8yR8w86FP1a0VPO8MSrQWpR6Hjk0jKc3U
	eyIBvh9Y4qJYxsqwrJ1WLK24Bj1ztZfN9pA18TYXv559qflssxRGhTySO4FWrmfK0q/W
	+W9IC9SCXbev6gApFC6cAREkk2dfLMq5u7GIlHg1tzZ9fHHdpV86qE/919LfVH/tmc9E
	cmDw==
X-Gm-Message-State: ALoCoQl6nf/PXL3M0xGONFhR9m/dkwNDTopU7THqSjzxvsS341Fhg+JoJWfEvTnJ8lX+IIyBnyVM
X-Received: by 10.140.94.144 with SMTP id g16mr22734067qge.77.1411402723546;
	Mon, 22 Sep 2014 09:18:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.180 with HTTP; Mon, 22 Sep 2014 09:18:23 -0700 (PDT)
In-Reply-To: <CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
References: <54203B56.5030607@sonatest.com>
	<CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 22 Sep 2014 17:18:23 +0100
Message-ID: <CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
To: Olivier Dugas <dugaso@sonatest.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake do_unpack checksum?
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
X-List-Received-Date: Mon, 22 Sep 2014 16:18:51 -0000
Content-Type: text/plain; charset=UTF-8

On 22 September 2014 17:16, Burton, Ross <ross.burton@intel.com> wrote:
> No, it wouldn't be hard.
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571

I hit sent a little early then.  5571 is a related issue, but if
you're a disk which is suffering from random bit flips, then do you
want to trust it to building a file system image that likely is
corrupted?  By extension we should checksum every file we generate
just in case they get corrupted too...

Ross

