Return-Path: <rob.woolleywr@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 0F81077D52
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Jun 2017 21:02:20 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id y5so2411981wmh.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Jun 2017 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:from:date:message-id:subject:to:cc;
	bh=SbfKP8M7OoO//xUHIkwnhPaffRcskx19xpU8gJBlyzw=;
	b=HX33GErXva0WMhWl/4yBgzRvPBF/h0KMHaw/QHPRjejZO/pVmH22r3wQudNgNxh4v8
	Cm01ejb7dFU8zcAV+LUeLTY7XmFRhhbNFsHPXjZRW51eqseeutvd8nvgNqkF86dOD70e
	1pyVSOEpsXjW5A9E1xJldjrzS2XPFUtw29dYyWlWvUV2VjzMb9R9KpYnuBhVhsi+K8ak
	Rv4Yauwa4I245LorgPw3DMIMwSob+qj9pR/NZVjpIyKM63CxCOXd5ZY71PVQyj97OeIj
	pi4yGn7W7efMTWxrAjRpXRzp2Ai3dxhDJI6o+/+zYteFo7Sx4z1q8bR/k9ArvW7ioES7
	JLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
	:to:cc;
	bh=SbfKP8M7OoO//xUHIkwnhPaffRcskx19xpU8gJBlyzw=;
	b=JCfqDn+WKQsCxdAHUSEPXSh2A+AStrbppCKrLl+5YmHIQbV7kbpfQmA88qQzXkRBmK
	TqJxnyZ7lqBgLUPqeIlOwmYFxZey8Eg20Bwny/50CSPmjE7ruQEhEaJDEjDrx+xPoKKP
	5wvmoIDHtoAShqhy5wcvunwe6bB5ImOXqQ05diC/YDj3llrqVxkZ/J/pvVQvWKVnI8Ww
	XFONSHTkI4ryb+1SVdrgSv7+Jtm9VCVGNZ2hVLwoUSBYCJd+cQLGynGLrq6h5AkWSZzI
	VEunGvVPKikoJQ+EWi9YmLSp9lREW+YzV5LDCSQ85D3hz4dxj4rHBi+jYg+7ewQveFBn
	ZIRA==
X-Gm-Message-State: AKS2vOzSl9sWwfKJKFlyCLWXEUpscc3QUXWB9BTmavJ9nbJWlPUxmwi3
	WKjPMmXpfnwo34LqSuMEHlS2Q7vtDw==
X-Received: by 10.28.209.70 with SMTP id i67mr978076wmg.3.1498510941566; Mon,
	26 Jun 2017 14:02:21 -0700 (PDT)
MIME-Version: 1.0
Sender: rob.woolleywr@gmail.com
Received: by 10.28.113.195 with HTTP; Mon, 26 Jun 2017 14:02:20 -0700 (PDT)
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 26 Jun 2017 17:02:20 -0400
X-Google-Sender-Auth: kSNXt1kRhfR-hB6-qxCMZpRjFKk
Message-ID: <CAGAhMBywmKF1GnYYsMEDoLLWJLivMrC7AmtMPh2wT6ju7RKgdQ@mail.gmail.com>
To: Diana Thayer <garbados@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake : Paginate 'bitbake -e' using less.
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
X-List-Received-Date: Mon, 26 Jun 2017 21:02:21 -0000
Content-Type: multipart/alternative; boundary="94eb2c1313f65d3f4f0552e34468"

--94eb2c1313f65d3f4f0552e34468
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Feel free to grab pieces from here, if you find it useful:
https://patchwork.openembedded.org/patch/89543/

I based it on the same logic used by git to determine whether the user had
a pager set already and whether or not the output was going to the terminal
or being piped to another process.

The feedback I got was that the functionality wasn't needed and users could
just pipe it to less if they wanted a pager:
http://lists.openembedded.org/pipermail/bitbake-devel/2015-March/005545.htm=
l

Regards,
Rob

On Mon, Jun 26, 2017 at 4:48 PM, Diana Thayer <garbados@gmail.com> wrote:

