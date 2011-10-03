Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RAgoV-0001gX-9x for bitbake-devel@lists.openembedded.org;
	Mon, 03 Oct 2011 13:36:03 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p93BauNi010401; Mon, 3 Oct 2011 12:36:56 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LH16XPl+5mlN; Mon,  3 Oct 2011 12:36:56 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p93BaoMJ010395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Oct 2011 12:36:52 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cliff Brake <cliff.brake@gmail.com>
Date: Mon, 03 Oct 2011 12:30:21 +0100
In-Reply-To: <CAOd_LFywLRNDRAbWLJvV1Z1qE4Swot0SQT2RpNz-CBWPc9Jdmg@mail.gmail.com>
References: <CAOd_LFywLRNDRAbWLJvV1Z1qE4Swot0SQT2RpNz-CBWPc9Jdmg@mail.gmail.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1317641429.4454.74.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: fetcher hangs
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
X-List-Received-Date: Mon, 03 Oct 2011 11:36:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-10-03 at 05:54 -0400, Cliff Brake wrote:
> One thing I've been noticing is that bitbake seems to hang when its
> trying to fetch a dead URI:
> 
> NOTE: package linux-3.0-r4: task do_fetch: Started
> WARNING: Fetcher failure for URL: 'None'. Fetch command export
> HOME="/home/cbrake"; export SSH_AGENT_PID="2994"; export
> SSH_AUTH_SOCK="/tmp/keyring-ptLxSd/ssh"; export
> GIT_CONFIG="/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/etc/gitconfig";
> export PATH="/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/bin/armv5te-angstrom-linux-gnueabi:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/cm-x270/usr/bin/crossscripts:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/sbin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/bin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/sbin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux//bin:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/bin/armv5te-angstrom-linux-gnueabi:/scratch/pp/pp-oe-2011/build/tmp-angstrom_2010_x-eglibc/sysroots/x86_64-linux/usr/bin:/scratch/pp/pp-oe-2011/sources/openembedded-core/scripts:/scratch/pp/pp-oe-2011/sources/bitbake/bin:/home/cbrake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/scratch/pp/pp-oe-2011/sources/o!
 pen
>  embedded-core/scripts";
> /usr/bin/env wget -t 5 -q --passive-ftp --no-check-certificate -P
> /scratch/pp/pp-oe-2011/sources/downloads
> 'http://kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.bz2' failed
> with signal 8, output:
> (bitbake hangs here)
> 
> Is this expected behavior?

No. I tried an experiment here where I added a linux "3.0" headers
recipe and tried fetching it. It rapidly failed and came back to the
console.

What do you have PREMIRORS and MIRRORS set to? Does bitbake -DDD help
show what bitbake is doing? What about the fetch log files for the
recipe in question?

Cheers,

Richard





