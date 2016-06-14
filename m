Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
	[209.85.214.67])
	by mail.openembedded.org (Postfix) with ESMTP id 5C8586612C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 19:00:57 +0000 (UTC)
Received: by mail-it0-f67.google.com with SMTP id d71so407723ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=1S7QWMZKWC5uRIvaeQSlV7M8yMgpRZT90gb0jhsFEAA=;
	b=zm6xQJPJg2AXDVdUw+nvFbeJGvoMNWTgC6sJhkBJsSpNx8DvQhyXxRatwFOzJvlyt+
	TZbfzIbymZTXInD2JCpTydAZNUiWbn+ibv/SLQpktJlZG0qw7fjJOQSTCLL/bBdFYJXx
	JNanQ5o+LoFQZctV76y+7SSKZ1tSpCiKF/3iGAIJc5MkgTRRfbs5jj5Rsi+9xzVuCqdK
	ZZVe+eWphlWqOskgNVLLy2NJsKncdoVR9obdEflYoqfgZUxxENe4jkg7O2iXOyA3A4wh
	aBiwls2yL8EYyoFhBuR60nzPrgs1S0wj6NfLe3+935QP9xCHg4MRxpyG04E7NQ4QZDpL
	04Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=1S7QWMZKWC5uRIvaeQSlV7M8yMgpRZT90gb0jhsFEAA=;
	b=OyVP5/oaJOQe92olCb/kcSd8HotSfElyVQjEM2r7YepxM6TTRPz13ieuBa3KTsQ3Kw
	eb25xmUiiKe9AsU7qxZKGGFNspDDdi8isXaU/+aOhtbeRH8rrHEs2hBP2hmo5D8CqxDB
	RYQgbKGmjAuhL5/M4xjD1myBhI92M8gLLnIsq+AnKAJZ8GDirKC1u3+r6AL15kOvkeJZ
	hEPQygxRownKDUe4hcJIw7A7FeEyqh6r8LcVDR6Hpw9hkFTCFe2xGsKLJ2U1+w2AWmLp
	Q6Ah3dKNlJwO0MHJ/USlFIV6ClIGb1c786bA9EETHdSkQviOx2xk8pOp2j6VLw4Rqd8A
	uQMw==
X-Gm-Message-State: ALyK8tIL5osqYkRzgQpt7poSV8m8DSS+sFmg3AfJ8YaraX1ddkJExcBGqhKRQQSy3os6CJVj9Pnc/iV4ur8lBQ==
X-Received: by 10.36.53.145 with SMTP id k139mr11174174ita.66.1465930858215;
	Tue, 14 Jun 2016 12:00:58 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.130.66 with HTTP; Tue, 14 Jun 2016 12:00:38 -0700 (PDT)
In-Reply-To: <6ba89ed1550846468db3183a33ec1435@PACDCEX33.cable.comcast.com>
References: <9547b470c88646879f86e63f4371ad71@VAADCEX01.cable.comcast.com>
	<CABcZANmO0ymS8uUFq-GRdwi4LHm+aKwLjWRSfnafqYytNKGmOw@mail.gmail.com>
	<6ba89ed1550846468db3183a33ec1435@PACDCEX33.cable.comcast.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 14 Jun 2016 12:00:38 -0700
X-Google-Sender-Auth: lk7GiHUrXJ6a70dMghE2KjfOymE
Message-ID: <CABcZANkPNCXaxk-5WMWPgdEqWB9jodo0PpMUV_Gk4TRybk6UhA@mail.gmail.com>
To: "Nair, Sandeep (Contractor)" <Sandeep_Nair2@cable.comcast.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Random Bitbake build failures
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
X-List-Received-Date: Tue, 14 Jun 2016 19:00:58 -0000
Content-Type: multipart/alternative; boundary=001a114a93d811bebe053541a0e4

--001a114a93d811bebe053541a0e4
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 14, 2016 at 11:44 AM, Nair, Sandeep (Contractor) <
Sandeep_Nair2@cable.comcast.com> wrote:

