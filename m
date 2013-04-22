Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpurdie@rpsys.net>) id 1UUHpw-0003eS-Tf
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 16:35:23 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3MEHHCe027691; Mon, 22 Apr 2013 15:17:17 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id S8Tez0WMCMhH; Mon, 22 Apr 2013 15:17:17 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3MEHEPD027686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 22 Apr 2013 15:17:15 +0100
Message-ID: <1366640172.23738.12.camel@ted>
From: Richard Purdie <rpurdie@rpsys.net>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 22 Apr 2013 15:16:12 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Mon, 22 Apr 2013 14:35:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've been giving some thought to where BitBake needs to go in the future
in order to deliver for its users. It started life as a commandline
utility and its grown a lot since it was first created. I think there
are some key decisions that need to be taken to ensure its future
growth.

The first proposal is that we should change the BitBake server so it
becomes memory resident. This means that the first time you run "bitbake
X", the server loads into memory, then subsequent BitBake commands would
just connect to the server and do things. We'd add in some kind of
timeout of say 15 minutes so that it would gracefully exit.

The reason for doing this is simple, it would allow commands to be much
more responsive rather than having the cache/configuration loading each
time which is where our current overhead is. Obviously it would detect
changes to things like MACHINE setting, local.conf and re-parse as
normal in those cases. The intent would be to speed up the interaction
with the system so you don't have the annoying delays/lag.

This would then lead into the second proposal which is to add better
support for new commands. This would be along the lines of some of
Chris' work with bb, the bitbake-env script and so on but with the added
advantage of being able to connect to the server for info. It would
allow us to add query commands for things like the available
PACKAGECONFIG options/settings much more easily than the current
infrastructure. There are some issues about whether these would belong
as part of BitBake or OE and we'd need to figure that out.

The third proposal is to do away with the BitBake wrapper script in
OE-Core for pseudo. Doing this within BitBake is going to be hard and
require some rework but ultimately, I think it will be worth it from a
performance perspective and also stops some of the user confusion about
BitBake running twice (two sets of log files and so on).

These changes should also be in keeping with the expanded UI work and
options such as WebHob and allowing remote use of multiple UIs connected
to servers.

Feedback/comments/suggestions etc./ welcome as always.

I've cc'd the OE-Core list but further discussion should be taken to
bitbake-devel.

Cheers,

Richard



