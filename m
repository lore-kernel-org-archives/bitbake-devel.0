Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id 788B36FFF7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 11:19:58 +0000 (UTC)
Received: by mail-qk0-f179.google.com with SMTP id c4so28129747qkm.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 03:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=C0wZG0rNle9L30RKwV/YaNn99NyftSFdeWSqSSXUWV0=;
	b=DzQt6eGc0XmsFrmaVNgdhpsnkToPr8FkRsZssYnH8fSfiSCAmih2lp3g4uOwQaFGrm
	3E49+zUPTwhESCKbr80RUrsRQdTI2hDAyFdD64hehaAeVs4JYSY/FS+k3IoIhTaUA2oI
	YN+QUORzidj7DrOAQiyEOo/To62XJi09cpekw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=C0wZG0rNle9L30RKwV/YaNn99NyftSFdeWSqSSXUWV0=;
	b=K4l6Ymx3vxciMFHi+pFMI3qEFRzOpyPbgximxTPPjIaup+sYFuQ7zBhSgR7g8YZul0
	xpOvkklF2H5ddm+KEYCBC+x2/y5LcU6MvNqCE7yv5nhISWMU+4boCEUzv3fX0/Bg5SyF
	swHQOmJqWP0dVQ3oE1sCbUPCVqxNY4knaSuyvyXN8wTlzgrKxkcnWstXDCWYteqEKijB
	aSBaj4xwYJdIUBrH8IJZ1/H5oCdgdMREWtu1cZ96neGFMgnz1WViKXIC1Xz5le17wRuw
	NDG2AUcjEMJCNlUn+rrbLgsCnsz4Jm5Fd24AKSEUDeVMWppu2G2jZ4ARahgvF73CZkz8
	90Og==
X-Gm-Message-State: APf1xPD901yEMHfjZ7GPhQzLVKkYMjOJqo3UEVnXOuilGf15hfma4d4M
	hT7/qDvxVM34S5seox/8D/xlcH3VMbi5/EZlMz8Hzg==
X-Google-Smtp-Source: AH8x226Hg2bl3sdTT8DIzChgumPuLVE6cP1ZR6bbtED/olmVnsOfHtyF8cd9FtWWhI7Iog5CEkjN+3206HK426O7hbI=
X-Received: by 10.55.221.76 with SMTP id n73mr3286208qki.53.1518693600081;
	Thu, 15 Feb 2018 03:20:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.170 with HTTP; Thu, 15 Feb 2018 03:19:39 -0800 (PST)
In-Reply-To: <1518692356.24236.122.camel@linuxfoundation.org>
References: <CAP71WjygD3eM2fhhU5JG6Kn3_y=mH1fzy+aVrQFKtp+ED_yoog@mail.gmail.com>
	<1518692356.24236.122.camel@linuxfoundation.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 15 Feb 2018 12:19:39 +0100
Message-ID: <CAP71WjwJ-U3h14D0rZwcm0=eihVpdWRxrmfgmv7G+883Lu5ppg@mail.gmail.com>
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
X-List-Received-Date: Thu, 15 Feb 2018 11:19:59 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 15, 2018 at 11:59 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Wed, 2018-02-07 at 16:04 +0100, Nicolas Dechesne wrote:
>> we've been debugging an issue these days on our builder which ended
>> up
>>  do_fetch failing with
>>
>> LANG=C git -c core.fsyncobjectfiles=0 fetch -f --prune --progress
>> git://github.com/OP-TEE/optee_test.git refs/*:refs/* failed with exit
>> code 128, output:
>> error: Could not read 48e440f5f8d033e1ace6e41f424ecf6e6d96e5f2
>> error: Could not read 019a8db54beb29388e1108831d2e2dc135c1cd73
>>
>> It happens that these refs correspond to pull requests done on github
>> which existed at some point, but have been updated with newer
>> commits,
>> and won't exist anymore.
>>
>> the bitbake fetcher seems to be greedy and fetches refs/* which ends
>> up fetching pull request when fetching from github, e.g. in my
>> workspace:
>>
>> in $DL_DIR/git2/
>>
>> github.com.docker.containerd.git/refs/pull/66
>> github.com.docker.containerd.git/refs/pull/459
>> github.com.docker.containerd.git/refs/pull/551
>> github.com.docker.containerd.git/refs/pull/321
>> github.com.docker.containerd.git/refs/pull/60
>> github.com.docker.containerd.git/refs/pull/523
>> github.com.docker.containerd.git/refs/pull/40
>> github.com.docker.containerd.git/refs/pull/561
>>
>> It looks inefficient to fetch and store on each builder pull
>> requests.
>> I understand this is just because how PR are implemented in github,
>> but github is quite central, so many we should/could do something
>> about it?
>>
>> Beyond the inefficiencies, we now are seeing unrelated build issues
>> as well.
>>
>> What do you think? Should we try to avoid fetching refs/pull/* from
>> github? or is it our git fetch command that needs to be improve to
>> work in this situation?
>
> The git fetcher deals with a complicated set of problems since it needs
> to handle offline mirroring (with mirror tarballs) and a variety of
> different scenarios. The reason its pulling a complete set of
> references is likely to because of the mirroring and other demands
> placed upon it from the different scenarios. This isn't bad as such,
> github really shouldn't be sharing repos with invalid references in
> them.

the repos don't have any invalid references. But when pull requests
are updated by users on github, new references are pushed, and we seem
to be keeping old (invalid) and new references in our mirrors...

>
> I did read this when you sent it, I just don't have any good
> recommendation for you :(

the email is not a request for someone to fix.. just to get some
feedback, and at least mention this issue on the list in case someone
else hits it too...

>
> I dread "special casing" in the git fetcher as has burnt us a lot in
> the past, equally, that may be the only way to avoid this kind of
> problem...

I will try to reproduce the issue with a simpler build/config. It
could be that git is confused by github using refs as refs/pull..

>
> Cheers,
>
> Richard
>
>
>

