Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UUZQh-0006zp-C9; Tue, 23 Apr 2013 11:22:29 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3N95h4l029995; Tue, 23 Apr 2013 10:05:43 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iC085r5twyw1; Tue, 23 Apr 2013 10:05:42 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3N95eCA029986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 23 Apr 2013 10:05:42 +0100
Message-ID: <1366707875.23738.40.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Tue, 23 Apr 2013 10:04:35 +0100
In-Reply-To: <51758B94.8010405@linaro.org>
References: <1366640172.23738.12.camel@ted> <51758B94.8010405@linaro.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 23 Apr 2013 09:22:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-04-22 at 21:12 +0200, Marcin Juszkiewicz wrote:
> W dniu 22.04.2013 16:16, Richard Purdie pisze:
> > I've been giving some thought to where BitBake needs to go in the 
> > future in order to deliver for its users. It started life as a 
> > commandline utility and its grown a lot since it was first created.
> > I think there are some key decisions that need to be taken to ensure 
> > its future growth.
> 
> There is one thing which kind of bothers me. "ERROR" message which is
> just a warning. Like:
> 
> ERROR: libelf is listed in PACKAGES multiple times, this leads to packaging errors.
> ERROR: libasm is listed in PACKAGES multiple times, this leads to packaging errors.
> ERROR: libdw is listed in PACKAGES multiple times, this leads to packaging errors.
> ERROR: libdw-dev is listed in PACKAGES multiple times, this leads to packaging errors.
> ERROR: libasm-dev is listed in PACKAGES multiple times, this leads to packaging errors.
> ERROR: libelf-dev is listed in PACKAGES multiple times, this leads to packaging errors.
> 
> If it is error then let BitBake exit instead of doing task. If it is
> not error but just a warning then let it be renamed?

What we're trying to do is move everything to use a standard mechanism
for reporting issues of this type. With insane.bbclass, you can elect
whether a given type of error is a warning or errors and fails the task.

There are however several places where bb.error is used without that
mechanism. I'd love to see them fixed, please file a bug for it...

> My recent build failed with:
> 
> --------
> NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Started
> NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Succeeded
> NOTE: Tasks Summary: Attempted 2247 tasks of which 915 didn't need to be rerun and all succeeded.
> 
> Summary: There were 3 WARNING messages shown.
> Summary: There were 6 ERROR messages shown, returning a non-zero exit code.
> Build step 'Execute shell' marked build as failure
> --------
> 
> "all succeeded" does not look like a reason to fail a build.

Agreed, please open a bug for it.

FWIW Bitbake will set a non-zero exit code if any error messages appear,
as the message says. Whilst people find that confusing, I continue to
believe it is the right thing to be doing and we need to tighten up
things in other places as I describe above. That error code does help us
catch problems on the autobuilders and so forth.

Cheers,

Richard






