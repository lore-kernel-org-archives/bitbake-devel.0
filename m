Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail.openembedded.org (Postfix) with ESMTP id DA6D77E68A
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Jun 2019 21:38:45 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id x4so11596893wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Jun 2019 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=Yj7RdNp6wn0JyfL+SyYy/WfXwYDDksMTdzlgD5CE0Y0=;
	b=bD4UKwGAc8oPqKMCvWeNZtGisScmynx4Sv2ZqTeF1a1CKCMA8ob/IhH8hAlvmRwc+M
	l/z+SyRBLfnf3wETJ0DHVBZz+v1Pfn3r+69LM793dPtvg0AzJLrXxLDhfgFf77O+8Uun
	+9+Y3/bkrLZEXbxAc6O4e9XMCPHVlhXDWIXHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=Yj7RdNp6wn0JyfL+SyYy/WfXwYDDksMTdzlgD5CE0Y0=;
	b=j8wH9OdEJ+4vYOz/zlZWMbjKqhXSUAgYQZUNapAyOI4XTpfaYx3xeZfluF+PxxfRen
	JiaA/IMqw/W8MigbDOsurhrdgvD1UXS0q4Css94C5JH8Vkg4/z3SU9q50ehFMBo7Faet
	qNmKCHXYJiJXkuEygce5cmAnJhYqNhM+nD8UeOJpNbJkSUwyrAfvXGHNqoablr60C3a2
	bVbMsAAhQZjLq9LCWc/z80B1nT9CoAdDe4OGWJUU0v60dzwVLJQN16Ie3q4cPVIIyenz
	2kEVzs+0qGPjLD/HHw3DDF3HEWkmGjTYrnz1KceYYe6UJ5eXgulFs2saqitVq7baoasy
	KnrQ==
X-Gm-Message-State: APjAAAVMmUfRdgqnH97LGZ7PVqKtYpmcRrUqGJnknFQw8HEECF4RJqt5
	qSm5X75SojBZ0cRGXdFK4VBVCGWO+5s=
X-Google-Smtp-Source: APXvYqzF2bi12QfrWHgthIQL1C/rpEtRhUXDp1Z+j8FbiaBF/XpGQxEVmtTOVk9n5gCyvKK52shVhQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr16810985wrl.336.1561930726472;
	Sun, 30 Jun 2019 14:38:46 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c15sm12292709wrd.88.2019.06.30.14.38.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 30 Jun 2019 14:38:45 -0700 (PDT)
Message-ID: <d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alan Kozlay <alan.kozlay@ves-solutions.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 30 Jun 2019 22:38:44 +0100
In-Reply-To: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
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
X-List-Received-Date: Sun, 30 Jun 2019 21:38:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-06-28 at 13:31 -0400, Alan Kozlay wrote:
> We have need to generate 6 slighly different images, with different
> dedicated applications and use cases, but they're all destined for
> the same hardware.
> We have multiconfig set to build these 6 variants.  Clearly, they'll
> all share a majority of underlying packages.
> While the bitbake initialization takes a long time (with
> multiconfig), we were under the impression that it could save time
> during the actual build process because it could have the potential
> to reuse packages already built from mc A for mc B if the inputs to
> the recipes are unchanged (if same xxx_FEATURES, same arch, etc.).
> 
> This was a guess on our part since we initially didn't assign
> different tmp directories for each conf.  So, the <WORKDIR> didn't
> change between mc builds.  That actually was causing some issues
> until we realized that separate tmp dirs was recommended for them.
> Since they all now have separate tmp dirs, they clearly are not going
> to share work dirs, so, now we're questioning our original assumption
> about any build-time speed benefit.
> 
> So, is mc expected to be any faster than, say, 6 separate invocations
> of non-mc bitbake whilst switching out the local.conf between them? 

Ultimately, yes, it would be expected to be faster.

With the code as it stands today, no, it won't be. Its a known open
issue:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=10682

What would be faster is to build one of the configs initially which
will populate the sstate cache, then build the other 5 together in one
multiconfig.

We obviously want to get that issue fixed ultimately but its not an
easy thing to do due to the way our codebase works.

Cheers,

Richard


