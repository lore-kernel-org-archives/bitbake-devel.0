Return-Path: <akuster808@gmail.com>
Received: from mail-pl0-f51.google.com (mail-pl0-f51.google.com
	[209.85.160.51])
	by mail.openembedded.org (Postfix) with ESMTP id 5ECB377811
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 15:10:02 +0000 (UTC)
Received: by mail-pl0-f51.google.com with SMTP id i6so4386575plt.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-language;
	bh=hp1wlOwtQrc1LYyEiwLUVq0EhtQN/UHDHoQZSuUokhY=;
	b=YYGS++8UaMhnrdd1SFOmIzG5oQQhkckh2Woqa2UErxJq9Kw5NISsyw5S5XM1ONR9vf
	znlqHNcvIOLQyBO0CZ7XEHimk2OG5py4P9WzbCQm3aqRAeUuBEpC7IS1y6QRGw8i27GY
	MRmi8EhlZVWko2U3aX9rAzua0YofcPOh+KBH8WVzMYYCWY7ZwKkW6Rq+p3F8onG/HGWl
	4y5ivdRRUnG72ycU7Kekrj3QwWzVGY5bMzpf9Zp+EeTIzneXNwgsyFAFQRo3pDaCLdjm
	Q+HK9usNtgU9FqDliLDRCtKnvg9/lOf/9Mnh91XHYW1pImFjM0bx/LmcyPLFz4O4bOqN
	d1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-language;
	bh=hp1wlOwtQrc1LYyEiwLUVq0EhtQN/UHDHoQZSuUokhY=;
	b=QVGSBZacl9hPc6RLhNGbxa3+/A1ikgTfDIgehOucvTkhwYJFYsiFMNAO/W8l8QjjEd
	2O9q5U9fPgKX3C+H24z513ZOuweV6VddoespSbAItoZK0odeasnOpK/KyKg3tCaBZwjg
	VeFZZHfwDbWIArvPMHcFs/+ZUl5v2rzRIOjFVeek6V5LpUmIfLOqPbJ7xHQK+K0NDvjl
	ZyZPCSaLJqfwkCkabynf0JcaEU/wpz0La+uMyNPS6RVy6SVbXLGHT3Bio6BNmDvivV6N
	YkQoDc4P4APX8CB8mWEMLdzEsm66Ljv2bhYWFksJvFQFqR4i4DNZszvTZUgf1oMOlDqQ
	HFNA==
X-Gm-Message-State: AJaThX7S2YxoOBbqNY2mos5S5Ox+w1ENX/DspQrGo1v3UBCaTxRu7Oq1
	CcrrOjUYdjdumPjMjcSorqxVJA==
X-Google-Smtp-Source: AGs4zMa31HyIH2SRZgJ5ftrYjB+Q9vAJr20XF76AY7S6UHDJPnyzD/dVHQFiAPC2BxXJfDZo476v2w==
X-Received: by 10.159.242.4 with SMTP id t4mr2893945plr.411.1512054603853;
	Thu, 30 Nov 2017 07:10:03 -0800 (PST)
Received: from ?IPv6:2601:202:4001:9ea0:d931:40ea:f4e3:3a31?
	([2601:202:4001:9ea0:d931:40ea:f4e3:3a31])
	by smtp.gmail.com with ESMTPSA id
	o23sm7863608pgn.92.2017.11.30.07.10.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 Nov 2017 07:10:03 -0800 (PST)
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
From: akuster808 <akuster808@gmail.com>
Message-ID: <d0a53192-4390-7bb6-be68-e200d2efdee3@gmail.com>
Date: Thu, 30 Nov 2017 07:10:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
Subject: State of bitbake world, Failed tasks 2017-11-28
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
X-List-Received-Date: Thu, 30 Nov 2017 15:10:03 -0000
Content-Type: multipart/alternative;
	boundary="------------6D0A527D9D5F75C0445E855B"
Content-Language: en-US

--------------6D0A527D9D5F75C0445E855B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

http://www.openembedded.org/wiki/Bitbake_World_Status

