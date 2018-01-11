Return-Path: <davis.roman84@gmail.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
	[209.85.216.195])
	by mail.openembedded.org (Postfix) with ESMTP id B7CC278825
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jan 2018 04:55:22 +0000 (UTC)
Received: by mail-qt0-f195.google.com with SMTP id u10so411446qtg.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jan 2018 20:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=3XWmAdKZpWhdYOjI0cUqTtQnxfwA21ItnZqvaqf8n7I=;
	b=T6wxKOl8te6qw+eJ2s/OGWmi6/M1uO7WRCeY3W1nAP2R+DERMf+AbwIo5cHu5CQzID
	YzQJ/2AeOaAVff2NDG6Ee23px9BHJIiC6LCgz4rlAHzWq/13x3FXNQgvitK3YHtyPfTX
	yy3tlzUmVRI6bDTC5newNp/3pNavxD3tTnken4fjVBKnBzTyLiI6kESVe1C3BVi7x2zt
	H2ovDr6QXk1QhndqW67bh4kLKPgcikBfuHRqLp2Uzme27WCULrhFMVAXlwLPy/Nu2l4a
	LL3TpfYpsfuFVn0986P1p/S1ZlmknmAQupfVZNQlqSrvFpIGlDsL2wi3Fhb2Siy6Rn2o
	4EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=3XWmAdKZpWhdYOjI0cUqTtQnxfwA21ItnZqvaqf8n7I=;
	b=APUAFGo7ccgmY06ii2rqSoyX5xMoHpF43oYFx4EcYexHSi0uzmTLZEwKBCo/vu7d7A
	9Jj714kR++lbq0fMvTfFzb78gc6f9OMQwTwvt/qTEsZSD2ipjHtPabfoHcWg09xKtje0
	8FxKwVhWmeXXvFlzhcfdmDsWbln9uNxMFeWtB5vy2k6LWpbTRJUjDW4l1W/rW1t6wf/D
	kCR521K30DXEHgfSSs095LoD5bxdHRCULv1YsFpBDN9cugKrLsAHecra8sT9hM0ae/mM
	o5FHQXqc8+c63akBPmXPtYX/AtjZRCexmtwG7UY5PhkmePdU9V7M7LKAgzUise2rZ3/m
	uIbA==
X-Gm-Message-State: AKwxytffWoeeTovL6RYo3U/96efwvqKynGfu8Io7TsNb7PuRREErbmB2
	oA9IBpAkI4aBro/92ur/tXv6NB5qVVLoQFmsqMY=
X-Google-Smtp-Source: ACJfBotY74SWrl7fTiLdb7GDXB4bagPJoQPxbcDcyZ1Wlr01f9uBt4elsExPTiwZRm67toxqogYwxiP3EEVCoP9qixk=
X-Received: by 10.237.61.175 with SMTP id i44mr4581425qtf.89.1515646523494;
	Wed, 10 Jan 2018 20:55:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.233.239.137 with HTTP; Wed, 10 Jan 2018 20:55:23 -0800 (PST)
In-Reply-To: <CACfi_Z1iHtpMLTNnQO=FPpFVu+ZYaXrRLVSk6HkrrsSbt+CBkA@mail.gmail.com>
References: <CACfi_Z1iHtpMLTNnQO=FPpFVu+ZYaXrRLVSk6HkrrsSbt+CBkA@mail.gmail.com>
From: Davis Roman <davis.roman84@gmail.com>
Date: Wed, 10 Jan 2018 23:55:23 -0500
Message-ID: <CACfi_Z1-wtH0iVO6Q3vg2Q661tWSHF1ZFQuGU_QVyCtijxW58Q@mail.gmail.com>
To: poky@yoctoproject.org
X-Mailman-Approved-At: Mon, 22 Jan 2018 22:09:11 +0000
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org,
	yocto-bsp@yoctoproject.org
Subject: How to make the os-release package work with local walltime instead of GMT?
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
X-List-Received-Date: Thu, 11 Jan 2018 04:55:23 -0000
Content-Type: multipart/alternative; boundary="001a11401982a3548d056278f48b"

--001a11401982a3548d056278f48b
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm trying to fullfill a requirement which states that I must have a file
in my root filesystem which has the timestamp of when the rootfs was
generated for traceability purposes.

I've included the os-release package into my image recipe.

However, when I cat /etc/os-release, I notice that the BUILD_ID variable
does not reflect the actually time that my build took place.

Upon further inspection, I noticed in the os-release recipe that BUILD_ID
is based on the DATETIME variable.

Drilling down further, I noticed that DATETIME is defined
in ./meta/conf/bitbake.conf

    DATE := "${@time.strftime('%Y%m%d',time.gmtime())}"
    TIME := "${@time.strftime('%H%M%S',time.gmtime())}"
    DATETIME = "${DATE}${TIME}"

So it appears to me that DATETIME is based on gmttime.

Instead, I would like this to be based on wall time.

Any suggestions on how to do this?

Thank you,

Davis

--001a11401982a3548d056278f48b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><div>Hello,</d=
iv><div><br></div><div>I&#39;m trying to fullfill a requirement which state=
s that I must have a file in my root filesystem which has the timestamp of =
when the rootfs was generated for traceability purposes.</div><div><br></di=
v><div>I&#39;ve included the os-release package into my image recipe.<br></=
div><div><br></div><div>However, when I cat /etc/os-release, I notice that =
the BUILD_ID variable does not reflect the actually time that my build took=
 place.</div><div><br></div><div>Upon further inspection, I noticed in the =
os-release recipe that BUILD_ID is based on the DATETIME variable.</div><di=
v><br></div><div>Drilling down further, I noticed that DATETIME is defined =
in=C2=A0./meta/conf/bitbake.conf</div><div><br></div><div><div>=C2=A0 =C2=
=A0 DATE :=3D &quot;${@time.strftime(&#39;%Y%m%d&#39;,<wbr>time.gmtime())}&=
quot;</div><div>=C2=A0 =C2=A0 TIME :=3D &quot;${@time.strftime(&#39;%H%M%S&=
#39;,<wbr>time.gmtime())}&quot;</div><div>=C2=A0 =C2=A0 DATETIME =3D &quot;=
${DATE}${TIME}&quot;</div></div><div><br></div><div>So it appears to me tha=
t DATETIME is based on gmttime.=C2=A0</div><div><br></div><div>Instead, I w=
ould like this to be based on wall time.</div><div><br></div><div>Any sugge=
stions on how to do this?</div><div><br></div><div>Thank you,</div><div><br=
></div><div>Davis</div></div>
</div><br></div>

--001a11401982a3548d056278f48b--
