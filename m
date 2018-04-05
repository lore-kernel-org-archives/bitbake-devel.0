Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BC0C075030
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Apr 2018 16:57:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w35Gv2BM020919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 5 Apr 2018 17:57:04 +0100
Message-ID: <1522947422.11431.433.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Daniel Levin <dendy.ua@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 05 Apr 2018 17:57:02 +0100
In-Reply-To: <CAAvz69xX76ukua1z=t9OxeXKxx_K=UFO_C47QDux-nCSN_eZwg@mail.gmail.com>
References: <CAAvz69xX76ukua1z=t9OxeXKxx_K=UFO_C47QDux-nCSN_eZwg@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: Conditional DAG recalculation at build time
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
X-List-Received-Date: Thu, 05 Apr 2018 16:57:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-01-29 at 23:06 -0800, Daniel Levin wrote:
> In short: does bitbake support dependency graph recalculation at
> build time?
> 
> I am looking for a dependency resolution similar to BYPRODUCTS in
> CMake and restat in Ninja.
> 
> In other words when task _after_ execution might tell that output did
> not actually change. So all dependencies of that target should not be
> updated. Even when initially they were treated as (potentially) to be
> updated.
> 
> Usually in CMake that results in remaining task count decreased
> instantly during build time, because in fact they must not be
> running.
> 
> I found documentation in bitbake about task _input_ checksum, which
> is used to evaluate whether task need to be executed.
> So I am looking for the similar checksum for the task _output_. And
> when task does not change that output checksum means that
> dependencies of that output does not need to be triggered.
> 
> If this topic is well known and documented then could you please
> point me to the appropriate section in the documentation?

There are mailing list posts from me a long time ago when we added
checksum support and sstate explaining why we use input values rather
than outputs and the pros/cons of either.

Also, more recently, have a read of the thread "[yocto] RFC: Backwards
compatibility checking sstate-cache" on the yocto list. Its a similar
request.

My own thoughts are that the best way forward would be some kind of
equivalence server so that we could remap sstate values back to a
master value.

The first step would be to allow such a server to exist and to allow
resolution of a hash to a master base value.

Allowing bitbake to recalculate its taskgraph and dynamically adapt to
this would then be a secondary step in the interests of efficiency.

The first piece would be minimally invasive. The second piece would
mean huge changes to the way bitbake operates.

I'm not sure if anyone is pursuing this but its an interesting topic
I've given a bit of thought to.

Cheers,

Richard





