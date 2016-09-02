Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 04131770F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Sep 2016 11:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u82BvoMO007348; Fri, 2 Sep 2016 12:57:50 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nJ1gQj-zg84C; Fri,  2 Sep 2016 12:57:50 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u82BvjKR007342
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Sep 2016 12:57:47 +0100
Message-ID: <1472817465.29583.164.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Evade Flow <evadeflow@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 02 Sep 2016 12:57:45 +0100
In-Reply-To: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
References: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
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
X-List-Received-Date: Fri, 02 Sep 2016 11:57:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2016-09-01 at 11:29 -0400, Evade Flow wrote:
> This might be an 'X-Y' problem, so I should explain what I'm trying
> to achieve. We have a somewhat beefy build server with 32 cores that
> most of my team likes to `ssh` into to do builds of our Yocto/OE
> -based BSP. But a few of us build on different machines often enough
> that I recently spun up a web server—on the 32-core build machine—to
> act as a 'pre-mirror' to statically serve  our dependencies for
> remote builds. The web server is serving the exact same folder that
> I've been pointing `SOURCE_MIRROR_URL` at, as described at: https://w
> iki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_source_d
> ownload_mirror_.3F
> 
> When I went to integrate support for the HTTP pre-mirror, I ran into
> the following problem: if I assign `SOURCE_MIRROR_URL` and the
> specified folder doesn't exist (as will be the case for remote
> builds), the build *fails*. I had hoped that bitbake would 'fall
> through' to searching other pre-mirrors, but that doesn't appear to
> be the case(?)
> 
> IIs there some way I can use a specific (and *invariant*) local
> source mirror folder *only if it exists*, and use our internal HTTP
> pre-mirror otherwise?

You could do something like:

def testislocal(d):
    if os.path.exists("xxxx")
        return "local"
 
  return ""

LOCALBUILD = "${@testislocal(d)}"

SOURCE_MIRROR_URL ?= "{@base_contains('LOCALBUILD', 'local', 'file://xxx', 'http://xxx', d)}"

I'm sure there are ways to neaten this up but you get the idea...

Cheers,

Richard