== Number of issues - stats ==
{| class='wikitable'
!|Date		     !!colspan='4'|Failed tasks			    !!|Signatures		  !!colspan='15'|QA !!Comment
|-
||		||qemuarm	||qemuarm64	||qemux86	||qemux86_64	||all 	||already-stripped	||libdir	||textrel	||build-deps	||file-rdeps	||version-going-backwards	||host-user-contaminated	||installed-vs-shipped	||unknown-configure-option	||symlink-to-sysroot	||invalid-pkgconfig	||pkgname	||ldflags	||compile-host-path	||qa_pseudo	||	
|-
||2017-11-28	||5	||7	||29	||3	||0	||0		||0		||2		||0		||0		||32		||4		||1		||0		||0		||0		||0		||0		||0		||5		||	
|}

== Failed tasks 2017-11-28 ==

INFO: jenkins-job.sh-1.8.43 Complete log available at http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.report.20171129_182805.log

=== common (2) ===
    * meta-openembedded/meta-networking/recipes-daemons/ddclient/ddclient_3.8.3.bb:do_install
    * meta-openembedded/meta-networking/recipes-daemons/postfix/postfix_3.2.2.bb:do_install

=== common-x86 (0) ===

=== qemuarm (3) ===
    * meta-openembedded/meta-oe/recipes-devtools/android-tools/android-tools_5.1.1.r37.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtwebsockets_git.bb:do_package_qa
    * openembedded-core/meta/recipes-core/glibc/glibc-locale_2.26.bb:do_package_qa

=== qemuarm64 (4) ===
    * meta-openembedded/meta-initramfs/recipes-devtools/mtd/ubi-utils-klibc_1.5.2.bb:do_install
    * meta-openembedded/meta-initramfs/recipes-kernel/kexec/kexec-tools-klibc_2.0.2.bb:do_configure
    * meta-openembedded/meta-oe/recipes-devtools/luajit/luajit_2.0.5.bb:do_compile
    * openembedded-core/meta/recipes-kernel/kexec/kexec-tools_2.0.15.bb:do_compile

=== qemux86 (27) ===
    * meta-browser/recipes-browser/chromium/chromium_62.0.3202.94.bb:do_compile
    * meta-browser/recipes-browser/firefox/firefox_45.9.0esr.bb:do_compile
    * meta-openembedded/meta-networking/recipes-connectivity/rdist/rdist_6.1.5.bb:do_package
    * meta-openembedded/meta-networking/recipes-connectivity/samba/samba_4.7.0.bb:do_patch
    * meta-openembedded/meta-networking/recipes-daemons/opensaf/opensaf_5.17.07.bb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/vsftpd/vsftpd_3.0.3.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rsh/netkit-rsh_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rusers/netkit-rusers_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb:do_configure
    * meta-openembedded/meta-networking/recipes-protocols/mdns/mdns_765.50.9.bb:do_compile
    * meta-openembedded/meta-networking/recipes-protocols/tsocks/tsocks_1.8beta5.bb:do_compile
    * meta-openembedded/meta-networking/recipes-support/open-isns/open-isns_0.97.bb:do_compile
    * meta-openembedded/meta-oe/recipes-benchmark/libhugetlbfs/libhugetlbfs_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/umip/umip_1.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/wvdial/wvdial_1.61.bb:do_compile
    * meta-openembedded/meta-oe/recipes-devtools/pm-qa/pm-qa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-extended/mraa/mraa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/crash/crash_7.1.9.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/minicoredumper/minicoredumper_2.0.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-multimedia/alsa/alsa-oss_1.0.17.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python3-systemd_234.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python-systemd_234.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtlocation_git.bb:do_compile
    * openembedded-core/meta/recipes-devtools/systemd-bootchart/systemd-bootchart_231.bb:do_compile
    * openembedded-core/meta/recipes-graphics/cogl/cogl-1.0_1.22.2.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_1.12.3.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/x264/x264_git.bb:do_package_qa

=== qemux86_64 (1) ===
    * meta-qt5/recipes-qt/qt5/qtgamepad_git.bb:do_package_qa

