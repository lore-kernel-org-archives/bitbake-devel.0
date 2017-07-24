Return-Path: <raj.khem@gmail.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id D09D278351
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 17:50:53 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id t201so25797348wmt.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=Kle+cXkf87pCZBXbs3IbChhwepteRWzEq8Gv6alFoiM=;
	b=bMXZk1O+519XkpGrjqRN3/jjmaWR+QouT9pstx+GvoDCxFMYfcNSjOOu8O7k1MdTj7
	rVcCRiFmJWHqEALDYgUmLCQRbx85eV25b/h1oZgEa0wi4wRvI8xFiiOUt+YopJsNKufw
	C+EeV5kkhTWIre0s8dPJa6LZyFIOP5ot//puMUEvCj1o7HhPq5zwVjIClQEhO50LBJ4b
	oHif2owi7EtSSAww29Gbl6l+YrGIXMD3A58v8UDcS2/O3XE7j/wtaPFVRxuhrBE0FN5R
	4A+H5s1hLnIznxlzEhtd2BWSOM3qFOr+RPmgExwyHoDZnXM1thS7mXSPGVtMNCak2heI
	QDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=Kle+cXkf87pCZBXbs3IbChhwepteRWzEq8Gv6alFoiM=;
	b=UXaWbB38zpWqUHFBIYqFZqtdEBaYqdo4p3A/ZAykCIzrWcC2sM+weUWXBYZQ8NSZdD
	3hH02rhkwdnXUlM+wuQ79M9Z+/vYE0rUTNcmStKo5YpPfJ8JdFZ4RfWSC+FQlfwyt48l
	XJqLSNt7HgpPBOo+MFafDMWJARu9S0hZqtzMNgY8Z//5+Wth/dSh3I21n8gOIH+dqHkt
	JQpmWOUHW5fjKcru2Km3VzSa7OajHDS+VpbacqSWlzR269zoVgIn7knpNzE0yxghMUOL
	P7JASJ2lnBFQ3P43uF+28wi7Hsm0Fz5BD8kL2S9PMiTq28ELb9WsF6IhgW0DpSy0VwoD
	FqMA==
X-Gm-Message-State: AIVw113alqCgtdOXk69pn6gGRGxuY+UDitQslPVgw57wR3snbsHOwsaS
	MPTW0dSp8pLkawnBHPxthbWzsLR7yQ==
X-Received: by 10.80.164.18 with SMTP id u18mr3226899edb.250.1500918654456;
	Mon, 24 Jul 2017 10:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <PS1PR03MB1897C0F7BC9ECA259BF89091A8D80@PS1PR03MB1897.apcprd03.prod.outlook.com>
In-Reply-To: <PS1PR03MB1897C0F7BC9ECA259BF89091A8D80@PS1PR03MB1897.apcprd03.prod.outlook.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 24 Jul 2017 17:50:43 +0000
Message-ID: <CAMKF1soFC8dk0PPZVPJZtON-FFvm=ajL=AXair6VCsfKH2jMOQ@mail.gmail.com>
To: Choi Paul <cws7777@hotmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Question about the error of do_compile and oe_runmake failed in bitbake
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
X-List-Received-Date: Mon, 24 Jul 2017 17:50:54 -0000
Content-Type: multipart/alternative; boundary="94eb2c1988343c5b12055513db6c"

--94eb2c1988343c5b12055513db6c
Content-Type: text/plain; charset="UTF-8"

In batctl-2017.1 recipe file you are missing
Inherit pkgconfig

On Mon, Jul 24, 2017 at 6:49 AM Choi Paul <cws7777@hotmail.com> wrote:

