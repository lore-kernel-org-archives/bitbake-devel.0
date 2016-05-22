Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 199986FFF7;
	Sun, 22 May 2016 07:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4M7x1Xs031351; Sun, 22 May 2016 08:59:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p5k5Z9hU1r7K; Sun, 22 May 2016 08:59:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4M7wvqJ031347
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 22 May 2016 08:58:58 +0100
Message-ID: <1463903937.9570.12.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Sun, 22 May 2016 08:58:57 +0100
In-Reply-To: <1462826340.21831.151.camel@linuxfoundation.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<1462826340.21831.151.camel@linuxfoundation.org>
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
X-List-Received-Date: Sun, 22 May 2016 07:59:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Where are we at?

The python3 branches in bitbake, OE-Core and poky are looking fairly
good from a build perspective. The run overnight on the autobuilder had
the following issues:

ppc specific sanity test failure:
https://autobuilder.yoctoproject.org/main/builders/nightly-ppc/builds/7
99
https:
//autobuilder.yoctoproject.org/main/builders/nightly-ppc-lsb/builds/770

weird intermittent multilib failure:
https:/
/autobuilder.yoctoproject.org/main/builders/nightly-multilib/builds/795

4 test failures in oe-selftest:
https://autobuilder.yoctoproject.org/main/builders/nightly-oe-selftest/
builds/517

which given the scope of the changes isn't so bad.

I have merged some of the pieces which are 2.7 safe into master. We've
had some issues with buildtools-tarball and the python3 it contains but
I think we're nearly there in resolving that. I don't believe toaster i
quite there yet either but getting close.

The question is therefore how much more work to do before those
branches are ready for merging? They do need a little more cosmetic
cleanup but I think things are very close.

I would like to get them merged sooner than later since they are quite
a nightmare to maintain.

Cheers,

Richard


