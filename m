Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7DC636FFEA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 10:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QApQHW015534; Fri, 26 Feb 2016 10:51:26 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZxI1FD2D_M2G; Fri, 26 Feb 2016 10:51:26 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QApKMP015530
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 26 Feb 2016 10:51:22 GMT
Message-ID: <1456483880.11498.68.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Shashkevich <alex@stunpix.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 26 Feb 2016 10:51:20 +0000
In-Reply-To: <1456417951-11336-1-git-send-email-alex@stunpix.com>
References: <1456417951-11336-1-git-send-email-alex@stunpix.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Fri, 26 Feb 2016 10:51:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-02-25 at 18:32 +0200, Alexander Shashkevich wrote:
> When in SRC_URI appears file://dir;subdir=foo unpacker copies 'dir'
> to ${WORKDIR}, not
> ${WORKDIR}/foo as it should be.
> 
> These changes are fixing following bugs as well:
> Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
> Bug 6129 - Local directories unpack to a different location than
> local files

Sadly, this change isn't without side effects. For example:

https://autobuilder.yoctoproject.org/main/builders/nightly-x86-64/builds/680/steps/Building%20Toolchain%20Images/logs/stdio

| NOTE: Unpacking /home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/scripts/runqemu to /home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/build/tmp/work/i686-nativesdk-pokysdk-linux/nativesdk-qemu-helper/1.0-r9/
| cp: `/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/scripts/runqemu' and `/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-x86-64/build/scripts/runqemu' are the same file
| DEBUG: Python function base_do_unpack finished
| DEBUG: Python function do_unpack finished

Cheers,

Richard

