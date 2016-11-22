Return-Path: <sujith.h@gmail.com>
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com
	[209.85.220.177])
	by mail.openembedded.org (Postfix) with ESMTP id 3CD17605BA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 10:50:50 +0000 (UTC)
Received: by mail-qk0-f177.google.com with SMTP id q130so17405707qke.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 02:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=ZMvcDS/jLg0x6Q/iXDnC1KxzrC8YPIbzlUckFJCiCjQ=;
	b=kCYWNLyyobzkBKa2fPtJiXG882xqG0JFTrmqFoyk9B82pJbSWLGMRCD4Mhzy4Zv1lZ
	7SY6Q+qiskDktJkvOY7T3SEF2yvQVv0yX3JQZZKvdhkZOK2fzmV31eVr80EgJcZ+5l0o
	DBMMOLG7m9VYcQYlQnhtl8a7/a64ANqbatzQxKODqJ+ZalVbz9tPYa3vIDShKuXvGwS3
	O9kyj4Qi6iTqBeXn5O3I57FfdbSvnx+Pe+WmPu+yFBxQzN5UTXKFyCAYD8uaeh1lclK7
	0cN7NvbY1Ey7jPajctIsfaeiVUgXW4i0ZMtIyq3QFaKYU29mlQl++L0vVXD3nFSDTC81
	JWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=ZMvcDS/jLg0x6Q/iXDnC1KxzrC8YPIbzlUckFJCiCjQ=;
	b=Epr9Qc76lhTmFQW0UTKM/TxbcwVBH7imV6rxtONKuke9ZQMTIqHZ0HOOJUPbDkeSYs
	riq+6lWIgapPURKTxm/uHYXE8lg98Iw+gpRmWNxRh7Kx4n6ScGjpcsaO5hIBvir6Sr+Q
	QwMcrAEQApswDoNfYNiYkKewUexrolt3s/K5BEZNaPoIEiAPeSwMlP+ZioxarlFAPoSP
	d9TaHeCkdwMFovEWTWHEUfy60j/WYxIly5t4pScxHujVb9fFP/UfqiMLmbT2/2VLFqwl
	wj4bTQAtP+z+bwwxpdm4gCpWAGJw/pUbz1k1QYtvDB349xR+9paeGK5ejIdt6CGKO26j
	n3Cg==
X-Gm-Message-State: AKaTC03TFDj9Rd6fgcEjMTOWheAWNzrJkD9WO7k2SR9pmlZ4Bz0Q7wgg5CNFnwXJZQr7bVnExKJPkbTahwrnFQ==
X-Received: by 10.55.149.134 with SMTP id x128mr19469706qkd.263.1479811851128; 
	Tue, 22 Nov 2016 02:50:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.195.221 with HTTP; Tue, 22 Nov 2016 02:50:30 -0800 (PST)
In-Reply-To: <CADyYWLmiBkOd9xuc2SqfUG3sO6FdLGd9y5=+SNtGCCVC65tZ8w@mail.gmail.com>
References: <CADyYWLmiBkOd9xuc2SqfUG3sO6FdLGd9y5=+SNtGCCVC65tZ8w@mail.gmail.com>
From: sujith h <sujith.h@gmail.com>
Date: Tue, 22 Nov 2016 16:20:30 +0530
Message-ID: <CADyYWL=Zz0oHNW=gF--i3DD=ZU8ZgVd_K50MC7nwVx0RcHy4Fw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: getAllKeysWithFlags: Issue when returning the dump var
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
X-List-Received-Date: Tue, 22 Nov 2016 10:50:52 -0000
Content-Type: multipart/alternative; boundary=94eb2c083c88b8956c0541e18bda

--94eb2c083c88b8956c0541e18bda
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Finally I found that not all data in my case was
string/list/tuple/dict/None/int/float. That is those data types which can
be marshalled: https://docs.python.org/3/library/xmlrpc.client.html. But
there was a data type :
v =3D <subprocess.Popen object at 0x7f56f4964ef0>. So this was causing the
problem for me.

Thanks,
Sujith H

On Tue, Nov 22, 2016 at 2:54 PM, sujith h <sujith.h@gmail.com> wrote:

