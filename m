Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UUZMU-0006NQ-8v for bitbake-devel@lists.openembedded.org;
	Tue, 23 Apr 2013 11:18:07 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3N91GnS029803; Tue, 23 Apr 2013 10:01:16 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KL0zKrnLruNG; Tue, 23 Apr 2013 10:01:16 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3N91B15029785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 23 Apr 2013 10:01:13 +0100
Message-ID: <1366707606.23738.36.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Tue, 23 Apr 2013 10:00:06 +0100
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC79861BB305B@xmail3.se.axis.com>
References: <1366640172.23738.12.camel@ted>
	<A612847CFE53224C91B23E3A5B48BAC79861BB305B@xmail3.se.axis.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 23 Apr 2013 09:18:10 -0000
X-List-Received-Date: Tue, 23 Apr 2013 09:18:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-04-23 at 10:13 +0200, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: openembedded-core-bounces@lists.openembedded.org
> > [mailto:openembedded-core-bounces@lists.openembedded.org] On Behalf Of
> > Richard Purdie
> > Sent: den 22 april 2013 16:16
> > To: bitbake-devel
> > Cc: openembedded-core
> > Subject: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
> > 
> > I've been giving some thought to where BitBake needs to go in the
> > future in order to deliver for its users. It started life as a 
> > commandline utility and its grown a lot since it was first created. 
> > I think there are some key decisions that need to be taken to 
> > ensure its future growth.
> > 
> > The first proposal is that we should change the BitBake server so 
> > it becomes memory resident. This means that the first time you run
> > "bitbake X", the server loads into memory, then subsequent BitBake 
> > commands would just connect to the server and do things. We'd add 
> > in some kind of timeout of say 15 minutes so that it would 
> > gracefully exit.
> > 
> > The reason for doing this is simple, it would allow commands to be 
> > much more responsive rather than having the cache/configuration 
> > loading each time which is where our current overhead is. Obviously 
> > it would detect changes to things like MACHINE setting, local.conf 
> > and re-parse as normal in those cases. The intent would be to speed 
> > up the interaction with the system so you don't have the annoying 
> > delays/lag.
> 
> How will a bitbake command know which server to connect to in case 
> of multiple concurrent builds of different products on the same 
> computer? Or do you intend for one server to keep track of all builds?

There would continue to be one server per build. I tried to keep away
from specifics of the exact implementation since the answer right now is
"don't know". I do have ideas, for example we may do this through some
kind of file in the build directory like the bitbake.lock file and/or
some kind of variable behaving like DISPLAY. I don't really want to
reinvent the wheel though and am open to other ideas. Dbus falls down
with the "remote" part of what we want to do since its typically only
been used locally and whilst people had ideas about remote parts for it,
I don't think they were ever developed extensively.

> > These changes should also be in keeping with the expanded UI work 
> > and options such as WebHob and allowing remote use of multiple UIs
> > connected to servers.
> 
> How should a remote UI know which server to connect to (if there 
> are multiple ones)?

Right now there are commandline options to bitbake for this. This may
become some kind of DISPLAY equivalent environment variable, not sure
yet.

Cheers,

Richard



