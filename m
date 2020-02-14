Return-Path: <JanSimon.Moeller@gmx.de>
X-Greylist: delayed 303 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 14 Feb 2020 21:12:57 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by mail.openembedded.org (Postfix) with ESMTP id A3634610EF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1581714778;
	bh=aaeKQ4ii0PV2rLA/Jr/TwFW2bvCsipYtyc7iNFHLTbI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmGHazpmXWbYgLMENqvNCVa+lPMxz3ZCZGHomwr2nsT+nyuLAdlNqexxZ8JmFgHz8
	R7E+rXPtI+WB67u8IPqmf+0BC4S1R9wcui8GpckzEnztzAl7/vkIfUw22LSvHBrebt
	es7V1beNYhRJGbuKAiECkm1mxws6Lq8tWmSn7pN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [91.67.26.134] ([91.67.26.134]) by web-mail.gmx.net
	(3c-app-gmx-bap05.server.lan [172.19.172.75]) (via HTTP);
	Fri, 14 Feb 2020 22:07:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-9d130cae-9461-4149-b020-6aa0a462de8a-1581714472107@3c-app-gmx-bap05>
From: =?UTF-8?Q?=22Jan-Simon_M=C3=B6ller=22?= <JanSimon.Moeller@gmx.de>
To: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Date: Fri, 14 Feb 2020 22:07:52 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <80610678-1f40-8b81-f852-4d48a950ef73@kernel.crashing.org>
References: <20200214150109.29296-1-dl9pf@gmx.de>
	<80610678-1f40-8b81-f852-4d48a950ef73@kernel.crashing.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9wnFCNq4G8W6eUnaqc8t9ZXQg2jh+6ZIjbgFSm1WISVxFibk/3o116cTzFmzzQx1zUM8v
	8XbvmfMk1QoiZz9oIz8LfSkjb+asNkCH2KIECxuVwnHKTA1AMiZYoioiP9TmRDLjG565fxuSaEfD
	fh67Y+/3VkRi6rknkXJRqT/YSgSXn7/mXrA+P3XbXI8fNOVhbuFm1Tiuw+Gl/jRKCpg+rc0djCOe
	EaaJvVnNRj78E37S7OWBoGwBx++WZqjZiDIyE+xcxH4dQ63RsaTwf3isrbmUhuGYkRfXv2Zl30X7
	CY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5y1tm3dDes=:na8Zcc3M3NAgcbFUvQcra9
	hBkToJeA/EtAHVY7T9yJhXR/9cc5KJNnbOQkn+oYiAq8ll8XX1PQi/VFsCThbRU0jfFETpxkG
	4W8mnd8XqOiS9/yH8Ief9/PU0wYTBh8fpQiyzF4TqkBC5ATSFhrOGDSF/ebCdws+/KG+ZxMze
	S/qzH1JoBmuXOxOEu4tPXUm5VZ0KFZCbU3fLJHy16BF8HobKWgz3+yXuYDa+uuXFywx0t3dsm
	DA1B2AB8rg9Ug4oboPnqDRAz+7D+AWmHc4xiU89BVCqTGReR8VOCWJfAjO6YGvQfAiPujG5o0
	hqTUHxYRXEHZcag8i/h3dIcnhSiQRLHG+v2nyG3ByaI9XQ8iN3uqEzjIb4StXAOKiLrpzQQXF
	mhMAcWb23uQ4F1Hf12CT9IEDAWj+BzglmuVMMum4U7wHde5sJ01ofF2p6IwFWWbIuSuP/t4Ta
	/070RlYQwH/LjGDxzaE5yU/BptrT38p68zLj3wUY3goTBtaErsjlNfYJwShCjZUzmm7hvh4+/
	EdDd64pT/krVGB/oei07ibbNCk8/2L7J5TlqES9gXm+aTv6DVAV92kwA+IPVajlZUCmLaQF8Y
	8+Kcd1g7ILcGh/cfYTytoR1cLBfunnPTYw51DtCHCCiXlqT/xW5JgXqzv9u2NTyqlL/VqcFGh
	ExBEnbLQyX1OV5SM0Skbx1tLFpj8AeLE4rAiqM+AqI8O9DXKp9x6uCK1QpHBYqzS/oHc=
X-Mailman-Approved-At: Sat, 15 Feb 2020 09:30:45 +0000
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix bitbake-layerindex to checkout the requested branch
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
X-List-Received-Date: Fri, 14 Feb 2020 21:12:59 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mark!

Thanks for reviewing=2E I had hoped to find the right variables=2E A pity =
it did not land earlier=2E
Can we backport this to zeus, please ?
=C2=A0
=C2=A0
> This issue was already found (and I thought fixed?) Maybe the submission=
 hadn't
> been accepted=2E See:
>=20
> http://lists=2Eopenembedded=2Eorg/pipermail/bitbake-devel/2019-December/=
020645=2Ehtml


Please ignore my patchset then=2E

Best,
JS

