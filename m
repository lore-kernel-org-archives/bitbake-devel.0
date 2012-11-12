Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TXja0-0004VP-Qy
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Nov 2012 03:16:53 +0100
Received: by mail-ia0-f175.google.com with SMTP id z3so728968iad.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2012 18:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=6nMrUNVRANiqLpCa2v2xSukcOEHqnc9dr93hEkGIgvI=;
	b=ZR5hVt+VHWcJxgwAYbDKjjMMREGVqnnN+q/FgU/ZOEkL75oP5MhRgZoT1HD5c3CMtT
	/1xJ2kcvky7cvCXLW8xuf3rLYFsM+qzYnbg8De/zjG57cR848r9CV+P9JmINu4wlE4T9
	SvW6OWlCLs9H87A9XeY0v43Z3ZNxIkomdnVR8CQrfUsCpqEso+z4JritUpEJ2QR8R3E+
	BDon92uRJBwXgh3Soe8j2E3HUU5C/R006QpDc8HNlHPCNBxVUAmmUjvGBBJPcQnqa+4Q
	n4j9MZcGmr6k5LMfxsz19nvVV4W1CMpY8Rtf28tjnK0i05ADQV/z9AjTvR098oIgdCN4
	nxHg==
MIME-Version: 1.0
Received: by 10.50.0.168 with SMTP id 8mr6742269igf.36.1352685780154; Sun, 11
	Nov 2012 18:03:00 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Sun, 11 Nov 2012 18:02:59 -0800 (PST)
In-Reply-To: <CABcZANkEh-RvPBDRcGAbu3R=SBMrkqxFThjuvBwgj8Y2WuhLuQ@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<CABcZANkEh-RvPBDRcGAbu3R=SBMrkqxFThjuvBwgj8Y2WuhLuQ@mail.gmail.com>
Date: Sun, 11 Nov 2012 20:02:59 -0600
Message-ID: <CA+JN8xNCoawwA2Nu1-7fh5kH1w7uPpKVJCbB==ua3OyzTTs+bQ@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 12 Nov 2012 02:16:53 -0000
Content-Type: multipart/alternative; boundary=e89a8f5034e86b396604ce42b3a9

--e89a8f5034e86b396604ce42b3a9
Content-Type: text/plain; charset=ISO-8859-1

color_enabled is initialized on line 58 of msg.py.  I did this in the same
way as other class variables are initialized.

    levelnames = {
        DEBUG3   : 'DEBUG',
        DEBUG2   : 'DEBUG',
        DEBUG   : 'DEBUG',
        VERBOSE: 'NOTE',
        NOTE    : 'NOTE',
        PLAIN  : '',
        WARNING : 'WARNING',
        ERROR   : 'ERROR',
        CRITICAL: 'ERROR',
    }

    color_enabled = False
    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(30,38)


On Sun, Nov 11, 2012 at 4:54 PM, Chris Larson <clarson@kergoth.com> wrote:

>
>
> On Sun, Nov 11, 2012 at 8:17 AM, Seth Bollinger <seth.boll@gmail.com>wrote:
>
>> @@ -67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):
>>          if record.levelno == self.PLAIN:
>>              msg = record.getMessage()
>>          else:
>> +            if self.color_enabled:
>> +                self.colorize(record)
>>
>
>
> I'm not seeing your definition of color_enabled in the constructor.
> Wouldn't this attribute not exist when it's first created, before
> enable_color() is called? Have you tested this with a non-interactive
> terminal? I'd think you'd want a self.color_enabled = False in the
> constructor for the formatter.
> --
> Christopher Larson
>

--e89a8f5034e86b396604ce42b3a9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

color_enabled is initialized on line 58 of msg.py. =A0I did this in the sam=
e way as other class variables are initialized.<div><br></div><div><div>=A0=
 =A0 levelnames =3D {</div><div>=A0 =A0 =A0 =A0 DEBUG3 =A0 : &#39;DEBUG&#39=
;,</div><div>=A0 =A0 =A0 =A0 DEBUG2 =A0 : &#39;DEBUG&#39;,</div>
<div>=A0 =A0 =A0 =A0 DEBUG =A0 : &#39;DEBUG&#39;,</div><div>=A0 =A0 =A0 =A0=
 VERBOSE: &#39;NOTE&#39;,</div><div>=A0 =A0 =A0 =A0 NOTE =A0 =A0: &#39;NOTE=
&#39;,</div><div>=A0 =A0 =A0 =A0 PLAIN =A0: &#39;&#39;,</div><div>=A0 =A0 =
=A0 =A0 WARNING : &#39;WARNING&#39;,</div><div>
=A0 =A0 =A0 =A0 ERROR =A0 : &#39;ERROR&#39;,</div><div>=A0 =A0 =A0 =A0 CRIT=
ICAL: &#39;ERROR&#39;,</div><div>=A0 =A0 }</div><div><br></div><div>=A0 =A0=
 color_enabled =3D False</div><div>=A0 =A0 BLACK, RED, GREEN, YELLOW, BLUE,=
 MAGENTA, CYAN, WHITE =3D range(30,38)</div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Sun,=
 Nov 11, 2012 at 4:54 PM, Chris Larson <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:clarson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Sun, Nov 11, 2012 at 8:17 AM, Seth Bollinger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:seth.boll@gmail.com" target=3D"_blank">seth.=
boll@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><font face=3D"arial, sans-serif">@@ -67=
,6 +86,8 @@ class BBLogFormatter(logging.Formatter):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0if record.levelno =
=3D=3D self.PLAIN:</font></div><div><font face=3D"arial, sans-serif">=A0 =
=A0 =A0 =A0 =A0 =A0 =A0msg =3D record.getMessage()</font></div><div><font f=
ace=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0else:</font></div>



<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0if self.colo=
r_enabled:</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0self.colorize(record)</font></div></blockquote></div><br=
><br>I&#39;m not seeing your definition of color_enabled in the constructor=
. Wouldn&#39;t this attribute not exist when it&#39;s first created, before=
 enable_color() is called? Have you tested this with a non-interactive term=
inal? I&#39;d think you&#39;d want a self.color_enabled =3D False in the co=
nstructor for the formatter.<span class=3D"HOEnZb"><font color=3D"#888888">=
<br>


-- <br>Christopher Larson<br>
</font></span></div>
</blockquote></div><br></div>

--e89a8f5034e86b396604ce42b3a9--
