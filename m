Return-Path: <sujith.h@gmail.com>
Received: from mail-qg0-f41.google.com (mail-qg0-f41.google.com
	[209.85.192.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0A498731A7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jan 2016 15:16:48 +0000 (UTC)
Received: by mail-qg0-f41.google.com with SMTP id b35so33757204qge.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jan 2016 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=9m6sKULLU0rZI9S7xMt8mlFNmmg60rDVyHKI1zPoOm0=;
	b=e1t/gO9vDVCIGI69pHUMfoQtBFHbNm6nsVXm6zRCY7BIoin1Kf4CkBiua8csez2iZy
	NNlNLS6+jrLzqrAda3tO+KBoHNi/OKo66D6VBrdC+LBR3hoiK2JEx9Fsu5uZFige6ciF
	70uIEcHkB6wYDpQPIN1Ji5o++0mYcu8h3bqE1BQVPskC3MHsxrm6eEie7p56rfgEx4p2
	J5SBxmQ0CUOf12TXGBkBYmbBLkpeow1L7k0GNHP+86025GwJlNXSGWOANIYWD6Yei5Fy
	a24h33Oxz/vnbbOMbuHXkS2xevmmGyA6Ucst6oNFnTyT8uNek7S8WDbAGVbKTTjTWHIq
	fx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:content-type;
	bh=9m6sKULLU0rZI9S7xMt8mlFNmmg60rDVyHKI1zPoOm0=;
	b=Um2MRcfmXYAfkj2STvNzoC7YBRTAReljYg82y4nVJVSNRS8uMUbCxgzFJN1tDV/YnN
	YGw9IspKAFe6av/0PetJzKZAtc30eTfaZO8vGA96A58mOK76GhQZS4q395T53MJ/2h92
	y1KBxIHa1JgIlL3seBU6uXpYNeDCFtXhLICB2CUMmJVC0IRhFrSDvERYY1Mkg4LdiiXL
	cIu4zUJkcwryy409Liv5uFz2UY2x/AnZqhgp/cb1spXc/akHuNegGD3CEoXJyuoPX0T7
	AARBpbWmTGaqeDNx03ZdrUGjmng7w3ixYqMKVJlQ4etBTnjky4U/o6BTEZ2/ql1+YMC4
	WIRA==
X-Gm-Message-State: ALoCoQme1rBdeScHBNe69Gqr08UFNgv/hkeUC2XPCmqecVUDb9u3nr0PDh3wh4YdTQnKY8UMW+/M1DmBrtBIBx6G+BUVC+1kEg==
X-Received: by 10.140.170.212 with SMTP id q203mr55848120qhq.32.1453389408599; 
	Thu, 21 Jan 2016 07:16:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.154.139 with HTTP; Thu, 21 Jan 2016 07:16:29 -0800 (PST)
In-Reply-To: <CADyYWL=c3QO5zkOOjUuaiswwO4FVTGEmqGnF3_TjXH4=TVDbNw@mail.gmail.com>
References: <CADyYWLm+yYR7J6NMLKHR6Ss_i16Q5Tiz=x2DuJ7_mOViTEvcYg@mail.gmail.com>
	<20151218134627.GA27311@linux.intel.com>
	<CADyYWL=Vo_fcSzJU_QqRo=PpJHBQ03Ln0u+Fzma9xT=aFT4p5Q@mail.gmail.com>
	<CADyYWLnwDRR9S_XcdNesP9p+H18xkdnFRdCUajqNuF+8OJq-aA@mail.gmail.com>
	<CADyYWLnJJ0b0=kg7bMcLT+TUBa-HN6aPWbjDnrtr1Sz=bQS_MQ@mail.gmail.com>
	<CADyYWL=z8O=atf9g7L5rg_D2h7xY-Ng7KzC0i8JdBzGnuoYgPw@mail.gmail.com>
	<CADyYWLkn6=gE_GCefcYOJ82kn8hoGRyQY790F0_GWYkem-j5Sw@mail.gmail.com>
	<D2B17827.6E2E9%belen.barros.pena@intel.com>
	<CADyYWLmS5+BTJ35R2g0x_m3F2z45hGQM_bDcXFJSgKx7YvjWLw@mail.gmail.com>
	<CADyYWLmwFrdV4=M+Z6v_f7txSCLVCg_n0uDu79uTrYqKy0wSjw@mail.gmail.com>
	<CADyYWLnBt4cCOmJ0Ky2TcYdtDPrbvL4wXhtFcajbmqnw_xcmCw@mail.gmail.com>
	<D2B940D1.6F2B2%belen.barros.pena@intel.com>
	<D2B94862.6F2C3%belen.barros.pena@intel.com>
	<CADyYWLmpJE3y63f_-7QJAWhwxjq0gRo7QnfzGxW1-Ou_ddoqNA@mail.gmail.com>
	<D2C1AC14.703C1%belen.barros.pena@intel.com>
	<CADyYWL=c3QO5zkOOjUuaiswwO4FVTGEmqGnF3_TjXH4=TVDbNw@mail.gmail.com>
From: sujith h <sujith.h@gmail.com>
Date: Thu, 21 Jan 2016 20:46:29 +0530
Message-ID: <CADyYWLkv2Ot9BFZ1rEpPBg6HvvHLuAD50=s+jKuckMS7c622Xw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [Toaster] Build cancellation from toaster
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
X-List-Received-Date: Thu, 21 Jan 2016 15:16:49 -0000
Content-Type: multipart/alternative; boundary=001a113aaa386b84490529d99703

--001a113aaa386b84490529d99703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

After discussion with toaster community, it was decided to ask it over
bitbake-devel list. So I am sharing the issue, which I am blocked with.

Let me share the issue which I am facing: build triggered from command line
were not able to cancel from toaster, where as the build triggered from
toaster were able to cancel from toaster successfully.

The logic that I am using to cancel build from toaster is to pass
stateForceShutdown command ( as in
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Dsujith/t=
oaster-build-cancel12&id=3D6601df1a06abc3ce3290656e1f2f91a511653c0d).
This works like charm when the build is triggered from toaster. But when I
use the same logic to cancel the build triggered from command line I can
see error:
---------------------------
ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>

Not able to understand why it is not able to connect to the port. Because
as per my understanding when a build is triggered from toaster, we connect
to the host:port and execute the commands. The runcommand is failing badly
with the log:

2016-01-18 16:06:05,608 ERROR Internal Server Error:
/toastergui/project/1/builds/
Traceback (most recent call last):
  File
"/home/sujith/build/poky-push/venv/lib/python2.7/site-packages/django/core/=
handlers/base.py",
line 132, in get_response
    response =3D wrapped_callback(request, *callback_args, **callback_kwarg=
s)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 171, in returned_wrapper
    context =3D view(request, *args, **kwargs)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 2896, in projectbuilds
    bbctrl.forceShutDown()
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 73, in forceShutDown
    return self._runCommand(["stateForceShutdown"])
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 50, in _runCommand
    result, error =3D self.connection.runCommand(command)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1240, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1599, in __request
    verbose=3Dself.__verbose
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1280, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1328, in single_request
    response.msg,
ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>
Internal Server Error: /toastergui/project/1/builds/
Traceback (most recent call last):
  File
"/home/sujith/build/poky-push/venv/lib/python2.7/site-packages/django/core/=
handlers/base.py",
line 132, in get_response
    response =3D wrapped_callback(request, *callback_args, **callback_kwarg=
s)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 171, in returned_wrapper
    context =3D view(request, *args, **kwargs)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 2896, in projectbuilds
    bbctrl.forceShutDown()
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 73, in forceShutDown
    return self._runCommand(["stateForceShutdown"])
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 50, in _runCommand
    result, error =3D self.connection.runCommand(command)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1240, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1599, in __request
    verbose=3Dself.__verbose
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1280, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1328, in single_request
    response.msg,
ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>
[18/Jan/2016 16:06:05] "POST /toastergui/project/1/builds/ HTTP/1.1" 500
13414
-------------------------

As far as I understand the connection to bitbake server is failing.
Any helping hand or pointers to tackle this issue would be helpful for me
to move ahead with this task.

Thanks,
Sujith H


---------- Forwarded message ----------
From: sujith h <sujith.h@gmail.com>
Date: Mon, Jan 18, 2016 at 9:42 PM
Subject: Re: [Toaster] Build cancellation from toaster
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>
Cc: "toaster@yoctoproject.org" <toaster@yoctoproject.org>




On Mon, Jan 18, 2016 at 1:13 AM, Barros Pena, Belen <
belen.barros.pena@intel.com> wrote:

>
>
> On 13/01/2016 16:47, "sujith h" <sujith.h@gmail.com> wrote:
>
> >
> >I have updated another patch set with which I have verified with:
> >
> >a) cancellation of a normal build
> >
> >b) run again and cancel the build
> >
> >c) stop toaster + start toaster + run again   and cancel the build
> >
> >
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dsujith/to=
ast
> >er-build-cancel12
>
> Sorry for the delay in looking into this. Cancellation seems to be workin=
g
> well for me for any builds I start from Toaster. However, it doesn't seem
> to work for builds I start from the command line and I track through
> Toaster. For those builds, a 'cancel' button appears, but when I click it=
,
> nothing happens: the build proceeds until it completes.
>
> I am not even sure if the 'cancel' functionality can work for builds
> started from the command line, although it would be great if it did. If i=
t
> is not possible to make it work, then the cancel button should not displa=
y
> for those builds. We can provide a message instead, as we do in the case
> of the 'run again' button, explaining that builds started from the comman=
d
> line can only be cancelled from the command line.
>

