Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QUHsl-0005Ey-MM for bitbake-devel@lists.openembedded.org;
	Wed, 08 Jun 2011 14:29:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p58CPsoR031015
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Jun 2011 13:25:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30459-09 for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jun 2011 13:25:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p58CPlp5031009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Jun 2011 13:25:49 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 08 Jun 2011 13:25:38 +0100
Message-ID: <1307535939.15712.87.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Bitbake Server Cleanup and XMLRPC/None server resurection
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
X-List-Received-Date: Wed, 08 Jun 2011 12:29:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The ongoing issue of the server support in bitbake upstream verses the
copy of bitbake in poky has been a pain point for a while. I've now
committed changes to bring the two back into sync. I've done a variety
of testing but its likely I've missed some combinations of
bitbakes/servers/UIs so I'd like to ask for people to test the cases
they use and check nothing got broken. If it has, please report it so we
can get it fixed.

It is likely there is some cleanup than can be made on top of these
patches for now I've concentrated on bring things into sync trying to
ensure everything works.

Cheers,

Richard



