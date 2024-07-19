Return-Path: <andrii.sosiuk@seco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3701BC3DA5D
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 10:13:04 +0000 (UTC)
Subject: Bitbake does not perform to unpack tarball after second and other downloads for PREMIRRORs and MIRRORS 
To: bitbake-devel@lists.openembedded.org
From: andrii.sosiuk@seco.com
X-Originating-Location: Grosshaslach, Bavaria, DE (176.95.71.126)
X-Originating-Platform: Windows Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 19 Jul 2024 03:13:01 -0700
Message-ID: <9TpF.1721383981109709443.Rgoj@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="alCXst4wV5Iw4oKLXDtt"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jul 2024 10:13:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16430

--alCXst4wV5Iw4oKLXDtt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All.

I've encountered a bug, but I'm unable to report it directly as only regist=
ered users can create bug reports on Yocto Project's Bugzilla.
Therefore, I'm raising the issue here to see if anyone else has experienced=
 this problem.

The bug pertains to the use of MREMIRROR in a project setup where multiple =
source code tarballs are linked for a recipe.
Bitbake is designed to download and untar the tarball from the first provid=
ed link.
If there's an issue with this tarball=E2=80=94for instance, if the required=
 revision is missing=E2=80=94Bitbake then attempts to download the tarball =
from the next link.
However, it fails to untar this second tarball, leading to subsequent check=
s being incorrectly performed on outdated data from the first tarball since=
 the untar step is skipped.
As a result, even if the second tarball has the correct revision, the check=
s fail.

This problem can be observed in the fetch log file, where the fetcher uses =
wget followed by a tar command for the first link.
In contrast, for the second link, after wget, it bypasses the tar step and =
proceeds directly to performing git checks.

Is anyone else facing this issue, or does anyone have insights on a possibl=
e workaround or an instruction how to create a bug report?

Thanks, in advance.

DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t 2=
 -T 30 --passive-ftp --no-check-certificate -O /usr/src/packages/git2_code.=
qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://su=
pport.garz-fricke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.g=
z'

DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D"unix:path=3D/run/user/58604/bus"; =C2=A0/usr/bin/env wget -t 2 -T 30 --=
passive-ftp --no-check-certificate -O /usr/src/packages/git2_code.qt.io.qt.=
qtvirtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://support.gar=
z-fricke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz' --prog=
ress=3Ddot -v

--2024-07-19 08:45:38-- https://support.garz-fricke.com/mirror/git2_code.qt=
.io.qt.qtvirtualkeyboard.git.tar.gz

Resolving support.garz-fricke.com (support.garz-fricke.com)... 212.53.188.8=
, 2a00:1f78:cd:6::19e

Connecting to support.garz-fricke.com (support.garz-fricke.com)|212.53.188.=
8|:443... connected.

HTTP request sent, awaiting response... 200 OK

Length: 19921396 (19M) [application/x-gzip]

Saving to: =E2=80=98/usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.=
git.tar.gz.tmp=E2=80=99

2024-07-19 08:45:39 (27.0 MB/s) - =E2=80=98/usr/src/packages/git2_code.qt.i=
o.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99 saved [19921396/19921396]

DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D"unix:path=3D/run/user/58604/bus"; tar -xzf /usr/src/packages/git2_code.=
qt.io.qt.qtvirtualkeyboard.git.tar.gz' in /usr/src/packages//git2/code.qt.i=
o.qt.qtvirtualkeyboard.git

DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D"unix:path=3D/run/user/58604/bus"; git -c core.fsyncobjectfiles=3D0 bran=
ch --contains 7b90415c58dd02c682a9ba317f273d7b3398ff88 --list 5.15.2 2> /de=
v/null | wc -l' in /usr/src/packages//git2/code.qt.io.qt.qtvirtualkeyboard.=
git

=E2=80=A6=E2=80=A6

DEBUG: Mirror fetch failure for url https://support.garz-fricke.com/mirror/=
git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz (original url: git://code.q=
t.io/qt/qtvirtualkeyboard.git;name=3Dqtvirtualkeyboard;branch=3D5.15.2;prot=
ocol=3Dgit)

DEBUG: Fetcher failure: Unable to find revision 7b90415c58dd02c682a9ba317f2=
73d7b3398ff88 in branch 5.15.2 even from upstream

=E2=80=A6..

DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t 2=
 -T 30 --passive-ftp --no-check-certificate -O /usr/src/packages/git2_code.=
qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://su=
pport.garz-fricke.com/mirror/archive1/git2_code.qt.io.qt.qtvirtualkeyboard.=
git.tar.gz'

DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D"unix:path=3D/run/user/58604/bus"; /usr/bin/env wget -t 2 -T 30 --passiv=
e-ftp --no-check-certificate -O /usr/src/packages/git2_code.qt.io.qt.qtvirt=
ualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://support.garz-fric=
ke.com/mirror/archive1/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz' --p=
rogress=3Ddot -v

--2024-07-19 08:45:40-- https://support.garz-fricke.com/mirror/archive1/git=
2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz

Resolving support.garz-fricke.com (support.garz-fricke.com)... 212.53.188.8=
, 2a00:1f78:cd:6::19e

Connecting to support.garz-fricke.com (support.garz-fricke.com)|212.53.188.=
8|:443... connected.

HTTP request sent, awaiting response... 200 OK

Length: 20875043 (20M) [application/x-gzip]

Saving to: =E2=80=98/usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.=
git.tar.gz.tmp=E2=80=99

2024-07-19 08:45:41 (28.2 MB/s) - =E2=80=98/usr/src/packages/git2_code.qt.i=
o.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99 saved [20875043/20875043]

DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D"unix:path=3D/run/user/58604/bus"; git -c core.fsyncobjectfiles=3D0 bran=
ch --contains 7b90415c58dd02c682a9ba317f273d7b3398ff88 --list 5.15.2 2> /de=
v/null | wc -l' in /usr/src/packages//git2/code.qt.io.qt.qtvirtualkeyboard.=
git

--alCXst4wV5Iw4oKLXDtt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<p><span style=3D"font-family: Urbanist; color: black;">Hi All.<br/><br/></=
span>I&#39;ve encountered a bug, but I&#39;m unable to report it directly a=
s only registered users can create bug reports on Yocto Project&#39;s Bugzi=
lla. <br/>Therefore, I&#39;m raising the issue here to see if anyone else h=
as experienced this problem.</p>
<p>The bug pertains to the use of MREMIRROR in a project setup where multip=
le source code tarballs are linked for a recipe. <br/>Bitbake is designed t=
o download and untar the tarball from the first provided link. <br/>If ther=
e&#39;s an issue with this tarball=E2=80=94for instance, if the required re=
vision is missing=E2=80=94Bitbake then attempts to download the tarball fro=
m the next link. <br/>However, it fails to untar this second tarball, leadi=
ng to subsequent checks being incorrectly performed on outdated data from t=
he first tarball since the untar step is skipped. <br/>As a result, even if=
 the second tarball has the correct revision, the checks fail.</p>
<p>This problem can be observed in the fetch log file, where the fetcher us=
es wget followed by a tar command for the first link. <br/>In contrast, for=
 the second link, after wget, it bypasses the tar step and proceeds directl=
y to performing git checks.</p>
<p>Is anyone else facing this issue, or does anyone have insights on a poss=
ible workaround or an instruction how to create a bug report?<br/><br/>Than=
ks, in advance.</p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=C2=A0</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;"><br/>DEBUG: Fetcher accessed the network wit=
h the command /usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certifi=
cate -O /usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.t=
mp -P /usr/src/packages/ &#39;https://support.garz-fricke.com/mirror/git2_c=
ode.qt.io.qt.qtvirtualkeyboard.git.tar.gz&#39;</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Running export PSEUDO_DISABLED=3D1; e=
xport DBUS_SESSION_BUS_ADDRESS=3D&#34;unix:path=3D/run/user/58604/bus&#34;;=
 =C2=A0/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate -O=
 /usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /=
