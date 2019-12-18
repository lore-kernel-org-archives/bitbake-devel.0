Return-Path: <timblaktu@gmail.com>
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
	[209.85.210.44])
	by mail.openembedded.org (Postfix) with ESMTP id 153297FCBA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2019 00:17:18 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id p8so118596oth.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2019 16:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=O1yDY8uJcYBj3szeuFebxogS5cbFJv1FEnuHHhpw5aI=;
	b=cKddvBFlJVYeAAo2c/c99PSV82A8YxKt9CFxt18AmFbwQCtxP2R/K3oQpBgU3Gmrm4
	YGjXqmvOo4IIbsnXq7TLUUhSZ5TGTB83WO3JXeevxB9ALT5DxW3L5aLBeJoOO+lrXrwT
	xXlyVLug8nENZyJk6WUuMlewbnudzQU88fQWghO8prB17ZSGlM2lXKtU/ipDc79TISlR
	CjfB+YZLLz/19N6aBaysfzzynQED7ovSpBK/ZeSFW7fIJfrkcGwj3+/h2eGhXNcvQf/S
	hxcTdzjNWlA2XXKB+PrD/43Ebf3i3pK3tvWXlY/GsRXt42Yk6Ad7kks55L66em21qlPv
	Wa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=O1yDY8uJcYBj3szeuFebxogS5cbFJv1FEnuHHhpw5aI=;
	b=YxyknJajhO75lJLyX1c2FsTDSHCXf0X9E/MG39v4ZDgScT24zumJ6Yb/Onnp/4GSjI
	R+osnMVoyZ22HYozzCADRis5e81o+GgQ8spGR8wJRC8gXP68Ezu5fftvX+10dfdRqUTJ
	2oSlWraaw8/8PuX0yAyMGMwcUvVLHKnT84NPQOV1RqB5McxLq4iJPegznROIJpBq+oKL
	Dur83T72218LUdtnlN3LhNYRZzxyJepKv+T55jIouTG7SL2osbn6XZS002DtSpfNUD8C
	o9xJW2Sr98rlPjY+z1wAsdg3iIYA8g3M6NpW+0/1aZsP54MrD2UpbcbMbxCYuvHiX4id
	EjcA==
X-Gm-Message-State: APjAAAUBBWj8zm3dA8uWONFB9WFJOzFw9DQFAEjccn2fCVqtz8i1DYXx
	C82nGKiUv+qdcMDY+CuxSW0/M7Kk63P2e899ccqGYgKqLOQ=
X-Google-Smtp-Source: APXvYqyQCYTd0B3QjiS0HtR0buo4NF/TbRFyRR7PFw0fpijEZfgM/zCKft9uHLrUHogC2eericKlRD+OE9e9JtuF4xs=
X-Received: by 2002:a9d:f26:: with SMTP id 35mr278447ott.260.1576628238762;
	Tue, 17 Dec 2019 16:17:18 -0800 (PST)
MIME-Version: 1.0
From: Tim Black <timblaktu@gmail.com>
Date: Tue, 17 Dec 2019 16:17:08 -0800
Message-ID: <CA+23wiTzQ01zjRzYXYpcz9nLf=Pvt+8wQzg46LfjbRXp2rDhMA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: pyshtables.py and problems with concurrent bitbake builds
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
X-List-Received-Date: Wed, 18 Dec 2019 00:17:18 -0000
Content-Type: multipart/alternative; boundary="0000000000001d48600599ef5ed0"

--0000000000001d48600599ef5ed0
Content-Type: text/plain; charset="UTF-8"

My team employs a Jenkins Pipeline that performs 3 concurrent bitbake
builds, one for each of our "arches", in parallel steps/stages. Previously,
we cloned poky separately for each of these builds and each was performed
in separate, but identical, working trees. Our project structure is
designed to keep all of the arches' recipes maintained in separate,
distinct folders.