Somehow when i try to use the same logic to cancel the build triggered from
command line ( with small modification in the code though), I am getting
error in the toaster_web.log as:

ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>

Not able to understand why it is not able to connect to the port. Because
as per my understanding when a build is triggered from toaster, we connect
to the host:port and execute the commands. The runcommand is failing badly
with the log:

2016-01-18 16:06:05,608 ERROR Internal Server Error:
/toastergui/project/1/builds/
Traceback (most recent call last):
  File
"/home/sujith/build/poky-push/venv/lib/python2.7/site-packages/django/core/=
handlers/base.py",
line 132, in get_response
    response =3D wrapped_callback(request, *callback_args, **callback_kwarg=
s)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 171, in returned_wrapper
    context =3D view(request, *args, **kwargs)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 2896, in projectbuilds
    bbctrl.forceShutDown()
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 73, in forceShutDown
    return self._runCommand(["stateForceShutdown"])
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 50, in _runCommand
    result, error =3D self.connection.runCommand(command)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1240, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1599, in __request
    verbose=3Dself.__verbose
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1280, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1328, in single_request
    response.msg,
ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>
Internal Server Error: /toastergui/project/1/builds/
Traceback (most recent call last):
  File
"/home/sujith/build/poky-push/venv/lib/python2.7/site-packages/django/core/=
handlers/base.py",
line 132, in get_response
    response =3D wrapped_callback(request, *callback_args, **callback_kwarg=
s)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 171, in returned_wrapper
    context =3D view(request, *args, **kwargs)
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py",
line 2896, in projectbuilds
    bbctrl.forceShutDown()
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 73, in forceShutDown
    return self._runCommand(["stateForceShutdown"])
  File
