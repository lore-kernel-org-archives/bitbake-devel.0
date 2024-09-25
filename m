Return-Path: <brennan.coslett@bluerivertech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5891CCF9FA
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 21:38:01 +0000 (UTC)
Subject: URL encoding/decoding bug with files like "serialgetty@.service" or "sshd@.service" with archiver.bbclass #bitbake #kirkstone #poky
To: bitbake-devel@lists.openembedded.org
From: "Brennan Coslett" <brennan.coslett@bluerivertech.com>
X-Originating-Location: Denver, Colorado, US (165.225.11.61)
X-Originating-Platform: Linux Chrome 129
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 14:37:58 -0700
Message-ID: <bhfQ.1727300278439114446.Ff3Z@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="lia5g1rdlS2qKsP4Hb0u"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 21:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16602

--lia5g1rdlS2qKsP4Hb0u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey All,

I believe there is a bug with how bitbake handles systemd template files wh=
en archiving source, as the files are ending up in the rootfs. I was workin=
g on getting a script working to package up the tmp/deploy/source directory=
 and noticed that while the archiver was creating tmp/deploy/sources/aarch6=
4-shasta-linux/systemd-serialgetty-1.0-r5/ there wasn't anything inside it.=
 I think this is the base case for the bug as it has a SRC_URI of "file://s=
erial-getty@.service" vs some of the other packages which include these tem=
plate systemd files that end in @.service contain a ton of other files (I v=
erified the same issue shows up with openssh).

I assume that it will happen with all of these files:
```
$ find layers/ meta-* -name '*@*'
layers/meta-openembedded/meta-networking/recipes-support/nuttcp/nuttcp/nutt=
cp@.service
layers/meta-openembedded/meta-networking/recipes-support/openvpn/openvpn/op=
envpn@.service
layers/poky/meta/recipes-connectivity/openssh/openssh/sshd@.service
layers/poky/meta/recipes-connectivity/dhcpcd/files/dhcpcd@.service
layers/poky/meta/recipes-connectivity/ppp/ppp/ppp@.service
layers/poky/meta/recipes-core/dropbear/dropbear/dropbear@.service
layers/poky/meta/recipes-core/systemd/systemd-serialgetty/serial-getty@.ser=
vice
```

I was able to add some additional debug prints in archiver.bbclass and trie=
d to dig further but the insides of `fetch2` were a bit over my head.
```
diff --git a/meta/classes/archiver.bbclass b/meta/classes/archiver.bbclass
index 4a5865d7b5..daf7b4605b 100644
--- a/meta/classes/archiver.bbclass
+++ b/meta/classes/archiver.bbclass
@@ -181,6 +181,7 @@ python do_ar_original() {
ar_outdir =3D d.getVar('ARCHIVER_OUTDIR')
bb.note('Archiving the original source...')
urls =3D d.getVar("SRC_URI").split()
+ =C2=A0 =C2=A0bb.debug(1, "BRENNAN full SRC_URI %s" % urls)
# destsuffix (git fetcher) and subdir (everything else) are allowed to be
# absolute paths (for example, destsuffix=3D${S}/foobar).
# That messes with unpacking inside our tmpdir below, because the fetchers
@@ -198,7 +199,7 @@ python do_ar_original() {
del decoded[5][param]
encoded =3D bb.fetch2.encodeurl(decoded)
urls[i] =3D encoded
-
+ =C2=A0 =C2=A0bb.debug(1, "BRENNAN %s" % urls)
# Cleanup SRC_URI before call bb.fetch2.Fetch() since now SRC_URI is in the
# variable "urls", otherwise there might be errors like:
# The SRCREV_FORMAT variable must be set when multiple SCMs are used
```

This was tested with kirkstone, (this commit specifically e938b18b5342bd28e=
adb44ad39dbf1f5cf5be09b):
```
DEBUG: systemd-serialgetty-1.0-r5 do_ar_original: BRENNAN full SRC_URI ['fi=
le://serial-getty@.service']
DEBUG: systemd-serialgetty-1.0-r5 do_ar_original: BRENNAN ['file://.service=
']
```
It then can't find that file and so then the archiver doesn't package anyth=
ing up.

Hopefully bitbake-devel is the right mailing list for folks with more knowl=
edge of this stuff?

Thanks,
Brennan Coslett

--lia5g1rdlS2qKsP4Hb0u
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hey All,</div>
<div><br />I believe there is a bug with how bitbake handles systemd templa=
te files when archiving source, as the files are ending up in the rootfs. I=
 was working on getting a script working to package up the tmp/deploy/sourc=
