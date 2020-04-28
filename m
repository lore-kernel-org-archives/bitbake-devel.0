Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
 by mx.groups.io with SMTP id smtpd.web11.53.1588109953997620183
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 14:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@aruba.it header.s=a1 header.b=Jxx9n9mZ;
 spf=none, err=permanent DNS error (domain: faresoftware.it, ip: 62.149.158.217, mailfrom: mauro@faresoftware.it)
Received: from [192.168.24.172] ([93.38.119.136])
	by smtpcmd01.ad.aruba.it with bizsmtp
	id YMf82200h2wfazh01Mf9RN; Tue, 28 Apr 2020 23:39:11 +0200
To: bitbake-devel@lists.openembedded.org
From: "Mauro Ziliani" <mauro@faresoftware.it>
Subject: Skipping recipe.bb or recipes.bbappend
Message-ID: <d744891c-c4a6-9567-e042-d3e33f84805b@faresoftware.it>
Date: Tue, 28 Apr 2020 23:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
	t=1588109951; bh=7XR9hAbKlHEHXU/bRJHelW1FM5aUI8tYWMEhyKYRWw8=;
	h=To:From:Subject:Date:MIME-Version:Content-Type;
	b=Jxx9n9mZA51FNqXduUgISL7FZ+MH82yAoKs/jROf+E+qA74FOXzO9IrwvHQYVjKKQ
	 edFhI8uBa9ood2S9DIk1QkHcfRovFFH4JF7O5DWMsUy0piZ72vR6iy980cLdwnzmyX
	 kE1Cq0rGSjM7yMhG5SLm3mDHD2agkcS1Bkr7MdXkqU2HKirLKdIiRUijpG745AzPqG
	 q0cGC8Aj02uP20DhrmVvyz5E9aGlUw1ObnnqL/KjtZDvZikqHhpci8ZMPsfHWv59XT
	 57Okz3cV7BHJXNhRo9yQiGHpFgWZ7O1QNHYeBPup5KtZEZAO2lMm8U280HGyutT5dE
	 3uMZ5/S9n7yeg==
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it

Hi all.

I developed a small app for Yocto Pyro on IMX6DL, engicam platform

Now I'd like to port the same layer to openstlinux stm32mp1.


Some recipe.bbappend cannot be use with openstlinux layers because the 
"mother" recipe.bb is missing.


How can I skip the recipes.bbappend uneeded?

i.e.

Engicam give me the recipe engicam-linux-fslc.bb and I addes 
engicam-linux-fslc.bbappend

Now in openstlinux engicam-linux-fslc.bb doesn't exists and I need skip 
the .bbappend.


Which is the right mode to skip engicam-linux-fslc.bbappend if I use my 
layer in openstlinux?


Thanks to all


MZ

