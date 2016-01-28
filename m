Return-Path: <just4tech83@gmail.com>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
	[209.85.213.176])
	by mail.openembedded.org (Postfix) with ESMTP id 63B5C771A9;
	Thu, 28 Jan 2016 18:01:05 +0000 (UTC)
Received: by mail-ig0-f176.google.com with SMTP id t15so18967621igr.0;
	Thu, 28 Jan 2016 10:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:cc:content-type;
	bh=kIdvWs93Rb8BsoLY2ujcUEED0jHGLpXp+eQGK/FYkcs=;
	b=us2fn0b/lbMFNHWv22d20vm3o1TqdJ21zo9+vzeTWYuJkthOdGVe2VAd2+6XcetToW
	W5YMzMq3g9WAWkRMlEa049q6pp5TNF1IzwmLcbRPNtcx8RbKNCggFiQwC8LB3LDQJIkS
	/SnQaVL8O4ET8uf7Dn9kgMewkKCuxSY1ztzZq6urkP6F9qzPO+2WUGUJOsKRlmh9u874
	NEHxah7jhn0OYwOxlOPB5GFbXE6XHDnr/O46cRGj2UQXi+Fd5ebEuZsKNMqy4XtMfOPH
	obJ1jG9YGh66Jnbiz4pkfHKf+Cl9buRzu5i+Ssd7RJyJuVLUo1hKtZNEGJLEQR4u8dsv
	UK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
	:content-type;
	bh=kIdvWs93Rb8BsoLY2ujcUEED0jHGLpXp+eQGK/FYkcs=;
	b=mQWCNvKNAYZflfeYSTOjKMJ5MYs/4EMYg+ctAhEzrRuYBlLc4obR6QyQsa8A6r3Iis
	WJ7j4V6U+mnYOKwbi6WanA08Qv0MANL+7wL6EfrEjb3TQwe1UU0qpFiQIu1qiTf+EQ2z
	2TGSD7R2dVhKm/kFR7yE3u3Y7N94rswEU2LgnRdz7A7lo5xbFHyw74X80EpVMvJiE0d6
	ENlKT/xZ16qGJdG7yBgjWRaDV+ANPcUU9Am1PptgCGOd8aFS+TShLT5prbMFUd3F3heU
	qMazuYo9aMLdE+MX4mrbdN0NF/RA61qkSYi5P//+9HGLtgZXx2gZlAKjUjtQMIGN85Gz
	JQjA==
X-Gm-Message-State: AG10YOQ8Tw3cKr1qyjkQw/l7EDvR5J2BAbVy0FJeye6VfAMdrav3/cZAjegln66qFnfxHZCd0vfd8b9duwayuQ==
MIME-Version: 1.0
X-Received: by 10.50.183.7 with SMTP id ei7mr4856772igc.17.1454004066323; Thu,
	28 Jan 2016 10:01:06 -0800 (PST)
Received: by 10.36.196.133 with HTTP; Thu, 28 Jan 2016 10:01:06 -0800 (PST)
Received: by 10.36.196.133 with HTTP; Thu, 28 Jan 2016 10:01:06 -0800 (PST)
Date: Thu, 28 Jan 2016 23:31:06 +0530
Message-ID: <CAD2C2VRqrrOKLixFBBXq-Vxu-nb5DzSXqV8Xrr2yuwb6auds5w@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: openembedded-devel@lists.openembedded.org, linux-yocto@yoctoproject.org, 
	poky@yoctoproject.org, bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org, Khem Raj <raj.khem@gmail.com>
Cc: Chander.kashyap@gmail.com
Subject: Plymouth support in yocto
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
X-List-Received-Date: Thu, 28 Jan 2016 18:01:11 -0000
Content-Type: multipart/alternative; boundary=001a11c3ac26e0159e052a68b3e4

--001a11c3ac26e0159e052a68b3e4
Content-Type: text/plain; charset=UTF-8

Hi,
   Can  we integrate plymouth package in yocto  so that we can properly
display splash screen on different resolution monitors.

Thanks in advance
Bryan

--001a11c3ac26e0159e052a68b3e4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi,=C2=A0 <br>
=C2=A0=C2=A0 Can=C2=A0 we integrate plymouth package in yocto=C2=A0 so that=
 we can properly display splash screen on different resolution monitors. </=
p>
<p dir=3D"ltr">Thanks in advance <br>
Bryan</p>

--001a11c3ac26e0159e052a68b3e4--
