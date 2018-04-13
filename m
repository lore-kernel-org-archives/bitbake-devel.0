Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail.openembedded.org (Postfix) with ESMTP id 3A8567459B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Apr 2018 09:38:49 +0000 (UTC)
Received: by mail-wr0-f171.google.com with SMTP id f7so759075wrh.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Apr 2018 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=QW6B1B8r5Bdv9lqi61+kS50a8frAc3KvHGm6XfSLWOQ=;
	b=RJ05MCf0e4j1fZRWBcR6cu8/xlHZqgtfpJWPYhBargfyarWVlO2XcQXbqHLuZXT9rD
	Y/z1CPVqpAbahFCfSyq4LviylW/LKVZUuJz5er/0JdREGJuUWcipQy0phw6CZC6Zg3K3
	Q83TFV6bTQ3iRiBePgeXisn1ggpnYBcEscQdOKO+3KggT6htUKwRWIFSCrNcCEh8bEiU
	zp/DcvkEYMSx5DMInnfrnlsVsqkRx+9/Y7xXm3rIhsQKmF6I7JNHol9RoDwZ0ML68zqt
	GVhrcW2GbH2j51gtnSqU+nWeJfXWDoFYHALqVbq9ffRVDL/XeZSd48kQiOl30xQws5Ty
	TyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=QW6B1B8r5Bdv9lqi61+kS50a8frAc3KvHGm6XfSLWOQ=;
	b=tdDPewLspdHZD24dUaAaufMgAJiwaJ+fRV1qAUix0nmJzp74ElIFr7dcRy9HCX3rB7
	Q1HKeKdYIea3vwjt1Dxt+Q2FS94et2zdr7NnsFTeV9VFq0pT1ONlgp8ZbyC3AfdT+Lz6
	L7oTuQAI3kIaFYVEbnPu4ba//KSipD9rWKGLWhyZR4hw4e8mRUx/hTHpn5JkOmy9K/AE
	5bgYTYeogjnNgcUBDVSHZHopqhqa2kf/3fUyGUy4siw4g0hRh6vLeydsgdj0x6gmE/Im
	QoJ/SC80flfOmv7Jl1dF9P3/GfRtAZGt6H/CMpwVhjF8DXk/12bUTNVwgVLYiE2N0b1p
	7YTg==
X-Gm-Message-State: ALQs6tBCbIOE/LeAONwZghi8lm/K2B/yJjkmbr5P83kMYtgfyvJyAeol
	jxeNc+5Lk6iZjSEuItSqpukBNHRP/r6wcpyTD7t9bw==
X-Google-Smtp-Source: AIpwx4+MDHZzOTqOxOWyq3Ynj+9dYhPlnmgdu1j+1TYkwPUQUQUwzyCfKMocEGB/g7DE+UBTLqmhF1PUacLuo4QDfg8=
X-Received: by 10.223.219.10 with SMTP id s10mr3050623wri.241.1523612330498;
	Fri, 13 Apr 2018 02:38:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.126.12 with HTTP; Fri, 13 Apr 2018 02:38:49 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 13 Apr 2018 11:38:49 +0200
Message-ID: <CA+chaQdpV7yaPr6bw3nTg7S9FjyRcEyuXL3c1_bdHWHtdad4-Q@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: clearcase and npm fetch2 modules depending on python3-distutils
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
X-List-Received-Date: Fri, 13 Apr 2018 09:38:50 -0000
Content-Type: multipart/alternative; boundary="883d24f249c4bc1f130569b7a341"

--883d24f249c4bc1f130569b7a341
Content-Type: text/plain; charset="UTF-8"

Hi,

this is just a FYI, but these 2 fetches are using spawn from distutils:

lib/bb/fetch2/clearcase.py:from   distutils import spawn
lib/bb/fetch2/npm.py:from   distutils import spawn

and with latest Ubuntu 18.08 in minimalistic docker container I got
following error after rebuilding the container today:

$ bitbake zlib
Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/bin/bitbake", line 31, in <module>
    import bb
  File "/OE/build/oe-core/bitbake/lib/bb/__init__.py", line 79, in <module>
    from bb import fetch2 as fetch
  File "/OE/build/oe-core/bitbake/lib/bb/fetch2/__init__.py", line 1855, in
<module>
    from . import clearcase
  File "/OE/build/oe-core/bitbake/lib/bb/fetch2/clearcase.py", line 72, in
<module>
    from   distutils import spawn
ImportError: cannot import name 'spawn'

it's caused by python3-distutils missing in the container, something lost
the dependency on it, so it isn't installed by default anymore, you need to
add it to your Dockerfile or whatever you're using.

--883d24f249c4bc1f130569b7a341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>this is just a FYI, but =
these 2 fetches are using spawn from distutils:</div><div><br></div><div>li=
b/bb/fetch2/clearcase.py:from=C2=A0 =C2=A0distutils import spawn</div><div>=
lib/bb/fetch2/npm.py:from=C2=A0 =C2=A0distutils import spawn</div><div><br>=
</div><div>and with latest Ubuntu 18.08 in minimalistic docker container I =
got following error after rebuilding the container today:</div><div><br></d=
iv><div><div>$ bitbake zlib</div><div>Traceback (most recent call last):</d=
iv><div>=C2=A0 File &quot;/OE/build/oe-core/bitbake/bin/bitbake&quot;, line=
 31, in &lt;module&gt;</div><div>=C2=A0 =C2=A0 import bb</div><div>=C2=A0 F=
ile &quot;/OE/build/oe-core/bitbake/lib/bb/__init__.py&quot;, line 79, in &=
lt;module&gt;</div><div>=C2=A0 =C2=A0 from bb import fetch2 as fetch</div><=
div>=C2=A0 File &quot;/OE/build/oe-core/bitbake/lib/bb/fetch2/__init__.py&q=
uot;, line 1855, in &lt;module&gt;</div><div>=C2=A0 =C2=A0 from . import cl=
earcase</div><div>=C2=A0 File &quot;/OE/build/oe-core/bitbake/lib/bb/fetch2=
/clearcase.py&quot;, line 72, in &lt;module&gt;</div><div>=C2=A0 =C2=A0 fro=
m=C2=A0 =C2=A0distutils import spawn</div><div>ImportError: cannot import n=
ame &#39;spawn&#39;</div></div><div><br></div><div>it&#39;s caused by=C2=A0=
python3-distutils missing in the container, something lost the dependency o=
n it, so it isn&#39;t installed by default anymore, you need to add it to y=
our Dockerfile or whatever you&#39;re using.</div><div><br></div></div>

--883d24f249c4bc1f130569b7a341--
