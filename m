Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 43F806FF4E;
	Mon,  9 May 2016 20:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49Kd38o004732; Mon, 9 May 2016 21:39:03 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BEmy9za7pZDv; Mon,  9 May 2016 21:39:03 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49Kd0JE004715
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 9 May 2016 21:39:01 +0100
Message-ID: <1462826340.21831.151.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 09 May 2016 21:39:00 +0100
In-Reply-To: <1462352176.18407.11.camel@linuxfoundation.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: Python 3 for Bitbake
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
X-List-Received-Date: Mon, 09 May 2016 20:39:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-05-04 at 09:56 +0100, Richard Purdie wrote:
> My proposal is we decide to have the flag day, we queue up the 
> patches on a python3 branch both in oe-core and bitbake, then we 
> switch when we get successful autobuilder builds. I'd ideally like to 
> do this quite soon and get one with it (within a few weeks), leaving 
> plenty of time to handle issues and the other changes planned for 
> this release cycle and give other layers time to adapt.

To update, there are python3 branches in bitbake and OE-Core. With
those I've been able to "bitbake core-image-sato:do_rootfs core-image
-sato:do_populate_sdk" with the process and xmlrpc backends.

I've had a few issues to resolve, not least that we need to ensure
python is in utf-8 mode when it is started else files are opened as
ascii and all kinds of things break. Once started, you can't change the
default filesystem access mode and never will be able to for reasons
explained in a PEP.

I still haven't tried the various supporting tools, toaster, UIs other
than knotty, the oeqa framework.

I've separated out some patches and key fixes and submitted them, I
still have a monster patch which needs splitting up for both OE-Core
and bitbake though.

Help is welcome but a heads up on which area anyone is touching would
be appreciated. I know Ed plans to look at toaster.

Cheers,

Richard



