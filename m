Return-Path: <merics@wirespring.com>
X-Greylist: delayed 412 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 16 Jan 2015 19:37:02 UTC
Received: from smtp145.dfw.emailsrvr.com (smtp145.dfw.emailsrvr.com
	[67.192.241.145])
	by mail.openembedded.org (Postfix) with ESMTP id B62FF722C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 19:37:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id
	8E193380293 for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 14:30:10 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp23.relay.dfw1a.emailsrvr.com (Authenticated sender:
	merics-AT-wirespring.com) with ESMTPSA id 5F38F38028E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 14:30:10 -0500 (EST)
X-Sender-Id: merics@wirespring.com
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
	[209.85.192.178]) (using TLSv1 with cipher RC4-SHA)
	by 0.0.0.0:587 (trex/5.4.2); Fri, 16 Jan 2015 19:30:10 GMT
Received: by mail-pd0-f178.google.com with SMTP id r10so24357288pdi.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 11:30:09 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.66.102.1 with SMTP id fk1mr25491194pab.16.1421436609850;
	Fri, 16 Jan 2015 11:30:09 -0800 (PST)
Received: by 10.66.84.170 with HTTP; Fri, 16 Jan 2015 11:30:09 -0800 (PST)
Date: Fri, 16 Jan 2015 21:30:09 +0200
Message-ID: <CAHwPOGvszHu1LbioEyXBZEbpUJ4K2Fv78Tkdpjki7PHsJzcdnQ@mail.gmail.com>
From: Meric Sentunali <merics@wirespring.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 29 Jan 2015 22:13:57 +0000
Subject: [PATCH] add basic branch support to fetch2/hg
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
X-List-Received-Date: Fri, 16 Jan 2015 19:37:11 -0000
Content-Type: multipart/alternative; boundary=047d7bf18b1c337666050cca0041

--047d7bf18b1c337666050cca0041
Content-Type: text/plain; charset=UTF-8

following patch adds basic support to make AUTOREV work for a specific
branch for mercurial.

Signed-off-by: Meric Sentunali <merics@wirespring.com>
---
 bitbake/lib/bb/fetch2/hg.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 5760fcd..ef00729 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -51,6 +51,7 @@ class Hg(FetchMethod):
             raise MissingParameterError('module', ud.url)

         ud.module = ud.parm["module"]
+        ud.branch = ud.parm.get('branch', 'default')

         # Create paths to mercurial checkouts
         relpath = self._strip_leading_slashes(ud.path)
@@ -98,7 +99,7 @@ class Hg(FetchMethod):
                 hgroot = ud.user + "@" + host + ud.path

         if command == "info":
-            return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot,
ud.module)
+            return "%s identify -i -r %s %s://%s/%s" % (basecmd,
ud.branch, proto, hgroot, ud.module)

         options = [];

@@ -113,7 +114,7 @@ class Hg(FetchMethod):
             if ud.user and ud.pswd:
                 cmd = "%s --config auth.default.prefix=* --config
auth.default.username=%s --config auth.default.password=%s --config
\"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user,
ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
             else:
-                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, "
".join(options), proto, hgroot, ud.module, ud.module)
+                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, "
".join(options), proto, hgroot, ud.module, ud.module)
         elif command == "pull":
             # do not pass options list; limiting pull to rev causes the
local
             # repo not to contain it and immediately following "update"
command
-- 
2.1.0

--047d7bf18b1c337666050cca0041
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">following patch adds basic support to make AUTOREV work fo=
r a specific branch for mercurial.<div><br></div><div><div>Signed-off-by: M=
eric Sentunali &lt;<a href=3D"mailto:merics@wirespring.com">merics@wirespri=
ng.com</a>&gt;</div><div>---</div><div>=C2=A0bitbake/lib/bb/fetch2/hg.py | =
5 +++--</div><div>=C2=A01 file changed, 3 insertions(+), 2 deletions(-)</di=
v><div><br></div><div>diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/li=
b/bb/fetch2/hg.py</div><div>index 5760fcd..ef00729 100644</div><div>--- a/b=
itbake/lib/bb/fetch2/hg.py</div><div>+++ b/bitbake/lib/bb/fetch2/hg.py</div=
><div>@@ -51,6 +51,7 @@ class Hg(FetchMethod):</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise MissingParameterError(&#39;module&#39;=
, ud.url)</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.m=
odule =3D ud.parm[&quot;module&quot;]</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ud.branch =3D ud.parm.get(&#39;branch&#39;, &#39;default&#39;)</div><div=
>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create paths to mercu=
rial checkouts</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0relpath =3D self=
._strip_leading_slashes(ud.path)</div><div>@@ -98,7 +99,7 @@ class Hg(Fetch=
Method):</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0hgroot =3D ud.user + &quot;@&quot; + host + ud.path</div><div>=C2=A0<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if command =3D=3D &quot;info&qu=
ot;:</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;%s i=
dentify -i %s://%s/%s&quot; % (basecmd, proto, hgroot, ud.module)</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;%s identify -i -r =
%s %s://%s/%s&quot; % (basecmd, ud.branch, proto, hgroot, ud.module)</div><=
div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options =3D [];</div=
><div>=C2=A0</div><div>@@ -113,7 +114,7 @@ class Hg(FetchMethod):</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.user and ud.pswd:</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =
=3D &quot;%s --config auth.default.prefix=3D* --config auth.default.usernam=
e=3D%s --config auth.default.password=3D%s --config \&quot;auth.default.sch=
emes=3D%s\&quot; clone %s %s://%s/%s %s&quot; % (basecmd, ud.user, ud.pswd,=
 proto, &quot; &quot;.join(options), proto, hgroot, ud.module, ud.module)</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:</div><div>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D &quot;%s clo=
ne %s %s://%s/%s %s&quot; % (basecmd, &quot; &quot;.join(options), proto, h=
groot, ud.module, ud.module) =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D &quot;%s clone %s =
%s://%s/%s %s&quot; % (basecmd, &quot; &quot;.join(options), proto, hgroot,=
 ud.module, ud.module)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif com=
mand =3D=3D &quot;pull&quot;:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0# do not pass options list; limiting pull to rev causes the lo=
cal</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# repo not to=
 contain it and immediately following &quot;update&quot; command</div><div>=
--=C2=A0</div><div>2.1.0</div><div><br></div></div></div>

--047d7bf18b1c337666050cca0041--
