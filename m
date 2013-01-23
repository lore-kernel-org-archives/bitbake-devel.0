Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ty2Hh-0004Gz-V4 for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 16:30:43 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NFJ4CM013616; Wed, 23 Jan 2013 15:19:04 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FwZMv1DfwzuF; Wed, 23 Jan 2013 15:19:04 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NFIwMX013607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 23 Jan 2013 15:19:01 GMT
Message-ID: <1358954088.6356.61.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Wed, 23 Jan 2013 15:14:48 +0000
In-Reply-To: <CAMZjud1sM6e2Rd2tWsBjt_XJ7N9J6AZo5OJg+R6q47AXwdg_3A@mail.gmail.com>
References: <CAMZjud1sM6e2Rd2tWsBjt_XJ7N9J6AZo5OJg+R6q47AXwdg_3A@mail.gmail.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: RFC: bugfix for 3575
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
X-List-Received-Date: Wed, 23 Jan 2013 15:30:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-01-23 at 12:08 +0200, Marinescu, Bogdan A wrote:
> Please review my fix of bug 3575 (Ensure windows hob client
> communication with bitbake backend via xmlrpc). I'd like to get
> feedback before uploading the patches. I've pushed my fix on
> poky-contrib:
>http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=bogdanm/b3575
>
> Currently, the fix allows bitbake and hob to run on different machines
> and "talk" to each other via XMLRPC (no windows version yet, but it
> can be tested in Linux). Hopefully the commit messages will tell the
> rest of the story.

First two commits are no problem.

Third Commit:

I don't like the merging of all the extra cache data. I think when a
given UI registers, it needs to call into cooker and inform bitbake it
requires the extra caches (if it does so). With your current code, we
might as well throw away the extra cache code as it effectively works as
the greatest set. I see this only happens in server mode but I'm still
not 100% convinced its the right thing to do.

I also don't see why knotty can't work in server mode?

Fourth Commit:

I have a strong opinion that we want to support multiple clients
connected to one server. I appreciate this complicates things and
currently would be chaotic. I think the easiest way to deal with this is
to have some notion of a single "controller" which would perhaps be
represented by the token. We'd then have some kind of handoff process so
that a given UI could claim the token and then control the server. We
might be able to lose the need for the manual reclaim option too if we
can tie this to the registered handlers somehow?

Any thoughts on that approach? 

Cheers,

Richard







