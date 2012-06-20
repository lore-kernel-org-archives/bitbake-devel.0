Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShGfR-0006Yb-0L for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 10:53:38 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5K8ghpU003139;
	Wed, 20 Jun 2012 09:42:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01637-10; Wed, 20 Jun 2012 09:42:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5K8gZlX003133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 09:42:36 +0100
Message-ID: <1340181757.1640.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Wed, 20 Jun 2012 09:42:37 +0100
In-Reply-To: <4FE065F9.6010300@windriver.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<4FE065F9.6010300@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Signature-based rebuild improvements
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
X-List-Received-Date: Wed, 20 Jun 2012 08:53:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-06-19 at 06:43 -0500, Jason Wessel wrote:
> On 06/18/2012 10:45 AM, Paul Eggleton wrote:
> > The following changes (against poky, but apply cleanly with -p2 against
> > bitbake master) are available in the git repository at:
> > 
> >   git://git.yoctoproject.org/poky-contrib paule/bb-forcebuild
> >   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-forcebuild
> > 
> > Paul Eggleton (2):
> >   bitbake: ensure -f causes dependent tasks to be re-run
> >   bitbake: add -C option to invalidate a task and rebuild the target
> > 
> >  bitbake/bin/bitbake        |    3 +++
> >  bitbake/lib/bb/build.py    |   18 ++++++++++++++++++
> >  bitbake/lib/bb/cooker.py   |    6 +++---
> >  bitbake/lib/bb/runqueue.py |   28 ++++++++++++++++++++++------
> >  bitbake/lib/bb/siggen.py   |   35 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 81 insertions(+), 9 deletions(-)
> 
> While the use cases described in the defect work, there is a new side
> effect.  The sstate dir starts to fill up with new sums for the what
> ever package you compile.  Perhaps this is some kind of trade off we
> have to live with, but I do thing it is worth discussing.
>
> I start with a fully populated sstate.  I didn't make any code changes
> at all to any package, I just wanted to see the compile log from acl
> in this case.
>
>     bitbake -f -c compile acl
>     bitbake acl
>
> The sstate sum is completely different due to the hash injection, but
> the code compiled for everything is the same.  There is probably no
> easy, cheap (as in cpu/wall time) way to have the best of both worlds.

I think this fix is good and solves various immediate problems. Thinking
forward to the future, if you can know the state of a code base as a
checksum, you could inject that as the "taint" and then you would be
able to match two existing matching compiles. Having everything under
git control for example would be a cheap way to do this, if you can
gurantee that all changes were encapsulated.

For the menuconfig example, I did wonder about checksumming the new
defconfig and injecting that for example.

What I like about the architecture of the taint implementation is that
it doesn't preclude any of the above so its something we can think about
and work towards if we can come up with a good enough plan :)

Cheers,

Richard



