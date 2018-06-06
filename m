Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 57E8D77DCD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 10:19:13 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w56AJCU0020581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 6 Jun 2018 11:19:13 +0100
Message-ID: <03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Hoosier <matt.hoosier@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 06 Jun 2018 11:19:12 +0100
In-Reply-To: <20180525134537.27659-1-matt.hoosier@gmail.com>
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 06 Jun 2018 10:19:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-05-25 at 08:45 -0500, Matt Hoosier wrote:
> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
> 
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
> 
> [YOCTO #12739]
> 
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 84
> +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 8 deletions(-)

I hate to say this but we saw another failure from this :(

https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds/1099/steps/Running%20oe-selftest/logs/stdio

(the second one, grep for submodule deinit)

This was running on the centos 7 worker so I suspect older git versions
don't have the options you're using.

Cheers,

Richard



