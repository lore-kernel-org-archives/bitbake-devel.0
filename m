Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5C6406086F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 21:58:34 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w6PLwX8q013394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 25 Jul 2018 22:58:34 +0100
Message-ID: <18ef0e1f0af7576bbdc5841c8eaa064bc865e0ff.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Hoosier <matt.hoosier@gmail.com>, yocto@yoctoproject.org
Date: Wed, 25 Jul 2018 22:58:33 +0100
In-Reply-To: <CAJgxT3-Jrr2baQz8Y6c_VzNf0Jn6qSEfgNbDYu7xGN4g1PRT=A@mail.gmail.com>
References: <CAJgxT3_QyunmpzGW69j27sR_BFvvhisQVtG+-uGnMxhsO8mCLg@mail.gmail.com>
	<CAJgxT3-Jrr2baQz8Y6c_VzNf0Jn6qSEfgNbDYu7xGN4g1PRT=A@mail.gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] Ordering of anonymous Python functions and task signature calculations
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
X-List-Received-Date: Wed, 25 Jul 2018 21:58:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-07-25 at 08:47 -0500, Matt Hoosier wrote:
> Quite a while ago I wrote the following message:
> On Tue, Jan 24, 2017 at 11:55 AM Matt Hoosier <matt.hoosier@gmail.com
> > wrote:
> > In order to support a use-case that embeds information about the
> > Git revision of Yocto itself that was used to make a build, I would
> > like to run some arbitrary Python code and dump the results (Git
> > SHA1's, tag names, etc) into a Bitbake variable.
> > 
> > The idea is that the variable would get consumed in a do_install()
> > task to populate some cookie-crumb file in the package payload.
> > 
> > Something like:
> > 
> >   DEPENDS = "git-native"
> > 
> >   python () {
> >     # This pseudocode isn't strictly functional for invoking Git,
> > but you get the idea
> >     d.setVar('GIT_INFO', subprocess.Popen(['git', 'rev-list',
> > ...]).communicate().stdout)
> >   }
> > 
> >   do_install () {
> >     install -d ${D}/etc
> >     echo "${GIT_INFO}" > ${D}/etc/git-info.txt
> >   }
> > 
> > This all works on a fresh run, but Bitbake appears not to be
> > evaluating the anonymous Python function on each execution. This
> > leads it to have out-of-date information about the Git working copy
> > when global state changes but happens not to impact the particular
> > recipe holding this logic.
> > 
> > 
> 
> The replies given at the time were very helpful in letting me
> accomplish my immediate goals, but I never really did get to the
> bottom of the real question:
>  
> > Is there any trick available to cause the Python function to
> > execute (and hence update the value of ${GIT_INFO} each Bitbake
> > execution so that the up-to-the-moment contents of it filter into
> > the calculation of the signature for do_install()? Or am I just
> > trying a wrong-headed approach and doing something illegitimate? 
> > 
> 
> Some build systems I know of [1] that are based on hashes rather than
> timestamps have a way that you can inform the task execution engine
> to always poison the inputs to a certain task's up-to-dateness check.
> Is there anything in Bitbake that would allow a declaration to force
> such-and-such variable in a recipe always to be re-evaluated:
> 
>   EXTERNALLY_INFLUENCED_VARIABLE = "${@int(random.random() * 10)}"
>   do_install[vardepsalwaysdirty] = " EXTERNALLY_INFLUENCED_VARIABLE "
> 
>   do_install() {
>     echo '${ EXTERNALLY_INFLUENCED_VARIABLE }' > ${D}/etc/stuff.txt
>   }
> 
> Don't read too much into the example calling random() here. That's
> not really what I want to do; the point is just that the variable's
> value (though deterministic) isn't computed strictly from Bitbake
> metadata. So I'm searching for a way to get the value of
> EXTERNALLY_INFLUENCED_VARIABLE to be re-computed each time Bitbake
> starts. If the computed value ends up matching what was seen on the
> last execution, then any dependent tasks wouldn't need re-run.
> 
> Any ideas?
> 
> [1] I'm thinking particularly of Waf's hash-based task graph, which
> supports annotations that can be used to always cause a task to be
> re-run even if all the inputs feeding into it appear up-to-date.

From a bitbake perspective there are two things you need to ensure
here, that the recipe gets reparsed at every execution and that the
task dependency exists. You have the dependency above and that is the
easier piece to fix.

If the recipe is reparsed, the anon python reruns and the task hash
recalculated.

If a recipe sets BB_DONT_CACHE, it will be reparsed upon each run and
the hashes will dynamically change as you want. BB_SRCREV_POLICY !=
"cache" uses that behind the scenes so that it can dynamically update
srcrevs.

Hope that helps...

Cheers,

Richard



