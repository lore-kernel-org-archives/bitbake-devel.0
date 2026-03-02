Return-Path: <pedro.ms.ferreira@ctw.bmwgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC100E9B37E
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 16:54:16 +0000 (UTC)
Subject: Re: [PATCH] fetch2: avoid reuse download filenames
To: bitbake-devel@lists.openembedded.org
From: pedro.ms.ferreira@ctw.bmwgroup.com
X-Originating-Location: Porto, PT (213.205.68.220)
X-Originating-Platform: Linux Chrome 145
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 02 Mar 2026 08:54:15 -0800
References: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com> <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
In-Reply-To: <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
Message-ID: <1127752.1772470455842490403@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="plavj4w4xFSLooVdiwmn"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 16:54:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19099

--plavj4w4xFSLooVdiwmn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

This was detected internally when users modify source files and update
the hashes inside the recipes to match. Bitbake is allowing this operations
because it identifies a mismatch and renames it to procede with the downloa=
d.

I tested this locally with:

- Create a source file, for example, test_download.tar.gz
- Create a simple http server (python3 -m http.server 1212 )
- Create a small recipe, local_test.bb
------------------------------------------------------------------------
SUMMARY =3D "local test recipe"
DESCRIPTION =3D "Downloads and installs test files"
LICENSE =3D "CLOSED"

SRC_URI =3D "http://0.0.0.0:1212/test_download.tar.gz"

S =3D "${WORKDIR}"

SRC_URI[md5sum] =3D "12e597833772126eade44740570aab3c"
SRC_URI[sha256sum] =3D "f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4=
949f7de67fc87"

do_install() {
install -d ${D}/etc/test
install =C2=A0${S}/README.md -C ${D}/etc/test
}

FILES:${PN} =3D "/etc/test/README.md"

------------------------------------------------------------------------
- Run it: bitbake -C fetch local-test
- Modify source file
- Update the hash
- Run it: bitbake -C fetch local-test
- A warning is raised: WARNING: local-test-1.0-r0 do_fetch: Renaming /home/=
test/yocto-downloads/test_download.tar.gz to /home/test/yocto-downloads/tes=
t_download.tar.gz_bad-checksum_f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8=
156a3d4949f7de67fc87
- Bitbake continues the next steps with this new tarball.

Cheers.

--plavj4w4xFSLooVdiwmn
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Richard,</div>
<div>&nbsp;</div>
<div>This was detected internally when users modify source files and update=
</div>
<div>the hashes inside the recipes to match. Bitbake is allowing this opera=
tions</div>
<div>because it identifies a mismatch and renames it to procede with the do=
wnload.</div>
<div>&nbsp;</div>
<div>I tested this locally with:</div>
<div>&nbsp;</div>
<div>&nbsp;- Create a source file, for example, test_download.tar.gz</div>
<div>&nbsp;- Create a simple http server (python3 -m http.server 1212 )</di=
v>
<div>&nbsp;- Create a small recipe, local_test.bb</div>
<div>----------------------------------------------------------------------=
--</div>
<div>
<div>SUMMARY =3D "local test recipe"<br />DESCRIPTION =3D "Downloads and in=
stalls test files"<br />LICENSE =3D "CLOSED"</div>
<div>&nbsp;</div>
<div>SRC_URI =3D "http://0.0.0.0:1212/test_download.tar.gz"</div>
<div><br />S =3D "${WORKDIR}"</div>
<div>&nbsp;</div>
<div>SRC_URI[md5sum] =3D "12e597833772126eade44740570aab3c"<br />SRC_URI[sh=
a256sum] =3D "f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de67f=
c87"</div>
<div>&nbsp;</div>
<div>do_install() {<br />&nbsp; &nbsp; install -d ${D}/etc/test<br />&nbsp;=
 &nbsp; install &nbsp;${S}/README.md -C ${D}/etc/test<br />}</div>
<div>&nbsp;</div>
<div>FILES:${PN} =3D "/etc/test/README.md"</div>
<div>&nbsp;</div>
</div>
<div>----------------------------------------------------------------------=
--</div>
<div>&nbsp;- Run it: bitbake -C fetch local-test</div>
<div>&nbsp;- Modify source file</div>
<div>&nbsp;- Update the hash</div>
<div>&nbsp;- Run it: bitbake -C fetch local-test</div>
<div>&nbsp; &nbsp;- A warning is raised: WARNING: local-test-1.0-r0 do_fetc=
h: Renaming /home/test/yocto-downloads/test_download.tar.gz to /home/test/y=
octo-downloads/test_download.tar.gz_bad-checksum_f03e325aa451beda1b340a7ce0=
fcfd620b74c86e12b8156a3d4949f7de67fc87</div>
<div>&nbsp; - Bitbake continues the next steps with this new tarball.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Cheers.</div>

--plavj4w4xFSLooVdiwmn--

