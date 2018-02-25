Return-Path: <pbarker@toganlabs.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 85E946FF0E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 22:17:50 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id z81so13980845wmb.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Feb 2018 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=toganlabs-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Dmxosibc8cSEUE9/+4lg1yiH0PsJXsfj3TXBEWFicS4=;
	b=U5/PhJYxE9kKOUJlKdxSLKC/1CTAAHu7zNl7sCT72NQGQFEzYMs5wlI0t+ecncZaum
	0tzSriSSi0pitua6q2k514BC5C46xx6WqyxPDFGxzMmJ26opss5iSXy7OUmVNkv7Gidc
	ZA6OcfBSwfzB5uOtwRLW5GOs0YpM421H5GpjTmTuQLRIfX9BCNoM9rrAvxmOqgDLzHyT
	bboD3iVsCNgw+iuDDfU9TvZFr/f0rgI8poEDRTNoTHPOvtJf7bv1jbijTtI5yb0Nu5rn
	1hZh9Wx2h/0/CmMfTfFhuYdArHQbIKVZr+ag3iqN5jTMIAUFNt0ykmMlCOAEtyHb6d0b
	csRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Dmxosibc8cSEUE9/+4lg1yiH0PsJXsfj3TXBEWFicS4=;
	b=A2fmzreEqsofWkuL5zcs3dgJ2UHV82Dj5w45l+t0XdKy43aGsIy5sKa/VowM6yV8bF
	dSQR/DnfE2jKa6fzwaFcnGsJl5llEN9LtJiHanzYmN26jMxZMN6ZPfATIy0CYuP8d/+K
	J8Znui3palqLfbF0K7v75FAQqewUlTCEqfGW154jqQLPn1K1nv7giwpn2AfC3cP9ol3D
	OQToekyvd7cbqiA2RiAdVNZsf0EzxMf1FJebYPCxJKala/ozGsxZNO3HgsErSdMroxr0
	CiMUal5XcBlYgvo474k+Q7gmOe+auqioEekETkZzKR6oeS0R04aBCx+wX1jieD4FU9pk
	WBsA==
X-Gm-Message-State: APf1xPAALZzuZ7o3GQ29JkFKlSd8qroCkwr8CpiUBhVEtuRt3xX5kCt6
	raExt2KJuBBDsRrtAdjDEDS8ekqc+9wylBINekREPQ==
X-Google-Smtp-Source: AG47ELsnG9PmyyHTViKSsfl7e9et4vn694Q9Z2IZ3TkmPcPnRSiodlI8H5aFm5J/Vo/9Yr5hatyNmy0JkrYkBuZLTEk=
X-Received: by 10.28.37.5 with SMTP id l5mr6394747wml.127.1519597071173; Sun,
	25 Feb 2018 14:17:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.48 with HTTP; Sun, 25 Feb 2018 14:17:50 -0800 (PST)
In-Reply-To: <1519596717.24236.384.camel@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
	<1519596717.24236.384.camel@linuxfoundation.org>
From: Paul Barker <pbarker@toganlabs.com>
Date: Sun, 25 Feb 2018 22:17:50 +0000
Message-ID: <CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
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
X-List-Received-Date: Sun, 25 Feb 2018 22:17:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 10:11 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Sun, 2018-02-25 at 19:25 +0000, Paul Barker wrote:
>> I've been having build failures recently which I've tracked down to
>> this commit in bitbake via git bisect.
>>
>> I have an image recipe, oryx-image, and a publish recipe,
>> oryx-publish. In oryx-publish I have a do_publish task that copies
>> files out of "tmp/deploy/images/*" to their final places and so it
>> needs to run after the tasks in oryx-image that create the relevant
>> files. So I've explicitly added oryx-image:do_build to
>> do_publish[depends].
>
> Is do_publish added before do_build?
> Does oryx-publish inherit any of the image/meta classes?
>
> I suspect I need to better understand the problem as you've described
> what you think the problem is but not what problem you're seeing...
>

The recipe is here:
https://gitlab.com/oryx/meta-oryx/blob/master/recipes-core/publish/oryx-pub=
lish.bb.
ORYX_SYSTEM_PROFILE_PUBLISH_DEPENDS expands to "oryx-image:do_build".

The problem I'm seeing is that the files don't exist in
"tmp/deploy/images/*" when do_publish runs. Investigation via "bitbake
-g" shows that the dependency on "oryx-image:do_build" has been
dropped from do_publish:


--=20
Paul Barker
Tog=C3=A1n Labs Ltd

