Return-Path: <fred@rogue-research.com>
X-Greylist: delayed 338 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 04 Aug 2017 14:06:01 UTC
Received: from mail.rogue-research.com (mail.rogue-research.com [68.67.54.10])
	by mail.openembedded.org (Postfix) with ESMTP id 96A9F71A18
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Aug 2017 14:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.rogue-research.com (Postfix) with ESMTP id 0FB8D2445219;
	Fri,  4 Aug 2017 10:00:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mydomain = rogue-research.com
Received: from mail.rogue-research.com ([127.0.0.1])
	by localhost (kingu.rogue-research.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id buO5P6M14UYJ; Fri,  4 Aug 2017 10:00:24 -0400 (EDT)
Received: from [10.29.19.197] (unknown [10.29.19.197])
	by mail.rogue-research.com (Postfix) with ESMTPSA id 4EDE3244520B;
	Fri,  4 Aug 2017 10:00:24 -0400 (EDT)
To: bitbake-devel@lists.openembedded.org, poky@yoctoproject.org
From: Fred Lamer <fred@rogue-research.com>
Message-ID: <e380fe57-2ad0-787d-1ea0-b02411480121@rogue-research.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.2.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 01 Sep 2017 15:25:32 +0000
Subject: CVS support on Yocto 2.3 (Pyro) and bitbake 1.34
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
Date: Fri, 04 Aug 2017 14:06:01 -0000
X-Original-Date: Fri, 4 Aug 2017 10:00:23 -0400
X-List-Received-Date: Fri, 04 Aug 2017 14:06:01 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hi,

I'm trying to bring a project from Yocto 2.1 (Krogoth) to 2.3 (Pyro). I 
have a problem with one of my recipe that tries to fetch from a cvs 
repository. The recipe work perfectly on Yocto 2.1 (using bitbake 1.30), 
but not on Yocto 2.3 (using bitbake 1.34).

It seems like 'cvs' is not installed on the host system? I get the 
following error:

********************************************************************************************************************************************************

Fetcher failure: Fetch command export 
PATH="/media/yocto/yocto-vetrobot-next.git/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/media/yocto/yocto-vetrobot-next.git/poky/scripts:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot-native/usr/bin/x86_64-poky-linux:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot/usr/bin/crossscripts:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot-native/usr/sbin:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot-native/usr/bin:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot-native/sbin:/media/yocto/yocto-vetrobot-next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-sysroot-native/bin:/media/yocto/yocto-vetrobot-next.git/poky/bitbake/bin:/media/yocto/yocto-vetrobot-next.git/build/tmp/hosttools"; 
export HOME="/home/fred"; /usr/bin/env cvs 
'-d:pserver:anonymous@cvs.schmorp.de:/schmorpforge' co -r rel-4_15 libev 
failed with exit code 127, output:

/usr/bin/env: ‘cvs’: No such file or directory

********************************************************************************************************************************************************

So, it seems like cvs is either not installed or not in the PATH. Anyone 
ever had this problem?

Note that this if I copy/paste this command outside of the bitbake 
environnement:

************************************************************************************************

/usr/bin/env cvs '-d:pserver:anonymous@cvs.schmorp.de:/schmorpforge' co 
-r rel-4_15 libev

************************************************************************************************

it works perfectly (so it's not a fetch error from the repo).

Thanks

Fred


