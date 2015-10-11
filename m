Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3075C65C8A
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 07:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B7CPmJ013202; Sun, 11 Oct 2015 08:12:25 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HRSTRu0u1Cvh; Sun, 11 Oct 2015 08:12:25 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B7C8NT013195
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 08:12:22 +0100
Message-ID: <1444547527.14364.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Elliot Smith <elliot.smith@intel.com>
Date: Sun, 11 Oct 2015 08:12:07 +0100
In-Reply-To: <1444383523-23550-1-git-send-email-elliot.smith@intel.com>
References: <1444383523-23550-1-git-send-email-elliot.smith@intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: update meta-yocto to jethro and drop dizzy
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
X-List-Received-Date: Sun, 11 Oct 2015 07:12:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-10-09 at 10:38 +0100, Elliot Smith wrote:
> From: brian avery <avery.brian@gmail.com>
> 
> Toaster only supports building 2 branches back. This
> updates the conf file for meta-yocto to support
> master, jethro, and fido.
> 
> Signed-off-by: brian avery <avery.brian@gmail.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  meta-yocto/conf/toasterconf.json | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

This should actually go to the poky list and say something like
"toasterconf:" in the subject rather than "toaster:" however I've sorted
this out in this case.

Cheers,

Richard


