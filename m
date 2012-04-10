Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHk18-0000zD-9P for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 00:58:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMnBVl001455;
	Tue, 10 Apr 2012 23:49:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01063-07; Tue, 10 Apr 2012 23:49:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMn2GC001449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 23:49:03 +0100
Message-ID: <1334098130.10826.80.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Tue, 10 Apr 2012 23:48:50 +0100
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Changes to ensure Hob can be run on CentOS 6
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
X-List-Received-Date: Tue, 10 Apr 2012 22:58:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-04-05 at 11:29 -0700, Joshua Lock wrote:
> The following series contains changes to ensure Hob can be used on CentOS 6,
> that is Gtk+ 2.18.9 and PyGtk 2.16.0.
> 
> To achieve this I've replaced calls to convenience API which was only introduced
> with Gtk+ 2.22 and lowered the versions of Gtk+ and PyGtk we test for in the
> Hob GUI.
> 
> Tested on CentOS 6.2
> 
> Cheers,
> Joshua
> 
> The following changes since commit d49db15badb77855cef855ee73430fcbc16b6916:
> 
>   Hob: a minor fix on pmake (2012-04-05 18:47:37 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob-centos6
>   https://github.com/incandescant/bitbake/tree/josh/hob-centos6
> 
> Joshua Lock (3):
>   lib/bb/ui/crumbs/persistenttooltip: replace 2.22 API
>   lib/bb/ui/crumbs/hobwidget: replace new API
>   hob: update required versions of (py)gtk et al

Merged to master, thanks.

Richard



