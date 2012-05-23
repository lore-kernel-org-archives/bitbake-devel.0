Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8zK-0004rX-1R for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 12:40:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAU9NM011287;
	Wed, 23 May 2012 11:30:09 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10805-05; Wed, 23 May 2012 11:30:04 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAU2gn011273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 11:30:03 +0100
Message-ID: <1337769001.8248.58.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 23 May 2012 11:30:01 +0100
In-Reply-To: <cover.1337515887.git.liezhi.yang@windriver.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] V4 replace os.system and os.popen with subbprocess module
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
X-List-Received-Date: Wed, 23 May 2012 10:40:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-05-20 at 20:36 +0800, Robert Yang wrote:
> * Changes of V4:
>   Fix use readline() for the return value of bb.process.run(), the
>   return value is already a string, we can't (or don't have to) use
>   readline() for it, the string is what we need.
> 
> * Changes of V3:
>   Use bb.process.run() rather than bb.process.Popen() to replace os.popen()
> 
> * Changes of V2:
> 
>   - Remove the 2>/dev/null since we dont' need it.
>   - Use the wrapped Popen from bb.process, which is simpler than
>     subprocess.Popen(....).
> 
> * Original message of V1:
> Replace os.popen and os.system with subprocess.Popen and
> subprocess.call, since the older functions would fail (more or less) if
> the executed program cannot be found, this would cause potential errors
> since we don't know whether the problem executed well or not.
> 
> For the performance issue, I've done the testing before the patches and
> after with the oe-core layer (also the oe-core have applied the similar
> patches):
> 
> # The sources are on local disk
> 
> 1) Before applied these pacthes to bitbake and similar patches to oe-core:
> $ time bitbake core-image-sato
> real    177m50.723s
> user    436m1.551s
> sys     71m29.588s
> 
> 2) After applied the pathes:
> $ time bitbake core-image-sato
> real    176m26.194s
> user    436m7.931s
> sys     71m1.994s
> 
> After applied these patches, the time has reduced 84 seconds, this is
> very slight, I think that we can assume this is just a deviation, it
> doesn't cause performance problems.
> 
> // Robert
> 
> The following changes since commit b4c8c74a45e386f99344cf9799eb5294ad6c9e3e:
> 
>   hob: update required pygtk to 2.22.0 and gtk+ to 2.20.0 (2012-05-20 09:24:26 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/subprocess
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/subprocess
> 
> Robert Yang (2):
>   replace os.system with subprocess.call
>   replace os.popen with subprocess.Popen

Merged to master, thanks.

Richard



