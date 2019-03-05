Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id 0F16A7C377;
	Tue,  5 Mar 2019 11:10:09 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id v10so7239338lji.3;
	Tue, 05 Mar 2019 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BEN9w/8vTNRSvkdwNFxYQrP7vHUsDGOvZbsH66/nu+g=;
	b=vSW3wX0QQWjxUW7UNqeGnBQSHRft6msquQ0qPkPjiMT3ZMRbIF6Z5Hg90h9fjWzeT2
	hv73EAuSTsMZE+Ken7JvFMG4khf5AMefqVMNZjccEnT6synvgPLLDQENo7Y2llMT2Twp
	2EJkG39VuGAqwMwIPJDQiimLunF7ooZRq92C4S3JNFOQkdswkLrCyR6d06E7d/fNfRlN
	9aCm4nAB42azlsY/fxKtgpt+m1+rphGVWMVaBhLzpAiKzo7II6u9kYhwrPA4bIxOyDyE
	fdDG6ZBNki//WHWo2BaOEw/8MVCX/tVZvFfWeXnlsaB2kX1lFCW3Ctn2Oy/GgdVA1Ruh
	HgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BEN9w/8vTNRSvkdwNFxYQrP7vHUsDGOvZbsH66/nu+g=;
	b=HkAKFCCooOaHyrdZmtWFpeJXJPap/wx1NYBKccH9Y02p3kEG1tUTFsjqqlp3j77e+z
	3J5yy3XDAbjEuST+cCnKwN9OPJqebCWm8QMPva8DIj0pbR4xHVpZ9RP3ggsxTCGGAivT
	fI9W0nSanCXRbYLmdQYBlTsic3mb6RTw+tsWm1wFUlNyLoNBEiSuM8blaU1G4Ad2vbN9
	R0cBCEzIe6QdbLRnQFippRX06NFhtdRT1yCntwlUvdif6KKn5dgGY4Oi1AdBwLrR1NP8
	rBjVvoNYyrbLTqv+R+yXudqaW11+OG/eju0dQU0u2aLyg/3Dwue/PocIKlShSuqwuY51
	fsZg==
X-Gm-Message-State: APjAAAVDBJ/IE5lyxmvv3IquOJB0FG/opJl2Y+eC+cvm4RjoTIYhe5wi
	kJ6EIneiQYwmKK8SFI9zmtCmlO/GMFBhSRNQ2E0=
X-Google-Smtp-Source: APXvYqyXJuIt1t2IVpVAA46KoBgczjvgkmW3wpYVpOQOMibV0Mq+yWgIYqML+4qVByqwvz2xp3GFUc04PvkFU5sA8rY=
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr13231998lji.155.1551784210350;
	Tue, 05 Mar 2019 03:10:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
	<CAJTo0LYEFB4GyiyP=JK3vj2vFqzT1tzJiERKqezb9BO3N_K25g@mail.gmail.com>
	<CAPybu_2fbDkuM_kpX4ZbyPw8B8QfS2FEoCXSg1z7gFvfF=gyBg@mail.gmail.com>
	<CAJTo0LbXz_d+oNrHxrE2M3nOKeZh0C7-bz76OqHS0_zgkTHk6w@mail.gmail.com>
In-Reply-To: <CAJTo0LbXz_d+oNrHxrE2M3nOKeZh0C7-bz76OqHS0_zgkTHk6w@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 5 Mar 2019 12:09:53 +0100
Message-ID: <CAPybu_1hQXii8eaLk2fEhVaE7vbAQFBowBXtCjy+jKoNEYcmcQ@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
X-Mailman-Approved-At: Wed, 06 Mar 2019 08:57:11 +0000
Cc: Daniel Gomez <daniel@qtec.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Tue, 05 Mar 2019 11:10:10 -0000
Content-Type: text/plain; charset="UTF-8"

This is my approach (which is not more than a horrible hack)

