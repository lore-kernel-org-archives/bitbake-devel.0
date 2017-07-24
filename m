Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id D7C7A782E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 21:04:14 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id l81so22129652wmg.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=gaRI7apT1n3FtgX1cEgvey/YNAVeUavGMf3rkm6mZjc=;
	b=j1PGha36aUJuJ7+/w2GoscXQJobv0P/JDBSnRu/wKbAOjmmWqTprbNrr6+vki4Aslp
	n4CCtG02YKgql/bu4aE3/P4bWEQF3RPJ2oCmwsL+7xpkOSe/kJnMFImVq8qZCL/Acw/T
	CEXFXBaELQrDOg4bS+2ipHaQspgw2wbgvn+Pc/7NnwTcA+RGudPIyu04NAZfz/FrMqi5
	Jq4a4Z/zK9cjrQs71AErKOv1xaWPui64/r+ydSzqnkDeK1fq/tcfm+yxKK+8E4oO0x5O
	jx0MWmF+QNAvd6KXEuT4VXX/o4c8i0A8mj0z+AF2wHCGQDu9hDCdZSJa+M3r5j+5iU7H
	tgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=gaRI7apT1n3FtgX1cEgvey/YNAVeUavGMf3rkm6mZjc=;
	b=QcSJz1deX4kp6UbhqoPLU7CS2sH9hKMoS3i3DbBoJwjlfLyugc6H9QkzuxKFFQbVTi
	hECV9kEgziTs2zVQDay+k8IVjoGwqcPruECNy18scfnAlEK9+jVZF0Ff/VmW5NeG/raQ
	9TczryD3r01jFRtXEzJZNbDs1LXAyLMkF2+H/8BJTIeZF333Fky+5gloY2Ot12o6uJX6
	FIAxRTIzwfFBdCAoLNLmk3/tbCVmS59QuARuYgmboCLMSo/kHf3kPSwRmL/3CwpBFvEL
	N0O64dvv5Ak+HYY778mrlxgC1DF2rDc1ClenF1ug5S262TnP4Zxs9AlDIRgjERs5w5tz
	OgNg==
X-Gm-Message-State: AIVw110YI9fkskuHPDDXZX83rN0NXDo5CwgbPBqyI9ZKI/10AqPLcD3E
	qPLB1oBdesjcvMGz+YXRkgmIzB49og==
X-Received: by 10.28.37.193 with SMTP id l184mr6267420wml.24.1500930255671;
	Mon, 24 Jul 2017 14:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.175.16 with HTTP; Mon, 24 Jul 2017 14:04:15 -0700 (PDT)
In-Reply-To: <1464702613.3814.2.camel@linuxfoundation.org>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
	<1464702613.3814.2.camel@linuxfoundation.org>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 24 Jul 2017 14:04:15 -0700
Message-ID: <CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Fabien Proriol <fabien.proriol@jdsu.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	fabien.proriolpatch@kazoe.org
Subject: Re: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
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
X-List-Received-Date: Mon, 24 Jul 2017 21:04:15 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, May 31, 2016 at 6:50 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2016-05-31 at 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>>
>> This patch add the possibility to bitbake to avoid git protocol to
>> fetch sources.
>> This is usefull in some network with firewall blocking git port.
>>
>> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is
>> used to find the new protocol (http or https) and the new host (if
>> different) to used.
>>
>> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted.
>> This is usefull for exemple, if we use local git repository inside
>> the network.
>>
>> Exemple usage:
>>     # Avoid all git protocol
>>     BB_GIT_PROTOCOL_FIREWALL = "1"
>>
>>     # Avoid git protocol, except for srv1 and srv2 in local network
>>     BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"
>
> Why not use the more generic MIRRORS and PREMIRRORS for this? If they
> can't support this, we likely should figure out a way to make them work
> for it rather than adding new fetcher specific variables.

Sorry for resurrecting such an old thread, but I'm wondering if
there's been any more work on an upstreamable solution?

The problem being that recipes which define SRC_URI to git://* with
protocol=git (or with protocol unspecified, since git is the default)
fail during fetching for users working behind a firewall which blocks
the native git protocol.

Although MIRRORS and PREMIRRORS allow mapping from one host to another
there's no support for mapping one git fetch protocol to another and
it looks like extending the MIRRORS syntax to support that would be a
non-trivial change...

> Cheers,
>
> Richard
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

