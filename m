Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qk0zf-00045x-Eo for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 23:41:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LLbBqK007545;
	Thu, 21 Jul 2011 22:37:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04336-07; Thu, 21 Jul 2011 22:37:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6LLb667007539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jul 2011 22:37:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311275221.git.josh@linux.intel.com>
References: <cover.1311275221.git.josh@linux.intel.com>
Date: Thu, 21 Jul 2011 22:37:03 +0100
Message-ID: <1311284223.2344.88.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 21:41:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-21 at 12:08 -0700, Joshua Lock wrote:
> Here's a copy of Liping's "Remove unused target tree data for Hob" with my
> changes made per my review and my SoB added.
> 
> The following changes since commit 09a9146262d58dfe4a2ea4270026b90ae33f6c91:
> 
>   parse/ConfHandler: Fix multiline variable corruption (2011-07-21 11:08:19 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake lke-speed
>   https://github.com/incandescant/bitbake/tree/lke-speed
> 
> Liping Ke (1):
>   Remove unused target tree data for Hob

Merged to master, thanks.

Richard



