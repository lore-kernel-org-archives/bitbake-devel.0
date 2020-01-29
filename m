Return-Path: <maurofrqueiros@gmail.com>
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
	[209.85.217.41])
	by mail.openembedded.org (Postfix) with ESMTP id B2A9E60646
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jan 2020 13:51:46 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id g15so2107986vsf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jan 2020 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=fj9FhFsKdrnZRPl61Og+vt5X30gDe+VSQ3qyg7ffwao=;
	b=UcaYZaySUKCEUoDlG2usPvXTWzUQyccxHLlWeqwBGC5cAW3c27CdWqmFM0HtIyWhuu
	LQWB/qaZkruNJCNa75kyHC05lyka1yEzmfkMxX+D6AE5a07MkEpxpBoRH5RS669n5p/w
	REh58vJMBJ5rMab7Xxu+WtxlKzSIjPFRSSB2ZEHqVjH340L9xC1XJ+fz5zqTiR0vqmQs
	lAkVuaMsqyQcdygINJpNvWM9yNrAdfBaVPwfvw8+5PHfFC1s+wIukaK5vTqbqZqCJEAM
	/asAvODG/qk3tBiuacykfn4XT0p0L+imeb4pJkSPYs9/FbDuvcWbcM9gEboJjo57Tye6
	ueyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=fj9FhFsKdrnZRPl61Og+vt5X30gDe+VSQ3qyg7ffwao=;
	b=al4SngcuEhQwOlOkAiGxrSLiyscdGaPjJ+25aYhff8RJhUvCYNET+OvxZhB8M2rvs2
	1a8vZVFlmaZ5Wbpo1064+ehd6sffD84xMomYHCzfWLgQW6u7crFcSzDKNWb4AUEZMTBP
	1d0qboeedr4WeH+K4/vK6iFknicIROeZ3HaAWA4aNfdiHZDr7bN6GPtFoB5SuzdgLDsF
	TCi1yFU8v1+Kf4qE3OZ10GUJWSVPqvvvC6YYsGkwM0j9P4lm/6YuKB7TpMR22fuPYhMw
	Dgl8ckG09RrpyKLgLgaqibdmRiKXFQDLflMgVawIWF8lykb83X49BeYOblRIkD6Ai0T8
	jzwA==
X-Gm-Message-State: APjAAAVrz4Ewo0F4zZOfQQBZgOmoKp334nXfZVZHDyeLFoVcrnht58jC
	a6ftwEemNHxLfCt3SLUQLteBYgTPKsoKoouLwYORH2Ed
X-Google-Smtp-Source: APXvYqwqVJJG9zSJCSAqBkgJ+X1ae8v2+dqHls5RI38kSdcrNOv9EjPnasVRm3RzRKnN4qEHtaH0cevAA89ImF99lQM=
X-Received: by 2002:ac5:cdcd:: with SMTP id u13mr16577162vkn.0.1580300510959; 
	Wed, 29 Jan 2020 04:21:50 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Mauro_Queir=C3=B3s?= <maurofrqueiros@gmail.com>
Date: Wed, 29 Jan 2020 12:21:40 +0000
Message-ID: <CAOev9BfgUF4yCYYVwtLm1jQCKjwdTJPc5XHtPtrKq-vFzkdP_A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 10 Feb 2020 14:14:47 +0000
Subject: git-lfs validation
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
X-List-Received-Date: Fri, 31 Jan 2020 09:28:01 -0000
Content-Type: multipart/alternative; boundary="000000000000981c7e059d46626b"

--000000000000981c7e059d46626b
Content-Type: text/plain; charset="UTF-8"

Hi,



I noticed two things related to git-lfs on
poky/bitbake/lib/bb/fetch2/git.py, which I think may me improved:



First, git.py seems to always check the master branch when looking for lfs
objects (_contains_lfs function), even when the branch is specified in
SRC_URI;



Second, the warning message "Repository %s has LFS content but it is not
being fetched" is printed even when git-lfs is available and "lfs=1" is set.



I could also provide a patch if you think these two issues make sense.

--000000000000981c7e059d46626b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">











<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">H=
i, </p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">=
=C2=A0</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">I=
 noticed two things related to git-lfs on poky/bitbake/lib/bb/fetch2/git.py=
, which I think
may me improved:</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">=
=C2=A0</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">F=
irst,
git.py seems to always check the master branch when looking for lfs objects
(_contains_lfs function), even when the branch is specified in SRC_URI;</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">=
=C2=A0</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">S=
econd,
the warning message &quot;Repository %s has LFS content but it is not being
fetched&quot; is printed even when git-lfs is available and &quot;lfs=3D1&q=
uot;
is set.</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">=
=C2=A0</p>

<p style=3D"margin:0in;font-family:Calibri;font-size:11pt" lang=3D"en-US">I=
 could also provide a patch if you think these two issues make sense.<br></=
p>





</div>

--000000000000981c7e059d46626b--
