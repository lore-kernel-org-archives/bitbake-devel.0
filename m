Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qm6Xm-0004ko-Lo for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 18:01:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RFutJf031111;
	Wed, 27 Jul 2011 16:56:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30554-10; Wed, 27 Jul 2011 16:56:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RFukW4031102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jul 2011 16:56:46 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
Date: Wed, 27 Jul 2011 16:56:35 +0100
Message-ID: <1311782195.2344.405.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Some error message improvements
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
X-List-Received-Date: Wed, 27 Jul 2011 16:01:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-07-25 at 14:54 +0100, Paul Eggleton wrote:
> These changes add some more information to unavailable PREFERRED_VERSION
> and "nothing PROVIDES" error output for skipped recipes. I also found and
> fixed one bug in taskdata.py in the process.
> 
> The changes (against poky, apply cleanly against bitbake with -p2) are
> available in the git repository at:
>   git://git.pokylinux.org/poky-contrib paule/error-messages
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/error-messages

Merged to master, thanks.

Richard



