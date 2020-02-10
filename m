Return-Path: <armccurdy@gmail.com>
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
	[209.85.222.52])
	by mail.openembedded.org (Postfix) with ESMTP id CD3E460B3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 21:12:44 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id c7so3086572uaf.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=NuN8k5SSzpRTHoblL082G8j3WsEcASnAY+nG6uZoeDw=;
	b=Yzkxdy2T0kiyRYBkZ4DDfX2BSKx3f/dnuJylmyvZMKFg7sf8zm7g0NPhNyTJKraTkM
	PnZx4xK7r7h9UkQOvqvjmnK/xTGEgQix/vEwaCX8KcRvDHd5BNvskpUaSO+A2owE09Qh
	/cpQ/Gr42/WhHl+LT1W61ASbTi/rqK1ksTF0c300KLwBxnNYfclZj385XTF57RW5MFFA
	Ss9xn/dAZPHsTJ0ZHqYZjLpYK41Wva4erJh3aDm3xeXCL36iQ4/9X+VxgUujZNCElGtz
	w9D4KrpjyyDQO2E83M87orwsRUKqCRbuVeTiGmRezDW2b/YA4LlASedZdprebYiG7r8n
	t3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=NuN8k5SSzpRTHoblL082G8j3WsEcASnAY+nG6uZoeDw=;
	b=mgP4kmO7fE0/Dg9A4GjqcFbhSlaL0ARkakMxX5ZPzg6povR+JVMdyYjziF8XkYxsx8
	Io80gAbjWCt8IFqu+M/OH6ORjSIX+sb+9E3DFv3rS8/FlPi3aPJXbsxQChmcpFGVWi06
	iXc09iQdw/VAr+Lkq+fv+vN36MEcy+t5gDRT39LX86W49VJNNMk3cOqd0TDK83fc7ryH
	xwvkid+uVhTuOBLRy2KY1myZftPuVqm9D0y922lzcgu/y/Lok4Z9EOCkUlvqoWXRG9Ko
	ZOfP/XxnC89bvgQY2tn9BUg5P1tgBZX4QlkgiPi5FGTjHapPgonpbdzbg89xe2JiB3UZ
	y0Kg==
X-Gm-Message-State: APjAAAXM5ULiKC1FppxpKeWZrxFhvj5o/v5MaOdqT5TUcxZcDSj6ASKJ
	bgAtdMosbRHVW/Z4iIpXQV0ql38Db6KwBSsPFtfx5xqA
X-Google-Smtp-Source: APXvYqz9z5EPkpJ7PqILgEyV0MppAmZAws7h5XIRI+FPGPHme7R1x133WsYcO+3TFjjoFba+pvRH9QZJMxgghrqyCwI=
X-Received: by 2002:ab0:634c:: with SMTP id f12mr2076252uap.48.1581369165497; 
	Mon, 10 Feb 2020 13:12:45 -0800 (PST)
MIME-Version: 1.0
References: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
	<1581290815745.54479@parceiros.nos.pt>
In-Reply-To: <1581290815745.54479@parceiros.nos.pt>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 10 Feb 2020 13:12:34 -0800
Message-ID: <CAJ86T=VC+8Dd7jb+yPkvvfD8RMCrV6ATHf8etS7YV+krJbeFgA@mail.gmail.com>
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
X-List-Received-Date: Mon, 10 Feb 2020 21:12:45 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 10, 2020 at 6:15 AM Joao Carlos Cabral (P)
<Joao.CCabral@parceiros.nos.pt> wrote:
>
> Hi,
>
> I'm trying to create a image recipe based on a existing one.
> I've searched online, and I could find such an example.
>
> My problem is that the image I what to serve as a base is changed in
> another layer, and I want to include that changes.
>
> Ex:
>
> (tree)
>
> Prj_root
>     -> layer1
>         -> recipes-core
>             -> images
>                 -> my-image.bb  [This is the base recipe]
>     -> layer2
>         -> recipes-core
>             -> images
>                 -> my-image.bbappend [This is the changed one]
>     -> layer3
>         -> recipes-core
>             -> images
>                 -> my-image-dev.bb [this is the new image, based on my-image]
>
> my-image.bbappend is something like this:
>
> --------------------- my-image.bbappend ---------
> PROVIDES = "product"
>
> IMAGE_INSTALL += " \
>         <some_packages> \
> "
> IMAGE_INSTALL_remove += " \
>         <other-packeges>
> "
>
> (+ other functions related with signing the image)
> _________________________________________________
>
> The final image is created with 'bitbake product'.
> And, I want to create a dev image that must be based on the current
> "product" image (my-image.bb + my-image.bbappend) with some dev
> packages.
> So, I need to include the changes that my-image.bbapend does to this
> dev image I'm trying to create.
>
>
> Tried simple create a new image that should be a copy of the working
> one, and then add the needed packages for development.
> So I did the following...
>
> ---------------- my-image-dev.bbappend ----------
>
> SUMMARY = "dev Image"
>
> require layer1/recipes-core/images/my-image.bb
> ------------------------------------------------
>
> I can run 'bitbake my-image-dev' and it runs, but doesn't produce the
> same output as 'bitbake product'.
>
> Also, If I run 'bitbake my-image-dev' 1st, it finishes fine. Running
> 'bitbake product' after makes a bunch of other tasks and finishes fine.
> Running again 'bitbake my-image-dev' finishes with an error on a
> specific task. ( It shows that they are not building the same thing)
>
> How can I do what I need?
> NOTE: I can't change anything in the layer1 and layer2.

For the future, the clean way to do this would be to for the base
image to include a package group for dev tools. The dev tools package
group would be defined by a recipe in layer 1 and empty by default.
When you want to add dev tools you can create a .bbappend (in layer 3)
for the dev tools recipe.

If you can't modify layers 1 or 2 you can archieve something similar
with a .bbappend in layer 3 which adds the dev tools to one of the
package groups which _is_ being included in the image. For example, if
you look in the manifest for the image you should see a number of
package groups named packagegroup-base-ipv6, packagegroup-base-nfs,
etc which are being included in the image. You can add packages to
these package groups by using a .bbappend for the "
packagegroup-base.bb" recipe.