"/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.p=
y",
line 50, in _runCommand
    result, error =3D self.connection.runCommand(command)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1240, in __call__
    return self.__send(self.__name, args)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1599, in __request
    verbose=3Dself.__verbose
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1280, in request
    return self.single_request(host, handler, request_body, verbose)
  File "/usr/lib64/python2.7/xmlrpclib.py", line 1328, in single_request
    response.msg,
ProtocolError: <ProtocolError for 0.0.0.0:42952/: 503 Service Unavailable>
[18/Jan/2016 16:06:05] "POST /toastergui/project/1/builds/ HTTP/1.1" 500
13414


Any helping hand would be appreciated. More over I would also like to know
if we can pass commands to builds triggered from command line?

Thanks,
Sujith H

--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info



--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info

--001a113aaa386b84490529d99703
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br></div><div>After discussion with toaster c=
ommunity, it was decided to ask it over bitbake-devel list. So I am sharing=
 the issue, which I am blocked with.<br></div><div><br>Let me share the iss=
ue which I am facing: build triggered from command line were not able to ca=
ncel from toaster, where as the build triggered from toaster were able to c=
ancel from toaster successfully.<br><br></div><div>The logic that I am usin=
g to cancel build from toaster is to pass stateForceShutdown command ( as i=
n <a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/=
?h=3Dsujith/toaster-build-cancel12&amp;id=3D6601df1a06abc3ce3290656e1f2f91a=
511653c0d">http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=
=3Dsujith/toaster-build-cancel12&amp;id=3D6601df1a06abc3ce3290656e1f2f91a51=
1653c0d</a>). This works like charm when the build is triggered from toaste=
r. But when I use the same logic to cancel the build triggered from command=
 line I can see error:<br>---------------------------<br>ProtocolError: &lt=
