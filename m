Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5F193771BE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 14:03:01 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w56E2w3D004058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 6 Jun 2018 15:02:59 +0100
Message-ID: <f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Hoosier <matt.hoosier@gmail.com>
Date: Wed, 06 Jun 2018 15:02:58 +0100
In-Reply-To: <CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Wed, 06 Jun 2018 14:03:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-06-06 at 08:36 -0500, Matt Hoosier wrote:
> Okay, I'll see what's going on with that. I'm still interested to
> know if there's a listing of all the various automated regimens that
> are used as CI before accepting Bitbake/Poky patches -- I don't want
> to keep wasting the maintainers' time with failures that I could have
> uncovered independently.

The test matrix is basically encoded into:

http://git.yoctoproject.org/cgit.cgi/yocto-autobuilder-helper/tree/config.json

run across the various autobuilder workers on https://autobuilder.yocto
.io/buildslaves, i.e. centos7, debian8, debian9, fedora26, fedora27,
opensuse423, opensuse tumbleweed, ubuntu 1604 and ubuntu 1704

I'm not sure its reasonable to expect everyone to test across all those
combinations!

> Any comments on the aims and overall technique of this change? So far
> all I've really gotten back are copy/pastes of automated builder
> failures.

I strongly believe we should only have network access in do_fetch and
that our source mirroring should be functional and I therefore very
much support what the patch is doing and appreciate this getting fixed.

Sorry for the terse nature of the replies, we're just seeing a lot of
patches which are breaking the regression tests and its hard to root
cause them back to the underlying patches and help people debug them.

I do appreciate the help in getting this issue fixed as it will be a
good improvement to the fetcher.

Cheers,

Richard



 

