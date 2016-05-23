Return-Path: <ross.burton@intel.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 57BC760290
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 20:09:21 +0000 (UTC)
Received: by mail-ig0-f180.google.com with SMTP id l10so30459310igk.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=+W2zQ5JstIrUOWaB4qxYtAP3ujyL8vb5f2MqD4HM3wA=;
	b=WXbUHLwwOtzXDprWTS0xBY0etnuJG1Ra+5xzVc3i1HSv3aOmmK/6v5rbqhjl6iKkd7
	dd5RrGs/l6Ywt1s7DzXsU1U2We6LxvHc7UiogsQUO5IoqjWf9hxCPHagIP98/dXAgOum
	Q8LpeDjBy10hUypM5H7DC4ixJ5tlFcu8frutCDPtPK9TUHv3D2HgX7AnwjTMnL798CKW
	iAJ9aEPM2ZVMoDCf0NW+GEfyUhp59UGMR1qStt8m9KgTwx4zt/mN/jdHnwWhwdM6lssP
	KkG5naKI1HtiCt3bSbrBtnRb+ctrRmNjz3KUwC0xCS/jZNByS3/tTbpgbiqenNWgW9sD
	ttRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=+W2zQ5JstIrUOWaB4qxYtAP3ujyL8vb5f2MqD4HM3wA=;
	b=cMMGUSb8E3Mx/gljNKJvNIDW6QixOWJATGvdHd4D8ttHZqbml4/m2FGbdr+fiMDh8Q
	XZFfXApYMDN89BmNM6IFuRw0DLMUbvrdQecFlkExfMhtNivTKVdz8YHq6yGOynrztoO4
	tf3CAuC9aufFYRa46ybtu/SmCGxhVj1n5XveZkC3nxPddUSV6gaIPb4PlfjA7jQ4VDc/
	iyx1woSis68waFxVKqqO1ru84tpMIJDq19h6vFEY7933yt41x/jsx7RtCoUV/kZQGoXu
	qLEO0BbSIoPP9H50NrP5SpW++D6I3GoXKNmvwSgvCdK1oLJqee5M9Bm5EktRIhY4l24/
	dZhA==
X-Gm-Message-State: AOPr4FUp/S/K3XqEhjQ6splDkyGFz/4cELeRbQL+9GCe6opbBvS2/YYhmoCfRWz2dKjixqc6hnJsK2rZGEV793lP
X-Received: by 10.50.119.67 with SMTP id ks3mr14937558igb.78.1464034162386;
	Mon, 23 May 2016 13:09:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.162.6 with HTTP; Mon, 23 May 2016 13:09:02 -0700 (PDT)
In-Reply-To: <03f101d1b529$74cdb560$5e692020$@tekmagic.net>
References: <03d601d1b528$7bca9b90$735fd2b0$@tekmagic.net>
	<03e401d1b529$3aaa2210$affe6630$@tekmagic.net>
	<03f101d1b529$74cdb560$5e692020$@tekmagic.net>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 23 May 2016 21:09:02 +0100
Message-ID: <CAJTo0LaT2gdqyv+XkUPofOj+NYsmGT0eqKN6XQEtPpkwqb_gqg@mail.gmail.com>
To: "gerard.b@tekmagic.net" <gerard.b@tekmagic.net>
Cc: Denis Carikli <denis@eukrea.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: libsoup build error in master (missing gssapi/gssapi.h ?)
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
X-List-Received-Date: Mon, 23 May 2016 20:09:22 -0000
Content-Type: multipart/alternative; boundary=089e011847f630bf3d05338804e3

--089e011847f630bf3d05338804e3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23 May 2016 at 20:29, Gerard Bucas <gerard.b@tekmagic.net> wrote:

> *I have been trying to build yocto with chromium but keep on getting a
> libsoup error that I can=E2=80=99t seem to resolve.*
>
>
>
> *Looks like: *fatal error: gssapi/gssapi.h: No such file or directory
>
>
Update to current master, this has just been fixed.

Also for support like this for recipe in oe-core, please stick to yocto@ or
oe-core@.

Ross

--089e011847f630bf3d05338804e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 23 May 2016 at 20:29, Gerard Bucas <span dir=3D"ltr">&lt;<a href=3D"mail=
to:gerard.b@tekmagic.net" target=3D"_blank">gerard.b@tekmagic.net</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><p class=3D"MsoNormal"><b><s=
pan style=3D"font-size:14.0pt">I have been trying to build yocto with chrom=
ium but keep on getting a libsoup error that I can=E2=80=99t seem to resolv=
e.<u></u><u></u></span></b></p><p class=3D"MsoNormal"><b><span style=3D"fon=
t-size:14.0pt"><u></u>=C2=A0<u></u></span></b></p><p class=3D"MsoNormal"><b=
><span style=3D"font-size:14.0pt">Looks like: </span></b><code><span style=
=3D"font-size:10.0pt">fatal error: gssapi/gssapi.h: No such file or directo=
ry<u></u><u></u></span></code></p><p class=3D"MsoNormal"></p></blockquote><=
/div><br>Update to current master, this has just been fixed.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Also for support lik=
e this for recipe in oe-core, please stick to yocto@ or oe-core@.</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div=
>

--089e011847f630bf3d05338804e3--