;ProtocolError for <a href=3D"http://0.0.0.0:42952/" target=3D"_blank">0.0.=
0.0:42952/</a>: 503 Service Unavailable&gt;<br><br>Not
 able to understand why it is not able to connect to the port. Because=20
as per my understanding when a build is triggered from toaster, we=20
connect to the host:port and execute the commands. The runcommand is=20
failing badly with the log:<br><br>2016-01-18 16:06:05,608 ERROR Internal S=
erver Error: /toastergui/project/1/builds/<span class=3D""><br>Traceback (m=
ost recent call last):<br></span>=C2=A0 File &quot;/home/sujith/build/poky-=
push/venv/lib/python2.7/site-packages/django/core/handlers/base.py&quot;, l=
ine 132, in get_response<br>=C2=A0=C2=A0=C2=A0 response =3D wrapped_callbac=
k(request, *callback_args, **callback_kwargs)<br>=C2=A0 File &quot;/home/su=
jith/build/poky-push/bitbake/lib/toaster/toastergui/views.py&quot;, line 17=
1, in returned_wrapper<br>=C2=A0=C2=A0=C2=A0 context =3D view(request, *arg=
s, **kwargs)<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/=
toaster/toastergui/views.py&quot;, line 2896, in projectbuilds<br>=C2=A0=C2=
=A0=C2=A0 bbctrl.forceShutDown()<br>=C2=A0 File &quot;/home/sujith/build/po=
ky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.py&quot;, line 73, in f=
orceShutDown<br>=C2=A0=C2=A0=C2=A0 return self._runCommand([&quot;stateForc=
eShutdown&quot;])<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake=
/lib/toaster/bldcontrol/bbcontroller.py&quot;, line 50, in _runCommand<br>=
=C2=A0=C2=A0=C2=A0 result, error =3D self.connection.runCommand(command)<br=
>=C2=A0 File &quot;/usr/lib64/python2.7/xmlrpclib.py&quot;, line 1240, in _=
_call__<br>=C2=A0=C2=A0=C2=A0 return self.__send(self.__name, args)<br>=C2=
=A0 File &quot;/usr/lib64/python2.7/xmlrpclib.py&quot;, line 1599, in __req=
uest<br>=C2=A0=C2=A0=C2=A0 verbose=3Dself.__verbose<br>=C2=A0 File &quot;/u=
sr/lib64/python2.7/xmlrpclib.py&quot;, line 1280, in request<br>=C2=A0=C2=
=A0=C2=A0 return self.single_request(host, handler, request_body, verbose)<=
br>=C2=A0 File &quot;/usr/lib64/python2.7/xmlrpclib.py&quot;, line 1328, in=
 single_request<br>=C2=A0=C2=A0=C2=A0 response.msg,<br>ProtocolError: &lt;P=
