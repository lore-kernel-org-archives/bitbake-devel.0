Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ti694-0001Ql-Jy; Mon, 10 Dec 2012 17:24:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBAG9N4o003171;
	Mon, 10 Dec 2012 16:09:23 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02629-03; Mon, 10 Dec 2012 16:09:19 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBAG9GDC003164
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2012 16:09:17 GMT
Message-ID: <1355155747.29967.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, openembedded-core
	<openembedded-core@lists.openembedded.org>
Date: Mon, 10 Dec 2012 16:09:07 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: EXPORT_FUNCTIONS - change in behaviour proposal
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
X-List-Received-Date: Mon, 10 Dec 2012 16:24:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

After Enrico's reported problem, I've been poking around the
EXPORT_FUNCTIONS code. Currently OE-Core metadata generates list A
below. In particular, this leads to code like:

 do_configure calls gnomebase_do_configure
 gnomebase_do_configure calls autotools_do_configure

which has a level of indirection. The gnomebase class never references
do_configure. I can appreciate adding in a default mapping of:

 do_configure calls autotools_do_configure

since it allows a user to call into autotools_do_configure from a custom
do_configure but I can't see the value of the intermediary
gnomebase_do_configure. Does anyone know of a use for it?

I have a suspicion that if it ever did do anything useful, it stopped
being useful long ago.

I'm therefore strongly tempted to remove the intermediaries from the
code. This would result in list B below which is a more direct set of
mappings.

Any thoughts/comments from anyone?

Cheers,

Richard

List A:
 autotools_do_siteconfig calls siteconfig_do_siteconfig
 autotools_do_siteconfig_gencache calls siteconfig_do_siteconfig_gencache
 base_do_patch calls patch_do_patch
 cmake_do_configure calls autotools_do_configure
 cmake_do_install calls autotools_do_install
 core-image_do_rootfs calls image_do_rootfs
 core-image_make_zimage_symlink_relative calls image_make_zimage_symlink_relative
 core-image_remove_init_link calls image_remove_init_link
 core-image_rootfs_no_x_startup calls image_rootfs_no_x_startup
 core-image_rootfs_update_timestamp calls image_rootfs_update_timestamp
 core-image_set_image_autologin calls image_set_image_autologin
 core-image_zap_root_password calls image_zap_root_password
 do_compile calls base_do_compile
 do_compile calls cmake_do_compile
 do_compile calls cpan_do_compile
 do_compile calls distutils_do_compile
 do_compile calls kernel_do_compile
 do_compile calls module_do_compile
 do_compile calls setuptools_do_compile
 do_configure calls autotools_do_configure
 do_configure calls base_do_configure
 do_configure calls cmake_do_configure
 do_configure calls cml1_do_configure
 do_configure calls cpan_do_configure
 do_configure calls gnomebase_do_configure
 do_configure calls kernel_do_configure
 do_configure calls qmake2_do_configure
 do_configure calls qmake_base_do_configure
 do_deploy calls kernel_do_deploy
 do_fetch calls base_do_fetch
 do_generate_toolchain_file calls cmake_do_generate_toolchain_file
 do_install calls autotools_do_install
 do_install calls base_do_install
 do_install calls cmake_do_install
 do_install calls cpan_do_install
 do_install calls distutils_do_install
 do_install calls gnomebase_do_install
 do_install calls kernel_do_install
 do_install calls module_do_install
 do_install calls setuptools_do_install
 do_package calls base_do_package
 do_patch calls base_do_patch
 do_siteconfig calls autotools_do_siteconfig
 do_siteconfig_gencache calls autotools_do_siteconfig_gencache
 do_unpack calls base_do_unpack
 gnomebase_do_configure calls autotools_do_configure
 gnomebase_do_install calls autotools_do_install
 package_name_hook calls debian_package_name_hook
 qmake2_do_configure calls qmake_base_do_configure
 setuptools_do_compile calls distutils_do_compile
 setuptools_do_install calls distutils_do_install


List B:
 do_compile calls base_do_compile
 do_compile calls cmake_do_compile
 do_compile calls cpan_do_compile
 do_compile calls distutils_do_compile
 do_compile calls kernel_do_compile
 do_compile calls module_do_compile
 do_configure calls autotools_do_configure
 do_configure calls base_do_configure
 do_configure calls cmake_do_configure
 do_configure calls cml1_do_configure
 do_configure calls cpan_do_configure
 do_configure calls kernel_do_configure
 do_configure calls qmake_base_do_configure
 do_deploy calls kernel_do_deploy
 do_fetch calls base_do_fetch
 do_generate_toolchain_file calls cmake_do_generate_toolchain_file
 do_install calls autotools_do_install
 do_install calls base_do_install
 do_install calls cmake_do_install
 do_install calls cpan_do_install
 do_install calls distutils_do_install
 do_install calls kernel_do_install
 do_install calls module_do_install
 do_package calls base_do_package
 do_patch calls patch_do_patch
 do_siteconfig calls siteconfig_do_siteconfig
 do_siteconfig_gencache calls siteconfig_do_siteconfig_gencache
 do_unpack calls base_do_unpack
 package_name_hook calls debian_package_name_hook