We recently "improved" this process to perform a single clone of the repo
and to perform the parallel builds on the same local working tree, and we
started seeing intermittent bitbake errors that appear to be caused by
races between these concurrent processes in producing, and
importing/consuming, pyshtables.py. These manifest as simple SyntaxErrors
raised at import time, caused by pyshtables.py being instantaneously
malformed. Presumably, one process is writing pyshtables.py while another
is importing it. Since this file appears to be written to and read from a
shared location -  bitbake/lib/bb/pysh/pyshtables.py - we have a race
condition.

We understand that this generated file is a fundamental requirement for any
bitbake process to proceed. I would like to get feedback from the
developers on the assumptions we have made, and the quality of the
workaround we arrived at through trial and error.

What we have empirically determined (since all googling of this file
produces only issues related to .gitignoring it and permissions errors
while writing it) is that bitbake unconditionally generates this file, but
that it will "fall back" to writing it in the local build directory if it
fails to write it in bitbake/lib/bb/pysh, e.g. if it does not have write
permissions in that dir.

So, our workaround is to simply remove write permissions on that folder:

    chmod a-w ${pokyPath}/bitbake/lib/bb/pysh

..and let each of our concurrent bitbake processes fallback to writing this
(and others?) file into their distinct build subfolders. This appears to
work, but we are looking for confirmation that:

1. these assumptions are correct
2. when bitbake falls back to generating files in the local build
directory, these files are actually used from this location (through python
path adjustment?)
3. Are there any other such generated files or similar concerns related to
concurrent bitbake builds in the same poky working tree that we should be
worried about here?

Thanks for your consideration and expertise,
Tim Black

--0000000000001d48600599ef5ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">My team employs a Jenkin=
s Pipeline that performs 3 concurrent bitbake builds, one for each of our &=
quot;arches&quot;, in parallel steps/stages. Previously, we cloned poky sep=
arately for each of these builds and each was performed in separate, but id=
entical, working trees. Our project structure is designed to keep all of th=
e arches&#39; recipes maintained in separate, distinct folders.<div><br></d=
iv><div>We recently &quot;improved&quot; this process to perform a single c=
lone of the repo and to perform the parallel builds on the same local worki=
ng tree, and we started seeing intermittent bitbake errors that appear to b=
e caused by races between these concurrent processes in producing, and impo=
rting/consuming, pyshtables.py. These manifest as simple SyntaxErrors raise=
d at import time, caused by pyshtables.py being instantaneously malformed. =
Presumably, one process is writing pyshtables.py while another is importing=
 it. Since this file appears to be written to and read from a shared locati=
on -=C2=A0 bitbake/lib/bb/pysh/pyshtables.py - we have a race condition.=C2=
=A0=C2=A0
</div><div><br></div><div>We understand that this generated file is a funda=
mental requirement for any bitbake process to proceed. I would like to get =
feedback from the developers on the assumptions we have made, and the quali=
ty of the workaround we arrived at through trial and error.</div><div><br><=
/div><div>What we have empirically determined (since all googling of this f=
ile produces only issues related to .gitignoring it and permissions errors =
while writing it) is that bitbake unconditionally generates this file, but =
that it will &quot;fall back&quot; to writing it in the local build directo=
ry if it fails to write it in=20

bitbake/lib/bb/pysh, e.g. if it does not have write permissions in that dir=
.</div><div><br></div><div>So, our workaround is to simply remove write per=
missions on that folder:</div><div><br></div><div>=C2=A0 =C2=A0 chmod a-w $=
{pokyPath}/bitbake/lib/bb/pysh</div><div><br></div><div>..and let each of o=
ur concurrent bitbake processes fallback to writing this (and others?) file=
 into their distinct build subfolders. This appears to work, but we are loo=
king for confirmation that:</div><div><br></div><div>1. these assumptions a=
re correct</div><div>2. when bitbake falls back to generating files in the =
local build directory, these files are actually used from this location (th=
rough python path adjustment?)</div><div>3. Are there any other such genera=
ted files or similar concerns related to concurrent bitbake builds in the s=
ame poky working tree that we should be worried about here?</div><div><br><=
/div><div>Thanks for your consideration and expertise,</div><div>Tim Black<=
/div></div></div></div>

--0000000000001d48600599ef5ed0--
