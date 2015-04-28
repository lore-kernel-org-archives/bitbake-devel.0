Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2D50872491
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 16:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGp9EB003784; Tue, 28 Apr 2015 17:51:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IvuTYQGnKAc1; Tue, 28 Apr 2015 17:51:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGot5O003769
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Apr 2015 17:51:06 +0100
Message-ID: <1430239855.13022.243.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Katu Txakur <katutxakurra@gmail.com>
Date: Tue, 28 Apr 2015 17:50:55 +0100
In-Reply-To: <CAM1ZcoWg_S6ens4kumJSJzX3fdJio19tw3SUXEPFYpDoR6rAjw@mail.gmail.com>
References: <CAM1ZcoWg_S6ens4kumJSJzX3fdJio19tw3SUXEPFYpDoR6rAjw@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: List available kernel modules
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
X-List-Received-Date: Tue, 28 Apr 2015 16:51:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-04-28 at 15:43 +0100, Katu Txakur wrote:
> Hi,
> 
> 
> I'm using Yocto to bitbake a kernel and I would like to list the
> available kernel modules to decide which ones should I include. Could
> somebody please point me to the documentation explaining this. I've
> failed to find it.
> 
> 
> I know how to use the menuconfig, but I would like to see the list.
> Something similar to checking the list of packages that a recipe
> builds with 
> bitbake -e myrecipe | grep ^PACKAGES=
> 
This question is more appropriate for the yocto list really. You can see
the list of build packages by looking at the list of files in
tmp/deploy/<package manager> and kernel modules are prefixed
"kernel-module-" so something like:

ls tmp/deploy/ipk/qemux86/kernel-module-*

will give you a list assuming ipk packaging and qemux86 as the machine.

Cheers,

Richard



