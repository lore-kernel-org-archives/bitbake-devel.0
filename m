Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rkvgl-00044T-4l for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 11:45:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BAcKrc022800;
	Wed, 11 Jan 2012 10:38:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21682-08; Wed, 11 Jan 2012 10:38:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BAc9ox022794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2012 10:38:10 GMT
Message-ID: <1326278291.23315.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
Date: Wed, 11 Jan 2012 10:38:11 +0000
In-Reply-To: <cover.1326175837.git.lianhao.lu@intel.com>
References: <cover.1326175837.git.lianhao.lu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PRService/bitbake V2 0/2] new PRService features in bitbake
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
X-List-Received-Date: Wed, 11 Jan 2012 10:45:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-01-10 at 14:13 +0800, Lianhao Lu wrote:
> V2: rebase to latest code
> 
> NOTE: This set of patches added supporting for new features in bitbake.
> It should work together with another branch of patches in meta layers.
>     git://git.pokylinux.org/poky-contrib llu/PRService_oecore
> 
> It added PRService's export/import support in bitbake and also added a 
> no history mode as the default mode for PRSerivce. In this mode, the 
> AUTOPR value(which will be included in the finale PKGR) returned by 
> the PRService will never decrement. It also added PACKAGE_ARCH into 
> the index to the DB table, so the packages for different architcture 
> will have different AUTOPR values.
> 
> The PRService can be started in 2 ways. If the user wants share the 
> PRService for multiple buildings, it can start the PRService in the old
> way, by running "bitbake-prserv --start [options]", and set PRSERV_HOST 
> and PRSERV_PORT in local.conf accordingly.
> 
> If the user only wants the PRService to be used by current build, a local
> service may be started automatically by setting PRSERV_HOST to "localhost"
> and PRSERV_PORT to "0". This automatically started local service will only
> be effective to the builds running in the same build directory.
> 
> The following changes since commit 468998cddbe1a803096c9b357e1b5daa3b7e8c2e:
>   Dongxiao Xu (1):
>         command.py: add parseConfigurationFiles API
> 
> are available in the git repository at:
> 
>   git://git.pokylinux.org/poky-contrib llu/PRService_bitbake
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/PRService_bitbake
> 
> Lianhao Lu (2):
>   bitbake/PRservice: Added no_hist mode and export/import.
>   bitbake: Automatically start local PR service.

Merged to master, thanks.

Richard