DESCRIPTION = "Tegra replacements for mesa libraries"
require recipes-bsp/tegra-binaries/tegra-glvnd.inc
RDEPENDS_libgl-mesa = "tegra-lib-common libegl-mesa libxcb-glx
libxxf86vm libxdamage libxcb-xfixes"
RDEPENDS_libegl-mesa = "zlib libxcb-xfixes libxcb-present libdrm
libxshmfence libxcb-sync libglapi expat libxcb-dri2 libgbm libxcb-dri3
libx11 libx11-xcb"
RDEPENDS_libgles2-mesa = "libdrm libglapi"
RDEPENDS_libgles1-mesa = "libdrm libglapi"
RPROVIDES_libgl-mesa += "gl-proprietary libgl"
RPROVIDES_libegl-mesa += "libegl"
RPROVIDES_libgles2-mesa += "libgles2"
RPROVIDES_libgles1-mesa += "libgles1"
PV = "${L4T_RELEASE}"
PE = "5"
PACKAGES = "libgl-mesa libegl-mesa libgles2-mesa libgles1-mesa"
L4T_GLVND_DIR = "${WORKDIR}/Linux_for_Tegra/libglvnd"
L4T_GL_LIBRARIES = "${L4T_GLVND_DIR}/usr/lib/aarch64-linux-gnu/tegra"
L4T_EGL_LIBRARIES = "${L4T_GLVND_DIR}/usr/lib/aarch64-linux-gnu/tegra-egl"
do_unpack_append() {
    bb.build.exec_func("unpack_l4t_tar", d)
}
unpack_l4t_tar() {
    install -d ${L4T_GLVND_DIR}
    tar -C ${L4T_GLVND_DIR} -x -f \
    ${WORKDIR}/Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2 \
    usr/lib/aarch64-linux-gnu/tegra \
    usr/lib/aarch64-linux-gnu/tegra-egl
}
do_compile[noexec] = "1"
PACKAGEFUNCS_append = " rm_pkgdata_runtime"
rm_pkgdata_runtime() {
rm -rf ${WORKDIR}/pkgdata/runtime/*
rm -rf ${WORKDIR}/pkgdata/shlibs2/*
}
do_install() {
    install -d ${D}${libdir}
    # Install NVIDIA mesa libraries (libglvnd)
    install -m755 ${L4T_GL_LIBRARIES}/libGL.so.1 ${D}${libdir}/libGL.so.1.2.0
    install -m755 ${L4T_EGL_LIBRARIES}/libEGL.so.1 ${D}${libdir}/libEGL.so.1.0.0
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM.so.1
${D}${libdir}/libGLESv1_CM.so.1.1.0
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv2.so.2
${D}${libdir}/libGLESv2.so.2.0.0
    ln -sf libGL.so.1.2.0 ${D}${libdir}/libGL.so.1
    ln -sf libEGL.so.1.0.0 ${D}${libdir}/libEGL.so.1
    ln -sf libGLESv1_CM.so.1.1.0 ${D}${libdir}/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1.1.0 ${D}${libdir}/libGLESv1_CM.so
    ln -sf libGLESv2.so.2.0.0 ${D}${libdir}/libGLESv2.so.2
    # Install extra NVIDIA libglvnd libraries
    install -m755 ${L4T_GL_LIBRARIES}/libGLX.so.0 ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libGLdispatch.so.0 ${D}${libdir}/
    ln -sf libGLX.so.0 ${D}${libdir}/libGLX.so
    ln -sf libGLdispatch.so.0 ${D}${libdir}/libGLdispatch.so
    # Install extra EGL NVIDIA libraries
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM_nvidia.so.1 ${D}${libdir}/
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM.so.1 ${D}${libdir}/
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv2_nvidia.so.2 ${D}${libdir}/
    # Install extra GL NVIDIA libraries
    install -m755 ${L4T_GL_LIBRARIES}/libGLX_nvidia.so.0 ${D}${libdir}/
    # Install libraries dependent on libglvnd libs
    install -m755 ${L4T_EGL_LIBRARIES}/libEGL_nvidia.so.0 ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libnvidia-glsi.so.28.2.1 ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libnvbuf_utils.so.1.0.0 ${D}${libdir}/
    ln -sf libnvbuf_utils.so.1.0.0 ${D}${libdir}/libnvbuf_utils.so.1
    ln -sf libnvbuf_utils.so.1.0.0 ${D}${libdir}/libnvbuf_utils.so
    install -m755 ${L4T_GL_LIBRARIES}/libnvddk_vic.so ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libnvddk_2d_v2.so ${D}${libdir}/
    # nvcamera_daemon and argus_daemon have hard-coded path for this
    install -d ${D}${nonarch_libdir}/aarch64-linux-gnu/tegra-egl
    ln -sf ${libdir}/libEGL.so.1.0.0
${D}${nonarch_libdir}/aarch64-linux-gnu/tegra-egl/libEGL.so
}
PACKAGE_ARCH = "${MACHINE_ARCH}"
FILES_libgles1-mesa += "\
    ${libdir}/libGLESv1* \
"
FILES_libgles2-mesa += "\
    ${libdir}/libGLESv2* \
"
FILES_libegl-mesa += "\
    ${libdir}/libEGL* \
    ${nonarch_libdir}/aarch64-linux-gnu/tegra-egl/libEGL.so \
"
FILES_libgl-mesa += "\
    ${libdir}/libGL.* \
    ${libdir}/libGLX* \
    ${libdir}/libGLdispatch.so* \
    ${libdir}/libnvidia-glsi.so.28.2.1 \
    ${libdir}/libnvbuf_utils.so* \
    ${libdir}/libnvddk_vic.so  \
    ${libdir}/libnvddk_2d_v2.so \
"
INSANE_SKIP_${PN} = "already-stripped"
INSANE_SKIP_libegl-mesa = "ldflags dev-so"
INSANE_SKIP_libgles1-mesa = "ldflags dev-so"
INSANE_SKIP_libgles2-mesa = "ldflags"
INSANE_SKIP_libgl-mesa = "ldflags dev-so textrel"
PRIVATE_LIBS = "libGL.so.1 libEGL.so.1 libGLESv2.so.2 libGLESv1_CM.so.1"
read_subpackage_metadata () {
}


This is as Richard suggested:

DESCRIPTION = "Tegra replacements for mesa libraries"

require recipes-bsp/tegra-binaries/tegra-glvnd.inc

RDEPENDS_libgl-tegra = "tegra-lib-common libegl-tegra libxcb-glx
libxxf86vm libxdamage libxcb-xfixes"
RDEPENDS_libegl-tegra = "zlib libxcb-xfixes libxcb-present libdrm
libxshmfence libxcb-sync libglapi expat libxcb-dri2 libgbm libxcb-dri3
libx11 libx11-xcb"
RDEPENDS_libgles2-tegra = "libdrm libglapi"
RDEPENDS_libgles1-tegra = "libdrm libglapi"

PV = "${L4T_RELEASE}"
PE = "5"

PACKAGES = "libgl-tegra libegl-tegra libgles2-tegra libgles1-tegra"

L4T_GLVND_DIR = "${WORKDIR}/Linux_for_Tegra/libglvnd"
L4T_GL_LIBRARIES = "${L4T_GLVND_DIR}/usr/lib/aarch64-linux-gnu/tegra"
L4T_EGL_LIBRARIES = "${L4T_GLVND_DIR}/usr/lib/aarch64-linux-gnu/tegra-egl"

do_unpack_append() {
    bb.build.exec_func("unpack_l4t_tar", d)
}

unpack_l4t_tar() {
    install -d ${L4T_GLVND_DIR}
    tar -C ${L4T_GLVND_DIR} -x -f \
    ${WORKDIR}/Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2 \
    usr/lib/aarch64-linux-gnu/tegra \
    usr/lib/aarch64-linux-gnu/tegra-egl
}

do_compile[noexec] = "1"

do_install() {
    install -d ${D}${libdir}
    # Install NVIDIA mesa libraries (libglvnd)
    install -m755 ${L4T_GL_LIBRARIES}/libGL.so.1 ${D}${libdir}/libGL.so.1.2.0
    install -m755 ${L4T_EGL_LIBRARIES}/libEGL.so.1 ${D}${libdir}/libEGL.so.1.0.0
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM.so.1
${D}${libdir}/libGLESv1_CM.so.1.1.0
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv2.so.2
${D}${libdir}/libGLESv2.so.2.0.0
    ln -sf libGL.so.1.2.0 ${D}${libdir}/libGL.so.1
    ln -sf libEGL.so.1.0.0 ${D}${libdir}/libEGL.so.1
    ln -sf libGLESv1_CM.so.1.1.0 ${D}${libdir}/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1.1.0 ${D}${libdir}/libGLESv1_CM.so
    ln -sf libGLESv2.so.2.0.0 ${D}${libdir}/libGLESv2.so.2

    # Install extra NVIDIA libglvnd libraries
    install -m755 ${L4T_GL_LIBRARIES}/libGLX.so.0 ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libGLdispatch.so.0 ${D}${libdir}/
    ln -sf libGLX.so.0 ${D}${libdir}/libGLX.so
    ln -sf libGLdispatch.so.0 ${D}${libdir}/libGLdispatch.so

    # Install extra EGL NVIDIA libraries
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM_nvidia.so.1 ${D}${libdir}/
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv1_CM.so.1 ${D}${libdir}/
    install -m755 ${L4T_EGL_LIBRARIES}/libGLESv2_nvidia.so.2 ${D}${libdir}/

    # Install extra GL NVIDIA libraries
    install -m755 ${L4T_GL_LIBRARIES}/libGLX_nvidia.so.0 ${D}${libdir}/

    # Install libraries dependent on libglvnd libs
    install -m755 ${L4T_EGL_LIBRARIES}/libEGL_nvidia.so.0 ${D}${libdir}/

    install -m755 ${L4T_GL_LIBRARIES}/libnvidia-glsi.so.28.2.1 ${D}${libdir}/

    install -m755 ${L4T_GL_LIBRARIES}/libnvbuf_utils.so.1.0.0 ${D}${libdir}/
    ln -sf libnvbuf_utils.so.1.0.0 ${D}${libdir}/libnvbuf_utils.so.1
    ln -sf libnvbuf_utils.so.1.0.0 ${D}${libdir}/libnvbuf_utils.so

    install -m755 ${L4T_GL_LIBRARIES}/libnvddk_vic.so ${D}${libdir}/
    install -m755 ${L4T_GL_LIBRARIES}/libnvddk_2d_v2.so ${D}${libdir}/

    # nvcamera_daemon and argus_daemon have hard-coded path for this
    install -d ${D}${nonarch_libdir}/aarch64-linux-gnu/tegra-egl
    ln -sf ${libdir}/libEGL.so.1.0.0
${D}${nonarch_libdir}/aarch64-linux-gnu/tegra-egl/libEGL.so
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_libgles1-tegra += "\
    ${libdir}/libGLESv1* \
"

FILES_libgles2-tegra += "\
    ${libdir}/libGLESv2* \
"

FILES_libegl-tegra += "\
    ${libdir}/libEGL* \
    ${nonarch_libdir}/aarch64-linux-gnu/tegra-egl/libEGL.so \
"

FILES_libgl-tegra += "\
    ${libdir}/libGL.* \
    ${libdir}/libGLX* \
    ${libdir}/libGLdispatch.so* \
    ${libdir}/libnvidia-glsi.so.28.2.1 \
    ${libdir}/libnvbuf_utils.so* \
    ${libdir}/libnvddk_vic.so  \
    ${libdir}/libnvddk_2d_v2.so \
"

INSANE_SKIP_${PN} = "already-stripped"
INSANE_SKIP_libegl-tegra = "ldflags dev-so"
INSANE_SKIP_libgles1-tegra = "ldflags dev-so"
INSANE_SKIP_libgles2-tegra = "ldflags"
INSANE_SKIP_libgl-tegra = "ldflags dev-so textrel"

RREPLACES_libgl-tegra = "libgl-mesa"
RREPLACES_libegl-tegra = "libegl-mesa"
RREPLACES_libgles1-tegra = "libgles1-mesa"
RREPLACES_libgles2-tegra = "libgles2-mesa"

RCONFLICTS_libgl-tegra = "libgl-mesa"
RCONFLICTS_libegl-tegra = "libegl-mesa"
RCONFLICTS_libgles1-tegra = "libgles1-mesa"
RCONFLICTS_libgles2-tegra = "libgles2-mesa"

RPROVIDES_libgl-tegra += "gl-proprietary libgl libgl-mesa"
RPROVIDES_libegl-tegra += "libegl libegl-mesa"
RPROVIDES_libgles2-tegra += "libgles2 libgles2-tegra"
RPROVIDES_libgles1-tegra += "libgles1 libgles1-tegra"


PRIVATE_LIBS = "libGL.so.1 libEGL.so.1 libGLESv2.so.2 libGLESv1_CM.so.1"

On Tue, Mar 5, 2019 at 12:06 PM Burton, Ross <ross.burton@intel.com> wrote:
>
> That is horrible and they should be ashamed.  Can you share the
> complete recipe, as this *should* be a fairly trivial switcharoony.
>
> Ross
>
> On Tue, 5 Mar 2019 at 11:00, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> >
> > HI Ross
> > On Tue, Mar 5, 2019 at 11:58 AM Burton, Ross <ross.burton@intel.com> wrote:
> > >
> > > Does they literally just provide a libgl.so and no headers, etc?
> >
> > It provides:
> >
> > /usr/lib/libGL.so.1.2.0
> > /usr/lib/libGL.so.1
> >
> >
> > >
> > > Ross
> > >
> > > On Fri, 1 Mar 2019 at 11:29, Ricardo Ribalda Delgado
> > > <ricardo.ribalda@gmail.com> wrote:
> > > >
> > > > Hello
> > > >
> > > > I have a build system that supports some aarch64 machines. For most of
> > > > the them, the only difference is the kernel configuration, kernel
> > > > version.
> > > >
> > > > I am using multiconfig on my build server and the build goes really
> > > > fast thanks to all the shared binaries/artifacts.
> > > >
> > > > But I have a problem adding a new machine. This machine is also
> > > > aarch64, with a special kernel (nothing new here), but in this case
> > > > the vendor provides a binary .so for libgl that is required to get
> > > > hardware acceleation.
> > > >
> > > > I could .bbappend mesa and on the installation part replace libgl with
> > > > the new .so. But then everything that depends on mesa needs to be
> > > > rebuilt for that machine and I could not use multiconfig.
> > > >
> > > > Instead I have created a new recipe: mesa-gl-replace.bb that has the
> > > > file. This breakes completely the design of OE, but works.
> > > >
> > > > Some snipsets of the "magic" to make it work:
> > > >
> > > > #Force that the version is allways higher than the one from mesa:
> > > > PE = "5"
> > > >
> > > > #Rprovide the same as mesa
> > > > RPROVIDES_libgl-mesa += "libgl"
> > > >
> > > > #Do not overwrite pkgdata of mesa
> > > > PACKAGEFUNCS_append = " rm_pkgdata_runtime"
> > > > rm_pkgdata_runtime() {
> > > > rm -rf ${WORKDIR}/pkgdata/runtime/*
> > > > rm -rf ${WORKDIR}/pkgdata/shlibs2/*
> > > > }
> > > >
> > > > #Keep this on machine
> > > > PACKAGE_ARCH = "${MACHINE_ARCH}"
> > > >
> > > > #Make sure we are not saved as providers for libgl
> > > > PRIVATE_LIBS = "libGL.so.1"
> > > >
> > > > #Avoid sanity checks
> > > > read_subpackage_metadata () {
> > > > }
> > > >
> > > >
> > > > If your eyes have not fallen as this point, this means you have a lot
> > > > of tolerance for crappy code, congrats :)
> > > >
> > > > Now the question. Is there a better way to do this?
> > > >
> > > > PS: I already tried and failed with update_alternatives
> > > >
> > > >
> > > > Best regards!
> > > >
> > > >
> > > > --
> > > > Ricardo Ribalda
> > > > --
> > > > _______________________________________________
> > > > Openembedded-core mailing list
> > > > Openembedded-core@lists.openembedded.org
> > > > http://lists.openembedded.org/mailman/listinfo/openembedded-core
> >
> >
> >
> > --
> > Ricardo Ribalda



-- 
Ricardo Ribalda

