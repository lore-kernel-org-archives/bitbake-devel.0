Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qssga-0007Di-4z for bitbake-devel@lists.openembedded.org;
	Mon, 15 Aug 2011 10:38:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8XdCX015119;
	Mon, 15 Aug 2011 09:33:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14922-03; Mon, 15 Aug 2011 09:33:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8XWAB015113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Aug 2011 09:33:33 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1313197700.git.josh@linux.intel.com>
References: <cover.1313197700.git.josh@linux.intel.com>
Date: Mon, 15 Aug 2011 09:33:30 +0100
Message-ID: <1313397210.14274.543.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Switch from recipe-level to package-level data in hob
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
X-List-Received-Date: Mon, 15 Aug 2011 08:38:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 18:10 -0700, Joshua Lock wrote:
> We currently store recipe-level data in the tasklistmodel (include the
> contents of foo recipe) whereas in reality we're likely want to do
> package-level operations, as required by EXTRA_IMAGE_INSTALL.
> 
> This series enables package-level data in the model and optimises a few
> methods to cope with the increased model size.
> 
> Regards,
> Joshua
> 
> The following changes since commit b3ad7acebfad3063c3364f4492f53b25bf53cf81:
> 
>   lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse (2011-08-12 17:48:13 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (5):
>   bb/crumbs/tasklistmodel: filter nativesdk packages out of views
>   bb/ui/crumbs/tasklistmodel: include package level information
>   bb/ui/crumbs/tasklistmodel: optimise find_path_for_item
>   bb/ui/crumbs/tasklistmodel: make package_model_filter a little safer
>   bb/ui/crumbs/tasklistmodel: simplify conditional in include_item

Merged to master, thanks.

Richard