> Hi,
>
> I found a small issue while building a recipe/image in toaster. The
> problem I saw is when toaster completes parsing, I could see an error in
> the toaster_ui.log as:
>
> ERROR: <Fault 1: "<class 'TypeError'>:cannot marshal <class
> '_thread.lock'> objects">
> Traceback (most recent call last):
>   File "/home/sujith/MEL/toaster-latest/poky/bitbake/lib/bb/ui/toasterui.=
py",
> line 256, in main
>     buildinfohelper.save_build_layers_and_variables()
>   File "/home/sujith/MEL/toaster-latest/poky/bitbake/lib/bb/ui/buildinfoh=
elper.py",
> line 1151, in save_build_layers_and_variables
>     data =3D self.server.runCommand(["getAllKeysWithFlags", ["doc",
> "func"]])[0]
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 1098, in __call__
>     return self.__send(self.__name, args)
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 1437, in __request
>     verbose=3Dself.__verbose
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 1140, in request
>     return self.single_request(host, handler, request_body, verbose)
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 1156, in single_reques=
t
>     return self.parse_response(resp)
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 1327, in parse_respons=
e
>     return u.close()
>   File "/usr/lib/python3.4/xmlrpc/client.py", line 657, in close
>     raise Fault(**self._stack[0])
> xmlrpc.client.Fault: <Fault 1: "<class 'TypeError'>:cannot marshal <class
> '_thread.lock'> objects">
>
>
> This error doesn't stops the building of a recipe or image which is
> triggered. After seeing this error I tried to modify the cooker.py code f=
or
> getAllKeysWithFlags, at the end ( before it returns dump ), to write to a
> file a.py:
>
> fd.write("a =3D %s\n" %(str(dump)))
>
> And tried to import the file a.py. The moment I tried to import it, I was
> getting syntax error. Any helping hand would be nice for me to move ahead
> with this issue. If my understanding is correct, its not a toaster issue.
> Pardon me if my understanding is wrong.
>
> Thanks,
> Sujith H
>
> --
> =E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
> Bangalore
> <Project>Contributor to KDE project
> <Project>Contributor to Yocto project
> http://fci.wikia.com/wiki/Anti-DRM-Campaign
> <Blog> http://sujithh.info
> C-x C-c
>



--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
<Project>Contributor to Yocto project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info
C-x C-c

--94eb2c083c88b8956c0541e18bda
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br>Finally I found that not all data in =
my case was string/list/tuple/dict/None/int/float. That is those data types=
 which can be marshalled: <a href=3D"https://docs.python.org/3/library/xmlr=
pc.client.html">https://docs.python.org/3/library/xmlrpc.client.html</a>. B=
ut there was a data type :<br>v =3D &lt;subprocess.Popen object at 0x7f56f4=
964ef0&gt;. So this was causing the problem for me. <br><br></div>Thanks,<b=
r></div>Sujith H<br></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Tue, Nov 22, 2016 at 2:54 PM, sujith h <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:sujith.h@gmail.com" target=3D"_blank">sujith.h@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div=
><div><div><div><div><div>Hi,<br><br></div>I found a small issue while buil=
ding a recipe/image in toaster. The problem I saw is when toaster completes=
 parsing, I could see an error in the toaster_ui.log as:<br><br>ERROR: &lt;=
