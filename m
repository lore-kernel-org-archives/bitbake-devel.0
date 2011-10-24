Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RINda-00050C-3f for bitbake-devel@lists.openembedded.org;
	Mon, 24 Oct 2011 18:44:34 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p9OGcYTR031188;
	Mon, 24 Oct 2011 17:38:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30368-09; Mon, 24 Oct 2011 17:38:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p9OGcPfx031182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2011 17:38:26 +0100
Message-ID: <1319474305.26563.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Mon, 24 Oct 2011 17:38:25 +0100
In-Reply-To: <cover.1318352470.git.josh@linux.intel.com>
References: <cover.1318352470.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Improve usability of checksums
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
X-List-Received-Date: Mon, 24 Oct 2011 16:44:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-10-11 at 10:07 -0700, Joshua Lock wrote:
> I'd heard some complaints around the usability of checksums and, having done
> some recipe work recently, must agree with them.
> This series ams to make using checksums less intrusive by:
> 
> a) Removing the requirement that if one type of checksum is defined the other
> must be too.
> b) Reporting all sum mismatches at once
> c) Enabling sums to be defined as a parameter of a SRC_URI
> 
> Regards,
> Joshua
> 
> The following changes since commit dca46cc2e1c75b6add2c4801e2994a4812745f5b:
> 
>   fetch2: Export additional variables to the fetchers (2011-10-05 14:23:16 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake checksum
>   https://github.com/incandescant/bitbake/tree/checksum
> 
> Joshua Lock (2):
>   fetch2: improve usability of checksums
>   fetch2: enable checksum definition as SRC_URI parameter

Merged to master (or will be when I can actually push the changes). 

Cheers,

Richard