> Hi,
>
> This is  Paul Choi who is  a beginner of yocto image building and having a
> hard time on error(shown in attached figure) when I build image by typing
> 'bitbake piflo' (piflo is the name of image)
>
> Originally, I was using batman-adv-2016.4.bb and batctl-2016.4.bb and it
> builds well before with typing 'bitbake piflo'.
>
> However, after upgrading batman-adv-2016.4 and batctl-2016.4 to 2017.1, it
> gives me some errors like figure.
>
>
> Here are error messages:
>
>
> ERROR: batctl-2017.1-r0 do_compile: oe_runmake failed
> ERROR: batctl-2017.1-r0 do_compile: Function failed: do_compile (log file
> is located at
> /opt/cws7777/rpi-build/tmp/work/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/batctl/2017.1-r0/temp/log.do_compile.24608)
> ERROR: Logfile of failure stored in:
> /opt/cws7777/rpi-build/tmp/work/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/batctl/2017.1-r0/temp/log.do_compile.24608
> Log data follows:
> | DEBUG: Executing shell function do_compile
> | NOTE: make -j 8 STAGING_INC=
> | Makefile:65: *** pkg-config not found.  Stop.
> | ERROR: oe_runmake failed
> | WARNING: exit code 1 from a shell command.
> | ERROR: Function failed: do_compile (log file is located at
> /opt/cws7777/rpi-build/tmp/work/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/batctl/2017.1-r0/temp/log.do_compile.24608)
> ERROR: Task
> (/opt/cws7777/meta-piflo/recipes-connectivity/batctl/batctl_2017.1.bb:do_compile)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 2553 tasks of which 2552 didn't need to be
> rerun and 1 failed.
>
> Summary: 1 task failed:
>   /opt/cws7777/meta-piflo/recipes-connectivity/batctl/batctl_2017.1.bb:
> do_compile
> Summary: There was 1 WARNING message shown.
> Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
>
>
>
> What did I do wrong..? or any suggestions?
>
>
> Thanks in advance.
>
>
> Best,
>
> Paul Choi
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--94eb2c1988343c5b12055513db6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">In=C2=A0<span style=3D"font-family:Calibri,Helvetica=
,sans-serif;word-spacing:1px;background-color:rgb(255,255,255)">batctl-2017=
.1 recipe file you are missing=C2=A0</span></div><div dir=3D"auto"><span st=
yle=3D"font-family:Calibri,Helvetica,sans-serif;word-spacing:1px;background=
-color:rgb(255,255,255)">Inherit pkgconfig=C2=A0</span></div><br><div class=
=3D"gmail_quote"><div>On Mon, Jul 24, 2017 at 6:49 AM Choi Paul &lt;<a href=
=3D"mailto:cws7777@hotmail.com">cws7777@hotmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">




<div>
<div id=3D"m_8359997283950438397divtagdefaultwrapper" style=3D"font-size:12=
pt;color:#000000;font-family:Calibri,Helvetica,sans-serif">
<p>Hi,</p>
<p>This is=C2=A0 Paul Choi who is =C2=A0a beginner of yocto image building=
=C2=A0and having a hard time on error(shown in attached=C2=A0figure) when I=
 build image by typing &#39;bitbake piflo&#39; (piflo is the name of image)=
</p>
<p>Originally,=C2=A0I was using <a href=3D"http://batman-adv-2016.4.bb" tar=
get=3D"_blank">batman-adv-2016.4.bb</a> and <a href=3D"http://batctl-2016.4=
.bb" target=3D"_blank">batctl-2016.4.bb</a> and it builds well before with =
typing &#39;bitbake piflo&#39;.</p>
<p>However, after upgrading batman-adv-2016.4 and batctl-2016.4 to 2017.1, =
it gives me some errors like figure.</p>
<p><br>
</p>
<p>Here are error messages:</p>
<p><br>
</p>
<p></p>
<div>ERROR: batctl-2017.1-r0 do_compile: oe_runmake failed</div>
<div>ERROR: batctl-2017.1-r0 do_compile: Function failed: do_compile (log f=
ile is located at /opt/cws7777/rpi-build/tmp/work/cortexa7hf-neon-vfpv4-pok=
y-linux-gnueabi/batctl/2017.1-r0/temp/log.do_compile.24608)</div>
<div>ERROR: Logfile of failure stored in: /opt/cws7777/rpi-build/tmp/work/c=
ortexa7hf-neon-vfpv4-poky-linux-gnueabi/batctl/2017.1-r0/temp/log.do_compil=
e.24608</div>
<div>Log data follows:</div>
<div>| DEBUG: Executing shell function do_compile</div>
<div>| NOTE: make -j 8 STAGING_INC=3D</div>
<div>| Makefile:65: *** pkg-config not found.=C2=A0 Stop.</div>
<div>| ERROR: oe_runmake failed</div>
<div>| WARNING: exit code 1 from a shell command.</div>
<div>| ERROR: Function failed: do_compile (log file is located at /opt/cws7=
777/rpi-build/tmp/work/cortexa7hf-neon-vfpv4-poky-linux-gnueabi/batctl/2017=
.1-r0/temp/log.do_compile.24608)</div>
<div>ERROR: Task (/opt/cws7777/meta-piflo/recipes-connectivity/batctl/batct=
l_2017.1.bb:do_compile) failed with exit code &#39;1&#39;</div>
<div>NOTE: Tasks Summary: Attempted 2553 tasks of which 2552 didn&#39;t nee=
d to be rerun and 1 failed.</div>
<div><br>
</div>
<div>Summary: 1 task failed:</div>
<div>=C2=A0 /opt/cws7777/meta-piflo/recipes-connectivity/batctl/batctl_2017=
.1.bb:do_compile</div>
<div>Summary: There was 1 WARNING message shown.</div>
<div>Summary: There were 2 ERROR messages shown, returning a non-zero exit =
code.</div>
<div><br>
</div>
<br>
<p></p>
<p><br>
</p>
<p>What did I do wrong..? or any suggestions?</p>
<p><br>
</p>
<p>Thanks in advance.</p>
<p><br>
</p>
<p>Best,</p>
<p>Paul Choi</p>
</div>
</div>

--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div></div>

--94eb2c1988343c5b12055513db6c--