> Thank you for the feedback!
>
> I've added lines to check $OE_PAGER and $PAGER, such that `PAGER=3Dcat
> bitbake -e` effectively disables pagination.
>
> Regarding the option '--paginate', would it capture output from whatever
> command has run? I'm not sure how to capture stdout at such a scope.
>
>
> On Tue, Jun 20, 2017 at 6:39 AM, Peter Kjellerstedt <
> peter.kjellerstedt@axis.com> wrote:
>
>> Basically, this change needs to be aware of the destination for the
>> output. If it is a tty, then it is fine to output to a viewer such as le=
ss,
>> but otherwise it should go to stdout as before. This should of course no=
t
>> be hardcoded, but use environment variables, e.g., $OE_PAGER || $PAGER |=
|
>> less (inspired by git_pager() in the git source). You should also not
>> expect that everyone wants the options you have used for less. Looking
>> again at how git handles this, they use =E2=80=9CLESS=3DFRX <command>=E2=
=80=9D if the $LESS
>> environment variable is not set, and does not modify it if it is set. Yo=
u
>> also want to add options such as --paginate and --no-pager (yet again
>> inspired by git) to bitbake.
>>
>>
>>
>> All in all, look at and be inspired by how git handles pagers, they have
>> this pretty well covered.
>>
>>
>>
>> //Peter
>>
>>
>>
>> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
>> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *Burton, Ros=
s
>> *Sent:* den 20 juni 2017 12:06
>> *To:* Diana Thayer <garbados@gmail.com>
>> *Cc:* bitbake-devel <bitbake-devel@lists.openembedded.org>
>> *Subject:* Re: [bitbake-devel] [PATCH] bitbake : Paginate 'bitbake -e'
>> using less.
>>
>>
>>
>>
>>
>> On 20 June 2017 at 05:54, Diana Thayer <garbados@gmail.com> wrote:
>>
>> +        pager =3D subprocess.Popen(['less', '-F', '-R', '-S', '-X', '-K=
'],
>> +                                 stdin=3Dsubprocess.PIPE,
>> +                                 stdout=3Dsys.stdout,
>> +                                 universal_newlines=3DTrue)
>>
>>
>> What if I'm piping bitbake -e though grep or into a file already?
>>
>>
>>
>> Ross
>>
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--94eb2c1313f65d3f4f0552e34468
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Feel free to grab pieces from h=
ere, if you find it useful:=C2=A0<a href=3D"https://patchwork.openembedded.=
org/patch/89543/">https://patchwork.openembedded.org/patch/89543/</a></div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I based it =
on the same logic used by git to determine whether the user had a pager set=
 already and whether or not the output was going to the terminal or being p=
iped to another process.</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">The feedback I got was that the functionality wasn&#39;t=
 needed and users could just pipe it to less if they wanted a pager:=C2=A0<=
a href=3D"http://lists.openembedded.org/pipermail/bitbake-devel/2015-March/=
005545.html">http://lists.openembedded.org/pipermail/bitbake-devel/2015-Mar=
ch/005545.html</a></div><div class=3D"gmail_extra"><br>Regards,<br>Rob</div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jun 26, =
2017 at 4:48 PM, Diana Thayer <span dir=3D"ltr">&lt;<a href=3D"mailto:garba=
dos@gmail.com" target=3D"_blank">garbados@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Thank =
you for the feedback!<div><br></div><div>I&#39;ve added lines to check $OE_=
PAGER and $PAGER, such that `PAGER=3Dcat bitbake -e` effectively disables p=
agination.</div><div><br></div><div>Regarding the option &#39;--paginate&#3=
9;, would it capture output from whatever command has run? I&#39;m not sure=
 how to capture stdout at such a scope.</div><div><br></div></div><div clas=
s=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Tue, Jun 20, 2017 at 6:39 AM, Peter Kjellerste=
dt <span dir=3D"ltr">&lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" tar=
get=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"SV">
<div class=3D"gmail-m_-1063956160762219362m_-2171653402677448379WordSection=
1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)">Basically, this change needs =
to be aware of the destination for the output. If it is a tty, then it is f=
ine to output
 to a viewer such as less, but otherwise it should go to stdout as before. =
This should of course not be hardcoded, but use environment variables, e.g.=
, $OE_PAGER || $PAGER || less (inspired by git_pager() in the git source). =
You should also not expect that
 everyone wants the options you have used for less. Looking again at how gi=
t handles this, they use =E2=80=9CLESS=3DFRX &lt;command&gt;=E2=80=9D if th=
e $LESS environment variable is not set, and does not modify it if it is se=
t. You also want to add options such as --paginate and --no-pager
 (yet again inspired by git) to bitbake.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)"><u></u>=C2=A0<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)">All in all, look at and be in=
spired by how git handles pagers, they have this pretty well covered.<u></u=
><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)"><u></u>=C2=A0<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)">//Peter<u></u><u></u></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(148,54,52)"><u></u>=C2=A0<u></u></span></=
p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0cm 0cm 0cm 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11pt;font=
-family:Calibri,sans-serif">From:</span></b><span lang=3D"EN-US" style=3D"f=
ont-size:11pt;font-family:Calibri,sans-serif"> <a href=3D"mailto:bitbake-de=
vel-bounces@lists.openembedded.org" target=3D"_blank">bitbake-devel-bounces=
@lists.op<wbr>enembedded.org</a> [mailto:<a href=3D"mailto:bitbake-devel-bo=
unces@lists.openembedded.org" target=3D"_blank">bitbake-devel-bounces@<wbr>=
lists.openembedded.org</a>]
<b>On Behalf Of </b>Burton, Ross<br>
<b>Sent:</b> den 20 juni 2017 12:06<br>
<b>To:</b> Diana Thayer &lt;<a href=3D"mailto:garbados@gmail.com" target=3D=
"_blank">garbados@gmail.com</a>&gt;<br>
<b>Cc:</b> bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembe=
dded.org" target=3D"_blank">bitbake-devel@lists.openembed<wbr>ded.org</a>&g=
t;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] bitbake : Paginate &#39;bitbake=
 -e&#39; using less.<u></u><u></u></span></p>
</div>
</div><div><div class=3D"gmail-m_-1063956160762219362h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">On 20 June 2017 at 05:54, Diana Thayer &lt;<a href=
=3D"mailto:garbados@gmail.com" target=3D"_blank">garbados@gmail.com</a>&gt;=
 wrote:<u></u><u></u></p>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0cm 0cm 0cm 6pt;margin-left:4=
.8pt;margin-right:0cm">
<div id=3D"gmail-m_-1063956160762219362m_-2171653402677448379:9ou">
<p class=3D"MsoNormal">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pager =3D subprocess.Po=
pen([&#39;less&#39;, &#39;-F&#39;, &#39;-R&#39;, &#39;-S&#39;, &#39;-X&#39;=
, &#39;-K&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdin=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsys.stdout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0universal_newlines=3DTrue)<u><=
/u><u></u></p>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal"><br>
What if I&#39;m piping bitbake -e though grep or into a file already?<u></u=
><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Ross<u></u><u></u></p>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>
</div></div><br>--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
<br></blockquote></div><br></div></div>

--94eb2c1313f65d3f4f0552e34468--
