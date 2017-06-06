Return-Path: <vijaikumar.k@mistralsolutions.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail.openembedded.org (Postfix) with ESMTP id 1348F60621
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Jun 2017 07:11:11 +0000 (UTC)
Received: by mail-wr0-f171.google.com with SMTP id g76so49491422wrd.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Jun 2017 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mistralsolutions.com; s=dkim;
	h=mime-version:from:date:message-id:subject:to;
	bh=TtjzEnXJjTaU4ivmaUYAXYOzRpwL0FEPUX0UvytzJ44=;
	b=qn5DmI+vdr3rpmmEGu7iQfm1QajYeInq5WRrS4zoWqZvOWGRD2lulOzatQOUdnSsGy
	jnZm4wq5Rq0jgL93oL8QcZVl/r+yk8RCYlvtRyelxuD9d6jAxlC7/5MnsPpcSsQZNxLw
	uTqg326RzJuEeRBdbKUHmaN7alrQKobKza0b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=TtjzEnXJjTaU4ivmaUYAXYOzRpwL0FEPUX0UvytzJ44=;
	b=PEar9+YnTSdVGNcCjDiJMq3ydPI/nc4dmE9KLsChaUiry48N3ZOxgGFd149PU5PAen
	Niih5xlhLPq/+yIBqtClIZZJAP61L5wXBzo4T1bCQW2t3QdnnN7MPwviOJ5GZRyNj2zu
	WXjHwQftd5qzKxL004FVIyqOSbMPKDCByju/WgzOqFNob4ykmf5Su2Jj19lPX5KYEVwV
	YTlxCkOi4RuwyuLkhtQMwMfuNuGPu6gjDQ8SbkYKOHzmEHBsemHky64We64j2AG1UMTy
	LFk5wFhUf+39FREfMLUb61YPWWL4OCuZKxJ5myzF1XXihsqI11pwaBdj4cZt0TGpj9d0
	kBBg==
X-Gm-Message-State: AODbwcCLCT4T6ysZ5y5v9dpV0wTDVe4qpya/P9+UnYwpOOIzn7CnAOX5
	UUijIAKI2NEDJiECy/p33rHrg718FZOW
X-Received: by 10.223.129.4 with SMTP id 4mr4688918wrm.153.1496733072026; Tue,
	06 Jun 2017 00:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.203 with HTTP; Tue, 6 Jun 2017 00:10:51 -0700 (PDT)
From: vijaikumar k <vijaikumar.k@mistralsolutions.com>
Date: Tue, 6 Jun 2017 12:40:51 +0530
Message-ID: <CADOTBT0yMKs1LgmsG3gb+hSsprAzu6Osp2tcrOyYsc6uEjV-Wg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sat, 10 Jun 2017 07:41:56 +0000
Subject: Overriding bitbake functions
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
X-List-Received-Date: Tue, 06 Jun 2017 07:11:15 -0000
Content-Type: multipart/alternative; boundary="94eb2c0685981503160551455314"

--94eb2c0685981503160551455314
Content-Type: text/plain; charset="UTF-8"

Hi All,

I need to override an append function in bitbake. Just wondering if there
is a way to do it.

do_configure()
do_configure_append()
do_configure_append_mymachine()

I want to replace/override do_configure_append() with
do_configure_append_mymachine(). Is this possible? I do not want to disturb
do_configure and do_configure_append function. All the functions are in the
same bb file.

Thanks,
Vijai Kumar K

--94eb2c0685981503160551455314
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif;color:#073763">Hi All,</div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif;color:#073763"><br></div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
;color:#073763">I need to override an append function=C2=A0in bitbake. Just=
 wondering if there is a way to do it.</div><div class=3D"gmail_default" st=
yle=3D"font-family:arial,helvetica,sans-serif;color:#073763"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif;co=
lor:#073763">do_configure()</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif;color:#073763">do_configure_append()</di=
v><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-se=
rif;color:#073763">do_configure_append_mymachine()</div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif;color:#073763"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,s=
ans-serif;color:#073763">I want to replace/override do_configure_append() w=
ith do_configure_append_mymachine(). Is this possible? I do not want to dis=
turb do_configure and do_configure_append function. All the functions are i=
n the same bb file.</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif;color:#073763"><br></div><div><div class=3D"gmai=
l_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div =
dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"lt=
r"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div><span style=3D"color:rgb(7,55,99)">Thanks,<br></span></div><div><span s=
tyle=3D"color:rgb(7,55,99)">Vijai Kumar K</span><br></div></div></div></div=
></div></div></div></div></div></div></div></div></div></div></div></div></=
div></div></div>
</div>

--94eb2c0685981503160551455314--
