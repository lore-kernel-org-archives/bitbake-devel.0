Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjzEe-000132-MF for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jun 2012 22:53:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKgKfw019524
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:42:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17113-08 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:42:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKgD65019518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:42:14 +0100
Message-ID: <1340829736.23146.88.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jun 2012 21:42:16 +0100
In-Reply-To: <1340791594.23146.15.camel@ted>
References: <1340791594.23146.15.camel@ted>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Re: [PATCH] runqueue: Reimplement recrdepends so it works more correctly
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
X-List-Received-Date: Wed, 27 Jun 2012 20:53:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-06-27 at 11:06 +0100, Richard Purdie wrote:
> Currently, recrdepends is extremely greedy. For example:
> 
> do_foo[rdepends] = "somedep:sometask"
> addtask foo
> 
> which adds foo with *no* dependencies, will suddenly start appearing
> as a dependency in every task which uses recrdepends. So far this has
> been mildy annoying but we now have use cases where this makes no sense
> at all.
> 
> This reworks the recrdepends code to avoid this problem. To do this we
> can no longer collapse things into lists just based on file ID. The problem
> is this code is extremely performance sensitive. The "preparing runqueue"
> phase spends a lot of time in these recursive dependency calculations so any
> change here could negatively impact the user experience.
> 
> As such, this code has been carefully tested on convoluted dependency trees
> with operations like "time bitbake world -g". The net result of this change
> and the preceding changes combined is a net speed up of these operations in
> all cases measured.
> 
> Tests were made comparing "bitbake world -g" task-depends.dot before and after
> this patch. There *are* differences, particularly that a lot of *-native
> dependencies now disappear from recrdepends tasks like do_build. Also, -nativesdk
> do_build dependencies on -native recipes are no longer present. All removed
> dependencies appear to be sensible improvements to the system. The "rdepends"
> cross contamination issue above is also fixed.
> 
> As a result of this, people are going to notice significant falls in the numbers
> of tasks their standard builds will run, mainly from the removal of many -native
> "noexec" tasks. All the signs are this is a good thing.

I'm not entirely sure what I was thinking earlier on but the
disappearance of these tasks, whilst "nice" since we don't care about
them is incorrect and they should not be disappearing. There is a chunk
of dependencies we're ignoring and there could be something we do care
about getting lost. I'm working on a v2 of this patch.

Cheers,

Richard



