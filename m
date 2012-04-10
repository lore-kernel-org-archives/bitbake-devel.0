Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHk4G-0004Bs-Nr for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 01:01:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMqQ2q001480;
	Tue, 10 Apr 2012 23:52:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00840-10; Tue, 10 Apr 2012 23:52:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMqGk8001474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 23:52:17 +0100
Message-ID: <1334098335.10826.84.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Saul Wold <sgw@linux.intel.com>
Date: Tue, 10 Apr 2012 23:52:15 +0100
In-Reply-To: <1334096411-27965-1-git-send-email-sgw@linux.intel.com>
References: <1334096411-27965-1-git-send-email-sgw@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] ui/crumbs/utils.py: new file for choosing terminals
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
X-List-Received-Date: Tue, 10 Apr 2012 23:01:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-04-10 at 15:20 -0700, Saul Wold wrote:
> Adding this simple version of a terminal selector for use
> hob since it's needed. Moving forward in the 1.3 release
> the existing code in meta/lib/oe/termnial.py will be migrated
> to core bitbake code and this will use that code.
> 
> Signed-off-by: Saul Wold <sgw@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/utils.py |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>  create mode 100644 lib/bb/ui/crumbs/utils.py
> 
> diff --git a/lib/bb/ui/crumbs/utils.py b/lib/bb/ui/crumbs/utils.py
> new file mode 100644
> index 0000000..6526c15
> --- /dev/null
> +++ b/lib/bb/ui/crumbs/utils.py
> @@ -0,0 +1,33 @@
> +#
> +# BitBake UI Utils 
> +#
> +# Copyright (C) 2012 Intel Corporation
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +# This utility method looks for xterm or vte and return the 
> +# frist to exist, currently we are keeping this simple, but 
> +# we will likely move the oe.terminal implementation into 
> +# bitbake which will allow more flexibility.
> +
> +import os
> +
> +def which_terminal():
> +    term = bb.utils.which(os.environ["PATH"], "xterm")
> +    if not term:
> +        term = bb.utils.which(os.environ["PATH"], "vte")
> +        return term + " -c " 
> +    else:
> +        return term + " -e "

What happens when this tries to execute None + "-c"?

You want something like
 
    term = bb.utils.which(os.environ["PATH"], "xterm")
    if term:
        return term + " -e"
    term = bb.utils.which(os.environ["PATH"], "vte")
    if term:
        return term + " -c " 
    return None

Cheers,

Richard



