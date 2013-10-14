Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E986460F06
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 14:34:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EEXKU1002343; Mon, 14 Oct 2013 15:34:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZUgOEImVStvX; Mon, 14 Oct 2013 15:34:04 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9EEXxhR002370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 14 Oct 2013 15:34:01 +0100
Message-ID: <1381761236.29912.322.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Morgan <chmorgan@gmail.com>
Date: Mon, 14 Oct 2013 15:33:56 +0100
In-Reply-To: <1381683215.29912.233.camel@ted>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
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
X-List-Received-Date: Mon, 14 Oct 2013 14:34:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2013-10-13 at 17:53 +0100, Richard Purdie wrote:

> Its certainly possible, its just that nobody has done it. Your options
> would be to either reconfigure the native recipes to be packaged, or to
> add in a configuration which shortcircuits the cross compiler and adds
> in some native magic to specific machine targets.
> 
> Whilst adding packaging to native sounds attractive, the reality is that
> its not easy and doesn't really make sense technically. Adding in those
> short-circuits I mention by comparison shouldn't be hard and if I were
> doing this, its the way I'd go.

I had a kind of morbid curiosity about this. I came up with the patches
here:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/t2&id=c1c02d166f22179fb18e430aeae2806bb5d51a3f

where I've basically tried to wire in the host gcc yet compile
everything else for the target as usual including the libc. Its a bit of
an arbitrary choice but should in theory be easier than providing a
whole libc from the native system.

It works to a point (e.g. gettext compiled) but ncurses did not due to
symbol errors with __poll_chk. Why? Basically the compiler/linker do not
respect the sysroot, go searching for libc and find the system one
rather than the one we built. It then fails to link as there is version
mismatch. There isn't any compiler commandline option you can tweak to
stop it doing this :(.

Some questions this raises:

a) Do you use a sysroot of "/" or STAGING_DIR_TARGET?

I did the latter, it wasn't particularly successful as the tools don't
all respect it properly. In theory you can link the pieces inside the
STAGING_DIR to outside the sysroot if you want the compiler to see them,
the reality is some search paths are hardcoded into gcc and they leak
in. When we compile our compiler, we configure it not to do that.

To use "/" you'd have to do what native.bbclass does, set
STAGING_DIR_TARGET to be "/" and then set prefix to be inside the
STAGING_DIR but this means that binaries would expect to always run with
such a prefix.

I guess a hybrid would be possible, add -L and -I for the sysroot and
accept it linking with the system lib/include directories, ditching the
sysroot option a bit like the system did before gcc has sysroot support.

b) Can you use the system compiler without the libc?

Answer appears to be no, you can't. This means you would have to add in
some kind of tweaking to the output packages to add in dependencies on
libc and anything else that was system provided. You can therefore not
use this approach to build complete systems. Packaging up the system
provided libc would also seem to be ruled out.

Cheers,

Richard






