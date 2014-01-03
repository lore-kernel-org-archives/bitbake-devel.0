Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
	[209.85.219.44])
	by mail.openembedded.org (Postfix) with ESMTP id 7A95960E7C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 13:09:26 +0000 (UTC)
Received: by mail-oa0-f44.google.com with SMTP id m1so16107753oag.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2014 05:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
	:content-type;
	bh=c+a7eWmgh7F92ZrxPXsqYJZFXZ28Rlc1i6sJkFuEqfE=;
	b=a2b1EJPcdwB0uAs/UhRydQvC6mk4K8LukLE0fVsJ4GWbrkbQz+jmatqi7jq5lXxBBX
	rWUkaK0W7e93b1Mu9WY+081CfPsSS7G4ms6ReQyReA75HW6yOJ+3cyRF5BarQW2SYG/P
	HR8Jv/RmnSEZxAeWk1oiKjGxxzqaIIcD0pEqMJY/f3sbHctDYp14Ti9+gJVyHY8IuZg5
	OzFOq14SGuvHLZVE3/sqFIA55MCmdc8JMS1AI9gbduz73cFqKUnEjOPpt8mKpfZnuU9p
	m7hgO4tI3jB+W2j5B30oslSi5+g+kXa2VNfE+8xZA6nwGbdoEzLPAbdh5VAE4DINtZ5F
	pmVA==
X-Gm-Message-State: ALoCoQlZ3uZTlQmT7htzkxaAmthTI1rB9k135CsqhYfkEuAcuN4D3N7SKu0G3Rfz51crpohTsShs
X-Received: by 10.60.144.228 with SMTP id sp4mr58025928oeb.29.1388754567114;
	Fri, 03 Jan 2014 05:09:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.86.193 with HTTP; Fri, 3 Jan 2014 05:09:07 -0800 (PST)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 3 Jan 2014 13:09:07 +0000
Message-ID: <CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com>
To: jason.wessel@windriver.com, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: about oe-init-build-env: Allow startup with and without memres
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
X-List-Received-Date: Fri, 03 Jan 2014 13:09:29 -0000
Content-Type: multipart/alternative; boundary=047d7b41ccbca7448b04ef109e8b

--047d7b41ccbca7448b04ef109e8b
Content-Type: text/plain; charset=UTF-8

Hi Jason,

I noticed that this patch *oe-init-build-env: Allow startup with and
without memres* will kill any existing bitbake server when
oe-init-build-env is started. I think this always happens since I see no
way to source oe-init-build-env when BBSERVER is set.

I'm trying to figure out a better solution, since simply stopping the
server will leave toaster in an inconsistent state, if the server was
started through toaster.

Can you please tell me what behaviour are you trying to get out of the
system ? Let's try to find something that will also work for Toaster.

Cheers,
Alex

-- 
Alex Damian
Yocto Project
SSG / OTC

--047d7b41ccbca7448b04ef109e8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jason,<div><br></div><div>I noticed that this patch *oe=
-init-build-env: Allow startup with and without memres* will kill any exist=
ing bitbake server when oe-init-build-env is started. I think this always h=
appens since I see no way to source oe-init-build-env when BBSERVER is set.=
</div>

<div><br></div><div>I&#39;m trying to figure out a better solution, since s=
imply stopping the server will leave toaster in an inconsistent state, if t=
he server was started through toaster.</div><div><br></div><div>Can you ple=
ase tell me what behaviour are you trying to get out of the system ? Let&#3=
9;s try to find something that will also work for Toaster.</div>

<div><br></div><div>Cheers,</div><div>Alex</div><div><div><br></div>-- <br>=
<div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=
=A0</div></div>
</div></div>

--047d7b41ccbca7448b04ef109e8b--
