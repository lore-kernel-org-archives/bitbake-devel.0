Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 207F2605FE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jun 2018 10:20:46 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w58AKjGG002234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 8 Jun 2018 11:20:46 +0100
Message-ID: <65e369d383320a651429a9b59a8eb71c862b1d95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 08 Jun 2018 11:20:45 +0100
In-Reply-To: <CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
	<CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
	<CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
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
X-List-Received-Date: Fri, 08 Jun 2018 10:20:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:
> Thanks for the help getting this landed. With this change being part
> of Bitbake, what's the procedure for attempting to get it backported
> to the final MR of Yocto 2.2? Do I just backport it to a certain
> maintenance branch of Bitbake (announced somehow with a prefix on the
> git-send-email subject) and it would magically pop up out the
> corresponding branch of poky if accepted to Bitbake?

With bitbake its a case of requesting backports to the appropriate
stable release branches, either in the form of a patch with [1.3X] in
the subject, or just mention which revision to cherry-pick to which
branch if it cherry-picks cleanly.

I think to get back to 2.2, we'd have to backport to 1.38, 1.36, 1.34
and 1.32. I do get nervous about patches which land in master and then 
immediately get backported across so many releases. I'm less nervous if
the patches cleanly cherry-pick as at least the code is the same. How
cleanly does it backport?

Cheers,

Richard