> Thanks for the details. Please find the additional details based on your
> feedback
>
>
>
> >>remote side? bitbake builds have never been supported on nfs.
>
>
>
> We mount remote folders and bitbake sees these as a regular folder. Since
> this can be treated as a regular folder, we may not need nfs support in
> bitbake.
>

That's not actually the case, because bitbake needs certain reliable
features of the filesystem, particularly locking, which are problematic on
nfs. It's not completely transparent. You can likely use nfs for
SSTATE_DIR/DL_DIR, though, just not the tmp dir where builds occur.

>> But yes, generally the real task runs if the setscene fails.
>
>
>
> We do the real task when sstate cache fetch fails and we are trying to
> identify the reason why bitbake returns 1 (which happens when error count
> != 0) even when real task succeeds.  We see that Bitbake returns 1 in this
> case which causes random build failure even when the real task was
> performed successfully.
>

If that's actually the case, I'd say it's a bug. sstate fetch failure
shouldn't show error messages, the user doesn't care. I had a bug open for
a similar case at https://bugzilla.yoctoproject.org/show_bug.cgi?id=4499.
I'd suggest setting ;downloadfilename=PATH on the replacement side of the
sstate mirrors (this is automatic in very recent yocto, but wasn't in the
past), as is mentioned in that issue.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114a93d811bebe053541a0e4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 14, 2016 at 11:44 AM, Nair, Sandeep (Contractor) <span dir=3D"l=
tr">&lt;<a href=3D"mailto:Sandeep_Nair2@cable.comcast.com" target=3D"_blank=
">Sandeep_Nair2@cable.comcast.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
><p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,s=
ans-serif;color:rgb(31,73,125)">Thanks for the details. Please find the add=
itional details based on your feedback<u></u><u></u></span></p><span class=
=3D"">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">&gt;&gt;remote side? bitbake builds have never been =
supported on nfs.<span style=3D"font-size:11pt;font-family:Calibri,sans-ser=
if;color:rgb(31,73,125)">=C2=A0
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
</span><p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Cal=
ibri,sans-serif;color:rgb(31,73,125)">We mount remote folders and bitbake s=
ees these as a regular folder. Since this can be treated as a regular folde=
r, we may not need nfs support in bitbake.</span></p></blockquote><div><br>=
</div><div>That&#39;s not actually the case, because bitbake needs certain =
reliable features of the filesystem, particularly locking, which are proble=
matic on nfs. It&#39;s not completely transparent. You can likely use nfs f=
or SSTATE_DIR/DL_DIR, though, just not the tmp dir where builds occur.=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex"><span class=3D"">
<p class=3D"MsoNormal">&gt;&gt; But yes, generally the real task runs if th=
e setscene fails.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</span><p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Cal=
ibri,sans-serif;color:rgb(31,73,125)">We do the real task when sstate cache=
 fetch fails and we are trying to identify the reason why bitbake returns 1=
 (which happens when error count !=3D 0) even when
 real task succeeds.=C2=A0 We see that Bitbake returns 1 in this case which=
 causes random build failure even when the real task was performed successf=
ully.</span></p></blockquote></div><br>If that&#39;s actually the case, I&#=
39;d say it&#39;s a bug. sstate fetch failure shouldn&#39;t show error mess=
ages, the user doesn&#39;t care. I had a bug open for a similar case at=C2=
=A0<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D4499">htt=
ps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D4499</a>. I&#39;d suggest =
setting ;<span style=3D"color:rgb(0,0,0);white-space:pre-wrap">downloadfile=
name=3DPATH on the replacement side of the sstate mirrors (this is automati=
c in very recent yocto, but wasn&#39;t in the past), as is mentioned in tha=
t issue.</span><br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>Founde=
r - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Softw=
are Engineer, Mentor Graphics</div>
</div></div>

--001a114a93d811bebe053541a0e4--
