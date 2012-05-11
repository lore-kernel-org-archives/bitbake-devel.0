Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SSluB-0006o4-LJ for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 11:13:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4B931G6002732;
	Fri, 11 May 2012 10:03:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18512-04; Fri, 11 May 2012 10:02:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4B92pKj002724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2012 10:02:53 +0100
Message-ID: <1336726969.2494.182.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: GOPIKRISHNAN S <gopikrishnans@pec.edu>
Date: Fri, 11 May 2012 10:02:49 +0100
In-Reply-To: <CAOkC3RZ_mRLa8pmPEJKx-Qx=EfLN-Y8Ffsuchm_bAZ9gLGdpSQ@mail.gmail.com>
References: <CAOkC3RZ_mRLa8pmPEJKx-Qx=EfLN-Y8Ffsuchm_bAZ9gLGdpSQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: QorIQ_SDK-20110709-systembuilder
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
X-List-Received-Date: Fri, 11 May 2012 09:13:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-05-11 at 12:16 +0530, GOPIKRISHNAN S wrote:
>        I am n newbie working on QorIQ_SDK-20110709-systembuilder +
> Patches_V1_03_20110929;
>
>     * I have installed clamav using 
>      # echo "PROJECT_EXTRA_PKGS += \clamav"\"
> > /mycollection/recipies/images/amend.inc
>     Its installed. When I tried installing dpkg using same procedure;
> I got error message as below
>     # echo "PROJECT_EXTRA_PKGS += \dpkg"\"
> > /mycollection/recipies/images/amend.inc
> 
> gopi@gopi-desktop:/media/325GB_Drive/fs_dev/p2020_20110709$ bitbake
> devel-image
> NOTE: Handling BitBake files: | (0386/0386) [100 %]
> Parsing of 386 .bb files complete (380 cached, 6 parsed). 515 targets,
> 1 skipped, 0 masked, 0 errors.
> ERROR:
> '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/devel-image.bb']' RDEPENDS/RRECOMMENDS or otherwise requires the runtime entity 'dpkg' but it wasn't found in any PACKAGE or RPROVIDES variables
> ERROR: Required build target 'devel-image' has no buildable providers.
> Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
> NOTE: Resolving any missing task queue dependencies
> ERROR:
> '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/devel-image.bb']' RDEPENDS/RRECOMMENDS or otherwise requires the runtime entity 'dpkg' but it wasn't found in any PACKAGE or RPROVIDES variables
> Unknown Event: <bb.event.NoProvider instance at 0x9e0ecec>
> NOTE: Runtime target 'dpkg' is unbuildable, removing...
> Missing or unbuildable dependency chain was: ['dpkg']
> ERROR: Required build target 'devel-image' has no buildable providers.
> Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
> Command execution failed: Traceback (most recent call last):
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.py", line 88, in runAsyncCommand
>     commandmethod(self.cmds_async, self, options)
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.py", line 174, in buildTargets
>     command.cooker.buildTargets(pkgs_to_build, task)
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/cooker.py", line 784, in buildTargets
>     taskdata.add_unresolved(localdata, self.status)
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py", line 562, in add_unresolved
>     self.remove_runtarget(self.getrun_id(target))
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py", line 535, in remove_runtarget
>     self.fail_fnid(fnid, missing_list)
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py", line 490, in fail_fnid
>     self.remove_buildtarget(target, missing_list)
>   File
> "/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py", line 519, in remove_buildtarget
>     raise bb.providers.NoProvider
> NoProvider
>
> Where I should provide the configurations/specification for source...
> 
I don't think here is an appropriate place for this since this is an
issue with your metadata, not bitbake itself. I'd suggest taking this
issue up with whoever is providing your metadata.

Looking at the log, this is an older version of bitbake and it doesn't
look like openembedded-core. The error message is showing nothing
providing "dpkg", yet something is depending upon it. You therefore
either need to provide dpkg or remove the dependency.

Cheers,

Richard


> 
> 
> 
> Reg,
> Gopi Krishnan S
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




