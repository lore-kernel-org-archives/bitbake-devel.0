Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
	[209.85.210.182])
	by mail.openembedded.org (Postfix) with ESMTP id 4DCEB7BED6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 20:58:45 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d25so3761354pfn.8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=qJOTEfONbdKVW+ogPspkjEqfuOPM5wsFM6UAwuawlq8=;
	b=IEUJybnXLx2spps2GbX8R6gL8v1+cqcl6iiXZh9n5J9MQgafm2cSDLtTyMDbBIVta3
	b0QKgc3gydFAouiWXbp6AMa+xjnXz+WqG+bqXNZc7/rBUdci0+FwYSqDVNJBbTFFfeHs
	2PkgOFVodOSoj+kAhgknw9YdISFkU9z0Y3zWFIK9AiCGxUvQHtgBc5beP0ixCTNatdph
	tKLNYxqM/Upy689E/nT7oKKrtsQcnrJfgkAkui+IDqstyI/POWwsxxrshLihLvQELTeM
	rovL9ts6iVmdW3GaQRjcRpnQsIIXN6/XOavbba9JfB9/SA0lkTQbUcRf31SsAhh53AXc
	rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language;
	bh=qJOTEfONbdKVW+ogPspkjEqfuOPM5wsFM6UAwuawlq8=;
	b=j2PWJy0VAyV1ugjy4XJXYa2ICNXl9nphqU7IpFphYrm5HRoeGyOHwjrepqSFIGfd+y
	/5x3GHZYmGKJdy6RNFbn6Y1iofA4GL9q7FoW4idLhzsjc5xxNX9u+6Lz1gMkLMFkY8mr
	gCam2UlEo4O5rWtcsM9Atj8Cq+wWy92sJEJ7yWngX1YZzNz5olIoY0DpHQ2W8u+/JZms
	c0MDItsIu4F8zNRpVk42I4fvtSmPcqfVtXlItJpo89AN8afxQsIVhBOgBu/9wZy93Qro
	GFZkZ6S+pOYM6oqF0gLVgE0uoCPQrBy/cjrJJYjOHvQsHwxaL4cQ7v0LCc14rZMP81sT
	t2mQ==
X-Gm-Message-State: APjAAAXaFxUND9KrpgUczUvlmonZv6hw9nVYXgYWNaNuMc4uTN106QBI
	jMSp0RleIpwhWhCJkCOs7ECkKguo
X-Google-Smtp-Source: APXvYqx0XSKlkG417+8Ox/3Rq/MGveZX/RzQbarkF3jLqR51eQEBfhc9b0MLl+/rE4o1G5umWJSwEQ==
X-Received: by 2002:a17:902:121:: with SMTP id
	30mr16996749plb.315.1553374726075; 
	Sat, 23 Mar 2019 13:58:46 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:9ce3:bbbb:72cd:d5f9?
	([2601:202:4180:c33:9ce3:bbbb:72cd:d5f9])
	by smtp.gmail.com with ESMTPSA id 6sm13722961pfi.53.2019.03.23.13.58.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Mar 2019 13:58:45 -0700 (PDT)
