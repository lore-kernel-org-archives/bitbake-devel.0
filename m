Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com
	[209.85.220.181])
	by mail.openembedded.org (Postfix) with ESMTP id 21AAD60043
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 13:11:41 +0000 (UTC)
Received: by mail-qk0-f181.google.com with SMTP id f25so5229282qkm.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=NpmVTuRb70IRatG2bcfPVMviixxBfBTtOhFw8wRqDWk=;
	b=KDVR44SI9QM5c8uf5NLfMEWqJbevaqjsf8NFvQ9BW0F3i8ZaYjt5Hjv6w/pdGrdNur
	5dOfFgHh5KiKlGItMaF/bZxOpH5VjmZN4eljL9tia54WeYIpGgOqftRn62i3i8uVh0Z6
	0XCSFd6k9fsGpFCgVWwCHZbZil0xLh7/1IHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=NpmVTuRb70IRatG2bcfPVMviixxBfBTtOhFw8wRqDWk=;
	b=Ve7rcOZc7F/HwLHQVe/TrDcJKqGlW48dduhnn4vruENYL/UtSfenmqXw8N/d94a11+
	M3qm7vmiwL+PEKt5YblEXp/6QRCvJ/7x+h9eBdss2rNdXKJfswU68K+adYSP2i37+0XJ
	GhqiMeUWonyIJW8knC7V4xVcXIMkvUBtMCls/eNtFi1dlINKceQr0Js+WJVIcI7Eq142
	QA0U8xAuAeO5CxLuK4Qxwr/9rQwM6hHaTypVlgSjOcG35rgwAF8QvbQprWmqsEnkioKY
	QrA7El2S5Rq4m1g5jUhhyl0bRroBXO4AqGyT2Op8cJAihmocFMaxVrQpJp/zCzSe7IUA
	LiCg==
X-Gm-Message-State: APf1xPBQD5H5uisJqQS5a4dmSWJkPaiRfqfFHiLCnf4uVVOCHHkSq54+
	Sh94/koTXYBhxNiOiq4CczOL2AuyAeIiP9yTqUNq6A==
X-Google-Smtp-Source: AH8x226ZGLKe6NWjDXLszStd3utIrlt5aPaSpiE0YJxZq0tWK47zpu1gi1h3spA2rCFnaPc3GSk4Mu3Mt7Rb3GzuVTE=
X-Received: by 10.55.209.12 with SMTP id s12mr3725465qki.219.1518700302958;
	Thu, 15 Feb 2018 05:11:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.170 with HTTP; Thu, 15 Feb 2018 05:11:22 -0800 (PST)
In-Reply-To: <1518696127.24236.134.camel@linuxfoundation.org>
References: <CAP71WjygD3eM2fhhU5JG6Kn3_y=mH1fzy+aVrQFKtp+ED_yoog@mail.gmail.com>
	<1518692356.24236.122.camel@linuxfoundation.org>
	<CAP71WjwJ-U3h14D0rZwcm0=eihVpdWRxrmfgmv7G+883Lu5ppg@mail.gmail.com>
	<1518696127.24236.134.camel@linuxfoundation.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 15 Feb 2018 14:11:22 +0100
Message-ID: <CAP71WjwJrRtg5c3U3JeKuM4Q_LQASbfQbAfdUaXra08HQhMWGw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Ryan Harkin <ryan.harkin@linaro.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: git fetcher and github pull requests
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
X-List-Received-Date: Thu, 15 Feb 2018 13:11:42 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 15, 2018 at 1:02 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2018-02-15 at 12:19 +0100, Nicolas Dechesne wrote:
>> On Thu, Feb 15, 2018 at 11:59 AM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> >
>> > On Wed, 2018-02-07 at 16:04 +0100, Nicolas Dechesne wrote:
>> > >
>> > > we've been debugging an issue these days on our builder which
>> > > ended
>> > > up
>> > >  do_fetch failing with
>> > >
>> > > LANG=C git -c core.fsyncobjectfiles=0 fetch -f --prune --progress
>> > > git://github.com/OP-TEE/optee_test.git refs/*:refs/* failed with
>> > > exit
>> > > code 128, output:
>> > > error: Could not read 48e440f5f8d033e1ace6e41f424ecf6e6d96e5f2
>> > > error: Could not read 019a8db54beb29388e1108831d2e2dc135c1cd73
>> > >
>> > > It happens that these refs correspond to pull requests done on
>> > > github
>> > > which existed at some point, but have been updated with newer
>> > > commits,
>> > > and won't exist anymore.
>> > >
>> > > the bitbake fetcher seems to be greedy and fetches refs/* which
>> > > ends
>> > > up fetching pull request when fetching from github, e.g. in my
>> > > workspace:
>> > >
>> > > in $DL_DIR/git2/
>> > >
>> > > github.com.docker.containerd.git/refs/pull/66
>> > > github.com.docker.containerd.git/refs/pull/459
>> > > github.com.docker.containerd.git/refs/pull/551
>> > > github.com.docker.containerd.git/refs/pull/321
>> > > github.com.docker.containerd.git/refs/pull/60
>> > > github.com.docker.containerd.git/refs/pull/523
>> > > github.com.docker.containerd.git/refs/pull/40
>> > > github.com.docker.containerd.git/refs/pull/561
>> > >
>> > > It looks inefficient to fetch and store on each builder pull
>> > > requests.
>> > > I understand this is just because how PR are implemented in
>> > > github,
>> > > but github is quite central, so many we should/could do something
>> > > about it?
>> > >
>> > > Beyond the inefficiencies, we now are seeing unrelated build
>> > > issues
>> > > as well.
>> > >
>> > > What do you think? Should we try to avoid fetching refs/pull/*
>> > > from
>> > > github? or is it our git fetch command that needs to be improve
>> > > to
>> > > work in this situation?
>> > The git fetcher deals with a complicated set of problems since it
>> > needs
>> > to handle offline mirroring (with mirror tarballs) and a variety of
>> > different scenarios. The reason its pulling a complete set of
>> > references is likely to because of the mirroring and other demands
>> > placed upon it from the different scenarios. This isn't bad as
>> > such,
>> > github really shouldn't be sharing repos with invalid references in
>> > them.
>> the repos don't have any invalid references. But when pull requests
>> are updated by users on github, new references are pushed, and we
>> seem
>> to be keeping old (invalid) and new references in our mirrors...
>
> This isn't making sense to me :/.

well. that's the reason why i sent this email in the first place, it
doesn't seem to make any sense!

>
> Can you share a tarball of a repo where the above command gives the
> reference errors you mention? I'd like to have a closer look at what is
> happening...
>
> Or is there another way to reproduce the error?

right now, i can't, it was on our builders, and the fix was to delete
the git tarballs in DL_DIR...

the commit mentioned in the do_fetch() error correspond to github pull
request that have been submitted and eventually merged using github
interface with 'rebase and merge' option. the sha1 that bitbake
complains about corresponds to the sha1 of the initial pull request
before it was rebased and merged in the tree.

I will try to reproduce with a fake github project.

>
> Cheers,
>
> Richard

