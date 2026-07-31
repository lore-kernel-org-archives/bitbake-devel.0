Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5732C5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 13:05:49 +0000 (UTC)
Subject: Re: [PATCH v2 00/10] hashserv: Pipeline Upstream Queries
To: bitbake-devel@lists.openembedded.org
From: "Michal Sieron" <michalwsieron@gmail.com>
X-Originating-Location: Frankfurt am Main, Hesse, DE (136.226.162.169)
X-Originating-Platform: Linux Edge 148
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 31 Jul 2026 06:05:45 -0700
References: <20260724212822.1165552-1-JPEWhacker@gmail.com> <20260730183254.793698-1-JPEWhacker@gmail.com>
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
Message-ID: <1147544.1785503145144982751@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="LrZL8Fc0VlhJ5VIUxVkf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 13:05:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19895

--LrZL8Fc0VlhJ5VIUxVkf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

something is not working for me...

In the first run I got it stuck for an hour at:
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 192 messages but only received 49
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 115 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 115 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 165 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 9 messages but only received 4
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 99 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 15 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 9 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 1 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 4 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 47 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 1 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 116 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 112 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 117 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 277 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 66 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 72 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 157 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 45 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 52 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 75 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 18 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 10 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 98 messages but only received 0
Initialising tasks: =C2=A044% |############################################=
############## =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | ETA: =C2=A01:03:30

Then in another run, after reporting that 8 messages were sent, but 0 recei=
ved, hashserve.sock disappeared!
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: Sent 8 messages but only received 0
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or directory
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or directory
WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdi=
r/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or directory
Although that might be a different issue after killing previous run and not=
 making sure all Cooker processes are actually dead?

Anyway, after properly making sure there are no lingering processes, I am s=
till getting stuck at:
WARNING: [...] Sent 192 messages but only received 26
WARNING: [...] Sent 115 messages but only received 0
WARNING: [...] Sent 115 messages but only received 0
WARNING: [...] Sent 165 messages but only received 0
WARNING: [...] Sent 9 messages but only received 1

I will be going on vacation now, so unfortunately, I won't be able to test =
more if you come up with anything new.

Best regards,
Michal

--LrZL8Fc0VlhJ5VIUxVkf
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>something is not working for me...</div>
<div>&nbsp;</div>
<div>In the first run I got it stuck for an hour at:</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: Sent 192 messages but only receive=
d 49<br />WARNING: Error contacting Hash Equivalence Server unix:///path/to=
/my/workdir/builds/yoctobuild/hashserve.sock: Sent 115 messages but only re=
ceived 0<br />WARNING: Error contacting Hash Equivalence Server unix:///pat=
h/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 115 messages but onl=
y received 0<br />WARNING: Error contacting Hash Equivalence Server unix://=
/path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 165 messages but=
 only received 0<br />WARNING: Error contacting Hash Equivalence Server uni=
x:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9 messages b=
ut only received 4<br />WARNING: Error contacting Hash Equivalence Server u=
nix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 99 message=
s but only received 0<br />WARNING: Error contacting Hash Equivalence Serve=
r unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 15 mess=
ages but only received 0<br />WARNING: Error contacting Hash Equivalence Se=
rver unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9 me=
ssages but only received 0<br />WARNING: Error contacting Hash Equivalence =
Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1 =
messages but only received 0<br />WARNING: Error contacting Hash Equivalenc=
e Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent =
4 messages but only received 0<br />WARNING: Error contacting Hash Equivale=
nce Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sen=
t 47 messages but only received 0<br />WARNING: Error contacting Hash Equiv=
alence Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: =
Sent 1 messages but only received 0<br />WARNING: Error contacting Hash Equ=
ivalence Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock=
: Sent 116 messages but only received 0<br />WARNING: Error contacting Hash=
 Equivalence Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.=
sock: Sent 112 messages but only received 0<br />WARNING: Error contacting =
Hash Equivalence Server unix:///path/to/my/workdir/builds/yoctobuild/hashse=
rve.sock: Sent 117 messages but only received 0<br />WARNING: Error contact=
ing Hash Equivalence Server unix:///path/to/my/workdir/builds/yoctobuild/ha=
shserve.sock: Sent 277 messages but only received 0<br />WARNING: Error con=
tacting Hash Equivalence Server unix:///path/to/my/workdir/builds/yoctobuil=
d/hashserve.sock: Sent 66 messages but only received 0<br />WARNING: Error =
contacting Hash Equivalence Server unix:///path/to/my/workdir/builds/yoctob=
uild/hashserve.sock: Sent 72 messages but only received 0<br />WARNING: Err=
or contacting Hash Equivalence Server unix:///path/to/my/workdir/builds/yoc=
tobuild/hashserve.sock: Sent 157 messages but only received 0<br />WARNING:=
 Error contacting Hash Equivalence Server unix:///path/to/my/workdir/builds=
/yoctobuild/hashserve.sock: Sent 45 messages but only received 0<br />WARNI=
NG: Error contacting Hash Equivalence Server unix:///path/to/my/workdir/bui=
lds/yoctobuild/hashserve.sock: Sent 52 messages but only received 0<br />WA=
RNING: Error contacting Hash Equivalence Server unix:///path/to/my/workdir/=
builds/yoctobuild/hashserve.sock: Sent 75 messages but only received 0<br /=
>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/workd=
ir/builds/yoctobuild/hashserve.sock: Sent 18 messages but only received 0<b=
r />WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/wo=
rkdir/builds/yoctobuild/hashserve.sock: Sent 10 messages but only received =
0<br />WARNING: Error contacting Hash Equivalence Server unix:///path/to/my=
/workdir/builds/yoctobuild/hashserve.sock: Sent 98 messages but only receiv=
ed 0<br />Initialising tasks: &nbsp;44% |##################################=
######################## &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | ETA: &nbsp;1:0=
3:30</div>
<div>&nbsp;</div>
<div>Then in another run, after reporting that 8 messages were sent, but 0 =
received, hashserve.sock disappeared!</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: Sent 8 messages but only received =
0<br />WARNING: Error contacting Hash Equivalence Server unix:///path/to/my=
/workdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or direct=
ory<br />WARNING: Error contacting Hash Equivalence Server unix:///path/to/=
my/workdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or dire=
ctory</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or director=
y</div>
<div>Although that might be a different issue after killing previous run an=
d not making sure all Cooker processes are actually dead?</div>
<div>&nbsp;</div>
<div>Anyway, after properly making sure there are no lingering processes, I=
 am still getting stuck at:</div>
<div>WARNING: [...] Sent 192 messages but only received 26<br />WARNING: [.=
..] Sent 115 messages but only received 0</div>
<div>WARNING: [...] Sent 115 messages but only received 0</div>
<div>WARNING: [...] Sent 165 messages but only received 0</div>
<div>WARNING: [...] Sent 9 messages but only received 1</div>
<div>&nbsp;</div>
<div>I will be going on vacation now, so unfortunately, I won't be able to =
test more if you come up with anything new.</div>
<div>&nbsp;</div>
<div>Best regards,</div>
<div>Michal</div>

--LrZL8Fc0VlhJ5VIUxVkf--

