Return-Path: <armccurdy@gmail.com>
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
	[209.85.217.42])
	by mail.openembedded.org (Postfix) with ESMTP id EA1666108C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 23:33:15 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id a2so7317114vso.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=VEnyjiqhFI7vICyXzriq6QB1lh7UPm12iRGsTQwemEY=;
	b=bbICFXQe99GLIXsMAFLMTJWM1fj84rqOy5+XRsZRBeMyzsZoQbwGUcEB73h/jmjOY5
	D0uDcxxcQtwWsauBuh+Hk/yibcOX4w8/W3OxCzq10cJXoUUbQAyddLllLBbajzLkhBBK
	qk8DmEtrC1eQWVRkgdq8hUFV6ZVcBWwXjjiaeJQnH2zY92npp1qFOCGNY0HMo8UjkA9q
	JylgOb6krgTHlro6oBqJ2Cpdk4AeoTZNed8Hdivn/DHn4xAcOQ+mHxAekPIL9AAr/6jI
	G2XoEnFb6HsE1yVk5t0yAqu31b+xxuKN7IwzDh6eJIRyJVIFlVg1nmg6iNqnzlX4sc5P
	lOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VEnyjiqhFI7vICyXzriq6QB1lh7UPm12iRGsTQwemEY=;
	b=OGVqwtyOaZ3TKxTgX1qj4MnxJUkRHfhrdtZtn4v5Ut9wcaH1EOlQbrDjqr5OjgtE+b
	0gGR9ydfugt28rIJM8H9Q17MajCzBCoE6dZRm8AxaKgRnHrZOSDWThYys9/hvqYynQI7
	2jktZfz1uUk6l0ZMiG3XyNYEbQfqi8EKTsOsYKNu+Co+MF9idTaBaOz+EFYeK+vtzFOM
	chwenY5d3GZUda3kqWESu8ZaRW/K5w+sPFhkG/I41BDllVEQxY5yNRm/jGknvrXDeXRr
	gkAAdn6QhIwoL+ajBGgUmq3pTnp/q4BnxMeswDwtEbHw4BjsJh8sxHTJA3EAf7ngn2o0
	7Tvw==
X-Gm-Message-State: APjAAAX+IgYKuD/doB4G4Ang/Asox/dJyiJwtVTsovhvHKg3rrbKDz5j
	yjgPQ8/F7wLt+JKgzNH2bYbVbsOaUkwxZzYjpgU=
X-Google-Smtp-Source: APXvYqxDimzaO+7hdz7QMrxXb6hsWvx7T2ZYGBioTuliXv1Nk98ZN2wlUgNZ1pYoSsx9ZEgTJFat/cjYaY+GiPhmlPo=
X-Received: by 2002:a67:f41a:: with SMTP id p26mr3096694vsn.222.1581723196684; 
	Fri, 14 Feb 2020 15:33:16 -0800 (PST)
MIME-Version: 1.0
References: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
	<1581290815745.54479@parceiros.nos.pt>
	<CAJ86T=VC+8Dd7jb+yPkvvfD8RMCrV6ATHf8etS7YV+krJbeFgA@mail.gmail.com>
	<3cb24a9342e09cea61c0bde03c26d165588faf96.camel@parceiros.nos.pt>
In-Reply-To: <3cb24a9342e09cea61c0bde03c26d165588faf96.camel@parceiros.nos.pt>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Fri, 14 Feb 2020 15:33:04 -0800
Message-ID: <CAJ86T=WszRq0ff8uqn+afu5Eag8UNNxLL_=5LXRWUw3y5pyFTA@mail.gmail.com>
To: "Joao Carlos Cabral (P)" <Joao.CCabral@parceiros.nos.pt>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [HELP] Create a new image recipe based on a (changed) existing one
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
X-List-Received-Date: Fri, 14 Feb 2020 23:33:16 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 13, 2020 at 9:34 AM Joao Carlos Cabral (P)
<Joao.CCabral@parceiros.nos.pt> wrote:
>
> Thanks for your answer.
>
> Using your method, how could I create the normal image and the dev one?
>
> * bitbake product - would produce the normal one?
> * bitbake my-image - would produce the dev one?
>
> I still need to create the "normal" when ending a develop phase.

Assuming that you can't change layers 1 or 2 then the ONLY thing you
can build which will include both the my-image recipe in layer 1 and
its .bbappend in layer 2 is the my-image recipe itself. If the
development image is created by adding to the contents of my-image by
using a .bbappend in layer 3 then to switch back to the normal image
you would need to disable that .bbappend. e.g. If you have a .bbappend
which adds to a package group under the control of a variable then you
could switch between production and development by setting that
variable from a global config file (e.g. local.conf) and rebuilding
my-image.

A different approach which _would_ allow you to switch between
production and development by building a different image would be to
duplicate the .bbappend from layer 2 in your layer 3. In layer 3 you
could then have a new image recipe which directly includes the layer 1
recipe (ie what you tried originally) plus a new .bbappend which makes
the same changes to your new image recipe as the .bbappend in layer 2
makes to the layer 1 image recipe. If the contents of the .bbappend
don't need to be changed then you could perhaps make the layer 3
.bbappend a symlink pointing back to the layer 2 .bbappend, rather
than just copying and renaming the whole file.