e directory and noticed that while the archiver was creating tmp/deploy/sou=
rces/aarch64-shasta-linux/systemd-serialgetty-1.0-r5/ there wasn't anything=
 inside it. I think this is the base case for the bug as it has a SRC_URI o=
f "file://serial-getty@.service" vs some of the other packages which includ=
e these template systemd files that end in @.service contain a ton of other=
 files (I verified the same issue shows up with openssh).<br /><br />I assu=
me that it will happen with all of these files:<br />```</div>
<div>$ find layers/ meta-* -name '*@*'<br />layers/meta-openembedded/meta-n=
etworking/recipes-support/nuttcp/nuttcp/nuttcp@.service<br />layers/meta-op=
enembedded/meta-networking/recipes-support/openvpn/openvpn/openvpn@.service=
<br />layers/poky/meta/recipes-connectivity/openssh/openssh/sshd@.service<b=
r />layers/poky/meta/recipes-connectivity/dhcpcd/files/dhcpcd@.service<br /=
>layers/poky/meta/recipes-connectivity/ppp/ppp/ppp@.service<br />layers/pok=
y/meta/recipes-core/dropbear/dropbear/dropbear@.service<br />layers/poky/me=
ta/recipes-core/systemd/systemd-serialgetty/serial-getty@.service<br />```<=
br /><br />I was able to add some additional debug prints in archiver.bbcla=
ss and tried to dig further but the insides of `fetch2` were a bit over my =
head.<br />```</div>
<div>diff --git a/meta/classes/archiver.bbclass b/meta/classes/archiver.bbc=
lass<br />index 4a5865d7b5..daf7b4605b 100644<br />--- a/meta/classes/archi=
ver.bbclass<br />+++ b/meta/classes/archiver.bbclass<br />@@ -181,6 +181,7 =
@@ python do_ar_original() {<br />&nbsp; &nbsp; &nbsp;ar_outdir =3D d.getVa=
r('ARCHIVER_OUTDIR')<br />&nbsp; &nbsp; &nbsp;bb.note('Archiving the origin=
al source...')<br />&nbsp; &nbsp; &nbsp;urls =3D d.getVar("SRC_URI").split(=
)<br />+ &nbsp; &nbsp;bb.debug(1, "BRENNAN full SRC_URI %s" % urls)<br />&n=
bsp; &nbsp; &nbsp;# destsuffix (git fetcher) and subdir (everything else) a=
re allowed to be<br />&nbsp; &nbsp; &nbsp;# absolute paths (for example, de=
stsuffix=3D${S}/foobar).<br />&nbsp; &nbsp; &nbsp;# That messes with unpack=
ing inside our tmpdir below, because the fetchers<br />@@ -198,7 +199,7 @@ =
python do_ar_original() {<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;del decoded[5][param]<br />&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;encoded =3D bb.fetch2.encodeurl(decoded)<br />&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;urls[i] =3D encoded<br />-<br />+ &nbsp; &nbsp;bb.debug(1, "BRENNA=
N %s" % urls)<br />&nbsp; &nbsp; &nbsp;# Cleanup SRC_URI before call bb.fet=
ch2.Fetch() since now SRC_URI is in the<br />&nbsp; &nbsp; &nbsp;# variable=
 "urls", otherwise there might be errors like:<br />&nbsp; &nbsp; &nbsp;# T=
he SRCREV_FORMAT variable must be set when multiple SCMs are used<br />```<=
/div>
<div>&nbsp;</div>
<div>This was tested with kirkstone, (this commit specifically e938b18b5342=
bd28eadb44ad39dbf1f5cf5be09b):<br />```<br />&nbsp; &nbsp; &nbsp; &nbsp; DE=
BUG: systemd-serialgetty-1.0-r5 do_ar_original: BRENNAN full SRC_URI ['file=
://serial-getty@.service']<br />&nbsp; &nbsp; &nbsp; &nbsp; DEBUG: systemd-=
serialgetty-1.0-r5 do_ar_original: BRENNAN ['file://.service']<br />```</di=
v>
<div>It then can't find that file and so then the archiver doesn't package =
anything up.</div>
<div>&nbsp;</div>
<div>Hopefully bitbake-devel is the right mailing list for folks with more =
knowledge of this stuff?</div>
<div>&nbsp;</div>
<div>Thanks,<br />Brennan Coslett</div>

--lia5g1rdlS2qKsP4Hb0u--

