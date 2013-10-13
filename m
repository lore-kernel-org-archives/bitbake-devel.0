Return-Path: <trevor.woerner@linaro.org>
Received: from mail-ee0-f44.google.com (mail-ee0-f44.google.com [74.125.83.44])
	by mail.openembedded.org (Postfix) with ESMTP id 07ED660FC2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Oct 2013 16:03:34 +0000 (UTC)
Received: by mail-ee0-f44.google.com with SMTP id b47so2887447eek.17
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Oct 2013 09:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=VORsDVgg9/MSJm7snx8vAQn2JvdmssrdH3lg5XlOUbA=;
	b=PDiJSNwR5uxWoCmtAZjAu5zUliflQiA2bpu7BvKMX6QvjK/qxUQhqK11/ZhSCj9ofT
	Fa560mflz+5pIOyxHhkKBc2EZd0jfnSQ1iKAzoR6P66fwiENrgg2tKiQX/xeEX9NcX9P
	ecKYsfdyNyobaQsmgpVmKYLvRPbmImu7X8kzl2ZozLQ/S73qlY/v/DlhfS+8VtiyaAvs
	eXIZiLPrNf9gUblsxjHCQpGgkNZtLYuEMiwCHZYU+LnU+eqq4u2mPrERAlcJ5Wovacmq
	rCGqPND8nhbs2CPFehvJXFl5tksFZBIKlhB42NSr7i09b/L5QGW9k7taL6etjmQSRX7/
	pjxQ==
X-Gm-Message-State: ALoCoQnqvdpbbPjqSrkwhiDtf8mjzdq027xHHyZs/aGjnC/er6mjEJapkK3C0tuVAhcDnIbYAymr
MIME-Version: 1.0
X-Received: by 10.14.45.70 with SMTP id o46mr48536128eeb.19.1381680216299;
	Sun, 13 Oct 2013 09:03:36 -0700 (PDT)
Received: by 10.14.117.67 with HTTP; Sun, 13 Oct 2013 09:03:36 -0700 (PDT)
In-Reply-To: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
Date: Sun, 13 Oct 2013 12:03:36 -0400
Message-ID: <CALmOhgmJVjqnhUvQn=5hk3ZaM6r42PYWa+A2Xve34v6fEdc94w@mail.gmail.com>
From: Trevor Woerner <trevor.woerner@linaro.org>
To: Chris Morgan <chmorgan@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Sun, 13 Oct 2013 16:03:36 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hi Chris,

I don't think there's anything "wrong" with what you're proposing, but
your usage is so far outside what's intended that you'd be pretty much
on your own. I don't know that there are many people using bitbake
standalone (outside of OE/Yocto), but it would certainly be
interesting to hear of such projects.

Having OE/Yocto perform your complete build from the ground up, even
when compiling on an x86 machine for an x86 target, makes a huge
amount of sense in any scenario.

Even if there is only one developer: if your one and only build
machine dies (or needs to be replaced) and you are using OE/Yocto for
your entire build, you can easily switch to a new machine, start a new
build, and be right back where you were on the last machine. In other
words you don't have to "setup" your build machine in any way to make
sure it looks exactly like the old machine. If you are using OE/Yocto
for your entire build, it takes care of "setting up your build
environment" so your build performs the same on multiple machines.

But if you do have multiple developers, if you use OE/Yocto for the
entire build, all the developers can create the same image without
having to worry about native contamination. For example, if you didn't
want to use OE/Yocto for the entire build (and wanted everyone to use
their host environment as part of their build) then they all have to
be running the exact same version of whatever Linux distribution
you're using (so they all have the same compiler, linker, headers,
etc) and they all have to have the exact same packages installed (for
configuration). This becomes rather hard to enforce.

As another example, perhaps your x86 build and target machines are
currently 32-bit, but maybe you replace your build machine with a
64-bit machine in the future; in this case you'll need your build to
be completely self-contained (and not contaminated by the host's
environment). You will no longer be able to use your host's tools for
your build, you'll need to have something setup so that OE/Yocto
performs the entire build.

As another example. Maybe you release your product today but
development continues for the next 2 years. In this case you'll need
to make sure you "set aside" your build environment (maybe you're
lucky and this is easier to do because it's all been setup in a VM).
But if you're not using a VM and you're using a physical machine for
your build, you'll need to set aside your build machine and never
update it since you'd risk building something in the future which
links to a (for example) newer version of the C library and trying to
deploy that on your device which uses an older library version. If
you're using OE/Yocto now for your entire build then all you need to
do is continue using the current release in the future and you'll
still be able to update your build machine (new features, security
fixes, etc).

When you do move to your ARM platform you will need to compile
everything from the ground up to create your image. What OE/Yocto does
is to allow you to create your distribution. Ideally switching from
your x86 target to your ARM one would involve nothing more than
changing your MACHINE definition in your local.conf and you'll end up
with the exact same image in either case, the only difference being
one runs on x86 and the other runs on ARM. But if your x86 build isn't
using OE/Yocto completely then you'll never be quite sure what's in
that one.

Hope this helps,
    Trevor

