Subject: Backport fix for os.errno references in fetch2 (Thud)
To: bitbake-devel@lists.openembedded.org
From: "Daniel Dragomir" <Daniel.Dragomir@windriver.com>
X-Originating-Location: Galati, RO (5.13.234.136)
X-Originating-Platform: Linux Firefox 84
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 28 Jan 2021 15:48:33 -0800
Message-ID: <H2US.1611877713506764273.o6hn@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="LOFlfrXsVx2p0qVod40t"

--LOFlfrXsVx2p0qVod40t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers!

Can you please backport commit e74f80433e9a7e7ae7ec1472eb7387301d2dc816 ("=
bitbake: fetch2: Fix os.errno references") on Thud branch?

Don't know if Thud is still supported, but I see intermittent fetch failur=
es on Thud which were fixed with this patch (present starting with Warrior =
branch):

File: '..../poky/bitbake/lib/bb/fetch2/__init__.py', lineno: 1720, functio=
n: download
1716:
1717:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=
=A0=C2=A0=C2=A0=C2=A0 update_stamp(ud, self.d)
1718:
1719:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
cept IOError as e:
*** 1720:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if e.errno in [os.errno.ESTALE]:
1721:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.error("Stale Error Ob=
served %s." % u)
1722:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ChecksumError("Stale E=
rror Detected")
1723:
1724:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
cept BBFetchException as e:
Exception: AttributeError: module 'os' has no attribute 'errno'

Best regards!
Daniel

--LOFlfrXsVx2p0qVod40t
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers!<br /><br />Can you please backport commit e74f80433e9a7e=
7ae7ec1472eb7387301d2dc816 ("bitbake: fetch2: Fix os.errno references") on =
Thud branch?<br /><br />Don't know if Thud is still supported, but I see in=
termittent fetch failures on Thud which were fixed with this patch (present=
 starting with Warrior branch):<br /><br />File: '..../poky/bitbake/lib/bb/=
fetch2/__init__.py', lineno: 1720, function: download<br />&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 1716:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1717:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; update_stamp(ud, self.d)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1718:<br />=
&nbsp;&nbsp;&nbsp;&nbsp; 1719:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; except IOError as e:<br />&nbsp; *** 1720:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if e.errno in [os.errno.ESTALE]:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
721:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logger.error("Stale Error Obser=
ved %s." % u)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1722:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; raise ChecksumError("Stale Error Detected")<br />&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1723:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1724:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; except BBFe=
tchException as e:<br />Exception: AttributeError: module 'os' has no attri=
bute 'errno'<br /><br />Best regards!<br />Daniel

--LOFlfrXsVx2p0qVod40t--
