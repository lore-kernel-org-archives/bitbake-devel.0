Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1TwafU-00040v-UJ
	for bitbake-devel@lists.openembedded.org;
	Sat, 19 Jan 2013 16:49:32 +0100
Received: by mail-wi0-f171.google.com with SMTP id hn14so5995220wib.16
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Jan 2013 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=INUcdPm8F0ShVUpia3xFG5Fm7p9u7EcTZzV62ZY2kas=;
	b=BkpeRv1y/6TjqJfnLGJRVewaHA4S2Yw3kKNuXCAs3FVVM9IUUHHUj/ac85EhcM6uEL
	M30RkBfCeLs59ZqQdAxNtY70UdVMOsKCFFH3ZgXry0lmy3gr8WmsedaXhO2l7VHOwnvy
	8U6jZzpuxY5vPaEdEjn8IfR0N5IJVGBK682ay8jd0EEWkBnRXSycgzOiL5pCxwk8B/el
	i5tvRET4B77WuJyivbqnZkX/ytDPZ7oyOYksKvWyYULe1hLwuTDvoLR/8Xwec/Xyf12x
	4SMbhZY2kz8AIdfzvgO7hEyyIt7+snmppS++eP2HtlSRuh6qswuHC9zS/UjjBbpwIPwb
	q6QQ==
MIME-Version: 1.0
X-Received: by 10.180.81.39 with SMTP id w7mr8538676wix.15.1358609630985; Sat,
	19 Jan 2013 07:33:50 -0800 (PST)
Received: by 10.227.132.205 with HTTP; Sat, 19 Jan 2013 07:33:50 -0800 (PST)
In-Reply-To: <CABcZANmiBe2hkn0s98j729wiEwicLRYuKtoL3NThEojKxE2tCw@mail.gmail.com>
References: <CAHUNapQHDYC7g4aJnPH5U784rywtX1AnwVkbY9e1RJrB5mPszg@mail.gmail.com>
	<CABcZANmiBe2hkn0s98j729wiEwicLRYuKtoL3NThEojKxE2tCw@mail.gmail.com>
Date: Sat, 19 Jan 2013 10:33:50 -0500
Message-ID: <CAHUNapQqhpyUanHfBrY11t4AdGqD+x92F=3gxMrcD77=c4Cs7g@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: task override
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
X-List-Received-Date: Sat, 19 Jan 2013 15:49:33 -0000
Content-Type: multipart/alternative; boundary=bcaec555503471810804d3a5f490

--bcaec555503471810804d3a5f490
Content-Type: text/plain; charset=ISO-8859-1

Hi Chris, thanks for your feedback.

On Fri, Jan 18, 2013 at 4:57 PM, Chris Larson <clarson@kergoth.com> wrote:
> Just override do_rootfs in your 'myimg' recipe and call it done.

I was afraid that's what you'd say. I'm obviously doing something wrong
somewhere because I can't seem to get the results I would like.

> Beyond that, a directory isn't a layer. You have to have conf/layer.conf
and
> add the layer to bblayers.conf for bitbake to see it as a layer.

:-) I cut it down to only show the relevant parts :-)

My goal is to write my own methods and procedures for creating file system
images. I would like to do this in a layer so as to not disturb the existing
image-creation routines which are provided. My understanding is that the
image creation work takes place in the "do_rootfs" task.

As a start, in order to prove to myself that my routines were completely
replacing the base ones, I thought that if I wrote an empty do_rootfs
routine in
my layer, I could run a build and essentially end up with nothing (or next
to
nothing) in the tmp/deploy/images directory. But this isn't the results I'm
seeing.

Here is my code:

