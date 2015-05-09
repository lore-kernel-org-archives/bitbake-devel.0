Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CE52473CDC;
	Sat,  9 May 2015 08:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t498WDne019204; Sat, 9 May 2015 09:32:13 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mW2Jzblt-S47; Sat,  9 May 2015 09:32:13 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t498Vr4P019196
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 9 May 2015 09:32:11 +0100
Message-ID: <1431160313.8074.342.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jate Sujjavanich <jatedev@gmail.com>
Date: Sat, 09 May 2015 09:31:53 +0100
In-Reply-To: <CAPphmgYj=ARopeoCC+UdcLXcMTfZGO+CH=_YN4Zb7mvdvP==Yw@mail.gmail.com>
References: <CAPphmgYj=ARopeoCC+UdcLXcMTfZGO+CH=_YN4Zb7mvdvP==Yw@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [0/2] Yocto Bug #6149, #5044
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
X-List-Received-Date: Sat, 09 May 2015 08:32:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-05-07 at 19:50 -0400, Jate Sujjavanich wrote:
> I came across these bugs in poky 1.6.3 (daisy) with multiple package
> providers. I fixed bug 6149 with just bitbake patch.
>
> I came across another bug with this when I tried the bitbake fix on
> master. With the test case 
>
> IMAGE_INSTALL_append = " sshd"
> PREFERRED_PROVIDER_sshd="dropbear"
>
> meta/lib/oe/package_manager.py reported a package not found in the
> base feeds. The file image.bbclass starts copies IMAGE_INSTALL to
> PACKAGE_INSTALL and performs fix ups for multilib, etc. I added
> another function (rootfs_process_preferred_providers) to replace sshd
> in PACKAGE_INSTALL with dropbear. This eliminated the error.
>
> The mega-manual is vague when it describes what can be specified in
> PREFERRED_PROVIDER: an item. And the code partially supports run-time
> packages as a valid item on the left. My implementation assumes a
> package name on the right.

I'm afraid this assumption is not correct. There are two distinct
namespaces we have, the "buildtime" recipe names (PN) and the runtime
package names. PREFERRED_PROVIDER takes recipe names (PN), not runtime
ones. Mixing the two up is going to cause confusion and problems so the
patch as it stands cannot be merged for this reason.

> Yocto bug 5044 suggests traversing from the package name to the
> virtual/* provider, but I have not thought through how this might
> work.
>
> IMAGE_INSTALL_append = " libasound-module-bluez"
> PREFERRED_PROVIDER_libasound-module-bluez="bluez4"
>
> I got this working on poky 1.6.3, but some changes to the bluez
> recipes on master seemed to mitigate the original problem.
> 
We have several issues with the way PREFERRED_PROVIDER works today and
the translations between build time and runtime. I suspect that code
needs rethinking to some extent. I know 5044 is assined to me, as yet
I've not been able to find the time it needs to properly think through
the different issues and fix it :(

Cheers,

Richard



