Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qm77y-0005Pu-FB for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 18:38:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RGWLS3031364;
	Wed, 27 Jul 2011 17:32:21 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30946-07; Wed, 27 Jul 2011 17:32:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6RGWCJ0031358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jul 2011 17:32:12 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
Date: Wed, 27 Jul 2011 17:32:11 +0100
Message-ID: <1311784331.2344.406.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 0/3] Tracking parsed configuration files
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
X-List-Received-Date: Wed, 27 Jul 2011 16:38:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-26 at 21:46 -0700, Joshua Lock wrote:
> All,
> 
> This series attempts to address Yocto bug 1246: "Configuration changes could
> be saved to a file the cooker isn't using".
> 
> It's an ugly series and the issue will only present itself if users run the
> UI trough alternative ways. My main issue is that we can't easily track all
> loaded conf files at parseConfigurationFiles time so it feels a little
> brittle.
> 
> Thoughts? Comments?

Likely bitbake should be maintaining a list of files the given parsing
process has included up to a given point. I believe we already have
something along those lines and might just want to expose it...

Cheers,

Richard



