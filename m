Return-Path: <davis.roman84@gmail.com>
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
	[209.85.167.52])
	by mail.openembedded.org (Postfix) with ESMTP id 0B70C6010B;
	Thu, 15 Nov 2018 00:38:16 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id p86so12918280lfg.5;
	Wed, 14 Nov 2018 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=9/FpTZEXMEDndQDQfeOC4gi0kFPYxnCjAirmZdhPiew=;
	b=QfTKf8f7GRd8F4AehtN4XzvCBjROirlSbRGrPTh7qkdsgUDRX+Q2l9KHMGtXGe9I+x
	4ex+SCF4MLCUPqkdQFIZpQc1nIVdaHiKxfo4VtCx+RVMljfPd64gVF1ZoHQb+39/1T8m
	8FknFTTMkJ+kOvcQmcCm0+vi3ZosgD7LhRBhvRXVnW1F2L+CdeggkC/iEUy66+uZabL0
	rFzPI4TyjxNMZSbXmiHNQ7KPCTvHtNuAo+yn4MnMr+xe8CwHR1Szhz2pG0VTg2g5Z9D9
	aZSOEKPaA49JDG9cdO8hgSEuM5IrAGdiLCVaW7sKCzzB3AH0Eeh0hW4T7WMUg/a48r5Q
	GJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=9/FpTZEXMEDndQDQfeOC4gi0kFPYxnCjAirmZdhPiew=;
	b=SDDBC+okhBtGgY5aiB05UrqgXUHlmKOcxVhAydIh6bv6EGPwiGwSxBu9YYop/yxEHi
	Rlrx0DDsIAdtY+sxqffcNwJQG/3V3tnhNSNHQYFHvxREjJWzyTQTn3bburNT3UINV9Oj
	mwkbriBgPhQh3l7D79yByQC/0PIdIpWaPJxMCzy6RX7r+MAbhVLQzSM8paPQnISM0LsX
	WT6EKsEynsqZY25tgQHQ786s29u/raCOUWgcVpMl6RSNOA1j3E93DBimhzpTEdi6UAGC
	pLQShnqwL9+JrpgdL+GY8n31XwDEVesqdxfrA4br2E7/fX0wPBvnAbhgMv4I0IxpVSkc
	UsFw==
X-Gm-Message-State: AGRZ1gLhbBgY6eKcxbIZocdVv9P5bLEONqbRD1yS07zWvKVSJIeUevIK
	Q8fbryW7EuaT1P3zCmy1H5yrQtv02VZxRJrtDfPU3Q==
X-Google-Smtp-Source: AJdET5foZkJghTzSpJPEvmDLr55ENV6v3wmsPHN1hu0FUU82D0LOnmMtJba84MYeC19RqLFo5NRItzXnk1NyKkMEgUo=
X-Received: by 2002:a19:690d:: with SMTP id e13mr2214941lfc.84.1542242297175; 
	Wed, 14 Nov 2018 16:38:17 -0800 (PST)
MIME-Version: 1.0
From: Davis Roman <davis.roman84@gmail.com>
Date: Wed, 14 Nov 2018 19:38:05 -0500
Message-ID: <CACfi_Z3yjSK95o843HqpubqKgx=f-3u3e3GwGz65enKYTmbS6Q@mail.gmail.com>
To: Yocto discussion list <yocto@yoctoproject.org>
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: difference between DEPLOYDIR vs D
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
X-List-Received-Date: Thu, 15 Nov 2018 00:38:17 -0000
Content-Type: multipart/alternative; boundary="00000000000047e378057aa94433"

--00000000000047e378057aa94433
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm trying to understand the correlation between the $DEPLOYDIR and $D
variables.

They both seem very similar.

Do files from DEPLOYDIR eventually get copied to D in order to finally make
its way into the final package?

If so, why bother with  DEPLOYDIR and instead just copy straight into D?

Thank you,

Davis

--00000000000047e378057aa94433
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>I&#39;m trying to understa=
nd the correlation between the $DEPLOYDIR and $D variables.=C2=A0</div><div=
><br></div><div>They both seem very similar.</div><div><br></div><div>Do fi=
les from DEPLOYDIR eventually get copied to D in order to finally make its =
way into the final package?</div><div><br></div><div>If so, why bother with=
=C2=A0 DEPLOYDIR and instead just copy straight into D?</div><div><br></div=
><div>Thank you,</div><div><br>Davis</div></div>

--00000000000047e378057aa94433--
