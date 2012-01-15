Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RmN77-0008CS-00 for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:15:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0FA7Nuh007188;
	Sun, 15 Jan 2012 10:07:23 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05311-10; Sun, 15 Jan 2012 10:07:14 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0FA7B8f007159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jan 2012 10:07:13 GMT
Message-ID: <1326622036.18815.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Sun, 15 Jan 2012 10:07:16 +0000
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/8] Error message improvements
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
X-List-Received-Date: Sun, 15 Jan 2012 10:15:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-01-13 at 17:01 +0000, Paul Eggleton wrote:
> A number of fixes to improve the readability of error messages,
> primarily for fetch errors, but will improve error output in other
> situations as well.
> 
> (This supersedes the set of patches I sent a couple of days ago.)
> 
> The changes (against Poky, but apply cleanly with -p2 against bitbake
> master) are available in the git repository at: 
>   git://git.yoctoproject.org/poky-contrib paule/errorhandling
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/errorhandling
> 
> Paul Eggleton (8):
>   bitbake/knotty: don't count errors as warnings in summary
>   bitbake/fetch2: improve error formatting for fetcher errors
>   bitbake/runqueue: avoid "failed" in task summary if nothing did
>   bitbake/fetch2: correctly decode exit signal/status
>   bitbake/knotty: avoid printing full task log when error already
>     printed
>   bitbake/fetch2: reduce output for fetch failures
>   bitbake/cooker: avoid printing stack trace for -b match error
>   bitbake/knotty: print task failure summary

Merged to master, thanks. Some good improvements in there.

Cheers,

Richard



