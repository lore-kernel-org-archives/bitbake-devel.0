Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 73D4F6AF50
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Oct 2013 16:53:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9DGrgCP007761; Sun, 13 Oct 2013 17:53:43 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KBn7nxK8JEcW; Sun, 13 Oct 2013 17:53:42 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9DGrduG007752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sun, 13 Oct 2013 17:53:40 +0100
Message-ID: <1381683215.29912.233.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Morgan <chmorgan@gmail.com>
Date: Sun, 13 Oct 2013 17:53:35 +0100
In-Reply-To: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Sun, 13 Oct 2013 16:53:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-10-11 at 09:22 -0400, Chris Morgan wrote:
> I'm working on a project that generates several libraries and
> applications. Today we build and run exclusively on x86 Linux desktop
> machines and use cmake for the build system. In the future we plan to
> add cross-compiling of these same libraries and applications for an
> embedded arm platform, Yocto based. We would like to maintain both
> types of build, for x86 and for arm.
> 
> I've seen guides on how to use Yocto (or other bitbake based
> distributions) to generate x86 images but these appear to involve
> building the entire x86 toolchain, kernel, all libraries, creating a
> virtual root and building a root filesystem image that one would run
> under an emulator.

This isn't entirely accurate. You can choose just to build a given
library for example (bitbake libfoo). All its default dependencies are
also built though, which means in most cases, a cross toolchain would be
triggered. There is no need to build a kernel or a complete rootfs.

> In my case I'd like to use bitbake to build libraries and applications
> and create a virtual root, but not create a kernel, toolchain and
> other system provided libraries. Then, when we decide to transition
> over to Yocto I'd like to leverage the recipes by plugging them into
> the Yocto system somehow (I'm still starting to understand the
> process).

To try and clarify, we have roughly three types of target recipes:

a) target system

These are for the target system defined by MACHINE and are cross
compiled by a cross toolchain against a cross compiled libc. target can
be different to the build architecture. They are packaged and managed by
a package manager.

b) nativesdk

These are standalone binaries designed to run on SDKMACHINE. They are
cross compiled and link against their own libc which is designed to run
in some location defined at install time. We use these to generate
toolchain binaries and tools that can run on pretty much an Linux
system, regardless of its kernel, libc or system layout. They are
packaged and managed by a package manager.

c) native

These are compiled to run on the build system. They work very much like
you describe except they are not packaged at all.

(I'm ignoring -cross and -crosssdk since these are basically toolchain
bootstrap details).

> I haven't seen any guides or information on how to use bitbake for
> native desktop applications. I feel like its certainly possible but it
> appears to be quite a bit of work just to proof of concept things.
> 
> Is there anything inherently wrong with what I'm proposing here with
> bitbake? Does it make sense that it would save time to develop the
> recipes once and use bitbake for the desktop like this?

Its certainly possible, its just that nobody has done it. Your options
would be to either reconfigure the native recipes to be packaged, or to
add in a configuration which shortcircuits the cross compiler and adds
in some native magic to specific machine targets.

Whilst adding packaging to native sounds attractive, the reality is that
its not easy and doesn't really make sense technically. Adding in those
short-circuits I mention by comparison shouldn't be hard and if I were
doing this, its the way I'd go.

Cheers,

Richard