=== Number of failed tasks (44) ===
{| class=wikitable
|-
|| qemuarm 	|| 5	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm.20171128_061536.log/ || http://errors.yoctoproject.org/Errors/Build/48955/
|-
|| qemuarm64 	|| 7	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm64.20171128_085209.log/ || http://errors.yoctoproject.org/Errors/Build/48957/
|-
|| qemux86 	|| 29	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86.20171128_061544.log/ || http://errors.yoctoproject.org/Errors/Build/48956/
|-
|| qemux86_64 	|| 3	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86-64.20171128_090400.log/ || http://errors.yoctoproject.org/Errors/Build/48958/
|}

=== PNBLACKLISTs (0) ===

=== QA issues (44) ===
{| class=wikitable
!| Count		||Issue
|-
||0	||already-stripped
|-
||0	||build-deps
|-
||0	||compile-host-path
|-
||0	||file-rdeps
|-
||0	||invalid-pkgconfig
|-
||0	||ldflags
|-
||0	||libdir
|-
||0	||pkgname
|-
||0	||symlink-to-sysroot
|-
||0	||unknown-configure-option
|-
||1	||installed-vs-shipped
|-
||2	||textrel
|-
||32	||version-going-backwards
|-
||4	||host-user-contaminated
|-
||5	||qa_pseudo
|}



=== Incorrect PACKAGE_ARCH or sstate signatures (0) ===

Complete log: http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.signatures.20171128_114414.log/


    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86copy in /home/jenkins/oe/world/shr-core/tmpfs/stamps
    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86 in /home/jenkins/oe/world/shr-core/tmpfs/stamps


PNBLACKLISTs:
openembedded-core/:
meta-browser:
meta-openembedded:
meta-qt5:
PNBLACKLIST[android-system] = "depends on lxc from meta-virtualiazation which isn't included in my world builds"
PNBLACKLIST[bigbuckbunny-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-480p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[tearsofsteel-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[build-appliance-image] = "tries to include whole downloads directory in /home/builder/poky :/"


QA issues by type:
count: 0	issue: already-stripped


count: 0	issue: libdir


count: 2	issue: textrel
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264-bin/usr/bin/x264' has relocations in .text [textrel]
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264/usr/lib/libx264.so.148' has relocations in .text [textrel]


count: 0	issue: build-deps


count: 0	issue: file-rdeps


count: 32	issue: version-going-backwards
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-dbg went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-dev went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-ptest went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-dbg went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-dev went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-ptest went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]


count: 4	issue: host-user-contaminated
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-ce-ru/usr/lib/locale/ce_RU/LC_PAPER is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-hy-am/usr/lib/locale/hy_AM/LC_MEASUREMENT is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtgamepad-5.9.2+gitAUTOINC+167566d228: qtgamepad: /qtgamepad-qmlplugins/usr/lib/qt5/qml/QtGamepad/qmldir is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: qtwebsockets: /qtwebsockets-qmlplugins/usr/lib/qt5/qml/QtWebSockets/qmldir is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]


count: 1	issue: installed-vs-shipped
rdist: 1 installed and not shipped files. [installed-vs-shipped]


count: 0	issue: unknown-configure-option


count: 0	issue: symlink-to-sysroot


count: 0	issue: invalid-pkgconfig


count: 0	issue: pkgname


count: 0	issue: ldflags


count: 0	issue: compile-host-path


count: 5	issue: qa_pseudo
php-7.1.9: This /work/aarch64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/armv5e-oe-linux-gnueabi/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/core2-64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/i586-oe-linux-musl/php/7.1.9-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
python3-ndg-httpsclient-0.4.3: This /work/i586-oe-linux-musl/python3-ndg-httpsclient/0.4.3-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]



This git log matches with the metadata as seen by qemuarm build.
In some cases qemux86 and qemux86-64 builds are built with slightly
different metadata, you can see the exact version near the top of each
log.world.qemu* files linked from the report

== Tested changes (not included in master yet) - bitbake ==
latest upstream commit: 
8c48717 fetch/wget: use with to ensure the response is closed
not included in master yet: 
032e73d world-image: add extra target
f81d34e fetch2: Allow Fetch.download() to warn instead of error

