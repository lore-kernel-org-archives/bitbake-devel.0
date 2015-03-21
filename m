Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1080F60034
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Mar 2015 10:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2LANaL4002262; Sat, 21 Mar 2015 10:23:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UXkHCmeLZnP2; Sat, 21 Mar 2015 10:23:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2LANNKn002257
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 21 Mar 2015 10:23:35 GMT
Message-ID: <1426933403.14020.1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Chen, Simon (N-DCR SYSTEM HOUSE)" <simon.chen@lmco.com>
Date: Sat, 21 Mar 2015 10:23:23 +0000
In-Reply-To: <D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306@HVXDSP45.us.lmco.com>
References: <D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306@HVXDSP45.us.lmco.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Configuring Busybox's Kernel Commands
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
X-List-Received-Date: Sat, 21 Mar 2015 10:23:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2015-03-20 at 14:25 +0000, Chen, Simon (N-DCR SYSTEM HOUSE)
wrote:
> I am pretty new to the Yocto Project, and I am not sure if this
> mailing list fits my particular project goals. But since I am still
> waiting for subscription permission from other mailing lists, I’d
> thought I’d give this a shot.

This list is really for discussion about bitbake itself. One of the
Yocto lists would be more appropriate for this question.

> I am using Yocto’s Poky to build an OS for a custom board. On this
> embedded OS, I am trying to run an AMD GPU driver installer for the
> E8860 series card in which I am trying to integrate on my board. (This
> installer can be found here :
> http://support.amd.com/en-us/download/desktop?os=Linux+x86). As
> expected, the installer is not fully configured for Yocto. The
> installer (.run file) generates two errors from calling the commands
> “tar” and “gzip”, outputting an “invalid magic” error. I did some
> homework, and realized that Yocto’s linux commands are not from GNU at
> all, and are GNU-like commands built by Busybox. So I’ve tried to
> reconfigure these commands from the pre-bitbake stage by editing the
> “defconfig” file at the meta/recipes-core/busybox/busybox directory.
> In defconfig, I’ve tried turning on a couple of parameters that were
> previously off (ie. CONFIG_FEATURE_TAR_OLDSUN_COMPATIBILITY=y, or
> CONFIG_FEATURE_TAR_LONG_OPTIONS=y). This did not work, after I
> bitbaked core-image-sato, booted the Yocto image on my board, and ran
> the installer. Perhaps I’m missing a step in configuring the GNU
> commands? Perhaps I’m turning on the wrong parameters? Is there a way
> to remove Busybox completely and replace it with the real GNU?

The easiest way to do this is simply to add tar into your image.
IMAGE_INSTALL_append = " tar" in local.conf would probably do this for
you (the space before tar is important).

Cheers,

Richard