meta-trevor/
|-- README
|-- classes
|   `-- twrootfs.bbclass
|           addtask rootfs
|           twrootfs_do_rootfs() {
|                   echo "rootfs from meta-trevor!"
|           }
|           EXPORT_FUNCTIONS do_rootfs
|-- conf
|   `-- layer.conf
|           BBPATH := "${BBPATH}:${LAYERDIR}"
|
|           BBFILES := "${BBFILES} ${LAYERDIR}/recipes-*/*/*.bb \
|                  ${LAYERDIR}/recipes-*/*/*.bbappend"
|
|           BBFILE_COLLECTIONS += "trevor"
|           BBFILE_PATTERN_trevor := "^${LAYERDIR}/"
|           BBFILE_PRIORITY_trevor = "6"
`-- recipes-core
    `-- images
        `-- bboverride.bb
                DESCRIPTION = "A small-ish image that starts with busybox,
but then adds as many of the 'real' programs as possible"

                IMAGE_INSTALL = "packagegroup-core-boot
${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL} \
                        trace-cmd bash util-linux coreutils vim-tiny
openssh procps grep iputils gzip bzip2 sed \
                        tar net-tools gawk findutils ncurses tzdata less bc
wget psmisc file"

                IMAGE_LINGUAS = " "

                LICENSE = "MIT"

                inherit core-image
                inherit twrootfs

                ROOTFS_POSTPROCESS_COMMAND += "remove_packaging_data_files
; "



Then, in my build area:

conf/
|-- bblayers.conf
|       # LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
|       # changes incompatibly
|       LCONF_VERSION = "6"
|
|       BBPATH = "${TOPDIR}"
|       BBFILES ?= ""
|
|       BBLAYERS ?= " \
|         /home/trevor/devel/yocto/git-method/poky/meta \
|         /home/trevor/devel/yocto/git-method/poky/meta-yocto \
|         /home/trevor/devel/yocto/git-method/poky/meta-yocto-bsp \
|
/home/trevor/devel/yocto/git-method/poky/meta-openembedded/meta-oe \
|         /home/trevor/devel/yocto/meta-trevor \
|         "
|       BBLAYERS_NON_REMOVABLE ?= " \
|         /home/trevor/devel/yocto/git-method/poky/meta \
|         /home/trevor/devel/yocto/git-method/poky/meta-yocto \
|         "
`-- local.conf
        BB_NUMBER_THREADS = "1"
        PARALLEL_MAKE = "-j 1"
        MACHINE = "qemux86"
        DL_DIR = "/home/trevor/devel/Downloads"
        DISTRO = "poky"
        PACKAGE_CLASSES = "package_ipk"
        EXTRA_IMAGE_FEATURES = "debug-tweaks ssh-server-openssh"
        USER_CLASSES = "buildstats image-mklibs image-prelink"
        PATCHRESOLVE = "noop"

        BB_DISKMON_DIRS = "\
                STOPTASKS,${TMPDIR},1G,100K \
                STOPTASKS,${DL_DIR},1G,100K \
                STOPTASKS,${SSTATE_DIR},1G,100K \
                ABORT,${TMPDIR},100M,1K \
                ABORT,${DL_DIR},100M,1K \
                ABORT,${SSTATE_DIR},100M,1K"

        CONF_VERSION = "1"

        BB_DANGLINGAPPENDS_WARNONLY = "yes"
        IMAGE_FSTYPES = "vmdk"
        IMAGE_ROOTFS_SIZE = "100000"

You might think my setting BB_NUMBER_THREADS and PARALLEL_MAKE to 1
is strange, but it makes it _so_ much easier to read the output logs when
running
bitbake with "-vvvD".

After performing a "bitbake -vvvD bboverride 2>&1 | tee build.log" I find
all the
regular suspects in my tmp/deploy/images directory. When I look through the
log file I see all the regular image-building commands taking place (e.g.
rootfs_ipk_do_rootfs etc.), and I don't find the "rootfs from meta-trevor"
that
I was expecting.

I realize that my inclusion of 'IMAGE_FSTYPES = "vmdk"' in my local.conf
might be suspect, but I assume the routines to build the vmdk are
"underneath"
the do_rootfs task. As such, if I really am replacing the base do_rootfs
with
my own (which does nothing) having this line in the configuration file
shouldn't
be kicking off any image-creation procedures (I would think).

Any and all help is much appreciated, thanks :-)

--bcaec555503471810804d3a5f490
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>Hi Chris, tha=
nks for your feedback.<br><br>On Fri, Jan 18, 2013 at 4:57 PM, Chris Larson=
 &lt;<a href=3D"mailto:clarson@kergoth.com">clarson@kergoth.com</a>&gt; wro=
te:<br>
&gt; Just override do_rootfs in your &#39;myimg&#39; recipe and call it don=
e.<br><br>I was afraid that&#39;s what you&#39;d say. I&#39;m obviously doi=
ng something wrong<br><span class=3D""></span><span class=3D""></span>somew=
here because I can&#39;t seem to get the results I would like.<br>
<br>&gt; Beyond that, a directory isn&#39;t a layer. You have to have conf/=
layer.conf and<br>&gt; add the layer to bblayers.conf for bitbake to see it=
 as a layer.<br><br>:-) I cut it down to only show the relevant parts :-)<b=
