Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D927E606D0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:14:57 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0P6EGsi004484
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 24 Jan 2019 22:14:26 -0800
Received: from localhost.corp.ad.wrs.com (128.224.163.177) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.408.0; Thu, 24 Jan 2019 22:14:05 -0800
To: Juan Jose Aguilar Linares <juan.jose.aguilar.linares@everis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <AM0PR03MB414523FD870737F89E5A31538D990@AM0PR03MB4145.eurprd03.prod.outlook.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <def7611e-cb4c-edaa-4480-3af80d702d08@windriver.com>
Date: Fri, 25 Jan 2019 14:18:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <AM0PR03MB414523FD870737F89E5A31538D990@AM0PR03MB4145.eurprd03.prod.outlook.com>
Subject: Re: eSDK
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
X-List-Received-Date: Fri, 25 Jan 2019 06:14:58 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi,

On 1/23/19 11:18 PM, Juan Jose Aguilar Linares wrote:
> Dear Yocto Team, I have practically no experience in yocto. I’m trying to modify 
> the snmp sources
> 
> to add a mib module and I have read that I need to install "devtool".
> 
> I execute the following commad.
> 
> $ bitbake fsl-image-gui -c populate_sdk_ext
> 
> Then, when I execute the generated script to install extensible sdk I get the 
> following error message:
> 
> defense@Defense:~/fsl-release-bsp/testBuild/tmp/deploy/sdk$ 
> ./fsl-imx-x11-glibc-x86_64-fsl-image-gui-cortexa9hf-neon-toolchain-ext-4.1.15-2.1.0.sh 
> 
> 
> Freescale i.MX Release Distro Extensible SDK installer version 4.1.15-2.1.0
> 
> ===========================================================================
> 
> Enter target directory for SDK (default: ~/fsl-imx-x11_sdk): ~/fsl-imx-x11-sdk-0
> 
> You are about to install the SDK to "/home/defense/fsl-imx-x11-sdk-0". 
> Proceed[Y/n]? Y
> 
> Extracting 
> SDK.......................................................................................................done
> 
> Setting it up...
> 
> Extracting buildtools...
> 
> Preparing build system...
> 
> ERROR: SDK preparation failed: see 
> /home/defense/fsl-imx-x11-sdk-0/preparing_build_system.log

Have you check this file, please ? Or you can paste it here if it is not too long.


> 
> ### Shell environment set up for builds. ###
> 
> You can now run 'bitbake <target>'
> 
> Common targets are:
> 
>      core-image-minimal
> 
>      core-image-sato
> 
>      meta-toolchain
> 
>      meta-ide-support
> 
> You can also run generated qemu images with a command like 'runqemu qemux86'
> 
> Preparing SDK for fsl-image-gui...
> 
> Parsing recipes...WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-sdk/recipes-qt5/qt5/gstreamer1.0-plugins-bad-qt_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-bad-qt SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found

Check the SRC_URI in gstreamer1.0-plugins-bad-qt_1.8.1.bb and 
0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch, you specify 
wrong path in SRC_URI.

// Robert

> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-sdk/recipes-qt5/qt5/gstreamer1.0-plugins-bad-qt_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-bad-qt SRC_URI entry 
> 0001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0 SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-rtsp-server_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-rtsp-server SRC_URI entry 
> 0001-Don-t-hardcode-libtool-name-when-using-introspection.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-rtsp-server_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-rtsp-server SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-good SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-base SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-base SRC_URI entry 
> 0001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-base SRC_URI entry 
> 0002-Makefile.am-prefix-calls-to-pkg-config-with-PKG_CONF.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-base SRC_URI entry 
> 0003-riff-add-missing-include-directories-when-calling-in.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-base SRC_URI entry 
> 0004-rtsp-drop-incorrect-reference-to-gstreamer-sdp-in-Ma.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-bad SRC_URI entry 
> 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch: file could not 
> be found
> 
> WARNING: 
> /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_1.8.1.bb: 
> Unable to get checksum for gstreamer1.0-plugins-bad SRC_URI entry 
> 0001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch: file could not 
> be found
> 
> done.
> 
> Parsing of 2219 .bb files complete (0 cached, 2219 parsed). 2794 targets, 210 
> skipped, 5 masked, 0 errors.
> 
> NOTE: Resolving any missing task queue dependencies
> 
> ERROR: Uninative selected but not configured, please set UNINATIVE_URL
> 
> Summary: There were 13 WARNING messages shown.
> 
> Summary: There was 1 ERROR message shown, returning a non-zero exit code.
> 
> I have reviewed mailing list and I’ve found some useful information but I don’t 
> understand the problem.
> 
> Could you help me to solve the error or give me some guidelines to do it?
> 
> Thanks,
> 
> Juanjo.
> 
> 
> --------------------------------------------------------------------------------
> 
> AVISO DE CONFIDENCIALIDAD.
> Este correo y la información contenida o adjunta al mismo es privada y 
> confidencial y va dirigida exclusivamente a su destinatario. everis informa a 
> quien pueda haber recibido este correo por error que contiene información 
> confidencial cuyo uso, copia, reproducción o distribución está expresamente 
> prohibida. Si no es Vd. el destinatario del mismo y recibe este correo por 
> error, le rogamos lo ponga en conocimiento del emisor y proceda a su eliminación 
> sin copiarlo, imprimirlo o utilizarlo de ningún modo.
> 
> CONFIDENTIALITY WARNING.
> This message and the information contained in or attached to it are private and 
> confidential and intended exclusively for the addressee. everis informs to whom 
> it may receive it in error that it contains privileged information and its use, 
> copy, reproduction or distribution is prohibited. If you are not an intended 
> recipient of this E-mail, please notify the sender, delete it and do not read, 
> act upon, print, disclose, copy, retain or redistribute any portion of this E-mail.
> 

