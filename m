Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkfrQ-0005dx-1G for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:51:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0AHiGK0012430;
	Tue, 10 Jan 2012 17:44:16 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11885-06; Tue, 10 Jan 2012 17:44:10 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0AHi8FL012423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jan 2012 17:44:09 GMT
Message-ID: <1326217450.23315.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Tue, 10 Jan 2012 17:44:10 +0000
In-Reply-To: <cover.1326023910.git.paul.eggleton@linux.intel.com>
References: <cover.1326023910.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] bitbake-layers: flatten improvements
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
X-List-Received-Date: Tue, 10 Jan 2012 17:51:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-01-08 at 12:06 +0000, Paul Eggleton wrote:
> A few patches improving the "flatten" subcommand in bitbake-layers,
> prompted by Yocto bug #1654, to allow only flattening some of the
> configured layers as well as warn when recipes/bbappends are outside
> the new flattened layer's paths. I'm hoping to be able to improve it
> further in future to be able to automatically put files in the
> correct place but this will have to wait until the next development
> cycle.
> 
> The patches (against Poky, but which apply cleanly against bitbake
> master with -p2) are available in the git repository at:
>   git://git.yoctoproject.org/poky-contrib paule/bitbake-layers-fix4
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix4
> 
> Paul Eggleton (3):
>   bitbake-layers: flatten: allow specifying layers to flatten
>   bitbake-layers: flatten: warn the user if output structure is
>     incorrect
>   bitbake-layers: close files in apply_append()

Merged to master, thanks.

Richard