Fault 1: &quot;&lt;class &#39;TypeError&#39;&gt;:cannot marshal &lt;class &=
#39;_thread.lock&#39;&gt; objects&quot;&gt;<br>Traceback (most recent call =
last):<br>=C2=A0 File &quot;/home/sujith/MEL/toaster-<wbr>latest/poky/bitba=
ke/lib/bb/ui/<wbr>toasterui.py&quot;, line 256, in main<br>=C2=A0=C2=A0=C2=
=A0 buildinfohelper.save_build_<wbr>layers_and_variables()<br>=C2=A0 File &=
quot;/home/sujith/MEL/toaster-<wbr>latest/poky/bitbake/lib/bb/ui/<wbr>build=
infohelper.py&quot;, line 1151, in save_build_layers_and_<wbr>variables<br>=
=C2=A0=C2=A0=C2=A0 data =3D self.server.runCommand([&quot;<wbr>getAllKeysWi=
thFlags&quot;, [&quot;doc&quot;, &quot;func&quot;]])[0]<br>=C2=A0 File &quo=
t;/usr/lib/python3.4/xmlrpc/<wbr>client.py&quot;, line 1098, in __call__<br=
>=C2=A0=C2=A0=C2=A0 return self.__send(self.__name, args)<br>=C2=A0 File &q=
uot;/usr/lib/python3.4/xmlrpc/<wbr>client.py&quot;, line 1437, in __request=
<br>=C2=A0=C2=A0=C2=A0 verbose=3Dself.__verbose<br>=C2=A0 File &quot;/usr/l=
ib/python3.4/xmlrpc/<wbr>client.py&quot;, line 1140, in request<br>=C2=A0=
=C2=A0=C2=A0 return self.single_request(host, handler, request_body, verbos=
e)<br>=C2=A0 File &quot;/usr/lib/python3.4/xmlrpc/<wbr>client.py&quot;, lin=
e 1156, in single_request<br>=C2=A0=C2=A0=C2=A0 return self.parse_response(=
resp)<br>=C2=A0 File &quot;/usr/lib/python3.4/xmlrpc/<wbr>client.py&quot;, =
line 1327, in parse_response<br>=C2=A0=C2=A0=C2=A0 return u.close()<br>=C2=
=A0 File &quot;/usr/lib/python3.4/xmlrpc/<wbr>client.py&quot;, line 657, in=
 close<br>=C2=A0=C2=A0=C2=A0 raise Fault(**self._stack[0])<br>xmlrpc.client=
.Fault: &lt;Fault 1: &quot;&lt;class &#39;TypeError&#39;&gt;:cannot marshal=
 &lt;class &#39;_thread.lock&#39;&gt; objects&quot;&gt;<br><br><br></div>Th=
is error doesn&#39;t stops the building of a recipe or image which is trigg=
ered. After seeing this error I tried to modify the cooker.py code for getA=
llKeysWithFlags, at the end ( before it returns dump ), to write to a file =
a.py:<br><br></div>fd.write(&quot;a =3D %s\n&quot; %(str(dump)))<br><br></d=
iv>And tried to import the file a.py. The moment I tried to import it, I wa=
s getting syntax error. Any helping hand would be nice for me to move ahead=
 with this issue. If my understanding is correct, its not a toaster issue. =
Pardon me if my understanding is wrong.<br><br></div>Thanks,<br></div>Sujit=
h H<span class=3D"HOEnZb"><font color=3D"#888888"><br clear=3D"all"><div><d=
iv><div><div><div><div><div><div><br>-- <br><div class=3D"m_-33756987460140=
93964gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=E0=B4=B8=
=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=E0=B4=BF=
=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D<br>Bangalore<br>&lt;Project&g=
t;Contributor to KDE project<br></div><div>&lt;Project&gt;Contributor to Yo=
cto project<br></div><div><a href=3D"http://fci.wikia.com/wiki/Anti-DRM-Cam=
paign" target=3D"_blank">http://fci.wikia.com/wiki/<wbr>Anti-DRM-Campaign</=
a><br>&lt;Blog&gt; <a href=3D"http://sujithh.info" target=3D"_blank">http:/=
/sujithh.info</a><br></div><div>C-x C-c<br></div></div></div></div></div>
</div></div></div></div></div></div></div></div></font></span></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div>=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=
=B9=E0=B4=B0=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D<br>Banga=
lore<br>&lt;Project&gt;Contributor to KDE project<br></div><div>&lt;Project=
&gt;Contributor to Yocto project<br></div><div><a href=3D"http://fci.wikia.=
com/wiki/Anti-DRM-Campaign" target=3D"_blank">http://fci.wikia.com/wiki/Ant=
i-DRM-Campaign</a><br>&lt;Blog&gt; <a href=3D"http://sujithh.info" target=
=3D"_blank">http://sujithh.info</a><br></div><div>C-x C-c<br></div></div></=
div></div></div>
</div>

--94eb2c083c88b8956c0541e18bda--