To: Martin Jansa <martin.jansa@gmail.com>
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
	<5e7ac387-3a30-6fd3-b593-a2636e0cb93e@mvista.com>
	<CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	mQINBFnlUP4BEADpKf+FQdLykenQXKk8i6xJNxDow+ypFeVAy8iFJp7Dsev+BtwUFo8VG7hx
	Jmd71vHMw+coBetWC3lk+IKjX815Ox0puYXQVRRtI+yMCgd6ib3oGxoQ8tCMwhf9c9/aKjaz
	mP97lWgGHbiEVsDpjzmMZGlJ6pDVZzxykkJExKaosE46AcA8KvfhRQg5zRyYBtinzs8Zu8AP
	aquZVHNXxPwjKPaSEEYqQjFeiNgFTavV+AhM2dmPmGUWCX9RZisrqA4slGwEB0srMdFf12Zg
	mD35Y9jZ80qpu5LPtJCFcsaAlebqR+dg36pIpiRR+olhN1wmC6LYP1vw6uMEYBjkTa2Rnb6+
	C4FDzCJD4UCrUvLMNeTW810DY0bjMMj3SfmSGSfQUssaaaTXCVlLGuGxyCr/kza1rHaXMKum
	Ek4EFj1fyn7AfkSLEHfJfY4sO1tpgigvs4eD/4ZSQEXSu/TjVvyKx4EvUbhlGMRyH2CPwD/H
	7DFF8tcVtJvCwUUW+zKtjxjSSLrhniNMXAOQJZ6CdaqCe4OyJQT5aRdr+FWbBRjpaRCCf5nf
	dTc88NMU9PrBT3vu0QJ5WNPO6MJpnb+d8iMNLZAz8tv8JMm2l+sMcNKSJ6lhX8peoBsfMVqc
	FgiykEO0fUt7DCbUYR5tLjM/3E5tHvTjMooVJyOxoufVLYtTtQARAQABtCFha3VzdGVyODA4
	IDxha3VzdGVyODA4QGdtYWlsLmNvbT6JAj0EEwEIACcFAlnlUP4CGyMFCQlmAYAFCwkIBwIG
	FQgJCgsCBBYCAwECHgECF4AACgkQ7ou0mfRW5/kuhRAAlR2FTq5572jrX5nnPR7AqI2bvSVb
	vqGLlvv739WhghvagbC+tu05QguopAhWW1/DcHK2+QtfIoC9UZrSW4RaO0CCo5sPjqK7l1KT
	ngWX/rGjF6xTF2QN0U/btcpMyVN2CNtVLwsDF9e+GHKoUcnFkP+JP8vHGokN9k6E/c97hLaL
	IJPeKl8LZXc2Efk+MaW1NXkfDJdcp/p+voajbihSQO6OZ/o+x9d2I3ZybKfTZ71+ek5Hxzjz
	g6KkMOI7KJjlmBlrQFAtVbS+CFAKrwkYznE6ggkcmGv3N7DeUBTUR78hf+EZEAM+ajeLMtrG
	rXE00pIb+gLGYPZxba5pCdQ+qWUW38qi9UnIRPm6fq7Ypx1r6XwJvbgCOkhbxo3D4YUdyC0b
	FE9lgrg8htbc9in4j2+hVI6ALswNjLprzXdzdKrd+T3Egx36o3Z/qrYsW2o5/A5sVvvASVKi
	wRPuEKhEhfmiHUPLvuKqhMoymHaz3fg5D2Q8G0gSDkLgeEpAjiWqf4+AGLx+MSDai7DSOsmI
	t61kWxs7cFTB32UrB/TDoVNn3Fm88ZFQpA/bngikE9jgEm045mSY86fNlbFj2mcCd0Ha1i1n
	aYc97RpgfjNMWyHDVHOGrNg/hJjkGa5RsAXkfyBwltHRw0Hj4urUQ3rr8um8PLe43SezPwXA
	oRoyDxC5Ag0EWeVQ/gEQALNHwj5VSPdnvXy1RXUuH+rclMx4x8zaqDyY0YqHfA7b/d8Y0VAt
	Y6YpzDeFTwD8A0Wfb7kZ2mlDIE6ODCB71uT/E3C6b+FiiN+lgzslznjUW+9l8ddDhRrC8HMG
	37vrXF5h++PTXUKEKUlkDib1w093tu3mlJXUvIAzl8CEHkptF6Br0L9XxFwuWoNUfjT9IorQ
	0SVIhvq5PhVAITXUD5fD7/N8B4TYegmHFRo1UaaKSnSHwlJJkzKpeWOH8QTYrP0RHxX86Obv
	IZuwbAo3F3oojcvLJt9NxWnbEmEALkleklLZnukgu7q5Wp1VDwhUbMFTLb6qmnBa/Xi30uOk
	0l1TMHDbeQswvQDOZBAMukSRqyBetKxQ3iTfZ/3z1ubQRcVDbVlMDScSHQq0LK3F9yMOMM/6
	0QPqJjl13xn/+Bn7WJiAIXXwzAV7uo6i0khFfjDtCDQ40aeffqOLxp1yMLkc3EKJGcQ5F6O2
	ycEf4QXCYUbMXjxB0EJB8y7z+xOi5Mmd/pPlVmZ2gQK84NAL90p7n7jRlyf3gOUY+JOl4c5e
	UFiIhOzmuqNrvPOiZ02GXh6SGUU5y7IgSoIKvXSFgHAn2OG/tcspBmkyv6IuNVpmbmEgYn4I
	Rnt40UXVQkxTh0dENFhk2cjunMYozV/OqYCgmZLFSeJd8kAo4yn+yOtNABEBAAGJAiUEGAEI
	AA8FAlnlUP4CGwwFCQlmAYAACgkQ7ou0mfRW5/nNcg//R63cbOS6zLtvdnPub3Ssp1Ft8Wmv
	mni+kccuNApuDV7d63QckYxjAfUv2zYMLpbh87gVbLyCq9ASn552EbfRhTvHdk44CgbHBVcI
	ZBEdZWgRR5ViJakQSYHpP2e5AGNFnx9gSIuRTaa5rvZM+4xeoZ2vJiq93TtaYPr7UFNfK+c4
	vv4C66lkt9l95/I10eSc3RqbOKZW47emlg4X3ygEoB9k2lPrpspyf6sUuSEi0WrlSxoLAr6p
	JG8rTUErYNeXe6JCdL31odDx1Dh5sdKIj2RicUYZNilxu9f1M7jZwf2ra1FGAlKj2ybqmgpZ
	EFteaiCinEYsvDyZyOiWHjAFI+RZIPQQL3AnVp4l7wYD3r9hnqYPww0slyMDcb9262RoFkHq
	dDwxPYarrNjWUpOzxB6bFxOgNRdCTgvQl8Ftk8a/yXB6vHeUSm1vPFCBxQPZytyfOLhEWm0J
	/mkVL0Z6iRK3p1LKnpLYCS4/esL2u7RrhPyCs2SsL58YcQF/g+PpeT9geZ+oyZ/4IQ+TWJoU
	PNHndk8VBTpzrmOaJxrebNL/W6C8JCmbLM11TAUMmHYi9JDytN8Au78hWpDbIdKwg1LeSxpw
	ZZD/OqOc0DBvHOpQhzkSrtR1lVlDV/+9E8J1T4uDhrGmZwYV+4xQetypHax8aAHisYbjXdVa
	8CS2NxU=
