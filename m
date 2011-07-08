Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QfEA2-0003fB-2c for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 18:44:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p68GeHGT021944;
	Fri, 8 Jul 2011 17:40:17 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21380-10; Fri,  8 Jul 2011 17:40:13 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p68GeAf5021938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jul 2011 17:40:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
In-Reply-To: <cover.1308034271.git.lianhao.lu@intel.com>
References: <cover.1308034271.git.lianhao.lu@intel.com>
Date: Fri, 08 Jul 2011 17:39:31 +0100
Message-ID: <1310143171.20015.908.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 0/1] process cmd line parsing result by individual UI
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
X-List-Received-Date: Fri, 08 Jul 2011 16:44:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-06-14 at 15:12 +0800, Lianhao Lu wrote:
> This patch tries to allow the individual UI to decide whether it should display the cmd line parsing result.
> 
> The command "getCmdLineAction" now returns either None or a dictionary with the key of {'action', 'msg'}. 
> 
> If it returns None, it means no command line action parameters are provided. 
> 
> If it returns a dictionary, the entry of the key 'action' stores the list which should be used with server.runCommand(); the entry of the key 'msg' stores the error message from the cmd line parsing result (in which case the 'action' entry is None). 
> 
> It is up to the individual UI to decide whether and how to display those parsing result.
> 
> Please review the following changes for suitability for inclusion. If you have
> any objections or suggestions for improvement, please respond to the patches. If
> you agree with the changes, please provide your Acked-by.
> 
> The following changes since commit a27fbe5e25a5aee956d2a43a2e2bf671c6d985f2:
>   Scott Rifenbark (1):
>         documentation/yocto-project-qs/yocto-project-qs.xml: removed 5.0 references
> 
> are available in the git repository at:
> 
>   git://git.pokylinux.org/poky-contrib llu/cmdLineParsing
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/cmdLineParsing

Merged to master, thanks.

In future please put the above info in the commit message instead of the
pull request though! :)

Cheers,

Richard