r>
<br>My goal is to write my own methods and procedures for creating file sys=
tem<br>images. I would like to do this in a layer so as to not disturb the =
existing<br>image-creation routines which are provided. My understanding is=
 that the<br>
image creation work takes place in the &quot;do_rootfs&quot; task.<br><br>A=
s a start, in order to prove to myself that my routines were completely<br>=
replacing the base ones, I thought that if I wrote an empty do_rootfs routi=
ne in<br>
my layer, I could run a build and essentially end up with nothing (or next =
to<br>nothing) in the tmp/deploy/images directory. But this isn&#39;t the r=
esults I&#39;m seeing.<br><br>Here is my code:<br><br>meta-trevor/<br>|-- R=
EADME<br>
|-- classes<br>| =A0 `-- twrootfs.bbclass<br>| =A0 =A0 =A0 =A0 =A0 addtask =
rootfs<br>| =A0 =A0 =A0 =A0 =A0 twrootfs_do_rootfs() {<br>| =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 echo &quot;rootfs from meta-trevor!&quot;<br>| =A0 =A0=
 =A0 =A0 =A0 }<br>| =A0 =A0 =A0 =A0 =A0 EXPORT_FUNCTIONS do_rootfs<br>
|-- conf<br>| =A0 `-- layer.conf<br>| =A0 =A0 =A0 =A0 =A0 BBPATH :=3D &quot=
;${BBPATH}:${LAYERDIR}&quot;<br>|<br>| =A0 =A0 =A0 =A0 =A0 BBFILES :=3D &qu=
ot;${BBFILES} ${LAYERDIR}/recipes-*/*/*.bb \<br>| =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0${LAYERDIR}/recipes-*/*/*.bbappend&quot;<br>
|<br>| =A0 =A0 =A0 =A0 =A0 BBFILE_COLLECTIONS +=3D &quot;trevor&quot;<br>| =
=A0 =A0 =A0 =A0 =A0 BBFILE_PATTERN_trevor :=3D &quot;^${LAYERDIR}/&quot;<br=
>| =A0 =A0 =A0 =A0 =A0 BBFILE_PRIORITY_trevor =3D &quot;6&quot;<br>`-- reci=
pes-core<br>=A0 =A0 `-- images<br>=A0 =A0 =A0 =A0 `-- <a href=3D"http://bbo=
verride.bb">bboverride.bb</a><br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DESCRIPTION =3D &quot;A small=
-ish image that starts with busybox, but then adds as many of the &#39;real=
&#39; programs as possible&quot;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 IMAGE_INSTALL =3D &quot;packagegroup-core-boot ${ROOTFS_PKGMAN=
AGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL} \<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 trace-cmd bas=
h util-linux coreutils vim-tiny openssh procps grep iputils gzip bzip2 sed =
\<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 tar net-=
tools gawk findutils ncurses tzdata less bc wget psmisc file&quot;<br><br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IMAGE_LINGUAS =3D &quot; &quo=
t;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LICENSE =3D &quot;M=
IT&quot;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inherit core-=
image<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inherit twrootfs<br>=
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ROOTFS_POSTPROCESS_COMMAN=
D +=3D &quot;remove_packaging_data_files ; &quot;<br>
<br><br><br></div>Then, in my build area:<br><br>conf/<br>|-- bblayers.conf=
<br>|=A0=A0=A0=A0=A0=A0 # LAYER_CONF_VERSION is increased each time build/c=
onf/bblayers.conf<br>|=A0=A0=A0=A0=A0=A0 # changes incompatibly<br>|=A0=A0=
=A0=A0=A0=A0 LCONF_VERSION =3D &quot;6&quot;<br>
|<br>|=A0=A0=A0=A0=A0=A0 BBPATH =3D &quot;${TOPDIR}&quot;<br>|=A0=A0=A0=A0=
=A0=A0 BBFILES ?=3D &quot;&quot;<br>|<br>|=A0=A0=A0=A0=A0=A0 BBLAYERS ?=3D =
&quot; \<br>|=A0=A0=A0=A0=A0=A0 =A0 /home/trevor/devel/yocto/git-method/pok=
y/meta \<br>|=A0=A0=A0=A0=A0=A0 =A0 /home/trevor/devel/yocto/git-method/pok=
y/meta-yocto \<br>
|=A0=A0=A0=A0=A0=A0 =A0 /home/trevor/devel/yocto/git-method/poky/meta-yocto=
-bsp \<br>|=A0=A0=A0=A0=A0=A0 =A0 /home/trevor/devel/yocto/git-method/poky/=
meta-openembedded/meta-oe \<br>|=A0=A0=A0=A0=A0=A0 =A0 /home/trevor/devel/y=
octo/meta-trevor \<br>|=A0=A0=A0=A0=A0=A0 =A0 &quot;<br>
|=A0=A0=A0=A0=A0=A0 BBLAYERS_NON_REMOVABLE ?=3D &quot; \<br>|=A0=A0=A0=A0=
=A0=A0 =A0 /home/trevor/devel/yocto/git-method/poky/meta \<br>|=A0=A0=A0=A0=
=A0=A0 =A0 /home/trevor/devel/yocto/git-method/poky/meta-yocto \<br>|=A0=A0=
=A0=A0=A0=A0 =A0 &quot;<br>`-- local.conf<br>=A0=A0=A0=A0=A0=A0=A0 BB_NUMBE=
R_THREADS =3D &quot;1&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 PARALLEL_MAKE =3D &quot;-j 1&quot;<br>=A0=A0=A0=A0=A0=
=A0=A0 MACHINE =3D &quot;qemux86&quot;<br>=A0=A0=A0=A0=A0=A0=A0 DL_DIR =3D =
&quot;/home/trevor/devel/Downloads&quot;<br>=A0=A0=A0=A0=A0=A0=A0 DISTRO =
=3D &quot;poky&quot;<br>=A0=A0=A0=A0=A0=A0=A0 PACKAGE_CLASSES =3D &quot;pac=
kage_ipk&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 EXTRA_IMAGE_FEATURES =3D &quot;debug-tweaks ssh-serve=
r-openssh&quot;<br>=A0=A0=A0=A0=A0=A0=A0 USER_CLASSES =3D &quot;buildstats =
image-mklibs image-prelink&quot;<br>=A0=A0=A0=A0=A0=A0=A0 PATCHRESOLVE =3D =
&quot;noop&quot;<br><br>=A0=A0=A0=A0=A0=A0=A0 BB_DISKMON_DIRS =3D &quot;\<b=
r>
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 STOPTASKS,${TMPDIR},1G,100K \<b=
r>=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 STOPTASKS,${DL_DIR},1G,100K \=
<br>=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 STOPTASKS,${SSTATE_DIR},1G,=
100K \<br>=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ABORT,${TMPDIR},100M,=
1K \<br>=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ABORT,${DL_DIR},100M,1K=
 \<br>
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ABORT,${SSTATE_DIR},100M,1K&quo=
t;<br><br>=A0=A0=A0=A0=A0=A0=A0 CONF_VERSION =3D &quot;1&quot;<br><br>=A0=
=A0=A0=A0=A0=A0=A0 BB_DANGLINGAPPENDS_WARNONLY =3D &quot;yes&quot;<br>=A0=
=A0=A0=A0=A0=A0=A0 IMAGE_FSTYPES =3D &quot;vmdk&quot;<br>=A0=A0=A0=A0=A0=A0=
=A0 IMAGE_ROOTFS_SIZE =3D &quot;100000&quot;<br>
<br></div>You might think my setting BB_NUMBER_THREADS and PARALLEL_MAKE to=
 1<br></div>is strange, but it makes it _so_ much easier to read the output=
 logs when running<br>bitbake with &quot;-vvvD&quot;.<br><br></div>After pe=
rforming a &quot;bitbake -vvvD bboverride 2&gt;&amp;1 | tee build.log&quot;=
 I find all the<br>
regular suspects in my tmp/deploy/images directory. When I look through the=
<br></div>log file I see all the regular image-building commands taking pla=
ce (e.g.<br>rootfs_ipk_do_rootfs etc.), and I don&#39;t find the &quot;root=
fs from meta-trevor&quot; that<br>
I was expecting.<br><br>I realize that my inclusion of &#39;IMAGE_FSTYPES =
=3D &quot;vmdk&quot;&#39; in my local.conf<br></div>might be suspect, but I=
 assume the routines to build the vmdk are &quot;underneath&quot;<br></div>
the do_rootfs task. As such, if I really am replacing the base do_rootfs wi=
th<br>my own (which does nothing) having this line in the configuration fil=
e shouldn&#39;t<br></div>be kicking off any image-creation procedures (I wo=
uld think).<br>
<br></div>Any and all help is much appreciated, thanks :-)<br></div>

--bcaec555503471810804d3a5f490--