usr/src/packages/ &#39;https://support.garz-fricke.com/mirror/git2_code.qt.=
io.qt.qtvirtualkeyboard.git.tar.gz&#39; --progress=3Ddot -v</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">--2024-07-19 08:45:38--=C2=A0 <a href=3D"htt=
ps://support.garz-fricke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyboard.gi=
t.tar.gz">https://support.garz-fricke.com/mirror/git2_code.qt.io.qt.qtvirtu=
alkeyboard.git.tar.gz</a></span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Resolving support.garz-fricke.com (support.g=
arz-fricke.com)... 212.53.188.8, 2a00:1f78:cd:6::19e</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Connecting to support.garz-fricke.com (suppo=
rt.garz-fricke.com)|212.53.188.8|:443... connected.</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">HTTP request sent, awaiting response... 200 =
OK</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Length: 19921396 (19M) [application/x-gzip]<=
/span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Saving to: =E2=80=98/usr/src/packages/git2_c=
ode.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=C2=A0</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">2024-07-19 08:45:39 (27.0 MB/s) - =E2=80=98/=
usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=
=99 saved [19921396/19921396]</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=C2=A0</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Running &#39;export PSEUDO_DISABLED=
=3D1; export DBUS_SESSION_BUS_ADDRESS=3D&#34;unix:path=3D/run/user/58604/bu=
s&#34;; tar -xzf /usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git=
.tar.gz&#39; in /usr/src/packages//git2/code.qt.io.qt.qtvirtualkeyboard.git=
</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Running &#39;export PSEUDO_DISABLED=
=3D1; export DBUS_SESSION_BUS_ADDRESS=3D&#34;unix:path=3D/run/user/58604/bu=
s&#34;; git -c core.fsyncobjectfiles=3D0 branch --contains 7b90415c58dd02c6=
82a9ba317f273d7b3398ff88 --list 5.15.2 2&gt; /dev/null | wc -l&#39; in /usr=
/src/packages//git2/code.qt.io.qt.qtvirtualkeyboard.git</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=E2=80=A6=E2=80=A6</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Mirror fetch failure for url <a href=
=3D"https://support.garz-fricke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyb=
oard.git.tar.gz">https://support.garz-fricke.com/mirror/git2_code.qt.io.qt.=
qtvirtualkeyboard.git.tar.gz</a> (original url: git://code.qt.io/qt/qtvirtu=
alkeyboard.git;name=3Dqtvirtualkeyboard;branch=3D5.15.2;protocol=3Dgit)</sp=
an></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Fetcher failure: Unable to find revis=
ion 7b90415c58dd02c682a9ba317f273d7b3398ff88 in branch 5.15.2 even from ups=
tream</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=E2=80=A6..</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Fetcher accessed the network with the=
 command /usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate =
-O /usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P=
 /usr/src/packages/ &#39;https://support.garz-fricke.com/mirror/archive1/gi=
t2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz&#39;</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Running export PSEUDO_DISABLED=3D1; e=
xport DBUS_SESSION_BUS_ADDRESS=3D&#34;unix:path=3D/run/user/58604/bus&#34;;=
 /usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate -O /usr/=
src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /usr/sr=
c/packages/ &#39;https://support.garz-fricke.com/mirror/archive1/git2_code.=
qt.io.qt.qtvirtualkeyboard.git.tar.gz&#39; --progress=3Ddot -v</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">--2024-07-19 08:45:40--=C2=A0 <a href=3D"htt=
ps://support.garz-fricke.com/mirror/archive1/git2_code.qt.io.qt.qtvirtualke=
yboard.git.tar.gz">https://support.garz-fricke.com/mirror/archive1/git2_cod=
e.qt.io.qt.qtvirtualkeyboard.git.tar.gz</a></span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Resolving support.garz-fricke.com (support.g=
arz-fricke.com)... 212.53.188.8, 2a00:1f78:cd:6::19e</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Connecting to support.garz-fricke.com (suppo=
rt.garz-fricke.com)|212.53.188.8|:443... connected.</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">HTTP request sent, awaiting response... 200 =
OK</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Length: 20875043 (20M) [application/x-gzip]<=
/span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">Saving to: =E2=80=98/usr/src/packages/git2_c=
ode.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=C2=A0</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">2024-07-19 08:45:41 (28.2 MB/s) - =E2=80=98/=
usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=
=99 saved [20875043/20875043]</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">=C2=A0</span></p>
<p class=3D"DefangedMsoNormal" style=3D"margin:0px;"><span style=3D"font-fa=
mily: Urbanist; color: black;">DEBUG: Running &#39;export PSEUDO_DISABLED=
=3D1; export DBUS_SESSION_BUS_ADDRESS=3D&#34;unix:path=3D/run/user/58604/bu=
s&#34;; git -c core.fsyncobjectfiles=3D0 branch --contains 7b90415c58dd02c6=
82a9ba317f273d7b3398ff88 --list 5.15.2 2&gt; /dev/null | wc -l&#39; in /usr=
/src/packages//git2/code.qt.io.qt.qtvirtualkeyboard.git</span></p>
</div>

--alCXst4wV5Iw4oKLXDtt--

