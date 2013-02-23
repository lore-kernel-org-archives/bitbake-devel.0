Received: from mail-ve0-f174.google.com ([209.85.128.174])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1U9N9Z-0002jw-3I
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Feb 2013 23:01:09 +0100
Received: by mail-ve0-f174.google.com with SMTP id pb11so1421950veb.19
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2013 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=M0YGiCxL5Y6fvvT65z++aep2G++D6n7Io5leMDVIrmc=;
	b=IA8ApZRAqOfkqCx0p1z9jnd/esFT9M//OYXcWzKrRI7hSli71UHgyvQ3AoHz3WNIdx
	X3gHJl6CInMMUUapFIyimP63FVKrNu1GjEwyKtz6XZFFWYQz9p7Wr1OdjHTz8V2TmVWB
	hg5da0qGxMZ1dgczdl0LbOP0oXgzHUEJKjBE2xRcs3IHxugu3Xdg6qWkFKRzwGqe11ma
	0q7hMelRsgn4hjZi+sfIgN1o3ByAcQf6cUwaw/OD8VJkMn1Gstj69b1SHG23vSqpJu00
	E4lxCF/Pm7ooHSrbvXD2jFHzubx3XIMBPMQQ9DwJaKa4PHfKG7/yTKRYHYJV92BTwOsa
	Dd1A==
MIME-Version: 1.0
X-Received: by 10.58.132.170 with SMTP id ov10mr7915609veb.57.1361655893374;
	Sat, 23 Feb 2013 13:44:53 -0800 (PST)
Received: by 10.52.185.168 with HTTP; Sat, 23 Feb 2013 13:44:53 -0800 (PST)
Date: Sat, 23 Feb 2013 22:44:53 +0100
Message-ID: <CALbNGRSGHYF0-9AgF7KmK8W_BBBOriVmx7FYupxySHUgdqKeYg@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: bitbake-devel@lists.openembedded.org
Subject: parse does not cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 23 Feb 2013 22:01:14 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

with the latest HEAD bitbake performs a full parse for every run. I
could not find a hint so far - so is it a bug or did I miss something?

Andreas