rotocolError for <a href=3D"http://0.0.0.0:42952/" target=3D"_blank">0.0.0.=
0:42952/</a>: 503 Service Unavailable&gt;<br>Internal Server Error: /toaste=
rgui/project/1/builds/<span class=3D""><br>Traceback (most recent call last=
):<br></span>=C2=A0 File &quot;/home/sujith/build/poky-push/venv/lib/python=
2.7/site-packages/django/core/handlers/base.py&quot;, line 132, in get_resp=
onse<br>=C2=A0=C2=A0=C2=A0 response =3D wrapped_callback(request, *callback=
_args, **callback_kwargs)<br>=C2=A0 File &quot;/home/sujith/build/poky-push=
/bitbake/lib/toaster/toastergui/views.py&quot;, line 171, in returned_wrapp=
er<br>=C2=A0=C2=A0=C2=A0 context =3D view(request, *args, **kwargs)<br>=C2=
=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/=
views.py&quot;, line 2896, in projectbuilds<br>=C2=A0=C2=A0=C2=A0 bbctrl.fo=
rceShutDown()<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib=
/toaster/bldcontrol/bbcontroller.py&quot;, line 73, in forceShutDown<br>=C2=
=A0=C2=A0=C2=A0 return self._runCommand([&quot;stateForceShutdown&quot;])<b=
r>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/bldcon=
trol/bbcontroller.py&quot;, line 50, in _runCommand<br>=C2=A0=C2=A0=C2=A0 r=
esult, error =3D self.connection.runCommand(command)<br>=C2=A0 File &quot;/=
usr/lib64/python2.7/xmlrpclib.py&quot;, line 1240, in __call__<br>=C2=A0=C2=
=A0=C2=A0 return self.__send(self.__name, args)<br>=C2=A0 File &quot;/usr/l=
ib64/python2.7/xmlrpclib.py&quot;, line 1599, in __request<br>=C2=A0=C2=A0=
=C2=A0 verbose=3Dself.__verbose<br>=C2=A0 File &quot;/usr/lib64/python2.7/x=
mlrpclib.py&quot;, line 1280, in request<br>=C2=A0=C2=A0=C2=A0 return self.=
single_request(host, handler, request_body, verbose)<br>=C2=A0 File &quot;/=
usr/lib64/python2.7/xmlrpclib.py&quot;, line 1328, in single_request<br>=C2=
=A0=C2=A0=C2=A0 response.msg,<br>ProtocolError: &lt;ProtocolError for <a hr=
ef=3D"http://0.0.0.0:42952/" target=3D"_blank">0.0.0.0:42952/</a>: 503 Serv=
ice Unavailable&gt;<br>[18/Jan/2016 16:06:05] &quot;POST /toastergui/projec=
t/1/builds/ HTTP/1.1&quot; 500 13414<br>-------------------------<br></div>=
<div><br>As far as I understand the connection to bitbake server is failing=
.<br>Any helping hand or pointers to tackle this issue would be helpful for=
 me to move ahead with this task.<br></div><div><br></div><div>Thanks,<br><=
