Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 937576B6F7;
	Fri, 10 Jun 2016 15:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5AFXYxe027496; Fri, 10 Jun 2016 16:33:34 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KYLwjSwL0vkL; Fri, 10 Jun 2016 16:33:34 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5AFXTIp027464
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Jun 2016 16:33:30 +0100
Message-ID: <1465572809.13979.185.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Date: Fri, 10 Jun 2016 16:33:29 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Multi-configuration builds
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
X-List-Received-Date: Fri, 10 Jun 2016 15:33:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

A few people have asked about multi-machine builds. Firstly, to be
clear, the way to implement this is as multiple configuration builds.
This is because:

a) Bitbake has no knowledge of MACHINE, its an OE implementation detail
b) There are other variables which would make sense to vary in builds
such as SDKMACHINE, possibly libc or distro too.

I have been wanting to experiment with the codebase a bit before
committing to exactly how this would work. This is so that we can try
and avoid huge invasive changes to bitbake if we can help it and to
ensure we get an optimal implementation. With the work I've done over
the past couple of weeks, I do have some idea how its likely to work
though.

To enable it, there would be a line in local.conf a bit like:

BBMULTICONFIG = "configA configB configC"

(or likely from the environment in the future like MACHINE).

This would tell bitbake that before it parses the base configuration,
it should load conf/configA.conf and so on for each different
configuration. These would contain lines like:

MACHINE = "A"

or other variables which can be set which can be built in the same
build directory (or change TMPDIR not to conflict).

One downside I've already discovered is that if we want to inherit this
file right at the start of parsing, the only place you can put the
configurations is in "cwd", since BBPATH isn't constructed until the
layers are parsed and therefore using it as a preconf file isn't
possible unless its located there. I've decided to worry about that
later right now.

Execution of these targets would likely be in the form "bitbake
multiconfig:configA:core-image-minimal core-image-sato" so similar to
our virtclass approach for native/nativesdk/multilib.

Implementation wise, the implication is that instead of tasks being
uniquely referenced with "recipename/fn:task" it now needs to be
"configuration:recipename:task".

We already started using "virtual" filenames for recipes when we
implemented BBCLASSEXTEND and my proposal is to add a new prefix to
these, "multiconfig:<configname>:" and hence avoid changes to a large
part of the codebase thanks to this. I have an approach where
databuilder has an internal array of data stores and uses the right one
depending on the supplied virtual filename which seems to work well.

That trick allows us to use the existing parsing code including the
multithreading mostly unchanged. The next issue is the cache and here,
we can again make it use the virtual filenames without much pain.

The problems start where the recipe cache is parsed into an object
which lists providers and so on (cooker.recipecache). Here it makes
sense to change to an array of recipecaches, one for each
configuration.

The real problems are the apparent as taskdata and runqueue can only
deal with one recipecache, not multiple entries.

My initial plan is to have completely unlinked builds, so iterate
recipecaches, building individual taskdata objects from them, then
teach runqueue to process the multiple taskdata objects into a single
runqueue. There would be no support for dependencies between the
different configurations.

Once that works, we can look at allowing dependencies between the
different configurations. Rather than overload DEPENDS further, I'd
likely prefer to use a new task flag for these inter-configuration
dependencies.

Initially, I'm planning to implement this without sstate optimisations.
This means if the build uses the same object twice in say two different
TMPDIRs, it will either load from an existing sstate cache at the start
or build it twice. We can then in due course look at ways in which it
would only build it once and then reuse it. This will likely need
significant changes to the way sstate currenty works to make that
possible.

I've shared a branch with the work I have so far on it:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/mul
ticonfig

Its all in the top commit and not split into logical commits yet or
anything very neat. It can:

* Parse the multiple configurations
* Load the multiple configurations from the cache
* Run tasks with -b (bitbake -b multiconfig:qemuppc:bash_4)

which is a good start but as yet the taskdata and runqueue changes aren
't done so there is no dependency handling.

Cheers,

Richard


