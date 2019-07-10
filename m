Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 5EB3A7EF14
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 09:32:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id g17so1667161wrr.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=jpazy8f6FFj3gzmF3yT3e3w5JoBjN7E+sTezSjij+Fs=;
	b=CdPJdzFAQdu96uEMQ/yeq43/DY4SWCs2OvoyH+7W2tj6+ByEiQ+G1n6uYM4mRSj4I6
	eCtgYg8XRE5s+Ngr4CRPQ+RCL7WZjRlVJUeYjVZBCYXjIXxOVVGO82vkPPy06BY+JIb1
	jK6F8osZ1+lmbL2SjJF/1hzHHxoPFuqyqvM/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=jpazy8f6FFj3gzmF3yT3e3w5JoBjN7E+sTezSjij+Fs=;
	b=cpjGIKnX7MiZnhTLaZwboSMmw01vrQvu+FllBLYXei2IuuhgMHmymby1th5Oa+PpMd
	e/d3qhq3UrXAsvygE84edccUYjtjupwl+YbcZ6KjcbrrVkzafUMX1jPURwRHEIBmy+fc
	ikrLu37ai8WHl9EBAEl1wBTi6mNlhivG1L3LuN7vs4xrMDzsk7uXdWaGn5VIWsHFa290
	AflYH72wY9ZEFXtHDT8g4n4Cpt16cXMiUI+FC+lQJ3I2eDAnOzZ6xpojhkYmCH96JuHl
	cj4bOVqTnft5fsBaRzazaV67WetAMj8JpTOIaBVA5xvK1jGq2C7B447TU2x1ONqxubZL
	KqbA==
X-Gm-Message-State: APjAAAVVFc8XIjqXIfX33W+NxT5XTPRAGlcLS04IBS2xSzsbFW9PWdNe
	kSalxa3vuNqUg285xJfowSf0SxAtLRc=
X-Google-Smtp-Source: APXvYqwyS7/tpL+sNhhZBB/t1nK02nT6Xvjhg5OUw92arLyg+xWtdE4QVQehnyPyX4ZLSyyb3CMDDA==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr5529664wro.324.1562751144032; 
	Wed, 10 Jul 2019 02:32:24 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n14sm2308789wra.75.2019.07.10.02.32.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 02:32:23 -0700 (PDT)
Message-ID: <a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alan Kozlay <alan.kozlay@ves-solutions.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jul 2019 10:32:22 +0100
In-Reply-To: <CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Wed, 10 Jul 2019 09:32:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-07-08 at 14:27 -0400, Alan Kozlay wrote:
> We're looking for things we can do to improve the multiconfig build
> time.
> 
> Even on our build servers it still takes a long time.
> For instance, our build servers each have 64 core, 128G RAM with 4
> NVMe SSD HDs in a striped raid (all configured with bells and
> whistles to make it super fast).
> A full fresh build on one of those servers still takes 6 hours.

Given we have no idea what these mulitconfigs are, how much overlap
there is or how you're running it, its hard to know whether 6 hours is
good or bad.

> I need to also clarify that we do indeed define different
> DISTRO_FEATURES between multiconfigs, so multiconfig is necessary.
> 
> (1) We're attempting to use the ccache (via ccache.bbclass), but it's
> causing some build errors that we're investigating.

That shouldn't cause errors and would likely be some ccache problem.

> (2) Can we at least set the root native work directory to be the same
> for all multiconfigs?

It depends if the configurations are different or not. WORKDIR isn't
your problem here, you really need the builds to have the same sysroot-
components dir for the native case too, else this won't work. Its more
about the output from the task than the directory they were built in.

> Would each multiconfig honor the previously built native tools?
> Or, would it just rebuild them, anyway?
> Is this safe or tested or supported?

multiconfig is configured so that if it sees overlapping stamp files it
would handle that correctly. The tricky part is you'd have to split
some directories which aren't usually split such as sysroot-components. 
I've never seen that attempted and am not sure if it would work or not.

> (3) We're considering a network shared sstate-cache.  But it's not
> entirely clear if a multiconfig build is benefited by the sstate-
> cache directory.
> Under what circumstances does a multiconfig leverage sstate-cache
> when building for another multiconfig?

Right now today for a single multiconfig build it won't.

> What if the recipe would be affected by a change in DISTRO_FEATURES
> between multiconfigs?
> Are native packages included in the sstate-cache or just target
> packages?

native and target are included in sstate-cache.

> We welcome all thoughts and ideas.

With current bitbake you'd be best off splitting your multiconfig build
into two parts a first stage where you build common shared components
and a second where you leverage them.

I appreciate that isn't a good solution but its what will work right
now.

The initial work in adapting bitbake to better handle situations like
this is being done, as we speak and there are patches starting it in
master-next.

Right now those patches also won't change anything for you, they re-
architect the codebase so we have a chance of implementing what you
want. It is however at least a start. I'm working on this effectively
alone with the day to day patch review, email and bugs to handle at the
same time :(. As a project we know this is important but we struggle to
find people willing to contribute development resources to make these
kinds of changes happen.

Next step is to write a regression test suite for runqueue. Once I've
done that I'll start to think about optimisation work.

Cheers,

Richard



