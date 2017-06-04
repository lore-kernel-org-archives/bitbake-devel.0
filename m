Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 96D327198D
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Jun 2017 14:13:16 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v54EDB6W019446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 4 Jun 2017 15:13:12 +0100
Message-ID: <1496585591.6630.163.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>, Bitbake dev
	Mailing List <bitbake-devel@lists.openembedded.org>
Date: Sun, 04 Jun 2017 15:13:11 +0100
In-Reply-To: <1496018646-92426-2-git-send-email-rebecca.swee.fun.chang@intel.com>
References: <1496018646-92426-1-git-send-email-rebecca.swee.fun.chang@intel.com>
	<1496018646-92426-2-git-send-email-rebecca.swee.fun.chang@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Sun, 04 Jun 2017 15:13:13 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong@intel.com>
Subject: Re: [PATCHv2] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Sun, 04 Jun 2017 14:13:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-05-29 at 08:44 +0800, Chang Rebecca Swee Fun wrote:
> In the original implementation, "bitbake-layers add-layers <layer>"
> succeeded without error checking. This will further introduce
> failures in recipe parsing only when "bitbake" command is executed.
> Adding a meta layer without its dependency layer(s) should failed
> and exit the process gracefully.
> 
> Added extra argument "-f" to force add a layer without checking
> layer dependency.
> 
> [YOCTO #10913]
> 
> Signed-off-by: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong
> @intel.com>
> Signed-off-by: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.c
> om>
> ---
>  bin/bitbake-layers     |  1 +
>  lib/bblayers/action.py | 26 ++++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)

This patch seems to result in this:

https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds/320/steps/Running%20oe-selftest/logs/stdio

Cheers,

Richard

