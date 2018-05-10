Return-Path: <bela@becker.rocks>
X-Greylist: delayed 345 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 10 May 2018 19:31:20 UTC
Received: from becker.rocks (catv-188-142-200-211.catv.broadband.hu
	[188.142.200.211])
	by mail.openembedded.org (Postfix) with ESMTP id D1F1A75358
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 19:31:20 +0000 (UTC)
Received: from maxion.localnet (catv-89-133-30-81.catv.broadband.hu
	[89.133.30.81]) by becker.rocks (Postfix) with ESMTPSA id D7933E01FF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 21:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=becker.rocks; s=mail;
	t=1525980335; bh=bECRp4115NRchkFrpgDXuquvJn3IvA8iJtoC1KBHAoY=;
	h=From:To:Subject:Date:From;
	b=UJbsmhDH1kmOB1RcDX/78vlJUG27B+Xxi32f3d1NPzVpJCVDP1yLFe5GGQnozNOCF
	Fm+AN0V4MiqJKDzTPlbWUX/RSCK7n7AK+UeVem9zVDAcX6vC9JvrFPtfhQ2NqZfUW5
	aE//dZeBLHMG8x3h66+363s3G15TH1zyV05Kvvdo=
From: Becker =?ISO-8859-1?Q?B=E9la?= <bela@becker.rocks>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 May 2018 21:25:35 +0200
Message-ID: <4772545.pSEQItiHMW@maxion>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 11 May 2018 06:52:15 +0000
Subject: Forcing a task to run depending on the output of a python script?
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
X-List-Received-Date: Thu, 10 May 2018 19:31:21 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

My goal is to have a fancy version string, computed from my meta layer using versions of the `git describe` command, to be stored in the file system, but I can't figure out how I can invalidate the cache for my recipe in order for the do_install task to fire.

Currently, I'm using an anonymous python script instide a .bbclass to set up a variable ( let's call it ${VERSION} ) using git's numerous commands. This is then inherited in a .bb file, that contains a single file for the target, under /etc with my fancy string.

When I run `bitbake -e git-version`, I can see that leaving a commit changes the variable, but the package isn't rebuilt, not until I force it.

So far I have tried:
-setting `PV = ${VERSION}`
-changing the task basehash with `BB_BASEHASH_task-do_install += ${VERSION}`
-adding VERSION to do_install[vardeps]

Is it possible, to have this package be rebuilt when a change occurs, so the images will be rebuilt as well?

