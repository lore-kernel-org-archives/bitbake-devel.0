Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
	[209.85.216.50])
	by mail.openembedded.org (Postfix) with ESMTP id 77700610F5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 22:20:36 +0000 (UTC)
Received: by mail-qa0-f50.google.com with SMTP id j7so818004qaq.23
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 15:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=58Q+nN7/WIppeIhsp2HjAOoiufVmbQw2WvqxmKz0Ifo=;
	b=OteRmet1gq2+L7yaJR0iE/W3lh+WZ2fW6z31l5NXFXGtIAcYNi30A0qGoAvFa/A3Lg
	hWHArUUPNDA+P5hXYbH4r5aprNP7WcBxOA6Y50YtyEJ7oBovtG63dTlEy3zRgP9+mctN
	vhnG/rWwigx9jhB5tkSG9nEfKj2EULhSjunPJaMIgp+IkmjXEMGMhRs6yNFGeGIFqyp1
	rcrEOhz+KO4yQZ4ygOM5ObyTSM4Om0uKvKrQWnjW73KgclW95eeyvvYocrPOsbeoneGQ
	fB+mVrzg36TAshteL8FFeS7ASO5xWBJsbTEe7X9dMNLIv8IODHFNYp/EzzgTYrGB6CU3
	Wu/w==
X-Gm-Message-State: ALoCoQmlo3SkbBou67jWB9Hcz/kXKiOFzdScIOH/vnzI6I25tIdkSYjBy8IQgqmjUcNnvo7RLMW6
X-Received: by 10.140.94.144 with SMTP id g16mr25857954qge.77.1411424437800;
	Mon, 22 Sep 2014 15:20:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.180 with HTTP; Mon, 22 Sep 2014 15:20:17 -0700 (PDT)
In-Reply-To: <54207A81.9070102@sonatest.com>
References: <54203B56.5030607@sonatest.com>
	<CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
	<CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
	<54205685.2060104@sonatest.com>
	<CAJTo0Lbfg7nz7vYLOhT2VuxDCCeO0eBVtmer+ODFQTwfgncTrA@mail.gmail.com>
	<54207A81.9070102@sonatest.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 22 Sep 2014 23:20:17 +0100
Message-ID: <CAJTo0LaXAVpDvEka7wH5wLJzbR5NqdMG_+oTUsSV=qXKVh6Rzw@mail.gmail.com>
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
X-List-Received-Date: Mon, 22 Sep 2014 22:20:40 -0000
Content-Type: text/plain; charset=UTF-8

On 22 September 2014 20:37, Olivier Dugas <dugaso@sonatest.com> wrote:
> I know that no journal and high write delay could corrupt my disk. In this
> event I would reformat and rebuild the image, no big deal. What seem to me
> like a big deal though is to have a healthy hard drive that will once every
> 2 year flip a bit randomly on one of my downloaded tarball, and not having
> bitbake verify the checksum just in case.
>
> When I say it this way, I realize having bitbake doing checksum for every
> already downloaded tarball in the system could indeed add significant
> overhead, like said by Richard Purdie, even if I thought that a checksum was
> a fast operation... So I'm stuck. What would be the best solution then? I
> can't see any other simple solution then the one you proposed in #5571.

I think that if you're worrying about a bit flipping once in two years
then there are far more important places it could flip than the source
tarball archives.  tarballs/zip files etc have CRCs internally so a
flipped bit will be detected.  A bit flipping inside a compiled object
before it reaches a CRC'd package won't be detected until it crashes
or executes incorrectly.

As far as I'm aware this is mostly a hypothetical problem: hard drives
employ CRC to detect errors when reading sectors and will remap as bad
sectors appears.  Wikipedia says "10 non-recoverable read errors in
every 10^16 bits" and they'll be reported to the operating system as a
bad sector error and not silent corruption.  I'm happy to live with
that error rate.

Ross