/div><div>Sujith H<br></div><div><br><br><div><div class=3D"gmail_quote">--=
-------- Forwarded message ----------<br>From: <b class=3D"gmail_sendername=
">sujith h</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:sujith.h@gmail.com">=
sujith.h@gmail.com</a>&gt;</span><br>Date: Mon, Jan 18, 2016 at 9:42 PM<br>=
Subject: Re: [Toaster] Build cancellation from toaster<br>To: &quot;Barros =
Pena, Belen&quot; &lt;<a href=3D"mailto:belen.barros.pena@intel.com">belen.=
barros.pena@intel.com</a>&gt;<br>Cc: &quot;<a href=3D"mailto:toaster@yoctop=
roject.org">toaster@yoctoproject.org</a>&quot; &lt;<a href=3D"mailto:toaste=
r@yoctoproject.org">toaster@yoctoproject.org</a>&gt;<br><br><br><div dir=3D=
"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><span c=
lass=3D"">On Mon, Jan 18, 2016 at 1:13 AM, Barros Pena, Belen <span dir=3D"=
ltr">&lt;<a href=3D"mailto:belen.barros.pena@intel.com" target=3D"_blank">b=
elen.barros.pena@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><span><br>
<br>
On 13/01/2016 16:47, &quot;sujith h&quot; &lt;<a href=3D"mailto:sujith.h@gm=
ail.com" target=3D"_blank">sujith.h@gmail.com</a>&gt; wrote:<br>
<br>
&gt;<br>
&gt;I have updated another patch set with which I have verified with:<br>
&gt;<br>
&gt;a) cancellation of a normal build<br>
&gt;<br>
&gt;b) run again and cancel the build<br>
&gt;<br>
&gt;c) stop toaster + start toaster + run again=C2=A0 =C2=A0and cancel the =
build<br>
&gt;<br>
&gt;<a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?=
h=3Dsujith/toast" rel=3D"noreferrer" target=3D"_blank">http://git.yoctoproj=
ect.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dsujith/toast</a><br>
&gt;er-build-cancel12<br>
<br>
</span>Sorry for the delay in looking into this. Cancellation seems to be w=
orking<br>
well for me for any builds I start from Toaster. However, it doesn&#39;t se=
em<br>
to work for builds I start from the command line and I track through<br>
Toaster. For those builds, a &#39;cancel&#39; button appears, but when I cl=
ick it,<br>
nothing happens: the build proceeds until it completes.<br>
<br>
I am not even sure if the &#39;cancel&#39; functionality can work for build=
s<br>
started from the command line, although it would be great if it did. If it<=
br>
is not possible to make it work, then the cancel button should not display<=
br>
for those builds. We can provide a message instead, as we do in the case<br=
>
of the &#39;run again&#39; button, explaining that builds started from the =
command<br>
line can only be cancelled from the command line.<br></blockquote><div><br>=
</div></span><div>Somehow when i try to use the same logic to cancel the bu=
ild triggered from command line ( with small modification in the code thoug=
h), I am getting error in the toaster_web.log as:<br><br>ProtocolError: &lt=
;ProtocolError for <a href=3D"http://0.0.0.0:42952/" target=3D"_blank">0.0.=
0.0:42952/</a>: 503 Service Unavailable&gt;<br><br></div><div>Not able to u=
nderstand why it is not able to connect to the port. Because as per my unde=
rstanding when a build is triggered from toaster, we connect to the host:po=
rt and execute the commands. The runcommand is failing badly with the log:<=
br><br>2016-01-18 16:06:05,608 ERROR Internal Server Error: /toastergui/pro=
ject/1/builds/<span class=3D""><br>Traceback (most recent call last):<br></=
span>=C2=A0 File &quot;/home/sujith/build/poky-push/venv/lib/python2.7/site=
-packages/django/core/handlers/base.py&quot;, line 132, in get_response<br>=
=C2=A0=C2=A0=C2=A0 response =3D wrapped_callback(request, *callback_args, *=
*callback_kwargs)<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake=
/lib/toaster/toastergui/views.py&quot;, line 171, in returned_wrapper<br>=
=C2=A0=C2=A0=C2=A0 context =3D view(request, *args, **kwargs)<br>=C2=A0 Fil=
e &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/toastergui/views.p=
y&quot;, line 2896, in projectbuilds<br>=C2=A0=C2=A0=C2=A0 bbctrl.forceShut=
Down()<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaste=
r/bldcontrol/bbcontroller.py&quot;, line 73, in forceShutDown<br>=C2=A0=C2=
=A0=C2=A0 return self._runCommand([&quot;stateForceShutdown&quot;])<br>=C2=
=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/=
bbcontroller.py&quot;, line 50, in _runCommand<br>=C2=A0=C2=A0=C2=A0 result=
, error =3D self.connection.runCommand(command)<br>=C2=A0 File &quot;/usr/l=
ib64/python2.7/xmlrpclib.py&quot;, line 1240, in __call__<br>=C2=A0=C2=A0=
=C2=A0 return self.__send(self.__name, args)<br>=C2=A0 File &quot;/usr/lib6=
4/python2.7/xmlrpclib.py&quot;, line 1599, in __request<br>=C2=A0=C2=A0=C2=
=A0 verbose=3Dself.__verbose<br>=C2=A0 File &quot;/usr/lib64/python2.7/xmlr=
pclib.py&quot;, line 1280, in request<br>=C2=A0=C2=A0=C2=A0 return self.sin=
gle_request(host, handler, request_body, verbose)<br>=C2=A0 File &quot;/usr=
/lib64/python2.7/xmlrpclib.py&quot;, line 1328, in single_request<br>=C2=A0=
=C2=A0=C2=A0 response.msg,<br>ProtocolError: &lt;ProtocolError for <a href=
=3D"http://0.0.0.0:42952/" target=3D"_blank">0.0.0.0:42952/</a>: 503 Servic=
e Unavailable&gt;<br>Internal Server Error: /toastergui/project/1/builds/<s=
pan class=3D""><br>Traceback (most recent call last):<br></span>=C2=A0 File=
 &quot;/home/sujith/build/poky-push/venv/lib/python2.7/site-packages/django=
