Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 917C66FFA4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 21:29:38 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id g62so44746649wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=WAqmOiLRqGhosD8U9KWXE8L9OxaRI8R4Bz6Oo1BQy9o=;
	b=Tfk5SBIsIuTi+yCIjii8PX8YXDYdPbv5UGgZX2XArsIcHA4yB0s92s6e+vrL9HoHEK
	Ez6anHK4wV8LlXZMI27ZlZ2Ii1LMJmnvsDbi1fKtXBunZQLUqDoBYPJ3RqsBrkNytlhY
	iohQM2lFLBVQPSmX+zkx0aOQRUdruI+bPW/PBXKyL5GckunS/86OfVPNhSwc0WfxPtuq
	9NmVBo5E+fyq3ej7D1DnNwTzPqvTLhBBlrY4CuzLvL17lCGJagGcOyVnORdCDumNZCst
	J38sD20/Hd6SleKvdvxcjpaJDMe0AUVUB54KNqob/xkHpE63yx8VgcGkqyOGi7/JIlYQ
	9YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to
	:content-type;
	bh=WAqmOiLRqGhosD8U9KWXE8L9OxaRI8R4Bz6Oo1BQy9o=;
	b=gVrZn3FUkGOgJaEVWWnTnDn782eYABWDT6LfqYs2fLrGreOt6uIT8+X/L4oXK7BfS/
	9XAdfG4GWpaSKSraqBZLSB3lych1WGuxURBx3XHiQ1//amA5OLIBCraLGSzrW4lQfutI
	9Bn2C3yEpjnDSXioHzeE98976/NkQuyHep0b8P4N/UrAjbS9a1DnEexlVt/xwlmOwyfc
	X2GSa8C3DJ4i8qbbP6RErmbrpJ/wVk4uV2i6PNFJPSLb4MYqZA80azYpXjGJ7S0RBvjZ
	wlMYI/mzSQpSsJox6kQgFh7qVZxeSR6SyY462xSGGoZ8bA7opKsGxraitqaTnGp6HCuJ
	AcwA==
X-Gm-Message-State: AG10YOTqX0Cbzf0sutSWaNqbo2z5qnQG+BuwsZD1S5bHJbFS4JjJM0jgvufvIsoXEXDxNQSZdxsVi2AY+kRXPw==
MIME-Version: 1.0
X-Received: by 10.28.187.134 with SMTP id l128mr13062542wmf.61.1455139778254; 
	Wed, 10 Feb 2016 13:29:38 -0800 (PST)
Received: by 10.194.209.131 with HTTP; Wed, 10 Feb 2016 13:29:38 -0800 (PST)
Date: Wed, 10 Feb 2016 13:29:38 -0800
Message-ID: <CAJ86T=XzRYAohb5Zr-hqxgZX=diMZd3ixz5Pk9TCUVe1zuNztA@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Unable to abort bitbake with ctrl-c
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
X-List-Received-Date: Wed, 10 Feb 2016 21:29:39 -0000
Content-Type: text/plain; charset=UTF-8

With today's master branch, attempting to abort bitbake while it's
parsing recipes results in a hang and the following error message:

  ERROR: Timeout while attempting to communicate with bitbake server

