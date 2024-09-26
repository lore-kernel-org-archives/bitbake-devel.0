Return-Path: <brennan.coslett@bluerivertech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F7CDE00F
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 14:57:47 +0000 (UTC)
Subject: Re: URL encoding/decoding bug with files like "serialgetty@.service" or "sshd@.service" with archiver.bbclass #poky #bitbake #kirkstone
To: bitbake-devel@lists.openembedded.org
From: "Brennan Coslett" <brennan.coslett@bluerivertech.com>
X-Originating-Location: Denver, Colorado, US (165.225.11.61)
X-Originating-Platform: Linux Chrome 129
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 07:57:38 -0700
References: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
In-Reply-To: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
Message-ID: <29158.1727362658714839430@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="UpEwERQ7CY0ISWuQjuFF"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 14:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16605

--UpEwERQ7CY0ISWuQjuFF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I think the bug is in `bb.fetch.decodeurl`, I just noticed it because of th=
e archiver.
@Alex if that means it should still move over to the oe-core list, let me k=
now and I can do that.

Steps to replicate:
1. Checkout poky master (just replicated with 8634e46b4040b6008410b6d77fecb=
5cbaec7e90e)
2. source oe-init-build-env
3. append the following to the auto-generated local.conf:
+ require conf/distro/include/init-manager-systemd.inc
+ INHERIT +=3D "archiver"
+ ARCHIVER_MODE[src] =3D "original"
4. Run "bitbake systemd-serialgetty", the source dir will be created but it=
 wont contain anything:
brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ ls tmp/deploy/so=
urces/x86_64-poky-linux/systemd-serialgetty-1.0-r0/
brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$

I think something in the regex inside the `decodeurl` function in `bitbake/=
lib/bb/fetch2/__init__.py` needs to change to stop it from
parsing out `<name>@` =C2=A0in `<name>@.service` into the `user` field or m=
aybe it needs additional logic inside that function when its a
local file to put the parsed out `user` group back into the `location` grou=
p? This appears to fix it but i'm not sure if this is actually valid,
if it is I can submit it as an actual patch. I think there should probably =
be a corresponding addition of a fetch test around these types of
files?

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index ddee4400bb..2ea834416b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -369,6 +369,11 @@ def decodeurl(url):
path =3D location[locidx:]
elif type.lower() =3D=3D 'file':
host =3D ""
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# parsing out a user doesn't make sense for
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# local files?
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if user:
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0location =3D "%s@%s" % (user, lo=
cation)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user =3D None
path =3D location
else:
host =3D location

I was able to see the `serialgetty@.service` file in the output folder:
brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ bitbake systemd-=
serialgetty
...
NOTE: Tasks Summary: Attempted 969 tasks of which 871 didn't need to be rer=
un and all succeeded.
Summary: There was 1 WARNING message.
brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ ls tmp/deploy/so=
urces/x86_64-poky-linux/systemd-serialgetty-1.0-r0/
serial-getty@.service

Thanks,
Brennan Coslett

--UpEwERQ7CY0ISWuQjuFF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>I think the bug is in `bb.fetch.decodeurl`, I just noticed it because =
of the archiver.<br />@Alex if that means it should still move over to the =
oe-core list, let me know and I can do that.</div>
<div>&nbsp;</div>
<div>Steps to replicate:<br />1. Checkout poky master (just replicated with=
 8634e46b4040b6008410b6d77fecb5cbaec7e90e)<br />2. source oe-init-build-env=
<br />3. append the following to the auto-generated local.conf:<br />&nbsp;=
 &nbsp; + require conf/distro/include/init-manager-systemd.inc<br />&nbsp; =
&nbsp; + INHERIT +=3D "archiver"<br />&nbsp; &nbsp; + ARCHIVER_MODE[src] =
=3D "original"<br />4. Run "bitbake systemd-serialgetty", the source dir wi=
ll be created but it wont contain anything:<br />&nbsp; &nbsp; brennan.cosl=
ett@lpgt-bcosl001:~/missing-source/poky/build$ ls tmp/deploy/sources/x86_64=
-poky-linux/systemd-serialgetty-1.0-r0/<br />&nbsp; &nbsp; brennan.coslett@=
lpgt-bcosl001:~/missing-source/poky/build$</div>
<div>&nbsp;</div>
<div>I think something in the regex inside the `decodeurl` function in `bit=
bake/lib/bb/fetch2/__init__.py` needs to change to stop it from<br />parsin=
g out `&lt;name&gt;@` &nbsp;in `&lt;name&gt;@.service` into the `user` fiel=
d or maybe it needs additional logic inside that function when its a<br />l=
ocal file to put the parsed out `user` group back into the `location` group=
? This appears to fix it but i'm not sure if this is actually valid,<br />i=
f it is I can submit it as an actual patch. I think there should probably b=
e a corresponding addition of a fetch test around these types of<br />files=
?</div>
<div>&nbsp;</div>
<div>diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2=
/__init__.py<br />index ddee4400bb..2ea834416b 100644<br />--- a/bitbake/li=
b/bb/fetch2/__init__.py<br />+++ b/bitbake/lib/bb/fetch2/__init__.py<br />@=
@ -369,6 +369,11 @@ def decodeurl(url):<br />&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;path =3D location[locidx:]<br />&nbsp; &nbsp; &nbsp;elif type.lower() =
=3D=3D 'file':<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;host =3D ""<br />+ &n=
bsp; &nbsp; &nbsp; &nbsp;# parsing out a user doesn't make sense for<br />+=
 &nbsp; &nbsp; &nbsp; &nbsp;# local files?<br />+ &nbsp; &nbsp; &nbsp; &nbs=
p;if user:<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;location =3D "%s=
@%s" % (user, location)<br />+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;use=
r =3D None<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;path =3D location<br />&n=
bsp; &nbsp; &nbsp;else:<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;host =3D loc=
ation</div>
<div>&nbsp;</div>
<div>I was able to see the `serialgetty@.service` file in the output folder=
:<br />&nbsp; &nbsp; brennan.coslett@lpgt-bcosl001:~/missing-source/poky/bu=
ild$ bitbake systemd-serialgetty<br />&nbsp; &nbsp; ...<br />&nbsp; &nbsp; =
NOTE: Tasks Summary: Attempted 969 tasks of which 871 didn't need to be rer=
un and all succeeded.<br />&nbsp; &nbsp; Summary: There was 1 WARNING messa=
ge.<br />&nbsp; &nbsp; brennan.coslett@lpgt-bcosl001:~/missing-source/poky/=
build$ ls tmp/deploy/sources/x86_64-poky-linux/systemd-serialgetty-1.0-r0/<=
br />&nbsp; &nbsp; serial-getty@.service</div>
<div>&nbsp;</div>
<div>Thanks,<br />Brennan Coslett</div>
</div>

--UpEwERQ7CY0ISWuQjuFF--

