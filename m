Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4641C7706C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 17:23:29 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 03 Nov 2015 09:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,239,1444719600"; d="scan'208";a="593317547"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2015 09:23:29 -0800
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id B65326A4083
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 09:22:26 -0800 (PST)
Date: Tue, 3 Nov 2015 19:23:25 +0200
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20151103172325.GA7954@linux.intel.com>
References: <1446570229-7700-1-git-send-email-ed.bartosh@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1446570229-7700-1-git-send-email-ed.bartosh@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH] qemu-native: fix build on Ubuntu 15.10
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: ed.bartosh@linux.intel.com
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 03 Nov 2015 17:23:30 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sorry, wrong list. Please, ignore this patch. I'll send it to oe-core.

On Tue, Nov 03, 2015 at 07:03:49PM +0200, Ed Bartosh wrote:
> Build of qemu-native on Ubuntu 15.10 fails on configure step.
> The reason for this is that system dbus version is higher than
> oe dbus version and system pulseaudio libraries require newer dbus.
> 
> It causes configure to break with a lot of errors similar to this:
>   libpulsecommon-6.0.so: undefined reference to dbus_watch_get_enabled@LIBDBUS_1_3
> 
> Fixed by building qemu-native with the system dbus on Ubuntu 15.10
> 
> Note: This is a workaround. It must be removed when oe dbus is upgraded
> to the version >= system dbus version (1.10.0 at the moment).
> 
> [YOCTO #8553]
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  meta/recipes-devtools/qemu/qemu.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/meta/recipes-devtools/qemu/qemu.inc b/meta/recipes-devtools/qemu/qemu.inc
> index abbace8..b17da2f 100644
> --- a/meta/recipes-devtools/qemu/qemu.inc
> +++ b/meta/recipes-devtools/qemu/qemu.inc
> @@ -40,6 +40,12 @@ do_configure_prepend_class-native() {
>  	BHOST_PKGCONFIG_PATH=$(PATH=/usr/bin:/bin pkg-config --variable pc_path pkg-config || echo "")
>  	if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
>  		export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
> +		# link with system dbus on Ubuntu 15.10
> +		# FIXME: remove below 4 lines when oe dbus is upgraded
> +		if [ -r /etc/lsb-release -a "$(lsb_release -is)$(lsb_release -rs)" = "Ubuntu15.10" ] ; then
> +			libs=$(PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 PKG_CONFIG_PATH=$BHOST_PKGCONFIG_PATH PATH=/usr/bin:/bin pkg-config --libs dbus-1 || echo "")
> +			[ -n "$libs" ] && export LDFLAGS="$libs $LDFLAGS"
> +		fi
>  	fi
>  }
>  
> -- 
> 2.1.4
> 

-- 
--
Regards,
Ed

