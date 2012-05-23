Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8vS-0004oD-8c for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 12:36:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAQ79s011243;
	Wed, 23 May 2012 11:26:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10805-04; Wed, 23 May 2012 11:26:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAPvqN011237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 11:25:58 +0100
Message-ID: <1337768756.8248.55.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 23 May 2012 11:25:56 +0100
In-Reply-To: <cover.1337728949.git.paul.eggleton@linux.intel.com>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Implement file checksums
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
X-List-Received-Date: Wed, 23 May 2012 10:36:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-23 at 00:23 +0100, Paul Eggleton wrote:
> This is 2/3 of the changes required to implement local file checksums;
> the other third is a patch to base.bbclass which will be sent to the
> OE-Core list.
> 
> 
> The following changes (against Poky, but apply cleanly against BitBake
> master with -p2) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/file-checksum-bb
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/file-checksum-bb
> 
> Paul Eggleton (2):
>   bitbake: refactor out codeparser cache into a separate class
>   bitbake: implement checksums for local files in SRC_URI

Merged to master, thanks.

Richard