/core/handlers/base.py&quot;, line 132, in get_response<br>=C2=A0=C2=A0=C2=
=A0 response =3D wrapped_callback(request, *callback_args, **callback_kwarg=
s)<br>=C2=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/to=
astergui/views.py&quot;, line 171, in returned_wrapper<br>=C2=A0=C2=A0=C2=
=A0 context =3D view(request, *args, **kwargs)<br>=C2=A0 File &quot;/home/s=
ujith/build/poky-push/bitbake/lib/toaster/toastergui/views.py&quot;, line 2=
896, in projectbuilds<br>=C2=A0=C2=A0=C2=A0 bbctrl.forceShutDown()<br>=C2=
=A0 File &quot;/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/=
bbcontroller.py&quot;, line 73, in forceShutDown<br>=C2=A0=C2=A0=C2=A0 retu=
rn self._runCommand([&quot;stateForceShutdown&quot;])<br>=C2=A0 File &quot;=
/home/sujith/build/poky-push/bitbake/lib/toaster/bldcontrol/bbcontroller.py=
&quot;, line 50, in _runCommand<br>=C2=A0=C2=A0=C2=A0 result, error =3D sel=
f.connection.runCommand(command)<br>=C2=A0 File &quot;/usr/lib64/python2.7/=
xmlrpclib.py&quot;, line 1240, in __call__<br>=C2=A0=C2=A0=C2=A0 return sel=
f.__send(self.__name, args)<br>=C2=A0 File &quot;/usr/lib64/python2.7/xmlrp=
clib.py&quot;, line 1599, in __request<br>=C2=A0=C2=A0=C2=A0 verbose=3Dself=
.__verbose<br>=C2=A0 File &quot;/usr/lib64/python2.7/xmlrpclib.py&quot;, li=
ne 1280, in request<br>=C2=A0=C2=A0=C2=A0 return self.single_request(host, =
handler, request_body, verbose)<br>=C2=A0 File &quot;/usr/lib64/python2.7/x=
mlrpclib.py&quot;, line 1328, in single_request<br>=C2=A0=C2=A0=C2=A0 respo=
nse.msg,<br>ProtocolError: &lt;ProtocolError for <a href=3D"http://0.0.0.0:=
42952/" target=3D"_blank">0.0.0.0:42952/</a>: 503 Service Unavailable&gt;<b=
r>[18/Jan/2016 16:06:05] &quot;POST /toastergui/project/1/builds/ HTTP/1.1&=
quot; 500 13414<br><br><br></div><div>Any helping hand would be appreciated=
. More over I would also like to know if we can pass commands to builds tri=
ggered from command line?<br><br></div><div>Thanks,<br></div><div>Sujith H<=
br clear=3D"all"></div></div><span class=3D""><br>-- <br><div>=E0=B4=B8=E0=
=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=E0=B4=BF=E0=
=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D<br>Bangalore<br>&lt;Project&gt;C=
ontributor to KDE project<br><a href=3D"http://fci.wikia.com/wiki/Anti-DRM-=
Campaign" target=3D"_blank">http://fci.wikia.com/wiki/Anti-DRM-Campaign</a>=
<br>&lt;Blog&gt; <a href=3D"http://sujithh.info" target=3D"_blank">http://s=
ujithh.info</a><br></div>
</span></div></div>
</div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_signature">=E0=
=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=E0=
=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D<br>Bangalore<br>&lt;Pro=
ject&gt;Contributor to KDE project<br><a href=3D"http://fci.wikia.com/wiki/=
Anti-DRM-Campaign" target=3D"_blank">http://fci.wikia.com/wiki/Anti-DRM-Cam=
paign</a><br>&lt;Blog&gt; <a href=3D"http://sujithh.info" target=3D"_blank"=
>http://sujithh.info</a><br></div>
</div></div></div>

--001a113aaa386b84490529d99703--
