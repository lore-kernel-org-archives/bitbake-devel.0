Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1GMu-0004nU-9X for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 13:04:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1PBuPt7019702;
	Sat, 25 Feb 2012 11:56:25 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19581-02; Sat, 25 Feb 2012 11:56:21 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1PBuF2J019696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Feb 2012 11:56:17 GMT
Message-ID: <1330170976.13788.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Sat, 25 Feb 2012 11:56:16 +0000
In-Reply-To: <cover.1330149082.git.josh@linux.intel.com>
References: <cover.1330149082.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Fix depexp
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
X-List-Received-Date: Sat, 25 Feb 2012 12:04:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-02-24 at 21:52 -0800, Joshua Lock wrote:
> Per the patch and Yocto bug #2027 the recent BitBake patch
> to implement the new Hob UI deleted the file which implements
> thge progress bar used by depexp. The following patch adds
> back that file.
> 
> Cheers,
> Joshua
> 
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=2027
> 
> The following changes since commit c7486a09310fe63b1aa1b7b0bb9450f306b6093b:
> 
>   bitbake/cooker: terminate when errors found in layer configuration (2012-02-24 23:30:16 +0000)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/depexp
>   https://github.com/incandescant/bitbake/tree/josh/depexp
> 
> Joshua Lock (1):
>   crumbs: add back progress implementation for depexp

Merged to master, thanks.

Richard