== Tested changes (not included in master yet) - openembedded-core ==
latest upstream commit: 
33418ed runqemu: Also specialcase resolution of '.' to the file's location
not included in master yet: 
47dc3bd kernel-devicetree.bbclass: Use lowercase names for shell variables
7e0e6c9 kernel-devicetree.bbclass: Fix and simplify instalation of DTB files
f3a28cf kernel.bbclass: use the consistent naming schema for initramfs
cb576cc kernel.bbclass: move variables for kernel artifacts names to separate bbclass
0c828c4 report-error: Allow to upload reports automatically
932355c buildhistory.bbclass: metadata-revs show repo parent
37d01c5 metadata-revs: provide more information
0fb7c6a qemux86: Add identical qemux86copy variant for tests
a8998be reproducible_build.bbclass: initial support for binary reproducibility
d050fd8 cpio: provide cpio-replacement-native
40bbaf9 image_types.bbclass: improve cpio image reproducibility
dc33f56 rootfs-postcommands.bbclass: support binary reproducibility
35e8e23 sstate.bbclass: Do not cause build failures due to setscene errors
08fe101 insane.bbclass: Add do_qa_pseudo function to check for common errors listed in pseudo.log
320a40d insane.bbclass: use package_qa_handle_error for do_qa_pseudo

== Tested changes (not included in master yet) - meta-openembedded ==
latest upstream commit: 
34aa4c3 usb-modeswitch: add usb-modeswitch@.service
not included in master yet: 
6e0c0da bridge-utils: modify the AR to cross toolchain
ccf7d98 ssmtp: misc recipe updates + add Debian "partial loss of message body" fix
7e57be2 dovecot: Fix parallel build
9dff7b4 dnsmasq: update SRC_URI for versions 2.69 and earlier
5aea2c3 postfix: fix send mail failure and eliminate warning
deb3cf4 openvpn: Upgrade 2.4.3 -> 2.4.4
5af2de5 arptables: Fix do_install task
657a099 ddclient: new package
78080cd lksctp-tools: update and remove from blacklist
29e2270 freediameter: add new recipe
0628458 net-snmp: support openssl without 3des
1924580 stunnel: fix compile error when openssl disable des support
f05c04c bridge-utils: update to v1.6
f4389c9 corosync: 2.4.2 -> 2.4.3
d1a0371 cyrus-sasl: virtual/db isn't used by core, change to db
beb6e83 postfix: virtual/db isn't used by core, change to db
7dd3689 networkmanager: add consolekit only when x11 is enabled
de66bed iscsi-initiator-utils: check file existence before moving
c27cc77 iscsi-initiator-utils: remove the distro_features_check
1f35578 open-isns: add sysvinit support
f7e7c55 libtalloc: update to version 2.1.10
f079b8b libtevent: update to version 0.99.33
4d804d8 libtdb: update to version 1.3.15
16cc5d7 libldb: update to version 1.2.2
d117bd1 Revert "samba: add missing RDEPENDS"
5ff041c samba: move to version 4.7.0
9563446 pcmciautils: add (from oe-core)
238665f drop redundant 'inherit allarch' from packagegroups
570d625 hiredis: fix paths in pkgconfig conf file
9dea3c6 python-py: update to version 1.5.2
3f4c95a python-pytest: update to version 3.2.5
846cb92 python-jinja2: update to version 2.10
2b38bab python-grpcio: update to version 1.7.0
9892e2e python-grpcio-tools: update to version 1.7.0
33464c4 python3-coverage: update to version 4.4.2
c47b7d9 python-pyro4: update to version 4.63
fe8cc6e python-pysmi: update to version 0.2.2
2cbdc04 xfce4-vala: update vala api to 0.38
c5273e6 chrony: Update to version 3.2
8290ddb UFL: add missing license
524d2fc debootstrap: change license to MIT
c3e5719 poco: update to 1.8.0.1
0779247 Allow native builds of python-asyn1crypto
83e747f site: move from meta-oe to meta-networking
5f2a6ea xfce4-screenshooter: create src dir before build
061422d gpsd: use upstream config instead of our own
16565b0 gpsd: add gpsdctl@.service for USB autoplug
8181bd8 opencv: Fix error when dynamic link
a086166 php: Security Advisory - php - CVE-2017-16642
1376290 Fix PACKAGES assignment for fftw
8ec4f60 cdrkit: add a link to genisoimage with the name mkisofs
4ccbd11 dos2unix: update to version 7.4.0
1f5d5e2 gd: update to version 2.2.5
3950a1c xrdp: new recipe
f0d001a python-grpcio: only modify the compiler arguments on the target build
1544726 python-pyparted: remove unneeded DEPENDS on python{3}-re
7cd594b python-bitarray: add native to BBCLASSEXTEND
93725cd python-django-south: add native to BBCLASSEXTEND
4fe267f python-django: add native to BBCLASSEXTEND
c24340c python-jsonpatch: update to version 1.20
2c32abc python-pyasn1: update to version 0.4.2

