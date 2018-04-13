Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com
	[209.85.128.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5628C745F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Apr 2018 09:26:47 +0000 (UTC)
Received: by mail-wr0-f169.google.com with SMTP id u46so7628532wrc.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Apr 2018 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=trXJTmjXT/2xH7XCEEDrHkGsZfkx4A3SWGxdGXRdBZk=;
	b=TBT1zoIESl4CScBX6nSaNDD9aC7IIqhhT2Kmils6AOqwE3eXJx69g5Bn3tzqTx8YLe
	wNqX109gBGkwYsvcZj5ZZceTmfjQXCsh+u5urr2enwsLSaConMjMcTuZcOR4eMzAROTW
	U1g6gtQJUGminiLW9P7LsOkZW5kjipy7Ss6GVuhfFUOFB9yg7qKd5tMcJ1K+Os0QWRK8
	2ugYa3lVZc4uOrdHdONDpJlQl/UoatyhD/7DTP080zsdQpDhJZ6CsEYeLA/vKNtSdJ16
	7pLKAGqdnDgA+yJIHQc31ZTMlSFFRhZSJB8RANHrs03SiSbaE8j2jlmtukvHwGZfRXhO
	KVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=trXJTmjXT/2xH7XCEEDrHkGsZfkx4A3SWGxdGXRdBZk=;
	b=cn2+KgesTr/35JcaDXeNwjxSJj7I2cOWQ6bXo0wflz08q5al0u3KDow13Ko8wTbrhc
	Q3Q5KHzCGeAAiRt4C/riFVHSzYHNsPNfmUxVWOtTV8gzSUvEC/NyYRrNSSESMXQa/2xY
	AH/R6X1QFBBASKMGmueybJqFCgCoHipKiPprbCkqFAqjP1Hie+4jgHe7/b9CtXBLL9Sc
	PHayc5HqpYLV6kexqODGi6+g5Sm9bLYJ1qFMDl7vM7KKHegmpY5aBPNXKg5a3GlzxjON
	kWThHGIxkoKXIeUNPNduzz+U3ysSGdVOOMIysBq+pigNXzth6hQ2vmO9LNCayyfDa/4w
	xgpg==
X-Gm-Message-State: ALQs6tAo49PV66ZHXOrpnROoKm+q+oEVcCGWNa4sNIaWF7QuvstUBRP8
	NMdi3wBF8Esj+iIWM12eGla6H6TlaauB/eTwHCU=
X-Google-Smtp-Source: AIpwx4/26qekyClLIr87dYGW6RnJLuW+ioqENCqrsTkmPW2My4QKG+JoRyN8VrQ5b+psUCdWS8TIYCxSx0zc5KkxT+s=
X-Received: by 10.223.219.10 with SMTP id s10mr3018608wri.241.1523611608608;
	Fri, 13 Apr 2018 02:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.126.12 with HTTP; Fri, 13 Apr 2018 02:26:48 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 13 Apr 2018 11:26:48 +0200
Message-ID: <CA+chaQfuvWmNBxSJTu6UEqE_mDCvAEXOdNE_XKSwx3PcOr3VQg@mail.gmail.com>
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
X-List-Received-Date: Fri, 13 Apr 2018 09:26:48 -0000
Content-Type: multipart/alternative; boundary="883d24f249c4b4f3a90569b77840"

--883d24f249c4b4f3a90569b77840
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

--883d24f249c4b4f3a90569b77840
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>this is just a FYI, but =
these 2 fetches are using spawn from distutils:</div><div><br></div><div>li=
b/bb/fetch2/clearcase.py:<wbr>from=C2=A0 =C2=A0distutils import spawn</div>=
<div>lib/bb/fetch2/npm.py:from=C2=A0 =C2=A0distutils import spawn</div><div=
><br></div><div>and with latest Ubuntu 18.08 in minimalistic docker contain=
er I got following error after rebuilding the container today:</div><div><b=
r></div><div><div>$ bitbake zlib</div><div>Traceback (most recent call last=
):</div><div>=C2=A0 File &quot;/OE/build/oe-core/bitbake/<wbr>bin/bitbake&q=
uot;, line 31, in &lt;module&gt;</div><div>=C2=A0 =C2=A0 import bb</div><di=
v>=C2=A0 File &quot;/OE/build/oe-core/bitbake/<wbr>lib/bb/__init__.py&quot;=
, line 79, in &lt;module&gt;</div><div>=C2=A0 =C2=A0 from bb import fetch2 =
as fetch</div><div>=C2=A0 File &quot;/OE/build/oe-core/bitbake/<wbr>lib/bb/=
fetch2/__init__.py&quot;, line 1855, in &lt;module&gt;</div><div>=C2=A0 =C2=
=A0 from . import clearcase</div><div>=C2=A0 File &quot;/OE/build/oe-core/b=
itbake/<wbr>lib/bb/fetch2/clearcase.py&quot;, line 72, in &lt;module&gt;</d=
iv><div>=C2=A0 =C2=A0 from=C2=A0 =C2=A0distutils import spawn</div><div>Imp=
ortError: cannot import name &#39;spawn&#39;</div></div><div><br></div><div=
>it&#39;s caused by=C2=A0python3-distutils missing in the container, someth=
ing lost the dependency on it, so it isn&#39;t installed by default anymore=
, you need to add it to your Dockerfile or whatever you&#39;re using.</div>=
<div><br></div></div>

--883d24f249c4b4f3a90569b77840--