Message-ID: <1c5e4301-95c9-c004-681a-1b6c3ccb936f@gmail.com>
Date: Sat, 23 Mar 2019 13:58:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Armin Kuster <akuster808@gmail.com>
Subject: Re: [PATCH 00/12] Sumo pull request
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
X-List-Received-Date: Sat, 23 Mar 2019 20:58:45 -0000
Content-Type: multipart/alternative;
	boundary="------------61431A091CCB84F36B081735"
Content-Language: en-US

--------------61431A091CCB84F36B081735
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 3/23/19 1:37 PM, Martin Jansa wrote:
> >=C2=A0 Why would I reference patchwork? How does that work if this is =
the
> only message sent out?
>
> I don't want you to reference patchwork.
>
> I'm only asking why you haven't included this change
> (http://lists.openembedded.org/pipermail/openembedded-core/2019-March/2=
79999.html
> if you don't like the link to patchwork) in the pull request, or in
> sumo-next branch when patchwork status says "sumo-next".

its in the next series. I had build failures that put everything on old
for two weeks while I troubleshot the failures=C2=A0 Adding new changes w=
ould
have just added to the problem.=C2=A0 if you look at stable/sumo-nmut, it=
 has
your changes and a few more.

- armin
>
> On Sat, Mar 23, 2019 at 3:40 PM akuster <akuster@mvista.com
> <mailto:akuster@mvista.com>> wrote:
>
>
>
>     On 3/23/19 1:32 AM, Martin Jansa wrote:
>>     Hi,
>>
>>     is there a reason for not including
>>     https://patchwork.openembedded.org/patch/159465/
>>     ?
>>
>     Why would I reference patchwork? How does that work if this is the
>     only message sent out?
>
>>     It says sumo-next on patchwork, but I don't know which sumo-next
>>     it is, I don't see it in:
>>     http://git.openembedded.org/openembedded-core/log/?h=3Dsumo-next
>     I don't have write access to core.
>
>     the changes are in contrib:
>     https://git.openembedded.org/openembedded-core-contrib/log/?h=3Dsta=
ble/sumo-next
>     - armin
>>
>>     On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster
>>     <akuster808@gmail.com <mailto:akuster808@gmail.com>> wrote:
>>
>>         Please consider this for the next sumo update
>>
>>         The following changes since commit
>>         6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>>
>>         =C2=A0 package_rpm/archiver: Apply bandaid to src.rpm creation=

>>         (2019-02-25 22:13:08 +0000)
>>
>>         are available in the git repository at:
>>
>>         =C2=A0 git://git.openembedded.org/openembedded-core-contrib
>>         <http://git.openembedded.org/openembedded-core-contrib>
>>         stable/sumo-next
>>         =C2=A0
>>         http://cgit.openembedded.org/openembedded-core-contrib/log/?h=3D=
stable/sumo-next
>>
>>         Chen Qi (2):
>>         =C2=A0 systemd: fix CVE-2018-15686
>>         =C2=A0 systemd: fix CVE-2018-15688
>>
>>         George McCollister (5):
>>         =C2=A0 systemd: fix CVE-2018-15687
>>         =C2=A0 systemd: Security fix CVE-2018-16864
>>         =C2=A0 systemd: Security fix CVE-2018-16865
>>         =C2=A0 systemd: fix CVE-2018-6954
>>         =C2=A0 systemd: fix CVE-2019-6454
>>
>>         Marcus Cooper (1):
>>         =C2=A0 systemd: Security fix CVE-2018-16866
>>
>>         Mingli Yu (1):
>>         =C2=A0 logrotate.py: restore /etc/logrotate.d/wtmp
>>
>>         ROGEZ Matthieu (1):
>>         =C2=A0 systemd: Fix typo in root home variable.
>>
>>         Richard Purdie (1):
>>         =C2=A0 oeqa/runtime/dnf: Fix test error when static libs are e=
nabled
>>
>>         Stefan Agner (1):
>>         =C2=A0 run-postinsts: for dpkg/opkg, do not rely on /etc/*-pos=
tinsts
>>
>>         =C2=A0meta/lib/oeqa/runtime/cases/dnf.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-
>>         =C2=A0meta/lib/oeqa/runtime/cases/logrotate.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-
>>         =C2=A0...sive-let-s-rework-the-recursive-logic-to-.patch |=C2=A0=
 252 +++
>>         =C2=A0...eserializing-state-always-use-read_line-L.patch |=C2=A0=
 250 +++
>>         =C2=A0...sure-we-have-enough-space-for-the-DHCP6-o.patch |=C2=A0=
 =C2=A039 +
>>         =C2=A0...n-t-resolve-pathnames-when-traversing-rec.patch |=C2=A0=
 643
>>         +++++++
>>         =C2=A0.../systemd/systemd/0002-Make-tmpfiles-safe.patch=C2=A0 =
| 1828
>>         ++++++++++++++++++++
>>         =C2=A0...-not-store-the-iovec-entry-for-process-co.patch |=C2=A0=
 193 +++
>>         =C2=A0...ld-set-a-limit-on-the-number-of-fields-1k.patch |=C2=A0=
 =C2=A060 +
>>         =C2=A0...ote-set-a-limit-on-the-number-of-fields-i.patch |=C2=A0=
 =C2=A079 +
>>         =C2=A0...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |=C2=A0=
 =C2=A049 +
>>         =C2=A0.../systemd/systemd/CVE-2019-6454.patch=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 210 +++
>>         =C2=A0...e-receive-an-invalid-dbus-message-ignore-.patch |=C2=A0=
 =C2=A061 +
>>         =C2=A0meta/recipes-core/systemd/systemd_237.bb
>>         <http://systemd_237.bb>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A013 +-
>>         =C2=A0.../run-postinsts/run-postinsts/run-postinsts=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A021 +-
>>         =C2=A0.../run-postinsts/run-postinsts.service=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -
>>         =C2=A016 files changed, 3694 insertions(+), 13 deletions(-)
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-r=
ework-the-recursive-logic-to-.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0001-core-when-deserializing=
-state-always-use-read_line-L.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have=
-enough-space-for-the-DHCP6-o.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-=
pathnames-when-traversing-rec.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patc=
h
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0024-journald-do-not-store-t=
he-iovec-entry-for-process-co.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on=
-the-number-of-fields-1k.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-li=
mit-on-the-number-of-fields-i.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-boun=
ds-read-CVE-2018-16866.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>>         =C2=A0create mode 100644
>>         meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-inva=
lid-dbus-message-ignore-.patch
>>
>>         --=20
>>         2.7.4
>>
>>         --=20
>>         _______________________________________________
>>         bitbake-devel mailing list
>>         bitbake-devel@lists.openembedded.org
>>         <mailto:bitbake-devel@lists.openembedded.org>
>>         http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>>
>


--------------61431A091CCB84F36B081735
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/23/19 1:37 PM, Martin Jansa wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">&gt; 
          Why would I reference patchwork? How does that work if this is
          the only message sent out?
          <div><br>
          </div>
          <div>I don't want you to reference patchwork.</div>
          <div><br>
          </div>
          <div>I'm only asking why you haven't included this change (<a
href="http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html"
              moz-do-not-send="true">http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html</a>
            if you don't like the link to patchwork) in the pull
            request, or in sumo-next branch when patchwork status says
            "sumo-next".</div>
        </div>
      </div>
    </blockquote>
    <br>
    its in the next series. I had build failures that put everything on
    old for two weeks while I troubleshot the failures  Adding new
    changes would have just added to the problem.  if you look at
    stable/sumo-nmut, it has your changes and a few more.<br>
    <br>
    - armin<br>
    <blockquote type="cite"
cite="mid:CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com"><br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019 at 3:40
          PM akuster &lt;<a href="mailto:akuster@mvista.com"
            moz-do-not-send="true">akuster@mvista.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor="#FFFFFF"> <br>
            <br>
            <div class="gmail-m_7305473577171404396moz-cite-prefix">On
              3/23/19 1:32 AM, Martin Jansa wrote:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">Hi,
                <div><br>
                </div>
                <div>is there a reason for not including</div>
                <div><a
                    href="https://patchwork.openembedded.org/patch/159465/"
                    target="_blank" moz-do-not-send="true">https://patchwork.openembedded.org/patch/159465/</a><br>
                </div>
                <div>?</div>
                <div><br>
                </div>
              </div>
            </blockquote>
            Why would I reference patchwork? How does that work if this
            is the only message sent out?<br>
            <br>
            <blockquote type="cite">
              <div dir="ltr">
                <div>It says sumo-next on patchwork, but I don't know
                  which sumo-next it is, I don't see it in:</div>
                <div><a
                    href="http://git.openembedded.org/openembedded-core/log/?h=sumo-next"
                    target="_blank" moz-do-not-send="true">http://git.openembedded.org/openembedded-core/log/?h=sumo-next</a><br>
                </div>
              </div>
            </blockquote>
            I don't have write access to core.<br>
            <br>
            the changes are in contrib:
            <a class="gmail-m_7305473577171404396moz-txt-link-freetext"
href="https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
              target="_blank" moz-do-not-send="true">https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
            - armin<br>
            <blockquote type="cite"><br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019
                  at 3:12 AM Armin Kuster &lt;<a
                    href="mailto:akuster808@gmail.com" target="_blank"
                    moz-do-not-send="true">akuster808@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">Please consider
                  this for the next sumo update<br>
                  <br>
                  The following changes since commit
                  6d56e912fbbaa22830b4da5ab230586a3d15b23e:<br>
                  <br>
                    package_rpm/archiver: Apply bandaid to src.rpm
                  creation (2019-02-25 22:13:08 +0000)<br>
                  <br>
                  are available in the git repository at:<br>
                  <br>
                    git://<a
                    href="http://git.openembedded.org/openembedded-core-contrib"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">git.openembedded.org/openembedded-core-contrib</a>
                  stable/sumo-next<br>
                    <a
href="http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
                  <br>
                  Chen Qi (2):<br>
                    systemd: fix CVE-2018-15686<br>
                    systemd: fix CVE-2018-15688<br>
                  <br>
                  George McCollister (5):<br>
                    systemd: fix CVE-2018-15687<br>
                    systemd: Security fix CVE-2018-16864<br>
                    systemd: Security fix CVE-2018-16865<br>
                    systemd: fix CVE-2018-6954<br>
                    systemd: fix CVE-2019-6454<br>
                  <br>
                  Marcus Cooper (1):<br>
                    systemd: Security fix CVE-2018-16866<br>
                  <br>
                  Mingli Yu (1):<br>
                    logrotate.py: restore /etc/logrotate.d/wtmp<br>
                  <br>
                  ROGEZ Matthieu (1):<br>
                    systemd: Fix typo in root home variable.<br>
                  <br>
                  Richard Purdie (1):<br>
                    oeqa/runtime/dnf: Fix test error when static libs
                  are enabled<br>
                  <br>
                  Stefan Agner (1):<br>
                    run-postinsts: for dpkg/opkg, do not rely on
                  /etc/*-postinsts<br>
                  <br>
                   meta/lib/oeqa/runtime/cases/dnf.py                 | 
                    2 +-<br>
                   meta/lib/oeqa/runtime/cases/logrotate.py           | 
                    6 +-<br>
                   ...sive-let-s-rework-the-recursive-logic-to-.patch | 
                  252 +++<br>
                   ...eserializing-state-always-use-read_line-L.patch | 
                  250 +++<br>
                   ...sure-we-have-enough-space-for-the-DHCP6-o.patch | 
                   39 +<br>
                   ...n-t-resolve-pathnames-when-traversing-rec.patch | 
                  643 +++++++<br>
                   .../systemd/systemd/0002-Make-tmpfiles-safe.patch  |
                  1828 ++++++++++++++++++++<br>
                   ...-not-store-the-iovec-entry-for-process-co.patch | 
                  193 +++<br>
                   ...ld-set-a-limit-on-the-number-of-fields-1k.patch | 
                   60 +<br>
                   ...ote-set-a-limit-on-the-number-of-fields-i.patch | 
                   79 +<br>
                   ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch | 
                   49 +<br>
                   .../systemd/systemd/CVE-2019-6454.patch            | 
                  210 +++<br>
                   ...e-receive-an-invalid-dbus-message-ignore-.patch | 
                   61 +<br>
                   meta/recipes-core/systemd/<a
                    href="http://systemd_237.bb" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">systemd_237.bb</a> 
                           |   13 +-<br>
                   .../run-postinsts/run-postinsts/run-postinsts      | 
                   21 +-<br>
                   .../run-postinsts/run-postinsts.service            | 
                    1 -<br>
                   16 files changed, 3694 insertions(+), 13 deletions(-)<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch<br>
                   create mode 100644
                  meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch<br>
                   create mode 100644
                  meta/recipes-core/systemd/systemd/CVE-2019-6454.patch<br>
                   create mode 100644
meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch<br>
                  <br>
                  -- <br>
                  2.7.4<br>
                  <br>
                  -- <br>
                  _______________________________________________<br>
                  bitbake-devel mailing list<br>
                  <a href="mailto:bitbake-devel@lists.openembedded.org"
                    target="_blank" moz-do-not-send="true">bitbake-devel@lists.openembedded.org</a><br>
                  <a
                    href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
                </blockquote>
              </div>
              <br>
              <fieldset
                class="gmail-m_7305473577171404396mimeAttachmentHeader"></fieldset>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------61431A091CCB84F36B081735--