== Tested changes (not included in master yet) - meta-qt5 ==
latest upstream commit: 
06d1c47 qtwebengine: make test suite succeed
not included in master yet: 

== Tested changes (not included in master yet) - meta-browser ==
latest upstream commit: 
a8bb1e7 Merge pull request #75 from rakuco/chromium-62.0.3202.94
not included in master yet: 


--------------6D0A527D9D5F75C0445E855B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre class="console-output"><a href="http://www.openembedded.org/wiki/Bitbake_World_Status">http://www.openembedded.org/wiki/Bitbake_World_Status</a>

== Number of issues - stats ==
{| class='wikitable'
!|Date		     !!colspan='4'|Failed tasks			    !!|Signatures		  !!colspan='15'|QA !!Comment
|-
||		||qemuarm	||qemuarm64	||qemux86	||qemux86_64	||all 	||already-stripped	||libdir	||textrel	||build-deps	||file-rdeps	||version-going-backwards	||host-user-contaminated	||installed-vs-shipped	||unknown-configure-option	||symlink-to-sysroot	||invalid-pkgconfig	||pkgname	||ldflags	||compile-host-path	||qa_pseudo	||	
|-
||2017-11-28	||5	||7	||29	||3	||0	||0		||0		||2		||0		||0		||32		||4		||1		||0		||0		||0		||0		||0		||0		||5		||	
|}

== Failed tasks 2017-11-28 ==

INFO: jenkins-job.sh-1.8.43 Complete log available at <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.report.20171129_182805.log">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.report.20171129_182805.log</a>

=== common (2) ===
    * meta-openembedded/meta-networking/recipes-daemons/ddclient/ddclient_3.8.3.bb:do_install
    * meta-openembedded/meta-networking/recipes-daemons/postfix/postfix_3.2.2.bb:do_install

=== common-x86 (0) ===

=== qemuarm (3) ===
    * meta-openembedded/meta-oe/recipes-devtools/android-tools/android-tools_5.1.1.r37.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtwebsockets_git.bb:do_package_qa
    * openembedded-core/meta/recipes-core/glibc/glibc-locale_2.26.bb:do_package_qa

=== qemuarm64 (4) ===
    * meta-openembedded/meta-initramfs/recipes-devtools/mtd/ubi-utils-klibc_1.5.2.bb:do_install
    * meta-openembedded/meta-initramfs/recipes-kernel/kexec/kexec-tools-klibc_2.0.2.bb:do_configure
    * meta-openembedded/meta-oe/recipes-devtools/luajit/luajit_2.0.5.bb:do_compile
    * openembedded-core/meta/recipes-kernel/kexec/kexec-tools_2.0.15.bb:do_compile

