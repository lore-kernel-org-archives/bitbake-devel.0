Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
 by mx.groups.io with SMTP id smtpd.web08.11599.1631108168891590827
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Sep 2021 06:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=PtIwQnVN;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.13, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1631108125; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H82Lazx8wVRul0OZQYa8/PF/gb+XFtwP757f/u07dHOX4KF05/UufkxGWHDibOVpCQsaWuNEGpj7dTGD7ARNhXxS99xLIfLDEvduDKOAzFJ5j5ywrQySm//VKe0wk8uWZNOdLaynXA3D6kQdRVxswmRjZcmo9dXMZwkBgZaZqGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1631108125; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Gz6b70NfZ9jCqwXev7HpHYhIWkr9CPdZIekgWvLRbYU=; 
	b=dGQ19ket/O/5VPrLlwesayaNpNawbiz9xEhK90Y0Jt9O/pzdrbPhmKy9h23Y6kI76zmNSf62PNcPl0UScYg/oE4kvTIUkID7s80liZr66kYkjChWG9ChIsfFHrRGtv/jFKjTGLr93Acvm51mWHXqGhrLTumpWwJLLUVhStzqV/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1631108125;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gz6b70NfZ9jCqwXev7HpHYhIWkr9CPdZIekgWvLRbYU=;
	b=PtIwQnVNJp1ERljN6/jj/gS3wTUvq6l97qFdB/KFK86c1Foy387a8vEv06/dtW5r
	LSfCZjhz80jZk4CvkHPJvo+zGCasWjyUszlPenccmbErxkCgEeF/vSmS4P2Qtj6h0Wl
	RfgMHJoX9CUNYXEZN7LDey2QURXounvY0QovPJS8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1631108122534595.1748313984823; Wed, 8 Sep 2021 06:35:22 -0700 (PDT)
Date: Wed, 08 Sep 2021 15:35:22 +0200
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Message-ID: <17bc59ec791.b6e62dd2473904.7067434806749865403@ertelnet.rybnik.pl>
In-Reply-To: <lyv93b9yr7.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl> <lyv93b9yr7.fsf@ensc-virt.intern.sigma-chemnitz.de>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


 ---- On Wed, 08 Sep 2021 11:56:28 +0200 Enrico Scholz <enrico.scholz@sigma-chemnitz.de> wrote ----
 > "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl> writes:
 > 
 > > It frequently happens that the 3rd party layer is, in practise,
 > > fully compatible with the older version of yocto. So, instead of
 > > false positively reporting an error, it seems to be more
 > > appropriately to just emit the warning.
 > 
 > You can achieve this already now (when you are really sure that it works
 > for your bsp).  Just set

I'm aware of this thread [2] where it was already discussed, but I was hoping to fix it for good in the root of the problem.

[2] https://lists.yoctoproject.org/g/yocto/topic/74454321

Regards,
Damian

 > 
 > | LAYERSERIES_COMPAT:<foreign-layer>:append = " frodo"
 > 
 > in your bblayers.conf.
 > 
 > 
 > 
 > Enrico
 > 
