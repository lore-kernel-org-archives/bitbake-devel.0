Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B55F176040
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jun 2018 08:09:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w5F89VnA006840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 15 Jun 2018 09:09:32 +0100
Message-ID: <70dc8d4579b4b6429d7572f2308176d3e52e64b0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ben Levinsky <ben.levinsky@xilinx.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jun 2018 09:09:31 +0100
In-Reply-To: <1529014433-30364-1-git-send-email-ben.levinsky@xilinx.com>
References: <1529014433-30364-1-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] runqemu: Allow the user to specity DTB
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
X-List-Received-Date: Fri, 15 Jun 2018 08:09:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-14 at 15:13 -0700, Ben Levinsky wrote:
> In some cirsumstances the user doesn't want to supply a kernel,
> rootFS
> to QEMU, but only a DTB.
> 
> Allow users to specify dtb for supply via the QB_DTB option
> to QEMU.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
>  scripts/runqemu | 3 +++
>  1 file changed, 3 insertions(+)

The patch looks good but this needs to go to the openembedded-core
mailing list as this script is part of the oe-core repo, not bitbake.

Cheers,

Richard