=== qemux86 (27) ===
    * meta-browser/recipes-browser/chromium/chromium_62.0.3202.94.bb:do_compile
    * meta-browser/recipes-browser/firefox/firefox_45.9.0esr.bb:do_compile
    * meta-openembedded/meta-networking/recipes-connectivity/rdist/rdist_6.1.5.bb:do_package
    * meta-openembedded/meta-networking/recipes-connectivity/samba/samba_4.7.0.bb:do_patch
    * meta-openembedded/meta-networking/recipes-daemons/opensaf/opensaf_5.17.07.bb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/vsftpd/vsftpd_3.0.3.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rsh/netkit-rsh_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rusers/netkit-rusers_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb:do_configure
    * meta-openembedded/meta-networking/recipes-protocols/mdns/mdns_765.50.9.bb:do_compile
    * meta-openembedded/meta-networking/recipes-protocols/tsocks/tsocks_1.8beta5.bb:do_compile
    * meta-openembedded/meta-networking/recipes-support/open-isns/open-isns_0.97.bb:do_compile
    * meta-openembedded/meta-oe/recipes-benchmark/libhugetlbfs/libhugetlbfs_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/umip/umip_1.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/wvdial/wvdial_1.61.bb:do_compile
    * meta-openembedded/meta-oe/recipes-devtools/pm-qa/pm-qa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-extended/mraa/mraa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/crash/crash_7.1.9.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/minicoredumper/minicoredumper_2.0.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-multimedia/alsa/alsa-oss_1.0.17.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python3-systemd_234.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python-systemd_234.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtlocation_git.bb:do_compile
    * openembedded-core/meta/recipes-devtools/systemd-bootchart/systemd-bootchart_231.bb:do_compile
    * openembedded-core/meta/recipes-graphics/cogl/cogl-1.0_1.22.2.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_1.12.3.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/x264/x264_git.bb:do_package_qa

=== qemux86_64 (1) ===
    * meta-qt5/recipes-qt/qt5/qtgamepad_git.bb:do_package_qa

=== Number of failed tasks (44) ===
{| class=wikitable
|-
|| qemuarm 	|| 5	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm.20171128_061536.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm.20171128_061536.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/48955/">http://errors.yoctoproject.org/Errors/Build/48955/</a>
|-
|| qemuarm64 	|| 7	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm64.20171128_085209.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm64.20171128_085209.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/48957/">http://errors.yoctoproject.org/Errors/Build/48957/</a>
|-
|| qemux86 	|| 29	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86.20171128_061544.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86.20171128_061544.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/48956/">http://errors.yoctoproject.org/Errors/Build/48956/</a>
|-
|| qemux86_64 	|| 3	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86-64.20171128_090400.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86-64.20171128_090400.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/48958/">http://errors.yoctoproject.org/Errors/Build/48958/</a>
|}

=== PNBLACKLISTs (0) ===

=== QA issues (44) ===
{| class=wikitable
!| Count		||Issue
|-
||0	||already-stripped
|-
||0	||build-deps
|-
||0	||compile-host-path
|-
||0	||file-rdeps
|-
||0	||invalid-pkgconfig
|-
||0	||ldflags
|-
||0	||libdir
|-
||0	||pkgname
|-
||0	||symlink-to-sysroot
|-
||0	||unknown-configure-option
|-
||1	||installed-vs-shipped
|-
||2	||textrel
|-
||32	||version-going-backwards
|-
||4	||host-user-contaminated
|-
||5	||qa_pseudo
|}



=== Incorrect PACKAGE_ARCH or sstate signatures (0) ===

Complete log: <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.signatures.20171128_114414.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.signatures.20171128_114414.log/</a>


    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86copy in /home/jenkins/oe/world/shr-core/tmpfs/stamps
    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86 in /home/jenkins/oe/world/shr-core/tmpfs/stamps


