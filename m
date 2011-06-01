Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QRjWO-0001eq-6f for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 13:23:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p51BK6LW003411;
	Wed, 1 Jun 2011 12:20:06 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03221-02; Wed,  1 Jun 2011 12:20:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p51BJt0T003392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2011 12:19:58 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1306922503.git.paul.eggleton@linux.intel.com>
References: <cover.1306922503.git.paul.eggleton@linux.intel.com>
Date: Wed, 01 Jun 2011 12:19:37 +0100
Message-ID: <1306927177.27470.419.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] bitbake: use layer priority when applying bbappends v2
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
X-List-Received-Date: Wed, 01 Jun 2011 11:23:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-06-01 at 11:09 +0100, Paul Eggleton wrote:
> Since v1, fixed missing "self." on one reference to calc_bbfile_priorities.
> 
> ---------
> 
> The following changes since commit 52295fa3deef3b0374b99829626d524cefae6001:
> 
>   Improve handling of 'all' architecture recipes and their interaction with sstate (2011-05-31 13:07:00 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib paule/bbfile-sort
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bbfile-sort
> 
> Paul Eggleton (1):
>   bitbake: use layer priority when applying bbappends

Merged to master, thanks.

Richard



