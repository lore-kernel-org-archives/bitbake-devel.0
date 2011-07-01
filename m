Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QcgGS-0000bh-31 for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 18:08:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61G4XK1012535;
	Fri, 1 Jul 2011 17:04:33 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12248-07; Fri,  1 Jul 2011 17:04:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61G4O3h012529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2011 17:04:25 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Date: Fri, 01 Jul 2011 17:04:03 +0100
Message-ID: <1309536243.20015.527.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/10] Hob - BitBake GUI
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
X-List-Received-Date: Fri, 01 Jul 2011 16:08:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-06-30 at 23:02 -0700, Joshua Lock wrote:
> All,
> 
> This series are the current state of the image creator project I have been
> working on for the past few months.
> It's by no means perfect but I'd love to get some review and preferably move
> development into master, rather than a less public branch.
> 
> The first 7 patches are changes to BitBake to be used by the GUI whilst the
> final patch is a squashed patch of my image creator development tree[1].
> 
> Of course, before sending this pull request I ran some final tests and
> encountered a significant problem with the implementation approach.
> Images are built by first using the buildTargets command to build all of the
> target dependencies then creating a recipe file and using the buildFile
> command to handle the build.
> The problem is that if you have a clean build directory, perfectly reasonable
> with such a tool, the buildFile command does not handle the native
> dependencies added by the image class.
> 
> The alternative I have is to save the image files somewhere within BBPATH,
> and perhaps suggest the user create a "workspace" layer, and build them with
> buildTargets. I didn't do this because I'd rather not pollute the users file
> system without good cause. It may be the only tenable approach though.
> 
> Any suggestions here?
> 
> Regards,
> Joshua
> 
> 1. https://github.com/incandescant/bitbake/commits/hob-full
> 
> The following changes since commit 5d41720d1550c04aac76275614ca15110c1c7f52:
> 
>   Update version to 1.13.2 (2011-06-28 15:27:14 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (8):
>   command|cooker: allow generating targets tree for specified pkgs
>   cooker: add generic method to locate configuration files
>   command|cooker|event: add findConfigFilePath command
>   cooker|command|event: add new command findFilesMatchingInDir
>   bitbake: add -R option for loading configuration files after
>     bitbake.conf
>   cooker: switch to new universe target rather than world
>   cooker: remove code duplication in non trivial functions
>   hob: re-designed interaction and implementation
> 
> Lianhao Lu (1):
>   ui/hob: Fixed the "build again" hang.
> 
> Liping Ke (1):
>   bitbake: Make bitbake server type configurable.

I merged in the first 9 of these as they looked ok. I've not had a
chance to look through the hob patch yet though.

Cheers,

Richard