PNBLACKLISTs:
openembedded-core/:
meta-browser:
meta-openembedded:
meta-qt5:
PNBLACKLIST[android-system] = "depends on lxc from meta-virtualiazation which isn't included in my world builds"
PNBLACKLIST[bigbuckbunny-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-480p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[tearsofsteel-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[build-appliance-image] = "tries to include whole downloads directory in /home/builder/poky :/"


QA issues by type:
count: 0	issue: already-stripped


count: 0	issue: libdir


count: 2	issue: textrel
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264-bin/usr/bin/x264' has relocations in .text [textrel]
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264/usr/lib/libx264.so.148' has relocations in .text [textrel]


count: 0	issue: build-deps


count: 0	issue: file-rdeps


count: 32	issue: version-going-backwards
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-dbg went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-dev went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target-ptest went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-standalone-sdk-target-1.0: Package version for package packagegroup-core-standalone-sdk-target went backwards which would break package feeds from (0:1.0-r8.3 to 0:1.0-r8.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-dbg went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-dev went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug-ptest went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-core-tools-debug-1.0: Package version for package packagegroup-core-tools-debug went backwards which would break package feeds from (0:1.0-r3.3 to 0:1.0-r3.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-debug went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-extended went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-graphics went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-host-tools went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-dbg went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-dev went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk-ptest went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted-sdk went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]
packagegroup-self-hosted-1.0: Package version for package packagegroup-self-hosted went backwards which would break package feeds from (0:1.0-r13.3 to 0:1.0-r13.2) [version-going-backwards]


count: 4	issue: host-user-contaminated
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-ce-ru/usr/lib/locale/ce_RU/LC_PAPER is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-hy-am/usr/lib/locale/hy_AM/LC_MEASUREMENT is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtgamepad-5.9.2+gitAUTOINC+167566d228: qtgamepad: /qtgamepad-qmlplugins/usr/lib/qt5/qml/QtGamepad/qmldir is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: qtwebsockets: /qtwebsockets-qmlplugins/usr/lib/qt5/qml/QtWebSockets/qmldir is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]


count: 1	issue: installed-vs-shipped
rdist: 1 installed and not shipped files. [installed-vs-shipped]


count: 0	issue: unknown-configure-option


count: 0	issue: symlink-to-sysroot


count: 0	issue: invalid-pkgconfig


count: 0	issue: pkgname


count: 0	issue: ldflags


count: 0	issue: compile-host-path


count: 5	issue: qa_pseudo
php-7.1.9: This /work/aarch64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/armv5e-oe-linux-gnueabi/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/core2-64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/i586-oe-linux-musl/php/7.1.9-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
python3-ndg-httpsclient-0.4.3: This /work/i586-oe-linux-musl/python3-ndg-httpsclient/0.4.3-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]



This git log matches with the metadata as seen by qemuarm build.
In some cases qemux86 and qemux86-64 builds are built with slightly
different metadata, you can see the exact version near the top of each
log.world.qemu* files linked from the report

== Tested changes (not included in master yet) - bitbake ==
latest upstream commit: 
8c48717 fetch/wget: use with to ensure the response is closed
not included in master yet: 
032e73d world-image: add extra target
f81d34e fetch2: Allow Fetch.download() to warn instead of error

== Tested changes (not included in master yet) - openembedded-core ==
latest upstream commit: 
33418ed runqemu: Also specialcase resolution of '.' to the file's location
not included in master yet: 
47dc3bd kernel-devicetree.bbclass: Use lowercase names for shell variables
7e0e6c9 kernel-devicetree.bbclass: Fix and simplify instalation of DTB files
f3a28cf kernel.bbclass: use the consistent naming schema for initramfs
cb576cc kernel.bbclass: move variables for kernel artifacts names to separate bbclass
0c828c4 report-error: Allow to upload reports automatically
932355c buildhistory.bbclass: metadata-revs show repo parent
37d01c5 metadata-revs: provide more information
0fb7c6a qemux86: Add identical qemux86copy variant for tests
a8998be reproducible_build.bbclass: initial support for binary reproducibility
d050fd8 cpio: provide cpio-replacement-native
40bbaf9 image_types.bbclass: improve cpio image reproducibility
dc33f56 rootfs-postcommands.bbclass: support binary reproducibility
35e8e23 sstate.bbclass: Do not cause build failures due to setscene errors
08fe101 insane.bbclass: Add do_qa_pseudo function to check for common errors listed in pseudo.log
320a40d insane.bbclass: use package_qa_handle_error for do_qa_pseudo

== Tested changes (not included in master yet) - meta-openembedded ==
latest upstream commit: 
34aa4c3 usb-modeswitch: add <a class="moz-txt-link-abbreviated" href="mailto:usb-modeswitch@.service">usb-modeswitch@.service</a>
not included in master yet: 
6e0c0da bridge-utils: modify the AR to cross toolchain
ccf7d98 ssmtp: misc recipe updates + add Debian "partial loss of message body" fix
7e57be2 dovecot: Fix parallel build
9dff7b4 dnsmasq: update SRC_URI for versions 2.69 and earlier
5aea2c3 postfix: fix send mail failure and eliminate warning
deb3cf4 openvpn: Upgrade 2.4.3 -&gt; 2.4.4
5af2de5 arptables: Fix do_install task
657a099 ddclient: new package
78080cd lksctp-tools: update and remove from blacklist
29e2270 freediameter: add new recipe
0628458 net-snmp: support openssl without 3des
1924580 stunnel: fix compile error when openssl disable des support
f05c04c bridge-utils: update to v1.6
f4389c9 corosync: 2.4.2 -&gt; 2.4.3
d1a0371 cyrus-sasl: virtual/db isn't used by core, change to db
beb6e83 postfix: virtual/db isn't used by core, change to db
7dd3689 networkmanager: add consolekit only when x11 is enabled
de66bed iscsi-initiator-utils: check file existence before moving
c27cc77 iscsi-initiator-utils: remove the distro_features_check
1f35578 open-isns: add sysvinit support
f7e7c55 libtalloc: update to version 2.1.10
f079b8b libtevent: update to version 0.99.33
4d804d8 libtdb: update to version 1.3.15
16cc5d7 libldb: update to version 1.2.2
d117bd1 Revert "samba: add missing RDEPENDS"
5ff041c samba: move to version 4.7.0
9563446 pcmciautils: add (from oe-core)
238665f drop redundant 'inherit allarch' from packagegroups
570d625 hiredis: fix paths in pkgconfig conf file
9dea3c6 python-py: update to version 1.5.2
3f4c95a python-pytest: update to version 3.2.5
846cb92 python-jinja2: update to version 2.10
2b38bab python-grpcio: update to version 1.7.0
9892e2e python-grpcio-tools: update to version 1.7.0
33464c4 python3-coverage: update to version 4.4.2
c47b7d9 python-pyro4: update to version 4.63
fe8cc6e python-pysmi: update to version 0.2.2
2cbdc04 xfce4-vala: update vala api to 0.38
c5273e6 chrony: Update to version 3.2
8290ddb UFL: add missing license
524d2fc debootstrap: change license to MIT
c3e5719 poco: update to 1.8.0.1
0779247 Allow native builds of python-asyn1crypto
83e747f site: move from meta-oe to meta-networking
5f2a6ea xfce4-screenshooter: create src dir before build
061422d gpsd: use upstream config instead of our own
16565b0 gpsd: add <a class="moz-txt-link-abbreviated" href="mailto:gpsdctl@.service">gpsdctl@.service</a> for USB autoplug
8181bd8 opencv: Fix error when dynamic link
a086166 php: Security Advisory - php - CVE-2017-16642
1376290 Fix PACKAGES assignment for fftw
8ec4f60 cdrkit: add a link to genisoimage with the name mkisofs
4ccbd11 dos2unix: update to version 7.4.0
1f5d5e2 gd: update to version 2.2.5
3950a1c xrdp: new recipe
f0d001a python-grpcio: only modify the compiler arguments on the target build
1544726 python-pyparted: remove unneeded DEPENDS on python{3}-re
7cd594b python-bitarray: add native to BBCLASSEXTEND
93725cd python-django-south: add native to BBCLASSEXTEND
4fe267f python-django: add native to BBCLASSEXTEND
c24340c python-jsonpatch: update to version 1.20
2c32abc python-pyasn1: update to version 0.4.2

== Tested changes (not included in master yet) - meta-qt5 ==
latest upstream commit: 
06d1c47 qtwebengine: make test suite succeed
not included in master yet: 

== Tested changes (not included in master yet) - meta-browser ==
latest upstream commit: 
a8bb1e7 Merge pull request #75 from rakuco/chromium-62.0.3202.94
not included in master yet: 
</pre>
  </body>
</html>

--------------6D0A527D9D5F75C0445E855B--
