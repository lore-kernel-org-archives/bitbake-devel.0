Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0J0H-0006Yf-TG for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 21:41:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MKXDEZ001083;
	Wed, 22 Feb 2012 20:33:13 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32559-06; Wed, 22 Feb 2012 20:33:09 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MKX5VC001077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Feb 2012 20:33:06 GMT
Message-ID: <1329942784.32110.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 22 Feb 2012 20:33:04 +0000
In-Reply-To: <1329922919-29294-1-git-send-email-Martin.Jansa@gmail.com>
References: <1329921469.20261.158.camel@ted>
	<1329922919-29294-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen: compare runtaskdeps dictionary even when they have the same size
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
X-List-Received-Date: Wed, 22 Feb 2012 20:41:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-22 at 16:01 +0100, Martin Jansa wrote:
> * otherwise it reports lots of changed checksums just because it compares different tasks
> 
>   notice linux-libc-headers_3.1.bb.do_package_write:
>   Task dependency hash changed from 42acced29debf54d598802474c5e9cbb to f438a54f995df77620d0727d6f4b4ce5 (for linux-libc-headers_3.1.bb.do_package_write and linux-gta04_git.bb.do_deploy)
>   Task dependency hash changed from 61f8babe1d10c6e7fb1423112bb04e1e to 1b3e21ff106ecfcb7ddf76a1e29537bb (for linux-nokia900-meego_git.bb.do_deploy and linux-gta04_git.bb.do_package_write)
>   Task dependency hash changed from 512f9d6686d760b318d8b11c8b589226 to 42acced29debf54d598802474c5e9cbb (for linux-nokia900-meego_git.bb.do_package_write and linux-libc-headers_3.1.bb.do_package_write)
>   Task dependency hash changed from 153e91dfd1d2053fda7b98cc08d4b802 to 92a293bdd8ed234932b87a66025038c5 (for systemd-serialgetty.bb.do_package_write and systemd-serialgetty.bb.do_package_write)
>   Task dependency hash changed from 730abebf9954794bb440c2f3239f79fe to 413eaebaff27a2fd16f5cf68c1f4ff17 (for systemd_git.bb.do_package_write and systemd_git.bb.do_package_write)
> 
>   with this patch:
>   Dependency on task linux-nokia900-meego_git.bb.do_package_write was added
>   Dependency on task linux-nokia900-meego_git.bb.do_deploy was added
>   Dependency on task linux-gta04_git.bb.do_deploy was removed
>   Dependency on task linux-gta04_git.bb.do_package_write was removed
>   Hash for dependent task systemd_git.bb.do_package_write changed from 730abebf9954794bb440c2f3239f79fe to 413eaebaff27a2fd16f5cf68c1f4ff17
>   Hash for dependent task systemd-serialgetty.bb.do_package_write changed from 153e91dfd1d2053fda7b98cc08d4b802 to 92a293bdd8ed234932b87a66025038c5
> 
> * added test if there is different task with same hash then we don't
>   show it as added/removed dependency, because bitbake doesn't care
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/siggen.py |   47 ++++++++++++++++++++++++++---------------------
>  1 files changed, 26 insertions(+), 21 deletions(-)

Merged to master, thanks.

Richard



