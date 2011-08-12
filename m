Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qruzw-0000Py-DP for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:54:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CGngNg013773;
	Fri, 12 Aug 2011 17:49:42 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12915-10; Fri, 12 Aug 2011 17:49:38 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CGnTcd013766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2011 17:49:33 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
Date: Fri, 12 Aug 2011 17:48:49 +0100
Message-ID: <1313167729.14274.514.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/8] Various hob related patches
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
X-List-Received-Date: Fri, 12 Aug 2011 16:54:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-08-11 at 15:57 -0700, Joshua Lock wrote:
> This pull request includes the series I submitted yesterday as well as some
> additional bug fixes.
> 
> Regards,
> Joshua
> 
> The following changes since commit 705d14d1e1108e0544c7eab827f1242f0839add9:
> 
>   bb/cooker: only emit ConfigFilePathFound for files which were parsed (2011-08-10 13:38:11 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (8):
>   bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
>   bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
>   bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
>   bb/cache: rename confusing variable
>   bb/command|cooker: refactor the reparseFiles logic
>   bb/ui/crumbs/hobeventhandler: adapt to reset -> reparse change
>   bb/ui/crumbs/configurator: introduce writeConfFile method for all
>     writes
>   lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse

Merged to master thanks.

Richard



